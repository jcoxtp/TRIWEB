<%
Response.Cookies("ResellerID") = "1"
Response.Cookies("ResellerID").Expires = FormatDateTime(DateAdd("d", 180, Now()))
Response.Cookies("ResellerID").Path = "/"
Response.Redirect("pdi/login.asp?res=1")
'Response.Redirect("pdi/login2.asp?res=1")

%>