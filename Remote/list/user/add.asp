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
	set rs = dbexecf("select * from ulist where name = %s", array(iname))
	if rs.eof then
		rs.close
		response.write "2 �Ҳ������û�"
	else
		rs.close
		set rs = dbexecf("select * from clist where uname = %s and itype = 'user' and iname = %s", array(uname,iname))
		if not rs.eof then
			response.write "3 �Ѽ�����û�"
		else
			dbexecf "insert into clist values (%s,'user',%s,%t)", array(uname,iname,now())
			response.write "0 ��ӳɹ�"
		end if
		rs.close
	end if
end if

conn.close
%>