<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey, uname, rs

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey´íÎó"
else
	dbexecf "update ulist set ltime = %t, apikey = null where name = %s", Array(now(),uname)
	response.write "0 ÍË³öµÇÂ½"
end if

conn.close
%>