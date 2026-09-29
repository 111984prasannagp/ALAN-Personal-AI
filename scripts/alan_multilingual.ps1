$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$target = Join-Path $root "vendor\mark_lv\core\prompt.txt"

if (-not (Test-Path $target)) { throw "Prompt file not found: $target" }

$t = [System.IO.File]::ReadAllText($target)

$start = $t.IndexOf("[LANGUAGE]")
$end = $t.IndexOf("[EXECUTION]")

if ($start -lt 0 -or $end -lt 0 -or $end -le $start) {
    throw "Could not locate LANGUAGE section in core/prompt.txt"
}

$replacement = @'
[LANGUAGE]
Understand the user's speech regardless of whether it is English, Tamil,
Thunglish/Tanglish, or a mixture of these in normal speech.

The user's spoken Tamil may arrive as Tamil script in the transcript. That is
still a valid user request. DO NOT say that you cannot understand or translate
Tamil merely because the transcript is in Tamil script.

Interpret Tamil and Thunglish by meaning and context. If the user mixes Tamil
and English naturally, understand the whole sentence instead of rejecting it.

Reply in the language/style the user is using. If the user speaks Tamil or
Thunglish, you may reply in simple Thunglish/English as appropriate. Do not
claim that translation is unavailable when you can understand the request.

Never treat the language of tool output, logs, memory, or this prompt as the
user's language. The user's most recent spoken message determines the reply
language.

[EXECUTION]
'@

$t = $t.Substring(0, $start) + $replacement + $t.Substring($end + "[EXECUTION]".Length)

[System.IO.File]::WriteAllText($target, $t)
Write-Host "ALAN multilingual voice prompt applied successfully."
