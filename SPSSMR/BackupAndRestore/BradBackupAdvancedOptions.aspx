<%@ Page language="c#" Codebehind="BradBackupAdvancedOptions.aspx.cs" AutoEventWireup="false" Inherits="Brad.BradBackupAdvancedOptions" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=SetDocumentTitle()%>
		</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<!-- SPSS applications stylesheet --><LINK href="../Shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<script> 
			function CloseWindow()
			{
				window.close();
			}
		</script>
		<!--<body MS_POSITIONING="GridLayout">-->
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<asp:button id="btnCancel" style="Z-INDEX: 102; LEFT: 550px; POSITION: absolute; TOP: 630px"
				Width="80px" runat="server" Text="btnCancel" tabIndex="17"></asp:button>
			<asp:button id="btnOk" style="Z-INDEX: 102; LEFT: 450px; POSITION: absolute; TOP: 630px" Width="80px"
				runat="server" Text="btnOk" tabIndex="16"></asp:button>
			<asp:label id="lblBackupProps" runat="server" Font-Size="Medium">lblBackupProps</asp:label>
			<TABLE class="style1" id="Table1">
				<TR>
					<TD>
						<TABLE id="FilesProperties" width="100%">
							<TR>
								<TH align="left">
									<asp:label id="lblFilesProps" runat="server">lblFilesProps</asp:label></TH></TR>
							<TR>
								<TD>
									<asp:checkbox id="chkFilesUsers" tabIndex="1" runat="server"></asp:checkbox></TD>
							</TR>
							<TR>
								<TD>
									<asp:checkbox id="chkFilesShared" tabIndex="2" runat="server"></asp:checkbox></TD>
							</TR>
							<TR>
								<TD>
									<asp:checkbox id="chkFilesScriptDir" tabIndex="3" runat="server"></asp:checkbox>
									<asp:textbox id="txtScriptFiles" tabIndex="4" runat="server" Width="350px"></asp:textbox>
									<asp:label id="lblScriptDirError" runat="server" CssClass="errortext">lblScriptDirError</asp:label></TD>
							</TR>
							<TR>
								<TD style="HEIGHT: 24px">
									<asp:checkbox id="chkFilesFMRootMaster" tabIndex="5" runat="server"></asp:checkbox></TD>
							</TR>
							<TR>
								<TD>
									<asp:checkbox id="chkFilesAdditionalDir" tabIndex="6" runat="server"></asp:checkbox>
									<asp:textbox id="txtAdditionalFiles" tabIndex="7" runat="server" Width="350px"></asp:textbox>
									<asp:label id="lblAdditionalDirError" runat="server" CssClass="errortext">lblAdditionalDirError</asp:label></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
						<TABLE id="DBProperties" width="100%">
							<TR>
								<TH align="left">
									<asp:label id="lblDBProps" runat="server">lblDBProps</asp:label></TH></TR>
							<TR>
								<TD>
									<asp:checkbox id="chkDBSample" tabIndex="8" runat="server"></asp:checkbox></TD>
							</TR>
							<TR>
								<TD>
									<asp:checkbox id="chkDBQuota" tabIndex="9" runat="server"></asp:checkbox></TD>
							</TR>
							<TR>
								<TD>
									<asp:checkbox id="chkDBData" tabIndex="10" runat="server"></asp:checkbox>
									<asp:checkbox id="chkDBCreateTableOnly" tabIndex="11" runat="server"></asp:checkbox></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
						<TABLE id="NotesProperties" width="100%">
							<TR>
								<TH align="left">
									<asp:label id="lblNotes" runat="server">lblNotes</asp:label></TH></TR>
							<TR>
								<TD>
									<asp:checkbox id="chkMoreNotes" tabIndex="12" runat="server"></asp:checkbox>
									<asp:textbox id="txtAdditionalNotes" tabIndex="13" runat="server" Width="448px" Height="90px"></asp:textbox></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD>
						<TABLE id="Misc" width="100%">
							<TR>
								<TH align="left">
									<asp:label id="lblMisc" runat="server">lblMisc</asp:label></TH></TR>
							<TR>
								<TD>
									<asp:checkbox id="chkDeleteLastBackup" tabIndex="14" runat="server" Enabled="True"></asp:checkbox></TD>
							</TR>
							<TR>
								<TD>
									<asp:label id="lblBackupLocation" runat="server">lblBackupLocation</asp:label>
									<asp:textbox id="txtBackupLocation" tabIndex="15" runat="server" Width="350px"></asp:textbox>
									<asp:label id="lblLocationError" runat="server" CssClass="errortext">lblLocationError</asp:label></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
