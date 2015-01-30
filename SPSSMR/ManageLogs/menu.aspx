<%@ Page Language="C#"  CodeBehind="menu.aspx.cs" Inherits="SPSS.ManageLogs.View.menu" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
    <title>Demo</title>
        <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
        <meta name="CODE_LANGUAGE" Content="C#">
        <meta name="vs_defaultClientScript" content="JavaScript">
        <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        <!-- STANDARD FUNCTIONS FOR THIS APP -->
        <!-- JAVASCRIPT TABLESORT LIB -->
        <LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../shared/coolmenu/spssmenu.css">
        
        <script src="../shared/coolmenu/coolmenus4.js" type="text/javascript"> </script> 
        
        <!-- STANDARD SPSS TABS -->
        <LINK href="../shared/tabs/spsstabs.css" type="text/css" rel="stylesheet">
        <script src="../shared/tabs/tabctrl.js" type="text/javascript"></script>

</head>
<body onload="doInitTabs();" class="menu" leftMargin="0" topMargin="0" style="width:100%; height:100%;">
    <form id="menu" method="post" runat="server">       
          <table width="100%" border="0">
				<tr>
					<td vAlign="top"><asp:table id="tblMenu" runat="server" width="100%"></asp:table></td>
				</tr>
			</table>		
	</form>
		
</body>

</html>
