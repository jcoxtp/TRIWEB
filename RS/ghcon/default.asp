<html>
<head><title>GHCON PDI</title>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
</head>
<body>
<%
Response.Cookies("ResellerID") = "19"
Response.Cookies("ResellerID").Expires = FormatDateTime(DateAdd("d", 180, Now()))
Response.Cookies("ResellerID").Path = "/"
'Response.Redirect("../../pdi/login.asp?res=19")
'Response.Redirect("../../pdi/ghconlogin.asp?res=19")
%>
<script type="text/javascript">
window.location = "../../pdi/ghconlogin.asp?res=19";
</script>
</body>
</html>