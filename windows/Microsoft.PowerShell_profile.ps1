<# 
 # My Powershell profile
 # magicwenli @ 2022/11/28
 #>

# Set and Unset proxy for powershell, $HTTP_PROXY will be replaced by all.config
function pxy {
    $env:http_proxy=HTTP_PROXY
    $env:https_proxy=HTTPS_PROXY
    Write-Host http_proxy = $env:http_proxy
    Write-Host https_proxy = $env:https_proxy
}

function unpxy {
    $env:http_proxy=""
    $env:https_proxy=""
    Write-Host Unset proxy!
}

function which($name) {
	Get-Command $name | Select-Object -ExpandProperty Definition
}

function edit {
	& "code" -g @args
}

function find-file($name) {
	get-childitem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | foreach-object {
		write-output($PSItem.FullName)
	}
}

set-alias find find-file
set-alias find-name find-file

function reboot {
	shutdown /r /t 0
}

# Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

$documents = $home + "\Documents"
$desktop = $home + "\Desktop"
$downloads = $home + "\Downloads"

# Set up command prompt and window title. Use UNIX-style convention for identifying 
# whether user is elevated (root) or not. Window title shows current version of PowerShell
# and appends [ADMIN] if appropriate for easy taskbar identification
function prompt 
{ 
    if ($isAdmin) 
    {
        "PS " + (Get-Location) + " (admin)$ " 
    }
    else 
    {
        "PS " + (Get-Location) + " > "
    }
}

# welcome banner
Write-Host ''
Write-Host 'Powershell' $PsVersionTable.PSVersion '-' (Get-date)
Write-Host 'Greetings. Shall we play a game?'
Write-Host ''