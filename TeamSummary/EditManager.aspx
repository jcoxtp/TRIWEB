<%@ Page language="c#" Codebehind="EditManager.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.EditManager" %>
<%@ Register TagPrefix="uc1" TagName="EditBanner" Src="EditBanner.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Edit League Manager</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="styles.css" type="text/css" rel="stylesheet">
		<script src="findDOM.js"></script>
		<script src="CtrlBehavior.js"></script>
		<script src="trUser.js"></script>
		<script language="javascript">
			var xhttp;
			var myWin;
			
			function popUp(url, callbackMethod)
			{
				Form1.callbackMethod.value = callbackMethod;
				myWin = window.open(url, "popDialog", "width=500,height=600;resizable=yes;scrollbars=yes");
			}
			
		
			function editLeagueManager(user) {
				Form1.hidLeagueManagerID.value = user.UserID;
				Form1.lblLeagueManager.value = user.Name;
				myWin.close();
				
				setVisibility("errLeagueManager", "hidden");
			}
			
		
			
			function addNewTeam(team)
			{
				//alert(team.toXML());
				var tbody = document.getElementById("tblTeams").getElementsByTagName("TBODY")[0];
				var rowIndex = tbody.rows.length;
				var row = document.createElement("TR");
				
				row.setAttribute("onmouseover", "this.className='datagrid-alternatingitem'");
				row.setAttribute("onmouseout", "this.className='datagrid-item'");
				row.vAlign = "middle";
				
				var td1 = document.createElement("TD");
				td1.appendChild(document.createTextNode(team.Name));
				var hID = document.createElement("INPUT");
				hID.setAttribute("type", "hidden");
				hID.value = team.TeamID;
				td1.appendChild(hID);
				
				var td2 = document.createElement("TD");
				td2.appendChild(document.createTextNode(team.Leader));
				
				var td3 = document.createElement("TD");
				td3.appendChild(document.createTextNode(team.Company));
				
				var td5 = document.createElement("TD");
				var delBtn = document.createElement("image");
				delBtn.src = "../images/icon-delete.gif";
				delBtn.onclick = function(){
					removeNewTeamRow(row.rowIndex);
				}; //this works!
				delBtn.onmouseover = function(){
					this.style.cursor = "hand";
				};
				delBtn.onmouseout = function(){
					this.style.cursor = "default";
				}
				td5.appendChild(delBtn);
				
				row.appendChild(td1);
				row.appendChild(td2);
				row.appendChild(td3);
				row.appendChild(td5);
				
				tbody.appendChild(row);				
			}
			
			
			function removeNewTeamRow(idx)
			{
				var tbody = document.getElementById("tblTeams").getElementsByTagName("TBODY")[0];
				tbody.deleteRow(idx);
			}
			
			function validatePage() {
				var isValid = true;
				
				if(Form1.hidLeagueManagerID.value < 1) {
					setVisibility("errLeagueManager", "visible");
					isValid = false;
					
				}
				
				return isValid
			}
			
			function persistData()
			{
				if(!validatePage()) {
					alert("Correct errors before saving.");
					return;
				}
				
				setVisibility("lblSysMsg", "visible");
				Form1.lblSysMsg.value = "uploading data to server...";
				
				var tbody = document.getElementById("tblTeams").getElementsByTagName("TBODY")[0];
				
				var managerID = document.getElementById("hidLeagueManagerID");
				
				var mgrXMLNode = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n" +  
										"<LeagueManager>" +
										"<UserID>" + managerID.value + "</UserID>";
										
				mgrXMLNode += "<TeamIDCollection>";
				for(i = 1; i < tbody.rows.length; i++)
				{	
					mgrXMLNode += "<Team ID=\"" + tbody.rows[i].getElementsByTagName("INPUT")[0].value + "\"/>";
				}
				mgrXMLNode += "</TeamIDCollection></LeagueManager>";
				
				//alert(mgrXMLNode);
				xhttp = new ActiveXObject("MSXML2.XMLHTTP");
					
				//hook the event handler
				xhttp.onreadystatechange = HandlerOnReadyStateChange;
				
				//prepare the call, http method=GET, false=asynchronous call
				xhttp.open("POST", "LeagueManager.ashx", false);
				xhttp.setRequestHeader("Content-Type", "application/xml")
				//finally send the call
				xhttp.send(mgrXMLNode);
			}
			
			function HandlerOnReadyStateChange(){
				
				//this handler is called 4 times for each state change of xmlhttp
				//states are 0 uninitialized
				//			1 loading
				//			2 loaded
				//			3 interactive
				//			4 complete
				if (xhttp.readyState==4){
					
					//responseXML contains an XMLDOM object
					//var nodes = xhttp.responseXML.selectNodes("//UserID");
					//Form1.hidLeagueManagerID.value = nodes(0).text;
					//alert(nodes(0).text);
					
					var nodes = xhttp.responseXML.selectNodes("//LeagueManager//Exception");
					
					if (nodes(0)) {
						alert("Error:\n" + nodes(0).text);
						Form1.lblSysMsg.value = nodes(0).text;
					}
					else {
						Form1.lblSysMsg.value = "data upload complete!";
						setTimeout(clearSysMsg, 2000);
					}
				}
			}
			
			function clearSysMsg() {
				setVisibility("lblSysMsg", "hidden");
			}
			
			
		</script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table id="Table1" cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td>
						<uc1:EditBanner id="EditBanner1" runat="server"></uc1:EditBanner><INPUT id="callbackMethod" type="hidden" value="addNewTeam" name="callbackMethod"></td>
				</tr>
			</table>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="style1" colSpan="3">
						<asp:HyperLink id="lnkToList" runat="server" NavigateUrl="LeagueManagers.aspx">League Manager List</asp:HyperLink>
						&gt;&gt;
						<asp:Label id=pageTitle runat="server" Text="<%# _manager.Name %>">
						</asp:Label></TD>
				</TR>
				<TR>
					<TD class="section-divline" colSpan="3">&nbsp;<INPUT style="MARGIN-TOP: 2px" onclick="persistData(); return false;" type="image" src="../images/icon-floppy.gif"></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 310px" vAlign="top" rowSpan="2">
						<TABLE id="Table2" style="WIDTH: 304px; HEIGHT: 58px" cellSpacing="0" cellPadding="1" width="304"
							border="0">
							<TR>
								<TD style="WIDTH: 84px">&nbsp;</TD>
								<TD style="WIDTH: 182px">&nbsp;</TD>
								<TD>&nbsp;</TD>
							</TR>
							<TR>
								<TD style="WIDTH: 84px" vAlign="top">League&nbsp;Manager:</TD>
								<TD style="WIDTH: 182px" vAlign="top"><INPUT 
            class=standard-label id=lblLeagueManager style="WIDTH: 168px" 
            readOnly type=text value="<%# _manager.Name %>" name=lblLeader 
             runat="server"><BR>
									<DIV id="errLeagueManager" style="DISPLAY: inline; VISIBILITY: hidden; WIDTH: 184px; COLOR: red; HEIGHT: 24px">*League 
										manager is a required field.</DIV>
								</TD>
								<TD vAlign="top"><INPUT id="btnEditManager" onclick="popUp('AddMember.aspx', 'editLeagueManager'); return false;"
										type="image" src="../images/users.gif" value="Edit League Manager">
								</TD>
							</TR>
						</TABLE>
						<INPUT class="system-label" id="lblSysMsg" style="DISPLAY: inline; VISIBILITY: hidden; WIDTH: 304px; HEIGHT: 22px"
							readOnly type="text" size="38" value="Uploading..." name="lblSysMsg" ms_positioning="FlowLayout">
					</TD>
					<TD vAlign="bottom" colSpan="2">
						<DIV onmouseover="this.style.cursor='hand'" onclick="popUp('AddTeam.aspx', 'addNewTeam')"
							onmouseout="this.style.cursor='default'">Add teams to this manager
							<asp:image id="imgAddTeam" runat="server" ImageUrl="../images/CreateTeams.gif"></asp:image></DIV>
					</TD>
				</TR>
				<TR>
					<TD vAlign="top" colSpan="2">&nbsp;
						<TABLE id="tblTeams" cellSpacing="0" runat="server" cellPadding="1" width="600" border="0">
							<tbody>
								<TR class="datagrid-header">
									<TD>Team</TD>
									<TD>Leader</TD>
									<TD colSpan="2">Company</TD>
								</TR>
							</tbody>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD colSpan="3"><INPUT id=hidLeagueManagerID 
      style="WIDTH: 32px; HEIGHT: 22px; BACKGROUND-COLOR: red" type=hidden 
      size=1 value="<%# _manager.ID %>" name=hidLeagueManagerID 
  runat="server">
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
