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
	Dim HighType1
	Dim HighType2
	Dim AppModParaFont
	Dim EndAppModParaFont
	Dim UserName
	Dim UserName1
	Dim PDITestSummaryID 
	Dim nC1
	Dim nC2
	Dim nC3
	Dim nC4
	Dim UserID 
	Dim oConn
	Dim oCmd
	Dim oRs
	
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
		<TD COLSPAN=4><IMG SRC="images/leading_pdf_cover_01.gif" WIDTH=612 HEIGHT=45 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/leading_pdf_cover_02.gif" WIDTH=36 HEIGHT=280 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/leading_pdf_cover_03.jpg" WIDTH=408 HEIGHT=280 ALT=""></TD>
		<TD><IMG SRC="images/leading_pdf_cover_04.gif" WIDTH=168 HEIGHT=280 ALT=""></TD>
	</TR>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/leading_pdf_cover_05.gif" WIDTH=612 HEIGHT=127 ALT=""></TD>
	</TR>
	<TR>
		<TD background="images/leading_pdf_cover_06.gif" WIDTH=612 HEIGHT=265 COLSPAN=4><%=UserName%><br><%=TestDate%></TD>
	</TR>
	<TR>
		<TD COLSPAN=2><IMG SRC="images/leading_pdf_cover_07.gif" WIDTH=123 HEIGHT=75 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/leading_pdf_cover_08.gif" WIDTH=489 HEIGHT=75 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/spacer.gif" WIDTH=36 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=87 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=321 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=168 HEIGHT=1 ALT=""></TD>
	</TR>
</TABLE>
<wxprinter PageBreak>
<%=strTopPgSpacing%>

<table WIDTH="700"><tr><td>
<br><br>
<%=AppModParaFont%>
	When you completed the Personal DISCernment® Inventory, you identified the 
	particular pattern that best reflects your behavioral tendencies.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, based on the &quot;Composite Graph&quot; of your Personal DISCernment® Inventory, 
	your predominant style is that of a high &quot;<%=HighType1%>&quot;.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<% If NOT IsFakeResults then%>
		<img src="../disccomposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" align="left" hspace="12" v:shapes="_x0000_s1026">
	<% End If %>
	The Personal DISCernment® Inventory measures four factors (D, I, S, and C) that 
	influence behavioral styles. Although everyone has threads of all four factors woven into 
	our basic temperament, most of us find that one or perhaps two of the factors express 
	themselves more strongly than the others in our behavioral style. Each person's 
	temperament is, in part, an expression of the way the four factors combine. For 
	example, a High I who is also a fairly High D will approach things differently than a High 
	I whose D is low.
	<br><br>
	However, in order to maximize understanding and application in this module, we focus 
	primarily on the &quot;pure&quot; types, considering only the tendencies we can expect from our 
	most predominant factor. Although these are brief summaries, describing only a few of 
	the elements that influence behavior in a given arena, even this level of understanding 
	can greatly improve the way you relate to others.
<%=EndAppModParaFont%>
<br><br>
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Leadership in a Real Time World
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	The organizational landscape is changing dramatically. Increased competition, mergers 
	and acquisitions, shrinking or emerging markets, increasingly demanding customers, 
	information overload&#151;all are placing incredible demands on companies and their 
	people. Get to the marketplace first! Do more with less! Develop diversity in your 
	workforce! Increase shareholder value!
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In today's world of rapid, discontinuous change, virtually every organization is feeling 
	the effects of a significant leadership shortage. As we take our first few faltering steps 
	into a new century, many have come to view the lack of organizational leadership as the 
	single biggest constraint to corporate aspirations.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Manager or Leader?
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Much is made of the difference between a manager and leader. In many cases the 
	terms are defined in such a manner as to disparage the manager, implying that if you 
	are only a manager and not a leader, then shame on you. Leadership and management 
	are different in nature, objectives, and processes, but both are critically important to any 
	organization. The issue is not whether you are a manager or a leader but rather, do you 
	know when to manage, when to lead, and when to do both? Most certainly, strong 
	leaders perform many management tasks regularly, without which an organization will 
	not achieve its objectives.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	John Kotter correctly observes in A Force for Change, &quot;Management and leadership 
	differ in certain key areas.&quot; 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Managers keep things operating to produce agreed-upon and current results. 
	They depend upon systems, processes, policies, and structure.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Leaders bring about significant change needed to produce different results. 
	That's the major differentiator: the ability to effect significant change and bring 
	others along. Leaders cause us to willingly follow them out of our comfort 
	zone, and to accomplish this feat they must call upon such tools as vision, 
	direction, inspiration, relationships, and changed organizational cultures.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	We frequently note that leadership is an art and management is a practice. The art of 
	leadership is often a more subjective, intuitive exercise; it's better observed than 
	described. Management is a more structured and defined discipline. Whereas 
	management can be &quot;taught,&quot; leadership must be &quot;caught.&quot;
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Leadership is all about relationships: a leader is a person who influences people 
	to accomplish a purpose. Indeed, today's leaders must be able to move people beyond 
	compliance to commitment. One cannot demand commitment; it must 
	be volunteered. That's what leaders do: create volunteers. Although people will achieve 
	acceptable results because that's what they are paid to do, exceptional results are 
	always volunteered.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Some leadership pundits would try to convince us that people are either leaders or 
	managers. However, we believe that complex managerial jobs require a blend of the 
	two disciplines on a task-by-task, situation-by-situation, moment-by-moment basis. 
	Theoretically, one person could master both leadership and management. In reality, the 
	nature (personality, skills, preferences, interests, experience, etc.) of individuals will 
	make them more inclined to one or the other. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In order to achieve this formidable goal, you must understand the strengths, 
	weaknesses, and needs of those you lead (as well as yourself).
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	What motivates them<br>
	&#149;	How do you need to communicate with them<br>
	&#149;	What creates tension or triggers resistance<br>
	&#149;	What particular strengths and gifts do they offer<br>
	&#149;	How do you bring out the best in each person<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	When you completed the Personal DISCernment® Inventory (PDI), you discovered that 
	the more you know about yourself and others the better you can anticipate behavior 
	and, therefore, better relate to other people. The PDI also helped you understand how 
	and why people are likely to behave in one way or another.
