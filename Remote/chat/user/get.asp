<!--#include file="../../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim umane

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey����"
else
	dim rs, tname
	tname = request.querystring("name")
	set rs = dbexecf("select * from ulist where name = %s",array(tname))
	if rs.eof then
		response.write "2 �Ҳ������û�"
		rs.close
	else
		response.write "0 ��ȡ�ɹ�" & vbcrlf
		rs.close
		set rs = dbexecf("select uname,ctime,ctext from gchat where uname = %s and tname = %s or tname = %s and uname = %s", array(uname, tname, umane, tname))
		response.write rsfmt(rs, false)
		rs.close
	end if
end if

conn.close
%>