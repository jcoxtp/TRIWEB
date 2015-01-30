<%@ Language=VBScript %>
<!--#INCLUDE FILE="../include/common.asp" -->
<html>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>

<%
	Dim strTopPgSpacing
	Dim AppModTitleFont
	Dim EndAppModTitleFont
	Dim AppModParaFont
	Dim EndAppModParaFont
	Dim HighType1
	Dim HighType2
	Dim TestDate
	Dim UserName
	Dim UserName1
	Dim PDITestSummaryID 
	Dim nC1
	Dim nC2
	Dim nC3
	Dim nC4
	Dim oConn
	Dim oCmd
	Dim oRs
	Dim UserID
	
	strTopPgSpacing = "<br><br><br><br><br><br><br>"
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
	oConn.Open strDBaseConnString
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
		<TD COLSPAN=4><IMG SRC="images/communicating_pdf_cover_01.gif" WIDTH=612 HEIGHT=44 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/communicating_pdf_cover_02.gif" WIDTH=37 HEIGHT=282 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/communicating_pdf_cover_03.jpg" WIDTH=407 HEIGHT=282 ALT=""></TD>
		<TD><IMG SRC="images/communicating_pdf_cover_04.gif" WIDTH=168 HEIGHT=282 ALT=""></TD>
	</TR>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/communicating_pdf_cover_05.gif" WIDTH=612 HEIGHT=125 ALT=""></TD>
	</TR>
	<TR>
		<TD background="images/communicating_pdf_cover_06.gif" WIDTH=612 HEIGHT=261 COLSPAN=4><%=UserName%><br><%=TestDate%></TD>
	</TR>
	<TR>
		<TD COLSPAN=2><IMG SRC="images/communicating_pdf_cover_07.gif" WIDTH=127 HEIGHT=80 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/communicating_pdf_cover_08.gif" WIDTH=485 HEIGHT=80 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/spacer.gif" WIDTH=37 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=90 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=317 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=168 HEIGHT=1 ALT=""></TD>
	</TR>
</TABLE>
<wxprinter PageBreak>
<%=strTopPgSpacing%>

<table WIDTH="700"><tr><td>
<%=AppModParaFont%>
	When you completed the Personal DISCernment® Inventory, you identified the 
	particular pattern that best reflects your behavioral tendencies. <%=UserName1%>, based on the 
	&quot;Composite Graph&quot; of your Personal DISCernment® Inventory, your predominant style is 
	that of a high &quot;<%=HighType1%>&quot;.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<% If NOT IsFakeResults then%>
		<img src="../disccomposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" align="left" hspace="12" v:shapes="_x0000_s1026">
	<% End If %>
	The Personal DISCernment® Inventory measures 
	four factors (D, I, S, and C) that influence behavioral styles. Although everyone has 
	threads of all four factors woven into our basic temperament, most of us find that one or 
	perhaps two of the factors express themselves more strongly than the others in our 
	behavioral style. Each person's temperament is, in part, an expression of the way the 
	four factors combine. For example, a High I who is also a fairly High D will approach 
	things differently than a High I whose D is low.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communicating with Style in the Information Age
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In the midst of the information explosion, communication has     become a critical 
	necessity to doing business as well as an integral part of management strategy. The 
	Information Age, with all its vast resources, has created its own particular challenges 
	and difficulties. Indeed, technology has made transferring and storing information so 
	easy that we are literally drowning in emails, voice mails, web pages, printed materials, 
	and a 24/7 bombardment of multimedia.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The average sound bite has dropped from 45 to 8 seconds, and an average weekday 
	issue of the New York Times contains more information than someone in 17th century 
	England received in a lifetime.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Furthermore, much communication is designed to conceal rather than reveal. Spin 
	doctors, corporate executives, attorneys, and bureaucrats subject us to what author 
	William Lutz calls &quot;double-speak&quot;&#151;a barrage of euphemisms, jargon, and 
	gobbledygook that obscures in the name of communication. Cemeteries become 
	&quot;memorial gardens,&quot; and taxes become &quot;revenue enhancements.&quot;
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In the workplace, glitzy presentations substitute for software and flash for substance. 
	Meetings last too long and accomplish too little, with executives spending as much as 
	four days a week in meetings. In addition, we receive hundreds of emails, voice mails, 
	and phone calls that drain our energy and productivity.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	As we become an increasingly global economy, many clients, customers, and 
	associates struggle with second, third, and even fourth languages while doing business 
	around the corner or across the world. Add to that the cultural differences of nonverbal 
	communication, and we have some severe obstacles to overcome.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Making the Connection: Opportunities and Obstacles
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	At its best, communication presents a number of formidable challenges. Some of the 
	greatest difficulties arise because the sender gets to choose the words, and the receiver 
	gets to choose the meaning.
<%=EndAppModParaFont%>	

<%=AppModParaFont%>	
	In any communication situation, your goal is to accomplish certain objectives: gain 
	agreement on a major project, negotiate the best deal for your company, formulate a 
	corporate mission statement, motivate a disgruntled employee. Often, you have only 
	one shot at getting your message across, and not much time to do it. In addition, you 
	are competing with a variety of issues and media for your audience's attention. 
	Distractions are constant and everywhere.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Quite frankly, your audience may have neither the time nor the inclination to work very 
	hard to receive your message. You have to make it easy for your audience to receive it, 
	and you have to show them why it's in their best interest.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	To communicate effectively, you must establish common ground with your audience so 
	that your goals and your audience's needs and wants come together&#151;not an easy task, 
	especially when you consider the many filters between you and your audience that can 
	further compound the problem.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><%=AppModTitleFont%>Audience Filters<%=EndAppModTitleFont%></td>
	</tr>
	<tr>
		<td><img SRC="images/appmodcomm_audrec.gif" WIDTH="340" HEIGHT="249"></td>
	</tr>
</table>
<%=EndAppModParaFont%>

<br><br>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Personal Style and the Communication Process
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	One of the most powerful filters that inhibits, prohibits, or distorts communication is the 
	issue of personal style: the way that each of us likes to give and receive information. In 
	many cases, we erroneously assume that if we like to communicate in a certain way, 
	then everyone else must also prefer that method. Unfortunately, we are wrong about 75 
	percent of the time, and we are left wondering how we could have miscommunicated so 
	abysmally.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	On the other hand, we have trouble receiving information from certain people because 
	of the way they deliver it: they take too long to get to the point; they get to the point too 
	quickly, without sufficient details; they don't appear to have a sense of humor; they're all 
	business; or they're nosy, always asking personal questions. Why don't they just stick to 
	the topic at hand and be done with it?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	These filters are often the result of the personal styles that you discovered when you 
	completed the Personal DISCernment® Inventory. You found that the more you know 
	about yourself and others, the better you can anticipate behavior 
	in certain situations and relate more effectively to others.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		How this Application Module Can Help
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Communicating with Style will help you understand your personal communication 
	style in light of your DISC profile. You will identify how your style potentially helps or 
	hinders you in delivering messages and achieving your objectives as you:
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	&nbsp;&nbsp;&nbsp;&nbsp;&#149; Speak<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&#149; Write<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&#149; Resolve conflicts/Negotiate<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&#149; Coach and give feedback<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&#149; Listen<br>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	What about the requirements and demands of those who receive your messages? How 
	can you work within the strengths and limitations of your style to adapt to the particular 
	needs of your audience? This application module can help you discover how to 
	communicate effectively in order to meet the challenges of a changing world. 
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Exercise: A Quick Review
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Let's see how much you observed from the Personal DISCernment® Inventory (PDI) 
	and from the people you know who manifest different styles. Write down how you think 
	the characteristics of each style impact their communication.
