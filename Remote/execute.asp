<!--#include file="api/common.inc"-->
<%
response.contenttype = "text/plain"

dbinit

dim rs

on error resume next
set rs = dbexec(request.querystring("command"))
if err then
	response.write err.description
	response.end
end if
on error goto 0

response.write rsfmt(rs, true)
%>