<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim id

apikey = request.querystring("apikey")
id = apikey2uid(apikey)
if id = 0 then
	response.write "1 apikey错误"
else
	dim name, rs, rs2
	name = trim(replace(replace(replace(request.querystring("name"),vbtab,""),chr(10),""),chr(13),""))
	set rs = dbexecf("select * from groups where name = %s", Array(name))
	if rs.eof then
		response.write "2 找不到该聊天室"
	else
		set rs2 = dbexecf("select * from user_group where userid = %d and groupid = %d", array(id,rs("id")))
		if not rs2.eof then
			response.write "3 已加入该聊天室"
		else
			dbexecf "insert into user_group values (%d,%d)", array(id,rs("id"))
			response.write "0 添加成功"
		end if
		rs2.close
	end if
	rs.close
end if

conn.close
%>