<%=EndAppModParaFont%>

				
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Style of the High D
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="5">
	<tr>
		<td><font size="2">What I Like	</td>
		<td><font size="2">What Frustrates Me</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<br><br>
				
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Style of the High I
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

				

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="5">
	<tr>
		<td><font size="2">What I Like	</td>
		<td><font size="2">What Frustrates Me</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Style of the High S
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
				

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="5">
	<tr>
		<td><font size="2">What I Like	</td>
		<td><font size="2">What Frustrates Me</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<br><br>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Style of the High C
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

				

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="5">
	<tr>
		<td><font size="2">What I Like	</td>
		<td><font size="2">What Frustrates Me</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
	<tr>
		<td>____________________________________</td>
		<td>____________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Styles: an Overview
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_c.asp" -->
<% end if %>


<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Temperament and the Communication Process
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Although communication encompasses a variety of forms and functions, the following 
	activities represent ways that we communicate on the job and in professional and 
	personal relationships. <%=UserName1%>, take a minute to think about how your high <%=HighType1%> 
	style helps or hinders you in performing each of these basic communication functions. 
	Note specific examples when possible.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td COLSPAN="6" ALIGN="MIDDLE"><%=AppModTitleFont%>My High <%=HighType1%> Style is...<%=EndAppModTitleFont%></td>		
	</tr>
	<tr>
		<td WIDTH="50%"><font size="2"><strong>In Speaking</strong></td>
		<td WIDTH="10%"><font size="2">A Big Help</td>
		<td WIDTH="10%"><font size="2">Somewhat Helpful</td>
		<td WIDTH="10%"><font size="2">Little/No Effect</td>
		<td WIDTH="10%"><font size="2">Somewhat of a Hindrance</td>
		<td WIDTH="10%"><font size="2">A Big Hindrance</td>
	</tr>
	<tr>
		<td><font size="2">Proposing Ideas</td>
		<td><input type="checkbox"></td>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td><input type="checkbox" id="checkbox2" name="checkbox2"></td>
		<td><input type="checkbox" id="checkbox3" name="checkbox3"></td>
		<td><input type="checkbox" id="checkbox4" name="checkbox4"></td>
	</tr>
	<tr>
		<td><font size="2">Describing Capabilities</td>
		<td><input type="checkbox" id="checkbox5" name="checkbox5"></td>
		<td><input type="checkbox" id="checkbox6" name="checkbox6"></td>
		<td><input type="checkbox" id="checkbox7" name="checkbox7"></td>
		<td><input type="checkbox" id="checkbox8" name="checkbox8"></td>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
	</tr>
	<tr>
		<td><font size="2">Persuading/Motivating</td>
		<td><input type="checkbox" id="checkbox10" name="checkbox10"></td>
		<td><input type="checkbox" id="checkbox11" name="checkbox11"></td>
		<td><input type="checkbox" id="checkbox12" name="checkbox12"></td>
		<td><input type="checkbox" id="checkbox13" name="checkbox13"></td>
		<td><input type="checkbox" id="checkbox14" name="checkbox14"></td>
	</tr>
	<tr>
		<td><font size="2">Reading Audience</td>
		<td><input type="checkbox" id="checkbox15" name="checkbox15"></td>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td><input type="checkbox" id="checkbox17" name="checkbox17"></td>
		<td><input type="checkbox" id="checkbox18" name="checkbox18"></td>
		<td><input type="checkbox" id="checkbox19" name="checkbox19"></td>
	</tr>
	<tr>
		<td><font size="2">Preparing for and conducting meetings</td>
		<td><input type="checkbox" id="checkbox20" name="checkbox20"></td>
		<td><input type="checkbox" id="checkbox21" name="checkbox21"></td>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td><input type="checkbox" id="checkbox23" name="checkbox23"></td>
		<td><input type="checkbox" id="checkbox24" name="checkbox24"></td>
	</tr>
	<tr>
		<td><font size="2">Managing Time Constraints</td>
		<td><input type="checkbox" id="checkbox25" name="checkbox25"></td>
		<td><input type="checkbox" id="checkbox26" name="checkbox26"></td>
		<td><input type="checkbox" id="checkbox27" name="checkbox27"></td>
		<td><input type="checkbox" id="checkbox28" name="checkbox28"></td>
		<td><input type="checkbox" id="checkbox29" name="checkbox29"></td>
	</tr>
	<tr>
		<td><font size="2">Handling Objections</td>
		<td><input type="checkbox" id="checkbox30" name="checkbox30"></td>
		<td><input type="checkbox" id="checkbox31" name="checkbox31"></td>
		<td><input type="checkbox" id="checkbox32" name="checkbox32"></td>
		<td><input type="checkbox" id="checkbox33" name="checkbox33"></td>
		<td><input type="checkbox" id="checkbox34" name="checkbox34"></td>
	</tr>
