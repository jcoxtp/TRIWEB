
<%

'Dim strLeftTitle1, strLeftText1
'Dim strRightTitle1, strRightText1
'Dim strLeftTitle2, strLeftText2
'Dim strRightTitle2, strRightText2

strLeftTitle1 = "Outstanding Traits"
strRightTitle1 = "Potential for Growth"
strLeftTitle2 = "Basic Desires and Internal Drive"
strRightTitle2 = "Ideal Work Setting"

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")

With oCmd

	.CommandText = "sel_RepProfile_Desc_ProfileID"
	.CommandType = 4

	.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
	.Parameters.Append .CreateParameter("@profileID",3, 1,4, profileID)

End With

oConn.Open strDBaseConnString

oCmd.ActiveConnection = oConn
	
oRs.CursorLocation = 3

oRs.Open oCmd, , 0, 1

	If oConn.Errors.Count < 1 Then

		strLeftText1 = oRs("outstandingTraits")
		strRightText1 = oRs("potentialGrowth")
		strLeftText2 = oRs("basicDesires")
		strRightText2 = oRs("workSetting")
				
	Else
	
		Response.Write "Error trying to retrieve profile description. Please try again."
	
	End If

Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing

%>

<table class="addtable" border="0" cellspacing="0" cellpadding="6" width="100%">
	<tr>
		<td valign="top" align="center" width="140">
			<img src="images/RepProfile<%=profileID%>.jpg" alt="" />
		</td>
		
		<td valign="top">
		
			<h1><%=profileName%></h1>
		
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


<% if (SPN <> "0") and (oldButtons = true) then %>
	
	<table border="0" cellspacing="0" cellpadding="0" width="570">
		<tr>
			<td align="right">
				<a href="PDIProfileRepProfile2.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img src="images/PDIPrevPage_Narrow.gif" alt="" /></a>
			</td>
		</tr>
	</table>

	
<% end if %>


