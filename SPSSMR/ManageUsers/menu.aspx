<%@ Page language="c#" Codebehind="Menu.aspx.cs" Inherits="ManageUsers.Menu" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS ManageUsers</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="jsinclude.js"></script>
		<!-- Menu stylesheet and javascript files -->
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
		<script type="text/javascript">
		window.onbeforeunload=function()
		{
		    if (document.body.offsetWidth-50<event.clientX && event.clientY<0)      
		        window_onunload();  
		}
		</script>

	</HEAD>
	<body class="Menu">
		<form id="menu" method="post" runat="server">
			<a id="exitLink" runat="server" target="_top" style="DISPLAY: none"></a>
		</form>
	</body>
</HTML>
