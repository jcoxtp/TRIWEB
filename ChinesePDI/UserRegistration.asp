<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/common.asp" -->
<% pageID = "register" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8" />
		<title>DISC Profile System | Register</title>
		<link rel="stylesheet" href="_system.css" type="text/css">
		<!-- #INCLUDE FILE="include/head_stuff.asp" -->
	</head>
<body>
<!-- #INCLUDE FILE="include/top_banner.asp" -->
<!-- #INCLUDE FILE="include/left_navbar.asp" -->
<div id="maincontent">
<%
Response.Buffer = TRUE
On Error Resume Next

	'=========================================================================================
	' Initialize variables
	'=========================================================================================
		'Objects for database operations
		Dim oConn, oCmd
		
		'Pageflow related data
		Dim bFilledOutProperly : bFilledOutProperly = FALSE
		Dim bSubmitted	: bSubmitted = Request.Form ("txtSubmit")
		Dim strErrMsg
		Dim intErrorCode, strErrorMessage
		intErrorCode = 0
		strErrorMessage = NULL
		'System data (and everything else... mg)
		Dim nCount
	
		'Form Variables
		Dim UserName, Password, PasswordConfirm
		Dim FirstName, LastName, EmailAddress
		Dim CompanyName
		Dim Address1, Address2, City, ProvinceID, PostalCode
		Dim Position, Department, TeamName
		Dim GenderValue, AgeValue, EducationValue, OccupationValue, MgtRespValue
	
		'-- Include registration demographic data -----------------------------------
		'- for some reason all the demographic data was hard coded into the asp pages
		'- its still working for the most part so we are waiting to change this until 
		'- it can be incorporated into new feature requests : mg 2/16/2004
		%><!--#INCLUDE FILE="UserRegistration_demographic_data.asp" --><%

	'=========================================================================================
	'  Receive and validate incomming form data
	'=========================================================================================
		strErrMsg = ""
		If bSubmitted <> "" Then
			ResetCookies
			'-- User Info---------------------
			UserName = Request.Form("txtUserName") : UserName = Trim(UserName)
				If UserName = "" Then strErrMsg = strErrMsg & "请键入一个“选择用户姓名”值。<br>"
			Password = Request.Form("txtPassword") : Password = Trim(Password)
			PasswordConfirm = Request.Form("txtPasswordConfirm") : PasswordConfirm = Trim(PasswordConfirm)
				If Password = "" Then strErrMsg = "请键入一个“密码”值。<br>"
				If PasswordConfirm <> Password Then strErrMsg = strErrMsg &  "密码和重新输入的密码值不相符合。请再试。<br>"
				If Len(Password) < 6 Then strErrMsg = strErrMsg & "密码必须至少有6个字长短。<br>"
			FirstName = Request.Form("txtFirstName") : FirstName = Trim(FirstName)
				If FirstName = "" Then strErrMsg = strErrMsg & "请键入一个“名”值。<br>"
			LastName = Request.Form("txtLastName") : LastName = Trim(LastName)
				If LastName = "" Then strErrMsg = strErrMsg & "请键入一个“姓”值。<br>"
			EmailAddress = Request.Form("txtEmailAddress") : EmailAddress = Trim(EmailAddress)
			'	If EmailAddress = "" Then strErrMsg = strErrMsg & "请键入一个“电子信箱地址”值。<br>"
			'	If InStr(1,CStr(EmailAddress),"@",1) = 0 OR InStr(1,CStr(EmailAddress),".",1) = 0 Then strErrMsg = strErrMsg & "请键入一个恰当的电子信箱地址。"

			'-- Check for an error message ----------------
			If strErrMsg = "" Then
				bFilledOutProperly = TRUE
			End If
		End If

	'=========================================================================================
	'  If postback and the data is good - write to the database
	'=========================================================================================
	'Response.Write "exec spRegistrationInsertShort '" & UserName & "','" & Password & "','" & FirstName & "','" & LastName & "','" & EmailAddress & "'," & intResellerID & "," & UserID & "," & intErrorCode & ",'" & strErrorMessage & "'"
	'Response.End

		If bSubmitted <> "" AND bFilledOutProperly Then
			CompanyNameRet = ""
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			With oCmd
				.CommandText = "spRegistrationInsertShort"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
				'-- User Info---------------------
				.Parameters.Append .CreateParameter("@UserName", 200, 1, 50, UserName)
				.Parameters.Append .CreateParameter("@Password", 200, 1, 50, Password)
				.Parameters.Append .CreateParameter("@FirstName", 200, 1, 100, FirstName)
				.Parameters.Append .CreateParameter("@LastName", 200, 1, 100, LastName)
				.Parameters.Append .CreateParameter("@EmailAddress", 200, 1, 100, EmailAddress)
				'-- Other ---------------------
				.Parameters.Append .CreateParameter("@ResellerID", 3, 1, 4, cInt(intResellerID))
				'-- Returning Parameters ----------
				.Parameters.Append .CreateParameter("@UserID", 3, 3, 4, NULL)
				.Parameters.Append .CreateParameter("@intErrorCode", 3, 3, 4, NULL)
				.Parameters.Append .CreateParameter("@strErrorMessage", 200, 3, 255, NULL)
			End With
			oConn.Open strDBaseConnString
			oCmd.ActiveConnection = oConn
			oCmd.Execute , , 128
			intErrorCode = oCmd.Parameters("@intErrorCode").value
			If intErrorCode = 0 Then
				UserID = oCmd.Parameters("@UserID").value
				intErrorCode = oCmd.Parameters("@intErrorCode").value
				strErrorMessage = oCmd.Parameters("@strErrorMessage").value
				Response.Cookies("UserID") = UserID
				Response.Cookies("Login") = 1
				Response.Cookies("FirstName") = FirstName
				Response.Redirect("EnterTestCode.asp?res=" & intResellerID & "&uid=" & UserID)
			Else
				intErrorCode = oCmd.Parameters("@intErrorCode").value
				strErrorMessage = oCmd.Parameters("@strErrorMessage").value
				Select Case intErrorCode
				Case 96001
					strErrMsg = "键入的电子信箱地址本系统内已有用户注册。请再试。"
					Response.Write "<script language=""javascript"">"
					Response.Write "window.status = ""Username already exists (96001) - " & strErrorMessage & """;"
					Response.Write "</script>"
				Case 96002
					strErrMsg = "ERROR. Please contact the site administrator for assistance."
					Response.Write "<script language=""javascript"">"
					Response.Write "window.status = ""Error 96002 - " & strErrorMessage & """;"
					Response.Write "</script>"
				Case Else
					strErrMsg = "ERROR. Please contact the site administrator for assistance."
					Response.Write "<script language=""javascript"">"
					Response.Write "window.status = ""Error - " & strErrorMessage & """;"
					Response.Write "</script>"
				End Select
				Err.Clear
			End If
			Set oConn = Nothing
			Set oCmd = Nothing
		End If
%>
<h1><b><span lang=ZH-CN>新用户注册</span></b></h1>
<form name="thisForm" id="thisForm" method="post" action="UserRegistration.asp?res=<%=intResellerID%>">
<input type="hidden" name="txtSubmit" id="txtSubmit" value="1">
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
	  	<td valign="middle" colspan="2">
	  		<span class="headertext2"><span lang=ZH-CN>用户信息</span></span><br>
			<span lang=ZH-CN>请在下面栏目中键入你的信息，然后点击本页末尾的“登记。”</span>
	  	</td>
	</tr>
	<%
		If strErrMsg <> "" Then
			Response.Write("<tr><td valign=""middle"" colspan=""2"">")
			Response.Write("<span class=""errortext"">" & strErrMsg & "</span>")
			Response.Write("</td></tr>")
		End If
	%>
	<tr>
	  	<td valign="middle" align="right" width="35%"><span class="required">*&nbsp;</span><strong><span lang=ZH-CN>选择用户姓名</span>:</strong></td>
	  	<td valign="middle" width="65%"><input type="text" name="txtUserName" id="txtUserName" MaxLength="50" Size="15" Value="<%=UserName%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><span lang=ZH-CN>选择密码</span>:</strong></td>
	  	<td valign="middle"><input type="password" name="txtPassword" id="txtPassword" MaxLength="50" Size="15" Value="<%=Password%>">&nbsp;&nbsp;&nbsp;(<span lang=ZH-CN>至少六个字母</span>)</td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><span lang=ZH-CN>重新输入密码</span>:</strong></td>
	  	<td valign="middle"><input type="password" name="txtPasswordConfirm" id="txtPasswordConfirm" MaxLength="50" Size="15" Value="<%=PasswordConfirm%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><span lang=ZH-CN>名</span>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtFirstName" id="txtFirstName" MaxLength="100" Size="50" Value="<%=FirstName%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><span class="required">*&nbsp;</span><strong><span lang=ZH-CN>姓</span>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtLastName" id="txtLastName" MaxLength="100" Size="50" Value="<%=LastName%>"></td>
	</tr>
	<tr>
	  	<td valign="middle" align="right"><strong><span lang=ZH-CN>电子邮箱地址</span>:</strong></td>
	  	<td valign="middle"><input type="text" name="txtEmailAddress" id="txtEmailAddress" MaxLength="100" Size="50" Value="<%=EmailAddress%>"></td>
	</tr>
</table>
<span class="required">*&nbsp;号表示必需</span>
<br><br>

<table class="addtable" border="0" cellspacing="0" cellpadding="3" width="100%">
	<tr>
	  	<td valign="top" align="right"><input type="submit" border="0" value="登记" id="add" name="add"></td>
	</tr>
</table>
</form>
</div>
</body>
</html>