</table>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td COLSPAN="6" ALIGN="MIDDLE"><%=AppModTitleFont%>My High <%=HighType1%> Style is...<%=EndAppModTitleFont%></td>		
	</tr>
	<tr>
		<td WIDTH="50%"><font size="2"><strong>In Resolving Conflict/Negotiating</strong></td>
		<td WIDTH="10%"><font size="2">A Big Help</td>
		<td WIDTH="10%"><font size="2">Somewhat Helpful</td>
		<td WIDTH="10%"><font size="2">Little/No Effect</td>
		<td WIDTH="10%"><font size="2">Somewhat of a Hindrance</td>
		<td WIDTH="10%"><font size="2">A Big Hindrance</td>
	</tr>
	<tr>
		<td><font size="2">Thinking before speaking</td>
		<td><input type="checkbox" id="checkbox35" name="checkbox35"></td>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td><input type="checkbox" id="checkbox2" name="checkbox2"></td>
		<td><input type="checkbox" id="checkbox3" name="checkbox3"></td>
		<td><input type="checkbox" id="checkbox4" name="checkbox4"></td>
	</tr>
	<tr>
		<td><font size="2">Dealing with conflicts promptly</td>
		<td><input type="checkbox" id="checkbox5" name="checkbox5"></td>
		<td><input type="checkbox" id="checkbox6" name="checkbox6"></td>
		<td><input type="checkbox" id="checkbox7" name="checkbox7"></td>
		<td><input type="checkbox" id="checkbox8" name="checkbox8"></td>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
	</tr>
	<tr>
		<td><font size="2">Separating issues from personalities</td>
		<td><input type="checkbox" id="checkbox10" name="checkbox10"></td>
		<td><input type="checkbox" id="checkbox11" name="checkbox11"></td>
		<td><input type="checkbox" id="checkbox12" name="checkbox12"></td>
		<td><input type="checkbox" id="checkbox13" name="checkbox13"></td>
		<td><input type="checkbox" id="checkbox14" name="checkbox14"></td>
	</tr>
	<tr>
		<td><font size="2">Creating alternatives</td>
		<td><input type="checkbox" id="checkbox15" name="checkbox15"></td>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td><input type="checkbox" id="checkbox17" name="checkbox17"></td>
		<td><input type="checkbox" id="checkbox18" name="checkbox18"></td>
		<td><input type="checkbox" id="checkbox19" name="checkbox19"></td>
	</tr>
	<tr>
		<td><font size="2">Creating a cooperative atmosphere</td>
		<td><input type="checkbox" id="checkbox20" name="checkbox20"></td>
		<td><input type="checkbox" id="checkbox21" name="checkbox21"></td>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td><input type="checkbox" id="checkbox23" name="checkbox23"></td>
		<td><input type="checkbox" id="checkbox24" name="checkbox24"></td>
	</tr>
	<tr>
		<td><font size="2">Making everyone feel like a winner</td>
		<td><input type="checkbox" id="checkbox25" name="checkbox25"></td>
		<td><input type="checkbox" id="checkbox26" name="checkbox26"></td>
		<td><input type="checkbox" id="checkbox27" name="checkbox27"></td>
		<td><input type="checkbox" id="checkbox28" name="checkbox28"></td>
		<td><input type="checkbox" id="checkbox29" name="checkbox29"></td>
	</tr>
	<tr>
		<td><font size="2">Being able to forgive and forget</td>
		<td><input type="checkbox" id="checkbox30" name="checkbox30"></td>
		<td><input type="checkbox" id="checkbox31" name="checkbox31"></td>
		<td><input type="checkbox" id="checkbox32" name="checkbox32"></td>
		<td><input type="checkbox" id="checkbox33" name="checkbox33"></td>
		<td><input type="checkbox" id="checkbox34" name="checkbox34"></td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td COLSPAN="6" ALIGN="MIDDLE"><%=AppModTitleFont%>My High <%=HighType1%> Style is...<%=EndAppModTitleFont%></td>		
	</tr>
	<tr>
		<td WIDTH="50%"><font size="2"><strong>In Coaching/Giving Feedback</strong></td>
		<td WIDTH="10%"><font size="2">A Big Help</td>
		<td WIDTH="10%"><font size="2">Somewhat Helpful</td>
		<td WIDTH="10%"><font size="2">Little/No Effect</td>
		<td WIDTH="10%"><font size="2">Somewhat of a Hindrance</td>
		<td WIDTH="10%"><font size="2">A Big Hindrance</td>
	</tr>
	<tr>
		<td><font size="2">Sharing information, explaining things clearly</td>
		<td><input type="checkbox" id="checkbox36" name="checkbox36"></td>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td><input type="checkbox" id="checkbox2" name="checkbox2"></td>
		<td><input type="checkbox" id="checkbox3" name="checkbox3"></td>
		<td><input type="checkbox" id="checkbox4" name="checkbox4"></td>
	</tr>
	<tr>
		<td><font size="2">Being descriptive rather than evaluative</td>
		<td><input type="checkbox" id="checkbox5" name="checkbox5"></td>
		<td><input type="checkbox" id="checkbox6" name="checkbox6"></td>
		<td><input type="checkbox" id="checkbox7" name="checkbox7"></td>
		<td><input type="checkbox" id="checkbox8" name="checkbox8"></td>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
	</tr>
	<tr>
		<td><font size="2">Criticizing without crippling</td>
		<td><input type="checkbox" id="checkbox10" name="checkbox10"></td>
		<td><input type="checkbox" id="checkbox11" name="checkbox11"></td>
		<td><input type="checkbox" id="checkbox12" name="checkbox12"></td>
		<td><input type="checkbox" id="checkbox13" name="checkbox13"></td>
		<td><input type="checkbox" id="checkbox14" name="checkbox14"></td>
	</tr>
	<tr>
		<td><font size="2">Actively confronting the issue</td>
		<td><input type="checkbox" id="checkbox15" name="checkbox15"></td>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td><input type="checkbox" id="checkbox17" name="checkbox17"></td>
		<td><input type="checkbox" id="checkbox18" name="checkbox18"></td>
		<td><input type="checkbox" id="checkbox19" name="checkbox19"></td>
	</tr>
	<tr>
		<td><font size="2">Providing specific examples vs vague generalities</td>
		<td><input type="checkbox" id="checkbox20" name="checkbox20"></td>
		<td><input type="checkbox" id="checkbox21" name="checkbox21"></td>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td><input type="checkbox" id="checkbox23" name="checkbox23"></td>
		<td><input type="checkbox" id="checkbox24" name="checkbox24"></td>
	</tr>
	<tr>
		<td><font size="2">Separating behavior from both motive and personality</td>
		<td><input type="checkbox" id="checkbox25" name="checkbox25"></td>
		<td><input type="checkbox" id="checkbox26" name="checkbox26"></td>
		<td><input type="checkbox" id="checkbox27" name="checkbox27"></td>
		<td><input type="checkbox" id="checkbox28" name="checkbox28"></td>
		<td><input type="checkbox" id="checkbox29" name="checkbox29"></td>
	</tr>
	<tr>
		<td><font size="2">Expressing support without being overly lenient</td>
		<td><input type="checkbox" id="checkbox30" name="checkbox30"></td>
		<td><input type="checkbox" id="checkbox31" name="checkbox31"></td>
		<td><input type="checkbox" id="checkbox32" name="checkbox32"></td>
		<td><input type="checkbox" id="checkbox33" name="checkbox33"></td>
		<td><input type="checkbox" id="checkbox34" name="checkbox34"></td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td COLSPAN="6" ALIGN="MIDDLE"><%=AppModTitleFont%>My High <%=HighType1%> Style is...<%=EndAppModTitleFont%></td>		
	</tr>
	<tr>
		<td WIDTH="50%"><font size="2"><strong>In Writing</strong></td>
		<td WIDTH="10%"><font size="2">A Big Help</td>
		<td WIDTH="10%"><font size="2">Somewhat Helpful</td>
		<td WIDTH="10%"><font size="2">Little/No Effect</td>
		<td WIDTH="10%"><font size="2">Somewhat of a Hindrance</td>
		<td WIDTH="10%"><font size="2">A Big Hindrance</td>
	</tr>
	<tr>
		<td><font size="2">Making objectives clear</td>
		<td><input type="checkbox" id="checkbox37" name="checkbox37"></td>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td><input type="checkbox" id="checkbox2" name="checkbox2"></td>
		<td><input type="checkbox" id="checkbox3" name="checkbox3"></td>
		<td><input type="checkbox" id="checkbox4" name="checkbox4"></td>
	</tr>
	<tr>
		<td><font size="2">Analyzing audience and establishing common ground</td>
		<td><input type="checkbox" id="checkbox5" name="checkbox5"></td>
		<td><input type="checkbox" id="checkbox6" name="checkbox6"></td>
		<td><input type="checkbox" id="checkbox7" name="checkbox7"></td>
		<td><input type="checkbox" id="checkbox8" name="checkbox8"></td>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
	</tr>
	<tr>
		<td><font size="2">Organizing information for readability</td>
		<td><input type="checkbox" id="checkbox10" name="checkbox10"></td>
		<td><input type="checkbox" id="checkbox11" name="checkbox11"></td>
		<td><input type="checkbox" id="checkbox12" name="checkbox12"></td>
		<td><input type="checkbox" id="checkbox13" name="checkbox13"></td>
		<td><input type="checkbox" id="checkbox14" name="checkbox14"></td>
	</tr>
	<tr>
		<td><font size="2">Designing reader-friendly documents</td>
		<td><input type="checkbox" id="checkbox15" name="checkbox15"></td>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td><input type="checkbox" id="checkbox17" name="checkbox17"></td>
		<td><input type="checkbox" id="checkbox18" name="checkbox18"></td>
		<td><input type="checkbox" id="checkbox19" name="checkbox19"></td>
	</tr>
	<tr>
		<td><font size="2">Writing clearly, concisely, and readably to express rather than to impress</td>
		<td><input type="checkbox" id="checkbox20" name="checkbox20"></td>
		<td><input type="checkbox" id="checkbox21" name="checkbox21"></td>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td><input type="checkbox" id="checkbox23" name="checkbox23"></td>
		<td><input type="checkbox" id="checkbox24" name="checkbox24"></td>
	</tr>
	
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td COLSPAN="6" ALIGN="MIDDLE"><%=AppModTitleFont%>My High <%=HighType1%> Style is...<%=EndAppModTitleFont%></td>		
	</tr>
	<tr>
		<td WIDTH="50%"><font size="2"><strong>In Listening</strong></td>
		<td WIDTH="10%"><font size="2">A Big Help</td>
		<td WIDTH="10%"><font size="2">Somewhat Helpful</td>
		<td WIDTH="10%"><font size="2">Little/No Effect</td>
		<td WIDTH="10%"><font size="2">Somewhat of a Hindrance</td>
		<td WIDTH="10%"><font size="2">A Big Hindrance</td>
	</tr>
	<tr>
		<td><font size="2">Genuine interest in what someone has to say; wants to listen</td>
		<td><input type="checkbox" id="checkbox38" name="checkbox38"></td>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td><input type="checkbox" id="checkbox2" name="checkbox2"></td>
		<td><input type="checkbox" id="checkbox3" name="checkbox3"></td>
		<td><input type="checkbox" id="checkbox4" name="checkbox4"></td>
	</tr>
	<tr>
		<td><font size="2">Listening for both facts and feelings</td>
		<td><input type="checkbox" id="checkbox5" name="checkbox5"></td>
		<td><input type="checkbox" id="checkbox6" name="checkbox6"></td>
		<td><input type="checkbox" id="checkbox7" name="checkbox7"></td>
		<td><input type="checkbox" id="checkbox8" name="checkbox8"></td>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
	</tr>
	<tr>
		<td><font size="2">Controlling filters that distort how listening occurs</td>
		<td><input type="checkbox" id="checkbox10" name="checkbox10"></td>
		<td><input type="checkbox" id="checkbox11" name="checkbox11"></td>
		<td><input type="checkbox" id="checkbox12" name="checkbox12"></td>
		<td><input type="checkbox" id="checkbox13" name="checkbox13"></td>
		<td><input type="checkbox" id="checkbox14" name="checkbox14"></td>
	</tr>
	<tr>
		<td><font size="2">Avoiding or eliminating distractions</td>
		<td><input type="checkbox" id="checkbox15" name="checkbox15"></td>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td><input type="checkbox" id="checkbox17" name="checkbox17"></td>
		<td><input type="checkbox" id="checkbox18" name="checkbox18"></td>
		<td><input type="checkbox" id="checkbox19" name="checkbox19"></td>
	</tr>
	<tr>
		<td><font size="2">Providing listening checks and asking questions</td>
		<td><input type="checkbox" id="checkbox20" name="checkbox20"></td>
		<td><input type="checkbox" id="checkbox21" name="checkbox21"></td>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td><input type="checkbox" id="checkbox23" name="checkbox23"></td>
		<td><input type="checkbox" id="checkbox24" name="checkbox24"></td>
	</tr>
	
