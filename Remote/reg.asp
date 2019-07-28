<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>用户注册</title>
<style type="text/css">
<!--
body,td,th {
 font-family: 宋体;
 font-size: 14px;
}
-->
</style>
</head>
<body>
<center>
用户注册<br>
<%
=request.QueryString("msg")
%>
<form name="form1" method="post" action="addnewdata.asp?ac=adduser">
<table width="39%" height="105" border="0" >
<tr>
<td width="27%" height="30">用户名：</td>
<td width="73%" height="30"><input name="username" type="text" id="username">
*</td>
</tr>
<tr>
<td height="30">密码：</td>
<td height="30"><input name="password" type="password" id="password">
*</td>
</tr>
<tr>
<td height="30">确定密码：</td>
<td height="30"><input name="password2" type="password" id="password2">
*</td>
</tr>
<tr>
<td height="30">性别：</td>
<td height="30"><input name="sex" type="text" id="sex"></td>
</tr>
<tr>
<td height="30">QQ：</td>
<td height="30"><input name="qq" type="text" id="qq"></td>
</tr>
<tr>
<td height="30">Mail：</td>
<td height="30"><input name="mail" type="text" id="mail"></td>
</tr>
<tr>
<td height="30">地址：</td>
<td height="30"><input name="add" type="text" id="add"></td>
</tr>
<tr>
<td>个人介绍</td>
<td><textarea name="personalinfo" cols="30" rows="6" id="personalinfo"></textarea></td>
</tr>
<tr>
<td> </td>
<td><input type="submit" name="Submit" value="提交"></td>
</tr>
</table>
</form>
</center>
</body>
</html>