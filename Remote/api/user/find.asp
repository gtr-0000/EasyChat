<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

apikey = request.querystring("apikey")
id = apikey2uid(apikey)
if id = 0 then
	response.write "1 apikey´íÎó"
else

end if

conn.close
%>