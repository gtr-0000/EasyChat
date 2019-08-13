@echo off
cls

del "%upath%\#open.txt" >nul 2>nul
if not exist "%upath%\#open.txt" exit /b
2>>"%upath%\@getA.txt" (call :main 3>"%upath%\#getA.txt")
del "%upath%\#getA.txt" >nul 2>nul
exit /b

:main
setlocal enabledelayedexpansion

:loop
http get "%upath%\$return.txt" "%server%/list/get.asp" "apikey=%apikey%"

if exist "%upath%\#exit.txt" exit /b

if %errorlevel% neq 0 echo Á¬½Ó´íÎó !errorlevel!>"%upath%\$getAerr.txt" & goto loop
set /p $return=<"%upath%\$return.txt"
if "%return:~,1%"=="0" (
	del "%upath%\$getAerr.txt" >nul 2>nul
) else (
	echo !return:~2!>"%upath%\$getAerr.txt"
	sleep 1000
	goto loop
)
set n=0
for /f "skip=1 usebackq" %%a in ("%upath%\$return.txt") do set /a n+=1
<"%upath%\$return.txt" >"%upath%\clist.txt" (
	set /p return=
	for /l %%a in (1,1,%n%) do (
		set /p l=
		echo %%a	!l!
	)
)
sleep 1000

if exist "%upath%\#exit.txt" exit /b

goto loop
