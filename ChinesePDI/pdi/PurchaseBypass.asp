<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/common.asp" -->
<%
	'=============================================================
	'	2/5/04 - MG
	'	Adding the ability for users to get reports without actually taking the PDI profile.
	'	The safest way to do this seems to be to create a fake test entry in the system.
	'=============================================================

	Dim intTestCodeID
	Dim intUserID

	intResellerID = Request("res")
	intTestCodeID = NULL
	intUserID = Request.Cookies("UserID")
	If intUserID = "" Then
		intUserID = Request("uid")
	End If

'Response.Write "<br>ResellerID = " & intResellerID
'Response.Write "<br>TestCodeID = " & intTestCodeID
'Response.Write "<br>intUserID = " & intUserID

	On Error Resume Next
	Response.Buffer = TRUE

	'=== Write the fake test info to the database ================
		Dim oConn, oCmd
		Set oConn = CreateObject("ADODB.Connection")
		Set oCmd = CreateObject("ADODB.Command")
		With oCmd
			.CommandText = "spPurchaseInsertFake"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@UserID", 3, 1, 4, intUserID)
			.Parameters.Append .CreateParameter("@ResellerID", 3, 1, 4, intResellerID)
			.Parameters.Append .CreateParameter("@intTestCodeID", 3, 3, 4, intTestCodeID)
		End With
		oConn.Open strDBaseConnString
		oCmd.ActiveConnection = oConn
		oCmd.Execute , , 128
		
	'=== Check for errors and proceed to the next page ===========
		If oConn.Errors.Count < 1 Then
			intTestCodeID = oCmd.Parameters("@intTestCodeID").value
			Response.Redirect "PDIProfileStartPage.asp?res=" & intResellerID & "&TCID=" & intTestCodeID
		Else
			  strErrMsg = Err.description
			  Err.Clear
		End If
%>
<html>
	<head>
		<title></title>
	</head>
	<body>
		<%
			If strErrMsg <> "" Then
				  Response.Write "<br>"
				  Response.Write strErrMsg
				  Response.Write "<br><br>"
			End If
		%>
	</body>
</html>