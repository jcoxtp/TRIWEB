<%
Response.Cookies("ResellerID") = "5"
Response.Cookies("ResellerID").Expires = FormatDateTime(DateAdd("d", 180, Now()))
Response.Cookies("ResellerID").Path = "/"
Response.Redirect("../../pdi/login.asp?res=5")
%>