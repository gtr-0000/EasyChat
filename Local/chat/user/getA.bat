@echo off
del "%cpath%\#open.txt" >nul 2>nul
if not exist "%cpath%\#open.txt" exit /b
2>>"%cpath%\@getA.txt" (call :main 3>"%cpath%\#getA.txt")
exit /b

:main

:loop
if not exist "%cpath%\cid.txt" (echo 0)> "%cpath%\cid.txt"
set /p cid=<"%cpath%\cid.txt"
http get "%cpath%\$return.txt" "%server%/chat/user/get.asp" "apikey=%apikey%" "name=%cname:""=%" "cid=%cid%"

if exist "%cpath%\#exit.txt" exit /b

if %errorlevel% neq 0 echo Á¬½Ó´íÎó %errorlevel%>"%cpath%\$getAerr.txt" & goto loop
set /p $return=<"%cpath%\$return.txt"
if "%return:~,1%"=="0" (
	del "%cpath%\$getAerr.txt" >nul 2>nul
) else (
	echo !return:~2!>"%cpath%\$getAerr.txt"
	sleep 1000
	goto loop
)
>>"%cpath%\chat.txt" (
	for /f "skip=1 usebackq tokens=1-4 delims=	" %%a in ("%cpath%\$return.txt") do (
		set cid=%%a
		echo $%%c
		echo @%%b
		if "%%b"=="%uname%" (
			echo [
			echo =%%d
			echo ]
		) else (
			echo {
			echo -%%d
			echo }
		)
	)
)
(echo %cid%)>"%cpath%\cid.txt"
sleep 1000

if exist "%cpath%\#exit" exit /b

goto loop