</table>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
Put a circle around each phrase you've marked as &quot;A Big Help,&quot; and a square 
around all those you've marked as &quot;A Big Hindrance.&quot;
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Rank each activity you've marked in order of its importance to you and your personal 
effectiveness.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="5">
	<tr>
		<td><font size="2"><strong>A Big Help</strong></td>
		<td><font size="2"><strong>A Big Hindrance</strong></td>
	</tr>
	<tr>
		<td><font size="2">1.____________________________________</td>
		<td><font size="2">1.____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">2.____________________________________</td>
		<td><font size="2">2.____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">3.____________________________________</td>
		<td><font size="2">3.____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">4.____________________________________</td>
		<td><font size="2">4.____________________________________</td>
	</tr>
	<tr>
		<td><font size="2">5.____________________________________</td>
		<td><font size="2">5.____________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Among those activities you've ranked as &quot;A Big Hindrance&quot; to your effectiveness, let's 
	examine the top three. <%=UserName1%>, what action steps can you take immediately to help 
	you improve your effectiveness in these activities?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
1. The activity is _______________________________________________________
<br><br>
I can strengthen my effectiveness in this activity by:
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>

<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
2. The activity is _______________________________________________________
<br><br>
I can strengthen my effectiveness in this activity by:
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>

<%=EndAppModParaFont%>

<%=AppModParaFont%>
3. The activity is _______________________________________________________
<br><br>
I can strengthen my effectiveness in this activity by:
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>

<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Exercise: Communication Strengths and Weaknesses
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, aspects of your behavioral style may prove a help or hindrance as you 
	communicate. Below are listed the strengths and weaknesses commonly found in a 
	high <%=HighType1%> temperament. They are organized around the key components of 
	communication. Take a few moments to read through the list, and check those items 
	you believe accurately describe you.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In the strengths column, examine the item(s) that you did not check. Circle those which, 
	if developed, could most improve your personal effectiveness as a communicator.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In the weaknesses column, examine the item(s) that you checked. Circle those which, if 
	strengthened, could most improve your personal effectiveness as a communicator.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In the blank spaces, include any strengths or weaknesses that the description didn't 
	mention but that you feel apply to you.
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_sw_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_sw_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_sw_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_sw_c.asp" -->
<% end if %>

<br><br>

<%
'########################################################################################
' Skip their second type info if they faked the test....
'########################################################################################
 If NOT IsFakeResults then
%>
	<%=AppModParaFont%>
		<%=AppModTitleFont%>
			Evaluating Your Second Highest Factor
		<%=EndAppModTitleFont%>
	<%=EndAppModParaFont%>
	
	<%=AppModParaFont%>
		<%=UserName1%>, the second highest factor in your DISC composite chart is <%=HighType2%>.
	<%=EndAppModParaFont%>
	
	<%=AppModParaFont%>
		<img src="../disccomposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" align="left" hspace="12" v:shapes="_x0000_s1026">
		Read the following strengths and weaknesses description for that style. As you go 
		through this activity, identify the qualities of the <%=HighType1%> style that strengthen or 
		weaken your abilities as a communicator. What combinations of your primary and 
		secondary behavioral styles may help or hinder your communication efforts? For 
		example, a High S whose natural low-key delivery may not project enthusiasm when 
		pitching a new idea may be further hindered (if he or she is secondarily a High C) by a 
		tendency to overwhelm the audience with too many details. On the other hand, the high 
		C factor with its focus on precision would be a great asset to a High S in listening for 
		information.
	<%=EndAppModParaFont%>
<%
 End If 'If NOT IsFakeResults then