<%=EndAppModParaFont%>



<%=AppModParaFont%>
	In this application module, you will discover how your style helps or hinders you in 
	performing the necessary functions of leadership: envisioning, enrolling, empowering, 
	and energizing. You will also identify ways to adapt your style to meet the particular 
	needs of those whom you lead.
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	No one personal leadership style has a lock on success. As you proceed through this 
	application module, you will gain insights about yourself and others and discover the 
	untapped potential within you and those you lead.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The Role of Leadership
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>



<%=AppModParaFont%>
	To really understand how your temperament affects the way you lead, you must first 
	understand what leaders do. The art of leadership is too complex and encompassing to 
	grasp as a whole. We must break it down into an organizing framework that allows us to 
	better grasp how our styles help or hinder the exercise of different elements 
	of the larger leadership role. We suggest that a leader's role can be organized under 
	four broad headings defined below:
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<strong>Envisioning</strong>&#151;In this role the leader looks ahead with the end in mind. Vision is a 
	picture of a positive, possible future, a picture of purpose 
	fulfilled. Vision speaks to the heart of inspiration.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<strong>Enrolling</strong>&#151;In this role the leader creates a shared vision  that can be embraced 
	and shared by everyone. When leaders are successful in this role, every member 
	of the organization &quot;buys into the vision&quot; and feels a sense of ownership in where 
	&quot;we are going.&quot;
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<strong>Empowering</strong>&#151;In this role the leader helps others see and understand the big 
	picture and creates an environment in which people feel empowered and want to 
	do their best. He or she makes each person feel his/her work 
	is important.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<strong>Energizing</strong>&#151;The leader is always looking for opportunities to praise, encourage, 
	and celebrate the success of others. He or she is able to inspire commitment, 
	leadership, initiative, and extra effort from others.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In this application module, you will learn how your unique behavioral style or 
	temperament affects the way you exercise specific leadership roles. You will discover 
	that, overall, your behavioral style is a big influence on how you lead. In fact, you are 
	always <em>leading with style</em> . . . 
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Leadership Styles
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%> your predominant style is a high <%=HighType1%>. In the very broadest of terms, 
	we might describe the high <%=HighType1%> leader as follows:
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleLeading_desc_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleLeading_desc_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleLeading_desc_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleLeading_desc_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		What a Leader Does: Leading with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table WIDTH="80%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>
				
		<%=AppModTitleFont%>
		Envisioning: 
		<%=EndAppModTitleFont%>
		<br><br>
		
		Looks ahead with the end in mind; has a view of the future; anticipates future  trends 
		and implications; demonstrates foresight; thinks through and clearly facilitates the 
		setting of organizational direction; reinforces organizational mission, vision, and values 
		in an inspirational manner.
		</td>
		<td><img SRC="images/Evisioning.gif" WIDTH="228" HEIGHT="171"></td>
	</tr>
</table>
<%=EndAppModParaFont%>





