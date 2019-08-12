:init
cls
timage "group\new.bmp" 0 0
set name=

:mouse
tcurs /crv 0
timage "group\new.bmp" 0 0 /transparentblt
tmouse /d 0 1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000
if %y% equ 9 if %x% geq 21 if %x% leq 58 goto input1
if %y% geq 20 if %y% leq 21 if %x% geq 21 if %x% leq 37 exit /b
if %y% geq 20 if %y% leq 21 if %x% geq 41 if %x% leq 58 goto new
goto mouse

:input1
tcurs /pos 25 9
echo;                                
tcurs /pos 25 9 /crv 1
timage "group\new.bmp" 0 0 /transparentblt
set name=
set /p name=
goto mouse

:new
if not defined name goto input1 
timage "group\new.0.bmp" 0 0 /transparentblt

rem 注意引号 " 变成了 chr(1), 即
http get "$return" "%server%/group/new.asp" "apikey=%apikey%" "name=%name:"=%"
if %errorlevel% neq 0 set "error=连接错误 %errorlevel%" & goto newerror
set /p return=<"$return"
del "$return"
timage "group\new.bmp" 0 0 /transparentblt
if "%return:~,1%"=="0" (
	gdi "" "创建成功*270*295*黑体*14*ff0000ff"
	tmouse /d 0 3 1
	exit /b
) else (
	set "error=%return:~2%"
	goto newerror
)
goto mouse

:newerror
gdi "" "%error%*240*300*黑体*14*0000ffff"
tmouse /d 0 3 1
goto mouse