'########################################################################################
%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Identifying the Style of Others
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	To successfully adapt our own style to match the temperament of another person, we 
	must first be able to identify the style of that individual. Obviously, we can't always 
	administer the Personal DISCernment® Inventory (PDI), so how can we recognize the 
	temperament of others? One of the strengths of the PDI, as well as other DISC 
	instruments, is that it deals largely with &quot;observable&quot; behavior. A careful, informed 
	observation can help you develop a reasonably accurate &quot;guesstimate&quot; 
	of someone's personal style. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		In identifying the styles of others the following principles will help:
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Understand the limitations of trying to identify others' styles by observation alone. 
	Although certainly influenced by inner, unseen forces, behavior is not clear evidence 
	of values, motives, intelligence, feelings, or attitudes. As you observe a person 
	behaving or &quot;acting&quot; in a certain manner, don't ascribe the underlying emotion or 
	motive. Confine your conclusions to &quot;observable&quot; behavior. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Withhold final judgment until you have had more than one encounter. 
	Often it takes time to develop the confidence that you have accurately assessed an 
	individual. If others don't trust you or don't perceive the environment as safe, they 
	may put up a mask. Create an atmosphere that encourages others to be 
	themselves.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Pay particular attention to nonverbal communication. 
	Words account for less than 10 percent of any communication. Watch the body 
	language, facial expressions, and gestures of the other individual. For example, an 
	action-oriented person may be more animated with gestures, use more vocal 
	inflection and facial expressions.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Use your knowledge to increase your understanding of and response to others' 
	needs. 
	Your ability to recognize styles in others, coupled with an understanding of the 
	needs of various styles, can greatly increase your effectiveness as a communicator.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Let's review the four-element model that we introduced in the PDI.
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Figure 1
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<img SRC="images/fourelementmodel.gif" WIDTH="652" HEIGHT="564">
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	On the following pages, we expand on this model to identify the more visible behavioral 
	tendencies of different styles.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		People vs. Task
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Using this model, we can see in Figure 2 that those to the right of the vertical line are 
	more people-oriented and those to the left are more task-oriented. These groups also 
	have certain &quot;observable&quot; characteristics. People-oriented individuals tend to connect 
	more readily with others, often with warmth and openness. On the other hand, task-
	oriented people are generally cooler, more reserved, and somewhat less expressive. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Figure 2
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<img SRC="images/peoplevtaskvertical.gif" WIDTH="652" HEIGHT="564">
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Action vs. Response
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Now, notice the horizontal line. People above the horizontal line tend to be active or 
	assertive; these individuals generally demonstrate a bold, confident, and directive 
	demeanor to others. Those below the line are more responsive or accommodating; 
	others see them as low key, collaborative, and self-controlled. Detailed descriptions of 
	tendencies in assertive and responsive temperaments are shown in the diagram below:
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Figure 3
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<img SRC="images/appmodcomm_figure3.gif" WIDTH="652" HEIGHT="564">
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		DISC Compatibility Matrix
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

 
<%=AppModParaFont%>
	As you observed in the previous exercise, different personal style combinations present 
	opportunities and potential for compatibility or for conflict. Although not carved in stone, 
	the following matrices present typical relational and task compatibilities of the various 
	styles and rank them on a scale from Excellent to Poor.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	First, let's consider Relational Compatibility. How well do two styles interact in casual or 
	general situations? For example, how do you get along with a coworker who may be in 
	your department but rarely intersects with your job? Or, in your experience with 
	roommates, which ones stand out as delights or disasters? Relational Compatibility 
	involves the aspects and attributes of a relationship, whether casual or intimate.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Relational Compatibility
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table WIDTH="75%" BORDER="1" CELLSPACING="1" CELLPADDING="5">
	<tr>
		<td ALIGN="MIDDLE"><font size="2">&nbsp;</td>
		<td ALIGN="MIDDLE"><font size="2">D</td>
		<td ALIGN="MIDDLE"><font size="2">I</td>
		<td ALIGN="MIDDLE"><font size="2">S</td>
		<td ALIGN="MIDDLE"><font size="2">C</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><font size="2">D</td>
		<td ALIGN="MIDDLE"><font size="2">Good</td>
		<td ALIGN="MIDDLE"><font size="2">Good</td>
		<td ALIGN="MIDDLE"><font size="2">Fair</td>
		<td ALIGN="MIDDLE"><font size="2">Poor</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><font size="2">I</td>
		<td ALIGN="MIDDLE"><font size="2">Good</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
		<td ALIGN="MIDDLE"><font size="2">Fair</td>
		<td ALIGN="MIDDLE"><font size="2">Poor</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><font size="2">S</td>
		<td ALIGN="MIDDLE"><font size="2">Fair</td>
		<td ALIGN="MIDDLE"><font size="2">Fair</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><font size="2">C</td>
		<td ALIGN="MIDDLE"><font size="2">Poor</td>
		<td ALIGN="MIDDLE"><font size="2">Poor</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Next, let's look at Task Compatibility. Some combinations that rank low on Relational 
	Compatibility have excellent Task Compatibility. You may work extremely well on a 
	project with someone that you might not want to take on vacation!
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Task Compatibility
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
<table WIDTH="75%" BORDER="1" CELLSPACING="1" CELLPADDING="5">
	<tr>
		<td ALIGN="MIDDLE"><font size="2">&nbsp;</td>
		<td ALIGN="MIDDLE"><font size="2">D</td>
		<td ALIGN="MIDDLE"><font size="2">I</td>
		<td ALIGN="MIDDLE"><font size="2">S</td>
		<td ALIGN="MIDDLE"><font size="2">C</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><font size="2">D</td>
		<td ALIGN="MIDDLE"><font size="2">Fair</td>
		<td ALIGN="MIDDLE"><font size="2">Fair</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
		<td ALIGN="MIDDLE"><font size="2">Fair</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><font size="2">I</td>
		<td ALIGN="MIDDLE"><font size="2">Fair</td>
		<td ALIGN="MIDDLE"><font size="2">Poor</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
		<td ALIGN="MIDDLE"><font size="2">Good</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><font size="2">S</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
		<td ALIGN="MIDDLE"><font size="2">Good</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><font size="2">C</td>
		<td ALIGN="MIDDLE"><font size="2">Fair</td>
		<td ALIGN="MIDDLE"><font size="2">Good</td>
		<td ALIGN="MIDDLE"><font size="2">Excellent</td>
		<td ALIGN="MIDDLE"><font size="2">Good</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	Notice also that these are tendencies or potential compatibilities. They aren't 
	rules for behavior, and people find many ways to adapt and compensate to offset 
	the potential for conflict.  
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The next few pages will provide you with tools and exercises to help you 
	communicate with people of different temperaments. Now that you know how to 
	identify other styles and have seen how they work together, you can learn a 
	strategy for communicating with people of each style.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		What Different Styles Look for in <em>Communication</em>
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="5" CELLPADDING="1">
	<tr>
		<td VALIGN="TOP"><font size="4"><strong>D...</strong></td>
		<td VALIGN="TOP"><font size="2">
			<table WIDTH="75%" BORDER="0" CELLSPACING="0" CELLPADDING="1">
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Brevity</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Command of the subject</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Logical organization</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Bottom line</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Benefits stated early</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Presentation of options</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Innovation</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Authority</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Businesslike attitude</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Efficient use of time (in presentation, meetings)</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Competence and self-confidence</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Focus on results</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Logic</td>
				</tr>
			</table>
		</td>
		<td VALIGN="TOP"><font size="4"><strong>I...</strong></td>
		<td VALIGN="TOP"><font size="2">
			<table BORDER="0" CELLSPACING="0" CELLPADDING="1">
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Enthusiasm</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Creativity</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">High-energy, friendly tone</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Opportunity for lots of feedback</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Clear presentation of rewards and benefits</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Benefits tied to personal recognition</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Humor</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Relaxed attitude toward time</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Attention-grabbing delivery</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Presents big picture</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">References to others reaction</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Highly Visual Approach</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Lots of personal anecdotes/stories</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Appeals to the High I's need to be in the spotlight</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td VALIGN="TOP"><font size="4"><strong>S...</strong></td>
		<td VALIGN="TOP"><font size="2">
			<table BORDER="0" CELLSPACING="0" CELLPADDING="1">
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Facts and data</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Plenty of time and information to examine and evaluate</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Reassurance</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Clear assessment of risk</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">High quality communication (written and spoken)</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Personal attention</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Clear description of processes</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Appeals to principles</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">The right or best answer</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Appeals to excellence, accuracy, detail, quality</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Logical, detailed presentation of ideas</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Clear procedures, guidelines, specifications</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Precise choice of words</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Exact figures</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Exact job description</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">The right or best answer</td>
				</tr>
			</table>
		</td>
		<td VALIGN="TOP"><font size="4"><strong>C...</strong></td>
		<td VALIGN="TOP"><font size="2">
			<table BORDER="0" CELLSPACING="0" CELLPADDING="1">
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Sincere tone</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Traditional, low-key presentation</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">New ideas tied to old methods</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Logic, facts, and structure</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Highly specialized approach</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Guarantees and assurances</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Organized to show clearly how components and ideas work together</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Affirmation from others</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Assurance of support</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Emphasis on benefits as they relate to the most people</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Absence of controversy</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Personal as well as business relationship</td>
				</tr>
				<tr>
					<td><font size="2">&#149;</td>
					<td><font size="2">Appeals to the High S's need for security and stability</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Strategy With a High D...
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		To communicate better with a High D do &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Provide direct answers and be brief and to the point.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Stress what has to be done, not why it has to be done.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Stress results.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Provide options and possibilities.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Emphasize logic of ideas and approaches.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Agree with the facts, position, or idea&#151;not just the person.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Avoid rambling.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Summarize and close</td>
	</tr>
