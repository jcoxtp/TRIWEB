<%@ Page language="c#" Codebehind="dlgUploadExistingData.aspx.cs" AutoEventWireup="false" Inherits="ProjectEditor.dlgUploadExistingData" %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgUploadExistingData_title"))%>
		</title>
		<base target="_self" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script src="general.js" type="text/javascript"></script>
		<script src="Shared/Dialog/dialog.js" type="text/javascript"></script>
		<script src="dlgUploadExistingData.js" type="text/javascript"></script>
		<script src="CustomDialog/MessageBox.js" type="text/javascript"></script>
		<LINK href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onkeydown="keyWasPressed()" tabIndex="-1">
		<table>
			<tr>
				<td>
					<form id="dlgUploadExistingData" method="post" encType="multipart/form-data" runat="server">
						<table class="OuterTable">
							<tr>
								<td>
									<input id="doResizeWindow" type="hidden" value="1" name="doResizeWindow" runat="server">
									<input id="hConfirmedOverwrite" type="hidden" name="hConfirmedOverwrite" runat="server">
									<input id="hConfirmedRename" type="hidden" name="hConfirmedRename" runat="server">
									<asp:button id="btnFinishServer" style="DISPLAY: none" onclick="btnFinishServer_Click" Runat="server"></asp:button>
									<asp:button id="btnTestConnectionServer" Runat="server" style="DISPLAY: none" OnClick="btnTestConnectionServer_Click"></asp:button>
									<asp:Button id="btnUpload" Runat="server" style="DISPLAY: none" OnClick="btnUpload_Clicked"></asp:Button>
									<table class="InnerTable" cellSpacing="2">
										<tr>
											<td class="InnerTableMainDataDark" style="WIDTH: 1%">
												<DIV id="lblDataType" style="DISPLAY: inline; WIDTH: 70px; HEIGHT: 15px" noWrap runat="server"
													ms_positioning="FlowLayout">Data Type:</DIV>
											</td>
											<td class="InnerTableMainDataDark"><select id="cbDataType" style="WIDTH: 344px" name="cbDataType" runat="server"></select>
											</td>
										</tr>
										<tr>
											<td class="InnerTableMainDataDark" style="WIDTH: 1%">
												<DIV id="lblFileToUpload" style="DISPLAY: inline; WIDTH: 10px; HEIGHT: 15px" noWrap runat="server">File 
													to upload:</DIV>
											</td>
											<td class="InnerTableMainDataDark">
											    <INPUT id="fUploadFile" style="WIDTH: 344px" type="file" name="fUploadFile" runat="server"
													onkeypress="return uploadFile_KeyPressed()" onchange="uploadFile_Changed()">
											</td>
										</tr>
										<tr>
											<td class="InnerTableMainDataDark" style="WIDTH: 1%; VERTICAL-ALIGN: top">
												<DIV id="lblFilesUploaded" style="DISPLAY: inline; WIDTH: 10px; HEIGHT: 15px" noWrap
													runat="server">File(s) uploaded:</DIV>
											</td>
											<td class="InnerTableMainDataDark">
												<div id="lblFileList" style="DISPLAY: inline" runat="server">(none)
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<table style="WIDTH: 100%" border="0">
							<tr>
								<td>&nbsp;<input id="btnTestConnection" onclick="btnTestConnection_ClickedClient()" type="button"
										value="Test Connection" name="btnTestConnection" runat="server">
								</td>
								<td style="TEXT-ALIGN: right">
									<div style="OVERFLOW: visible; WHITE-SPACE: nowrap"><input class="stdbutton" id="btnFinish" onclick="javascript:btnFinish_ClickedClient()"
											type="button" value="Finish" name="btnFinish" runat="server"> &nbsp;
									</div>
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
		</table>
		<div id="EventFormDiv" runat="server" style="DISPLAY: none"></div>
		<IFRAME id="KeepAliveFrame" runat="server" style="DISPLAY: none; WIDTH: 0px; HEIGHT: 0px" src="shared/sessionkeepalive.aspx">
		</IFRAME>
	</body>
</HTML>
