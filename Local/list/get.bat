@echo off
call "upath.bat"
if exist "%upath%\#open.txt" del "%upath%\#open.txt" >nul 2>nul
if exist "%upath%\#open.txt" exit
2>>"%upath%\@get.txt" (call :main 3>"%upath%\#open.txt")
exit

:main
del "%upath%\#exit.txt" >nul 2>nul
start /b cmd /c "list\getA.bat"

cls
set lp=1
set last=
set first=
set "mtitle=%uname: =*%EasyChat"
title %mtitle%

:mouse
tcurs /crv 0
set ln=0
for /f "usebackq tokens=1-4 delims=	" %%a in ("%upath%\clist.txt") do (
	set l%%aty=%%b
	set l%%ana=%%c
	set l%%ati=%%d
	set ln=%%a
)
set /a ln1=ln-4

set last=
set first=
if %lp% geq %ln1% set /a lp=ln1,last=1
if %lp% leq 1 set /a lp=1,first=1

setlocal enabledelayedexpansion
set disp="list\get.bmp*0*0" "%uname%*48*16*宋体*12*ffffffff"
if not defined first set disp=!disp! "list\get.up.bmp*608*64"
if not defined last set disp=!disp! "list\get.down.bmp*608*368"
set /a lp1=lp+4
for /l %%a in (%lp%,1,%lp1%) do (
	if %%a leq %ln% (
		set /a "y=(%%a-lp)*64+64,y1=y+16"
		if "!l%%aty!"=="group" (
			set disp=!disp! "list\get.item.bmp*48*!y!" "群 !l%%ana!*60*!y1!*黑体*12*000000ff"
		) else if "!l%%aty!"=="user" (
			set disp=!disp! "list\get.item.bmp*48*!y!" "用户 !l%%ana!*60*!y1!*黑体*12*000000ff"
		)
	)
)
if exist "%upath%\$getAerr.txt" (
	set /p error=<"%upath%\$getAerr.txt"
	set disp=!disp! "!error!*240*300*黑体*14*0000ffff"
)

gdi "/T:!mtitle!" !disp!
endlocal

tmouse /d 0 1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000

set select=
if %y% equ 1 (
	if %x% geq 2 if %x% leq 3 goto menu
	if %x% geq 76 if %x% leq 77 goto add
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
				start cmd /c "chat\!l%%aty!\get.bat"
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

:menu
timage "list\get.menu.bmp" 0 0 /transparentblt
tmouse /d 0 -1 1
set /a y=%errorlevel%,x=y/1000,y=y%%1000
if %x% leq 24 (
	if %y% geq 3 if %y% leq 5 call "user\config\pass.bat"
	if %y% geq 6 if %y% leq 8 call "user\logout.bat"&&exit
	if %y% geq 22 call "app\update.bat"
)
goto mouse

:add
timage "list\get.add.bmp" 520 32 /transparentblt
tmouse /d 0 -1 1
set /a y=%errorlevel%,x=y/1000,y=y%%1000
if %x% geq 66 if %x% leq 75 (
	if %y% equ 3 call "find\user.bat"
	if %y% equ 4 call "find\group.bat"
	if %y% equ 5 call "group\new.bat"
)
goto mouse
