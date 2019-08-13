if not exist "save" md "save"
if not exist "save\list.txt" break > "save\list.txt"
set upath=
for /f "usebackq tokens=1,2 delims=	" %%a in ("save\list.txt") do (
	if "%%b"=="%uname%" (
		set "upath=save\%%~a"
	)
)
if defined upath exit /b
for /l %%a in (9999,-1,1) do (
	if not exist "save\%%a" (
		set "upath=%%~a"
	)
)
(echo "%upath%"	%uname%)>>"save\list.txt"
set "upath=save\%upath%"
md "%upath%"
