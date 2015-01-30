<%@ Page Language="c#" Codebehind="ws_projectinfo.aspx.cs" AutoEventWireup="false"
    Inherits="ProjectEditor.ws_projectinfo" %>

<%@ OutputCache Location="none" %>
<%@ Reference Control="Controls/ProjectInfoControl.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <title>ws_projectinfo</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
    <meta content="C#" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <!-- Shared -->
    <link href="Shared/spssmrNet.css" type="text/css" rel="stylesheet">

    <script src="Shared/Dialog/dialog.js" type="text/javascript"></script>

    <script src="Shared/DataLinkDialog/datalinkdialog.js" type="text/javascript"></script>

    <!-- Application Specific -->
    <link href="css/properties.css" type="text/css" rel="stylesheet">

    <script src="general.js" type="text/javascript"></script>

    <script src="js/tablesort.js" type="text/javascript"></script>

    <script src="ws_projectinfo.js" type="text/javascript"></script>

    <script src="CustomDialog/MessageBox.js" type="text/javascript"></script>

</head>
<body tabindex="-1" ms_positioning="GridLayout" style="margin: 10px"  onload="EnableAllFrames();SynchMenuAndContent()">
    <form id="ws_projectinfo" method="post" runat="server" onsubmit="DisableAllFrames()">
        <!-- ... -->
        <input id="hProjectName" type="hidden" name="hProjectName" runat="server">
        <!-- input field to remember the control that has focus -->
        <input id="hCtrlFocus" type="hidden" name="hCtrlFocus" runat="server">
        <input id="hPropFocus" type="hidden" name="hPropFocus" runat="server">
        <input id="hPropFocusName" type="hidden" name="hPropFocusName" runat="server">
        <input id="hSelectedTab" type="hidden" name="hSelectedTab" runat="server">
        <asp:Button ID="reloadProjectBtn" Style="display: none" OnClick="reloadProjectBtn_Clicked"
            runat="server" Text=""></asp:Button>
        <asp:Button ID="dummyBtn" Style="display: none" OnClick="dummyBtn_Click" runat="server"
            Text=""></asp:Button>
        <asp:Button ID="btnClose" Style="display: none" OnClick="btnClose_Click" runat="server"
            Text=""></asp:Button>
        <asp:Button ID="AddApplicationBtn" Style="display: none" OnClick="AddApplicationBtn_Click"
            runat="server" Text=""></asp:Button>
        <input id="hAddApplicationName" type="hidden" name="hAddApplicationName" runat="server">
        <input id="newGroupName" type="hidden" runat="server">
        <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
            <tr>
                <td style="height: 1%">
                    <div style="width: 99%">
                        <asp:PlaceHolder ID="phProjectInfo" runat="server"></asp:PlaceHolder>
                        <br>
                    </div>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <!-- Project Info Tab -->
                    <table class="OuterTable" id="ProjectInfoTabTable" style="width: 515px; height: 131px"
                        cellspacing="0" cellpadding="0" runat="server">
                        <tr>
                            <td>
                                <table class="InnerTable" style="width: 508px; height: 131px" cellspacing="2">
                                    <tr>
                                        <td class="InnerTableMainDataDark" style="width: 100px; white-space: nowrap; height: 8px">
                                            <div id="lblLabel" style="display: inline; white-space: nowrap" nowrap runat="server"
                                                ms_positioning="FlowLayout">
                                                Label:</div>
                                        </td>
                                        <td class="InnerTableMainDataDark" style="height: 8px" colspan="2">
                                            <asp:TextBox ID="tbLabel" runat="server" Width="392px" CssClass="InnerTableMainDataCtrl"
                                                OnTextChanged="tbLabel_Changed" AutoPostBack="True"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="InnerTableMainDataDark" style="vertical-align: top; width: 100px; white-space: nowrap;
                                            height: 10px">
                                            <div id="lblDescription" style="display: inline; white-space: nowrap" nowrap runat="server"
                                                ms_positioning="FlowLayout">
                                                Description:</div>
                                        </td>
                                        <td class="InnerTableMainDataDark" style="height: 10px" colspan="2">
                                            <asp:TextBox ID="tbDescription" runat="server" Width="392px" CssClass="InnerTableMainDataCtrl"
                                                OnTextChanged="tbDescription_Changed" AutoPostBack="True" Height="90px" TextMode="MultiLine"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td class="InnerTableMainDataDark" style="width: 100px; white-space: nowrap; height: 10px">
                                            <div id="lblStatus" style="display: inline; white-space: nowrap" nowrap runat="server"
                                                ms_positioning="FlowLayout">
                                                Status:</div>
                                        </td>
                                        <td class="InnerTableMainDataDark" style="height: 10px" colspan="2">
                                            <asp:DropDownList ID="cbStatus" runat="server" Width="392px" CssClass="InnerTableMainDataCtrl"
                                                AutoPostBack="True" OnSelectedIndexChanged="cbStatus_Changed" DataValueField="DPMName"
                                                DataTextField="DisplayName">
                                                <asp:ListItem Value="Inactive" Selected="True">Inactive</asp:ListItem>
                                                <asp:ListItem Value="Test">Test</asp:ListItem>
                                                <asp:ListItem Value="Active">Active</asp:ListItem>
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td class="InnerTableMainDataDark" style="width: 100px; white-space: nowrap; height: 10px">
                                            <div id="lblGroupName" style="display: inline; white-space: nowrap" nowrap runat="server"
                                                ms_positioning="FlowLayout">
                                                Group Name:</div>
                                        </td>
                                        <td class="InnerTableMainDataDark" style="height: 10px">
                                            <asp:DropDownList ID="projectGroupList" onchange="groupSelected();" runat="server"
                                                AutoPostBack="True" OnSelectedIndexChanged="projectGroupList_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <!-- ... -->
                    <!-- Roles Tab -->
                    <table class="OuterTable" id="RolesTabTable" style="width: 523px; height: 155px"
                        cellspacing="0" cellpadding="0" runat="server">
                        <tr>
                            <td valign="top" style="white-space: nowrap">
                                <table class="InnerTable" style="table-layout: fixed; width: 510px; height: 155px"
                                    cellspacing="2">
                                    <tr>
                                        <td class="InnerTableMainDataDark" style="vertical-align: top; width: 115px">
                                            <div id="lblRoles" style="display: inline; width: 70px; height: 15px" nowrap runat="server"
                                                ms_positioning="FlowLayout">
                                                Groups:
                                            </div>
                                        </td>
                                        <td class="InnerTableMainDataDark" style="padding-right: 2px; padding-left: 2px;
                                            padding-bottom: 2px; vertical-align: top; padding-top: 2px; white-space: nowrap">
                                            <div style="border-right: 1px inset; border-top: 1px inset; overflow: auto; border-left: 1px inset;
                                                width: 100%; border-bottom: 1px inset; height: 146px; background-color: white">
                                                <asp:Repeater ID="RolesRepeater" runat="server" OnItemDataBound="RolesRepeater_ItemDataBound">
                                                    <HeaderTemplate>
                                                        <table id="RolesList" style="width: 90%">
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td style="width: 10px">
                                                                <img src="images/users.png" width="15" height="15">
                                                            </td>
                                                            <td style="width: 10px">
                                                                <asp:CheckBox ID="chkRole" Checked='<%# ((System.Data.DataRowView)Container.DataItem)["IsSelected"] %>'
                                                                    AutoPostBack="True" OnCheckedChanged="chkRole_CheckedChanged" runat="server"></asp:CheckBox>
                                                            </td>
                                                            <td>
                                                                <%# ((System.Data.DataRowView)Container.DataItem)["RoleName"] %>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        </TABLE>
                                                    </FooterTemplate>
                                                </asp:Repeater>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <!-- ... -->
                    <!-- Connection Tab -->
                    <table class="OuterTable" id="ConnectionTabTable" style="width: 523px; height: 155px"
                        cellspacing="0" cellpadding="0" runat="server">
                        <tr>
                            <td valign="top" style="white-space: nowrap">
                                <asp:TextBox ID="tbDataLocation" runat="server" Style="display: none" OnTextChanged="tbDataLocation_Changed"
                                    AutoPostBack="True"></asp:TextBox>
                                <div id="CsDiv" style="display: inline; overflow-x: scroll; width: 480px">
                                    <table class="InnerTable" style="display: inline; width: 480px; height: 155px" cellspacing="2">
                                        <tr>
                                            <td class="InnerTableMainDataDark" style="width: 120px; height: 20px; padding: 3px"
                                                valign="middle">
                                                <div id="lblMetaDataType" style="display: inline; width: 70px" nowrap runat="server"
                                                    ms_positioning="FlowLayout">
                                                    Meta data type:</div>
                                            </td>
                                            <td class="InnerTableMainDataDark" style="white-space: nowrap; height: 20px; padding: 3px">
                                                <div id="tbMetaDataType" style="display: inline; width: 339px" nowrap runat="server"
                                                    ms_positioning="FlowLayout">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="InnerTableMainDataDark" style="width: 120px; height: 20px; padding: 3px">
                                                <div id="lblMetaDataLocation" style="display: inline; width: 70px" nowrap runat="server"
                                                    ms_positioning="FlowLayout">
                                                    Meta data location:</div>
                                            </td>
                                            <td class="InnerTableMainDataDark" style="white-space: nowrap; height: 20px; padding: 3px">
                                                <div id="tbMetaDataLocation" style="display: inline; width: 339px" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="InnerTableMainDataDark" style="width: 120px; height: 20px; padding: 3px">
                                                <div id="lblMetaDataReadWrite" style="display: inline; width: 70px" nowrap runat="server"
                                                    ms_positioning="FlowLayout">
                                                    Meta data read/write:</div>
                                            </td>
                                            <td class="InnerTableMainDataDark" style="white-space: nowrap; height: 20px; padding: 3px">
                                                <div id="tbMetaDataReadWrite" style="display: inline; width: 339px" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="InnerTableMainDataDark" style="width: 120px; height: 20px; padding: 3px">
                                                <div id="lblCaseDataType" style="display: inline; width: 70px" nowrap runat="server"
                                                    ms_positioning="FlowLayout">
                                                    Case data type:</div>
                                            </td>
                                            <td class="InnerTableMainDataDark" style="white-space: nowrap; height: 20px; padding: 3px">
                                                <div id="tbCaseDataType" style="display: inline; width: 339px" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="InnerTableMainDataDark" style="width: 120px; height: 20px; padding: 3px">
                                                <div id="lblCaseDataLocation" style="display: inline; width: 70px" nowrap runat="server"
                                                    ms_positioning="FlowLayout">
                                                    Case data location:</div>
                                            </td>
                                            <td class="InnerTableMainDataDark" style="white-space: nowrap; height: 20px; padding: 3px">
                                                <div id="tbCaseDataLocation" style="display: inline; width: 339px" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="InnerTableMainDataDark" style="width: 120px; height: 20px; padding: 3px">
                                                <div id="lblCaseDataProject" style="display: inline; width: 70px" nowrap runat="server"
                                                    ms_positioning="FlowLayout">
                                                    Case data project:</div>
                                            </td>
                                            <td class="InnerTableMainDataDark" style="white-space: nowrap; height: 20px; padding: 3px">
                                                <div id="tbCaseDataProject" style="display: inline; width: 339px" runat="server">
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <span style="display: inline; height: 100%; padding: 4px"><a id="ancEditConnectionString"
                                    style="cursor: hand; text-decoration: underline" onclick="editConnectionString_Clicked()"
                                    tabindex="-1" runat="server">Edit</a> </span>
                            </td>
                        </tr>
                        <tr id="ConnectionStringErrorRow" runat="server" style="display: none">
                            <td class="InnerTableMainData" style="padding-right: 3px; padding-left: 3px; padding-bottom: 3px;
                                padding-top: 3px">
                                <div id="ConnectionStringErrorDiv" class="errorText" style="display: inline; margin-left: 5px"
                                    runat="server" ms_positioning="FlowLayout">
                                    - The connection string is not a valid string!</div>
                            </td>
                        </tr>
                    </table>
                    <!-- ... -->
                    <!-- Properties Tab -->
                    <table id="PropertiesTabTable" style="width: 100%; height: 100%" runat="server">
                        <tbody>
                            <tr>
                                <td class="InnerTableMainData" style="width: 1%; white-space: nowrap; height: 10px">
                                    <div id="lblApplication" style="display: inline; white-space: nowrap" nowrap runat="server"
                                        ms_positioning="FlowLayout">
                                        Application:</div>
                                </td>
                                <td class="InnerTableMainData" style="vertical-align: middle; white-space: nowrap;
                                    height: 10px">
                                    <asp:DropDownList ID="cbApplication" Style="margin-top: 1px; margin-bottom: 3px;
                                        margin-right: 0px" runat="server" CssClass="InnerTableMainDataCtrl" AutoPostBack="True"
                                        OnSelectedIndexChanged="cbApplicationSelector_Changed">
                                        <asp:ListItem Value="[spss:standard]" Selected="True">(Standard)</asp:ListItem>
                                    </asp:DropDownList>&nbsp;<a class="staticdark" onmousemove="ShowTitleInStatus(this)"
                                        id="ancAddApplication" onmouseover="ShowTitleInStatus(this)" style="margin-left: 0px;
                                        vertical-align: middle; text-decoration: underline" tabindex="-1" onmouseout="ClearStatus()"
                                        href="javascript:addApplicationClicked()" runat="server">Add Application</a>
                                </td>
                                <td class="InnerTableMainData" style="white-space: nowrap; height: 10px">
                                    <div style="width: 98%; margin-right: 15px; text-align: right">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="InnerTableMainData" colspan="3" style="padding: 0px">
                                    <table class="" id="properetiesTable" height="100%" cellspacing="0" width="99%">
                                        <thead>
                                            <tr>
                                                <td class="RoundedTableDarkHeaderTL">
                                                    <div style="height: 30px; width: 10px">
                                                    </div>
                                                </td>
                                                <td class="RoundedTableDarkHeaderT" style="width: 85%" colspan="2">
                                                    <div id="lblPropertiesHeader" runat="server">
                                                        Properties
                                                    </div>
                                                </td>
                                                <td class="RoundedTableDarkHeaderT" style="width: 15%; text-align: right">
                                                    <nobr>
															<a class="staticdark" style="CURSOR: hand; TEXT-DECORATION: none" onmousemove="ShowTitleInStatus(this)" id="insertAnc1" onmouseover="ShowTitleInStatus(this)" tabIndex="-1" onmouseout="ClearStatus()" runat="server" onserverclick="ancInsertProperty_Click">
																<img src="shared/images/add.png" border="0" width="16" height="16">
															</a>
															<A class="staticdark" style="CURSOR: hand; TEXT-DECORATION: none" onmousemove="ShowTitleInStatus(this)" id="importAnc1" onmouseover="ShowTitleInStatus(this)" tabIndex="-1" onmouseout="ClearStatus()" href="javascript:importPropertiesClicked()" runat="server">
																<img src="shared/images/import.png" border="0" style="MARGIN-RIGHT: 15px"  width="16" height="16">
															</A>
															<a class="staticdark" style="CURSOR: hand; TEXT-DECORATION: none" onmousemove="ShowTitleInStatus(this)" id="deleteAnc1" onmouseover="ShowTitleInStatus(this)" tabIndex="-1" onmouseout="ClearStatus()" runat="server" onserverclick="ancDeleteProperty_Click">
																<img src="shared/images/delete.png" border="0" width="16" height="16">
															</a>
														</nobr>
                                                </td>
                                                <td class="RoundedTableDarkHeaderTR">
                                                    <div style="height: 30px; width: 10px">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="RoundedTableLightHeaderL" style="padding: 0px;">
                                                    &nbsp;
                                                </td>
                                                <td class="RoundedTableLightHeader" style="padding: 0px; width: 15%; cursor: hand"
                                                    onclick="doSortProperties(1)">
                                                    <%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("projectinfo_properties_header_property_name"))%>
                                                </td>
                                                <td class="RoundedTableLightHeader" style="padding: 0px; width: 70%" onclick="doSortProperties(2)">
                                                    <%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("projectinfo_properties_header_property_value"))%>
                                                </td>
                                                <td class="RoundedTableLightHeader" style="padding: 0px; width: 15%; cursor: hand"
                                                    onclick="doSortProperties(3)">
                                                    <%=Server.HtmlEncode(ProjectEditor.Utilities.I18N.GetResourceString("projectinfo_properties_header_property_type"))%>
                                                </td>
                                                <td class="RoundedTableLightHeaderR" style="padding: 0px;">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="properetiesRepeater" runat="server" OnItemDataBound="OnItemDataBoundEventHandler">
                                                <ItemTemplate>
                                                    <tr id="propertyTR" runat="server" class="PropertiesTableRow" onclick="propertTR_Clicked(this)">
                                                        <td class="RoundedTableLightInfoL">
                                                            &nbsp;</td>
                                                        <td class="PropertiesTableCell" style="width: 15%">
                                                            <div>
                                                                <%# DataBinder.Eval(Container.DataItem, "Name") %>
                                                            </div>
                                                        </td>
                                                        <td class="PropertiesTableCell" style="width: 70%">
                                                            <asp:TextBox ID="property" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Value") %>'
                                                                AutoPostBack="True" OnTextChanged="tbPropertyValue_Changed" />
                                                        </td>
                                                        <td class="PropertiesTableCell" style="width: 15%">
                                                            <div>
                                                                <%# DataBinder.Eval(Container.DataItem, "Type") %>
                                                            </div>
                                                        </td>
                                                        <td class="RoundedTableLightInfoR">
                                                            &nbsp;</td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                        <tfoot>
                                            <tr class="PropertiesTableRow" id="newPropertyTR" style="display: none" runat="server">
                                                <td class="RoundedTableLightInfoL">
                                                    &nbsp;</td>
                                                <td class="PropertiesTableCell" style="width: 15%">
                                                    <asp:TextBox ID="tbNewPropertyName" runat="server" CssClass="PropertiesTableCtrl"
                                                        OnTextChanged="newProperty_NameChanged" AutoPostBack="True" OnInit="tbNewPropertyName_Init"></asp:TextBox></td>
                                                <td class="PropertiesTableCell" style="width: 70%">
                                                    <asp:TextBox ID="tbNewPropertyValue" runat="server" CssClass="PropertiesTableCtrl"
                                                        OnTextChanged="newProperty_ValueChanged" AutoPostBack="True" OnInit="tbNewPropertyValue_Init"></asp:TextBox></td>
                                                <td class="PropertiesTableCell" style="width: 15%">
                                                    <asp:DropDownList ID="ddlNewPropertyType" runat="server" CssClass="PropertiesTableCtrl"
                                                        AutoPostBack="True" OnSelectedIndexChanged="newProperty_TypeChanged" OnInit="ddlNewPropertyType_Init"
                                                        OnPreRender="ddlNewPropertyType_PreRender">
                                                    </asp:DropDownList></td>
                                                <td class="RoundedTableLightInfoR">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr class="PropertiesTableRow">
                                                <td class="RoundedTableLightInfoL">
                                                    &nbsp;</td>
                                                <td class="RoundedTableLightInfo" style="vertical-align: top; width: 15%; height: 100%">
                                                    <a class="PropertiesTableAddPropAnc" onmousemove="ShowTitleInStatus(this)" id="insertAnc2"
                                                        onmouseover="ShowTitleInStatus(this)" tabindex="-1" onmouseout="ClearStatus()"
                                                        runat="server" onserverclick="ancInsertProperty_Click">&lt; Click here to add property
                                                        &gt; </a>
                                                </td>
                                                <td class="RoundedTableLightInfo" colspan="2">
                                                    &nbsp;</td>
                                                <td class="RoundedTableLightInfoR">
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td class="RoundedTableDarkFooterBL">
                                                    <div style="height: 10px; width: 10px">
                                                    </div>
                                                </td>
                                                <td class="RoundedTableDarkFooterB" colspan="3">
                                                    &nbsp;</td>
                                                <td class="RoundedTableDarkFooterBR">
                                                    <div style="height: 10px; width: 10px">
                                                    </div>
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <!-- ... -->
                </td>
            </tr>
        </table>
    </form>
    <div id="EventFormDiv" style="display: none" runat="server">
    </div>
</body>
</html>
