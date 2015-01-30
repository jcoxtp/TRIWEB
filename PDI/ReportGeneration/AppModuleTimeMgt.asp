<%@ Language=VBScript %>
<% intPageID = 68 %>
<!--#Include virtual="/pdi/Include/common.asp" -->
<html>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link rel="stylesheet" href="AppModStyle.css" type="text/css">
</head>
<body>
<%
	Dim strTopPgSpacing
	strTopPgSpacing = "<br><br><br><br><br><br><br>"

	Dim HighType1
	Dim HighType2
	Dim AppModTitleFont
	Dim EndAppModTitleFont
	Dim AppModParaFont
	Dim EndAppModParaFont
	Dim UserName
	Dim UserName1
	Dim UserID 
	Dim PDITestSummaryID 
	Dim nC1, nC2, nC3, nC4
	Dim oConn, oCmd, oRs
	
	HighType1 = UCase(Request.QueryString("HT1"))
	HighType2 = UCase(Request.QueryString("HT2"))
	AppModTitleFont = "<strong><font size=4>"
	EndAppModTitleFont = "</strong></font>"
	AppModParaFont = "<blockquote><font size=3>"
	EndAppModParaFont = "</font></blockquote>"
	PDITestSummaryID = Request.QueryString("PDITSID")
	UserID = Request.QueryString("UID")
	
	Set oConn = CreateObject("ADODB.Connection")
	Set oCmd = CreateObject("ADODB.Command")
	Set oRs = CreateObject("ADODB.Recordset")
	
	With oCmd
		  .CommandText = "sel_PDITestSummary_Ex"
		  .CommandType = 4
		  .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
		  .Parameters.Append .CreateParameter("@UserID",3, 1,4, UserID)
		  .Parameters.Append .CreateParameter("@PDITestSummaryID",3, 1,4, PDITestSummaryID)
	End With
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	If oConn.Errors.Count > 0 then
		Response.Write "Unable to retrieve PDI Profile information from database. Please try again."
		Response.End
	end if 

	if oRs.EOF = FALSE then
		nC1 = oRs("C_NumberD")
		nC2 = oRs("C_NumberI")
		nC3 = oRs("C_NumberS")
		nC4 = oRs("C_NumberC")	
		UserName1 = oRs("FirstName")
		UserName = oRs("FirstName") & " " & oRs("LastName")
		Dim TestDate
		TestDate = oRs("FileCreationDate")
		'==================================================================================================
		'MG: 2/9/2004 - Added to handle fake test scenarios
		Dim IsFakeResults : IsFakeResults = False
		If (nC1=0) and (nC2=0) and (nC3=0) and (nC4=0) then
			If (oRs("M_NumberD")=0) and (oRs("M_NumberI")=0) and (oRs("M_NumberS")=0) and (oRs("M_NumberC")=0) then
				If (oRs("L_NumberD")=0) and (oRs("L_NumberI")=0) and (oRs("L_NumberS")=0) and (oRs("L_NumberC")=0) then 
					If (isNull(oRs("CPD"))) and (isNull(oRs("CPI"))) and (isNull(oRs("CPS"))) and (isNull(oRs("CPC"))) then 
						IsFakeResults = True
					End If
				End If
			End If
		End If
		'==================================================================================================
	else
		Response.Write "Unable to retrieve PDI Profile information from database. Please try again."
		Response.End
	end if 
%>
<TABLE WIDTH=612 BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR>
		<TD COLSPAN=4><IMG SRC="images/timeManagement_pdf_cover_01.gif" WIDTH=612 HEIGHT=44 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/timeManagement_pdf_cover_02.gif" WIDTH=36 HEIGHT=282 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/timeManagement_pdf_cover_03.jpg" WIDTH=407 HEIGHT=282 ALT=""></TD>
		<TD><IMG SRC="images/timeManagement_pdf_cover_04.gif" WIDTH=169 HEIGHT=282 ALT=""></TD>
	</TR>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/timeManagement_pdf_cover_05.gif" WIDTH=612 HEIGHT=124 ALT=""></TD>
	</TR>
	<TR>
		<TD background="images/timeManagement_pdf_cover_06.gif" WIDTH=612 HEIGHT=263 COLSPAN=4>
			<%=UserName%><br><%=TestDate%></TD>
	</TR>
	<TR>
		<TD COLSPAN=2><IMG SRC="images/timeManagement_pdf_cover_07.gif" WIDTH=124 HEIGHT=79 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/timeManagement_pdf_cover_08.gif" WIDTH=488 HEIGHT=79 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/spacer.gif" WIDTH=36 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=88 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=319 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=169 HEIGHT=1 ALT=""></TD>
	</TR>
