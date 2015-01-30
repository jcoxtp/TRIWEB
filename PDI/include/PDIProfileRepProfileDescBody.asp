<%
'Dim strLeftTitle1, strLeftText1
'Dim strRightTitle1, strRightText1
'Dim strLeftTitle2, strLeftText2
'Dim strRightTitle2, strRightText2
strLeftTitle1 = strTextOutstandingTraits
strRightTitle1 = strTextPotentialForGrowth
strLeftTitle2 = strTextBasicDesiresAndInternalDrive
strRightTitle2 = strTextIdealWorkSetting
Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
	.CommandText = "spRepProfileDescSelect"
	.CommandType = 4
	.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	.Parameters.Append .CreateParameter("@profileID", 3, 1, 4, profileID)
	.Parameters.Append .CreateParameter("@intLanguageID", 3, 1, 4, intLanguageID)
	.Parameters.Append .CreateParameter("@strProfileName", 200, 4, 30, NULL)
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1
If oConn.Errors.Count < 1 Then
	strProfileName = oCmd.Parameters("@strProfileName").value
	strLeftText1 = oRs("OutstandingTraits")
	strRightText1 = oRs("PotentialGrowth")
	strLeftText2 = oRs("BasicDesires")
	strRightText2 = oRs("WorkSetting")
Else
	Response.Write strTextErrorTryingToRetrieveProfileDescription
End If
Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing
%>
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
		<td valign="top" align="center" width="140"><img src="images/RepProfile<%=profileID%>.gif" alt="" /></td>
		<td valign="top">
			<h1><%=strProfileName%></h1>
			<h2><%=strLeftTitle1%></h2>
			<p><%=strLeftText1%></p>
			<h2><%=strLeftTitle2%></h2>
			<p><%=strLeftText2%></p>
			<h2><%=strRightTitle1%></h2>
			<p><%=strRightText1%></p>
			<h2><%=strRightTitle2%></h2>
			<p><%=strRightText2%></p>
		</td>
	</tr>
</table>
<% If (SPN <> "0") And (oldButtons = True) Then %>
	<table border="0" cellspacing="0" cellpadding="0" width="570">
		<tr>
			<td align="right">
				<a href="PDIProfileRepProfile2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img src="images/PDIPrevPage_Narrow.gif" alt="" /></a>
			</td>
		</tr>
	</table>
<% End If %>
