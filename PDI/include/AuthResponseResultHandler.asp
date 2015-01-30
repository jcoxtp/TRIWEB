<%

	' Send an e-mail acknowledging the purchase
    Response.Write("1")
	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
			.CommandText = "spUserInfoGetInfo"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@intUserID",3, 1,4, x_Cust_ID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
		
	strEmailAddress = oRs("EmailAddress")
	If oConn.Errors.Count < 1 then
    Response.Write("2")
		'If oRs.EOF = FALSE Then
		'	Dim JMail
		'	Set JMail = Server.CreateObject("JMail.SMTPMail")
		'	JMail.ServerAddress = "65.205.160.186:25"
		'	'JMail.ServerAddress = "www.pdiprofile.com:25"
		'	JMail.Sender = "support@pdiprofile.com"
		'	JMail.SenderName = "Team Resources, Inc."
		'	JMail.Subject = "Thank You for Your Purchase"
		'	JMail.AddRecipient(strEmailAddress)
		'	JMail.Body = "Thank you for your recent purchase at the Personal DISCernment Inventory website!" & VBcrLf & VBCrLf & "Here is your login information:" & VBCrLf & VBCrLf & "Username: " & oRs("UserName") & VBCrLf & "Password: " & oRs("Password") & VBCrLf & VBCrLf & VBCrLf & "Regards," & VBCrLf & VBCrLf & VBCrLf & "Team Resources, Inc."
		'	JMail.Priority = 3
		'	JMail.Execute
		'	Set oConn = Nothing
		'	Set oCmd = Nothing
		'	Set oRs = Nothing
		'	Response.End
		'Else
		'End If
	Else
        Response.Write("3")

			strErrMsg = Err.description
			Err.Clear
	End If
        Response.Write("4")

	'Response.End
		
	' If the trnasaction was not successful or encountere an error,
	' delete the purchase records in the appropriate tables
ElseIf X_RESPONSE_CODE = 2 Then
        Response.Write("5")

	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	With oCmd
			.CommandText = "spPurchaseDelete"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@intPurchaseID",3, 1,4, x_Invoice_Num)
	End With
	oConn.Open strDbConnString		  ' REPLACES > oConn.Open "DSN=TResources;UID=sa"
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128
	If oConn.Errors.Count < 1 then
		Response.Write "Purchase declined - Please try again."
		Response.Write "<br>"
		'Response.End
	End If
	Set oConn = Nothing
	Set oCmd = Nothing
Else
	' Else, assume that there wasn an error
        Response.Write("6")

	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	With oCmd
			.CommandText = "spPurchaseDelete"
			.CommandType = 4
			.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
			.Parameters.Append .CreateParameter("@intPurchaseID",3, 1,4, x_Invoice_Num)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oCmd.Execute , , 128
	If oConn.Errors.Count < 1 then
        Response.Write("7")

		Response.Write "Merchant Processing Error - Please try again."
		Response.Write "<br>"
		'Response.End
	End If
	Set oConn = Nothing
	Set oCmd = Nothing
End If %>