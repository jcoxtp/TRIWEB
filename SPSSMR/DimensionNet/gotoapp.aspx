<%@Page Inherits="Launcher.GotoAppClass"%>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS DimensionNet</title> <!-- 
 * Warning: this computer program is protected by
 * copyright law and international treaties.
 * Unauthorized reproduction or distribution of this
 * program, or any portion of it, may result in severe
 * civil and criminal penalties, and will be procecuted * to the maximum extent of the law. *  * Copyright (c) 2001-2002 SPSS Ltd. -->
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="STYLESHEET">
		<SCRIPT LANGUAGE='JavaScript'>
		function gotoApp()
		{
			document.getElementById("frmLauncher").submit();
		}
		</SCRIPT>
	</HEAD>
	<body id="body" runat=server>
		<asp:label id="lblInfo" runat="server"></asp:label><br>
		<asp:label id="lblReturn" runat="server"></asp:label><br>
		<div id="divForm" runat="server"></div>
	</body>
</HTML>
