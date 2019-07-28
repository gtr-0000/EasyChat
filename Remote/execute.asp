<!--#include file="common.asp"-->
<%
dbinit

dim rs

on error resume next

dim cmder
cmder = split(trim(request.querystring("command"))," ")

if ubound(cmder)>=0 then
	if lcase(cmder(0)) = "schema" then
		if ubound(cmder)>=1 then
			Set rs = conn.OpenSchema(Cint(cmder(1)))
		else
			err.raise 101,"execute","SCHEMA ×Ó¾äÓï·¨´íÎó¡£"
		end if
	else
		set rs = dbexec(request.querystring("command"))
	end if
else
	err.raise 100,"execute",""
end if

if err then
	response.write "<font color='red'>" & XmlEncode(err.description) & "</font>"
	response.end
end if
on error goto 0

response.write "<font style='font-family: ËÎÌå;'>" & rsfmth(rs, true) & "</font>"

conn.close
%>