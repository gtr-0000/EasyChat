<!--#include file="../../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim uname

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey����"
else
	dim rs, gname, ctext
	gname = request.querystring("name")
	ctext = request.querystring("text")
	set rs = dbexecf("select * from glist where name = %s",array(gname))
	if rs.eof then
		response.write "2 �Ҳ�����������" & vbcrlf
	else
		dbexecf "insert into gchat values (%s,%s,%t,%s)", array(uname,gname,now(),ctext)
		response.write "0 ���ͳɹ�" & vbcrlf
	end if
end if

conn.close
%>