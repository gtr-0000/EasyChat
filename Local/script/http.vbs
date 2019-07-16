if wscript.arguments.count < 3 then
	wscript.echo "用法: http {Get|Post} {path} {URL} [key1=value1 [key2=value2 ...]]"
	wscript.quit 0
end if

dim xhr, ado
dim method, path, url, param, i, j

path = wscript.arguments(1)
url = wscript.arguments(2)

if url = replace(url, "://", "") then url = "http://" & url

if wscript.arguments.count > 3 then
	i = 3
	while i < wscript.arguments.count
		j = split(wscript.arguments(i),"=",2)
		if i <> 3 then param = param & "&"
		param = param & URLEncode(j(0))
		if ubound(j) = 1 then param = param & "=" & URLEncode(j(1))
		i = i + 1
	wend
else
	param = ""
end if

set xhr = createobject("msxml2.xmlhttp")
set ado = createobject("adodb.stream")

on error resume next

select case lcase(wscript.arguments(0))
	case "get"
	xhr.open "Get", url & "?" & param, false
	xhr.send

	case "post"
	xhr.open "Post", url, false
	xhr.setrequestheader "Content-Type", "application/x-www-form-urlencoded"
	xhr.send param

	case else
	wscript.echo "用法: http {Get|Post} {URL} [key1=value1 [key2=value2 ...]]"
	wscript.quit 0
end select

if err then
	wscript.echo err.description
	wscript.quit err.number
elseif xhr.status < 200 or xhr.status > 299 then
	wscript.echo xhr.statustext
	wscript.quit xhr.status
else
	ado.mode = 3
	ado.type = 1
	ado.open
	ado.write xhr.responsebody
	ado.savetofile path, 2
	if err then
		wscript.echo err.description
		wscript.quit err.number
	end if
	ado.close
end if

on error goto 0

Function URLEncode(strURL)
    Dim I
    Dim tempStr
    For I = 1 To Len(strURL)
        If Asc(Mid(strURL, I, 1)) < 0 Then
            tempStr = "%" & Right(CStr(Hex(Asc(Mid(strURL, I, 1)))), 2)
            tempStr = "%" & Left(CStr(Hex(Asc(Mid(strURL, I, 1)))), Len(CStr(Hex(Asc(Mid(strURL, I, 1))))) - 2) & tempStr
            URLEncode = URLEncode & tempStr
        ElseIf (Asc(Mid(strURL, I, 1)) >= 65 And Asc(Mid(strURL, I, 1)) <= 90) Or (Asc(Mid(strURL, I, 1)) >= 97 And Asc(Mid(strURL, I, 1)) <= 122) Or (Asc(Mid(strURL, I, 1)) >= 48 And Asc(Mid(strURL, I, 1)) <= 57) Then
            URLEncode = URLEncode & Mid(strURL, I, 1)
        Else
            URLEncode = URLEncode & "%" & Hex(Asc(Mid(strURL, I, 1)))
        End If
    Next
End Function
