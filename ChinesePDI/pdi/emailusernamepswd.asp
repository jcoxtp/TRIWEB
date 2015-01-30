<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "forgot" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>DISC Profile System | Forgot Your Password?</title>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312" />
	<link rel="stylesheet" href="/pdi/_system.css" type="text/css"><!-- system stylesheet must come before the reseller stylesheet -->
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/reseller.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>

<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="maincontent">
	<%
	Dim strHost
	Dim Mail

	'*****************************************************************************************
	'* Created By: David Brackin
	'* Creation Date: Wednesday, May 29, 2002  09:07:35
	'* Purpose: This ASP page calls the stored procedure sel_UserInfo_EmailAddr using ADO.
	'*****************************************************************************************

	on error resume next
	Dim bSubmitted
	bSubmitted = Request.Form("txtSubmit")
	Dim bFilledOutProperly, strErrMsg
	Dim EmailAddress

	bFilledOutProperly = FALSE
	bSubmitted = TRIM(bSubmitted)
	
	If bSubmitted <> "" Then
		  EmailAddress = Request.Form("txtEmailAddress")
	elseif Request.QueryString("Eml") <> "" then
		EmailAddress = Request.QueryString("Eml")
		bSubmitted = 1 
	End If
	
	EmailAddress = Trim(EmailAddress)
	If bSubmitted <> "" Then
		  If EmailAddress = "" then 
				 strErrMsg = "请键入一个<strong>“电子信箱地址”</strong>值。"
		  Else
				 bFilledOutProperly = TRUE
		  End If
	End If
	
	If bSubmitted <> "" AND bFilledOutProperly Then
		Dim oConn
		Dim oCmd
		Dim oRs
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			  .CommandText = "sel_UserInfo_EmailAddr"
			  .CommandType = 4
			  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			  .Parameters.Append .CreateParameter("@EmailAddress",200, 1,100, EmailAddress)
		End With
	
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
	
		If oConn.Errors.Count < 1 then
			if oRs.EOF = TRUE then
				' [SM] Commented out the line below and added the line underneath it
				'Response.Write "<br><br><span class='titletext'>Your email address was not found. Please check your entry and try again.</span><br><br>"
				strErrMsg = "Your email address was not found. Please check your entry and try again."
			else
				' send the user the email that contains the user name and password
				Dim JMail
				Set JMail = Server.CreateObject("JMail.SMTPMail") 
				JMail.ServerAddress = "www.pdiprofile.com:25" ' change this to your mail server
				JMail.Sender = "support@pdiprofile.com" 'here type in your email address
				JMail.SenderName = "Team Resources, Inc."
				JMail.Subject = "Login Information for PDI Website" 
				JMail.AddRecipient(Cstr(EmailAddress)) 'here type in your email address again
				' [SM] Commented out the line below and added the line underneath it
				'JMail.HTMLBody = "Here is your login information for <a href='http://www.pdiprofile.com'>www.pdiprofile.com</a><br><br>UserName:" & oRs("UserName") & "<br><br>Password:" & oRs("Password")
				JMail.Body = "下面是你的个性鉴别清单网站进入的信息：" & vbcrlf & vbcrlf & "用户姓名：" & oRs("UserName") & vbcrlf & "密码：" & oRs("Password") & vbcrlf & vbcrlf & "你可以使用下列互联网址，进入网站：" & vbcrlf & "http://www.pdiprofile.com/pdi/login.asp" & vbcrlf & vbcrlf & vbcrlf & "致敬" & vbcrlf & vbcrlf & vbcrlf & "Team Resources, Inc."
				JMail.Priority = 3
				JMail.Execute
	
				' [SM] Added following line and modified the line underneath it
				Response.Write "<h2>谢谢！</h2>" & vbcrlf & vbcrlf
				Response.Write "<p>你的用户姓名和密码已经发送到你的电子信箱地址。</p>" & vbcrlf & vbcrlf
				Response.Write "<p>你找回你的用户信息后，请进入网站 <a href='login.asp?st=" & Site & "'>www.pdiprofile.com</a>.</p>"
	
				Set oConn = Nothing
				Set oCmd = Nothing
				Set oRs = Nothing
				Response.End
			end if
		else
			  strErrMsg = Err.description
			  Err.Clear
		End If
	End If
	' [SM] I disabled the following lines and added a modified version below

	'If strErrMsg <> "" Then
		  'Response.Write "<br>"
		  'Response.Write strErrMsg
		  'Response.Write "<br><br>"
	'End If
	%>

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr>
			<td valign="top"><h1>忘了你的用户姓名或密码？</h1>
			</td>

			<td valign="top" align="right"><!--#INCLUDE FILE="include/back_link.asp" -->
			</td>
		</tr>
	</table>

	<p>请输入你注册时提供的电子信箱地址，你的用户信息将发送给你。</p>

	<form name="thisForm" id="thisForm" method="post" action="emailusernamepswd.asp?res=<%=intResellerID%>">
	<input type="hidden" name="txtSubmit" id="txtSubmit" value="1">
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">

		<tr>
			<td valign="middle">&nbsp;</td>
			<td valign="middle">
				<% If strErrMsg <> "" Then
					Response.Write "<span class=""errortext"">" & strErrMsg & "</span>"
				Else
					Response.Write "&nbsp;"
				End If %>
			</td>
		</tr>
		<tr>
			<td valign="middle" align="right" width="25%"><strong>电子信箱地址： </strong></td>
			<td valign="middle" width="75%"><input type="text" name="txtEmailAddress" id="txtEmailAddress" maxlength="100" Size="50" value="<%=EmailAddress%>"></td>
		</tr>
		<tr> 
			<td valign="middle" align="center" colspan="2"><input type="submit" border="0" name="Add" id="Add" value="输入"></td>
		</tr>
			
	</table>
	</form>

</div>
</body>
</html>
