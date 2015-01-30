<%@ Page language="c#" Codebehind="Chain_NewProject.aspx.cs" AutoEventWireup="false" Inherits="ProjectEditor.Chain_NewProject" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>Chain_NewProject</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<!-- STANDARD FUNCTIONS FOR THIS APP -->
		<script type="text/javascript" src="general.js"></script>
		<!-- DIALOG LIB -->
		<script type="text/javascript" src="../Shared/Dialog/dialog.js"></script>
		<link type="text/css" rel="stylesheet" href="../shared/spssmrNet.css">
		<script type="text/javascript">
		<!--
			function showNewProjectDialog( strUILanguage, strProject ) {
				var url = 'dlgNewProject.aspx?lang='+strUILanguage;
				var rv = doDialog(url);
				if ( rv == null ) {
					// dialog was just closed - No project was created
					handleChainEnd( {status:'cancel'} );
				}
				else if ( rv.status == 'ok' ) {
					// "OK" was pressed in dialog - A project was created:
				//    Project Name : rv.project
				//    Application  : rv.application
					handleChainContinue( {status:'ok'} );
				}
				else if ( rv.status == 'cancel' ) {
					// "Cancel" pressed in the dialog - No project created
					handleChainEnd( {status:'cancel'} );
				}
				else {
					// Unknown return value returned from the dialog! - Error!
					handleChainEnd( {status:'error'} );
				}
			}
		-->
		</script>
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="Chain_NewProject" method="post" runat="server">
		</form>
		<%
			Response.Write( WriteNextAppForm() );
		%>
	</body>
</html>