<%=AppModParaFont%>

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><img SRC="images/Enrolling.gif" WIDTH="300" HEIGHT="221"></td>
		<td>
		
		<%=AppModTitleFont%>
		Enrolling:
		<%=EndAppModTitleFont%>
		
		<br><br>
		Recruits others into a vision of where the organization is going that everyone can 
		embrace and share; builds a shared vision that inspires others to high levels of 
		motivation and commitment; sets expectations and builds commitment to important 
		goals among diverse groups, organizations, and individuals; leads and influences others 
		through ideas, insight, determination, and focus on the vision.
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>
		<%=AppModTitleFont%>
		Empowering:
		<%=EndAppModTitleFont%>
		<br><br>
		Leverages the skills and expertise of others; believes that those closest to the work 
		understand the work best; seeks out and values the input and ideas of others; quick to 
		give others visibility and recognition; creates an environment in which people feel they 
		can take the initiative and affect results; makes them want to do their best; makes each 
		person feel that his or her work is important; removes the organizational obstacles that 
		prevent people from contributing. 
		</td>
		<td><img SRC="images/Empowering.gif" WIDTH="240" HEIGHT="180"></td>
	</tr>
</table>


<%=EndAppModParaFont%>

<%=AppModParaFont%>

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><img SRC="images/Energizing.gif" WIDTH="300" HEIGHT="225"></td>
		<td>
		<%=AppModTitleFont%>
		Energizing:
		<%=EndAppModTitleFont%>
		<br><br>
		Always looking for opportunities to praise and encourage others; wants to find others 
		doing something right; quick to celebrate successes; learns from failure and affirms the 
		unique contribution of others; balances the organization with focus on results and the 
		capacity to achieve future results; pursues everything with initiative, energy, and 
		commitment; fosters a &quot;can do&quot; attitude. 
		
		</td>
	</tr>
</table>

 
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Leading with Style 
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Numerous surveys reveal that people who choose to follow particular leaders demand 
	characteristics such as honesty, a forward-looking perspective, competence, 
	intelligence, the ability to inspire, courage, dependability, and maturity.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In addition, leaders must be able to perform specific and important functions that allow 
	them to take people where they have not been before. Consider these critical functions 
	and how different temperaments approach them. In the boxes below, describe how 
	each style might perform each leadership function or role. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table BORDER="1" CELLSPACING="1" CELLPADDING="60">
	<tr>
		<td WIDTH="20%">&nbsp;</td>
		<td ALIGN="MIDDLE"><font size="4"><strong>D</strong></td>
		<td ALIGN="MIDDLE"><font size="4"><strong>I</strong></td>
		<td ALIGN="MIDDLE"><font size="4"><strong>S</strong></td>
		<td ALIGN="MIDDLE"><font size="4"><strong>C</strong></td>
	</tr>
	<tr>
		<td><font size="4"><strong>Envisioning</strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><font size="4"><strong>Enrolling</strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><font size="4"><strong>Empowering</strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><font size="4"><strong>Energizing</strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Strengths and Weaknesses
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, as a high <%=HighType1%>, aspects of your work or social style may be a help or a 
	hindrance as you attempt to influence others. Below are listed the strengths and 
	weaknesses commonly found in a high <%=HighType1%> temperament, organized around the 
	key roles of leadership. Personalize this list by checking items that you feel accurately 
	describe you and adding other items that may come to mind.
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleLeading_sw_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleLeading_sw_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleLeading_sw_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleLeading_sw_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Leadership Situations: Perplexing or Productive
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>



<%=AppModParaFont%>
	Each of us has a distinctive personal style that is based on our unique personality, and 
	we tend to deal with others based on the style that is comfortable for us. As leaders, we 
	normally tend to lead others as we like to be led.
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	However, other people's styles may differ drastically from our own. What motivates us 
	may be a complete turnoff to someone else. We must learn to recognize and appreciate 
	their temperaments so that we can adapt our approach to suit their behavioral style. 
	Doing so will create the synergy that delivers outstanding results within an organization. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	To clarify this concept, answer the following questions:
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Think of a person you lead who frustrates you or makes you uncomfortable and less 
	effective as a leader. What characteristics does this person have that may cause 
	conflict or make it difficult for you to achieve excellent results when you work together 
	(e.g. has trouble making decisions, demonstrates a lack of focus, bogs down in details, 
	moves too fast, etc.)? Describe these characteristics.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
Now describe someone with whom you work especially well. What characteristics make 
you feel comfortable and more effective?
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
In a situation where you have found your personal style to be different or even 
incompatible with someone else, what adjustments have you made? What adjustments 
has the other person made?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
	Notice also that these are <em>tendencies</em> or <em>potential</em> compatibilities. They aren't 
	rules for behavior, and people find many ways to adapt and compensate to offset 
	the potential for conflict.  
<%=EndAppModParaFont%>



