<!-- #include file="conn.asp" -->
<%
'打开数据库判断用户是否存在,info为表名,username为字段名
set rsc=server.createobject("adodb.recordset")
sqlc="select * from info where username='"&request.Form("username")&"' and password='"&request.Form("password")&"'"
rsc.open sqlc,conn,1,1
session("username")=rsc("username")
session("password")=rsc("password")
session.Timeout=30
set rsc=nothing
response.Redirect("change.asp")
'如果用户不存在,session("username")为空
%>