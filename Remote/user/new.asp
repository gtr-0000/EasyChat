<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim name, pass
dim rs

name = trim(replace(replace(replace(request.querystring("name"),vbtab,""),chr(10),""),chr(13),""))
pass = request.querystring("pass")

if len(name)<1 or len(name)>32 then
	response.write "1 用户名长度不正确"
else
	set rs = dbexecf("select * from ulist where name = %s", array(name))
	if not rs.eof then
		rs.close
		response.write "1 用户名已被使用"
	else
		rs.close
		if len(pass)<1 or len(pass)>32 then
			response.write "2 密码长度不正确"
		else
			set rs = dbexecf("insert into ulist values (%s,%s,%t,null,null)", array(name,pass,now()))
			response.write "0 注册成功"
		end if
	end if
end if

conn.close
%>