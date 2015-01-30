<%@ Language=VBScript CodePage=65001 %>
<!-- #Include File = "Include/CheckLogin.asp" -->
<!-- #Include File = "Include/Common.asp" -->
<!-- #Include File = "Include/ADOVBS.asp" -->
<% pageID = "enterTestCode" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8" />
	<title>DISC Profile System | Redeem a Profile</title>
	<link rel="stylesheet" href="_system.css" type="text/css">
	<!-- #Include File = "Include/Head_Stuff.asp" -->
</head>
<body>
<!-- #Include File = "Include/Top_Banner.asp" -->
<!-- #Include File = "Include/Left_Navbar.asp" -->
<div id="maincontent">
	<script language="Javascript">
	<!--
		function displayPopup(url, height, width) {
			properties = "toolbar=0,location=0,scrollbars=0,height=" + height;
			properties = properties + ",width=" + width;
			properties = properties + ",left=0,top=0";
			poppupHandle = window.open(url, "DISCProfile", properties);
		}
	// -->
	</script>
<%
	On Error Resume Next

	Dim bSubmitted
	bSubmitted = Request.Form ("txtSubmit")
	Dim bFilledOutProperly, strErrMsg
	Dim TestCodeEntered
	Dim TRUserID, TestCodeID
	Dim intLanguageID
	intLanguageID = 6 'Simplified Chinese

	TRUserID = Request.Cookies("UserID")
	bFilledOutProperly = FALSE
	
	If bSubmitted <> "" Then
		  TestCodeEntered = Request.Form("txtTestCodeEntered")
	End If
	
	Dim bMainPgSubmit
	bMainPgSubmit = Request.QueryString("MPS")
	if bMainPgSubmit <> "" then
		bSubmitted = 1
		TestCodeEntered = Request.QueryString("TCODE")
	end if
	
	TestCodeEntered = Trim(TestCodeEntered)
	TRUserID = Trim(TRUserID)
	
	If bSubmitted <> "" Then
		  If TestCodeEntered = "" then 
			strErrMsg = "Please enter a value for: <strong>Profile Code</strong>"
		  ElseIf TRUserID = "" then 
			strErrMsg = "Please enter a value for: TRUserID"
		  Else
			bFilledOutProperly = TRUE
		  End If
	End If

	Dim strUserName
	strUserName = Request.Cookies("UserName")

	If bSubmitted <> "" AND bFilledOutProperly Then
		'Response.Write "<br>TestCodeEntered=" & TestCodeEntered
		'Response.Write "<br>TRUserID=" & TRUserID
		'Response.Write "<br>CompanyID=" & CompanyID
		'Response.Write "<br>CompanyName=" & CompanyName
		'Response.Write "<br>TestCodeID=" & TestCodeID
		'Response.End
		Dim oConn
		Dim oCmd
		Dim oRs
		Dim CompanyID
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		Set oRs = CreateObject("ADODB.Recordset")
		With oCmd
			.CommandText = "spTestCodeTestSelect"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue, 0)
			.Parameters.Append .CreateParameter("@TestCodeEntered", adVarWChar, adParamInput, 50, TestCodeEntered)
			.Parameters.Append .CreateParameter("@TRUserID", adInteger, adParamInput, 4, TRUserID)
			.Parameters.Append .CreateParameter("@CompanyID", adInteger, adParamOutput, 4, CLng(CompanyID))
			.Parameters.Append .CreateParameter("@CompanyName", adVarWChar, adParamOutput, 100, CStr(CompanyName))
			.Parameters.Append .CreateParameter("@TestCodeID", adInteger, adParamOutput, 4, CLng(TestCodeID))
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oRs.CursorLocation = 3
		oRs.Open oCmd, , 0, 1
		If oConn.Errors.Count < 1 then
			CompanyID = oCmd.Parameters("@CompanyID").value
			CompanyName = oCmd.Parameters("@CompanyName").value
			TestCodeID = oCmd.Parameters("@TestCodeID").value
			If Request.Cookies("CompanyID") = 0 or ISNULL(Request.Cookies("CompanyID")) = TRUE Then
				If CompanyID <> 0 then
					Response.Cookies("CompanyID") = CompanyID
					Response.Cookies("CompanyName") = CompanyName
				End If
			End If
			Dim Field, nColumns
			If oRs.EOF = FALSE then
				oRs.MoveFirst
				If oRs("Success") = 0 Then
					strErrMsg = oRs("ErrMsg")
				Else
					If Left(TestCodeEntered,4) = "PDIP" Or Left(TestCodeEntered,3) = "个性鉴" Then
						Response.Redirect("PDIProfileStartPage.asp?TCID=" & TestCodeID & "&res=" & intResellerID)
					Else
						Response.Redirect("AppModuleCreatePDF.asp?TCID=" & TestCodeID & "&res=" & intResellerID)
					End If
					' Next Line is "We are currently making changes to the system. Please try back later. Thank you."
					Response.Write "我们当前做对系统的变动。请尝试以后。谢谢。"
					Response.End
				End If
			End If
		Else
			  strErrMsg = Err.description
			  Err.Clear
		End If
	End If
	%>
	
	<table border="0" cellspacing="0" cellpadding="0" width="100%" ID="Table1">
		<tr>
			<td valign="top"><h1>使用鉴别系统密码</h1></td>
			<td valign="top" align="right">&nbsp;</td>
		</tr>
	</table>
	
	<p>如果你已有鉴别系统的密码，现在就想使用，请在下面键入：</p>
	
	<form name="thisForm" id="thisForm" method="post" action="EnterTestCode.asp?res=<%=intResellerID%>">
	<input type="hidden" name="txtTRUserID" id="txtTRUserID" Value="<%=TRUserID%>">
	<input type="hidden" name="txtSubmit" id="txtSubmit" value=1>
	
	<table border="0" cellspacing="0" cellpadding="3" width="100%" ID="Table2">
		<tr> 
			<td valign="middle">&nbsp;</td>
			<td valign="middle">
				<% If Trim(strErrMsg) <> "" Then
					If Trim(strErrMsg) = "This test code has already been redeemed by a different user." Then
						Response.Write "<span class=""errortext"">这个测试编码由一名另外用户已经赎回。</span>"
					ElseIf Trim(strErrMsg) = "This test code does not exist." Then
						Response.Write "<span class=""errortext"">这个测试编码不存在。</span>"
					Else
						Response.Write "<span class=""errortext"">" & strErrMsg & "</span>"
					End If
				Else
					Response.Write "&nbsp;"
				End If %>
			</td>
		</tr>
		<tr>
			<td valign="middle" align="right" width="25%"><strong>鉴别系统密码：</strong><p> &nbsp;</p></td>
			<td valign="middle" width="75%">
				<input type="text" name="txtTestCodeEntered" id="txtTestCodeEntered" maxlength="50" size="35" value="<%=TestCodeEntered%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" name="Submit" value="输入" ID="Submit1"><p><em>(键入鉴别系统的密码时，请都用大写字母)</em></p>
			</td>
		</tr>
	</table>
	</form>
	<p>如果你没有鉴别系统的密码，你必须向你的机构内部管理“个性鉴别清单®”的人员申请一个密码。</p>
	
	<div align="center">
	<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%" ID="Table4">
		<tr>
			<td valign="top" align="right" width="25%"><a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank"><img src="images/get_acrobat_reader.gif" alt="" width="88" height="31" /></a></td>
			<td valign="top" align="left" width="75%">
			<strong>注意：</strong> 你必须安装Adobe<sup>&reg;</sup> Acrobat<sup>&reg;</sup> Reader<sup>&reg;</sup> 才能查阅你的个性鉴别报告。 <a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank">请从Adobe网站下载免费的软件</a>。
			</td>
		</tr>
	</table>
	</div>
	<script>
	function confirmAppPDFCreation(TCID) {
		if (window.confirm("稍微等候一下，你将看到使用报告。然后你将会得到一个下载的网址。")) {
			var goToNextURL;
			goToNextURL = "AppModuleCreatePDF.asp?res=<%=intResellerID%>&TCID=" + TCID;
			document.location = goToNextURL;
		}
	}
	</script>
</div>
</body>
</html>