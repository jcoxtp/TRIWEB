<%
Response.Cookies("ResellerID") = "3"
Response.Cookies("ResellerID").Expires = FormatDateTime(DateAdd("d", 180, Now()))
Response.Cookies("ResellerID").Path = "/"
Response.Redirect("../pdi/login.asp?res=3")
%>