</TABLE>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<%=strTopPgSpacing%>
<table WIDTH="700"><tr><td>
<br><br>
<p>
When you completed the Personal DISCernment® Inventory, you identified the 
particular pattern that best reflects your behavioral tendencies.
</p>

<p>
<%=UserName1%>, based on the Composite Graph of your Personal DISCernment® Inventory, 
your predominant style is that of a High <%=HighType1%>.
</p>


<p>
<TABLE WIDTH=100% BORDER=0 CELLSPACING=1 CELLPADDING=1>
	<TR>
		<% If NOT IsFakeResults then%>
			<TD><img src="../disccompositesmall.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" align="left" hspace="12" v:shapes="_x0000_s1026"></TD>
		<% End If %>
		<TD>
			The Personal DISCernment® Inventory measures four factors (D, I, S, and C) that 
			influence behavioral styles. Although everyone has threads of all four factors woven into 
			our basic temperament, most of us find that one or perhaps two of the factors express 
			themselves more strongly than the others in our behavioral style. Each person's 
			temperament is, in part, an expression of the way the four factors combine. For 
			example, a High I who is also a fairly High D will approach things differently than a High 
			I whose D is low.
			<br><br>
			However, in order to maximize understanding and application in this module, we focus 
			primarily on the "pure" types, considering only the tendencies we can expect from our 
			most predominant factor. Although these are brief summaries, describing only a few of 
			the elements that influence behavior in a given arena, even this level of understanding 
			can greatly improve the way you relate to others.		
		</TD>
	</TR>
</TABLE>
</p>

<p>
	<%=AppModTitleFont%>
		Personality and Time
	<%=EndAppModTitleFont%>
</p>

<p>
	<%=AppModTitleFont%>
		Time is a Paradox
	<%=EndAppModTitleFont%>
</p>

<p>
	Everyone wants more time, yet we already have all the time there is. The problem, then, 
	is not a shortage of time, but how we choose to use the time available.
</p>

<p>
	The concept of time management is an illusion, because no one can really manage 
	time. Time is a constant—a measurement of intervals. It moves at the same rate 
	regardless of who we are or what we are trying to accomplish. No one can convert, 
	change, or otherwise modify time. Despite this, we continue to use the phrase 
	"managing time" to identify our efforts to use our allotted moments meaningfully. When 
	we talk about time management, we mean conducting our affairs within the time 
	available so that we achieve gratifying results.
</p>

<p>
	<%=AppModTitleFont%>
		Time Is a Resource
	<%=EndAppModTitleFont%>
</p>

<p>
	Think of time as an important resource that lies ready for use, or something that can be 
	drawn upon for aid. However, unlike other resources, you can't buy it, sell it, rent it, steal 
	it, borrow it, lend it, store it, multiply it, manufacture it, or change it. All you can do is 
	spend it.
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>

<p>
	As a resource, time poses another paradox: if you don't use it, it disappears anyway. 
	Thus the quality of this resource depends on how well you use it.
</p>

<p>
	<%=AppModTitleFont%>
		Time Is All Yours
	<%=EndAppModTitleFont%>
</p>

<p>
	Since you cannot increase the quantity of time you receive, the quality of time is the 
	only variable. Your time belongs to no one else. No one else can spend it for you. Other 
	people may make demands on how you spend your time, but you must do the actual 
	spending.
</p>


<p>
	Many people maintain that others control their time, but this is not necessarily true. No 
	one has any more control over your time than you are willing to allow. No one can force 
	you to spend your time effectively or prevent you from wasting it. In fact, much of the 
	control we attribute to others is really lack of self-control. We become intimidated by the 
	demands of others and thus allow ourselves to be controlled.
