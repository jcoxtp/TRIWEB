<%@ Control Language="vb" AutoEventWireup="false" Codebehind="mrWebExplorerCtrl.ascx.vb" Inherits="mrWebExplorer.mrWebExplorerCtrl" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<html>
	<head>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<title>
			<%=DialogTitle%>
		</title>
		<script type="text/javascript">
			if ( top.dialogHeight != null )
				top.dialogHeight = '500px';
			else if ( top.innerHeight != null )
				top.innerHeight = 500;
			
			if ( top.dialogWidth != null )
				top.dialogWidth = '800px';
			else if ( top.innerWidth != null)
				top.innerWidth = 800;
		</script>
	</head>
	<frameset rows="0,40,*" frameborder="0" border="0" framespacing="0">
		<frame name="frmFilemgrAction" id="frmFilemgrAction" src="<%=TemplateSourceDirectory%>/action.aspx" frameborder="0" marginwidth="0" noresize />
		<frame name="frmFilemgrCmdStatus" id="frmFilemgrCmdStatus" src="<%=TemplateSourceDirectory%>/CmdStatus.aspx" frameborder="1" scrolling="auto" marginwidth="0" noresize />
		<frameset cols="30%,*" frameborder="1" framespacing="5">
			<frame name="frmFilemgrSrcTree" id="frmFilemgrSrcTree" src="<%=TemplateSourceDirectory%>/srctree.aspx" frameborder="0">
			<frame name="frmFilemgrFilelist" id="frmFilemgrFilelist" src="<%=TemplateSourceDirectory%>/filelist.aspx" frameborder="0">
		</frameset>
	</frameset>

</html>
