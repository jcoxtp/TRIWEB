<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="pfs.asp" -->
<!-- #include file="fmutil.asp" -->
<%
	Dim oPFS
	Set oPFS = New ProjectfileSelection
	
	oPFS.SetXML unescape(Session.Value("PFSData"))
	Dim strLiterals
	strLiterals = Server.MapPath( "res/literals" )
	
	Dim strMasterDate, strUserDate
	strMasterDate = oPFS.GetWorkspaceAttribute("masterworkspace", "filedate")
	strUserDate   = oPFS.GetWorkspaceAttribute("userworkspace", "filedate")
%>
<html>
	<head>
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="filemgr.css" />
		<script language="javascript" src="dialog.js"></script>
		<script language="javascript" src="pfs_gui.js"></script>
		<script language="javascript">
			// initialize vars from pfs_gui.js
			// function confirmOverwrite()
			masterFileExists = <%=oPFS.GetWorkspaceAttribute("masterworkspace", "fileexists")%>;
			userFileExists	 = <%=oPFS.GetWorkspaceAttribute("userworkspace", "fileexists")%>;
			
			strConfirmMasterOverwriteUser        = '<%=Replace(Replace(GetLanguageLiteral("pfs_gui_confirmmasteroverwriteuser", strLiterals, oPFS.GetLanguage()), "{0}", strUserDate), "{1}", strMasterDate)%>';
			strConfirmNewOverwriteMasterUser     = '<%=Replace(GetLanguageLiteral("pfs_gui_confirmnewoverwritemasteruser", strLiterals, oPFS.GetLanguage()), "{0}", strUserDate)%>';
			strConfirmNewOverwriteMaster         = '<%=Replace(GetLanguageLiteral("pfs_gui_confirmnewoverwritemaster", strLiterals, oPFS.GetLanguage()), "{0}", strMasterDate)%>';
			strConfirmNewOverwriteUser           = '<%=Replace(GetLanguageLiteral("pfs_gui_confirmnewoverwriteuser", strLiterals, oPFS.GetLanguage()), "{0}", strUserDate)%>';
			strConfirmUploadOverwriteMasterUser  = '<%=Replace(GetLanguageLiteral("pfs_gui_confirmuploadoverwritemasteruser", strLiterals, oPFS.GetLanguage()), "{0}", strUserDate)%>';
			strConfirmUploadOverwriteMaster      = '<%=Replace(GetLanguageLiteral("pfs_gui_confirmuploadoverwritemaster", strLiterals, oPFS.GetLanguage()), "{0}", strMasterDate)%>';
			strConfirmUploadOverwriteUser        = '<%=Replace(GetLanguageLiteral("pfs_gui_confirmuploadoverwriteuser", strLiterals, oPFS.GetLanguage()), "{0}", strUserDate)%>';
			
			function clickItem( elmID ) {
				var e = document.getElementById(elmID);
				if ( e != null ) {
					e.click();
				}
			}
		</script>
	</head>
	<body tabIndex="-1">
	<%
		Response.Write(oPFS.Transform("pfs_gui.xslt"))
		
		Set oPFS = Nothing
	%>
	</body>
</html>
