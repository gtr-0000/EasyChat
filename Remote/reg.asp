<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�û�ע��</title>
<style type="text/css">
<!--
body,td,th {
 font-family: ����;
 font-size: 14px;
}
-->
</style>
</head>
<body>
<center>
�û�ע��<br>
<%
=request.QueryString("msg")
%>
<form name="form1" method="post" action="addnewdata.asp?ac=adduser">
<table width="39%" height="105" border="0" >
<tr>
<td width="27%" height="30">�û�����</td>
<td width="73%" height="30"><input name="username" type="text" id="username">
*</td>
</tr>
<tr>
<td height="30">���룺</td>
<td height="30"><input name="password" type="password" id="password">
*</td>
</tr>
<tr>
<td height="30">ȷ�����룺</td>
<td height="30"><input name="password2" type="password" id="password2">
*</td>
</tr>
<tr>
<td height="30">�Ա�</td>
<td height="30"><input name="sex" type="text" id="sex"></td>
</tr>
<tr>
<td height="30">QQ��</td>
<td height="30"><input name="qq" type="text" id="qq"></td>
</tr>
<tr>
<td height="30">Mail��</td>
<td height="30"><input name="mail" type="text" id="mail"></td>
</tr>
<tr>
<td height="30">��ַ��</td>
<td height="30"><input name="add" type="text" id="add"></td>
</tr>
<tr>
<td>���˽���</td>
<td><textarea name="personalinfo" cols="30" rows="6" id="personalinfo"></textarea></td>
</tr>
<tr>
<td> </td>
<td><input type="submit" name="Submit" value="�ύ"></td>
</tr>
</table>
</form>
</center>
</body>
</html>