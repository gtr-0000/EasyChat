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
	dim rs, gname, ctext
	gname = request.querystring("name")
	ctext = request.querystring("text")
	set rs = dbexecf("select * from glist where name = %s",array(gname))
	if rs.eof then
		response.write "2 找不到该聊天室" & vbcrlf
	else
		dbexecf "insert into gchat (uname,gname,ctime,ctext) values (%s,%s,%t,%s)", array(uname,gname,now(),ctext)
		dbexecf "update clist set itime = %t where itype = 'group' and iname = %s", array(now(),gname)
		response.write "0 发送成功" & vbcrlf
	end if
end if

conn.close
%>