<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Identifying the Style of Others
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	To adapt one's leadership style to better match the temperament of another 
	person, we must first be able to identify the style of that individual. Obviously, we 
	can't always administer the <em>Personal DISCernment® Inventory</em> (PDI), so how can 
	we recognize the temperament of others&#149; One of the strengths of the PDI, as 
	well as other DISC instruments, is that it deals largely with &quot;observable&quot; behavior. 
	A careful, informed observation can help you develop a reasonably accurate 
	&quot;guesstimate&quot; of someone's personal style.
 <%=EndAppModParaFont%>



<%=AppModParaFont%>
	<%=AppModTitleFont%>
		In identifying the styles of others the following principles will help:
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>




<%=AppModParaFont%>
&#149;	<em>Understand the limitations of trying to identify others' styles by observation 
alone.</em> Although certainly influenced by inner, unseen forces, behavior is not clear 
evidence of values, motives, intelligence, feelings, or attitudes. As you 
observe a person behaving or &quot;acting&quot; in a certain manner, don't ascribe the 
underlying emotion or motive. Confine your conclusions to &quot;observable&quot; 
behavior. 

<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<em>Withhold final judgment until you have had more than one encounter.</em> 
	Often it takes time to develop the confidence that you have accurately 
	assessed an individual. If others don't trust you or don't perceive the 
	environment as safe, they may put up a mask. Create an atmosphere that 
	encourages others to be themselves.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<em>Pay particular attention to nonverbal communication. </em>
	Words account for less than 10 percent of any communication. Watch the 
	body language, facial expressions, and gestures of the other individual. For 
	example, an action-oriented person may be more animated with gestures, 
	use more vocal inflection and facial expressions.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<em>Use your knowledge to increase your understanding of and response to 
	others' needs.</em> Your ability to recognize styles in others, coupled with an understanding of 
	the needs of various styles, can greatly increase your effectiveness as a 
	leader.
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
	tendencies of different styles
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
	<img SRC="images/appmodleading_figure3.gif" WIDTH="652" HEIGHT="564">
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Different Styles Different Needs
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>



<%=AppModParaFont%>
	Leadership is all about helping people venture into areas they probably would not 
	explore on their own. When true leadership is present, those who follow that leader do 
	more than comply with the leader's vision, strategy, or tactics. They choose to make a 
	commitment to the effort, whatever it may be. Commitment is a choice that comes from 
	a person's willingness to get on board and participate fully. No one can command 
	commitment from another person.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Since commitment is a choice, the people we lead must feel alignment and ownership 
	of our goals. They must be willing to invest in the outcome. To elicit that kind of 
	response in someone, a leader must meet those who follow &quot;where they live,&quot; in order 
	to strike a responsive chord deep within them. To connect at that level, leaders must 
	often modify their own styles to accommodate the style of the other person.
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Here are a few guidelines for leading others of each style.
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>

<table WIDTH="75%" BORDER="1" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><font size="4"><strong>A &quot;D&quot;...</strong></td>
		<td><font size="4"><strong>An &quot;I&quot;...</strong></td>
	</tr>
	<tr>
		<td><font size="2">
			&#149;	Freedom<br>
			&#149;	Authority<br>
			&#149;	Power<br>
			&#149;	Material rewards<br>
			&#149;	Opportunity to grow<br>
			&#149;	Diversification<br>
			&#149;	Innovation<br>
			&#149;	Challenge<br>
			&#149;	Opportunity for achievement<br>
			&#149;	Additional responsibility<br>
			&#149;	Businesslike attitude in others<br>
			&#149;	Efficient use of time<br>
			&#149;	Competence and self-confidence in others<br>
			&#149;	Possibilities associated with risks<br>
			&#149;	Progress<br>
			&#149;	Quick results<br>
		</td>
		<td><font size="2">
			&#149;	Popularity<br>
			&#149;	Prestige (title)<br>
			&#149;	Group activities<br>
			&#149;	Friendly relationships<br>
			&#149;	Favorable working conditions<br>
			&#149;	Recognition<br>
			&#149;	Opportunities to be in the spotlight<br>
			&#149;	Incentives for taking on tasks<br>
			&#149;	Humor<br>
			&#149;	Tolerance of casual attitude about time<br>
			&#149;	Quick results<br>
			&#149;	Knowledge of how others think and feel<br>
			&#149;	Support from others<br>
			&#149;	Positive feedback <br>
			&#149;	Approval<br>
			&#149;	Change, variety<br>
		</td>
	</tr>
	<tr>
		<td><font size="4"><strong>A &quot;C&quot;...</strong></td>
		<td><font size="4"><strong>An &quot;S&quot;...</strong></td>
	</tr>
	<tr>
		<td><font size="2">
			&#149;	Facts and data<br>
			&#149;	Safe environment<br>
			&#149;	Team participation<br>
			&#149;	Limited exposure to risk<br>
			&#149;	No sudden changes<br>
			&#149;	Personal attention<br>
			&#149;	Security and protection<br>
			&#149;	Reassurance<br>
			&#149;	Appeals to principles<br>
			&#149;	High standards<br>
			&#149;	Opportunity to help<br>
			&#149;	Appeals to excellence, accuracy, details, quality<br>
			&#149;	Time to consider key points thoughtfully<br>
			&#149;	Established procedures, guidelines, specifications<br>
			&#149;	Exact job description<br>
			&#149;	The right or best answer<br>
		</td>
		<td><font size="2">
			&#149;	Appreciation<br>
			&#149;	Sincerity<br>
			&#149;	Traditional procedures<br>
			&#149;	Limited/no travel<br>
			&#149;	Specialization<br>
			&#149;	New ideas tied to old methods<br>
			&#149;	Logic, facts and structure<br>
			&#149;	Minimum risk<br>
			&#149;	Assurance of support<br>
			&#149;	Secure, personal, agreeable environment<br>
			&#149;	Personal as well as business relationship <br>
			&#149;	Slow, deliberate process<br>
			&#149;	Guarantees and assurances<br>
			&#149;	Affirmation from others<br>
			&#149;	No/slow rate of change <br>
			&#149;	Reliability<br>
			&#149;	Quality<br>
		</td>		
	</tr>
