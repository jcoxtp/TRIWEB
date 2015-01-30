<%
' Retrieve the most, least and composite numbers from the database
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		.CommandText = "spTestSummarySelect"
		.CommandType = 4
		.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		.Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	Dim nProfileID1
	Dim ProfileName1
	Dim nProfileID2
	Dim ProfileName2
	Dim SPN2
	If oConn.Errors.Count < 1 Then
		oRs.MoveFirst
		nProfileID1 = oRs("ProfileID1")
		nProfileID2 = oRs("ProfileID2")
		ProfileName1 = oRs("ProfileName1")
		ProfileName2 = oRs("ProfileName2")
		Dim nC1_2, nC2_2, nC3_2, nC4_2
		nC1_2 = oRs("C_NumberD")
		nC2_2 = oRs("C_NumberI")
		nC3_2 = oRs("C_NumberS")
		nC4_2 = oRs("C_NumberC")
	Else
		Response.Write "<br><br>" & strTextUnableToRetrieveResultsFromDatabasePlease & VbCrLf
		Response.End
	End If
	If IsNull(nProfileID1) = True Then
		nProfileID1 = 0
	End If
	If IsNull(nProfileID2) = True Then
		nProfileID2 = 0
	End If
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
%>
<h1><%=strTextProbableStrengths%></h1>
<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%">
	<tr> 
	  	<td valign="top"><img src="SWStrengthsChart.asp?TCID=<%=TestCodeID%>&LC=<%=strLanguageCode%>" alt="" /></td>
		<td valign="middle">
			<img src="DISCCompositeSmall.asp?nD1=<%=nC1_2%>&amp;nD2=<%=nC2_2%>&amp;nD3=<%=nC3_2%>&amp;nD4=<%=nC4_2%>" alt="" />
			<br />
			<strong><%=strTextCompositeGraph%></strong>
		</td>
	</tr>
</table>
</div>
<% If (SPN <> "0") and (oldButtons = True) Then %>
	<table border="0" cellspacing="0" cellpadding="0" width="570">
		<tr>
			<td align="right">
				<a HREF="PDIProfileRepProfile2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>"><img SRC="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a HREF="PDIProfileSANDW2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>&lid=<%=intLanguageID%>"><img SRC="images/PDINextPage.gif" alt="" /></a>
			</td>
		</tr>
	</table>
<% End If %>
