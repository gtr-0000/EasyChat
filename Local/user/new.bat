cls
timage user\new.bmp 0 0
set NAME=
set PASS=
set PAS2=

:mouse
tcurs /crv 0
timage user\new.bmp 0 0 /transparentblt
tmouse /d 0 1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000
if %y% equ 9 if %x% geq 21 if %x% leq 58 goto input1
if %y% equ 13 if %x% geq 21 if %x% leq 58 goto input2
if %y% equ 17 if %x% geq 21 if %x% leq 58 goto input3
if %y% geq 20 if %y% leq 21 if %x% geq 21 if %x% leq 37 exit /b
if %y% geq 20 if %y% leq 21 if %x% geq 41 if %x% leq 58 goto new
goto mouse

:input1
tcurs /pos 25 9
echo;                                
tcurs /pos 25 9 /crv 1
timage user\new.bmp 0 0 /transparentblt
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
timage user\new.bmp 0 0 /transparentblt
password -32 -password >$PASS
set PASS=
set /p PASS=<$PASS
del $PASS
if defined PASS if not defined PAS2 goto input3
goto mouse

:input3
tcurs /pos 25 17
echo;                                
tcurs /pos 25 17 /crv 1
timage user\new.bmp 0 0 /transparentblt
password -32 -password >$PAS2
set PAS2=
set /p PAS2=<$PAS2
del $PAS2
goto mouse

:new
timage user\new.0.bmp 0 0 /transparentblt
if not defined NAME goto input1 
if not defined PASS goto input2 
if not defined PAS2 goto input3
if "%PASS:"=""%" neq "%PAS2:"=""%" set ERROR=两次密码不一致 & goto newerror

rem 注意引号 " 变成了 chr(1), 即
http get $RETURN "%SERVER%/user/new.asp" "name=%name:"=%" "pass=%pass:"=%"
if %errorlevel% neq 0 set ERROR=连接错误 %errorlevel% & goto loginerror
set /p RETURN=<$RETURN
del $RETURN
timage user\new.bmp 0 0 /transparentblt
if "%RETURN:~,1%"=="0" (
	gdi "" "注册成功*270*295*黑体*16*FF8000FF"
	Tmouse /d 0 3 1
	exit /b
) else (
	set ERROR=%RETURN:~2%
	Tmouse /d 0 3 1
)
goto mouse

:newerror
gdi "" "%ERROR%*220*295*黑体*16*0000FFFF"
Tmouse /d 0 3 1
goto mouse
