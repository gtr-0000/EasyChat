@echo off
cls

del "%upath%\#open" 2>nul
if not exist "%upath%\#open" exit /b
2>>"%upath%\debug2.txt" (call :main 3>"%upath%\#getA")
del "%upath%\#getA" 2>nul
exit /b

:main
setlocal enabledelayedexpansion

:loop
http get "%upath%\$return" "%server%/list/get.asp" "apikey=%apikey%"

del "%upath%\#open" 2>nul
if not exist "%upath%\#open" exit /b

set /p $return=<"%upath%\$return"
if "%return:~,1%"=="0" (
	del "$getAerr" 2>nul
) else (
	echo !return:~2!>"$getAerr"
	sleep 1000
	goto loop
)
set n=-1
for /f "usebackq" %%a in ("%upath%\$return") do set /a n+=1
<"%upath%\$return" >"%upath%\clist.txt" (
	set /p return=
	for /l %%a in (1,1,%n%) do (
		set /p l=
		echo %%a	!l!
	)
)
del "%upath%\$return"
sleep 1000

del "%upath%\#open" 2>nul
if not exist "%upath%\#open" exit /b

goto loop
