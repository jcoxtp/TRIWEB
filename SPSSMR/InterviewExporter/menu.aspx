<%@ Page language="c#" Codebehind="menu.aspx.cs" Inherits="InterviewExporter.menu" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>menu</title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<link href="../shared/coolmenu/spssmenu.css" type="text/css" rel="stylesheet">
		<script type="text/javascript" src="../shared/coolmenu/coolmenus4.js">  
			    /*****************************************************************************
			    Copyright (c) 2001 Thomas Brattli (www.bratta.com)
    			
			    eXperience DHTML coolMenus - Get it at www.bratta.com
			    Version 3.02
			    This script can be used freely as long as all copyright messages are
			    intact. 
			    ******************************************************************************/
		</script>
		<link href="../shared/tabs/spsstabs.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../Shared/Tabs/tabctrl.js"></script>
		<script language="javascript">
			function doCloseApp() 
			{
				var f = top.frames[0].document.forms("collections");
				var exportButton = f.document.getElementById("btnExport");
				exportButton.disabled = true;
			
				var exitURL = '<%=ApplicationUtils.WebApplicationSettings.LauncherStartURL!=null?ApplicationUtils.WebApplicationSettings.LauncherStartURL.ToString():""%>';
				if ( exitURL == '' )
					window.close();
				else
					top.location.replace( exitURL );
			}	    
		</script>
	</HEAD>
	<body class="Menu" leftMargin="0" topMargin="0">
		<form id="Menu" method="post" runat="server">
		</form>
	</body>
</HTML>
