# Serve the book locally as a browsable GitBook-style site.
#
#   .\tools\serve.ps1            # http://localhost:3000
#   .\tools\serve.ps1 -Port 8080
#   .\tools\serve.ps1 -NoOpen
#
# Ctrl+C to stop.
#
# Renders the Markdown live in the browser via docsify (index.html), so there
# is no build step: edit a .md file, refresh the page, see the change. Images
# are served over HTTP from the same origin, so they all work — unlike
# tools/preview.ps1, whose output only displays on this machine.

param(
    [int]$Port = 3000,
    [switch]$NoOpen
)

$ErrorActionPreference = "Stop"
$book = Split-Path -Parent $PSScriptRoot

if (-not (Test-Path (Join-Path $book "index.html"))) {
    Write-Error "index.html not found in $book - the docsify config is missing."
}

# Keep the sidebar in step with SUMMARY.md on every start.
$summary = Join-Path $book "SUMMARY.md"
$sidebar = Join-Path $book "_sidebar.md"
if (Test-Path $summary) {
    (Get-Content $summary) | Where-Object { $_ -notmatch '^# Summary$' } |
        Set-Content $sidebar -Encoding UTF8
}

# Fail early with a clear message rather than a cryptic bind error.
$busy = Get-NetTCPConnection -LocalPort $Port -State Listen -ErrorAction SilentlyContinue
if ($busy) {
    Write-Error "Port $Port is already in use. Try: .\tools\serve.ps1 -Port 8080"
}

$url = "http://localhost:$Port"
Write-Host ""
Write-Host "  Serving $book"
Write-Host "  $url" -ForegroundColor Cyan
Write-Host "  Ctrl+C to stop."
Write-Host ""

if (-not $NoOpen) {
    Start-Job -ScriptBlock { Start-Sleep -Seconds 2; Start-Process $using:url } | Out-Null
}

Push-Location $book
try {
    python -m http.server $Port --bind 127.0.0.1
}
finally {
    Pop-Location
    Get-Job | Where-Object { $_.State -eq 'Completed' } | Remove-Job -ErrorAction SilentlyContinue
}
