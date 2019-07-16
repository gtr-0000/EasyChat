<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey
dim id

apikey = request.querystring("apikey")
id = apikey2uid(apikey)
if id = 0 then
	response.write "1 apikey´íÎó"
else
	dbexecf "update users set logt = %t, apikey = null where id = %d", Array(now(),id)
	response.write "0 ÍË³öµÇÂ½"
end if

conn.close
%>