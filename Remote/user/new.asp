<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim name, pass

name = request.querystring("name")
pass = request.querystring("pass")

if len(name)<1 or len(name)>16 then
	response.write "1 用户名长度应为1到16之间"
else
	dim nameok
	nameok = true
	if name <> trim(name) then nameok = false
	if instr(1,name,vbtab,1) > 0 then nameok = false
	if instr(1,name,"*",1) > 0 then nameok = false
	if instr(1,name,chr(10),1) > 0 then nameok = false
	if instr(1,name,chr(13),1) > 0 then nameok = false
	if instr(1,name,chr(0),1) > 0 then nameok = false
	if not nameok then
		response.write "1 用户名有特殊字符"
	else
		dim rs
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
end if

conn.close
%>
