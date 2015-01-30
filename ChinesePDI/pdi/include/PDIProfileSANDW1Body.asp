<%

' retrieve the most, least and composite numbers 
' from the database

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")

With oCmd

     .CommandText = "spTestSummarySelect"
     .CommandType = 4

     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
     .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)

End With

oConn.Open strDBaseConnString

oCmd.ActiveConnection = oConn

oRs.CursorLocation = 3

oRs.Open oCmd, , 0, 1

Dim nProfileID1
Dim ProfileName1
Dim nProfileID2
Dim ProfileName2
Dim SPN2

If oConn.Errors.Count < 1 then

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
	
else 

	Response.Write "Unable to retrieve results from database. Please try again."
	Response.End
	
end if 

if ISNULL(nProfileID1) = TRUE then
	nProfileID1 = 0 
end if 

if ISNULL(nProfileID2) = TRUE then
	nProfileID2 = 0 
end if

Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing

%>


<h1>Probable Strengths</h1>

<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="85%">
	<tr> 
	  	<td valign="top"><img src="sw_strengths_chart.asp?TCID=<%=TestCodeID%>" alt="" />
		</td>
		
		<td valign="middle"><img src="disccomposite_small.asp?nD1=<%=nC1_2%>&amp;nD2=<%=nC2_2%>&amp;nD3=<%=nC3_2%>&amp;nD4=<%=nC4_2%>" alt="" /><br />
			<strong>Composite Graph</strong>
		</td>
	</tr>
</table>
</div>


<% if (SPN <> "0") and (oldButtons = true) then %>
	
	<table border="0" cellspacing="0" cellpadding="0" width="570">
		<tr>
			<td align="right">
				<a HREF="PDIProfileRepProfile2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img SRC="images/PDIPrevPage.gif" alt="" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a HREF="PDIProfileSANDW2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img SRC="images/PDINextPage.gif" alt="" /></a>
			</td>
		</tr>
	</table>
	
<% end if %>