</table>
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Leading Others with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>



<%=AppModParaFont%>
	<%=UserName1%>, as a leader, it's important to learn how your style interacts with other styles 
	and how to adapt to those styles when leading. Strategies are listed below for adapting 
	to all four follower styles. Review the list and indicate which are easy or difficult for you 
	as you lead others.
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleLeading_strat_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleLeading_strat_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleLeading_strat_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleLeading_strat_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		When the Heat is On: Leading Under Stress
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Leadership, challenging at best, becomes even more complex in our highly charged 
	workplaces when tempers flare, fatigue sets in, and people resist or resent the task or 
	the leader. Indeed, the most challenging leadership situations occur when things aren't 
	going well. A rise in stress levels introduces an interesting dimension to temperament 
	that we call stress behavior. People with similar temperaments tend to behave alike in 
	those situations where we find ourselves &quot;at the end of our rope,&quot; feeling as though we 
	just can't take it anymore.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In the PDI Instrument we introduced a model that explained DISC theory. The High D's 
	and I's are active/assertive in nature. They tend to shape their environments to better 
	suit their needs and expectations. The High S's and C's are more responsive/ 
	accommodating in nature. Their standards are not any lower, but they tend to accept 
	their environment the way it is and respond appropriately within that context.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Because D's and I's tend to see themselves as able to shape the environment, their 
	initial response to conflict and stress is assertive&#151; &quot;We missed that deadline. I won't 
	accept that behavior from anyone!&quot; The S's and C's tend to see themselves as needing 
	to work within the existing environment and therefore are initially more responsive, 
	cautious, and accommodating in conflict and stress. They tend to pull back and may 
	become slower to make decisions or take action.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Notice we described the above behavior with the qualifier &quot;initial.&quot; An interesting 
	phenomenon occurs under sustained conflict and stress. If the conflict is not quickly 
	resolved and the stress continues unabated, people tend to move into an alternate or 
	reserve style of behavior. For example, the High D may initially become demanding 
	(dictatorial and perhaps even tyrannical), but under sustained conflict will move to 
	detachment. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
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
	<%=AppModTitleFont%>
		The table below shows the initial and alternative style under stress for each of the four 
		temperaments.
	<%=EndAppModTitleFont%>
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
	Conflict is not the only cause of stress. Getting ready for the big presentation, rolling out 
	a new ad campaign or logo, or even getting that big increase in the budget can produce 
	stress.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Below is a list of more sources of stress for your temperament. Check the items you 
	have found create stress for you, and add additional items if relevant.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	As a High <%=HighType1%> you may encounter stress when...
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleLeading_es_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleLeading_es_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleLeading_es_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleLeading_es_c.asp" -->
<% end if %>

<%=AppModParaFont%> 	
	Now think of those you lead. What situations create stress for them? How do their 
	stressors differ from yours?
