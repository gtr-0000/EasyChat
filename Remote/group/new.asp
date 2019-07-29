<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey, uname

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey错误"
else
	dim name, rs
	name = trim(replace(replace(replace(request.querystring("name"),vbtab,""),chr(10),""),chr(13),""))
	if len(name)<1 or len(name)>32 then
		response.write "2 聊天室名长度不正确"
	else
		set rs = dbexecf("select * from glist where name = %s", array(name))
		if not rs.eof then
			rs.close
			response.write "2 聊天室名已被使用"
		else
			rs.close
			dbexecf "insert into glist values (%s,%t,1)", array(name,now())
			dbexecf "insert into clist values (%s,'group',%s,%t)", array(uname,name,now())
			response.write "0 创建成功"
		end if
	end if
end if

conn.close
%>