<%@ Page language="c#" Codebehind="DeleteProjectFrameSet.aspx.cs" Inherits="Brad.Delete.DeleteProjectFrameSet" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<TITLE>
			<%=SetDocumentTitle()%>
		</TITLE>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<frameset rows="160,*" frameborder="0" framespacing="0">
		<frame name="top" src="../Progress.htm">
		<frame name="bottom" src="<%=GetBottomPage()%>">		
	</frameset>
</HTML>