<%=EndAppModParaFont%>

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

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	2.	Think of someone on your team who has a different behavioral style. How would 
	you describe his/her behavior under stress? Again, check the behaviors on the 
	list for his/her temperament below. List additional behaviors if relevant.
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		The High D Under Stress
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
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
		Leading When You're Under Stress: How to Handle It
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	When you're under stress, you can take certain steps to relieve the stress you feel and 
	its effects on others.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Improve your attitude and perceptions by creating support systems, 
	alleviating stress through humor, balancing work and play, talking it out, or 
	seeking counseling if necessary. Remember that leaders need support also, 
	and they need to be able to recognize when those who follow them need 
	support. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Discuss your situation openly with peers and employees, and acknowledge 
	the behaviors that may be occurring as a result. If people understand what's 
	going on in your life, they will be more apt to understand your actions. 
	Leaders don't have to be superhuman, and sometimes admitting your own 
	vulnerability actually causes others to respect you for your honesty and 
	forthrightness. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Improve your physical ability to cope by making sure that you get proper 
	nutrition, adequate rest, and regular exercise. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Create a less stressful environment by structuring time off from work, ceasing 
	to attend certain meetings, taking a class you enjoy, or possibly changing jobs 
	or vocation.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Leading Others Who are Under Stress: How to Handle It
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>




<%=AppModParaFont%>
	&#149;	Acknowledge that someone is demonstrating stress behavior. People aren't 
	always going to be at their best; we all have rough days. The faster you 
	determine that someone's behavior is stress-related, the more effectively you 
	can deal with the situation.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Recognize the environment (either internal or external) that is causing the 
	stress. If you are causing or contributing to that stress, evaluate what you can 
	change and what you can't. Many times we know if someone is on deadline 
	or under the gun to make a quota. It's harder to pinpoint when stress is 
	coming from someone's personal life, since we may not know a lot about that 
	person away from the office. Take responsibility to look for clues that may 
	give you an idea of the cause, and give people the benefit of the doubt, at 
	least initially.
<%=EndAppModParaFont%>




<%=AppModParaFont%>
	&#149;	Try to keep from reacting in kind. Many times, someone's behavior can be so 
	unpleasant that we begin to demonstrate our own stress behavior. Keep your 
	focus on the stress that is causing this behavior, and find ways to alleviate it, 
	if possible. For example, if the person seems unable to deal with one more 
	problem, delay telling her about the unhappy customer who called to 
	complain.  
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	If possible, avoid making excessive demands, initiating an important project, 
	or adding to the workload of someone who is exhibiting stress behavior. Wait 
	until the person's stress level is lower and you can work together under more 
	normal circumstances. If postponing is not possible, stay aware of the 
	person's situation and try to keep things as cool as you can.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Exercise: Leading Under Stress
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	Think of the last time you were in a stressful situation at work. How did your behavior 
	differ from your normal work-related behavior? How did your stress behavior affect 
	those whom you lead?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
	&#149;	How do the behaviors of some of your colleagues differ from yours when they 
	experience stress? What was most noticeable to you? How did you react?
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
	&#149;	What was the effect on relationships and productivity?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
	&#149;	When the stress subsided, what changes took place in the workplace?
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
	&#149;	What can you do to improve the situation the next time stress occurs?
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
		Working Together:  Leading and Following with Style
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>




<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Even Leaders Have Leaders
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Even though you lead people, you may also be led by other leaders. For that reason, 
	you need to make sure that you know how to recognize the requirements of following a 
	leader whose style may be similar to or different from yours. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Let Others Know What You Need from Them
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	On the other hand, you owe it to those who follow you to let them know what you need 
	from them as you work together. You will do them a great service by communicating 
	what behaviors on their part will enhance your working relationships. Obviously, you will 
	be doing some accommodating on your own, but they will find it helpful to know what 
	you need and expect from them also.
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleLeading_expect_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleLeading_expect_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleLeading_expect_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleLeading_expect_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Maximizing Your Leadership Effectiveness
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Strengths and Weaknesses
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Everyone's mix of behavioral tendencies contains both strengths and weaknesses. 
	When we concentrate on developing our strengths rather than avoiding our 
	weaknesses, we focus on what we can do rather than what we can't, and we leverage 
	those strong areas. As a result, our weaknesses become less influential in our behavior.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	In order to increase our effectiveness as a leader, we must identify the leadership 
	strengths that grow out of our particular style, as well as the naturally occurring 
	weaknesses. In many cases, our weaknesses are strengths taken to an extreme. For 
	example, perseverance can become stubbornness, and optimism can turn into 
	unrealistic behavior. In these cases, neutralizing a weakness can be as simple as 
	exercising self-discipline. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Using the high factor that you identified on your Composite Graph, locate the applicable 
	lists and check the Probable Strengths and Possible Weaknesses that apply to you as a 
	leader.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	<%=UserName1%>, below are listed the strengths and weaknesses common to leaders of your 
	temperament. Take a moment to read through the list and check those items that apply 
	to you as a leader.
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleLeading_swc_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleLeading_swc_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleLeading_swc_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleLeading_swc_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Dealing with Weaknesses
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	<%=AppModTitleFont%>
		You can implement several strategies for dealing with leadership weaknesses:
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>