</p>

<p>
	Managing time means adapting ourselves to its passage in some appropriate, satisfying 
	manner. It means managing ourselves. To bring ourselves under control, we must learn 
	new, more appropriate behaviors. We have to change if we wish to improve.
</p>

<p>
	<%=AppModTitleFont%>
		Personality and Time
	<%=EndAppModTitleFont%>
</p>

<p>
	Our personalities help determine our attitudes toward time: how we respond to time 
	constraints, how well we discipline ourselves, how much energy we have to get things 
	done, and how we view deadlines. For some of us time is an ally, for others an enemy. 
	For certain personality types, time just doesn't seem to matter, and for others, attitudes 
	toward time seem to be governed by the individual situation.
</p>

<p>
	Knowing how you and other people deal with time-sensitive issues such as planning, 
	goal setting, scheduling, and organizing can be of immeasurable value as you attempt 
	to work with, serve, influence, and communicate with others.
</p>

<p>
	Behavior is influenced by a number of complex factors that Include our basic personality 
	or temperament, our current emotional and physical state, our skills, experiences, and 
	IQ, and our motivational needs. These and many other factors directly and indirectly 
	shape people's responses and behaviors.
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>

<p>
	<%=AppModTitleFont%>
		Time Management Style
	<%=EndAppModTitleFont%>
</p>

<p>
	<%=UserName1%>, as a High <%=HighType1%>, you have a unique way of managing time. In the 
	broadest of terms, we may describe that style as follows:
</p>


<% if UCase(HighType1) = "D" then %>
	<!--#Include FILE="AppModuleTimeMgt_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#Include FILE="AppModuleTimeMgt_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#Include FILE="AppModuleTimeMgt_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#Include FILE="AppModuleTimeMgt_c.asp" -->
<% end if %>

<p>
<%=AppModTitleFont%>
Other styles manage time differently . . .
<%=EndAppModTitleFont%>
</p>



<% if UCase(HighType1) <> "D" then %>
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>
	<!--#Include FILE="AppModuleTimeMgt_d.asp" -->
<% end if
	if UCase(HighType1) <> "I" then %>
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>
	<!--#Include FILE="AppModuleTimeMgt_i.asp" -->
<% end if
	if UCase(HighType1) <> "S" then %>
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>
	<!--#Include FILE="AppModuleTimeMgt_s.asp" -->
<% end if 
	if UCase(HighType1) <> "C" then %>
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>
	<!--#Include FILE="AppModuleTimeMgt_c.asp" -->
<% end if %>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>

<p>
	<%=AppModTitleFont%>
		Time and Temperament: The High <%=HighType1%>
		Evaluation and Application
	<%=EndAppModTitleFont%>
</p>

<ol>
	<li>Carefully read the descriptions in each of the three categories: Purpose, Planning, 
	and Priorities; Personal Management; and Time & Team.<br><br></li>
	<li>Check <img height="16" width="16" src="images/checkbox-icon.gif" /> any descriptions in these categories that you believe accurately describe 
	you.<br><br></li>
	<li>Are there additional descriptors/tendencies in these categories we did not include 
	that you might want to add?<br><br></li>
	<li>Considering the items you've checked, which one area, if strengthened, could make 
	the greatest contribution to increased personal effectiveness? Circle that item.<br><br></li>
	<li>For the item you've just circled, describe how you would like to be described in this 
	area.<br><br></li>
	<li>Identify the specific steps you might take to change the current situation to the 
	desired description above.</li>
</ol>


<% if UCase(HighType1) = "D" then %>
	<!--#Include FILE="AppModuleTimeMgt_pp_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#Include FILE="AppModuleTimeMgt_pp_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#Include FILE="AppModuleTimeMgt_pp_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#Include FILE="AppModuleTimeMgt_pp_c.asp" -->
<% end if %>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>

<p>
	<%=AppModTitleFont%>
		Timemaster Tips
	<%=EndAppModTitleFont%>
</p>

<p>
	<%=UserName1%>, these tips may be helpful to you as a High <%=HighType1%>:
</p>


