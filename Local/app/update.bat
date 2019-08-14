http get "$version.txt" "%server%/app/version.asp"
if not exist "$version.txt" exit /b

<"$version.txt" (
	set /p newver=
	set /p newurl=
)

if "%newver%" neq "v0.5" goto new

mshta vbscript:msgbox("当前是最新版本",4096,"EasyChat")(window.close)
exit /b

:new
mshta vbscript:execute("createobject (""Scripting.FileSystemObject"").getStandardStream(1).Write(msgbox(""最新版本 %newver%, 是否更新?"",4096+1,""EasyChat""))(window.close)") > "$input.txt"
set /p return=<"$input.txt"
if "%return%" == "1" start "" "%newurl%"