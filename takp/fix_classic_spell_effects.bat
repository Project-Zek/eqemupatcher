@echo off
setlocal
title Classic Spell Effects Fix

rem Work in the folder where this .bat resides
set "DIR=%~dp0"

echo.
echo Backing up spellsnew.edd and spellsnew.eff in:
echo   "%DIR%"

rem Backup spellsnew.edd -> spellsnew.edd.old
if exist "%DIR%spellsnew.edd.old" (
  echo Found "spellsnew.edd.old" - leaving as is.
) else (
  if exist "%DIR%spellsnew.edd" (
    ren "%DIR%spellsnew.edd" "spellsnew.edd.old"
    if errorlevel 1 (
      echo Failed to rename spellsnew.edd
    ) else (
      echo Renamed "spellsnew.edd" to "spellsnew.edd.old"
    )
  ) else (
    echo "spellsnew.edd" not found.
  )
)

rem Backup spellsnew.eff -> spellsnew.eff.old
if exist "%DIR%spellsnew.eff.old" (
  echo Found "spellsnew.eff.old" - leaving as is.
) else (
  if exist "%DIR%spellsnew.eff" (
    ren "%DIR%spellsnew.eff" "spellsnew.eff.old"
    if errorlevel 1 (
      echo Failed to rename spellsnew.eff
    ) else (
      echo Renamed "spellsnew.eff" to "spellsnew.eff.old"
    )
  ) else (
    echo "spellsnew.eff" not found.
  )
)

echo.
echo Ensuring "ShowSpellEffects=1" is set in eqclient.ini ...

powershell -NoProfile -ExecutionPolicy Bypass -Command "$root = Split-Path -Parent '%~f0'; $p = Join-Path $root 'eqclient.ini'; if (-not (Test-Path $p)) { Set-Content -Path $p -Value \"[Defaults]`r`nShowSpellEffects=1`r`n\" -Encoding Default; exit 0 }; $text = Get-Content -Path $p -Raw; if ($text -match '(?im)^\s*ShowSpellEffects\s*=\s*\d+') { $new = [regex]::Replace($text, '(?im)^\s*ShowSpellEffects\s*=\s*\d+', 'ShowSpellEffects=1') } else { if ($text -match '(?im)^\s*\[Defaults\]\s*$') { $new = [regex]::Replace($text, '(?im)(^\s*\[Defaults\]\s*$[\r\n]*)', '$1ShowSpellEffects=1`r`n') } else { $new = $text + \"`r`nShowSpellEffects=1`r`n\" } }; if ($new -ne $text) { Set-Content -Path $p -Value $new -Encoding Default }"

echo.
echo All done.
echo.
pause
