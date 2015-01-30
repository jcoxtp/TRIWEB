<%@ Page language="c#" Codebehind="Import.aspx.cs" Inherits="ManageUsers.Import"  %>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
	<head>
		<title>
			<%=TitleText%>
		</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta name="CODE_LANGUAGE" content="C#">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="jsinclude.js"></script>
	</head>
	<body bottomMargin="<%=bottomMargin%>" leftMargin="<%=leftMargin%>" topMargin="<%=topMargin%>" rightMargin="<%=rightMargin%>" MS_POSITIONING="GridLayout">
		<form id="Import" tabindex="-1" name="Import" method="post" enctype="multipart/form-data"
			runat="server">
			<asp:panel id="FilePanel" runat="server" visible="true">
				<table>
					<tr>
						<td><%=SpecifyFile%></td>
					</tr>
					<tr>
						<td>
							<table class="OuterTable" width="100%">
								<tr>
									<td>
										<table class="InnerTable" cellspacing="2">
											<tr>
												<td class="InnerTableMainDataDark">
													<div id="labelFile"><%=FileToUploadText%></div>
												</td>
												<td class="InnerTableMainDataDark"><input id="fileToUpload" tabindex="1" type="file" size="40" name="fileToUpload" runat="server">
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<div class="errortext">
														<asp:label id="UploadError" runat="server"></asp:label></div>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr align="right">
						<td>
							<asp:button id="okButton" tabindex="2" runat="server" cssclass="stdbutton" ></asp:button>&nbsp;
							<input class="stdbutton" id="cancelButton" onclick="javascript:window.close();" tabindex="3"
								type="button" name="cancelButton" runat="server">
						</td>
					</tr>
				</table>
			</asp:panel>
			<asp:panel id="ProgressPanel" runat="server" visible="false">
				<table height="100%" cellspacing="0" cellpadding="0" width="100%">
					<tr class="DarkBlueBackground" valign="middle" align="center">
						<td><img src="Shared/images/molecules.gif">
						</td>
					</tr>
					<tr valign="middle" align="center" height="50%">
						<td align="left"><iframe marginwidth=0 src="Progress.aspx?hash=<%=Hash%>" 
      frameborder=0 
width="100%"></iframe>
						</td>
					</tr>
				</table>
			</asp:panel>
			<asp:panel id="ParseResultsPanel" runat="server" visible="false" borderwidth="0px">
				<table width="100%">
					<tr width="100%">
						<td><%=InfoParseErrors%></td>
					</tr>
					<tr width="100%">
						<td>
							<asp:textbox id="ParseResultsTextBox" runat="server" width="580" height="190" textmode="MultiLine"
								wrap="False"></asp:textbox></td>
					</tr>
					<tr width="100%">
						<td align="right"><%=InfoParseContinue%></td>
					</tr>
					<tr width="100%">
						<td align="right">
							<asp:button id="ParseOKButton" tabindex="2" runat="server" cssclass="stdbutton"></asp:button>&nbsp;
							<asp:button id="ParseCancelButton" tabindex="3" runat="server" cssclass="stdbutton"></asp:button></td>
					</tr>
				</table>
			</asp:panel>
			<asp:panel id="ImportResultsPanel" runat="server" visible="false">
				<table>
					<tr>
						<td><%=InfoComplete%></td>
					</tr>
					<tr>
						<td width="100%">
							<asp:textbox id="ImportResultsTextBox" runat="server" width="580" height="190" textmode="MultiLine"
								wrap="False"></asp:textbox></td>
					</tr>
					<tr>
						<td align="right"><input class="stdbutton" id="closeButton" onclick="javascript:_refreshOpenerWindows();window.close();"
								tabindex="3" type="button" name="closeButton" runat="server">
						</td>
					</tr>
				</table>
			</asp:panel>
			<asp:panel id="AbortPanel" runat="server" visible="false">
				<table height="100%" width="100%">
					<tr valign="top" height="100%">
						<td><%=InfoAbort%></td>
					</tr>
					<tr>
						<td align="right">
							<asp:button id="AbortCloseButton" tabindex="3" runat="server" cssclass="stdbutton"></asp:button></td>
					</tr>
				</table>
			</asp:panel>
			
			<asp:panel id="ImportSuccessful" runat="server" visible="false">
				<table height="100%" width="100%">
					<tr valign="top" height="100%">
						<td><%=InfoSuccessful%></td>
					</tr>
					<tr>
						<td align="right">
							<asp:button id="btnOK" tabindex="3" runat="server" cssclass="stdbutton"></asp:button></td>
					</tr>
				</table>
			</asp:panel>
			
		</form>
	</body>
</html>
