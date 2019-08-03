cls
::timage user\logout.bmp 0 0
set /p APIKEY=<$APIKEY
http get $RETURN "%SERVER%/user/logout.asp" "apikey=%APIKEY%"
if %errorlevel% neq 0 set ERROR=Á¬½Ó´íÎó %errorlevel% & goto loginerror
set /p RETURN=<$RETURN
del $RETURN
if "%RETURN:~,1%"=="0" (
	del $APIKEY
) else (
	set ERROR=%RETURN:~2% & goto loginerror
)

exit /b
:error
gdi "" "%ERROR%*220*280*ºÚÌå*16*0000FFFF"
Tmouse /d 0 3 1