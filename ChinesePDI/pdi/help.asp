<%@ Language=VBScript %>
<% Response.Buffer = TRUE %>
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = Request("pageID")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
	<title>Help</title>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312" />
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
</head>
<body onLoad="self.focus()">
	<div align="center">
	<table border="0" cellspacing="0" cellpadding="6" width="95%">
		<tr>
			<td valign="top">
<%
Select Case pageID
	Case "register"
		Response.Write "<br><br>����дҪ�����Ŀ��Ȼ����ע����Լ����嵥��DISC���������κ�ʱ�򶼿��Ա༭��Ϣ��" & VbCrLf
	Case "contact"
		Response.Write "<br><br>������Ե������䣬�绰�������ʼ���˿ͷ�����ϵ�����˻ؼ��ص�ǰһҳ��" & VbCrLf
	Case "startPage"
		Response.Write "<br><br>���˻ؼ��ص�ǰһҳ��" & VbCrLf
	Case "question1"
		Response.Write "<br>�����������һ�������У�ѡ��һ�������ܡ���������֣�����һ������ܡ���������֡�" & VbCrLf
		Response.Write "<br><br>��ס�� ��������Լ����ڹ����Ļ����У�������ĵ�һֱ���ߡ�" & VbCrLf
		Response.Write "<br><br>���һҳ�󣬵�����Ͻǵ���һ������������" & VbCrLf
		Response.Write "<br><br>���˻ؼ��ص�ǰһҳ��" & VbCrLf
	Case "question2"
		Response.Write "<br><br>�����������һ�������У�ѡ��һ�������ܡ���������֣�����һ������ܡ���������֡�" & VbCrLf
		Response.Write "<br><br>��ס�� ��������Լ����ڹ����Ļ����У�������ĵ�һֱ���ߡ�" & VbCrLf
		Response.Write "<br><br>���һҳ�󣬵�����Ͻǵ���һ������������" & VbCrLf
		Response.Write "<br><br>���˻ؼ��ص�ǰһҳ��" & VbCrLf
	Case "question3"
		Response.Write "<br><br>�����������һ�������У�ѡ��һ�������ܡ���������֣�����һ������ܡ���������֡�" & VbCrLf
		Response.Write "<br><br>��ס����������Լ����ڹ����Ļ����У�������ĵ�һֱ���ߡ�" & VbCrLf
		Response.Write "<br><br>���һҳ�󣬵�����Ͻǵ���һ������������" & VbCrLf
		Response.Write "<br><br>���˻ؼ��ص�ǰһҳ��" & VbCrLf
	Case "question4"
		Response.Write "<br><br>�����������һ�������У� ѡ��һ�������ܡ���������֣�����һ������ܡ���������֡�" & VbCrLf
		Response.Write "<br><br>��ס����������Լ����ڹ����Ļ����У�������ĵ�һֱ���ߡ�" & VbCrLf
		Response.Write "<br><br>���һҳ�󣬵�����Ͻǵ���һ������������" & VbCrLf
		Response.Write "<br><br>���˻ؼ��ص�ǰһҳ��" & VbCrLf
	Case "quit"
		Response.Write "<br><br>����һҳ�������ѡ��" & VbCrLf
		Response.Write "<br><br>1�� �鿴����ӡ��ĸ��Լ����嵥?�Ľ����" & VbCrLf
		Response.Write "<br><br>2�� ����һ�����Ƶġ��ڽ���Ļ��������������ʹ�ñ��档��Щ���潫���������������ص�Ӧ�õ��쵼��������������������ۡ��Լ�ʱ������÷�������������õ��������Ϣ�������ϣ�������ı������Ŀ��" & VbCrLf
		Response.Write "<br><br>3�� �鿴����ӡһ�����Ƶġ����Ѿ������˵�ʹ�ñ��档" & VbCrLf
		Response.Write "<br><br>�ü�ͷ�����岽���˻ص�ǰһҳ���ñ�ҳ���Ĳ˵��˻ص����˵�����������ϵ�������˳���" & VbCrLf
End Select
%>

<p>
	<em>
		��Ҫ���������������ϵ��
	</em>
</p>
			</td>
		</tr>
		<tr>
			<td valign="top" align="center"><a href="javascript:window.close()"><img src="images/closeWindow.gif" border="0" width="95" height="18" alt=""></a></td>
		</tr>
	</table>
	</div>
</body>
</html>
