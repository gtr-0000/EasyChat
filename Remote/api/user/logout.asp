<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey
dim rs

set rs = dbexecf("select * from users where apikey = %s", Array(apikey))
if rs.eof then
	rs.close
	response.write "1 apikey����"
else
	rs.close
	set rs = dbexecf("update users set logt = %t, apikey = %s where name = %s and pass = %s", Array(now(),apikey,name,pass))
	response.write "0 �˳���½"
end if

conn.close
%>