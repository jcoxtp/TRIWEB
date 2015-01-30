<%
Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")
With oCmd
	.CommandText = "spGetCountries"
	.CommandType = 4
	.Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
End With
oConn.Open strDbConnString
oCmd.ActiveConnection = oConn
oRs.CursorLocation = 3
oRs.Open oCmd, , 0, 1
If oConn.Errors.Count < 1 then
	if bSubmitted = "" then
		while oRs.EOF = FALSE
			Response.Write("<option value=""" & oRs("CountryID") & """>" & oRs("Country") & "</option>")
			oRs.MoveNext
		wend
	else
		while oRs.EOF = FALSE
			if CInt(oRs("ProvinceID")) = CInt(ProvinceID) then
				Response.Write("<option value=""" & oRs("CountryID") & """ >" & oRs("Country") & "</option>")
			else
				Response.Write("<option value=""" & oRs("CountryID") & """>" & oRs("Country") & "</option>")
			end if
			oRs.MoveNext
		wend
	end if
end if
Set oConn = Nothing : Set oCmd = Nothing : Set oRs = Nothing
%>
