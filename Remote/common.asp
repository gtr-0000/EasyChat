<%@CODEPAGE="936"%>
<%
option explicit

dim conn

'dbinit 加载database到conn, 记得conn.close
'dbexecf 类似printf, %d数字, %s字符串, %t时间, 执行格式化后的sql并返回recordset
'rsfmt 格式化recordset

function dbinit
	set conn = server.createobject("adodb.connection")
	conn.open "Provider = Microsoft.Jet.OLEDB.4.0; Data Source = " & server.mappath("/EasyChat/database")
end function

function dbexec(byval command)
	on error resume next
	set dbexec = conn.execute(command)
	if err then
		response.write command & vbcrlf & err.description
		on error goto 0
		response.end
	else
		on error goto 0
	end if
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
					command = command & "#" & argument(j) & "#"
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
	dim str, i
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
				if isnull(rs.fields(i).value) then
					str = str & "" & vbtab
				else
					str = str & cstr(rs.fields(i).value) & vbtab
				end if
			next
			str = left(str,len(str)-1)
			str = str & vbcrlf
			rs.movenext
		wend
	end if
	rsfmt = str
end function

function rsfmth(byval rs, byval optitle)
	dim str, i
	str = "<table border='1'>"
	if rs.fields.count > 0 then
		if opTitle then
			str = str & "<tr>"
			for i = 0 to rs.fields.count - 1
				str = str & "<th>" & xmlencode(rs.fields(i).name) & "</th>"
			next
			str = str & "</tr>"
		end if

		while not rs.eof
			str = str & "<tr>"
			for i = 0 to rs.fields.count - 1
				if isnull(rs.fields(i).value) then
					str = str & "<td><font color='gray'><i>NULL</i></font></td>"
				else
					str = str & "<td>" & xmlencode(cstr(rs.fields(i).value)) & "</td>"
				end if
			next
			str = str & "</tr>"
			rs.movenext
		wend
	end if
	rsfmth = str & "</table>"
end function

function apikey2name(apikey)
	set rs = dbexecf("select name from ulist where apikey = %s and ltime > %t", array(apikey,dateadd("n",-30,now())))
	if not rs.eof then
		apikey2name = rs("name")
		dbexecf "update ulist set ltime = %t where name = %s", array(now(),rs("name"))
	else
		apikey2name = ""
	end if
	rs.close
end function


Function XmlEncode(strText)
	Dim aryChars
	aryChars = Array(38, 60, 62, 34, 61, 39)
	Dim i
	For i = 0 To UBound(aryChars)
		strText = Replace(strText, Chr(aryChars(i)), "&#" & aryChars(i) & ";")
	Next
	strText = Replace(strText, Chr(32), "&nbsp;")
	strText = Replace(strText, Chr(9), "&nbsp;&nbsp;&nbsp;&nbsp;")
	strText = Replace(strText, chr(13)&chr(10) , "<br/>")
	strText = Replace(strText, Chr(10), "<br/>")
	strText = Replace(strText, Chr(13), "<br/>")
	XmlEncode = strText
End Function

%>