<%=AppModParaFont%>
	&#149;	<strong>Develop compensating skills</strong><br>
	Recognize your weaknesses or tendencies and be aware of what they may be. 
	Remember that the weaknesses described in the PDI are not necessarily your 
	weaknesses. Rather, they are the typical weaknesses of your particular style. You 
	may identify with some and reject others. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Generally we can control these tendencies in our behavioral style if we are aware of 
	them. For example, someone who tends to be naturally dictatorial or unilateral in 
	decision-making can learn to get input from others before making decisions. A poor 
	listener can make an extra effort to become a better listener, perhaps by taking 
	some classes in the subject.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<strong>Recognize your own vulnerability and prepare for your behavior under stress</strong><br>
	Stress often brings our weaknesses to the surface. For example, impatience and 
	aggressiveness may become more pronounced in situations that demand our 
	performance in the face of obstacles. Or, a person who easily gets defensive will 
	become even more so when he or she feels threatened. If we are alert to both our 
	weaknesses and the situations in which we experience stress, we can develop early 
	warning systems that can help us neutralize the negative impact of these 
	tendencies. We can also formulate a strategy for dealing with those situations.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<strong>Staff to your weaknesses</strong><br>
	Synergy flows out of diversity. Identifying our own weaknesses alerts us to the need 
	to surround ourselves with associates and team members who are strong in those 
	areas where we are weakest. Andrew Carnegie, father of the US steel industry, 
	chose as his epitaph: &quot;Here lies a man who knew how to bring into his service better 
	men than he was himself (Peter Drucker, The Leader of the Future).&quot;  
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	Knowing your weaknesses can help you seek out and identify associates and 
	employees who manifest the strength side of that trait. For example, if you are a 
	freewheeling, generous person who may spend money too readily, you may want to 
	make sure that you have someone on your team with a sharp eye for ways to 
	conserve and cut costs. On the other hand, if you are too risk-averse to be decisive 
	in certain situations, you need to add an optimistic risk-taker to your staff.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	&#149;	<strong>Adapt your style to fit the needs of other people or situations</strong><br>
	Adapting certain behavioral dimensions of your style not only allows you to work 
	better with others of different styles but also helps them work better with you. This 
	application module provides you with insights about how to recognize the styles of 
	others, the needs of others' styles, and the strengths and weaknesses associated 
	with your own style.
<%=EndAppModParaFont%> 

<%=AppModParaFont%>
	You can use this information to tailor your behavior to the needs of others. Obviously, 
	you don't want to constantly change everything for everyone. However, you can identify 
	and select a few behavioral tendencies that, if modified, would better meet the needs of 
	the other person in a specific instance. If you are low-key and laid back by nature, you 
	may want to turn up the volume and enthusiasm when your top salesperson comes 
	back to the office, excited about her latest competitive win. Your naturally calm 
	disposition may put a damper on her motivation the next time.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
	On the following pages, we have provided action plan forms to help you capture the 
	insights you have gained in this workbook and put them into practice in your day-to-day 
	leadership activities.  
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
	<%=AppModTitleFont%>
		Leadership Action Plan
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Use this action plan guide to formulate how you might adapt your strategy to more 
	effectively provide leadership for a specific individual with whom you work.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&nbsp;</td>
		<td ALIGN="MIDDLE"><font size="4">D</td>
		<td ALIGN="MIDDLE"><font size="4">I</td>
		<td ALIGN="MIDDLE"><font size="4">S</td>
		<td ALIGN="MIDDLE"><font size="4">C</td>
	</tr>
	<tr>
		<td ALIGN="RIGHT">My Style:</td>
		<td ALIGN="MIDDLE">
		<% if HighType1 = "D" then %>
			<input CHECKED type="checkbox" id="checkbox2" name="checkbox2">
		<% else %>
			<input type="checkbox" id="checkbox2" name="checkbox2">
		<% end if %>
		</td>
		<td ALIGN="MIDDLE">
		<% if HighType1 = "I" then %>
			<input CHECKED type="checkbox" id="checkbox3" name="checkbox3">
		<% else %>
			<input type="checkbox" id="checkbox3" name="checkbox3">
		<% end if %>
		</td>
		<td ALIGN="MIDDLE">
		<% if HighType1 = "S" then %>
			<input CHECKED type="checkbox" id="checkbox4" name="checkbox4">
		<% else %>
			<input type="checkbox" id="checkbox4" name="checkbox4">
		<% end if %>
		</td>
		<td ALIGN="MIDDLE">
		<% if HighType1 = "C" then %>
			<input CHECKED type="checkbox" id="checkbox5" name="checkbox5">
		<% else %>
			<input type="checkbox" id="checkbox5" name="checkbox5">
		<% end if %>
		</td>
	</tr>
	<tr>
		<td ALIGN="RIGHT">_______________'s Style:</td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox6" name="checkbox6"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox7" name="checkbox7"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox8" name="checkbox8"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox9" name="checkbox9"></td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	Which of my specific leadership weaknesses might create the most problems as I 
