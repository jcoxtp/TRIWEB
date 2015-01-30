<body class="loginbody">
    <%	If intResellerID = 2 Then %>
    <div style="position: absolute; top: 438px; left: 220px; border-top: 1px red solid; border-bottom: 1px red solid; color: red; font-size: 12pt; font-weight: bold">Spring Special: $25</div>
    <%	End If %>
    <div id="CenterAll">
        <table border="0" cellspacing="0" cellpadding="0" width="768" height="800" style="background-repeat: no-repeat; background-image: url('/RS/<%=SitePathName%>/Background<%=strLanguageCode%>.jpg');">
            <tr>
                <td></td>
            </tr>
        </table>
        <%	If intResellerID = 1 Then %>
        <div class="LoginLanguageChooser">
            <!-- #Include File = "Include/LanguageChooser.asp" -->
        </div>
        <%	End If %>
        <div id="login_section01">
            <form name="PurchaseForm" id="PurchaseForm" method="post" action="UserRegistration.asp?res=<%=intResellerID%>" target="_top">
                <input type="hidden" name="txtSubmit" value="0">
                <table width="675" border="0">
                    <tr>
                        <td>
                            <%
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginRadioStationPar1 & "</p>" & VbCrLf
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginRadioStationPar2 & "</p>" & VbCrLf
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginRadioStationPar3 & "</p>" & VbCrLf
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginRadioStationPar4 & "</p>" & VbCrLf
	Response.Write VbTab & "<p class=""logintext""><input type=""submit"" name=""Submit"" value=""" & strTextPurchaseNow & """><strong>&nbsp;&nbsp;" & strTextYesImReadyToStartOnMyDreamJourney & "</strong></p>"
                            %>
                        </td>
                    </tr>
                </table>
        </div>
        </form>
        <%
	Response.Write "<div id=""login_section02"">" & VbCrLf
	Response.Write "<table border=""0"" cellspacing=""0"" cellpadding=""0"" width=""350"" height=""175"" style=""background-image: url('/RS/" & SitePathName & "/BackgroundPane.jpg'); background-repeat:no-repeat; border-color: #FFFFFF; border-size: 1"">" & VbCrLf
	Response.Write "	<tr>" & VbCrLf
	Response.Write "			<td>" & VbCrLf
	Response.Write "<p class=""big_learnmore"">&nbsp;&nbsp;&nbsp;" & strTextLearnMore & "</p>" & VbCrLf
	Response.Write "<ul>" & VbCrLf
	Response.Write "<li class=""logintext"">" & " <a class=""login_section02_link"" href=""DISCBackground.asp?res=" & intResellerID & """ target=""_top"">" & strTextHistoryAndTheory & "</a> " & strTextOfDISC & "</li>" & VbCrLf
	Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""OnlinePDIReport.asp?res=" & intResellerID & """ target=""_top"">" & strTextTheOnlinePDIRegMark & "</a></li>" & VbCrLf
	Response.Write "<li class=""logintext"">" & Application("strTextThe" & strLanguageCode) & " <a class=""login_section02_link"" href=""DGAssessment.asp?res=" & intResellerID & """ target=""_top"">" & strTextDreamAssessmentReportRegMark & "</a></li>" & VbCrLf
	Response.Write "<li class=""logintext"">" & Application("strTextThe" & strLanguageCode) & " <a class=""login_section02_link"" href=""DISCProfile.asp?res=" & intResellerID & """ target=""_top"">" & Application("strTextDISCProfile" & strLanguageCode) & "</a> " & Application("strTextSystem" & strLanguageCode) & "<sup>&reg;</sup></li>" & VbCrLf
	Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""PrivacyPolicy.asp?res=" & intResellerID & """ target=""_top"">" & Application("strTextPrivacyPolicy" & strLanguageCode) & "</a></li>" & VbCrLf
	Response.Write "</ul>" & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "</div>" & VbCrLf
        %>
        <div id="login_form">
            <form name="thisForm" id="thisForm" method="post" action="login.asp?res=<%=intResellerID%>" target="_top">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
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
                                <tr>
                                    <td valign="middle" align="right">
                                        <span class="logintext"><strong><%=Application("strTextUsername" & strLanguageCode)%>:&nbsp;</strong></span>
                                    </td>
                                    <td valign="middle">
                                        <input name="txtUserName" class="loginform_field" type="text" size="20" maxlength="32" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle" align="right">
                                        <span class="logintext"><strong><%=Application("strTextPassword" & strLanguageCode)%>:&nbsp;</strong></span>
                                    </td>
                                    <td valign="middle">
                                        <input name="txtPassword" class="loginform_field" type="password" size="20" maxlength="32" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="middle" align="right">
                            <input type="submit" value="<%=Application("strTextEnter" & strLanguageCode)%>" id="add" name="add" />
                            <input type="hidden" name="txtSubmit" id="txtSubmit" value="1" />
                        </td>
                        <td width="5%">&nbsp;</td>
                    </tr>
                </table>
            </form>
        </div>
</body>
