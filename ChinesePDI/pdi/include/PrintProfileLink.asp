<%
If SPN <> "0" Then
	Response.Write "<div align=""center"">" & VbCrLf
	Response.Write "<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""4"" width=""100%"">" & VbCrLf
	Response.Write "	<tr>" & VbCrLf
	Response.Write "		<td valign=""middle"" align=""right""><a href=""" & nextLink & """><img src=""images/learn.gif"" alt="""" width=""32"" height=""32""></a></td>" & VbCrLf
	Response.Write "		<td valign=""middle"" align=""left"" width=""35%"">" & VbCrLf
	Response.Write "			<a href=""" & nextLink & """>" & strTextContinueLearning & "</a>" & VbCrLf
	Response.Write "			<br />" & strTextAboutMyUniqueTemperament & VbCrLf
	Response.Write "		</td>" & VbCrLf
	Response.Write "		<td valign=""middle"" align=""right"" >" & VbCrLf
	Response.Write "			<a href=""PDIProfileRepProfile1.asp?TCID=" & TestCodeID & "&res=" & intResellerID & """><img src=""images/Print" & strLanguageCode & ".gif"" alt="""" width=""40"" height=""36""></a>" & VbCrLf
	Response.Write "		</td>" & VbCrLf
	Response.Write "		<td valign=""middle"" align=""left"" width=""35%"">" & VbCrLf
	Response.Write "			" & strTextShortOnTime & "<br />" & VbCrLf
	Response.Write "				<a href=""PDIProfileRepProfile1.asp?TCID=" & TestCodeID & "&res=" & intResellerID & """>" & strTextChooseProfile & "</a> "  & strTextAndPrintMyReport & VbCrLf
	Response.Write "		</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "</table>" & VbCrLf
	Response.Write "<br><br>" & VbCrLf
	Response.Write "</div>" & VbCrLf
End If
%>
