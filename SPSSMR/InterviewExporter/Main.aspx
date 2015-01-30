<%@ Reference Control="ProjectInfoControl.ascx" %>
<%@ OutputCache Location="none" %>
<%@ Page language="c#" Codebehind="Main.aspx.cs" AutoEventWireup="false" Inherits="InterviewExporter.Main" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <HEAD>
        <title>main</title>
        <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
        <meta name="CODE_LANGUAGE" Content="C#">
        <meta name="vs_defaultClientScript" content="JavaScript">
        <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        <!-- SPSS Launcher applications stylesheet -->
        <link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
        <style>
		.section { MARGIN-TOP: 5px; MARGIN-BOTTOM: 10px }
		.indent { MARGIN-LEFT: 40px }
        </style>
        
    </HEAD>
    <body id="body" runat="server">
        <form id="Main" method="post" runat="server">
            <input id="action" type="hidden" runat="server"> <input id="version" type="hidden" runat="server">
            <input id="language" type="hidden" runat="server"> <input id="context" type="hidden" runat="server">
            <input id="labelType" type="hidden" runat="server">
            <table width="600">
                <tr>
                    <td>
                        <asp:PlaceHolder id="phProjectInfo" runat="server"></asp:PlaceHolder>
                    </td>
                </tr>
            </table>
            <asp:panel id="Panel1" runat="server" Width="600px" BackColor="#DDEBF6" BorderStyle="Solid"
                BorderWidth="1px">
                <TABLE width="100%">
                    <TR>
                        <TD width="10"></TD>
                        <TD>
                            <TABLE class="section">
                                <TR> <!-- Export to dropdown -->
                                    <TD><LABEL id="lblExportTo"><%=GetResourceString("main_export_to")%></LABEL></TD>
                                    <TD>
                                        <asp:DropDownList id="lstExportTo" Runat="server"></asp:DropDownList>&nbsp;&nbsp;
                                    </TD>
                                </TR> <!-- System variables dropdown -->
                                <TR> <!-- Language dropdown -->
                                    <TD><LABEL id="lblLanguage"><%=GetResourceString("main_language")%></LABEL></TD>
                                    <TD>
                                        <asp:DropDownList id="ddlLanguage" Runat="server"></asp:DropDownList>&nbsp;&nbsp;
                                    </TD>
                                </TR>
                                <TR>
                                    <TD><LABEL id="lblSystemVariables"><%=GetResourceString("main_system_variables")%></LABEL></TD>
                                    <TD>
                                        <asp:DropDownList id="lstSystemVariables" Runat="server"></asp:DropDownList></TD>
                                </TR> <!-- Variable types dropdown -->
                                <TR id="variable_types_select" style="DISPLAY: none" runat="server">
                                    <TD><LABEL id="lblVariableTypes"><%=GetResourceString("main_variable_types")%></LABEL></TD>
                                    <TD>
                                        <asp:DropDownList id="lstVariableTypes" Runat="server"></asp:DropDownList></TD>
                                </TR>
                            </TABLE> <!-- Sav DSC short name options -->
                            <DIV class="section" id="sav_shortname_options" style="DISPLAY: none">
                                <TABLE>
                                    <TR>
                                        <TD><LABEL id="lblUseShortNames"><%=GetResourceString("main_use_sav_short_names")%></LABEL></TD>
                                        <TD>
                                            <asp:CheckBox id="cbUseShortNames" runat="server"></asp:CheckBox></TD>
                                    </TR>
                                    <TR>
                                        <TD>
                                            <asp:Label id="lblMaxSavNameLenght" Runat="server"></asp:Label></TD>
                                        <TD>
                                            <asp:TextBox id="tbMaxSavNameLength" Runat="server"></asp:TextBox></TD>
                                    </TR>
                                </TABLE>
                            </DIV> <!-- Variable types checkboxes -->
                            <DIV id="variable_types_options" style="DISPLAY: none" runat="server">
                                <DIV class="indent">
                                    <DIV>
                                        <asp:CheckBox id="cbText" Runat="server" Checked="True"></asp:CheckBox><LABEL id="lblText"><%=GetResourceString("main_variable_types_options_text")%></LABEL></DIV>
                                    <DIV>
                                        <asp:CheckBox id="cbCategorical" Runat="server" Checked="True"></asp:CheckBox><LABEL id="lblCategorical"><%=GetResourceString("main_variable_types_options_categorical")%></LABEL></DIV>
                                    <DIV>
                                        <asp:CheckBox id="cbLong" Runat="server" Checked="True"></asp:CheckBox><LABEL id="lblLong"><%=GetResourceString("main_variable_types_options_numeric_long")%></LABEL></DIV>
                                    <DIV>
                                        <asp:CheckBox id="cbReal" Runat="server" Checked="True"></asp:CheckBox><LABEL id="lblReal"><%=GetResourceString("main_variable_types_options_numeric_float")%></LABEL></DIV>
                                    <DIV>
                                        <asp:CheckBox id="cbBool" Runat="server" Checked="True"></asp:CheckBox><LABEL id="lblBool"><%=GetResourceString("main_variable_types_options_boolean")%></LABEL></DIV>
                                    <DIV>
                                        <asp:CheckBox id="cbDate" Runat="server" Checked="True"></asp:CheckBox><LABEL id="lblDate"><%=GetResourceString("main_variable_types_options_date")%></LABEL></DIV>
                                    <DIV>
                                        <asp:CheckBox id="cbCategoricalWithOther" Runat="server" Checked="True"></asp:CheckBox><LABEL id="lblCategoricalWithOther"><%=GetResourceString("main_variable_types_options_cate_other")%></LABEL></DIV>
                                </DIV>
                            </DIV> <!-- Cart column options -->
                            <DIV class="section" id="cart_col_options" style="DISPLAY: none">
                                <DIV><LABEL id="lblCartColumnOptions"><%=GetResourceString("main_select_card_column_options")%></LABEL>:
                                </DIV>
                                <DIV class="indent">
                                    <TABLE>
                                        <TR id="keepOldCardColRow" runat="server">
                                            <TD>
                                                <asp:CheckBox id="cbKeepOldardCol" Runat="server"></asp:CheckBox><LABEL id="lblKeepOldCardCol"><%=GetResourceString("main_keep_current_card_columns")%></LABEL></TD>
                                            <TD>&nbsp;
                                            </TD>
                                        </TR>
                                        <TR>
                                            <TD><LABEL id="lblWidthOfSerialNumber"><%=GetResourceString("main_width_of_serial_number")%></LABEL></TD>
                                            <TD>
                                                <asp:TextBox id="txtWidthOfSerialNumber" Runat="server"></asp:TextBox></TD>
                                        </TR>
                                        <TR>
                                            <TD><LABEL id="lblWidthOfCardNumber"><%=GetResourceString("main_width_of_card_number")%></LABEL></TD>
                                            <TD>
                                                <asp:TextBox id="txtWidthOfCardNumber" Runat="server"></asp:TextBox></TD>
                                        </TR>
                                        <TR>
                                            <TD><LABEL id="lblMaxCardLength"><%=GetResourceString("main_max_card_length")%></LABEL></TD>
                                            <TD>
                                                <asp:TextBox id="txtMaxCardLength" Runat="server"></asp:TextBox></TD>
                                        </TR>
                                    </TABLE>
                                </DIV>
                            </DIV> <!-- Status filter options -->
                            <DIV class="section">
                                <DIV><LABEL id="lblStatusFilter"><%=GetResourceString("main_status_filter")%></LABEL>:
                                </DIV>
                                <DIV class="indent">
                                    <DIV><LABEL id="lblSelectStatusFilter"><%=GetResourceString("main_status_filter_select")%></LABEL>:
                                    </DIV>
                                    <DIV class="indent">
                                        <asp:RadioButtonList id="lstSelectStatusFilter" Runat="server"></asp:RadioButtonList></DIV>
                                </DIV>
                                <DIV class="indent">
                                    <DIV><LABEL id="lblWhereStatusFilter"><%=GetResourceString("main_where")%></LABEL>:
                                    </DIV>
                                    <DIV class="indent">
                                        <DIV>
                                            <asp:CheckBox id="cbCompletedSuccesfully" Runat="server" TextAlign="Right"></asp:CheckBox></DIV>
                                        <DIV>
                                            <asp:CheckBox id="cbActive" Runat="server" TextAlign="Right"></asp:CheckBox></DIV>
                                        <DIV>
                                            <asp:CheckBox id="cbTimedOut" Runat="server" TextAlign="Right"></asp:CheckBox></DIV>
                                        <DIV>
                                            <asp:CheckBox id="cbStoppedByScript" Runat="server" TextAlign="Right"></asp:CheckBox></DIV>
                                        <DIV>
                                            <asp:CheckBox id="cbStoppedByRespondent" Runat="server" TextAlign="Right"></asp:CheckBox></DIV>
                                        <DIV>
                                            <asp:CheckBox id="cbSystemShutdown" Runat="server" TextAlign="Right"></asp:CheckBox></DIV>
                                        <DIV>
                                            <asp:CheckBox id="cbReviewed" Runat="server" TextAlign="Right"></asp:CheckBox></DIV>
                                        <DIV>
                                            <asp:CheckBox id="cbSignal" Runat="server" TextAlign="Right"></asp:CheckBox></DIV>
                                    </DIV>
                                </DIV>
                            </DIV> <!-- Select filter based on date -->
                            <DIV class="section">
                                <DIV><LABEL id="lblDateFilter"><%=GetResourceString("main_select_filter_date")%></LABEL>:
                                </DIV>
                                <DIV class="indent">
                                    <TABLE width="100%">
                                        <TR>
                                            <TD width="100">
                                                <asp:CheckBox id="cbStartDate" Runat="server"></asp:CheckBox><LABEL id="lblStartDate"><%=GetResourceString("main_select_filter_date_start")%></LABEL></TD>
                                            <TD>
                                                <asp:TextBox id="txtStartDate" Runat="server"></asp:TextBox>
                                                <asp:CustomValidator id="valStartDate" Runat="server" ControlToValidate="txtStartDate"></asp:CustomValidator>
                                                <asp:CustomValidator id="valStartBeforeEndDate" Runat="server" ControlToValidate="txtStartDate"></asp:CustomValidator></TD>
                                        </TR>
                                        <TR>
                                            <TD>
                                                <asp:CheckBox id="cbEndDate" Runat="server"></asp:CheckBox><LABEL id="lblEndDate"><%=GetResourceString("main_select_filter_date_end")%></LABEL></TD>
                                            <TD>
                                                <asp:TextBox id="txtEndDate" Runat="server"></asp:TextBox>
                                                <asp:CustomValidator id="valEndDate" Runat="server" ControlToValidate="txtEndDate"></asp:CustomValidator></TD>
                                        </TR>
                                    </TABLE>
                                </DIV>
                            </DIV>
                        </TD>
                    </TR>
                </TABLE>
            </asp:panel>
        </form>
        <iframe style="DISPLAY: none; WIDTH: 0px; HEIGHT: 0px" src="shared/sessionkeepalive.aspx">
        </iframe>
        <script language="javascript">
            top.frames[0].document.location.href = "collections.aspx";
		</script>
	</body>
</HTML>
