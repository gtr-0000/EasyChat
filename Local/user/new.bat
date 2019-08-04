cls
timage "user\new.bmp" 0 0
set name=
set pass=
set pas2=

:mouse
tcurs /crv 0
timage "user\new.bmp" 0 0 /transparentblt
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
timage "user\new.bmp" 0 0 /transparentblt
set name=
set /p name=
if defined name if not defined pass goto input2
goto mouse

:input2
tcurs /pos 25 13
echo;                                
tcurs /pos 25 13 /crv 1
timage "user\new.bmp" 0 0 /transparentblt
password -32 -password >"$input"
set pass=
set /p pass=<"$input"
del "$input"
if defined pass if not defined pas2 goto input3
goto mouse

:input3
tcurs /pos 25 17
echo;                                
tcurs /pos 25 17 /crv 1
timage "user\new.bmp" 0 0 /transparentblt
password -32 -password >"$input"
set pas2=
set /p pas2=<"$input"
del "$input"
goto mouse

:new
timage "user\new.0.bmp" 0 0 /transparentblt
if not defined name goto input1 
if not defined pass goto input2 
if not defined pas2 goto input3
if "%pass:"=""%" neq "%pas2:"=""%" set error=两次密码不一致 & goto newerror

rem 注意引号 " 变成了 chr(1), 即
http get "$return" "%server%/user/new.asp" "name=%name:"=%" "pass=%pass:"=%"
if %errorlevel% neq 0 set error=连接错误 %errorlevel% & goto newerror
set /p return=<"$return"
del "$return"
timage "user\new.bmp" 0 0 /transparentblt
if "%return:~,1%"=="0" (
	gdi "" "注册成功*270*295*宋体*14*ff0000ff"
	tmouse /d 0 3 1
	exit /b
) else (
	set error=%return:~2%
	goto newerror
)
goto mouse

:newerror
gdi "" "%error%*240*300*宋体*14*0000ffff"
tmouse /d 0 3 1
goto mouse
