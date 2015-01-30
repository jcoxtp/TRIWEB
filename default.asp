<%@ Language=VBScript%>
<html>
<head><title></title>
<!--<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>-->
<script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
    ga('create', 'UA-368995-2', 'pdiprofile.com');
    ga('require', 'displayfeatures');
    ga('send', 'pageview');
</script> 
</head>
<body>

<%
Response.Cookies("ResellerID") = "1"
Response.Cookies("ResellerID").Expires = FormatDateTime(DateAdd("d", 365, Now()))
Response.Cookies("ResellerID").Path = "/"

Dim strWebAddress
strWebAddress = Request.ServerVariables("HTTP_HOST")

Response.Redirect("http://" & strWebAddress & "/PDI/Login.asp?res=1")
'Response.Redirect("UnderConst.asp")
%>
</body>
</html>