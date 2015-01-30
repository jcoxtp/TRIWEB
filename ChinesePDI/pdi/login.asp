<%@ Language=VBScript Codepage=65001 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8" />
		<title>Welcome to the DISC Profile System</title>
<%
' <meta http-equiv="Content-type" content="text/html; charset=utf-8">
' <meta http-equiv="Content-language" content="en,zh">
' <meta http-equiv="Content-Type" content="text/html; charset=GB18030">
Response.Buffer = TRUE %>
<!--#INCLUDE FILE="include/common.asp" -->
<%
On Error Resume Next
Dim bSubmitted, strErrMsg
bSubmitted = Request.Form ("txtSubmit")
strErrMsg = Request.QueryString("bSuccess")

if bSubmitted <> "" then 
	Dim UserName : UserName = Request.Form("txtUserName")
	Dim Password : Password = Request.Form("txtPassword")
	
	Dim oConn, oCmd, oRs
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
	     .CommandText = "sel_TRUser_login"
	     .CommandType = 4
	     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	     .Parameters.Append .CreateParameter("@UserName",200, 1,50, UserName)
	     .Parameters.Append .CreateParameter("@Password",200, 1,50, Password)
	End With
	oConn.Open strDBaseConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1

	If oConn.Errors.Count < 1 then
		' reset the cookies first
		ResetCookies
		if oRs("LoginResults") = 1 then
			Response.Cookies("Login") = 1
			Response.Cookies("UserID") = oRs("UserID")
			Response.Cookies("UserName") = oRs("UserName")
			'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			'If CompanyID is null in UserInfo table, firstname and lastname comes back null.  
			'If so, go get the firstname and lastname. Otherwise use the values from the stored proc.
			'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			If ISNULL(oRs("FirstName")) or oRs("FirstName") = "" then
				strSQL = "select firstname, lastname from userinfo a, truser b where a.userinfoid = b.userinfoid and b.userid = " & oRs("UserID")
				Response.Cookies("FirstName") = oConn.Execute (strSQL).fields(0).value
				Response.Cookies("LastName") = oConn.Execute (strSQL).fields(1).value
			Else 
				Response.Cookies("FirstName") = oRs("FirstName")
				Response.Cookies("LastName") = oRs("LastName")
			End IF
			Response.Cookies("NoPDIPurch") = oRs("NoPDIPurch")
			Response.Cookies("IsProfileMgr") = oRs("IsProfileMgr")
			Response.Cookies("IsFinancialsViewer") = oRs("IsFinancialsViewer")
			if ISNULL(oRs("CompanyID")) then
				Response.Cookies("CompanyID") = ""
			else
				Response.Cookies("CompanyID") = oRs("CompanyID")
			end if
			if ISNULL(oRs("CompanyName")) then
				Response.Cookies("CompanyName") = ""
			else
				Response.Cookies("CompanyName") = oRs("CompanyName")
			end if
			Response.Cookies("UserTypeID") = oRs("UserTypeID")
			Response.Redirect("EnterTestCode.asp?res=" & intResellerID & "&uid=" & oRs("UserID"))
		else
			' just in case we want to provide custom login error messages
			' in the future I have separated the different replies from the 
			' stored procedure
			' right now the only custom message is that the user is inactive
			if InStr(1,oRs("CustomErrMsg"),"INVALIDPASSWORD") <> 0 then
				strErrMsg = "Login Failed. Please Try Again"
			elseif InStr(1,oRs("CustomErrMsg"),"NOSUCHUSER") <> 0 then
				strErrMsg = "Login Failed. Please Try Again"
			elseif InStr(1,oRs("CustomErrMsg"),"USERINACTIVE") <> 0 then
				strErrMsg = "This user name is inactive. Please Try Again"
			else
				strErrMsg = "Login Failed. Please Try Again"
			end if
		End If
	else
		Response.Write "<div style='color:white; font-weight: bold'><BR><BR>Transaction Failed<BR><BR>Database String: " & strDBaseConnString & "<br></div>"
		Response.Write Err.description
		Err.Clear
	End If
