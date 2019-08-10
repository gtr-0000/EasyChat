<!--#include file="../../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey, uname

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey错误"
else
	dim rs, tname, cname, ctext
	tname = request.querystring("name")
	if uname < tname then
		cname = uname + vbcrlf + tname
	else
		cname = tname + vbcrlf + uname
	end if
	ctext = request.querystring("text")
	set rs = dbexecf("select * from ulist where name = %s",array(tname))
	if rs.eof then
		response.write "2 找不到该用户"
		rs.close
	else
		response.write "0 获取成功" & vbcrlf
		rs.close
		set rs = dbexecf("select id,uname,ctime,ctext from uchat where cname = %s", array(cname))
		response.write rsfmt(rs, false)
		rs.close
	end if
end if

conn.close
%>
