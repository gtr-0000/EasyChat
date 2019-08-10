:init
cls
timage "list\get.bmp" 0 0

:mouse
tcurs /crv 0
timage "list\get.bmp" 0 0 /transparentblt
tmouse /d 0 1 1
if %errorlevel% lss 0 goto mouse
set /a y=%errorlevel%,x=y/1000,y=y%%1000
title %x% %y%
if %y% equ 1 (
	if %x% geq 2 if %x% leq 3 goto menu
	if %x% geq 76 if %x% leq 77 goto add
)
;;;
goto mouse

:menu
timage "list\get.menu.bmp"
