:: windows 下的守护重启脚本

@echo on
 
set _task=notepad.exe
set _svr=c:\windows\notepad.exe
set _des=start.bat
 
:checkstart
for /f "tokens=5" %%n in ('qprocess.exe ^| find "%_task%" ') do (
 if %%n==%_task% (goto checkag) else goto startsvr
)
 
  
 
:startsvr
echo %time% 
echo -------app start -----
echo app start at time %time% >> restart_service.txt
echo start %_svr% > %_des%
echo exit >> %_des%
start %_des%

echo Wscript.Sleep WScript.Arguments(0) >%tmp%\delay.vbs 
cscript //b //nologo %tmp%\delay.vbs 10000 
del %_des% /Q
echo app %notepad.exe% start
goto checkstart
 
 
:checkag
echo %time% running... 
echo Wscript.Sleep WScript.Arguments(0) >%tmp%\delay.vbs 
cscript //b //nologo %tmp%\delay.vbs 10000 
goto checkstart
