<html>
<head><title>Slalom Consulting</title>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
</head>
<body>
<%
Response.Cookies("ResellerID") = "24"
Response.Cookies("ResellerID").Expires = FormatDateTime(DateAdd("d", 180, Now()))
Response.Cookies("ResellerID").Path = "/"
Response.Cookies("intLanguageID") = 1
Response.Redirect("../../pdi/login.asp?res=24&lid=1")
%>
<script type="text/javascript">
window.location = "../../pdi/login.asp?res=24&lid=1";
</script>
</body>
</html>