<% if UCase(HighType1) = "D" then %>
	<!--#Include FILE="AppModuleTimeMgt_tips_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#Include FILE="AppModuleTimeMgt_tips_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#Include FILE="AppModuleTimeMgt_tips_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#Include FILE="AppModuleTimeMgt_tips_c.asp" -->
<% end if %>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>

<p>
	<%=AppModTitleFont%>
		Tips for Becoming a Top Timemaster
	<%=EndAppModTitleFont%>
</p>


<table border="0" cellpadding="3">
 <tr valign="top">
	<td width="45%">
		<ol>
			<li>Clarify your goals to add direction, motivation, and meaning to your life<br><br></li>
			<li>Make sure the first hour of your day is productive. The rest will usually follow 
				suit.<br><br></li>
			<li>Analyze everything you do in terms of your goals. Find out what you do, when you 
				do it, and why you do it. Ask yourself what would happen if you didn't do it. If 
				the answer is "nothing," then stop doing it.<br><br></li>
			<li>As you go through the day, continually ask: Is what I'm doing helping me achieve 
				my goals?<br><br></li>
			<li>Avoid activity traps. Focus on doing what is really important. Learn to resist 
				the merely urgent.<br><br></li>
			<li>Record a time log to help analyze how you use your time and identify your bad 
				habits.<br><br></li>
			<li>Write out a plan for each week. Ask yourself what you hope to achieve by the end 
				of the week, and what activities will be required to get those results.<br><br></li>
			<li>Make a plan for every day. Be sure to Include priorities and time estimates for 
				each activity. Remember, you don't run out of work; you run out of time.<br><br></li>
			<li>Schedule the most important activities. Be sure to allow flexibility for 
				unexpected problems and interruptions. But remember that those things which you 
				have scheduled have a better chance of working out right.<br><br></li>
			<li>Eliminate at least one timewaster every week.<br><br></li>
			
		</ol>
	</td>
	<td width="10%"></td>
	<td width="45%">
		<ol start="11">
			<li>Be gracious with people, but firm with time. Learn to respond appropriately, and 
				say "no" when you should.<br><br></li>
			<li>Take time to do it right the first time. You won't waste time doing it over.<br><br></li>
			<li>Schedule quiet time for yourself to organize your thoughts.<br><br></li>
			<li>Eliminate recurring crises from your job. Find out why the same things keep 
				going awry.<br><br></li>
			<li>Analyze your paperwork to see what you can eliminate, modify, shorten, and 
				streamline.<br><br></li>
			<li>Keep the clutter under control.<br><br></li>
			<li>Take time to be a good listener. It saves lots of time and prevents problems.<br><br></li>
			<li>Show people you respect their time. Be on time, be prepared, deliver results on 
				time, and don't interrupt so much.<br><br></li>
			<li>Ask people you work with these two questions: (a) What do I do that wastes your 
				time and hinders your performance? (b) What could I do to help you be more 
				effective?<br><br></li>
			<li>Conquer procrastination. Learn to do it now.<br><br></li>
			<li>Develop the habit of doing first things first. Train yourself to follow your 
				plans as closely as possible.<br><br></li>
			<li>Balance your time across all aspects of your life: spiritual, family, career, 
				social, health, self-development, and personal.<br><br></li>
		</ol>
	</td>
 </tr>
</table>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>

<p>
	<%=AppModTitleFont%>
		Personal Action Plan
	<%=EndAppModTitleFont%>
</p>

<p>
	"If it is meant to be, it is up to me."
</p>

<ul>
	<li>Earlier you identified some things you could do to improve your time and personal 
	management. Describe three of those items in the space below. For each, choose a 
	start date when you will initiate your action plan for that item.</li>
</ul>

<%
	Dim strLine
	strLine = "___________________________________"
%>

<p>
<TABLE WIDTH=100% BORDER=0 CELLSPACING=1 CELLPADDING=1>
	<TR>
		<TD>&nbsp;</TD>
		<TD ALIGN=MIDDLE><font size=3><STRONG>This is What I Intend To Do</STRONG></TD>
		<TD ALIGN=MIDDLE><font size=3><STRONG>Start Date</STRONG></TD>
	</TR>
	<TR>
		<TD><font size=3>1.</TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD><font size=3>2.</TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD><font size=3>3.</TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
	<TR>
		<TD></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
		<TD ALIGN=MIDDLE><%=strLine%></TD>
	</TR>
