<html>
<head><title>Focus 3 PDI</title>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
</head>
<body>
<%
Response.Cookies("ResellerID") = "12"
Response.Cookies("ResellerID").Expires = FormatDateTime(DateAdd("d", 180, Now()))
Response.Cookies("ResellerID").Path = "/"
'Response.Redirect("../../pdi/login.asp?res=12")
%>
<script type="text/javascript">
window.location = "../../pdi/login.asp?res=12";
</script>
</body>
</html>