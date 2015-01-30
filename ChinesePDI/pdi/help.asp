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
		Response.Write "<br><br>请填写要求的栏目，然后再注册个性鉴别清单（DISC）。你在任何时候都可以编辑信息。" & VbCrLf
	Case "contact"
		Response.Write "<br><br>你可以以电子信箱，电话，或者邮件与顾客服务部联系。按退回键回到前一页。" & VbCrLf
	Case "startPage"
		Response.Write "<br><br>按退回键回到前一页。" & VbCrLf
	Case "question1"
		Response.Write "<br>请从下列四字一组的组合中，选择一个“最能”描述你的字，还有一个“最不能”描述你的字。" & VbCrLf
		Response.Write "<br><br>记住， 想象把你自己放在工作的环境中，随着你的第一直觉走。" & VbCrLf
		Response.Write "<br><br>完成一页后，点击右上角的下一步键，继续。" & VbCrLf
		Response.Write "<br><br>按退回键回到前一页。" & VbCrLf
	Case "question2"
		Response.Write "<br><br>请从下列四字一组的组合中，选择一个“最能”描述你的字，还有一个“最不能”描述你的字。" & VbCrLf
		Response.Write "<br><br>记住， 想象把你自己放在工作的环境中，随着你的第一直觉走。" & VbCrLf
		Response.Write "<br><br>完成一页后，点击右上角的下一步键，继续。" & VbCrLf
		Response.Write "<br><br>按退回键回到前一页。" & VbCrLf
	Case "question3"
		Response.Write "<br><br>请从下列四字一组的组合中，选择一个“最能”描述你的字，还有一个“最不能”描述你的字。" & VbCrLf
		Response.Write "<br><br>记住，想象把你自己放在工作的环境中，随着你的第一直觉走。" & VbCrLf
		Response.Write "<br><br>完成一页后，点击右上角的下一步键，继续。" & VbCrLf
		Response.Write "<br><br>按退回键回到前一页。" & VbCrLf
	Case "question4"
		Response.Write "<br><br>请从下列四字一组的组合中， 选择一个“最能”描述你的字，还有一个“最不能”描述你的字。" & VbCrLf
		Response.Write "<br><br>记住，想象把你自己放在工作的环境中，随着你的第一直觉走。" & VbCrLf
		Response.Write "<br><br>完成一页后，点击右上角的下一步键，继续。" & VbCrLf
		Response.Write "<br><br>按退回键回到前一页。" & VbCrLf
	Case "quit"
		Response.Write "<br><br>在这一页，你可以选择：" & VbCrLf
		Response.Write "<br><br>1． 查看并打印你的个性鉴别清单?的结果。" & VbCrLf
		Response.Write "<br><br>2． 购买一份特制的、在结果的基础上有所扩充的使用报告。这些报告将帮助你把你的性情特点应用到领导、交流、集体合作、销售、以及时间的利用方面上来。若想得到更多的信息，点击你希望看到的报告的题目。" & VbCrLf
		Response.Write "<br><br>3． 查看并打印一份特制的、你已经购买了的使用报告。" & VbCrLf
		Response.Write "<br><br>用箭头“第五步”退回到前一页。用本页左侧的菜单退回到主菜单，与我们联系，或者退出。" & VbCrLf
End Select
%>

<p>
	<em>
		需要帮助，请跟我们联系。
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
