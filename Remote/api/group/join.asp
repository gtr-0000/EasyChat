<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim id

apikey = request.querystring("apikey")
id = apikey2uid(apikey)
if id = 0 then
	response.write "1 apikey����"
else
	dim name, rs, gid
	name = trim(replace(replace(replace(request.querystring("name"),vbtab,""),chr(10),""),chr(13),""))
	set rs = dbexecf("select * from groups where name = %s", Array(name))
	if rs.eof then
		rs.close
		response.write "2 �Ҳ�����������"
	else
		gid = rs("id")
		rs.close
		set rs = dbexecf("select * from user_group where userid = %d and groupid = %d", array(id,gid))
		if not rs.eof then
			response.write "3 �Ѽ����������"
		else
			dbexecf "update groups set unum = unum + 1 where id = %d", array(gid)
			dbexecf "insert into user_group values (%d,%d)", array(id,gid)
			response.write "0 ����ɹ�"
		end if
		rs.close
	end if
end if

conn.close
%>