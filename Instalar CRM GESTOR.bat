@echo off
title CRM GESTOR - instalar
rem Instala o CRM GESTOR neste computador (C:\CRM GESTOR\sistema).
rem Rode depois de descompactar o .zip inteiro. Ver "LEIA-ME - instalar.txt".
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0servidor\instalar.ps1" %*
echo.
pause
