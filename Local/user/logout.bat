cls
::timage user\logout.bmp 0 0
set /p APIKEY=<$APIKEY
http get $RETURN "%SERVER%/user/logout.asp" "apikey=%APIKEY%"
set /p RETURN=<$RETURN
del $RETURN
if "%RETURN:~,1%"=="0" (
	del $APIKEY
) else (
	gdi "" "%RETURN:~2%*220*280*ºÚÌå*16*0000FFFF"
	Tmouse /d 0 3 1
)