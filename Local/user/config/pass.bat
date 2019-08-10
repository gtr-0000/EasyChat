cls
timage user\config\pass.bmp 0 0
set pold=
set pass=
set pas2=

:mouse
tcurs /crv 0
timage user\config\pass.bmp 0 0 /transparentblt
tmouse /d 0 1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000
if %y% equ 9 if %x% geq 21 if %x% leq 58 goto input1
if %y% equ 13 if %x% geq 21 if %x% leq 58 goto input2
if %y% equ 17 if %x% geq 21 if %x% leq 58 goto input3
if %y% geq 20 if %y% leq 21 if %x% geq 21 if %x% leq 37 exit /b
if %y% geq 20 if %y% leq 21 if %x% geq 41 if %x% leq 58 goto change
goto mouse

:input1
tcurs /pos 25 9
echo;                                
tcurs /pos 25 9 /crv 1
timage user\config\pass.bmp 0 0 /transparentblt
password -32 -password >"$input"
set pold=
set /p pold=<"$input"
del "$input"
if defined pold if not defined pass goto input2
goto mouse

:input2
tcurs /pos 25 13
echo;                                
tcurs /pos 25 13 /crv 1
timage user\config\pass.bmp 0 0 /transparentblt
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
timage user\config\pass.bmp 0 0 /transparentblt
password -32 -password >"$input"
set pas2=
set /p pas2=<"$input"
del "$input"
goto mouse

:change
timage user\config\pass.0.bmp 0 0 /transparentblt
if not defined pold goto input1 
if not defined pass goto input2 
if not defined pas2 goto input3
if "%pass:"=""%" neq "%pas2:"=""%" set error=两次密码不一致 & goto passerror

rem 注意引号 " 变成了 chr(1), 即
http get "$return" "%server%/user/config/pass.asp" "apikey=%apikey%" "pold=%pold:"=%" "pass=%pass:"=%"
if %errorlevel% neq 0 set error=连接错误 %errorlevel% & goto passerror
set /p return=<"$return"
del "$return"
timage user\config\pass.bmp 0 0 /transparentblt
if "%return:~,1%"=="0" (
	gdi "" "修改成功*270*295*宋体*14*ff0000ff"
	tmouse /d 0 3 1
	exit /b
) else (
	set error=%return:~2%
	goto passerror
)
goto mouse

:passerror
gdi "" "%error%*240*300*宋体*14*0000ffff"
tmouse /d 0 3 1
goto mouse

