<%@ Page ASPCompat="True" CodeBehind="MDMProperties.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="VB.MDMProperties" %>
<%@ OutputCache Location="none" %>
<html>
	<head>
		<title><%=Server.HtmlEncode(VB.Utilities.I18N.GetLanguageLiteral("mdm-properties-dialog-title", Request.QueryString("langres")))%></title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="spssmrNet.css">
		<script type="text/javascript" src="datalinkdialog.js"></script>
		<script type="text/javascript">
			function doOK()
			{
				ctx = document.getElementById("Contexts").value
				lang = document.getElementById("Languages").value
				lbl = document.getElementById("LabelTypes").value
				ver = document.getElementById("CurrentVersion").innerHTML
				result = { version:ver, context:ctx, language:lang, labeltype:lbl }
				closeDialog(result)    
			}

			function doCancel()
			{
				closeDialog()
			}

			function getText(dest, src)
			{	
				// depending on aspx output, some fields may be missing	
				getText2(document.getElementById(dest), src)
			}

			function getText2(field, src)
			{
				text = document.getElementById(src)
				if(text && field)
				{
					text = text.value			
					if(field.type == "submit")
						field.value = text
					else if(field.innerHTML)
						field.innerHTML = text
					else
					field.text = text			
				}
			}
		</script>
	</head>
	<body>
		<form ID="MDMProperties" RunAt="Server">
			<asp:Panel ID="MainPanel" RunAt="Server">
				<H3>
					<asp:Label id="MDMPropertiesLabel" RunAt="Server" Text="MDM Properties"></asp:Label></H3><B>
					<asp:Label id="CurrentVersionLabel" RunAt="Server" Text="Current version:"></asp:Label></B>
					<asp:Label id="CurrentVersion" RunAt="Server"></asp:Label><BR><BR><EM>
					<asp:Label id="BadVersion" RunAt="Server" Text="Bad Version:" Visible="False"></asp:Label></EM>
					<asp:TextBox id="EditVersion" RunAt="Server" OnTextChanged="ApplyVersion_Click"></asp:TextBox>
					<asp:Button id="ApplyVersion" onclick="ApplyVersion_Click" RunAt="Server" Text="Apply" CssClass="stdbutton" Width="100px"></asp:Button><BR>
					<asp:Button id="ApplyLatest" onclick="ApplyLatest_Click" RunAt="Server" Text="Latest" CssClass="stdbutton" Width="100px"></asp:Button>
					<asp:Button id="ApplyAll" onclick="ApplyAll_Click" RunAt="Server" Text="All" CssClass="stdbutton" Width="100px"></asp:Button><BR><BR><B>
					<asp:Label id="Versions" RunAt="Server" Text="Versions:"></asp:Label></B><BR>
					<DIV style="OVERFLOW-Y: auto; WIDTH: 100%; HEIGHT: 200px">
						<ASP:DataGrid id="VersionGrid" RunAt="server" CellSpacing="0" CellPadding="3" Width="100%" GridLines="Both" BorderWidth="1" BorderColor="black">
							<HeaderStyle BackColor="#aaaadd" Wrap="False"></HeaderStyle>
							<ItemStyle Wrap="False"></ItemStyle>
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<asp:checkbox ID="VersionSelect" AutoPostBack="True" OnCheckedChanged="CheckVersion_Click" Runat="Server" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</ASP:DataGrid>
					</DIV><BR><B>
					<asp:Label id="LanguagesLabel" RunAt="Server" Text="Languages:"></asp:Label></B><BR>
					<asp:DropDownList id="Languages" RunAt="Server"></asp:DropDownList><BR><BR><B>
					<asp:Label id="ContextsLabel" RunAt="Server" Text="Contexts:"></asp:Label></B><BR>
					<asp:DropDownList id="Contexts" RunAt="Server"></asp:DropDownList><BR><BR><B>
					<asp:Label id="LabelTypesLabel" RunAt="Server" Text="Label Types:"></asp:Label></B><BR>
					<asp:DropDownList id="LabelTypes" RunAt="Server"></asp:DropDownList>
					<BR><BR>
					<INPUT type="button" class="stdbutton" runat="server" id="OKButton" onclick="doOK()" value="OK">&nbsp;
					<INPUT type="button" class="stdbutton" runat="server" id="CancelButton" onclick="doCancel()" value="Cancel">
			</asp:Panel>
			<asp:Panel ID="ErrorPanel" Visible="False" RunAt="Server">
				<BR>
				<BR>
				<asp:Panel id="DocumentError" RunAt="Server" Visible="False">
					<H2><EM>
							<asp:Label id="DocumentErrorLabel" RunAt="Server" Text="Error Processing Document"></asp:Label></EM></H2>
					<BR>
				</asp:Panel>
				<asp:Panel id="UnableToOpenDocumentError" RunAt="Server" Visible="False">
					<H2><EM>
							<asp:Label id="UnableToOpenDocument" RunAt="Server" Text="Unable to open Document"></asp:Label></EM></H2>
					<BR>
					<asp:Label id="DocumentPathLabel" RunAt="Server" Text="Document path: "></asp:Label>
					<asp:Label id="DocumentPathName" RunAt="Server"></asp:Label>
				</asp:Panel>
				<asp:Panel id="MDSCNotSupportedError" RunAt="Server" Visible="False">
					<H2><EM>
							<asp:Label id="MDSCNotSupported" RunAt="Server" Text="MDSC metadata not supported"></asp:Label></EM></H2>
					<BR>
				</asp:Panel>
				<BR>
				<BR>
				<INPUT type="button" class="stdbutton" runat="server" id="ErrorButton" onclick="doCancel()" value="OK">
			</asp:Panel>
		</form>
	</body>
</html>
