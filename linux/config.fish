# Cute shell shortcuts
alias ls='ls --sort=extension --color=auto'
alias ll='ls -lh'
alias la='ls -A'
alias psg='ps -A | grep'
alias l='ls -CF'

# Git Commands
# Add and Commit are used as functions
alias ga="git add"
alias gca="git commit --amend"
alias gc="git commit -m"
alias gp="git push"


# Network Related
alias localip="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ and print $1'"
alias whois="whois -h whois-servers.net"


# functions
function giveme --description "sudo apt-get install $1"
    for pkg in $argv
        echo "apt-get installing: " (set_color --bold blue) $pkg (set_color normal)
        sudo apt-get install -y $pkg
    end
end


function up --description "up dir $1 times"
    for i in (seq 1 $argv)
        cd ..
    end
end


# source from https://github.com/justinmayer/tackle/blob/master/plugins/extract/extract.fish
function extract -d "Expand or extract bundled & compressed files"
    for file in $argv
        if test -f $file
            echo -s "Extracting: " (set_color --bold blue) $file (set_color normal)
            switch $file
                case *.tar
                    tar -xf $file
                case *.tar.xz *.txz
                    # Use pixz for parallel extraction, if available
                    set os (uname)
                    if [ $os = "Darwin" ]
                        command -s pixz gtar >/dev/null
                        and gtar -Ipixz -xf $file
                        or tar -Jxf $file
                    else
                        command -s pixz >/dev/null
                        and tar -Ipixz -xf $file
                        or tar -Jxf $file
                    end
                case *.tar.bz2 *.tbz *.tbz2
                    tar -jxf $file
                case *.tar.gz *.tgz
                    tar -zxf $file
                case *.xz
                    command -s pixz >/dev/null
                    and pixz -d $file
                    or unxz $file
                case *.bz2
                    bunzip2 $file
                case *.gz
                    gunzip $file
                case *.rar
                    unrar x $file
                case *.zip
                    unzip -uo $file -d (basename $file .zip)
                case *.pax
                    pax -r < $file
                case '*'
                    echo "Extension not recognized, cannot extract $file"
            end
        else
            echo "$file is not a valid file"
        end
    end
end

function compress -d "Compress a file or directory via xz, with optional destination"
    # Target is a file
    if test -f $argv[1]
        set file $argv[1]
        # If no destination is provided, compress in-place
        if test (count $argv) = 1
            set destination $file.xz
        else
            set destination $argv[2]
        end
        echo -s "Compressing file: " (set_color --bold blue) $file (set_color normal)
        command -s pixz >/dev/null
        and pixz $file $destination
        or xz $file $destination
    end

    # Target is a directory
    if test -d $argv[1]
        set directory $argv[1]
        # If no destination is provided, compress in-place
        if test (count $argv) = 1
            set destination $directory.txz
        else
            set destination $argv[2]
        end
        echo -s "Compressing directory: " (set_color --bold blue) $directory (set_color normal)
        set os (uname)
        switch $os
            case Darwin
                command -s gtar pixz >/dev/null
                and gtar -Ipixz -cf $destination $directory
                or tar -Jcf $destination $directory
            case '*'
                command -s pixz >/dev/null
                and tar -Ipixz -cf $destination $directory
                or tar -Jcf $destination $directory
        end
    end
end