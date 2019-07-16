<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim name, pass
dim rs, apikey, i

name = trim(replace(replace(replace(request.querystring("name"),vbtab,""),chr(10),""),chr(13),""))
pass = request.querystring("pass")

set rs = dbexecf("select * from users where name = %s and pass = %s", Array(name,pass))
if rs.eof then
	rs.close
	response.write "1 用户名或密码错误"
else
	rs.close
	Randomize
	apikey = ""
	for i = 1 to 32: rnd(): next
	for i = 1 to 32
		apikey = apikey & chr(65 + int(rnd() * 26))
	next
	set rs = dbexecf("update users set logt = %t, apikey = %s where name = %s and pass = %s", Array(now(),apikey,name,pass))
	response.write "0 " & apikey
end if

conn.close
%>