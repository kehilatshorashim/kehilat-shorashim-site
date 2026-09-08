$site = "C:\Users\david\AppData\Local\Temp\claude\C--Users-david-Desktop-natha-s-hard-disk\5b33c630-1897-4426-ad18-c9bf2a9bfeeb\scratchpad\site"
$assets = "C:\Users\david\AppData\Local\Temp\claude\C--Users-david-Desktop-natha-s-hard-disk\5b33c630-1897-4426-ad18-c9bf2a9bfeeb\scratchpad\fb_assets"
$deploy = "C:\Users\david\AppData\Local\Temp\claude\C--Users-david-Desktop-natha-s-hard-disk\5b33c630-1897-4426-ad18-c9bf2a9bfeeb\scratchpad\deploy"

$utf8 = New-Object System.Text.UTF8Encoding($false)

function Wrap-Html($fragment, $description) {
    $favicon = 'data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22%3E%3Ctext y=%22.9em%22 font-size=%2290%22%3E%F0%9F%8C%B3%3C/text%3E%3C/svg%3E'
    $head = "<!DOCTYPE html>`n<html lang=`"he`" dir=`"rtl`">`n<meta charset=`"UTF-8`">`n<meta name=`"viewport`" content=`"width=device-width, initial-scale=1`">`n<meta name=`"description`" content=`"$description`">`n<link rel=`"icon`" href=`"$favicon`">`n"
    return $head + $fragment + "`n</html>`n"
}

$logoB64 = [System.IO.File]::ReadAllText((Join-Path $assets "logo_b64.txt"), $utf8)
$heroB64 = [System.IO.File]::ReadAllText((Join-Path $assets "hero_illustration_b64.txt"), $utf8)
$treeB64 = [System.IO.File]::ReadAllText((Join-Path $assets "tree_b64.txt"), $utf8)
$tileB64 = [System.IO.File]::ReadAllText((Join-Path $assets "tree_tile_b64.txt"), $utf8)
$qrB64 = [System.IO.File]::ReadAllText((Join-Path $assets "whatsapp_qr_b64.txt"), $utf8)
$fbUrl = "https://www.facebook.com/KehilatShorashimJlm"
$waUrl = "https://chat.whatsapp.com/D9gUTmWu5asBXR1ZuHR7pS"
$descHome = [System.IO.File]::ReadAllText((Join-Path $deploy "desc_home.txt"), $utf8)
$descVisit = [System.IO.File]::ReadAllText((Join-Path $deploy "desc_visit.txt"), $utf8)
$descJoin = [System.IO.File]::ReadAllText((Join-Path $deploy "desc_join.txt"), $utf8)

# Relative/root URLs for the real domain
$homeUrl = "/"
$visitUrl = "/prayer-times.html"
$joinUrl = "/join.html"

$homeHtml = [System.IO.File]::ReadAllText((Join-Path $site "home_template.html"), $utf8)
$homeHtml = $homeHtml.Replace("{{LOGO_B64}}", $logoB64)
$homeHtml = $homeHtml.Replace("{{HERO_B64}}", $heroB64)
$homeHtml = $homeHtml.Replace("{{TREE_B64}}", $treeB64)
$homeHtml = $homeHtml.Replace("{{TILE_B64}}", $tileB64)
$homeHtml = $homeHtml.Replace("{{FACEBOOK_URL}}", $fbUrl)
$homeHtml = $homeHtml.Replace("{{VISIT_URL}}", $visitUrl)
$homeHtml = $homeHtml.Replace("{{JOIN_URL}}", $joinUrl)
$homeHtml = Wrap-Html $homeHtml $descHome
[System.IO.File]::WriteAllText((Join-Path $deploy "index.html"), $homeHtml, $utf8)

$visit = [System.IO.File]::ReadAllText((Join-Path $site "visit_template.html"), $utf8)
$visit = $visit.Replace("{{LOGO_B64}}", $logoB64)
$visit = $visit.Replace("{{TILE_B64}}", $tileB64)
$visit = $visit.Replace("{{FACEBOOK_URL}}", $fbUrl)
$visit = $visit.Replace("{{HOME_URL}}", $homeUrl)
$visit = $visit.Replace("{{JOIN_URL}}", $joinUrl)
$visit = Wrap-Html $visit $descVisit
[System.IO.File]::WriteAllText((Join-Path $deploy "prayer-times.html"), $visit, $utf8)

$join = [System.IO.File]::ReadAllText((Join-Path $site "join_template.html"), $utf8)
$join = $join.Replace("{{LOGO_B64}}", $logoB64)
$join = $join.Replace("{{TILE_B64}}", $tileB64)
$join = $join.Replace("{{FACEBOOK_URL}}", $fbUrl)
$join = $join.Replace("{{HOME_URL}}", $homeUrl)
$join = $join.Replace("{{VISIT_URL}}", $visitUrl)
$join = $join.Replace("{{QR_B64}}", $qrB64)
$join = $join.Replace("{{WHATSAPP_URL}}", $waUrl)
$join = Wrap-Html $join $descJoin
[System.IO.File]::WriteAllText((Join-Path $deploy "join.html"), $join, $utf8)

Write-Output "Built deploy files:"
Write-Output "index.html: $((Get-Item (Join-Path $deploy 'index.html')).Length) bytes"
Write-Output "prayer-times.html: $((Get-Item (Join-Path $deploy 'prayer-times.html')).Length) bytes"
Write-Output "join.html: $((Get-Item (Join-Path $deploy 'join.html')).Length) bytes"
