<%@ Page language="c#" Codebehind="dlgImportProperties.aspx.cs" AutoEventWireup="false" Inherits="ProjectEditor.dlgImportProperties" %>
<%@ OutputCache Location="none" %>
<%@ Register tagprefix="SPSS" Tagname="OkCancel" src="ctrlOkCancel.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>
			<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgImportProperties_title"))%>
		</title>
		<base target="_self">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<!-- STANDARD FUNCTIONS FOR THIS APP -->
		<script src="general.js" type="text/javascript"></script>
		<!-- DIALOG LIB -->
		<script src="../Shared/Dialog/dialog.js" type="text/javascript"></script>
		<!-- JAVASCRIPT FUNCTIONS USED ONLY FROM THIS PAGE -->
		<script src="dlgImportProperties.js" type="text/javascript"></script>
		<link type="text/css" rel="stylesheet" href="../shared/spssmrNet.css">
		<LINK href="css/properties.css" type="text/css" rel="stylesheet">
		<script type="text/javascript">
		<!--
			
		-->
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<table style="WIDTH: 100%">
			<tr>
				<td>
					<table class="OuterTable" style="WIDTH: 100%">
						<tr>
							<td>
								<form id="dlgImportProperties" method="post" runat="server">
									<input id="doResizeWindow" type="hidden" value="1" name="doResizeWindow" runat="server">
									<asp:button id="btnImportProperties" style="DISPLAY: none" onclick="btnImportProperties_Click" runat="server" Text=""></asp:button>
									<table class="InnerTable" cellSpacing="2" style="TABLE-LAYOUT: fixed; WIDTH: 600px; ">
										<tr>
											<td class="InnerTableMainDataDark" style="WIDTH: 150px">
												<DIV id="lblProjectName" style="DISPLAY: inline; WIDTH: 70px; HEIGHT: 15px" noWrap runat="server" ms_positioning="FlowLayout">Project 
													Name:</DIV>
											</td>
											<td class="InnerTableMainDataDark" style="WHITE-SPACE: nowrap"><asp:dropdownlist id="cbProjectName" runat="server" DataValueField="ProjectName" DataTextField="ProjectLabelAndName" CssClass="InnerTableMainDataCtrl" Width="344" AutoPostBack="True" OnSelectedIndexChanged="cbProjectName_Changed"></asp:dropdownlist></td>
										</tr>
										<tr>
											<td class="InnerTableMainDataDark" style="WIDTH: 1%">
												<DIV id="lblApplication" style="DISPLAY: inline; WIDTH: 70px; HEIGHT: 15px" noWrap runat="server" ms_positioning="FlowLayout">Application:</DIV>
											</td>
											<td class="InnerTableMainDataDark" style="WHITE-SPACE: nowrap"><asp:dropdownlist id="cbApplication" runat="server" CssClass="InnerTableMainDataCtrl" Width="344" AutoPostBack="True" OnSelectedIndexChanged="cbApplication_Changed"></asp:dropdownlist></td>
										</tr>
										<tr>
											<td class="InnerTableMainDataDark" colSpan="2" style="WIDTH: 600px">
												<div class="InnerTableMainDataCtrl" style="OVERFLOW: auto; HEIGHT: 300px; WIDTH: 585px">
													<table class="PropertiesTable" id="properetiesTable" cellSpacing="0" width="99%">
														<THEAD>
															<tr>
																<td class="PropertiesTableHeader" style="WIDTH: 1%">
																	<div style="WIDTH: 100px">
																		<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgImportProperties_header_property_select"))%>
																	</div>
																</td>
																<td class="PropertiesTableHeader" style="WIDTH: 15%">
																	<div style="WIDTH: 100px">
																		<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgImportProperties_header_property_name"))%>
																	</div>
																</td>
																<td class="PropertiesTableHeader" style="WIDTH: 69%">
																	<div style="WIDTH: 100px">
																		<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgImportProperties_header_property_value"))%>
																	</div>
																</td>
																<td class="PropertiesTableHeader" style="WIDTH: 15%">
																	<div style="WIDTH: 100px">
																		<%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("dlgImportProperties_header_property_type"))%>
																	</div>
																</td>
															</tr>
														</THEAD>
														<TBODY>
															<asp:repeater id="properetiesRepeater" runat="server" OnItemDataBound="OnItemDataBoundEventHandler">
																<ItemTemplate>
																	<tr id="propertyTR" runat="server" class="PropertiesTableRow">
																		<td class="PropertiesTableCell" style="width:1%">
																			<div>
																				<input type="checkbox" id="chSelectProperty" runat="server">
																			</div>
																		</td>
																		<td class="PropertiesTableCell" style="width:15%">
																			<div id="clPropertyName" runat="server">
																				<%# DataBinder.Eval(Container.DataItem, "Name") %>
																			</div>
																		</td>
																		<td class="PropertiesTableCell" style="width:69%">
																			<div id="clPropertyValue" runat="server">
																				<%# DataBinder.Eval(Container.DataItem, "Value") %>
																			</div>
																		</td>
																		<td class="PropertiesTableCell" style="width:15%">
																			<div id="clPropertyType" runat="server">
																				<%# DataBinder.Eval(Container.DataItem, "Type") %>
																			</div>
																		</td>
																	</tr>
																</ItemTemplate>
															</asp:repeater>
															<tr id="BottomPropertyTR" runat="server">
																<td class="PropertiesTableCell" colSpan="4">&nbsp;
																</td>
															</tr>
														</TBODY>
													</table>
												</div>
											</td>
										</tr>
									</table>
								</form>
							</td>
						</tr>
					</table>
					<SPSS:OKCANCEL id="Okcancel" runat="server" NAME="Okcancel"></SPSS:OKCANCEL></td>
			</tr>
		</table>
	</body>
</HTML>
