:: wrapline <输入文件> <列数>
setlocal enabledelayedexpansion
for /f %%a in ('find /c /v "" ^<"%~f1"') do set #FN=%%a
<"%~f1" (
	for /l %%f in (1,1,!#FN!) do (
		set #F=
		set /p #F=
		if defined #F (
			set #P=!#F:~,1!
			set #F=!#F:~1!
			set $=!#F!.
			set #L=0
			for %%a in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
				if not "!$:~%%a,1!"=="" (
					set /a #L+=%%a
					set $=!$:~%%a!
				)
			)
			set /a #L-=1
			set "#S=`1234567890-=[]\;',./~^^^!@#$%%^^&*()_+{}|:""<>?qwertyuiopasdfghjklzxcvbnm "
			set P=
			set L=
			for /l %%a in (0,1,!#L!) do (
				set "C=!#F:~%%a,1!"
				if "!C!"=="*" set C=﹡
				if "!C!"=="	" set "C= "
				set W=2
				for /l %%b in (0,1,70) do (
					if /i "!C!"=="!#S:~%%b,1!" set W=1
				)
				set /a L+=W
				if !L! gtr %2 (
					echo:!#P!!P!
					set L=!W!
					set P=!C!
				) else (
					set "P=!P!!C!"
				)
			)
			echo:!#P!!P!
		)
	)
)
goto :eof
