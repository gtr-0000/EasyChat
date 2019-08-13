<!--#include file="../../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey, uname, cid

apikey = request.querystring("apikey")
cid = request.querystring("cid")
uname = apikey2name(apikey)

if uname = "" then
	response.write "1 apikey错误"
else
	dim rs, gname
	gname = request.querystring("name")
	set rs = dbexecf("select * from glist where name = %s",array(gname))
	if rs.eof then
		response.write "2 找不到该聊天室"
		rs.close
	else
		response.write "0 获取成功" & vbcrlf
		rs.close
		set rs = dbexecf("select id,uname,ctime,ctext from gchat where gname = %s and id > %d", array(gname, cid))
		response.write rsfmt(rs, false)
		rs.close
	end if
end if

conn.close
%>
