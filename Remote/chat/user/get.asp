<!--#include file="../../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey, uname, cid

apikey = request.querystring("apikey")
cid = request.querystring("cid")
uname = apikey2name(apikey)

if uname = "" then
	response.write "1 apikey����"
else
	dim rs, tname, cname, ctext
	tname = request.querystring("name")
	if uname < tname then
		cname = uname + vbcrlf + tname
	else
		cname = tname + vbcrlf + uname
	end if
	ctext = request.querystring("text")
	set rs = dbexecf("select * from ulist where name = %s",array(tname))
	if rs.eof then
		response.write "2 �Ҳ������û�"
		rs.close
	else
		response.write "0 ��ȡ�ɹ�" & vbcrlf
		rs.close
		set rs = dbexecf("select id,uname,ctime,ctext from uchat where cname = %s and id > %d", array(cname, cid))
		response.write rsfmt(rs, false)
		rs.close
	end if
end if

conn.close
%>
