@echo off
http get "$return" "%server%/list/group/del.asp" "apikey=%apikey%" "name=%cname:""=%"
if %errorlevel% neq 0 set "error=���Ӵ��� %errorlevel%" & goto error
set /p return=<"$return"
del "$return"
if "%return:~,1%"=="0" (
	set apikey=
) else (
	"set error=%return:~2%" & goto error
)

exit /b
:error
gdi "/T:%mtitle%" "%error%*240*300*����*14*0000ffff"
tmouse /d 0 3 1
