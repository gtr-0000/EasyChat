:init
cls
set "mtitle=EasyChat"
title %mtitle%
timage "user\login.bmp" 0 0
set name=
set pass=

:mouse
tcurs /crv 0
timage "user\login.bmp" 0 0 /transparentblt
tmouse /d 0 1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000
if %y% equ 9 if %x% geq 21 if %x% leq 58 goto input1
if %y% equ 13 if %x% geq 21 if %x% leq 58 goto input2
if %y% geq 20 if %y% leq 21 if %x% geq 21 if %x% leq 37 goto login
if %y% geq 20 if %y% leq 21 if %x% geq 41 if %x% leq 58 call "user\new.bat"
goto mouse

:input1
tcurs /pos 25 9
echo;
tcurs /pos 25 9 /crv 1
timage "user\login.bmp" 0 0 /transparentblt
set name=
set /p name=
if defined name if not defined pass goto input2
goto mouse

:input2
tcurs /pos 25 13
echo;
tcurs /pos 25 13 /crv 1
timage "user\login.bmp" 0 0 /transparentblt
password -password >"$input.txt"
set pass=
set /p pass=<"$input.txt"
del "$input.txt"
goto mouse

:login
if not defined name goto input1
if not defined pass goto input2
timage "user\login.0.bmp" 0 0 /transparentblt
rem 注意引号 " 变成了 chr(1), 即
set return=
http get "$return.txt" "%server%/user/login.asp" "name=%name:"=%" "pass=%pass:"=%"
if %errorlevel% neq 0 set "error=连接错误 %errorlevel%" & goto loginerror
set /p return=<"$return.txt"
del "$return.txt"
timage "user\login.bmp" 0 0 /transparentblt
if "%return:~,1%"=="0" (
	set "uname=%name:"=""%"
	set "apikey=%return:~2%"
	call "list\get.bat"
	call "user\logout.bat"
	goto init
) else (
	set "error=%return:~2%" & goto loginerror
)
goto mouse

:loginerror
gdi "/T:%mtitle%" "%error%*240*300*黑体*14*0000ffff"
tmouse /d 0 3 1
goto mouse
