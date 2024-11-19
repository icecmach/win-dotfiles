# Starship
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Aliases
Remove-Alias -Name cd
Remove-Alias -Name cat
Set-Alias cat bat
Set-Alias cd z
function config {git --git-dir=$HOME/.cfg --work-tree=$HOME $args}
Set-Alias curl Invoke-WebRequest
function env {gci env:* | sort-object name}
Set-Alias grep findstr
Remove-Alias -Name history
function history {bat (Get-PSReadlineOption).HistorySavePath}
#Set-Alias ll Get-ChildItem
function la {eza -l -a --time-style 'long-iso' --icons always $args}
function ll {eza -l --time-style 'long-iso' --icons always $args}
Remove-Alias -Name ls
function ls {eza --icons always $args}
function lr {eza --long --tree --icons always $args}
function sftp {push-sftp $args}
function top {While(1) {ps | sort -des cpu | select -f 30 | ft -a; sleep 10; cls}}
Set-Alias unzip Expand-Archive
Set-Alias vi nvim
function view {nvim -R $args}
Set-Alias wget Invoke-WebRequest

# Environment variables
$env:DISPLAY="127.0.0.1:0"

# Functions
function vpn {wsl.exe -d wsl-vpnkit --cd /app wsl-vpnkit}

function Rest-ApiCall { param ($url)
    $proxyUri = [Uri]$null
    $proxy = [System.Net.WebRequest]::GetSystemWebProxy()
    if ($proxy) {
        $proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials
        $proxyUri = $proxy.GetProxy($url)
    }

    if ($proxyUri -ne $null -and $proxyUri -ne $url) {
        return Invoke-RestMethod -Uri $url -ContentType $contentType -Headers $headers -UseDefaultCredentials -Proxy $proxyUri -ProxyUseDefaultCredentials -AllowUnencryptedAuthentication -ConnectionTimeoutSeconds 3
    } else {
        return Invoke-RestMethod -Uri $url -ContentType $contentType -Headers $headers -UseDefaultCredentials -AllowUnencryptedAuthentication -ConnectionTimeoutSeconds 3
    }
}

# Variables
$user=(gci -Path Env:\USERNAME).Value
$date=(Get-Date -UFormat "%A %B %d %Y %I:%M %p")
$weather=Rest-ApiCall -url http://wttr.in/London?format="%l:+%c+%t+%f+%m\n"

# Greeting
Write-Host `n"Welcome" $user -ForeGroundColor Magenta
Write-Host " -> " $date
Write-Host " -> " $weather

# Winfetch
. $env:USERPROFILE\git-workspace\winfetch\winfetch.ps1

# Custom ASCII banner (or set one above in the Winfetch cfg file)
#Write-Host "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢉⣴⣶⣤⠀⣿⣿ T"
#Write-Host "⡿⢛⣉⣉⣉⣉⡛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⣡⣴⠏⠁⠀⡚⠀⢸⣿ h"
#Write-Host "⠁⣿⠉⢀⡉⠉⢿⣷⣄⠈⠉⠁⣠⣀⣤⡀⣤⣤⣀⣴⠂⢺⠧⠀⠀⠀⠀⠀⣾⣿ e"
#Write-Host "⠀⢷⣀⠀⠀⠀⠈⠙⣷⠀⠀⣿⣿⣿⣿⣿⢿⣿⡟⠃⠠⢄⣀⢀⡴⠀⣠⣾⣿⣿ r"
#Write-Host "⣧⠈⠣⣦⠀⠀⠀⠀⠉⠸⠛⠃⠉⠋⠹⠀⠃⠁⠀⠀⠀⠺⣟⣷⣦⣄⠙⠿⣿⣿ e"
#Write-Host "⣿⣇⢈⢿⣷⣾⣦⡤⢴⣿⣶⡀⢠⣔⣤⣤⡀⠀⠲⣾⣿⣶⣿⣿⣿⣿⣷⣄⠈⢻ i   1"
#Write-Host "⣿⠏⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⡻⣿⠀⠘⠿⡟⠡⠄⢉⡼⢿⣿⣿⣦⠈ s l 2"
#Write-Host "⡏⣨⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⡁⠐⠃⠈⠀⠐⠀⠀⣀⢠⡤⣾⠃⠀⠉⠛⠛⢠ n i 7"
#Write-Host "⠁⣿⣿⣿⣿⣿⣿⣿⠏⠁⠘⠿⣶⣤⠴⠶⢟⣰⣶⣾⣿⣷⣤⣀⠀⠀⠀⠀⣠⣾ o k 0."
#Write-Host "⡀⢿⣿⣿⣿⡿⠋⠁⠀⠀⠀⠀⠉⠁⢠⣴⣿⣿⣿⣿⢿⣟⠿⣿⡆⠀⢀⣾⣿⣿ p e 0."
#Write-Host "⣷⡄⠛⠟⠃⠀⠀⠀⠀⠀⠀⢠⣤⣶⣿⣿⣿⣿⣿⡃⠈⠁⠀⠘⣡⣾⣿⣿⣿⣿ l   1"
#Write-Host "⣿⣿⣶⣿⣤⣤⣄⣄⣄⣄⣈⣛⣉⣉⡙⠋⠋⠋⠁⠀⢀⣠⣾⣿⣿⣿⣿⣿⣿⣿ a"
#Write-Host "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ c"
#Write-Host "⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ e"
