@echo off
mode 80,25
tcurs /crv 0
call "cpath.bat" G
if exist "%cpath%\#open.txt" del "%cpath%\#open.txt" >nul 2>nul
if exist "%cpath%\#open.txt" exit /b
2>>"%cpath%\@get.txt" (call :main 3>"%cpath%\#open.txt")
exit /b

:main
del "%cpath%\#exit.txt" >nul 2>nul
start /b cmd /c "chat\group\getA.bat"

cls
color f9
set lp=1
set last=1
set first=
set "mtitle=%cname: =*%%uname: =*%EasyChat"
title %mtitle%

:mouse
set ln=0
for /f "usebackq" %%a in ("%cpath%/chat.txt") do set /a ln+=1
set /a ln1=ln-17
if defined last set lp=%ln1%

set last=
set first=
if %lp% geq %ln1% set /a lp=ln1,last=1
if %lp% leq 1 set /a lp=1,first=1

setlocal enabledelayedexpansion
set disp="chat\get.bmp*0*0" "%cname%*48*16*����*12*ffffffff"
if not defined first set disp=!disp! "list\get.up.bmp*608*64"
if not defined last set disp=!disp! "list\get.down.bmp*608*304"
<"%cpath%\chat.txt" (
	for /l %%a in (2,1,%lp%) do set /p l=
	for /l %%a in (1,1,18) do (
		set l=
		set /p l=
		if defined l (
			set /a y=%%a*16+32
			set c=!l:~,1!
			set "l=!l:~1! "
			if "!c!" == "$" (
				set disp=!disp! "!l:"=""!*16*!y!*����*12*808080ff"
			) else if "!c!" == "@" (
				set disp=!disp! "!l:"=""!*16*!y!*����*12*0000ffff"
			) else if "!c!" == "{" (
				set disp=!disp! "chat/11.bmp*16*!y!"
			) else if "!c!" == "-" (
				set disp=!disp! "chat/12.bmp*16*!y!" "!l:"=""!*32*!y!*����*12*000000ff"
			) else if "!c!" == "}" (
				set disp=!disp! "chat/13.bmp*16*!y!"
			) else if "!c!" == "[" (
				set disp=!disp! "chat/21.bmp*16*!y!"
			) else if "!c!" == "=" (
				set disp=!disp! "chat/22.bmp*16*!y!" "!l:"=""!*32*!y!*����*12*ffffffff"
			) else if "!c!" == "]" (
				set disp=!disp! "chat/23.bmp*16*!y!"
			)
		)
	)
)
if exist "%cpath%\$getAerr.txt" (
	set /p error=<"%cpath%\$getAerr.txt"
	set disp=!disp! "!error!*240*300*����*14*0000ffff"
)

gdi "/T:!mtitle!" !disp!
endlocal

tmouse /d 0 1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000

if %x% geq 76 if %x% leq 77 (
	if %y% equ 4 set /a lp-=14&set last=
	if %y% equ 19 set /a lp+=14
)
if %y% geq 21 if %y% leq 24 start /b cmd /c "chat\group\send.bat"
goto mouse
