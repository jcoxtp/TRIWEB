<%@ Page language="c#" Codebehind="BackupFrameSet.aspx.cs" AutoEventWireup="false" Inherits="Brad.BackupFrameSet" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<TITLE>
			<%=SetDocumentTitle()%>
		</TITLE>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<frameset rows="160,*" frameborder="0" framespacing="0" bordercolor="#99ff00">
		<frame name="top" src="Progress.htm" width="100%" marginwidth="0" bordercolor="#ff66cc">
		<frame name="bottom" src="<%=GetBottomPage()%>">
	</frameset>
</HTML>
