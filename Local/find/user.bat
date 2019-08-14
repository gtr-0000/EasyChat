:main

cls
set lp=1
set last=
set first=
set find=

:find
if defined find (
	http get "%upath%\$find.txt" "%server%/find/user.asp" "find=%find:"=%" "apikey=%apikey%"
) else (
	http get "%upath%\$find.txt" "%server%/find/user.asp" "apikey=%apikey%"
)
if %errorlevel% neq 0 set "error=连接错误 %errorlevel%" & goto finderror
set /p return=<"%upath%\$find.txt"
if not "%return:~,1%"=="0" set "error=%return:~2%" & goto finderror

setlocal enabledelayedexpansion
set n=0
for /f "skip=1 usebackq" %%a in ("%upath%\$find.txt") do set /a n+=1
<"!upath!\$find.txt" >"!upath!\find.txt" (
	set /p return=
	for /l %%a in (1,1,%n%) do (
		set /p l=
		echo %%a	!l!
	)
)
endlocal
del "%upath%\$find.txt"

:mouse
tcurs /crv 0
set ln=0
for /f "usebackq tokens=1-2 delims=	" %%a in ("%upath%\find.txt") do (
	set l%%ana=%%b
	set ln=%%a
)
set /a ln1=ln-4
::if defined last set lp=%ln1%

set last=
set first=
if %lp% geq %ln1% set /a lp=ln1,last=1
if %lp% leq 1 set /a lp=1,first=1

setlocal enabledelayedexpansion
set disp="find\find.bmp*0*0"
if not defined first set disp=!disp! "list\get.up.bmp*608*64"
if not defined last set disp=!disp! "list\get.down.bmp*608*368"
set /a lp1=lp+4
for /l %%a in (%lp%,1,%lp1%) do (
	if %%a leq %ln% (
		set /a "y=(%%a-lp)*64+64,y1=y+16"
		set disp=!disp! "list\get.item.bmp*48*!y!" "!l%%ana!*60*!y1!*黑体*12*000000ff"
	)
)

gdi "/T:!mtitle!" !disp!
endlocal

tmouse /d 0 -1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000

set select=
if %y% equ 1 (
	if %x% geq 2 if %x% leq 3 exit /b
	if %x% geq 76 if %x% leq 77 goto findset
)
if %x% geq 6 if %x% leq 70 (
	setlocal enabledelayedexpansion
	for /l %%a in (1,1,5) do (
		set /a y1=%%a*4+1,y2=%%a*4+3
		if %y% geq !y1! if %y% leq !y2! set select=%%a
	)
	if defined select (
		set /a select+=lp-1
		if !select! leq !ln! (
			for %%a in (!select!) do (
				set cname=!l%%ana!
				start /b /wait cmd /c "list\user\add.bat"
				start cmd /c "chat\user\get.bat"
				exit /b
			)
		)
	)
	endlocal
)
if %x% geq 76 if %x% leq 77 (
	if %y% equ 4 set /a lp-=4&set last=
	if %y% equ 23 set /a lp+=4
)
goto mouse

:findset
tcurs /pos 5 1 /crv 1
echo;
tcurs /pos 5 1 /crv 1
set find=
set /p find=^>
goto find

:finderror
gdi "/T:%mtitle%" "%error%*240*300*黑体*14*0000ffff"
tmouse /d 0 3 1
goto mouse
