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
	dim rs, mode, name, msg
	mode = request.querystring("mode")
	name = request.querystring("name")
	msg = request.querystring("msg")
	select case lcase(mode)
		case "user"
		set rs = dbexecf("select * from users where name = %s",array(name))
		if rs.eof then
			response.write "2 用户不存在" & vbcrlf
		else
			dbexecf "insert into chat_user values (%d,%d,%t,%s)", array(id,rs("id"),now(),msg)
			response.write "0 发送成功" & vbcrlf
		end if

		case "group"
		set rs = dbexecf("select * from groups where name = %s",array(name))
		if rs.eof then
			response.write "2 聊天室不存在" & vbcrlf
		else
			dbexecf "insert into chat_group values (%d,%d,%t,%s)", array(id,rs("id"),now(),msg)
			response.write "0 发送成功" & vbcrlf
		end if

		case else
		response.write "2 模式不正确:应为'group'或'user'"
	end select
end if

conn.close

'lmmmmyhmmmsmsm

%>