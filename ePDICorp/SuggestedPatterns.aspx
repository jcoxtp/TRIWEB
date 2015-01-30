<%@ Page language="c#" Codebehind="SuggestedPatterns.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.SuggestedPatterns" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SuggestedPatterns</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
<script type="text/javascript" src="scripts/jquery-1.4.2.js"></script>
<script type="text/javascript" src="scripts/jquery.corners.js"></script>
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
	</HEAD>
	<body>
	   <div id="page">
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<div id="main-content">
			<TABLE align="center" id="tblLayout" cellSpacing="0" cellPadding="0" border="0">
				<TR>
					<td vAlign="top" align="center" width="15%" rowSpan="3" class="left-sidebar"><br>
						<br>
						<asp:Image id="imgComposite" runat="server"></asp:Image><br>
						<br>
						Your Composite Graph</td>
					<TD class="style1" align="center" width="70%">Select a Suggested Pattern</TD>
					<td vAlign="top" align="center" width="15%" rowSpan="3"><br>
						<br>
						<div class="style1-body" align="right">&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</TR>
				<TR>
					<TD class="section-divline" width="70%">&nbsp;</TD>
				</TR>
				<tr>
					<td width="70%">
						<P>Based on your composite graph scores, the pattern(s) below might fit your 
							general personality type. Compare your composite graph (left) to the patterns 
							below. Read the description for these patterns to see which one best matches 
							your personality. Click the "Select this pattern" link under the image.</P>
						<!-- <P>We have created 28 personality patterns based on years of collecting anonymous 
							data from our clients. Most people will find that their composite graph matches 
							one of these 28 patterns.</P>
						<p>
							If you want to see all 28 patterns, click on the link at the bottom of the 
							page.</p> -->
						<P><asp:datagrid id="dtgSuggestedPatterns" runat="server" AutoGenerateColumns="False" DataKeyField="PDIRepProfileID"
								CellPadding="3">
								<Columns>
									<asp:TemplateColumn HeaderText="Representative Pattern">
										<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
										<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
										<ItemTemplate>
											<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ProfileName") %>'>
											</asp:Label>
											<br>
											<asp:LinkButton runat="server" Text='<%# "<img border=\"0\" src=\"images/en/" + DataBinder.Eval(Container, "DataItem.ProfileImgFileName") + "\">" %>' CommandName="Select" CausesValidation="False" />
											<br>
											<br>
											<asp:LinkButton runat="server" Text="Select this pattern" CssClass="blue-link" CommandName="Select"
												CausesValidation="false"></asp:LinkButton>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="Description">
										<HeaderStyle Font-Bold="True" HorizontalAlign="Center"></HeaderStyle>
										<ItemTemplate>
											<p class="standard-text-small">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.ObservableTraits") %>'>
												</asp:Label>
											</p>
											<p class="standard-text-small">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.InternalMotive") %>'>
												</asp:Label>
											</p>
											<p class="standard-text-small">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.AttentionAreas") %>'>
												</asp:Label>
											</p>
											<p class="standard-text-small">
												<asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.SpouseNeedToKnow") %>'>
												</asp:Label>
											</p>
											<br>
											<br>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></P>
					</td>
				</tr>
				<TR>
					<TD></TD>
					<TD align="center">
						<asp:LinkButton id="lnkToRepPatternChart" runat="server" CssClass="blue-link" Visible="False">See all 28 patterns</asp:LinkButton></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD style="BORDER-TOP: #435b69 1px solid" align="center"><A href="ContactUs.aspx">© 
							Copyright 2006-2008 Triaxia Partners, Inc. All Rights Reserved</A></TD>
					<TD></TD>
				</TR>
			</TABLE>
			</div>
		</form>
	   </div>
	</body>
</HTML>
