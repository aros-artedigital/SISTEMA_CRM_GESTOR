@echo off
setlocal
title CRM GESTOR - parando o servidor

rem ============================================================
rem  Encerra o servidor local do CRM GESTOR.
rem  So e necessario se voce quiser liberar a porta ou fechar
rem  tudo; fechar a janela "CRM GESTOR - servidor" faz o mesmo.
rem
rem  Desde a v8.56: so encerra o servidor do CRM GESTOR
rem  (servidor_crm_gestor.py, ou o http.server das versoes antigas)
rem  - outro programa na mesma porta fica intacto - e fecha junto a
rem  janela "CRM GESTOR - servidor" que o hospedava, como o "Abrir
rem  CRM GESTOR.bat" faz ao trocar de versao. Antes, encerrava qualquer
rem  programa na porta e deixava essa janela aberta, vazia.
rem ============================================================

set "PORTA=%~1"
if not defined PORTA set "PORTA=4590"

rem saida 0 = encerrado, 1 = nada na porta, 2 = outro programa na porta
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ids=@(Get-NetTCPConnection -State Listen -LocalPort ([int]$env:PORTA) -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess -Unique); if (-not $ids) { exit 1 }; foreach ($id in $ids) { $p=Get-CimInstance Win32_Process -Filter ('ProcessId='+$id); if (-not $p -or ($p.CommandLine -notlike '*http.server*' -and $p.CommandLine -notlike '*servidor_crm_gestor*')) { exit 2 } }; foreach ($id in $ids) { $p=Get-CimInstance Win32_Process -Filter ('ProcessId='+$id); $pai=Get-CimInstance Win32_Process -Filter ('ProcessId='+$p.ParentProcessId); Stop-Process -Id $id -Force -ErrorAction SilentlyContinue; if ($pai -and $pai.Name -eq 'cmd.exe' -and ($pai.CommandLine -like '*http.server*' -or $pai.CommandLine -like '*servidor_crm_gestor*')) { Stop-Process -Id $pai.ProcessId -Force -ErrorAction SilentlyContinue } }; exit 0"
if errorlevel 2 goto outro
if errorlevel 1 goto nenhum

echo.
echo   Servidor do CRM GESTOR encerrado.
echo.
goto fim

:outro
echo.
echo   A porta %PORTA% esta ocupada por outro programa, que nao e o
echo   servidor do CRM GESTOR. Nada foi encerrado.
echo.
goto fim

:nenhum
echo.
echo   Nenhum servidor do CRM GESTOR estava rodando na porta %PORTA%.
echo.

:fim
rem ping em vez de timeout: timeout falha quando a entrada esta redirecionada
ping -n 4 127.0.0.1 >nul 2>&1
exit /b 0
