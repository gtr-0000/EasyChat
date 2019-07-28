<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim uname

apikey = request.querystring("apikey")
uname = apikey2uid(apikey)
if uname = "" then
	response.write "1 apikey错误"
else
	dim rs
	response.write "0 获取成功" & vbcrlf
	set rs = dbexecf("select itype,iname,itime from clist where uname = %s",array(uname))
	response.write rsfmt(rs, false)
	rs.close
end if

conn.close

'lmmmmyhmmmsmsm

%>