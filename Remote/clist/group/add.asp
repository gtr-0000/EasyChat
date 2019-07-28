<!--#include file="../../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim uname

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey错误"
else
	dim gname, rs, gid
	gname = request.querystring("name")
	set rs = dbexecf("select * from glist where name = %s", array(gname))
	if rs.eof then
		rs.close
		response.write "2 找不到该聊天室"
	else
		rs.close
		set rs = dbexecf("select * from clist where uname = %s and gname = %s", array(uname,gname))
		if not rs.eof then
			response.write "3 已加入该聊天室"
		else
			dbexecf "update glist set unum = unum + 1 where name = %s", array(gname)
			dbexecf "insert into clist values (%s,'group',%t,%s)", array(uname,now(),gname)
			response.write "0 加入成功"
		end if
		rs.close
	end if
end if

conn.close
%>