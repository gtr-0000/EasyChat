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
	dim name, rs
	name = trim(replace(replace(replace(request.querystring("name"),vbtab,""),chr(10),""),chr(13),""))
	if len(name)<1 or len(name)>32 then
		response.write "2 �����������Ȳ���ȷ"
	else
		set rs = dbexecf("select * from groups where name = %s", Array(name))
		if not rs.eof then
			rs.close
			response.write "2 ���������ѱ�ʹ��"
		else
			rs.close
			dbexecf "insert into groups (name,regt,unum) values (%s,%t,1)", array(name,now())
			set rs = dbexecf("select * from groups where name = %s", array(name))
			dbexecf "insert into user_group values (%d,%d)", array(id,rs("id"))
			rs.close
			response.write "0 �����ɹ�"
		end if
	end if
end if

conn.close
%>