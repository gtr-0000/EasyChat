cls
http get "$return" "%server%/user/logout.asp" "apikey=%apikey%"
if %errorlevel% neq 0 set error=Á¬½Ó´íÎó %errorlevel% & goto loginerror
set /p return=<"$return"
del "$return"
if "%return:~,1%"=="0" (
	set apikey=
) else (
	set error=%return:~2% & goto loginerror
)

exit /b
:error
gdi "" "%error%*240*300*ËÎÌå*14*0000ffff"
tmouse /d 0 3 1
