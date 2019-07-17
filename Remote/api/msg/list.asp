<!--#include file="../common.asp"-->
<%
response.contenttype = "text/plain"

dbinit

dim id

apikey = request.querystring("apikey")
id = apikey2uid(apikey)
if id = 0 then
	response.write "1 apikey错误"
else
	dim rs, rs2, mode, u2id, gid
	mode = request.querystring("mode")
	select case lcase(mode)
		case "user"
		set rs = dbexecf("select * from user_user where userid = %d",array(id))
		while not rs.eof
			u2id = rs("user2id")
			set rs2 = dbexecf("select name from users where id = %d",array(u2id))
			response.write rs2("name") + vbcrlf
			rs2.close
			rs.movenext
		wend
		rs.close

		case "group"
		set rs = dbexecf("select * from user_group where userid = %d",array(id))
		while not rs.eof
			gid = rs("groupid")
			set rs2 = dbexecf("select name from groups where id = %d",array(gid))
			response.write rs2("name") + vbcrlf
			rs2.close
			rs.movenext
		wend
		rs.close

		case else
		response.write "2 模式不正确:应为'group'或'user'"
	end select
end if

conn.close

'lmmmmyhmmmsmsm

%>