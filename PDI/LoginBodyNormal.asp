<body class="loginbody">
<!--    <link rel="stylesheet" href="Include/DefaultLogin<%=strLanguageCode%>.css" type="text/css"/>-->
    <link rel="stylesheet" href="Include/DefaultLoginEN.css" type="text/css"/>
    <link rel="stylesheet" href="Include/global.css" type="text/css" />
    <div id="CenterAll">
    <!-- #Include virtual="PDI/Include/header.asp" -->
    </div>
    <div id="main">
        <%If strSiteType = "TR" Then %>
    <!-- #Include virtual="PDI/Include/front-landing-page.html" -->
        <%Else %>
<div id="login_section01">
<%
	If strSiteType = "Focus3" Then
		If intUserID = 2 Or intUserID = 210 Or intUserID = 171 Or intUserID = 8791 Then
		Response.Write "	<form name=""PurchaseForm"" id=""PurchaseForm"" method=""post"" action=""UserRegistration.asp?res=" & intResellerID & """ target=""_top"">" & VbCrLf
		Response.Write "		<input type=""hidden"" name=""txtSubmit"" value=""0"">" & VbCrLf
		Response.Write VbTab & "			<div align=""center""><input type=""submit"" name=""Submit"" value=""Click here to get started""></div>" & VbCrLf
		Response.Write "<br>" & VbCrLf
		End If
	End If

	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginPar1 & "</p>" & VbCrLf
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginPar2 & "</p>" & VbCrLf
	Response.Write VbTab & "<p class=""logintext"">" & strTextPDILoginPar3 & "</p>" & VbCrLf

	If strSiteType = "Focus3" Then
		If intUserID = 2 Or intUserID = 210 Or intUserID = 171 Or intUserID = 8791 Then
		Response.Write "</form>" & VbCrLf
		End If
	End If
	
	Response.Write "</div>" & VbCrLf
	Response.Write "<div id=""login_section02"">" & VbCrLf
	Response.Write "<p class=""big_learnmore"">" & strTextLearnMore & "</p>" & VbCrLf
	Response.Write "<ul>" & VbCrLf
	Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""DISCBackground.asp?res=" & intResellerID & """ target=""_top"">" & strTextHistoryAndTheory & "</a> " & strTextOfDISC & "</li>" & VbCrLf
	Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""OnlinePDIReport.asp?res=" & intResellerID & """ target=""_top"">" & strTextTheOnlinePDIRegMark & "</a></li>" & VbCrLf
	If strSiteType <> "Focus3" Then 'Focus3 does not want to display these options
		Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""PDIAppReports.asp?res=" & intResellerID & """ target=""_top"">" & strTextTailoredApplicationReports & "</a></li>" & VbCrLf
		Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""VolumeDiscounts.asp?res=" & intResellerID & """ target=""_top"">" & strTextMultipleCopies & "</a> / " & strTextVolumeDiscounts & "</li>" & VbCrLf
		Response.Write "<li class=""logintext""><a class=""login_section02_link"" href=""PrivacyPolicy.asp?res=" & intResellerID & """ target=""_top"">" & Application("strTextPrivacyPolicy" & strLanguageCode) & "</a></li>" & VbCrLf
	End If
	Response.Write "</ul>" & VbCrLf
%>
</div>
        <%End If%>

    </div>
</body>