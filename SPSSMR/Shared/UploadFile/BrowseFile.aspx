<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="BrowseFile.aspx.cs" AutoEventWireup="false" Inherits="SPSSMR.Web.UI.UploadFile.BrowseFile" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=Server.HtmlEncode(SPSSMR.Web.UI.UploadFile.Utilities.I18N.GetResourceString("dlgUploadFiles_dialog_title"))%>
		</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../spssmrNet.css" type="text/css" rel="stylesheet">		
	</HEAD>
	<body>
		<base target="_top">
		<form id="frmUpload" method="post" encType="multipart/form-data" runat="server">
			<table width="330">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td id="tdSelectFile" align="left" runat="server">
                                    </td>
							<tr>
							<tr>
								<td><input id="fileUpload" type="file" size="30" name="fileUpload" ><br>
								</td>
							<tr>
								<td><asp:button id="btnUpload" runat="server"></asp:button>&nbsp;<input id="btnClose" onclick="javascript:window.top.close();" type="button" runat="server"></td>
							</tr>
							<tr>
								<td>
									<asp:Label id="lblError" runat="server"></asp:Label></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<script type="text/javascript" src="scripts/jsinclude.js"></script>
		<script type="text/javascript">
            InitHandler();
		</script>
	</body>
</HTML>
