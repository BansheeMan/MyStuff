Clear-Host
Write-Host "=== HTTPS Monitor ===" -ForegroundColor Cyan

$uri = Read-Host "Enter URI (for example, https://httpbin.org/basic-auth/testuser/testpass)"
$user = Read-Host "Enter username"
$pass = Read-Host "Enter password"

$LogFile = Read-Host "Enter the path to the log file (key Enter default values)"
if ([string]::IsNullOrWhiteSpace($LogFile)) {
    $LogFile = ".\check_https_log.txt"
}

$IntervalSeconds = Read-Host "Enter the interval between requests in seconds (key Enter for 60)"
if (-not [int]::TryParse($IntervalSeconds, [ref]([int]$tmp))) {
    $IntervalSeconds = 60
} else {
    $IntervalSeconds = [int]$IntervalSeconds
}

$pair = "$($user):$($pass)"
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($pair))
$headers = @{ Authorization = "Basic $base64AuthInfo" }

$timestamp = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
Write-Host "`n--- Checking HTTPS request ---"
Write-Host "PowerShell version: $($PSVersionTable.PSVersion)"
Write-Host "URI: $uri"
Write-Host "------------------------------`n"
Write-Host "$timestamp INFO: Start monitoring. URI=$uri, Interval=$IntervalSeconds sec"

Add-Content -Path $LogFile -Value "$timestamp INFO: Start monitoring. URI=$uri, Interval=$IntervalSeconds sec"

if ($PSVersionTable.PSVersion.Major -lt 6) {
    Write-Host "PowerShell 5.x — disable SSL certificate verification..." -ForegroundColor Yellow
    add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(ServicePoint srvPoint, X509Certificate certificate, WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
    [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
} else {
    Write-Host "PowerShell 6+ — disable SSL certificate verification using the standard method." -ForegroundColor Yellow
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
}

$global:stopRequested = $false

try {
    [Console]::CancelKeyPress += {
        $global:stopRequested = $true
        Write-Host "`nMonitoring stopped by user." -ForegroundColor Yellow
    }
} catch {
    Write-Host "The Ctrl+C handler is unavailable (ISE/VSCode). You can stop it manually." -ForegroundColor DarkYellow
}

while (-not $global:stopRequested) {
    $timestamp = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")

    try {
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        $response = Invoke-WebRequest -Uri $uri -Headers $headers -UseBasicParsing
        $stopwatch.Stop()

        $elapsedSeconds = [math]::Round($stopwatch.Elapsed.TotalSeconds, 2)
        $size = $response.RawContentLength

        $logLine = "$timestamp OK: Status=$($response.StatusCode); Time=${elapsedSeconds}s; Size=${size}b"
        Write-Host $logLine -ForegroundColor Green
        Add-Content -Path $LogFile -Value $logLine
    }
    catch {
        $stopwatch.Stop()
        $elapsedSeconds = [math]::Round($stopwatch.Elapsed.TotalSeconds, 2)
        $errorMsg = $_.Exception.Message
        $logLine = "$timestamp ERROR: $errorMsg (Time=${elapsedSeconds}s)"
        Write-Host $logLine -ForegroundColor Red
        Add-Content -Path $LogFile -Value $logLine
    }

    Start-Sleep -Seconds $IntervalSeconds
}

Write-Host "`n==============================="
Write-Host "Monitoring is complete."
Write-Host "Log: $LogFile"
Write-Host "==============================="
