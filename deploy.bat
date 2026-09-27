@echo off
setlocal
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 (
  echo [HATA] Node.js bulunamadi. https://nodejs.org adresinden kur.
  goto :fail
)

echo [1/5] Bagimliliklar
pushd Source
if not exist node_modules (
  call npm install
  if errorlevel 1 (
    popd
    goto :fail
  )
)

echo [2/5] Lint
call npm run lint
if errorlevel 1 (
  popd
  goto :fail
)

echo [3/5] Build
call npm run build
if errorlevel 1 (
  popd
  goto :fail
)
popd

echo [4/5] Build dogrulanıyor
node "Source\scripts\verify-dist.mjs" "Source\dist"
if errorlevel 1 goto :fail

echo [5/5] Kok dizine yayinlaniyor
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
