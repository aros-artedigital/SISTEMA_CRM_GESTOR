@echo off
title CRM GESTOR - atualizar
rem Atualiza o CRM GESTOR instalado neste computador para a versao deste pacote.
rem Faz backup dos dados antes e volta para a versao anterior se algo der errado.
rem Opcoes: --voltar (volta para a versao anterior), --forcar (reinstala a mesma versao).
"%~dp0servidor\python\python.exe" -X utf8 "%~dp0servidor\atualizar.py" %*
echo.
pause
