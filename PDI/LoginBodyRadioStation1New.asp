	<div id="login_form">
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
			<tr align="left">
				<td valign="middle" width="50%" height="55">
<%
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginRadioStation1Par1 & "</p>" & VbCrLf
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginRadioStation1Par2 & "</p>" & VbCrLf
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginRadioStation1Par3 & "</p>" & VbCrLf
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginRadioStation1Par4 & "</p>" & VbCrLf
%>
			<tr align="left">
				<td valign="middle" width="50%" height="55">
<%
				Response.Write "<span class=""logintext"">" & strTextFirstTimeUser & "? " & strTextPlease & " <a class=""loginform_link"" href=""UserRegistration.asp?res=" & intResellerID & """ target=""_top"">" & LCase(strTextRegister) & "</a>.<br /></span>" & VbCrLf
				Response.Write "<span class=""logintext"">" & strTextForgotUserNameOrPassword & "? <a class=""loginform_link"" href=""emailusernamepswd.asp?res=" & intResellerID & """ target=""_top"">" & strTextHaveItSentToYou & "</a>.</span>" & VbCrLf
%>
				</td>
				<td valign="middle" width="5%">&nbsp;</td>
				<td valign="middle">
					<table border="0" cellspacing="0" cellpadding="2">
						<form name="thisForm" id="thisForm" method="post" action="login.asp?res=<%=intResellerID%>" target="_top">
						<tr>
							<td valign="middle" align="right">
								<span class="logintext"><strong><%=Application("strTextUsername" & strLanguageCode)%>:&nbsp;</strong></span>
							</td>
							<td valign="middle"><input name="txtUserName" class="loginform_field" type="text" size="20" maxlength="32" />
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right"><span class="logintext"><strong><%=Application("strTextPassword" & strLanguageCode)%>:&nbsp;</strong></span>
							</td>
							<td valign="middle">
								<input name="txtPassword" class="loginform_field" type="password" size="20" maxlength="32" />
							</td>
						</tr>
					</table>
				</td>
				<td valign="middle" align="right"><input type="submit" value="<%=Application("strTextEnter" & strLanguageCode)%>" id="add" name="add" />
					<input type="hidden" name="txtSubmit" id="txtSubmit" value="1" />
				</td>
				<td width="5%">&nbsp;</td>
			</tr>
		</table>
		</form>
	</div>
	<div id="login_section01">
<%
	If intResellerID = 2 Then 'The Dream Giver
		Response.Write VbTab & "<p class=""logintext"">" & strTextDGLoginPar4 & "</p>" & VbCrLf
	End If
	
	Response.Write "</div>" & VbCrLf
	Response.Write "<div id=""login_section02"">" & VbCrLf
	Response.Write "<p class=""big_learnmore"">" & strTextLearnMore & "</p>" & VbCrLf
	Response.Write "<ul>" & VbCrLf
	Response.Write "<li class=""logintext"">" & " <a class=""login_section02_link"" href=""DISCBackground.asp?res=" & intResellerID & " target=""_top"">" & strTextHistoryAndTheory & "</a> " & strTextOfDISC & "</li>" & VbCrLf
	Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""OnlinePDIReport.asp?res=" & intResellerID & """ target=""_top"">" & strTextTheOnlinePDIRegMark & "</a></li>" & VbCrLf
	If intResellerID = 2 Then 'The Dream Giver
		Response.Write "<li class=""logintext"">" & Application("strTextThe" & strLanguageCode) & " <a class=""login_section02_link"" href=""DGAssessment.asp?res=" & intResellerID & """ target=""_top"">" & strTextDreamGiverAssessment & "</a></li>" & VbCrLf
		Response.Write "<li class=""logintext"">" & Application("strTextThe" & strLanguageCode) & " <a class=""login_section02_link"" href=""disc_profile.asp?res=" & intResellerID & """ target=""_top"">" & Application("strTextDISCProfile" & strLanguageCode) & "</a>" & Application("strTextSystem" & strLanguageCode) & "<sup>&reg;</sup></li>" & VbCrLf
	Else
		Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""PDIAppReports.asp?res=" & intResellerID & """ target=""_top"">" & strTextTailoredApplicationReports & "</a></li>" & VbCrLf
		Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""VolumeDiscounts.asp?res=" & intResellerID & """ target=""_top"">" & strTextMultipleCopies & "</a> / " & strTextVolumeDiscounts & "</li>" & VbCrLf
	End If
	
	Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""PrivacyPolicy.asp?res=" & intResellerID & """ target=""_top"">" & Application("strTextPrivacyPolicy" & strLanguageCode) & "</a></li>" & VbCrLf
	Response.Write "</ul>" & VbCrLf
%>
	</div>
