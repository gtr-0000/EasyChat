<!-- #include file="conn.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�޸�</title>
<style type="text/css">
<!--
body,td,th {
 font-size: 14px;
}
-->
</style></head>
<center>
<body>
<br>
<%

set rsc=server.createobject("adodb.recordset")
sqlc="select * from info where username='"&session("username")&"' and password='"&session("password")&"'"
rsc.open sqlc,conn,1,1
nr=rsc("password")
username=rsc("username")
password=rsc("password")
sex=rsc("sex")
qq=rsc("qq")
mail=rsc("mail")
add=rsc("add")
personalinfo=rsc("personalinfo")
vv=rsc("ntime")
set rsc=nothing
if nr="" then
response.Redirect("index.asp")
end if
if strcomp(nr,request.Form("password"))=0 then
response.Write("��ӭ�㣡"&request.Form("username"))
response.Write("������"&vv&"ע���")
session("username")=request.Form("username")
end if
if session("username")="" then
response.Redirect("index.asp")
end if
%>
<form name="form1" method="post" action="change.asp?ac=ch">
<table width="39%" height="105" border="0" >
<tr>
<td width="27%" height="30">�û�����</td>
<td width="73%" height="30"><input name="username" type="text" id="username" value="<%=username%>">
*</td>
</tr>
<tr>
<td height="30">��  �룺</td>
<td height="30"><input name="password" type="text" id="password" value="<%=password%>">
*</td>
</tr>
<tr>
<td height="30">��  ��</td>
<td height="30"><input name="sex" type="text" id="sex" value="<%=sex%>"></td>
</tr>
<tr>
<td height="30">QQ��</td>
<td height="30"><input name="qq" type="text" id="qq" value="<%=qq%>"></td>
</tr>
<tr>
<td height="30">Mail��</td>
<td height="30"><input name="mail" type="text" id="mail" value="<%=mail%>"></td>
</tr>
<tr>
<td height="30">��  ַ��</td>
<td height="30"><input name="add" type="text" id="add" value="<%=add%>"></td>
</tr>
<tr>
<td>����</td>
<td><textarea name="personalinfo" cols="30" rows="6" id="personalinfo"><%=personalinfo%></textarea></td>
</tr>
<tr>
<td> </td>
<td><input type="submit" name="Submit" value="�޸�">
<a href="change.asp?se=y" target="_self">�˳�ϵͳ</a></td>
  <% if strcomp(request.QueryString("se"),"y")=0 then
  session("username")=""
  response.Redirect("index.asp")
  end if
  %>
</tr>
</table>
</form>
<%
if strcomp(request.QueryString("ac"),"ch")=0 then
set rs=server.createobject("adodb.recordset")
sql="select * from info where username='"&session("username")&"'"
rs.open sql,conn,1,3
rs("username")=request.Form("username")
rs("password")=request.Form("password")
rs("mail")=request.Form("mail")
rs("sex")=request.Form("sex")
rs("qq")=request.Form("qq")
rs("add")=request.Form("add")
rs("personalinfo")=request.Form("personalinfo")
rs.update
set rs=nothing
response.Write("�޸���ɣ�")
end if
%>
</body>
</center>
</html>