</TABLE>
</p>

<ul>
	<li>To increase your motivation, share your commitment with someone who is 
		significant to you. For instance, you might give your boss or a co-worker a copy of 
		your action plan and promise to meet with him or her periodically to discuss your 
		progress. If you do, you are far more likely to actually follow through on your 
		intentions.
		<br>
		<br></li>
	<li>I will give_______________________________________a copy of my action plan and ask <br>
		him or her to meet with me regularly to evaluate my progress.</li>
</ul>
<br><br><br>

<p align="right">
_______________________________________<br>
(Signed)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV><%=strTopPgSpacing%>

<p>
	The <STRONG>DISC Profile System®</STRONG> is a family of instruments and workbooks designed specifically to increase 
	understanding of yourself and others to achieve greater personal and interpersonal effectiveness.
</p>
<p>
	The <STRONG>Personal DISCernment® Inventory</STRONG>, the basic module, provides a unique insight into your 
	temperament, producing both a general and a detailed description of your behavioral style. This 
	instrument also allows you to develop a comprehensive list of your strengths and weaknesses.
</p>


<p>
	<%=AppModTitleFont%>
		Five application modules are available:
	<%=EndAppModTitleFont%>
</p>

<p>
	The <STRONG>DISC Profile® System</STRONG> Includes a series of application modules that will guide you in applying these 
	insights to specific situations. The module workbooks provide additional information each behavioral style 
	as it relates to that arena and suggest how you may apply this information to yourself and your 
	teammates.
</p>

<p>
	<%=AppModTitleFont%>
		Teamwork with Style
	<%=EndAppModTitleFont%>
</p>
<p>
	Each temperament brings unique strengths and weaknesses to the team setting. Your behavioral 
	style influences the way you plan and organize your work, communicate and make decisions. 
	This workbook will provide the opportunity for you to identify, explore, and discuss the effects of 
	the individual behavioral styles on your team. The result will be enhanced understanding of how 
	to build on individual differences for greater team effectiveness.
</p>

<p>
	<%=AppModTitleFont%>
		Leading with Style
	<%=EndAppModTitleFont%>
</p>
<p>
	Our behavioral traits are not only a major influence on our leadership style, but also provide the 
	template through which we view the leadership of others. When we are led by those with different 
	behavioral styles from our own, we have a tendency to feel overled. Understanding these 
	differences will not only help you to better serve those you lead, but also help you to better 
	respond to the leadership of others.
</p>

	
<p>
	<%=AppModTitleFont%>
		Communicating with Style
	<%=EndAppModTitleFont%>
</p>
<p>
	This module will help you recognize how your personal communication style enhances or 
	impedes the messages that you send to others. In addition, you will learn to identify the styles of 
	those receiving your message, and discover ways to adapt your style to meet their needs. As a 
	result, you will greatly improve the effectiveness of your written and spoken communication in a 
	variety of situations.
</p>

<p>
<%=AppModTitleFont%>
Selling with Style
<%=EndAppModTitleFont%>
</p>


<p>
	Behavioral style not only influences how we persuade or convince others, but how we ourselves 
	are persuaded. This module, designed for the sales environment, provides insights into the 
	strengths and weaknesses of each behavioral style as we attempt to communicate with and 
	convince others. You will also discover how different temperaments receive and respond to such 
	overtures. These insights can greatly increase your effectiveness in communicating a point of 
	view, as well as understanding and meeting the needs of others.
</p>

	
<p>
	<%=AppModTitleFont%>
		Time Management with Style
	<%=EndAppModTitleFont%>
</p>
<p>
	Our personalities often determine our attitudes toward time: how we respond to time constraints, 
	how we discipline ourselves, how much energy we have to get things done, and how we view 
	deadlines. This workbook outlines each behavioral style's response to the various aspects of time 
	and personal management.
</p>


<p>
	For more information call Triaxia Partners, Inc. at 1.800.214.3917 or visit our website: www.triaxiapartners.com
</p>

</td></tr></table>

</body>
</html>