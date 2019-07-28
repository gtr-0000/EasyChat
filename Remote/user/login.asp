<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim name, pass
dim rs, apikey, i

name = request.querystring("name")
pass = request.querystring("pass")

set rs = dbexecf("select * from ulist where name = %s and pass = %s", array(name,pass))
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
	set rs = dbexecf("update ulist set ltime = %t, apikey = %s where name = %s and pass = %s", array(now(),apikey,name,pass))
	response.write "0 " & apikey
end if

conn.close
%>