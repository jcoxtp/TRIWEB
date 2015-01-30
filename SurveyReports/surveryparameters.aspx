<%@ Page language="c#" Codebehind="surveryparameters.aspx.cs" AutoEventWireup="false" Inherits="SurveyReports.surveryparameters" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>surveryparameters</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" border="1">
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>
						Database:</TD>
					<TD>
						<asp:DropDownList id="ddlDatabase" runat="server" Width="256px">
							<asp:ListItem Value="pdi">PDI Database</asp:ListItem>
							<asp:ListItem Value="cas" Selected="True">Survey Database</asp:ListItem>
						</asp:DropDownList></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>Enter report filename:</TD>
					<TD>
						<asp:TextBox id="txtReportFilename" runat="server" Width="256px"></asp:TextBox></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<asp:Button id="btnGetParameters" runat="server" Text="Get Parameters"></asp:Button></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<asp:DataGrid id="DataGrid1" runat="server" AutoGenerateColumns="False">
							<Columns>
								<asp:TemplateColumn HeaderText="Parameter Name">
									<ItemTemplate>
										<asp:Label runat="server" ID="paramKey" Text='<%# DataBinder.Eval(Container, "DataItem.ParameterName") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="Parameter Value">
									<ItemTemplate>
										<asp:TextBox Runat="server" ID="paramValue"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD>
						<asp:Button id="btnRunReport" runat="server" Text="Run Report"></asp:Button></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
