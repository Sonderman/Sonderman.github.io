@echo off
setlocal
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 (
  echo [HATA] Node.js bulunamadi. https://nodejs.org adresinden kur.
  goto :fail
)

echo [1/4] Bagimliliklar
pushd Source
if not exist node_modules (
  call npm install
  if errorlevel 1 (
    popd
    goto :fail
  )
)

echo [2/4] Build
call npm run build
if errorlevel 1 (
  popd
  goto :fail
)
popd

echo [3/4] Build dogrulanıyor
node "Source\scripts\verify-dist.mjs" "Source\dist"
if errorlevel 1 goto :fail

echo [4/4] Kok dizine yayinlaniyor
robocopy "Source\dist" "." /MIR /XD "Source" ".git" /XF "README.md" "AGENTS.md" "deploy.bat" ".gitignore" /NFL /NDL /NJH /NJS /NP
if errorlevel 8 goto :fail

node "Source\scripts\verify-dist.mjs" "."
if errorlevel 1 goto :fail

echo.
echo Yayin tamam. Simdi degisiklikleri kontrol edip commit edebilirsin: git status
pause
exit /b 0

:fail
echo.
echo [HATA] Yayin tamamlanmadi. Yukaridaki ciktiyi kontrol et.
pause
exit /b 1
