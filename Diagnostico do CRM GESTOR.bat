@echo off
title CRM GESTOR - diagnostico
rem Confere o CRM GESTOR deste computador e grava um relatorio na Area de Trabalho
rem para mandar ao suporte. Nao muda nada.
set "PY=python"
python -c "import sqlite3" >nul 2>&1 || set "PY=%~dp0servidor\python\python.exe"
"%PY%" -X utf8 "%~dp0servidor\diagnostico.py" %*
echo.
pause
