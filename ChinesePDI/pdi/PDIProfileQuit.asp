<%@ Language=VBScript CodePage=65001 %>
<!--#INCLUDE FILE="include/checklogin.asp" -->
<!--#INCLUDE FILE="include/common.asp" -->
<%
pageID = "quit"
Dim TestCodeID
TestCodeID = Request.QueryString("TCID")
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8" />
	<title>DISC Profile System | Print Your PDI Profile</title>
	<link rel="stylesheet" href="_system.css" type="text/css">
	<!--#INCLUDE FILE="include/head_stuff.asp" -->
</head>
<body>
<!--#INCLUDE FILE="include/top_banner.asp" -->
<!--#INCLUDE FILE="include/left_navbar.asp" -->
<div id="tabgraphic">
	<img src="images/s2p1.gif" width="692" height="82" alt="" usemap="#tab" />
	<map name="tab">
		<area shape="poly" alt="" coords="633,53,672,53,680,59,673,65,632,66,617,59,634,53,637,53" HREF="PDIProfileSANDW2.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>">
	</map>
</div>
<div id="maincontent_tab">
	<%
	Dim nP, nE
	nP = Request.QueryString("PRNT")
	nE = Request.QueryString("EXIT")
	Dim bChoseRepProfile, bQuestionsCompleted
	Dim oConn
	Dim oCmd
	Dim oRs
	Dim intLanguageID
	intLanguageID = 6 'Simplified Chinese
	
	' We want to bypass checking to see that the user selected a pattern, not using it in the first Chinese version
	' bChoseRepProfile = FALSE
	bChoseRepProfile = TRUE
	bQuestionsCompleted = FALSE
	
	' first see if the user has completed the questions and has chosen at least 
	' 1 profile - if they have not then warn the user the PDI cannot be produced 
	' and allow them to quit anyway - but don't produce the PDF report for them
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	With oCmd
		  .CommandText = "spTestSummarySelect"
		  .CommandType = 4
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@TestCodeID", 3, 1, 4, TestCodeID)
	End With
	oConn.Open strDBaseConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1

	If oConn.Errors.Count > 0 Then
		'Response.Write "Unable to update database. Please try again."
		Response.Write "无法更新数据库。请尝试再。"
		Response.End
	End If

	If oRs.EOF = FALSE Then
		oRs.MoveFirst
		If CInt(oRs("QuestionsCompleted")) = 1 Then
			bQuestionsCompleted = TRUE
		End If
		If oRs("ProfileName1") <> "" Then ' [SM] Deleted reference to Profile 2
			bChoseRepProfile = TRUE
		End If
	Else
		'Response.Write "<font size=2>Cannot find test information in database. Please try again.</font>"
		Response.Write "<font size=2>不能找到测试信息在数据库。请尝试再。</font>"
		Response.End
	End If

	Set oConn = Nothing
	Set oCmd = Nothing
	Set oRs = Nothing

	If bQuestionsCompleted = FALSE Then
		If nP = "1" Then
			'Response.Write "<p>You have not completed the questions portion of the PDI Profile. You must complete the questions to print the PDI PDF report.</p>"
			Response.Write "<p>您未完成PDI 外形的问题部份。您必须完成问题打印PDI PDF 报告。</p>"
			Response.End
		Else
			'Response.Write "<p>You have not completed the questions portion of the PDI Profile. If you quit now you will be able to return and complete the questions.</p>"
			Response.Write "<p>您未完成PDI 外形的问题部份。如果您现在放弃您能退回和完成问题。</p>"
			'Response.Write "<p><a href='main.asp?st=" & Site & "'>Click here to exit the PDI Profile</a>.</p>"
			Response.Write "<p><a href='main.asp?st=" & Site & "'>点击这里退出PDI 外形</a>.</p>"
		End If
	Else
		If bChoseRepProfile = FALSE Then
			'Response.Write "<p>You have not chosen a representative profile. As a result your PDI PDF Profile will not be created.</p>"
			Response.Write "<p>您未选择代表性外形。结果您的PDI PDF 外形不会被创造。</p>"
			'Response.Write "<p>Are you sure you want to exit now? If yes, then you can return to choose a representative profile later.</p>"
			Response.Write "<p>是否确实要现在退出吗? 如果是, 您能然后回来以后选择代表性外形。</p>"
			'Response.Write "<p><a href='main.asp?st=" & Site & "'>Click here to exit now</a>.</p>"
			Response.Write "<p><a href='main.asp?st=" & Site & "'>点击这里退出PDI 外形</a>.</p>"
		Else %>
			祝贺你！ 你完成了个性鉴别清单</span>DISC<sup>&reg;</sup> <span lang=ZH-CN>的测试。</span></h2>
			<p style="margin-bottom:0px">
			<table border="0" cellspacing="0" cellpadding="6" width="100%">
				<tr>
					<td valign="top" align="center" width="32"><a href="javascript:confirmPDIPDFCreation()"><img src="images/PrintChinese.gif" width="32" height="38"></a></td>
					<td valign="top">
						<h2><span lang=ZH-CN>查看并打印你的完整的测试报告 （</span>PDF<span lang=ZH-CN>模式</span>)</h2>
	<p><span lang=ZH-CN>点击左侧“打印”图标，用</span>Adobe<span lang=ZH-CN>的</span>PDF<span
  lang=ZH-CN>模式创建你个人的</span>DISC<sup>&reg;</sup> <span lang=ZH-CN>报告。查看报告也允许你把它打印出来并存档。关闭</span>PDF<span
  lang=ZH-CN>报告视窗，返回此屏幕。你完成了个性鉴别清单</span>DISC<sup>&reg;</sup> <span lang=ZH-CN>的测试。你现在可以退出，或者在下面创立一个个性化的使用报告。</span></p>
						<div align="right">
						<p style="margin-bottom:0px">
						<table border="0" cellspacing="0" cellpadding="2" width="100%">
							<tr>
								<td valign="top" align="right" width="25%">
									<a href="http://www.adobe.com/products/acrobat/readstep2.html" target="_blank"><img src="images/get_acrobat_reader.gif"></a>
								</td>
								<td>&nbsp;&nbsp;</td>
								<td valign="top" align="left" width="75%">
									<strong><span lang=ZH-CN mso-bidi-font-family:SimSun'>注意：</span></strong><span lang=ZH-CN> 你必须安装</span>Adobe Acrobat Reader <span lang=ZH-CN>才能查看你的报告。请从</span>Adobe<span lang=ZH-CN>的网站免费下载该软件。</span>
								</td>
							</tr>
						</table>
						</p>
						</div>
					</td>
				</tr>
			</table>
			</p>
			<!--#INCLUDE FILE="include/divider.asp" -->
			<p style="margin-bottom:0px">

		<%
		End If
	End If
	%>
	<script type="text/javascript">
	// alerts user to delay while generating the PDF and application reports
	function confirmAppPDFCreation(TCID)
	{
		if (window.confirm("It will take about a minute to generate your application report."))
		{
			var goToNextURL;
		
			goToNextURL = "AppModuleCreatePDF.asp?TCID=" + TCID + "&res=<%=intResellerID%>";
		
			document.location = goToNextURL;
		}
	}
	
	function confirmPDIPDFCreation()
	{
		if (window.confirm("稍等一分钟你就可以获得你的个性鉴别清单报告。"))
		{	
			var goToNextURL;
			
			goToNextURL = "activePDF.asp?TCID=" + <%=TestCodeID%> + "&res=<%=intResellerID%>";
			
			openAnyWindow(goToNextURL,'Download',"height=240,width=450,menubar=1,resizable=1,scrollbars=1,status=1,titlebar=1,toolbar=1,z-lock=0");
		}
	}
	</script>
</div>
</body>
</html>
