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
	dim pass, pold
	dim rs
	pold = request.querystring("pold")
	pass = request.querystring("pass")
	set rs = dbexecf("select * from users where id = %d and pass = %s", array(id,pold))
	if rs.eof then
		rs.close
		response.write "1 �������"
	else
		rs.close
		if len(pass)<1 or len(pass)>32 then
			response.write "2 ���볤�Ȳ���ȷ"
		else
			set rs = dbexecf("update users set pass = %s where id = %d", array(pass,id))
			response.write "0 �޸ĳɹ�"
		end if
	end if
end if

conn.close
%>