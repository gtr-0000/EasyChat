@echo off
mode 80,25
tcurs /crv 0
if exist "%cpath%\#open" del "%cpath%\#open" >nul 2>nul
if exist "%cpath%\#open" exit /b
break >> "%cpath%\chat.txt"
2>>"%cpath%\debug.txt" (call :main 3>"%cpath%\#open")
exit /b

:main
del "%cpath%\#exit" >nul 2>nul
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
set /a ln1=ln-14
if defined last set lp=%ln1%

set last=
set first=
if %lp% geq %ln1% set /a lp=ln1,last=1
if %lp% leq 1 set /a lp=1,first=1

setlocal enabledelayedexpansion
set disp="chat\get.bmp*0*0"
if not defined first set disp=!disp! "list\get.up.bmp*608*64"
if not defined last set disp=!disp! "list\get.down.bmp*608*304"
set /a lp1=lp+14
<"%cpath%\chat.txt" (
	for /l %%a in (2,1,%lp%) do set /p l=
	for /l %%a in (1,1,15) do (
		set l=
		set /p l=
		if defined l (
			set /a y=%%a*16+48
			set c=!l:~,1!
			set "l=!l:~1! "
			if "!c!" == "$" (
				set disp=!disp! "!l:"=""!*0*!y!*黑体*12*808080ff"
			) else if "!c!" == "@" (
				set disp=!disp! "!l:"=""!*0*!y!*黑体*12*0000ffff"
			) else (
				set disp=!disp! "!l:"=""!*0*!y!*黑体*12*000000ff"
			)
		)
	)
)
if exist "%cpath%\$getAerr" (
	set /p error=<"%cpath%\$getAerr"
	set disp=!disp! "!error!*240*300*黑体*14*0000ffff"
)

gdi "/T:!mtitle!" !disp!
endlocal

tmouse /d 0 1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000

if %x% geq 76 if %x% leq 77 (
	if %y% equ 4 set /a lp-=4&set last=
	if %y% equ 19 set /a lp+=4
)
if %y% geq 21 if %y% leq 24 start /b cmd /c "chat\group\send.bat"
goto mouse