attempt to provide leadership to this individual?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What leadership needs does a person of this style require that may be more difficult 
for me to provide?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	In what ways has the interaction of my style with his or her style already caused 
tension, conflict, and frustration for me and for him/her?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	How would I describe the degree of tension/conflict/frustration?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="60%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td ALIGN="MIDDLE"><font size="2">Not Very Bad</td>
		<td ALIGN="MIDDLE"><font size="2">Bad</td>
		<td ALIGN="MIDDLE"><font size="2">So-So</td>
		<td ALIGN="MIDDLE"><font size="2">Very Bad</td>
		<td ALIGN="MIDDLE"><font size="2">Terrible</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox10" name="checkbox10"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox11" name="checkbox11"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox12" name="checkbox12"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox13" name="checkbox13"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox14" name="checkbox14"></td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What are the implications of continuing in the situation without adapting my style?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What specific behaviors must I change as I adapt my style to better meet the 
demands of this situation and the needs of this person?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What are the barriers I face in adapting my style?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	Are there other options/strategies?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What specific action will I take?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
		Leadership Action Plan
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
	Use this action plan guide to formulate how you might adapt your strategy to more 
	effectively provide leadership for a specific individual with whom you work.
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>&nbsp;</td>
		<td ALIGN="MIDDLE"><font size="4">D</td>
		<td ALIGN="MIDDLE"><font size="4">I</td>
		<td ALIGN="MIDDLE"><font size="4">S</td>
		<td ALIGN="MIDDLE"><font size="4">C</td>
	</tr>
	<tr>
		<td ALIGN="RIGHT">My Style:</td>
		<td ALIGN="MIDDLE">
		<% if HighType1 = "D" then %>
			<input CHECKED type="checkbox" id="checkbox2" name="checkbox2">
		<% else %>
			<input type="checkbox" id="checkbox2" name="checkbox2">
		<% end if %>
		</td>
		<td ALIGN="MIDDLE">
		<% if HighType1 = "I" then %>
			<input CHECKED type="checkbox" id="checkbox3" name="checkbox3">
		<% else %>
			<input type="checkbox" id="checkbox3" name="checkbox3">
		<% end if %>
		</td>
		<td ALIGN="MIDDLE">
		<% if HighType1 = "S" then %>
			<input CHECKED type="checkbox" id="checkbox4" name="checkbox4">
		<% else %>
			<input type="checkbox" id="checkbox4" name="checkbox4">
		<% end if %>
		</td>
		<td ALIGN="MIDDLE">
		<% if HighType1 = "C" then %>
			<input CHECKED type="checkbox" id="checkbox5" name="checkbox5">
		<% else %>
			<input type="checkbox" id="checkbox5" name="checkbox5">
		<% end if %>
		</td>
	</tr>
	<tr>
		<td ALIGN="RIGHT">_______________'s Style:</td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox6" name="checkbox6"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox7" name="checkbox7"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox8" name="checkbox8"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox9" name="checkbox9"></td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	Which of my specific leadership weaknesses might create the most problems as I 
attempt to provide leadership to this individual?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What leadership needs does a person of this style require that may be more difficult 
for me to provide?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	In what ways has the interaction of my style with his or her style already caused 
tension, conflict, and frustration for me and for him/her?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	How would I describe the degree of tension/conflict/frustration?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="60%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td ALIGN="MIDDLE"><font size="2">Not Very Bad</td>
		<td ALIGN="MIDDLE"><font size="2">Bad</td>
		<td ALIGN="MIDDLE"><font size="2">So-So</td>
		<td ALIGN="MIDDLE"><font size="2">Very Bad</td>
		<td ALIGN="MIDDLE"><font size="2">Terrible</td>
	</tr>
	<tr>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox10" name="checkbox10"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox11" name="checkbox11"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox12" name="checkbox12"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox13" name="checkbox13"></td>
		<td ALIGN="MIDDLE"><input type="checkbox" id="checkbox14" name="checkbox14"></td>
	</tr>
</table>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What are the implications of continuing in the situation without adapting my style?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What specific behaviors must I change as I adapt my style to better meet the 
demands of this situation and the needs of this person?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What are the barriers I face in adapting my style?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	Are there other options/strategies?
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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
&#149;	What specific action will I take?
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
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