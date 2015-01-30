<%@ Page language="c#" Codebehind="PurchaseProduct.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.PurchaseProduct" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script src="findDOM.js"></script>
		<script src="CtrlBehavior.js"></script>
		<LINK href="styles.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<TABLE id="Table1" cellSpacing="8" cellPadding="2" align="center" border="0">
				<TR>
					<td vAlign="top" align="center" width="15%" rowSpan="3" class="left-column"><br>
						<br>
					</td>
					<TD class="style1" align="center" width="70%">Purchase Profile Code</TD>
					<td vAlign="top" align="center" width="15%" rowSpan="3" class="right-column"><br>
						<br>
						<div class="style1-body" align="right">
						</div>
					</td>
				</TR>
				<TR>
					<TD class="section-divline" width="70%">&nbsp;</TD>
				</TR>
				<tr>
					<td width="70%" class="center-column">
						<p>
							<asp:Label id="lblProductInfo" runat="server" Width="408px" Font-Bold="True" Font-Size="14pt">Label</asp:Label>
							<TABLE id="Table4" cellSpacing="3" cellPadding="1" border="0" style="BORDER-RIGHT: #435b69 1px solid; BORDER-TOP: #435b69 1px solid; BORDER-LEFT: #435b69 1px solid; BORDER-BOTTOM: #435b69 1px solid">
								<TBODY>
									<TR>
										<TD style="WIDTH: 105px" align="right"></TD>
										<TD></TD>
										<TD></TD>
										<td rowspan="17" vAlign="top">
											<asp:ValidationSummary id="ValidationSummary1" runat="server"></asp:ValidationSummary>&nbsp;</td>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">Credit Card:</TD>
										<TD>
											<asp:textbox id="txtCCNum" runat="server" Width="228px" CssClass="standard-text"></asp:textbox></TD>
										<TD>
											<asp:RequiredFieldValidator id="RequiredFieldValidator8" runat="server" ErrorMessage="Credit card number required"
												ControlToValidate="txtCCNum">*</asp:RequiredFieldValidator></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">Expiration Date:</TD>
										<TD>Month:&nbsp;&nbsp;
											<asp:dropdownlist id="ddlMonth" runat="server" CssClass="standard-text">
												<asp:ListItem Value="01">01</asp:ListItem>
												<asp:ListItem Value="02">02</asp:ListItem>
												<asp:ListItem Value="03">03</asp:ListItem>
												<asp:ListItem Value="04">04</asp:ListItem>
												<asp:ListItem Value="05">05</asp:ListItem>
												<asp:ListItem Value="06">06</asp:ListItem>
												<asp:ListItem Value="07">07</asp:ListItem>
												<asp:ListItem Value="08">08</asp:ListItem>
												<asp:ListItem Value="09">09</asp:ListItem>
												<asp:ListItem Value="10">10</asp:ListItem>
												<asp:ListItem Value="11">11</asp:ListItem>
												<asp:ListItem Value="12">12</asp:ListItem>
											</asp:dropdownlist>&nbsp;&nbsp;&nbsp;Year:&nbsp;&nbsp;
											<asp:dropdownlist id="ddlYear" runat="server" CssClass="standard-text"></asp:dropdownlist></TD>
										<TD></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right"></TD>
										<TD></TD>
										<TD></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">First Name:</TD>
										<TD>
											<asp:textbox id="txtFirstName" runat="server" CssClass="standard-text"></asp:textbox></TD>
										<TD>
											<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="First name required" ControlToValidate="txtFirstName">*</asp:RequiredFieldValidator></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">Last Name:</TD>
										<TD>
											<asp:textbox id="txtLastName" runat="server" CssClass="standard-text"></asp:textbox></TD>
										<TD>
											<asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ErrorMessage="Last name required" ControlToValidate="txtLastName">*</asp:RequiredFieldValidator></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">Address 1:</TD>
										<TD>
											<asp:textbox id="txtAddress1" runat="server" Width="228px" CssClass="standard-text"></asp:textbox></TD>
										<TD>
											<asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" ErrorMessage="Address required" ControlToValidate="txtAddress1">*</asp:RequiredFieldValidator></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">Address 2:</TD>
										<TD>
											<asp:textbox id="txtAddress2" runat="server" Width="228px" CssClass="standard-text"></asp:textbox></TD>
										<TD></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">City:</TD>
										<TD>
											<asp:textbox id="txtCity" runat="server" CssClass="standard-text"></asp:textbox></TD>
										<TD>
											<asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server" ErrorMessage="City required" ControlToValidate="txtCity">*</asp:RequiredFieldValidator></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">State/Province:</TD>
										<TD>
											<asp:textbox id="txtState" runat="server" CssClass="standard-text"></asp:textbox></TD>
										<TD>
											<asp:RequiredFieldValidator id="RequiredFieldValidator5" runat="server" ErrorMessage="State/Province required"
												ControlToValidate="txtState">*</asp:RequiredFieldValidator></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">Postal Code:</TD>
										<TD>
											<asp:textbox id="txtZip" runat="server" CssClass="standard-text"></asp:textbox></TD>
										<TD>
											<asp:RequiredFieldValidator id="RequiredFieldValidator6" runat="server" ErrorMessage="Postal code required"
												ControlToValidate="txtZip">*</asp:RequiredFieldValidator></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">Country:</TD>
										<TD>
											<asp:DropDownList id="ddlCountries" runat="server" Width="228px" CssClass="standard-text"></asp:DropDownList></TD>
										<TD></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">Email Address:</TD>
										<TD>
											<asp:TextBox id="txtEmail" runat="server" Width="228px" CssClass="standard-text"></asp:TextBox></TD>
										<TD>
											<asp:RequiredFieldValidator id="RequiredFieldValidator7" runat="server" ErrorMessage="Email required" ControlToValidate="txtEmail">*</asp:RequiredFieldValidator>
											<asp:RegularExpressionValidator id="revUserEmail" runat="server" ErrorMessage="Your email is not in a valid format."
												ControlToValidate="txtEmail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right"></TD>
										<TD>
											<asp:Button id="btnPurchase" runat="server" CssClass="standard-text" Text="Submit Purchase"></asp:Button></TD>
										<TD></TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">&nbsp;</TD>
										<TD>&nbsp;</TD>
										<TD>&nbsp;</TD>
									</TR>
									<TR>
										<TD style="WIDTH: 105px" align="right">Profile Code:</TD>
										<TD>
											<asp:textbox id="txtProfileCode" runat="server" Width="200px" CssClass="standard-text"></asp:textbox></TD>
					</td>
					<TD></TD>
				</tr>
				<TR>
					<TD style="WIDTH: 105px" align="right"></TD>
					<TD>
						<asp:Button id="btnRedeemCode" runat="server" CssClass="standard-text" Text="Redeem Code" CausesValidation="False"></asp:Button></TD>
					<TD></TD>
				</TR>
			</TABLE>
			</P></TD></TR></TBODY></TABLE>
		<%= getHTML("footer.inc") %>
		</form>
	</body>
</HTML>
