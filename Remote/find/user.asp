<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey, uname

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey´íÎó"
else
	dim rs, find
	find = request.querystring("find")
	set rs = dbexecf("select name from ulist where name like %s",_
		array("%" & replace(replace(replace(find,"%","[%]"),"_","[_]"),"[","[[]") & "%") _
	)
	response.write "0 ²éÕÒ³É¹¦" & vbcrlf
	response.write rsfmt(rs, false)
	rs.close
end if

conn.close
%>
