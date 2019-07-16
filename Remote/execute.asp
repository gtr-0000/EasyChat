<!--#include file="api/common.inc"-->
<%
dbinit

dim rs

on error resume next
select case lcase(trim(request.querystring("command")))
	case "list table"
	Set rs = conn.OpenSchema(20)

	case else
	set rs = dbexec(request.querystring("command"))
end select

if err then
	response.write "<font color='red'>" & XmlEncode(err.description) & "</font>"
	response.end
end if
on error goto 0

response.write rsfmth(rs, true)
%>