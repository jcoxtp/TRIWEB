<%
If SPN <> "0" Then %>

<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="4" width="100%">
	<tr>
		<td valign="middle" align="right"><a href="<%=nextLink%>"><img src="images/learn.gif" alt="" width="32" height="32"></a></td>
		<td valign="middle" align="left" width="35%"><a href="<%=nextLink%>">Continue Learning</a><br />
			About My Unique Temperament</td>
		
		<td valign="middle" align="right" ><a href="PDIProfileRepProfile1.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>"><img src="images/printer.gif" alt="" width="32" height="32"></a></td>
		<td valign="middle" align="left" width="35%">Short on Time?<br />
			<a href="PDIProfileRepProfile1.asp?TCID=<%=TestCodeID%>&res=<%=intResellerID%>">Choose Profile</a> and Print My Report</td>
	</tr>	
</table>
</div>

<%
End If %>


