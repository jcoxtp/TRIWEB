<%@ Language=VBScript %>
<!--#INCLUDE FILE="include/common.asp" -->
<%
	'=============================================================
	'	2/5/04 - MG
	'	Adding the ability for users to get reports without actually taking the PDI profile.
	'	The safest way to do this seems to be to create a fake test entry in the system.
	'=============================================================

	Dim UserID
	UserID = Request.Cookies("UserID")

	on error resume next
	Response.Buffer = TRUE

	'=============================================================
	' Gather incoming data and assign to variables
	'=============================================================
		Dim HP1
		Dim strErrMsg
		Dim bFilledOutProperly	:	bFilledOutProperly = FALSE
		
		HP1 = Request("HP1") 
'		Response.Write("<br>HP1=") : Response.Write(HP1)
'		Response.Write("<hr>")
		
		'=== Validate incoming data ==================================
		HP1 = Trim(HP1)

		strErrMsg = ""
		If HP1 = "" then strErrMsg = strErrMsg & " Please enter a value for - HP1 <br>"

		' Is incoming data good? 
		If strErrMsg = "" then bFilledOutProperly = TRUE

	'====================================================================		
	' If incoming data is good then fake the extra info and write to the db	
	'====================================================================		
	If bFilledOutProperly then

		'=== Write the fake test info to the database ================
			Dim oConn, oCmd
			Set oConn = CreateObject("ADODB.Connection")
			Set oCmd = CreateObject("ADODB.Command")
			With oCmd
				.CommandText = "spPDI_DiamondLane"
				.CommandType = 4
				.Parameters.Append .CreateParameter("@UserID",3, 1, , UserID)
				.Parameters.Append .CreateParameter("@ResellerID",3, 1, , intResellerID)
				.Parameters.Append .CreateParameter("@HP1",129, 1,1, HP1)
			End With
			oConn.Open strDBaseConnString
			oCmd.ActiveConnection = oConn
			oCmd.Execute , , 128
			
		'=== Check for errors and proceed to the next page ===========
			If oConn.Errors.Count < 1 then
				Response.Write "<BR><BR>Transaction Successful<BR><BR>"
				Dim RedirVal : RedirVal = "purchasetest.asp?res=" & intResellerID
				Response.Redirect(RedirVal)
			else
				  strErrMsg = Err.description
				  Err.Clear
			End If
	'====================================================================		
	End If ' closes If bFilledOutProperly then...
	'====================================================================		
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