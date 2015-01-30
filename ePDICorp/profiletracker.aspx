<%@ Page language="c#" Codebehind="profiletracker.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.profiletracker" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>profiletracker</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE id="Table1" style="Z-INDEX: 101; LEFT: 8px; POSITION: absolute; TOP: 8px" cellSpacing="1"
				cellPadding="1" border="0">
				<tr>
					<td>
						<img src="images/header.gif" alt="" width="791" height="89">
					</td>
				</tr>
				<tr>
					<td>
						<a href="http://www.pdiprofile.com/pdi/main.asp?res=<%=intResellerID%>">PDI Home</a>&nbsp;|
						<a href="http://www.pdiprofile.com/pdi/logout.asp?res=<%=intResellerID%>">Logout</a>&nbsp;
					</td>
				</tr>
				<TR>
					<TD><h1>Test Results</h1>
						Search:&nbsp;
						<asp:DropDownList id="ddlWhereField" runat="server">
							<asp:ListItem Value="TestCode">PDI Profile Code</asp:ListItem>
							<asp:ListItem Value="LastName">User Last Name</asp:ListItem>
							<asp:ListItem Value="EmailAddress">Email Address</asp:ListItem>
						</asp:DropDownList>&nbsp;for&nbsp;
						<asp:TextBox id="txtWhereValue" runat="server"></asp:TextBox>&nbsp;
						<asp:Button id="btnSearch" runat="server" Text="Search"></asp:Button>&nbsp;&nbsp;
						<asp:LinkButton id="btnClearSearch" runat="server">Clear Search Criteria</asp:LinkButton>
					</TD>
				</TR>
				<TR>
					<TD>
						<asp:DataGrid id=dtgProfileResults runat="server" DataSource="<%# profileTrackerDataset1 %>" DataMember="vw_ProfileTrackingResults" AllowPaging="True" AllowSorting="True" PageSize="20" ShowFooter="True" AutoGenerateColumns="False" DataKeyField="TestCode">
							<AlternatingItemStyle BackColor="#DDDDDD"></AlternatingItemStyle>
							<HeaderStyle Font-Bold="True"></HeaderStyle>
							<Columns>
								<asp:HyperLinkColumn DataNavigateUrlField="PDFFileName" DataNavigateUrlFormatString="../../pdfreports/{0}"
									DataTextField="TestCode" SortExpression="TestCode" HeaderText="Test&amp;nbsp;Code"></asp:HyperLinkColumn>
								<asp:BoundColumn DataField="PurchaseDate" SortExpression="PurchaseDate DESC" HeaderText="Purchased"
									DataFormatString="{0:MM/dd/yyyy}">
									<ItemStyle Width="90px"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="Redeemed" SortExpression="Redeemed ASC, PurchaseDate DESC" HeaderText="Used">
									<ItemStyle Width="40px"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="TestTaker" SortExpression="TestTaker" HeaderText="Test Taker">
									<ItemStyle Width="150px"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="TestStartDate" SortExpression="TestStartDate DESC" HeaderText="Started"
									DataFormatString="{0:MM/dd/yyyy}">
									<ItemStyle Width="90px"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="TestCompleteDate" SortExpression="TestCompleteDate DESC" HeaderText="Completed"
									DataFormatString="{0:MM/dd/yyyy}">
									<ItemStyle Width="90px"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="HighFactorType1" SortExpression="HighFactorType1 ASC, TestStartDate DESC"
									HeaderText="Type 1">
									<ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="HighFactorType2" SortExpression="HighFactorType2 ASC, TestStartDate DESC"
									HeaderText="Type 2">
									<ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="RepProfileName" SortExpression="RepProfileName ASC, TestStartDate DESC"
									HeaderText="Profile">
									<ItemStyle Width="90px"></ItemStyle>
								</asp:BoundColumn>
								<asp:BoundColumn DataField="Area" SortExpression="Area ASC, TestStartDate DESC" HeaderText="Area"></asp:BoundColumn>
							</Columns>
							<PagerStyle Mode="NumericPages"></PagerStyle>
						</asp:DataGrid></TD>
				</TR>
				<TR>
					<TD>
						<asp:TextBox id="hidSortExpression" runat="server" Visible="False">TestCompleteDate DESC</asp:TextBox></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
