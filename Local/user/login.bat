cls
timage user\login.bmp 0 0
set NAME=
set PASS=

:mouse
tcurs /crv 0
timage user\login.bmp 0 0 /transparentblt
tmouse /d 0 1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000
if %y% equ 9 if %x% geq 21 if %x% leq 58 goto input1
if %y% equ 13 if %x% geq 21 if %x% leq 58 goto input2
if %y% geq 20 if %y% leq 21 if %x% geq 21 if %x% leq 37 goto login
if %y% geq 20 if %y% leq 21 if %x% geq 46 if %x% leq 53 call user\new
goto mouse

:input1
tcurs /pos 25 9
echo;                                
tcurs /pos 25 9 /crv 1
timage user\login.bmp 0 0 /transparentblt
password -32 >$NAME
set NAME=
set /p NAME=<$NAME
del $NAME
if defined NAME if not defined PASS goto input2
goto mouse

:input2
tcurs /pos 25 13
echo;                                
tcurs /pos 25 13 /crv 1
timage user\login.bmp 0 0 /transparentblt
password -32 -password >$PASS
set PASS=
set /p PASS=<$PASS
del $PASS
goto mouse

:login
if not defined NAME goto input1
if not defined PASS goto input2
timage user\login.0.bmp 0 0 /transparentblt
rem 注意引号 " 变成了 chr(1), 即
set RETURN=
http get $RETURN "%SERVER%/user/login.asp" "name=%name:"=%" "pass=%pass:"=%"
if %errorlevel% neq 0 set ERROR=连接错误 %errorlevel% & goto loginerror
set /p RETURN=<$RETURN
del $RETURN
timage user\login.bmp 0 0 /transparentblt
if "%RETURN:~,1%"=="0" (
	echo %RETURN:~2%>$APIKEY
	call clist\get
) else (
	set ERROR=%RETURN:~2% & goto loginerror
)
goto mouse

:loginerror
gdi "" "%ERROR%*220*280*黑体*16*0000FFFF"
Tmouse /d 0 3 1
goto mouse
