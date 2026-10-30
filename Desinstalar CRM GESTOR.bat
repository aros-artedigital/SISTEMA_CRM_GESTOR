@echo off
setlocal
title CRM GESTOR - desinstalar

rem ============================================================
rem  Desinstala o CRM GESTOR deste computador. Fica na pasta do
rem  sistema (C:\CRM GESTOR\sistema). Detalhes em
rem  servidor\desinstalar.ps1: pergunta antes de apagar os dados,
rem  e nunca mexe na pasta do fornecedor.
rem ============================================================

set "ESTE=%~f0"

rem --- sem administrador: pede ao Windows e roda de novo como admin ---
net session >nul 2>&1
if not errorlevel 1 goto desinstalar
echo.
echo   Pedindo permissao de administrador ao Windows...
powershell -NoProfile -Command "try { Start-Process -FilePath $env:ESTE -Verb RunAs -ErrorAction Stop } catch { exit 1 }"
if not errorlevel 1 exit /b 0
echo.
echo   Sem a permissao de administrador, nada foi alterado.
echo.
pause
exit /b 1

:desinstalar
rem O script e copiado para a pasta temporaria: a pasta do sistema
rem e apagada no fim, e este arquivo esta dentro dela.
set "TMPD=%TEMP%\crm_gestor_desinstalar"
if not exist "%TMPD%" mkdir "%TMPD%"
copy /y "%~dp0servidor\desinstalar.ps1" "%TMPD%\desinstalar.ps1" >nul
rem "%~dp0." (e nao "%~dp0") porque a barra no fim quebra as aspas
start "CRM GESTOR - desinstalar" powershell -NoProfile -ExecutionPolicy Bypass -File "%TMPD%\desinstalar.ps1" -Destino "%~dp0."
exit /b 0
