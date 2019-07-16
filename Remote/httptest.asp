<%
response.contenttype = "text/plain"
response.write "Get:" + request.querystring + vbcrlf
response.write "Post:" + request.form + vbcrlf
%>