<!--#include file="api/common.asp"-->
<%
dbinit

dim rs

on error resume next

dim cmder
cmder = split(trim(request.querystring("command"))," ")
select case lcase(cmder(0))
	case "schema"
	Set rs = conn.OpenSchema(Cint(cmder(1)))

	case else
	set rs = dbexec(request.querystring("command"))
end select

if err then
	response.write "<font color='red'>" & XmlEncode(err.description) & "</font>"
	response.end
end if
on error goto 0

response.write "<font style='font-family: ����;'>" & rsfmth(rs, true) & "</font>"

conn.close
%>