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
	dim gname, rs, gid
	gname = request.querystring("name")
	set rs = dbexecf("select * from clist where uname = %s and gname = %s", array(uname,gname))
	if rs.eof then
		response.write "3 δ�����������"
	else
		dbexecf "update glist set unum = unum - 1 where name = %s", array(gname)
		dbexecf "delete from clist where uname = %s and itype = 'group' and iname = %s", array(uname,gname)
		response.write "0 �˳��ɹ�"
	end if
	rs.close
end if

conn.close
%>