@echo off
cls

del "%upath%\#open" >nul 2>nul
if not exist "%upath%\#open" exit /b
2>>"%upath%\debug2.txt" (call :main 3>"%upath%\#getA")
del "%upath%\#getA" >nul 2>nul
exit /b

:main
setlocal enabledelayedexpansion

:loop
http get "%upath%\$return" "%server%/list/get.asp" "apikey=%apikey%"

if exist "%upath%\#exit" exit /b

if %errorlevel% neq 0 echo Á¬½Ó´íÎó !errorlevel!>"%upath%\$getAerr" & goto loop
set /p $return=<"%upath%\$return"
if "%return:~,1%"=="0" (
	del "%upath%\$getAerr" >nul 2>nul
) else (
	echo !return:~2!>"%upath%\$getAerr"
	sleep 1000
	goto loop
)
set n=0
for /f "skip=1 usebackq" %%a in ("%upath%\$return") do set /a n+=1
<"%upath%\$return" >"%upath%\clist.txt" (
	set /p return=
	for /l %%a in (1,1,%n%) do (
		set /p l=
		echo %%a	!l!
	)
)
del "%upath%\$return"
sleep 1000

if exist "%upath%\#exit" exit /b

goto loop
