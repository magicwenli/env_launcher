$config = ".\common\all.config"
$dest_config = $PROFILE.AllUsersAllHosts # All user, current host
$ps_profile = ".\windows\Microsoft.PowerShell_profile.ps1"

# Find out if the current user identity is elevated (has admin rights)
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (!$isAdmin) {
    Write-Host This initial script require *admin privilege*!
    Write-Host Press any key to continue...
    exit
}

Get-Content $config | foreach-object -begin { $result = @{} } -process {
    $pair = [regex]::split($_, '=')
    if (($pair[0].CompareTo("") -ne 0) -and ($pair[0].StartsWith("[") -ne $True)) {
        $result.Add($pair[0], $pair[1]) 
    } 
}
$temp = Get-Content $ps_profile
foreach ($i in $result.GetEnumerator()) {
    write-host $i.name $i.value
    $temp = $temp.replace($i.name, $i.value) 
}

# New-Item -Path $dest_config -Force
Out-File -FilePath $dest_config -InputObject $temp -Force

# Apply Profile
Clear-Host
& $dest_config

Write-Host Initial OK!
