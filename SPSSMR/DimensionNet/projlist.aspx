<%@ Register TagPrefix="ignav" Namespace="Infragistics.WebUI.UltraWebNavigator" Assembly="Infragistics2.WebUI.UltraWebNavigator.v7.2, Version=7.2.20072.61, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" %>
<%@Page Inherits="Launcher.ProjectListClass"%>
<%@ OutputCache Location="none" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>SPSS DimensionNet</title> <!-- 
 * Warning: this computer program is protected by
 * copyright law and international treaties.
 * Unauthorized reproduction or distribution of this
 * program, or any portion of it, may result in severe
 * civil and criminal penalties, and will be procecuted * to the maximum extent of the law. *  * Copyright (c) 2001-2002 SPSS Ltd. -->
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<link href="../shared/spssmrNet.css" type="text/css" rel="stylesheet">
		<style type="text/css">
			.ActiveCell { COLOR: white; BACKGROUND-COLOR: #31569c }
		</style>
		<script type="text/javascript" src="../shared/dialog/dialog.js"></script>
		<script type="text/javascript" src="jsinclude.js"></script>
		
		<script type="text/javascript" src="projlist.js"></script>
		 
		<script type="text/javascript">
		<!--
		var currentSelection = "";
		var wBradBackup;
	    function initSelection() 
	    {
	     	//Select the project node
			showCurrentProjectInfo();
		}
		function deleteProjectDialog() 
		{
			var type = document.forms[0].tbSelection.getAttribute("nodetype");
			if(type !="project")
			{
			    alert(getI18N("JUSTFORPROJECT"));
			    return;
			}
			var project =  document.forms[0].tbSelection.value;
			
			if (project == "") {
				alert(getI18N("JUSTFORPROJECT"));
				return;
			}
			
			var url = '../BackupAndRestore/MyApplicationInit.aspx?project=' + project;
			var lang = '&lang=' + document.forms[0].tbPreferredLanguage.value;
			var action = '&action=delete';
			
			url += lang;
			url += action;
			
			var wBradDelete;
			wBradDelete= window.open(url, "brad_delete", "width=470,height=300,location=no,menubar=no,toolbar=no");
			wBradDelete.focus();

		}

		function editProject(anchor)
		{
			//alert(anchor);
			var type = document.forms[0].tbSelection.getAttribute("nodetype");
			if(type !="project")
			{
			    alert(getI18N("JUSTFORPROJECT"));
			    return;
			}
			var project =  document.forms[0].tbSelection.value;
			
			if (project == "") {
				alert(getI18N("JUSTFORPROJECT"));
				return;
			}
			
			var sUrl = "gotoapp.aspx?app=projecteditor&proj=" + project;
			var sHash = getHash(top.location);
			if (sHash!="")
				sUrl+="&hash="+sHash;
         	top.location.href = sUrl;
		}

		function backupProject()
		{		  		
			var type = document.forms[0].tbSelection.getAttribute("nodetype");
			if(type !="project")
			{
			    alert(getI18N("JUSTFORPROJECT"));
			    return;
			}
			var project =  document.forms[0].tbSelection.value;
			
			if (project == "") {
				alert(getI18N("JUSTFORPROJECT"));
				return;
			}
				
			var sUrl = "../BackupAndRestore/BradBackupStart.aspx?project=" + project	
			var sHash = getHash(top.location);
			var sWindowName = "brad_backup";
			
			if (sHash!="")
			{
				sUrl+="&hash="+sHash;
			}
			
			//Check if the window is open				
			if(wBradBackup != null)
			{			
				try
				{
					if(wBradBackup.closed)
					{					
						wBradBackup = window.open(sUrl, sWindowName, "width=470,height=300,location=no,menubar=no,toolbar=no");
						wBradBackup.focus();
					}
					else
					{			
						wBradBackup.focus();	
					}
				}
				catch(exception)
				{
					if(exception.description == null)
					{
						alert("Error: " + exception.message);
					}
					else
					{
						alert("Error: " + exception.description);
					}				
				}			
			}
			else
			{						
				wBradBackup = window.open(sUrl, sWindowName, "width=470,height=300,location=no,menubar=no,toolbar=no");
				wBradBackup.focus();
			}	
		}

		function lockProject(bLockProject)
		{
			var type = document.forms[0].tbSelection.getAttribute("nodetype");
			if(type !="project")
			{
			    alert(getI18N("JUSTFORPROJECT"));
			    return;
			}
			var project =  document.forms[0].tbSelection.value;
			
			if (project == "") {
				alert(getI18N("JUSTFORPROJECT"));
				return;
			}
				
			if (bLockProject)
				document.forms[0].btnLock.onclick();
			else
				document.forms[0].btnUnlock.onclick();
		}
		-->
		</script>
	</HEAD>
	<body onload="javascript:initSelection();resizeTree();scrollInSelectedNode();" onresize="javascript:resizeTree();"  topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
	<form id="ProjListClass" name="ProjListClass" runat="server">
		<table id="_ctl0_tblTable" class="RoundedTable" cellpadding="0" border="0" style="width:100%;height:100%">
			<tr><td colspan="2" rowspan="2" style="width:10px;"><IMG height='30' alt='' src='shared/images/RoundedTableControl/dark_topleft.gif' width='10'></td><td class="RoundedTableOuterBorder" colspan="2" style="height:1px;"></td><td colspan="2" rowspan="2"><img src='shared/images/RoundedTableControl/dark_topright.gif' height='30' width='10' alt=''></td></tr>
			<tr><td class="RoundedTableDarkHeader" colspan="2"><asp:Label ID="lblMyProjects" Runat="server"></asp:Label></td></tr>
			<tr>
				<td class="RoundedTableOuterBorder" style="width:1px;"></td>
				<td class="RoundedTableProjectInfoBackground" style="width:9px;"></td>
				<td class="RoundedTableProjectInfoBackground" colspan="2" style="width:100%;"></td>
				<td class="RoundedTableProjectInfoBackground" style="width:9px;"></td>
				<td class="RoundedTableOuterBorder" style="width:1px;"></td>
			</tr>
			<tr>
				<td class="RoundedTableOuterBorder" style="width:1px;"></td>
				<td class="RoundedTableLightHeader" style="width:9px;"></td>
				<td class="RoundedTableLightHeader" colspan="2" style="height:28px;width:100%;">
					<asp:Table ID="tblProjectMenu" Runat="server" Width="100%"></asp:Table>
				</td>
				<td class="RoundedTableLightHeader" style="width:9px;"></td>
				<td class="RoundedTableOuterBorder" style="width:1px;"></td>
			</tr>
			<tr valign="top" style="height:100px;width:100px">
				<td class="RoundedTableOuterBorder" style="width:1px;"></td>
				<td class="RoundedTableDarkInfo" colspan="4" height="100%" id="TreeCell">
                    <asp:Label ID="lblInfo" runat="server" Text=""></asp:Label>
					 <ignav:UltraWebTree ID="webTreeProjects" runat="server" TargetFrame="frmeRHS" Cursor="Default"
                        Indentation="20" ImageDirectory="" WebTreeTarget="HierarchicalTree" CollapseImage="./images/projectIcon/Minus.gif"
                        ExpandImage="./images/projectIcon/Plus.gif" Font-Names="Verdana" Font-Size="8pt"
                        OnNodeRemoved="webTreeProjects_NodeRemoved" OnNodeChanged="webTreeProjects_NodeChanged"
                        OnNodeDropped="webTreeProjects_NodeDropped" Height="100%" Editable="true" OnNodeCollapsed="webTreeProjects_NodeCollapsed" OnNodeExpanded="webTreeProjects_NodeExpanded">
                        <NodeEditStyle CssClass="EditNode"/>
                        <SelectedNodeStyle CssClass="SelectedNode"/>
                        <HoverNodeStyle CssClass="HoverNode"/>
                        <NodePaddings Bottom="1px" Left="0px" Top="3px" Right="0px"></NodePaddings>
                        <Levels>
                            <ignav:Level Index="0"></ignav:Level>
                            <ignav:Level Index="1"></ignav:Level>
                        </Levels>
                        <ClientSideEvents AfterNodeSelectionChange="afterNodeSelChange" DragStart="treeNodeDragStart" DragOver="treeNodeDragOver" 
                            KeyUp="treeKeyUp" AfterBeginNodeEdit="afterBeginNodeEdit">
                        </ClientSideEvents>
                        <AutoPostBackFlags NodeChanged="True"/>
                    </ignav:UltraWebTree>
				</td>
				<td class="RoundedTableOuterBorder" style="width:1px;"></td>
			</tr>
			<tr><td class="RoundedTableDarkInfo" colspan="2" rowspan="2"><img src='shared/images/RoundedTableControl/light_bottomleft.gif' height='10' width='10'</td><td class="RoundedTableDarkInfo" colspan="2" style="height:9px;"></td><td class="RoundedTableDarkInfo" colspan="2" rowspan="2"><img src='shared/images/RoundedTableControl/light_bottomright.gif' height='10' width='10'></td></tr>
			<tr><td class="RoundedTableOuterBorder" colspan="2" style="height:1px;"></td></tr>
		</table>
		<input id="tbSelection" runat="server" type="hidden">
		<input id="tbCut" runat="server" type="hidden">
		<input id="tbTreeLoaded" runat="server" type="hidden">
		<input id="tbExpend" runat="server" type="hidden">
		<input id="tbCanManageFolder" runat="server" type="hidden">
		<input id="tbPreferredLanguage" runat="server" type="hidden" NAME="lang" value="">
		<input id="btnUnlock" type="button" runat="server" onserverclick="btnUnlock_Click" style="VISIBILITY: hidden;">
		<input id="btnLock" type="button" runat="server" onserverclick="btnLock_Click" style="VISIBILITY: hidden;" >
	</form>
	<div><asp:Label id="txtLoading" runat="server">Loading Applications Please Wait</asp:Label></div>
	<div id="reloader" runat="server"></div>
	</body>
</HTML>
