<%@ Language=VBScript %>
<!--#Include FILE="Include/CheckAdminLogin.asp" -->
<!--#Include FILE="../Include/common.asp" -->
<!--#Include FILE="Include/DateTimeFunctions.asp" -->
<!--#Include FILE="Include/FormattingFunctions.asp" -->
<%
	pageID = ""
	If Not IsAuthorized(4) Then 
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	End If
%>
<!--#Include FILE="Include/header.asp" -->
<tr>
	<td valign="top" class="leftnav"><!--#Include FILE="Include/navigation.asp" --></td>
	<td valign="top" class="maincontent">
		Page stuff goes here....
	</td>
</tr>
<!--#Include FILE="Include/footer.asp" -->