End If
%>
			<link rel="stylesheet" href="_system.css" type="text/css"> <!-- system stylesheet must come before the reseller stylesheet -->
				<link rel="stylesheet" href="../RS/<%=SitePathName%>/reseller.css" type="text/css">
		<!--#INCLUDE FILE="include/head_stuff.asp" -->
	</head>
	<body class="loginbody">
		<div id="CenterAll">
			<table border="0" cellspacing="0" cellpadding="0" width="768" height="650" style="BACKGROUND-IMAGE: url(images/background_chinese.jpg); BACKGROUND-REPEAT: no-repeat">
				<tr>
					<td></td>
				</tr>
			</table>
			<div id="login_form">
				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr align="left">
						<td colspan="5">
							<span class="zhs_title" lang="zh">个性鉴别清单</span>
							<span class="logintext_title" lang="en">DISC<sup>&reg;</sup></span>
						</td>
					</tr>
					<tr align="left">
						<td valign="center" height="55"><span class="zhs_white" lang="zh">首次用户？请 <a class="loginform_link" href="UserRegistration.asp?res=<%=intResellerID%>" target="_top">登记</a></span>
							<br>
							<span class="zhs_white" lang="zh">忘记用户姓名或密码？帮你</span><a class="loginform_link" href="emailusernamepswd.asp?res=<%=intResellerID%>" target="_top">查到</a>?¡ê</span>
						</td>
						<td valign="center" width="5%">&nbsp;</td>
						<td valign="center">
							<table border="0" cellspacing="0" cellpadding="2">
								<form name="thisForm" id="thisForm" method="post" action="login.asp?res=<%=intResellerID%>" target="_top">
									<tr>
										<td valign="center" align="right">
											<strong>
												<span class="zhs_white" lang="zhs">用户姓名</span>:&nbsp;</strong>
										</td>
										<td valign="center"><input name="txtUserName" class="loginform_field" type="text" size="20" maxlength="15">
										</td>
									</tr>
									<tr>
										<td valign="center" align="right"><span class="logintext"><strong><span class="logintext">密码</span>:&nbsp;</strong></span>
										</td>
										<td valign="center">
											<input name="txtPassword" class="loginform_field" type="password" size="20" maxlength="15">
										</td>
									</tr>
							</table>
						</td>
						<td valign="center" align="right"><input type="submit" value="登记" id="add" name="add">
							<input type="hidden" name="txtSubmit" id="txtSubmit" value="1">
						</td>
						<td width="5%">&nbsp;</td>
					</tr>
				</table>
				</form>
			</div>
			<div id="login_section01">
				<br><p><span class="logintext">
					我们对自己、对别人了解的越多，我们跟其他人就能合作的越好。
					个性鉴别清单 <sup>â</sup>（PDI)）
					有助于我们理解人们的行为表现为什么会不同，如何不同。</span>
				</p>

				<p><span class="logintext">
					这套独特的教育工具基于经久不衰的 DISC 
					理论，该理论对你的工作和社会交往提出有力的见解。
					它能够使你清楚地了解你是如何看待自己的，
					你想让别人怎么看待你。经过这个过程后，你将认识真实的你 
					一个也许与你的想象略有不同的人。</span>
				</p>
				
				<p><span class="logintext">
					个性鉴别清单<sup>â</sup>
					不是考试；<b>这里没有“正确”或“错误”的回答</b>
					。它只是帮助你了解分析你自身行为风格的一套工具，
					以便你能够更好地使你适应特殊的环境，
					更有效地跟他人保持工作和私人的关系。</span>
				</p>

				<% IF intResellerID = 2 Then 'The Dream Giver %>
				<p class="logintext">
					The DreamGiver Assessment connects the insights from your DISC 
					profile to your personal Dream Journey. This customized report explores each 
					stage of your Dream and describes the unique challenges you will encounter due 
					to your style's particular strengths and weaknesses. Learn about the major 
					issues in each stage and discover how to successfully navigate the path to 
					fulfilling your Dream.
				</p>
				<% End If %>
			</div>
		</div>
	</body>
</html>
