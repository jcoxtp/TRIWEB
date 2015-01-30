<%@ Page AutoEventWireup="false" %>
<%@ OutputCache Location="none" %>
<!-- 
	IMPORTANT
	This page is not part of the EditProject application.
	It is for internal test only and should not be distributed
	with the web application.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<META NAME="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<title>Application Test Page</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<style type="text/css"> A { COLOR: blue; TEXT-DECORATION: underline; CURSOR: hand; }
		</style>
		<script type="text/javascript" src="/SPSSMRDEV/Shared/Dialog/dialog.js"></script>
		<script type="text/javascript">
		<!--
			window.name = 'uniguename' + Number(new Date()).toString();
			
			function initPage() {
				if ( isDialog() ) {
					document.getElementById('mainPageDiv').style.display = "none";
				}
			}
			window.onload=initPage;
			
			function newProjectDialog() {
				var url = 'dlgNewProject.aspx?lang='+document.Form1.lang.value;
				var rv = doDialog(url);
				if ( rv == null ) {
					alert('You just closed the dialog!\nNo project was created');
				}
				else if ( rv.status == "ok" ) {
					alert('You pressed "Ok" in the dialog.\nA project was created:\nProject Name : '+rv.project+'\nApplication : '+rv.application);
				}
				else if ( rv.status == "cancel" ) {
					alert('You pressed "Cancel" in the dialog.');
				}
				else {
					alert('Unknown return value returned from the dialog!');
				}
			}
			
			function startChain() {
				document.Form2.action = document.getElementById('chainAction').value;
				var paramSeperator = "?";
				if ( document.getElementById('Integrated') ) {
					document.Form2.action += paramSeperator + 'Integrated=' + document.getElementById('Integrated').value;
					paramSeperator = "&";
				}
				
				if ( document.getElementById('Silent') ) {
					document.Form2.action += paramSeperator + 'Silent=' + document.getElementById('Silent').value;
					paramSeperator = "&";
				}
				
				if ( document.getElementById('RequestStatusChangeTo') ) {
					document.Form2.action += paramSeperator + 'RequestStatusChangeTo=' + document.getElementById('RequestStatusChangeTo').value;
					paramSeperator = "&";
				}
				
				if ( document.getElementById('chainTarget').value == "_top" ) {
					document.Form2.target = window.name
				}
				else {
					document.Form2.target = document.getElementById('chainTarget').value;
				}
				document.Form2.submit();
			}
			
			function startApplication(strAppPath) {
				document.Form2.action = strAppPath;
				document.Form2.target = window.name
				document.Form2.submit();
			}
			
		-->
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<div style="FONT-WEIGHT: bold; FONT-SIZE: smaller">Context User : "<%=Context.User.Identity.Name%>"</div>
		<div id="mainPageDiv">
			<form id="Form1" name="Form1" method="post">
				<select id="lang" name="lang">
					<option value="en-us" selected>English</option>
					<option value="da">Danish</option>
					<option value="fool">Foolish</option>
				</select>
			</form>
			<a onclick="newProjectDialog()">New Project (Just open the dialog)</a>
			<hr>
			<hr>
			<a onclick="doDialog('WebForm1.aspx', '600px', '500px');">The Form below in a dialog...</a>
			<hr>
		</div>
		<table ID="Table1">
			<tr>
				<td>
					Action
				</td>
				<td>
					<select id="chainAction" name="chainAction">
						<option value="Chain_NewProject.aspx" selected>Chain_NewProject.aspx</option>
						<option value="default.aspx">default.aspx</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					Target
				</td>
				<td>
					<select id="chainTarget" name="chainTarget">
						<option value="_top">Existing Browser</option>
						<option value="_blank" selected>New Browser</option>
					</select>
				</td>
			</tr>
		</table>
		<hr>
		<b>URL Parameters:</b>
		<table ID="Table2">
			<tr>
				<td>
					Integrated
				</td>
				<td>
					<select id="Integrated" name="Integrated">
						<option value="0">0</option>
						<option value="1" selected>1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					Silent
				</td>
				<td>
					<select id="Silent" name="Silent">
						<option value="0" selected>0</option>
						<option value="1">1</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					RequestStatusChangeTo
				</td>
				<td>
					<select id="RequestStatusChangeTo" name="RequestStatusChangeTo">
						<option value="" selected>&lt;Empty&gt;</option>
						<option value="Test">Test</option>
						<option value="Active">Active</option>
					</select>
				</td>
			</tr>
		</table>
		<form id="Form2" name="Form2" method="post">
			<b>Form Parameters:</b>
			<table ID="Table3">
				<tr>
					<td>
						AppName
					</td>
					<td>
						<input type="text" id="AppName" name="AppName" value="App1">
					</td>
				</tr>
				<tr>
					<td>
						ChainName
					</td>
					<td>
						<select id="ChainName" name="ChainName">
							<option value="MRAgency_NewProject" selected>MRAgency_NewProject</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						ProjectName
					</td>
					<td>
						<input type="text" id="ProjectName" name="ProjectName">
					</td>
				</tr>
				<tr>
					<td>
						ProjectSrcFolder
					</td>
					<td>
						<input type="text" id="ProjectSrcFolder" name="ProjectSrcFolder">
					</td>
				</tr>
				<tr>
					<td>
						Language
					</td>
					<td>
						<select id="Language" name="Language">
							<option value="en-us" selected>English</option>
							<option value="da">Danish</option>
							<option value="fool">Foolish</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						LauncherStartURL
					</td>
					<td>
						<input type="text" id="LauncherStartURL" name="LauncherStartURL" value="TestPage.aspx">
					</td>
				</tr>
				<tr>
					<td>
						LauncherUnlockProjURL
					</td>
					<td>
						<input type="text" id="LauncherUnlockProjURL" name="LauncherUnlockProjURL">
					</td>
				</tr>
			</table>
			<a onclick="startChain()">Start Chain</a>
			<br>
			<a onclick="startApplication('default.aspx')">
				Just open specified project in ProjectEditor</a>
		</form>
	</body>
</HTML>
