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
	dim rs, rs2, mode, name, uid, u2id, gid
	mode = request.querystring("mode")
	name = request.querystring("name")
	select case lcase(mode)
		case "user"
		set rs = dbexecf("select * from users where name = %s",array(name))
		if rs.eof then
			response.write "2 找不到该用户"
			rs.close
		else
			response.write "0 获取成功" & vbcrlf
			u2id = rs("id")
			rs.close
			set rs = dbexecf("select userid,msg from chat_user where (userid = %d and user2id = %d) or (userid = %d and user2id = %d)", array(id,u2id,u2id,id))
			while not rs.eof
				uid = rs("userid")
				set rs2 = dbexecf("select name from users where id = %d",array(uid))
				response.write rs2("name") & vbtab & rs("msg") & vbcrlf
				rs2.close
				rs.movenext
			wend
			rs.close
		end if

		case "group"
		set rs = dbexecf("select * from groups where name = %s",array(name))
		if rs.eof then
			response.write "2 找不到该聊天室"
			rs.close
		else
			response.write "0 获取成功" & vbcrlf
			gid = rs("id")
			rs.close
			set rs = dbexecf("select userid,msg from chat_group where groupid = %d", array(gid))
			while not rs.eof
				uid = rs("userid")
				set rs2 = dbexecf("select name from users where id = %d",array(uid))
				response.write rs2("name") & vbtab & rs("msg") & vbcrlf
				rs2.close
				rs.movenext
			wend
			rs.close
		end if

		case else
		response.write "2 模式不正确:应为'group'或'user'"
	end select
end if

conn.close
%>