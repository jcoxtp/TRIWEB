<%@ Page Inherits="Launcher.CollectionsClass" CodeBehind="Collections.aspx.cs" Language="c#" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS DimensionNet</title>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"> <!-- 
 * Warning: this computer program is protected by
 * copyright law and international treaties.
 * Unauthorized reproduction or distribution of this
 * program, or any portion of it, may result in severe
 * civil and criminal penalties, and will be procecuted * to the maximum extent of the law. *  * Copyright (c) 2001-2002 SPSS Ltd. -->
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body style="OVERFLOW: scroll" target="frmeRHS" >
		<table border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
			<tr>
				<td width="100%">
					<%if ((String.Compare((string)Request.QueryString["proj"], "") != 0) && (Request.QueryString["proj"] != null))
			Response.Write("<iframe name='ProjList' frameborder='no' src='projlist.aspx?hash="+(string)Request.QueryString["hash"]+"&proj="+(string)Request.QueryString["proj"]+"' marginheight=5 marginwidth=5 height='100%' width='100%' scrolling='no'>");
		else
			Response.Write("<iframe name='ProjList' frameborder='no' src='projlist.aspx?hash="+(string)Request.QueryString["hash"]+"' marginheight=5 marginwidth=5 height='100%' width='100%' scrolling='no'>");
		%>
					</IFRAME></td>
			</tr>
		</table>
		<br>
	</body>
</HTML>
