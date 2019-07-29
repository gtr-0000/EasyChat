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
	dim iname, rs
	iname = request.querystring("name")
	set rs = dbexecf("select * from ulist where name = %s", array(iname))
	if rs.eof then
		rs.close
		response.write "2 找不到该用户"
	else
		rs.close
		set rs = dbexecf("select * from clist where uname = %s and itype = 'user' and iname = %s", array(uname,iname))
		if not rs.eof then
			response.write "3 已加入该用户"
		else
			dbexecf "insert into clist values (%s,'user',%s,%t)", array(uname,iname,now())
			response.write "0 添加成功"
		end if
		rs.close
	end if
end if

conn.close
%>