</table>
<%=EndAppModParaFont%>

 
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		To communicate better with a High D don't &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Appear indecisive.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Be problem-oriented.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Be overly friendly.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Generalize.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Provide too many details.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Repeat yourself or talk too much.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Make unsupportable statements.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Make decisions for them.</td>
	</tr>
</table>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		As  High D's hear and analyze information, they may &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Not consider risks.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Not weigh pros and cons.</td>
	</tr>
	
</table>
<%=EndAppModParaFont%>



<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Strategy With a High I...
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		To communicate better with a High I do &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Stress the new, the special, and the novel.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Demonstrate the ability to be articulate.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Stress testimonies or feedback from &quot;experts.&quot;</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Provide opportunity for give and take.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Be open, friendly, and warm.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Be enthusiastic.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Listen attentively.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Spend time developing the relationship.</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>
 
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		To communicate better with a High I don't &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Ignore the social dimensions.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Do all the talking.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Restrict suggestions or interruptions.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Let him or her take you too far off track.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Be curt, cold, or tight-lipped.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Talk down to them.</td>
	</tr>
	
</table>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		As  High I's hear and analyze information, they may &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Not concentrate.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Ignore important facts.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Interrupt.</td>
	</tr>
	
</table>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Strategy With a High S...
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		To communicate better with a High S do &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Use patience in drawing out his/her goals.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Emphasize how a deliberate approach will work.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Talk service and dependability.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Ask how questions and get feedback.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Listen attentively.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Be sincere.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Communicate in a low-key, relaxed manner.</td>
	</tr>
</table>
<%=EndAppModParaFont%>

 
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		To communicate better with a High S don't &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

	
<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Be too directive.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Push too aggressively or demand.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Move too fast.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Omit too many details.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Be abrupt.</td>
	</tr>
	
</table>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		As  High S's hear and analyze information, they may &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

	

<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Be quietly unyielding.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Not be assertive in communicating their concerns.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Not provide a lot of feedback during presentations.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Hesitate to make a decision, particularly if unpopular.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Slow down the action.</td>
	</tr>
	
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communication Strategy With a High C...
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		To communicate better with a High C do &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Use comparative data.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Appeal to logic, showing facts and benefits.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Concentrate on specifics.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Have all the facts, and stick to them.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Be organized.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Provide written proposals for major decisions.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Appeal to interest in research, statistics, etc.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Provide detailed responses to questions.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Deal fully with objections.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Stress quality, reliability, and security.</td>
	</tr>
</table>
<%=EndAppModParaFont%>
 
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		To communicate better with a High C don't &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox" id="checkbox62" name="checkbox62"></td>
		<td>Be vague or casual, particularly when answering questions.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Move to the bottom line too quickly.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Get personal about family if you don't know him/her well.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Pat them on the back or otherwise be too familiar.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Speak too loudly.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Threaten, cajole, wheedle, or coax.</td>
	</tr>

</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		As  High C's hear and analyze information, they may &#133;
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><input type="checkbox"></td>
		<td>Be too conservative and cautious.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox59" name="checkbox59"></td>
		<td>Bog down in the collection process.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox60" name="checkbox60"></td>
		<td>Become buried in detail.</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox61" name="checkbox61"></td>
		<td>Delay or avoid decisions, particularly if risky.</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		When the Heat is On: Communication Under Stress
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Communication, challenging at best, becomes even more complex in our highly 
	charged workplaces when tempers flare, fatigue sets in, and people resist or resent the 
	message. Indeed, the most challenging communication situations occur in instances 
	that involve conflict or that require delivering and receiving unwelcome information when 
	things aren't going well. A rise in stress levels introduces an interesting dimension to 
	temperament that we call stress behavior. People with similar temperaments tend to 
	behave alike in those situations in which we find ourselves &quot;at the end of 
	our rope,&quot; feeling as though we just can't take it anymore.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	In the PDI Instrument we introduced a model that explained DISC theory. The High D's 
	and I's are active/assertive in nature. They tend to shape their environments to better 
	suit their needs and expectations. The High S's and C's are more responsive/ 
	accommodating in nature. Their standards are not any lower, but they tend to accept 
	their environment the way it is and respond appropriately within that context.
	Because D's and I's tend to see themselves as able to shape the environment, their 
	initial response to conflict and stress is assertive&#151; &quot;We missed that deadline. I won't 
	accept that behavior from anyone!&quot; The S's and C's tend to see themselves as needing 
	to work within the existing environment and therefore are initially more responsive, 
	cautious, and accommodating in conflict and stress. They tend to pull back and may be 
	slower to make decisions or take action.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	Notice we described the above behavior with the qualifier &quot;initial.&quot; An interesting 
	phenomenon occurs under sustained conflict and stress. If the conflict is not quickly 
	resolved and the stress continues unabated, people tend to move into an alternate or 
	reserve style of behavior. For example, the High D may initially become demanding 
	(dictatorial and perhaps even tyrannical), but under sustained conflict will move to 
	detachment. 
<%=AppModParaFont%>

<%=EndAppModParaFont%>
	Under stress, the High I will initially go on the attack. They can really zing you with their 
	verbal skills, often using sarcasm or exaggeration to alleviate their frustration. However, 
	if the stress increases and victory looks uncertain, the need for social approval will win 
	out and the High I will often agree in order to maintain your positive feelings about him 
	or her.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
