<%@ Page language="c#" Codebehind="MonitoringMain.aspx.cs" Inherits="SPSSMR.Management.Monitoring.Web.MonitoringMain" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
  <HEAD>
        <title></title>
        <meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
        <meta content="C#" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <!-- SPSS Launcher applications stylesheet --><LINK href="Shared/spssmrNet.css" type="text/css" rel="stylesheet"><LINK href="MonitoringDataGrid.css" type="text/css" rel="stylesheet">
        
        <script src="MonitoringMail.js" type="text/javascript"></script>
        
        <script language="javascript">
            function SetTitle(name)
            {
                window.top.document.title = name;
            }
        </script>
</HEAD>
    <body onload="SetTitle(<%=GetPageTitle()%>)" MS_POSITIONING="GridLayout">
        <form id="Form1" method="post" runat="server">
        <input id="hSelectedTab" type="hidden" name="hSelectedTab" runat="server">
        
            <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
            <tr style="height:10px">
            <td valign="top"></td>
            </tr> 
            
            <tr>
                <td valign="top">
                    <!-- Concurrent Table -->
                    <table class="OuterTable" id="tabLicense" cellPadding="0" runat="server" style="width: 100%;">
                 
                    <tr>
                    <td>
                    <br>
                    <table class="RoundedTable" id="tab1" cellPadding="0" runat="server">
                        <!-- Header -->
                        <tr>
                            <td colSpan="2" rowSpan="2"><IMG height="30" alt="" src="shared/images/RoundedTableControl/dark_topleft.gif" width="10"></td>
                            <td class="RoundedTableOuterBorder" colSpan="2" height="1"></td>
                            <td colSpan="2" rowSpan="2"><IMG height="30" alt="" src="shared/images/RoundedTableControl/dark_topright.gif" width="10"></td>
                        </tr>
                        <!-- Title -->
                        <tr>
                            <td class="RoundedTableDarkHeader" width="100%" colSpan="2"><asp:label id="labLicenseHeader" runat="server" Width="100%"></asp:label></td>
                        </tr>
                        <!-- Contents -->
                        <tr>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                            <td class="RoundedTableLightInfo" width="9"></td>
                            <td class="RoundedTableLightInfo" colSpan="2" height="100%">
                                <table height="100%" cellSpacing="0" cellPadding="5" width="100%" border="0">
                                    <tr>
                                        <td nowrap="nowrap"><asp:label id="lblConPeriod" runat="server" Font-Bold="True">lblReports</asp:label></td>
                                        <td align="left"><asp:dropdownlist id="cmbConPeriod" runat="server"></asp:dropdownlist></td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap"><asp:label id="lblConActivities" runat="server" Font-Bold="True">lblCounters</asp:label></td>
                                        <td align="left"><asp:dropdownlist id="cmbConActivities" runat="server"></asp:dropdownlist></td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap"><asp:label id="lblConServer" runat="server" Font-Bold="True">lblServers</asp:label></td>
                                        <td align="left"><asp:dropdownlist id="cmbConServer" runat="server"></asp:dropdownlist></td>
                                        <td align="left" width="100%"><asp:button id="btnViewCon" runat="server" Text="btnView"></asp:button></td>
                                    </tr>
                                </table>
                            </td>
                            <td class="RoundedTableLightInfo" width="9"></td>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                        </tr>
                        <!-- Activity Hint -->
                        <tr>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                            <td class="RoundedTableDarkInfo" width="9"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" height="100%"><span class="RoundedTableText"><br>
                                    <asp:label id="labConActivityHint" runat="server">lblActivityHint</asp:label><br>
                                </span>
                            </td>
                            <TD class="RoundedTableDarkInfo" width="9"></TD>
                            <TD class="RoundedTableOuterBorder" width="1"></TD>
                        </tr>
                        
                        <tr>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                            <td class="RoundedTableDarkInfo" width="9"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" height="100%" ><span class="RoundedTableText"><br>
                                    <IMG height="10" src="shared/images/Failed.gif" width="10"><asp:label id="lblLicExceed" runat="server">lblLicExceed</asp:label><br>
                                </span>
                            </td>
                            <TD class="RoundedTableDarkInfo" width="9"></TD>
                            <TD class="RoundedTableOuterBorder" width="1"></TD>
                        </tr>
                        
                        <!-- Bottom -->
                        <tr>
                            <td class="RoundedTableDarkInfo" colSpan="2" rowSpan="2"><IMG height="10" src="shared/images/RoundedTableControl/light_bottomleft.gif" width="10"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" height="9"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" rowSpan="2"><IMG height="10" src="shared/images/RoundedTableControl/light_bottomright.gif" width="10"></td>
                        </tr>
                        <tr>
                            <td class="RoundedTableOuterBorder" colSpan="2" height="1"></td>
                        </tr>
                    </table>
                    <br>
                    <table class="RoundedTable" id="tblConResult" cellPadding="0" Runat="server">
                        <tr>
                            <td colSpan="2" rowSpan="2"><IMG height="30" alt="" src="shared/images/RoundedTableControl/dark_topleft.gif" width="10"></td>
                            <td class="RoundedTableOuterBorder" colSpan="2" height="1"></td>
                            <td colSpan="2" rowSpan="2"><IMG height="30" alt="" src="shared/images/RoundedTableControl/dark_topright.gif" width="10"></td>
                        </tr>
                        <tr>
                            <td class="RoundedTableDarkHeader" width="100%" colSpan="2"><asp:label id="lblConResHeader" runat="server" Width="100%" Font-Size="12px"></asp:label></td>
                        </tr>
                        <tr>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                            <td class="RoundedTableLightInfo" colSpan="4" height="100%">
                            
                            <asp:datagrid id="dgConResults" style="Z-INDEX: 101" runat="server" Width="100%" GridLines="None" AutoGenerateColumns="False" OnItemDataBound="dgConResults_ItemDataBound" OnDataBinding="dgConResults_DataBinding" >
                                    <HeaderStyle CssClass="DG_HEADER" Height="30px"></HeaderStyle>
                                <Columns>
                                    <asp:BoundColumn DataField="Server" HeaderText="Server"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="Date" HeaderText="Date"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="Activity" HeaderText="Activity"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="Total" HeaderText="Total Avaliable"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="Time" HeaderText="Concurrent in Use"></asp:BoundColumn>
                                    <asp:TemplateColumn HeaderText="Value">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Value") %>'></asp:Label><img id="imgExceed" height="10" src="shared/images/Failed.gif" width="10" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                                    
                                </asp:datagrid></td>
                            <TD class="RoundedTableOuterBorder" width="1"></TD>
                        </tr>
                        <tr>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                            <td class="RoundedTableDarkInfo" width="9"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" height="100%"><br>
                                <span class="RoundedTableText" id="Span1">
                                    <asp:button id="btnDownLoadConData" runat="server" Text="btnDownload" Visible="False"></asp:button></span>
                            </td>
                            <TD class="RoundedTableDarkInfo" width="9"></TD>
                            <TD class="RoundedTableOuterBorder" width="1"></TD>
                        </tr>
                        <tr>
                            <td class="RoundedTableDarkInfo" colSpan="2" rowSpan="2"><IMG height="10" src="shared/images/RoundedTableControl/light_bottomleft.gif" width="10"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" height="9"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" rowSpan="2"><IMG height="10" src="shared/images/RoundedTableControl/light_bottomright.gif" width="10"></td>
                        </tr>
                        <TR>
                            <TD class="RoundedTableOuterBorder" colSpan="2" height="1"></TD>
                        </TR>
                        
                    </table>
                    <br>
                    </td>
                    </tr>
                    </table>
                    <!-- Usage Report Table -->
                    <table class="OuterTable" id="tabCounter" cellPadding="0" runat="server" style="width: 100%; " >
                    <tr>
                    <td>
                    <br>
                    <table class="RoundedTable" id="tab2" cellPadding="0" runat="server">
                        <!-- Header -->
                        <tr>
                            <td colSpan="2" rowSpan="2"><IMG height="30" alt="" src="shared/images/RoundedTableControl/dark_topleft.gif" width="10"></td>
                            <td class="RoundedTableOuterBorder" colSpan="2" height="1"></td>
                            <td colSpan="2" rowSpan="2"><IMG height="30" alt="" src="shared/images/RoundedTableControl/dark_topright.gif" width="10"></td>
                        </tr>
                        <!-- Title -->
                        <tr>
                            <td class="RoundedTableDarkHeader" width="100%" colSpan="2"><asp:label id="lblHeader" runat="server" Width="100%">Monitoring Reports</asp:label></td>
                        </tr>
                        <!-- Contents -->
                        <tr>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                            <td class="RoundedTableLightInfo" width="9"></td>
                            <td class="RoundedTableLightInfo" colSpan="2" height="100%">
                                <table height="100%" cellSpacing="0" cellPadding="5" width="100%" border="0">
                                    <tr>
                                        <td nowrap="nowrap"><asp:label id="lblReports" runat="server" Font-Bold="True">lblReports</asp:label></td>
                                        <td align="left"><asp:dropdownlist id="cmbReports" runat="server"></asp:dropdownlist></td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap"><asp:label id="lblCounters" runat="server" Font-Bold="True">lblCounters</asp:label></td>
                                        <td align="left"><asp:dropdownlist id="cmbCounters" runat="server"></asp:dropdownlist></td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap"><asp:label id="lblServers" runat="server" Font-Bold="True">lblServers</asp:label></td>
                                        <td align="left"><asp:dropdownlist id="cmbServers" runat="server"></asp:dropdownlist></td>
                                        <td align="left" width="100%"><asp:button id="btnView" runat="server" Text="btnView"></asp:button></td>
                                    </tr>
                                </table>
                            </td>
                            <td class="RoundedTableLightInfo" width="9"></td>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                        </tr>
                        <!-- Activity Hint -->
                        <tr>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                            <td class="RoundedTableDarkInfo" width="9"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" height="100%"><span class="RoundedTableText"><br>
                                    <asp:label id="lblActivityHint" runat="server">lblActivityHint</asp:label><br>
                                </span>
                            </td>
                            <TD class="RoundedTableDarkInfo" width="9"></TD>
                            <TD class="RoundedTableOuterBorder" width="1"></TD>
                        </tr>
                        <!-- Bottom -->
                        <tr>
                            <td class="RoundedTableDarkInfo" colSpan="2" rowSpan="2"><IMG height="10" src="shared/images/RoundedTableControl/light_bottomleft.gif" width="10"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" height="9"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" rowSpan="2"><IMG height="10" src="shared/images/RoundedTableControl/light_bottomright.gif" width="10"></td>
                        </tr>
                        <tr>
                            <td class="RoundedTableOuterBorder" colSpan="2" height="1"></td>
                        </tr>
                    </table>
                    <br>
                    <table class="RoundedTable" id="tblResults" cellPadding="0" Runat="server">
                        <tr>
                            <td colSpan="2" rowSpan="2"><IMG height="30" alt="" src="shared/images/RoundedTableControl/dark_topleft.gif" width="10"></td>
                            <td class="RoundedTableOuterBorder" colSpan="2" height="1"></td>
                            <td colSpan="2" rowSpan="2"><IMG height="30" alt="" src="shared/images/RoundedTableControl/dark_topright.gif" width="10"></td>
                        </tr>
                        <tr>
                            <td class="RoundedTableDarkHeader" width="100%" colSpan="2"><asp:label id="lblResHeader" runat="server" Width="100%" Font-Size="12px"></asp:label></td>
                        </tr>
                        <tr>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                            <td class="RoundedTableLightInfo" colSpan="4" height="100%"><asp:datagrid id="dgResults" style="Z-INDEX: 101" runat="server" Width="100%" GridLines="None">
                                    <HeaderStyle CssClass="DG_HEADER" Height="30"></HeaderStyle>
                                </asp:datagrid></td>
                            <TD class="RoundedTableOuterBorder" width="1"></TD>
                        </tr>
                        <tr>
                            <td class="RoundedTableOuterBorder" width="1"></td>
                            <td class="RoundedTableDarkInfo" width="9"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" height="100%"><br>
                                <span class="RoundedTableText" id="ProjectInfoTable_btnDownload">
                                    <asp:button id="btnDownload" runat="server" Text="btnDownload" Visible="False"></asp:button></span>
                            </td>
                            <TD class="RoundedTableDarkInfo" width="9"></TD>
                            <TD class="RoundedTableOuterBorder" width="1"></TD>
                        </tr>
                        <tr>
                            <td class="RoundedTableDarkInfo" colSpan="2" rowSpan="2"><IMG height="10" src="shared/images/RoundedTableControl/light_bottomleft.gif" width="10"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" height="9"></td>
                            <td class="RoundedTableDarkInfo" colSpan="2" rowSpan="2"><IMG height="10" src="shared/images/RoundedTableControl/light_bottomright.gif" width="10"></td>
                        </tr>
                        <TR>
                            <TD class="RoundedTableOuterBorder" colSpan="2" height="1"></TD>
                        </TR>
                    </table>
                    <br>
                    </td>
                    </tr>
                    </table>
                </td>
            </tr>
            </table>
        </form>
    </body>
</HTML>
