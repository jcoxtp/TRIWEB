<%@ Page language="c#" Codebehind="welcome.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.welcome" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Welcome</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
<script type="text/javascript" src="scripts/jquery-1.4.2.js"></script>
<script type="text/javascript" src="scripts/jquery.corners.js"></script>
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
		<script type="text/javascript">
		        function checkCookiesEnabled()
		        {
		            if(!navigator.cookiesEnabled)
		            {
		                alert("Cookies must be enabled on this site.");
		            }
		        }
		</script>
	</HEAD>
	<body>
	   <div id="page">
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<div id="main-content">
			<%= getHTML("welcome.inc") %>
			<div id="welcomeBeginButton"><asp:button id="btnBegin" runat="server" CssClass="standard-textbox" Text="Begin" CausesValidation="False"></asp:button></div>
			</div>
			<%= getHTML("footer.inc") %>
		</form>
	   </div>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	</body>
</HTML>
