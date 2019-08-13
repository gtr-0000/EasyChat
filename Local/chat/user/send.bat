@echo off
2>>"%cpath%\@send.txt" (call :main 3>"%cpath%\#send.txt")
if not defined text exit /b
http get "%cpath%\$send.txt" "%server%/chat/user/send.asp" "apikey=%apikey%" "name=%cname:"=%" "text=%text:"=%"
exit /b

:main
cls
tcurs /crv 1 /pos 0 21
set text=
set /p text=
tcurs /crv 0
cls