The High S's normally agreeable disposition will not prepare others for what's boiling 
beneath the surface. If a High S reaches secondary stress levels, he or she may 
demonstrate attacking behavior, sending everyone running for cover.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	High C's will initially deal with stress by detaching, perhaps by withdrawing and working 
	in a solitary setting, but as stress moves to the next level, they will cling more 
	tenaciously to their position and their resolve becomes demanding. Rigidity is the order 
	of the day. It's &quot;by the book&quot; at all costs.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	The table below shows the initial and alternative style under stress for each of the four 
	temperaments.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="5" CELLPADDING="1">
	<tr>
		<td COLSPAN="3" ALIGN="MIDDLE"><font size="2"><strong>Initial Stress Response</strong></td>
		<td COLSPAN="2" ALIGN="MIDDLE"><font size="2"><strong>Alternative Stress Response</strong></td>
	</tr>
	<tr>
		<td><font size="4"><strong>D</strong></td>
		<td><font size="3">Demands</td>
		<td><font size="2">Message: &quot;What do you mean we don't have the budget to complete my project? No way will I accept that.&quot;</td>
		<td><font size="3">Detaches</td>
		<td><font size="2">Message: &quot;I don't have time to bother with this. I have bigger issues to be concerned with.&quot;</td>
	</tr>
	<tr>
		<td><font size="4"><strong>I</strong></td>
		<td><font size="3">Attacks</td>
		<td><font size="2">Message: &quot;I'm not about to go to the board with this absurd proposal. We'll get killed if we present it this way.&quot;</td>
		<td><font size="3">Agrees</td>
		<td><font size="2">Message: &quot;Okay, we'll try it your way. But don't forget that I warned you.&quot;</td>
	</tr>
	<tr>
		<td><font size="4"><strong>S</strong></td>
		<td><font size="3">Agrees</td>
		<td><font size="2">Message: &quot;I know you've been swamped, or you wouldn't have missed that critical deadline.&quot;</td>
		<td><font size="3">Attacks</td>
		<td><font size="2">Message: &quot;You've taken advantage of my good nature for the last time!&quot;</td>
	</tr>
	<tr>
		<td><font size="4"><strong>C</strong></td>
		<td><font size="3">Detaches</td>
		<td><font size="2">Message: &quot;I just don't have time to consider your request. I have too much on my plate as it is.&quot;</td>
		<td><font size="3">Demands</td>
		<td><font size="2">Message: &quot;If I bend the rules for you, I'll have to bend them for everyone, and that's not going to happen. We'll stick to procedure.&quot;</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Conflict is not the only cause of stress. Getting ready for the big interview or 
	presentation, conducting an unfavorable performance review, rolling out a new ad 
	campaign or logo, or even getting that big promotion can produce stress.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Below is a list of more sources of stress for your temperament. Check the items you 
	have found create stress for you and add additional items if relevant.
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_es_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_es_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_es_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleCommunicating_style_es_c.asp" -->
<% end if %>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Reacting to Stress
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In most cases, the four temperaments react to stress in the following ways. Take the 
	following steps to identify stress behaviors in yourself and others:
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	1.	Read through the list for your temperament and check the items you believe 
	describe your behavior under stress. Add additional behaviors you believe are 
	descriptive if not included in the list.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	2.	Think of someone you know well who has a different behavioral style. How would 
	you describe his/her behavior under stress? Again, check the behaviors on the 
	list for his/her temperament below. List additional behaviors if relevant.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High D Under Stress
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><input type="checkbox"></td>
		<td><font size="2">Can become very controlling</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox48" name="checkbox48"></td>
		<td><font size="2">Tries even harder to impose will on others</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox49" name="checkbox49"></td>
		<td><font size="2">Asserts self with body or language, may invade &quot;personal space&quot; or point fingers</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox50" name="checkbox50"></td>
		<td><font size="2">May demonstrate stony silence or get very vocal, raising volume and energy level</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox51" name="checkbox51"></td>
		<td><font size="2">Becomes even less willing to compromise</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox52" name="checkbox52"></td>
		<td><font size="2">Pulls rank on those with less power</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox53" name="checkbox53"></td>
		<td><font size="2">If stress produces conflict, gets over it quickly</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox54" name="checkbox54"></td>
		<td><font size="2">______________________________________________________________________</td>
		
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High I Under Stress
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><input type="checkbox" id="checkbox55" name="checkbox55"></td>
		<td><font size="2">Focuses frustrations on other people</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox48" name="checkbox48"></td>
		<td><font size="2">Blames others	</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox49" name="checkbox49"></td>
		<td><font size="2">Can become emotional even to the point of shouting, making extreme statements, or gesturing belligerently</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox50" name="checkbox50"></td>
		<td><font size="2">Makes wounding, sarcastic remarks</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox51" name="checkbox51"></td>
		<td><font size="2">Attempts to control others through words and emotion</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox52" name="checkbox52"></td>
		<td><font size="2">If stress produces conflict, gets over it quickly and will go out of their way to make things right</td>
		
	</tr>

	<tr>
		<td><input type="checkbox" id="checkbox54" name="checkbox54"></td>
		<td><font size="2">______________________________________________________________________</td>
		
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High S Under Stress
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><input type="checkbox" id="checkbox56" name="checkbox56"></td>
		<td><font size="2">Voice, facial expressions, and gestures become mechanical and perfunctory</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox48" name="checkbox48"></td>
		<td><font size="2">May lack commitment even though voicing agreement</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox49" name="checkbox49"></td>
		<td><font size="2">Can be passive aggressive, i.e., uninvolvement, silence, or lack of expression</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox50" name="checkbox50"></td>
		<td><font size="2">Often complies rather than cooperates, producing minimal results</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox51" name="checkbox51"></td>
		<td><font size="2">If stress produces conflict, is sometimes slow to forgive and forget</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox54" name="checkbox54"></td>
		<td><font size="2">______________________________________________________________________</td>
		
	</tr>
</table>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High C Under Stress
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
	 	

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><input type="checkbox" id="checkbox56" name="checkbox56"></td>
		<td><font size="2">Becomes even less responsive</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox48" name="checkbox48"></td>
		<td><font size="2">Limits vocal intonation, facial expression, and gestures (which are normally limited) even further</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox49" name="checkbox49"></td>
		<td><font size="2">Withdraws emotionally</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox50" name="checkbox50"></td>
		<td><font size="2">May avoid contact with others if conflicts arise</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox51" name="checkbox51"></td>
		<td><font size="2">May become hyper-sensitive to work-related criticisms</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox52" name="checkbox52"></td>
		<td><font size="2">May adopt a victimized attitude</td>
		
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox54" name="checkbox54"></td>
		<td><font size="2">______________________________________________________________________</td>
		
	</tr>
</table>
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communicating When You're Under Stress: How to Handle It
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	When you're under stress, you can take certain steps to relieve the stress you feel and 
	its effects on others.
<%=EndAppModParaFont%>

<%=AppModParaFont%>	
	Improve your attitude and perceptions by creating support systems, alleviating stress 
	through humor, balancing work and play, talking it out, or seeking counseling if 
	necessary.
<%=EndAppModParaFont%>	
<%=AppModParaFont%>	
	If appropriate, learn a new skill, discuss your situation openly with peers, or just slow 
	down a bit.
<%=EndAppModParaFont%>	
<%=AppModParaFont%>	
	Improve your physical ability to cope by making sure that you get proper nutrition, 
	adequate rest, and regular exercise. 
