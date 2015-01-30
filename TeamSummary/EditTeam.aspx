<%@ Page language="c#" Codebehind="EditTeam.aspx.cs" AutoEventWireup="false" Inherits="TeamSummary.EditTeam" %>
<%@ Register TagPrefix="uc1" TagName="EditBanner" Src="EditBanner.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>Edit Team</title>
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
			
			function txtTeamNameOnBlur() {
				if(Form1.txtTeamName.value.length > 0)
					setVisibility("errTeamName", "hidden");
			}
			function editLeader(user) {
				Form1.hidLeaderID.value = user.UserID;
				Form1.lblLeader.value = user.Name;
				myWin.close();
				
				setVisibility("errLeader", "hidden");
			}
			
			function editCompany(company) {
				Form1.hidCompanyID.value = company.CompanyID;
				Form1.lblCompany.value = company.Name;
				myWin.close();
				
				setVisibility("errCompany", "hidden");
			}
			
			function addNewMember(member)
			{
				var tbody = document.getElementById("newMembers").getElementsByTagName("TBODY")[0];
				var rowIndex = tbody.rows.length;
				var row = document.createElement("TR");
				
				row.setAttribute("onmouseover", "this.className='datagrid-alternatingitem'");
				row.setAttribute("onmouseout", "this.className='datagrid-item'");
				row.vAlign = "middle";
				
				var td1 = document.createElement("TD");
				td1.appendChild(document.createTextNode(member.UserName));
				var hID = document.createElement("INPUT");
				hID.setAttribute("type", "hidden");
				hID.value = member.UserID;
				td1.appendChild(hID);
				
				var td2 = document.createElement("TD");
				td2.appendChild(document.createTextNode(member.Name));
				
				var td3 = document.createElement("TD");
				td3.appendChild(document.createTextNode(member.Email));
				
				var td4 = document.createElement("TD");
				var testText = "Team Resources, Inc.: " + rowIndex;
				td4.appendChild(document.createTextNode(member.Company));
				
				var td5 = document.createElement("TD");
				var delBtn = document.createElement("image");
				delBtn.src = "../images/icon-delete.gif";
				delBtn.onclick = function(){
					removeNewMemberRow(row.rowIndex);
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
				row.appendChild(td4);
				row.appendChild(td5);
				
				tbody.appendChild(row);				
			}
			
			
			function removeNewMemberRow(idx)
			{
				var tbody = document.getElementById("newMembers").getElementsByTagName("TBODY")[0];
				tbody.deleteRow(idx);
			}
			
			function validatePage() {
				var isValid = true;
				
				if(Form1.txtTeamName.value.length < 1) {
					setVisibility("errTeamName", "visible");
					isValid = false;
				}
				
				if(Form1.lblCompany.value.length < 1) {
					setVisibility("errCompany", "visible");
					isValid = false;
				}
				
				if(Form1.lblLeader.value.length < 1) {
					setVisibility("errLeader", "visible");
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
				
				var iCurCell = 0 + newMembers.cols;
				var tbody = document.getElementById("newMembers").getElementsByTagName("TBODY")[0];
				
				var teamID = document.getElementById("hidTeamID");
				var teamName = document.getElementById("txtTeamName");
				var leaderID = document.getElementById("hidLeaderID");
				var companyID = document.getElementById("hidCompanyID");
				
				var teamXMLNode = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n" +  
										"<Team>" +
										"<TeamName>" + teamName.value + "</TeamName>" + 
										"<tID>" + teamID.value + "</tID>" + 
										"<LeaderID>" + leaderID.value + "</LeaderID>" + 
										"<CompanyID>" + companyID.value + "</CompanyID>";
										
				teamXMLNode += "<TeamMembers>";
				for(i = 1; i < tbody.rows.length; i++)
				{	
					teamXMLNode += "<Member>";
					teamXMLNode += "<TeamID>" + teamID.value + "</TeamID>";
					teamXMLNode += "<UserID>" + tbody.rows[i].getElementsByTagName("INPUT")[0].value + "</UserID>";
					teamXMLNode += "</Member>";
				}
				teamXMLNode += "</TeamMembers></Team>";
				
				//alert(teamXMLNode);
				xhttp = new ActiveXObject("MSXML2.XMLHTTP");
					
				//hook the event handler
				xhttp.onreadystatechange = HandlerOnReadyStateChange;
				
				//prepare the call, http method=GET, false=asynchronous call
				xhttp.open("POST", "Team.ashx", false);
				xhttp.setRequestHeader("Content-Type", "application/xml")
				//finally send the call
				xhttp.send(teamXMLNode);
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
					var nodes = xhttp.responseXML.selectNodes("//tID");
					Form1.hidTeamID.value = nodes(0).text;
					//alert(nodes(0).text);
					Form1.lblSysMsg.value = "data upload complete!";
					setTimeout(clearSysMsg, 2000);
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
					<td><uc1:editbanner id="EditBanner1" runat="server"></uc1:editbanner><input id="callbackMethod" type="hidden" value="addNewMember" name="callbackMethod"></td>
				</tr>
			</table>
			<TABLE id="tblMain" cellSpacing="5" cellPadding="0" width="100%" border="0">
				<TR>
					<TD class="style1" colSpan="3">
						<asp:HyperLink id="lnkToList" runat="server" NavigateUrl="ManageTeams.aspx">Team List</asp:HyperLink>&nbsp;&gt;&gt;
						<asp:Label id=lblPageTitle runat="server" Text="<%# _team.Name %>">
						</asp:Label></TD>
				</TR>
				<TR>
					<TD class="section-divline" colSpan="3">&nbsp;<INPUT style="MARGIN-TOP: 2px" onclick="persistData(); return false;" type="image" src="../images/icon-floppy.gif"></TD>
				</TR>
				<TR>
					<TD style="WIDTH: 269px" vAlign="top" rowSpan="2">
						<table style="WIDTH: 256px; HEIGHT: 90px" border="0">
							<tr>
								<td vAlign="top">Team&nbsp;Name:</td>
								<td><asp:textbox id=txtTeamName runat="server" CssClass="standard-text" Text="<%# _team.Name %>" Width="168px"></asp:textbox><BR>
									<DIV id="errTeamName" style="DISPLAY: inline; VISIBILITY: hidden; WIDTH: 168px; COLOR: red">*Team 
										Name is a required field.</DIV>
								</td>
								<TD></TD>
							</tr>
							<TR>
								<TD vAlign="top">Leader:</TD>
								<TD vAlign="middle">
									<INPUT id="lblLeader" 
            style="WIDTH: 168px" readOnly type=text value="<%# _team.Leader %>" 
            runat="server" class=standard-label><BR>
									<DIV id="errLeader" style="DISPLAY: inline; VISIBILITY: hidden; WIDTH: 168px; COLOR: red">*Leader 
										is a required field.</DIV>
								</TD>
								<TD>
									<div onmouseover="this.style.cursor='hand'" onclick="popUp('AddMember.aspx', 'editLeader')"
										onmouseout="this.style.cursor='default'"><asp:image id="imgEditLeader" runat="server" ImageUrl="../images/users.gif" AlternateText="Edit Team Leader"></asp:image></div>
								</TD>
							</TR>
							<tr>
								<td vAlign="top">Company:</td>
								<td><input class=standard-label id=lblCompany 
            style="WIDTH: 168px" readOnly type=text value="<%# _team.Company %>" 
             runat="server"><BR>
									<DIV id="errCompany" style="DISPLAY: inline; VISIBILITY: hidden; WIDTH: 168px; COLOR: red">*Company 
										is a required field.</DIV>
								</td>
								<TD>
									<div onmouseover="this.style.cursor='hand'" onclick="popUp('AddCompany.aspx', 'editCompany')"
										onmouseout="this.style.cursor='default'"><asp:image id="imgEditCompany" runat="server" ImageUrl="../images/Contacts.gif" AlternateText="Edit Associated Company"></asp:image></div>
								</TD>
							</tr>
						</table>
						<INPUT 
      id=hidTeamID style="WIDTH: 32px; HEIGHT: 22px; BACKGROUND-COLOR: red" 
      type=hidden size=1 value="<%# _team.ID %>" name=hidTeamID 
       runat="server"><INPUT id=hidLeaderID 
      style="WIDTH: 32px; HEIGHT: 22px; BACKGROUND-COLOR: red" type=hidden 
      size=1 value="<%# _team.LeaderID %>" name=hidLeaderID 
      runat="server"><INPUT id=hidCompanyID 
      style="WIDTH: 32px; HEIGHT: 22px; BACKGROUND-COLOR: red" type=hidden 
      size=1 value="<%# _team.CompanyID %>" name=hidCompanyID 
       runat="server"><INPUT class="system-label" id="lblSysMsg" style="DISPLAY: inline; VISIBILITY: hidden; WIDTH: 160px; HEIGHT: 22px"
							readOnly type="text" value="Uploading..." ms_positioning="FlowLayout"></TD>
					<TD vAlign="middle" colSpan="2">
						<DIV onmouseover="this.style.cursor='hand'" onclick="popUp('AddMember.aspx', 'addNewMember')"
							onmouseout="this.style.cursor='default'">Add Team Members&nbsp;
							<asp:image id="imgAddMember" runat="server" ImageUrl="../images/CreateTeams.gif"></asp:image></DIV>
					</TD>
				</TR>
				<TR>
					<td vAlign="top" colSpan="2">
						<div onmouseover="this.style.cursor='hand'" onclick="popUp('Template.htm')" onmouseout="this.style.cursor='default'">&nbsp;</div>
						<table id="newMembers" cellSpacing="0" cellPadding="1" border="0" runat="server">
							<tbody id="memberRows">
								<tr class="datagrid-header">
									<td width="75">Username</td>
									<td width="100">Member&nbsp;Name</td>
									<td width="250">Email</td>
									<td width="150" colSpan="2">Company</td>
								</tr>
							</tbody>
						</table>
					</td>
				</TR>
				<TR>
					<TD colSpan="3"></TD>
				</TR>
			</TABLE>
			</TD></TR></TBODY></TABLE></form>
	</body>
</HTML>
