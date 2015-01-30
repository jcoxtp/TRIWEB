<%@ Page Language="C#" AutoEventWireup="true"  Codebehind="Default.aspx.cs" Inherits="SPSS.ManageLogs.View.Default" %>

<%@ Register Src="DateSelecter.ascx" TagName="DateSelecter" TagPrefix="uc3" %>

<%@ Register Src="ProjectInfoControl.ascx" TagName="ProjectInfoControl" TagPrefix="uc2" %>
<%@ Register Assembly="DimensionNet, Version=3.0.2.0, Culture=neutral, PublicKeyToken=8174058f62942e31"
    Namespace="SPSSMR.Web" TagPrefix="cc1" %>
<%@ Register Src="RoundedGridView.ascx" TagName="RoundedGridView" TagPrefix="uc1" %>
<%@ OutputCache Location="none" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
    <head id="Head1" runat="server">
        <title>Demo</title>
        <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
        <meta name="CODE_LANGUAGE" Content="C#">
        <meta name="vs_defaultClientScript" content="JavaScript">
        <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        <!-- STANDARD FUNCTIONS FOR THIS APP -->
        <!-- JAVASCRIPT TABLESORT LIB -->
        <LINK href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="../shared/coolmenu/spssmenu.css">
        <!-- STANDARD SPSS TABS -->
        <LINK href="../shared/tabs/spsstabs.css" type="text/css" rel="stylesheet">
        <script src="../shared/tabs/tabctrl.js" type="text/javascript"></script>
        <script src="General.js" type="text/javascript"></script>
        <LINK href="PageNumber.css" type="text/css" rel="stylesheet">


    </head>
   <body MS_POSITIONING="GridLayout" leftMargin="0" topMargin="0" id="body" onload="initPanels();CreateIframe('DivWaiting');OpenWindow();updateTableHeight();" >
        <form id="form1" method="post" runat="server" >
          <br>
            
                    <!--all the panel : LogList,ViewEvent, SendLog-->
                    <!--sub panel : LogPanel, EventPanel, EmailPanel, FTPPanel-->
             	
		    <!--Send Log-->
			  <asp:Panel id="SendLog" runat="server" width="90%" style="Z-INDEX: 30; POSITION: absolute" >
			  <uc2:ProjectInfoControl id="CompressInfo" runat="server">
               </uc2:ProjectInfoControl>
               <br>
				<TABLE cellpadding="0" width="900px" style="background-color : #EFF7FF; border-right: black 1px solid; border-top: black 1px solid;border-left: black 1px solid; border-bottom: black 1px solid;">
				    <TR>
						<TD style="width: 225px" valign="top">
                           <div style="white-space:nowrap;"><asp:Literal ID="litMachine" runat="server" ></asp:Literal></div>
                        </TD>
						
						<td colspan="2" style="width: 400px">
                        &nbsp;&nbsp;<asp:ListBox ID="lstMachine" runat="server" Width="345px" SelectionMode="Multiple" Rows="3"> 
                            <asp:ListItem Selected="True" Text="All Machines"></asp:ListItem>
                        </asp:ListBox>
                        </td><td></td>
					</TR>
					
				    <TR>
				        <TD  style="width: 225px" valign="top">
                          <div style="white-space:nowrap;"><asp:Literal ID="litLogType" runat="server" ></asp:Literal></div>
                        </TD>
				        <td  colspan="2" style="width: 400px">
                        <asp:CheckBoxList ID="ckLstLogTypes" runat="server" BorderColor="#000066"  Width="330px" RepeatColumns="1">
                        </asp:CheckBoxList>
                        </td><td></td>
		            </TR>
		        			
					   <tr><td colspan="4">
				        <uc3:DateSelecter id="dateSelecterCompress" runat="server"></uc3:DateSelecter>
				    </td></tr>  
					    
		           <TR>
			        <TD  style="width: 225px" >
                       <div style="white-space:nowrap;"> <asp:Literal ID="litEvent" runat="server" ></asp:Literal></div>
                    </TD>
			        <TD style="width: 400px" align="left" colspan="2">
                        &nbsp;<asp:CheckBox ID="ckEvent" runat="server" Text="" />
                    </td>
                    <td></td>
			        </TR>
					    
					
					   
					<TR>
					    <TD style="width: 225px">
                            <div style="white-space:nowrap;"><asp:Literal ID="litReadMe" runat="server" ></asp:Literal></div>
                        </TD>
                        
                        <TD style="width: 150px">
                            <div style="white-space:nowrap;">&nbsp;&nbsp;<asp:Literal ID="litPriority" runat="server" ></asp:Literal></div>
                        </td>
                        <TD style="width: 160px">
                            <asp:DropDownList ID="ddlPriority" runat="server" Width="180px" ></asp:DropDownList>
                        </TD>	
                        <td></td>					
				    </TR> 
				    <tr>
				        <td></td>
                        <TD style="width: 150px">
                            <div style="white-space:nowrap;">&nbsp;&nbsp;<asp:Literal ID="litContact" runat="server" ></asp:Literal></div>
                        </td>
                        <TD style="width: 160px">
                            <asp:TextBox ID="txtContact" runat="server" Width="180px"></asp:TextBox>
                        </TD>	
                        	<td></td>				
				    </TR> 
				    <tr>
				        <td></td>
                        <TD valign=top style="width: 150px">
                            <div style="white-space:nowrap;">&nbsp;&nbsp;<asp:Literal ID="litDesc" runat="server" ></asp:Literal></div>
                        </td>
                        <TD style="width: 160px">
                            <asp:TextBox ID="txtDesc" runat="server" TextMode=MultiLine Rows=5 Width="350px"></asp:TextBox>
                        </TD>	
                        	<td></td>			
				    </TR> 
				   
					
			    </TABLE>
				<table>	
					<TR>
						<TD colspan="4" align=left>
                            <asp:Button ID="btnDownload" runat="server" OnClick="btnDownload_Click"/>
                            
                            </TD>	
                     </TR>
                     
                     <tr>
				        <td colspan="4" valign=middle style="height:40px;" ><asp:Literal ID="litDownload" runat="server" ></asp:Literal> 
				        </td>
                        				
				    </TR> 
                    
				</table>
                  
                  <br>
				
			</asp:Panel>  
                    <!--view Log list-->
             <asp:Panel id="LogList" runat="server" width="90%" style="Z-INDEX: 100; POSITION: absolute;"  >
				<uc2:ProjectInfoControl id="ViewLogs" runat="server">
               </uc2:ProjectInfoControl>
               <br>
				<TABLE cellpadding="0" width="900px" style="background-color : #EFF7FF; border-right: black 1px solid; border-top: black 1px solid;border-left: black 1px solid; border-bottom: black 1px solid;">
					    <TR>
						    <TD style="width: 150px" valign="top" >
                                <div style="white-space:nowrap;"><asp:Literal ID="litMachines" runat="server" ></asp:Literal></div>
                            </TD>
    						
						    <td colspan="2">
                           <asp:ListBox ID="lstMachines" runat="server" Width="400px" SelectionMode="Single" Rows="3"> 
                            </asp:ListBox>
                            </td>
					    </TR>
					    <TR>
						    <TD style="width: 150px;" valign="top">
                              <div style="white-space:nowrap;"> <asp:Literal ID="litSql" runat="server"></asp:Literal></div>

                            </TD>
                            <TD  colspan="2" valign="top" style="width: 400px;">
                               <asp:TextBox ID="txtSQL" runat="server" TextMode=MultiLine Rows="4" Width="400px"></asp:TextBox>
                            </TD>
    											
					    </TR>
					    
					</table>
					<table>
					    <TR>
						    <TD colspan=4  >
                                <asp:Button ID="btnViewLogs" runat="server" OnClick="btnViewLogs_Click"  />
                            </TD>	
                        </TR>
                        <TR>
						   <TD colspan=4 style="height:10px;">
                               
                           </TD>	
                        </TR>
                     </TABLE>
                
                 <uc1:RoundedGridView id="roundedGridView" runat="server"></uc1:RoundedGridView>
                
                 
                <br>
                <table width="100%" id="tblNavigator" runat="server">
                      <tr>
                        <td align="center" colSpan="6">
                            <TABLE id="Table3" cellSpacing="0" cellPadding="0">
                                <TR>
                                    <TD><asp:image id="imgFirst" runat="server" ImageUrl="..\Shared\Images\page_back.gif" ImageAlign="Middle"></asp:image></TD>
                                    <td><asp:image id="imgPrev" runat="server" ImageUrl="..\Shared\Images\page_back2.gif" ImageAlign="Middle"></asp:image></td>
                                    <TD><asp:label id="lblP1" runat="server" EnableViewState="False"></asp:label></TD>
                                    <TD><asp:label id="lblP2" runat="server" EnableViewState="False"></asp:label></TD>
                                    <TD><asp:label id="lblP3" runat="server" EnableViewState="False"></asp:label></TD>
                                    <TD><asp:label id="lblP4" runat="server" EnableViewState="False"></asp:label></TD>
                                    <TD><asp:label id="lblP5" runat="server" EnableViewState="False"></asp:label></TD>
                                    <TD><asp:image id="imgNext" runat="server" ImageUrl="../shared/images/page_forward2.gif" ImageAlign="Middle"></asp:image></TD>
                                    <TD><asp:image id="imgLast" runat="server" ImageUrl="../shared/images/page_forward.gif" ImageAlign="Middle"></asp:image></TD>
                                </TR>
                            </TABLE>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" colSpan="6"><div style="white-space:nowrap;"><asp:label id="lblTotalPages" runat="server"></asp:label></div></td>
                    </tr>
                    <tr>
                        <td align="left" colSpan="6"><div style="white-space:nowrap;"><asp:label id="lblTotalRecords" runat="server"></asp:label></div></td>
                    </tr>
                </table>
                <br>
			</asp:Panel> 
		
			 <asp:Panel id="ViewSetting" runat="server" width="90%" style="Z-INDEX: 100; POSITION: absolute;" >
			 <uc2:ProjectInfoControl id="ViewSettings" runat="server">
               </uc2:ProjectInfoControl>
               <br>
			 <TABLE cellpadding="0" width="900px" style="background-color : #EFF7FF; border-right: black 1px solid; border-top: black 1px solid;border-left: black 1px solid; border-bottom: black 1px solid;">
				   <TR>
						<TD  style="width: 225px" >
                         <div style="white-space:nowrap;"> <asp:Literal ID="litNum" runat="server" ></asp:Literal></div>
                        </TD>
						<td colspan="3" style="width: 500px">
                           &nbsp; <asp:DropDownList ID="ddlPages" runat="server" Width="190px">
                            <asp:ListItem Selected="TRUE" Text="50">50</asp:ListItem>
                            <asp:ListItem  Text="100" Value="100">100</asp:ListItem>
                            <asp:ListItem Text="500" Value="500">500</asp:ListItem>
                            <asp:ListItem Text="800" Value="800">800</asp:ListItem>
                            </asp:DropDownList>
                        </td>
						<td></td>
					</TR>
				    <TR>
						<TD  style="width: 225px" valign="top">
                          <div style="white-space:nowrap;"><asp:Literal ID="litType" runat="server" ></asp:Literal></div>
                        </TD>
						<td colspan="3" style="width: 500px">
                        <asp:CheckBoxList ID="ckLstType" runat="server" BorderColor="#000066"  Width="220px" RepeatColumns="1">
                        </asp:CheckBoxList>
                        </td>
						<td></td>
					</TR>
					<tr><td colspan="5">
				        <uc3:DateSelecter id="dateSelecterSettings" runat="server"></uc3:DateSelecter>
				    </td></tr>
					     
				
				</TABLE>
				<table cellpadding="0">
				<TR>
				    <TD align=left>
                        <asp:Button ID="btnApply" runat="server" Width="50px" OnClick="btnApply_Click"/>&nbsp;&nbsp;&nbsp;  <asp:Button ID="btnCancel" runat="server" Width="50px" OnClick="btnCancel_Click"/>
                    </TD>	
                 </TR>
                </table>
                <br>
			 </asp:Panel>
			     
            <input id="TabID" type="hidden" runat="server"/> 
            <input id="Archive" type="hidden" runat="server"/>   
            <input id="ViewMachine" type="hidden" runat="server"/>
            <input id="DownloadDate" type="hidden" runat="server"/>
            <input id="DownloadPriority" type="hidden" runat="server"/>
            <input id="DownloadMachine" type="hidden" runat="server"/>   
            <input id="SettingDate" type="hidden" runat="server"/>   
            <input id="SettingPages" type="hidden" runat="server"/> 
            <input id="cellContent" type="hidden" runat="server"/> 
            <input id="ViewClick" type="hidden" runat="server"/> 
            <input type="hidden" name="waitlayerstring" value='<%=GetResourceString("waiting_string")%>' />
            <INPUT id="paging_currentpage" type="hidden" name="paging_currentpage" runat="server"/>     
			<iframe
                id="DivBody"
                src=""
                scrolling="no"
                frameborder="0"
                style="position:absolute; top:0px; left:0px; display:none; z-index:9999; background-color:Green;" >
            </iframe>
        </form>
    </body>
</html>
