if not exist "%upath%" md "%upath%"
if not exist "%upath%\list.txt" break > "%upath%\list.txt"
set cpath=
for /f "usebackq tokens=1,2 delims=	" %%a in ("%upath%\list.txt") do (
	if "%%~b"=="%~1%cname%" (
		set "cpath=%upath%\%%~a"
	)
)
if defined cpath exit /b
for /l %%a in (9999,-1,1) do (
	if not exist "%upath%\%%a" (
		set "cpath=%%~a"
	)
)
(echo "%cpath%"	"%~1%cname%")>>"%upath%\list.txt"
set "cpath=%upath%\%cpath%"
md "%cpath%"
