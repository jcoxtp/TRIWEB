<%@Page Inherits="Launcher.ProjectAppsClass"%>
<%@ OutputCache Location="none" %>
<%@ Reference Control="ProjectInfoControl.ascx" %>
<%@ Reference Control="RoundedTableControl.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
		<title>SPSS DimensionNet</title> <!-- 
 * Warning: this computer program is protected by
 * copyright law and international treaties.
 * Unauthorized reproduction or distribution of this
 * program, or any portion of it, may result in severe
 * civil and criminal penalties, and will be procecuted * to the maximum extent of the law. *  * Copyright (c) 2001-2002 SPSS Ltd. -->
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="jsinclude.js">
		
		</script>
  </HEAD>
	<body onload="init();">
		<form id="ProjectAppsClass" runat="server">
			<asp:PlaceHolder id="phProjectInfo" runat="server"></asp:PlaceHolder><br>
			<asp:PlaceHolder id="phActivities" runat="server"></asp:PlaceHolder><br>
			<div align=center><asp:Label id=txtLoading runat="server"></asp:Label></div>
		</form>
		<div id="reloader" runat="server"></div>
		<div id="alerter" runat="server"></div>
	</body>
</HTML>
