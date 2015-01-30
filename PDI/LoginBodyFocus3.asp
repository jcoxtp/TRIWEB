<body class="loginbody">
<div id="CenterAll">
	<table border="0" cellspacing="0" cellpadding="0" width="875" height="680" style="background-repeat: no-repeat; background-image: url('/RS/<%=SitePathName%>/Background<%=strLanguageCode%>.jpg');"><tr><td></td></tr></table>
<div id="login_section01">
	<form name="thisForm1" id="thisForm1" method="post" action="UserRegistration.asp?res=<%=intResellerID%>" target="_top">
	<input type="hidden" name="txtSubmit" value="0">
	<table width="675" border="0">
		<tr align="center">
			<td>
				<input type="button" value="<%=strTextClickHereToRegisterAndBegin%>" onClick="javascript:submit();"  style="font-family:arial;font-size:18pt;font-weight:bold;">
			</td>
		</tr>
		<tr>
			<td>
<%
				Response.Write VbTab & "<font class=""logintext"">" & strTextPDILoginPar1 & "</font>" & VbCrLf
				Response.Write VbTab & "<br><font class=""textsmallgap"">&nbsp;</font>" & VbCrLf
				Response.Write VbTab & "<br><font class=""logintext"">" & strTextPDILoginPar2 & "</font>" & VbCrLf
				Response.Write VbTab & "<br><font class=""textsmallgap"">&nbsp;</font>" & VbCrLf
				Response.Write VbTab & "<br><font class=""logintext"">" & strTextPDILoginPar3 & "</font>" & VbCrLf
%>
			</td>
		</tr>
	</table>
	</form>
</div>
<%
If intResellerID <> 18 Then 'Do NOT print the history section for Ross Foods reseller
	Response.Write "<div id=""login_section02"">" & VbCrLf
	Response.Write "<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""350"" height=""175"" style=""background-image: url('/RS/" & SitePathName & "/BackgroundPane.jpg'); background-repeat:no-repeat; border-color: #FFFFFF; border-size: 1"">" & VbCrLf
	Response.Write "	<tr>" & VbCrLf
	Response.Write "			<td>" & VbCrLf
	Response.Write "<p class=""big_learnmore"">" & strTextLearnMore & "</p>" & VbCrLf
	Response.Write "<ul>" & VbCrLf
	Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""DISCBackground.asp?res=" & intResellerID & """ target=""_top"">" & strTextHistoryAndTheory & "</a> " & strTextOfDISC & "</li>" & VbCrLf
	Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""OnlinePDIReport.asp?res=" & intResellerID & """ target=""_top"">" & strTextTheOnlinePDIRegMark & "</a></li>" & VbCrLf
	Response.Write "</ul>" & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "</div>" & VbCrLf
End If
%>
<div id="login_form">
    <form name="thisForm" id="thisForm" method="post" action="login.asp?res=<%=intResellerID%>" target="_top">

	<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<tr align="left">
			<td valign="middle" height="55">
<%
	Response.Write "<span class=""logintext""><strong>" & strTextReturningUsersPlease & "</strong><br /><br /></span>" & VbCrLf
	Response.Write "<span class=""logintext"">" & strTextForgotUserNameOrPassword & "?   <a class=""loginform_link"" href=""emailusernamepswd.asp?res=" & intResellerID & """ target=""_top"">"  & strTextHaveItSentToYou & "</a>.</span>" & VbCrLf
%>
			</td>
			<td valign="middle">&nbsp;</td>
<% If intResellerID = 18 Then %>
</tr><tr><td colspan=2>&nbsp;</td></tr><tr>
<% End If %>
			
			<td valign="bottom" align="right">
				<table border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td valign="middle" align="right">
							<span class="logintext"><strong><%=Application("strTextUsername" & strLanguageCode)%>:&nbsp;</strong></span>
						</td>
						<td valign="middle">
							<input name="txtUserName" class="loginform_field" type="text" size="15" maxlength="32" />
						</td>
					</tr>
					<tr>
						<td valign="middle" align="right">
							<span class="logintext"><strong><%=Application("strTextPassword" & strLanguageCode)%>:&nbsp;</strong></span>
						</td>
						<td valign="middle">
							<input name="txtPassword" class="loginform_field" type="password" size="15" maxlength="32" />
						</td>
					</tr>
				</table>
			</td>
			<td valign="bottom" align="right">
				<input type="submit" value="<%=Application("strTextEnter" & strLanguageCode)%>" id="add" name="add" />
				<input type="hidden" name="txtSubmit" id="txtSubmit" value="1" />
			</td>
		</tr>
	</table>
	</form>
</div>
    </body>