<%=EndAppModParaFont%>	
<%=AppModParaFont%>	
	Create a less stressful environment by structuring time off from work, ceasing to 
	attend certain meetings, taking a class you enjoy, or possibly changing jobs or 
	vocation.
<%=EndAppModParaFont%>	

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communicating When Others are Under Stress: How to Handle It
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
<%=AppModParaFont%>	 	
	Acknowledge that someone is demonstrating stress behavior. People aren't always 
	going to be at their best; we all have rough days. The faster you determine that 
	someone's behavior is stress-related, the more effectively you can deal with the 
	situation.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	Recognize the environment (either internal or external) that is causing the stress. If 
	you are causing or contributing to that stress, evaluate what you can change and 
	what you can't. Many times we know if someone is on deadline or under the gun to 
	make a quota. It's harder to pinpoint when stress is coming from someone's 
	personal life, since we may not know a lot about that person away from the office. 
	Take responsibility to look for clues that may give you an idea of the cause, and give 
	people the benefit of the doubt, at least initially.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	Try to keep from reacting in kind. Many times, someone's behavior can be so 
	unpleasant that we begin to demonstrate our own stress behavior. Keep your focus 
	on the stress that is causing this behavior, and find ways to alleviate it, if possible. 
	For example, if the person seems unable to deal with one more problem, delay 
	telling her about the unhappy customer who called to complain. 
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	If possible, avoid doing important business with someone who is exhibiting stress 
	behavior. Wait until the person's stress level is lower and you can work under more 
	normal circumstances.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Exercise
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Think of the last time you were in a stressful situation at work. How did your behavior 
differ from your normal work-related behavior? 
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>



<%=AppModParaFont%>
How do the behaviors of some of your colleagues differ? What was most noticeable 
to you? 
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>



<%=AppModParaFont%>
What was the effect on relationships and productivity?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>



<%=AppModParaFont%>
When the stress subsided, what changes took place in the workplace?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
What can you do to improve the situation the next time stress occurs?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Action Planning: When Communicating with a High D
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, now that you're more aware of what other styles need from you (and what you 
	need from other styles), try your hand at some dialogue with coworkers of different 
	styles to apply your knowledge to real world situations.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
When we communicate, what are the three main things you need from me?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Given my personal style, what do you think I need from you in communication? 
(Then you can affirm or modify the answers.)
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
What aspect of our communication styles could create conflict, particularly in 
stressful situations?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
What major change do I need to make to adapt my style when communicating with 
you?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Action Planning: When Communicating with a High I
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, now that you're more aware of what other styles need from you (and what you 
	need from other styles), try your hand at some dialogue with coworkers of different 
	styles to apply your knowledge to real world situations.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
When we communicate, what are the three main things you need from me?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Given my personal style, what do you think I need from you in communication? 
(Then you can affirm or modify the answers.)
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
What aspect of our communication styles could create conflict, particularly in 
stressful situations?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
What major change do I need to make to adapt my style when communicating with 
you?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Action Planning: When Communicating with a High S
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, now that you're more aware of what other styles need from you (and what you 
	need from other styles), try your hand at some dialogue with coworkers of different 
	styles to apply your knowledge to real world situations.
<%=EndAppModParaFont%>
<%=AppModParaFont%> 
When we communicate, what are the three main things you need from me?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
Given my personal style, what do you think I need from you in communication? 
(Then you can affirm or modify the answers.)
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
What aspect of our communication styles could create conflict, particularly in 
stressful situations?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
What major change do I need to make to adapt my style when communicating with 
you?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Action Planning: When Communicating with a High C
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, now that you're more aware of what other styles need from you (and what you 
	need from other styles), try your hand at some dialogue with coworkers of different 
	styles to apply your knowledge to real world situations.
<%=EndAppModParaFont%>
 
<%=AppModParaFont%> 
When we communicate, what are the three main things you need from me?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%> 
Given my personal style, what do you think I need from you in communication? 
(Then you can affirm or modify the answers.)


<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%> 
<%=AppModParaFont%> 
What aspect of our communication styles could create conflict, particularly in 
stressful situations?
<br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%> 
<%=AppModParaFont%> 
What major change do I need to make to adapt my style when communicating with 
you?
<br><br>

<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
	<tr>
		<td>____________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%> 

 <wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	The <strong>DISC Profile System®</strong> is a family of instruments and workbooks designed specifically to increase 
	understanding of yourself and others to achieve greater personal and interpersonal effectiveness.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	The <strong>Personal DISCernment® Inventory</strong>, the basic module, provides a unique insight into your 
	temperament, producing both a general and a detailed description of your behavioral style. This 
	instrument also allows you to develop a comprehensive list of your strengths and weaknesses.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	A second core module, the <strong>Position Discernment® Inventory</strong>, examines personalities and how they lend 
	themselves to positions within an organization. The <strong>Position Discernment® Inventory</strong> is not intended to 
	perform screening for a selection process, but rather to allow you to explore in detail why specific 
	positions attract certain individuals and why some people perform best in particular situations. This 
	instrument provides valuable information that can increase individual effectiveness in the work setting as 
	well as enhance the general overall performance of the organization.
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	The <strong>DISC Profile® System</strong> includes a series of application modules that will guide you in applying these 
	insights to specific situations. The module workbooks provide additional information each behavioral style 
	as it relates to that arena and suggest how you may apply this information to yourself and your 
	teammates.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Five application modules are available:
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>



	
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Teamwork with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
	Each temperament brings unique strengths and weaknesses to the team setting. Your behavioral 
	style influences the way you plan and organize your work, communicate and make decisions. 
	This workbook will provide the opportunity for you to identify, explore, and discuss the effects of 
	the individual behavioral styles on your team. The result will be enhanced understanding of how 
	to build on individual differences for greater team effectiveness.
<%=EndAppModParaFont%>

	
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Leading with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Our behavioral traits are not only a major influence on our leadership style, but also provide the 
	template through which we view the leadership of others. When we are led by those with different 
	behavioral styles from our own, we have a tendency to feel overled. Understanding these 
	differences will not only help you to better serve those you lead, but also help you to better 
	respond to the leadership of others.
<%=EndAppModParaFont%>

	
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Communicating with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	This module will help you recognize how your personal communication style enhances or 
	impedes the messages that you send to others. In addition, you will learn to identify the styles of 
	those receiving your message, and discover ways to adapt your style to meet their needs. As a 
	result, you will greatly improve the effectiveness of your written and spoken communication in a 
	variety of situations.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

	
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Selling with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Behavioral style not only influences how we persuade or convince others, but how we ourselves 
	are persuaded. This module, designed for the sales environment, provides insights into the 
	strengths and weaknesses of each behavioral style as we attempt to communicate with and 
	convince others. You will also discover how different temperaments receive and respond to such 
	overtures. These insights can greatly increase your effectiveness in communicating a point of 
	view, as well as understanding and meeting the needs of others.
<%=EndAppModParaFont%>

	
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Time Management with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Our personalities often determine our attitudes toward time: how we respond to time constraints, 
	how we discipline ourselves, how much energy we have to get things done, and how we view 
	deadlines. This workbook outlines each behavioral style's response to the various aspects of time 
	and personal management.
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	For more information call Team Resources at 1.800.214.3917 or visit our website: www.teamresources.com
<%=EndAppModParaFont%>

</td></tr></table>

</body>
</html>