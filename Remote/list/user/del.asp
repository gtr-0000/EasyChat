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
	dim iname, rs
	iname = request.querystring("name")
	set rs = dbexecf("select * from clist where uname = %s and itype = 'user' and iname = %s", array(uname,iname))
	if rs.eof then
		response.write "3 δ��Ӹ��û�"
	else
		dbexecf "delete from clist where uname = %s and itype = 'user' and iname = %s", array(uname,iname)
		response.write "0 ����ɹ�"
	end if
	rs.close
end if

conn.close
%>