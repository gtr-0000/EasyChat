<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim name, pass
dim rs

name = trim(replace(replace(replace(request.querystring("name"),vbtab,""),chr(10),""),chr(13),""))
pass = request.querystring("pass")

if len(name)<1 or len(name)>32 then
	response.write "1 �û������Ȳ���ȷ"
else
	set rs = dbexecf("select * from ulist where name = %s", array(name))
	if not rs.eof then
		rs.close
		response.write "1 �û����ѱ�ʹ��"
	else
		rs.close
		if len(pass)<1 or len(pass)>32 then
			response.write "2 ���볤�Ȳ���ȷ"
		else
			set rs = dbexecf("insert into ulist values (%s,%s,%t,null,null)", array(name,pass,now()))
			response.write "0 ע��ɹ�"
		end if
	end if
end if

conn.close
%>