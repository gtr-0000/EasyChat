<%
dim conn

'dbinit 加载database到conn, 记得conn.close
'dbexecf 类似printf, %d数字, %s字符串, %t时间, 执行格式化后的sql并返回recordset
'rsfmt 格式化recordset

function dbinit
	set conn = server.createobject("adodb.connection")
	conn.open "Provider = Microsoft.Jet.OLEDB.4.0; Data Source = " & server.mappath("/EasyChat/database")
end function

function dbexec(byval command)
	set dbexec = conn.execute(command)
end function

function dbexecf(byval commfmt, byval argument)
	dim command, i, j
	i = 1
	j = 0
	while i <= len(commfmt)
		if mid(commfmt,i,1) = "%" then
			i = i + 1
			if j > ubound(argument) then
				err.raise 103,"dbexecf","参数太少"
			end if
			select case mid(commfmt,i,1)
				case "s"
				command = command & "'" & replace(argument(j), "'", "''") & "'"

				case "d"
				if isnumeric(argument(j)) then
					command = command & argument(j)
				else
					err.raise 102,"dbexecf","不是数字: " & argument(j)
					exit function
				end if
				on error goto 0

				case "t"
				if isdate(argument(j)) then
					command = command & "'" & argument(j) & "'"
				else
					err.raise 102,"dbexecf","不是时间: " & argument(j)
					exit function
				end if
				on error goto 0

				case "%"
				command = command & "%"

				case else
				err.raise 101,"dbexecf","格式错误: $" & mid(commfmt,i,1)
				exit function
			end select
			j = j + 1
		else
			command = command & mid(commfmt,i,1)
		end if
		i = i + 1
	wend

	set dbexecf = dbexec(command)
end function

function rsfmt(byval rs, byval optitle)
	dim str
	str = ""
	if rs.fields.count > 0 then
		if opTitle then
			for i = 0 to rs.fields.count - 1
				str = str & rs.fields(i).name & vbtab
			next
			str = str & vbcrlf
		end if

		while not rs.eof
			for i = 0 to rs.fields.count - 1
				str = str & cstr(rs.fields(i).value) & vbtab
			next
			str = str & vbcrlf
			rs.movenext
		wend
	end if
	rsfmt = str
end function
%>