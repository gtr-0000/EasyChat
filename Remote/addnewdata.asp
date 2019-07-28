<!-- #include file="conn.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>成功</title>
</head>
<body>
<%
ac=request.QueryString("ac")
msg="注册错误信息"
if request.Form("username")="" then
msg=msg&"<br>"&"用户名不能为空"
end if
if strcomp(cstr(request.Form("password")),cstr(request.Form("password2")))<>0 then
msg=msg&"<br>"&"两次密码输入不同"
end if

if len(request.Form("password"))<6 then
msg=msg&"<br>"&"密码太简单"
end if

if strcomp(msg,"注册错误信息")>0 then
response.Redirect("reg.asp?msg="&msg)
end if
if ac="adduser" then
set rsc=server.createobject("adodb.recordset")
sql="select * from info where username='"&request.Form("username")&"'"
rsc.open sql,conn,1,1
ck=rsc("username")
set rsc=nothing
if ck<>"" then
msg=msg&"<br>"&"用户名被人注册"
response.Redirect("reg.asp?msg="&msg)
end if
dsql="select * from info where id is null"
set rs=server.createobject("adodb.recordset")
rs.open dsql,conn,1,3
rs.addnew
rs("username")=request.Form("username")
rs("password")=request.Form("password")
rs("mail")=request.Form("mail")
rs("sex")=request.Form("sex")
rs("qq")=request.Form("qq")
rs("add")=request.Form("add")
rs("personalinfo")=request.Form("personalinfo")
rs("ntime")=now
rs.update
set rs=nothing
%>
<center>
<a href="index.asp" target="_self">注册成功,点击登陆</a>
</center>
<%
end if
%>
</body>
</html>