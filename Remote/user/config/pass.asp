<!--#include file="../../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey, uname

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey����"
else
	dim pass, pold
	dim rs
	pold = request.querystring("pold")
	pass = request.querystring("pass")
	set rs = dbexecf("select * from ulist where name = %s and pass = %s", array(uname,pold))
	if rs.eof then
		rs.close
		response.write "1 �������"
	else
		rs.close
		if len(pass)<1 or len(pass)>32 then
			response.write "2 ���볤�Ȳ���ȷ"
		else
			set rs = dbexecf("update ulist set pass = %s where name = %s", array(pass,uname))
			response.write "0 �޸ĳɹ�"
		end if
	end if
end if

conn.close
%>