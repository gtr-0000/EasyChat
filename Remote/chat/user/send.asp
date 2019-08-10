<!--#include file="../../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim apikey, uname

apikey = request.querystring("apikey")
uname = apikey2name(apikey)
if uname = "" then
	response.write "1 apikey错误"
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
		rs.close
		response.write "2 找不到该用户" & vbcrlf
	else
		rs.close
		dbexecf "insert into uchat (uname,cname,ctime,ctext) values (%s,%s,%t,%s)", array(uname,cname,now(),ctext)
		set rs = dbexecf("select * from clist where uname = %s and itype = 'user' and iname = %s", array(tname,uname))
		if rs.eof then
			dbexecf "insert into clist values (%s,'user',%s,null)", array(tname,uname)
		end if
		dbexecf "update clist set itime = %t where uname = %s and itype = 'user' and iname = %s", array(now(),tname,uname)
		dbexecf "update clist set itime = %t where uname = %s and itype = 'user' and iname = %s", array(now(),uname,tname)
		response.write "0 发送成功" & vbcrlf
	end if
end if

conn.close
%>
