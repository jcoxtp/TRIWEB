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
		<TD COLSPAN=4><IMG SRC="images/teamwork_pdf_cover_01.gif" WIDTH=612 HEIGHT=45 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/teamwork_pdf_cover_02.gif" WIDTH=37 HEIGHT=280 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/teamwork_pdf_cover_03.jpg" WIDTH=407 HEIGHT=280 ALT=""></TD>
		<TD><IMG SRC="images/teamwork_pdf_cover_04.gif" WIDTH=168 HEIGHT=280 ALT=""></TD>
	</TR>
	<TR>
		<TD COLSPAN=4><IMG SRC="images/teamwork_pdf_cover_05.gif" WIDTH=612 HEIGHT=126 ALT=""></TD>
	</TR>
	<TR>
		<TD background="images/teamwork_pdf_cover_06.gif" WIDTH=612 HEIGHT=262 COLSPAN=4><%=UserName%><br><%=TestDate%></TD>
	</TR>
	<TR>
		<TD COLSPAN=2><IMG SRC="images/teamwork_pdf_cover_07.gif" WIDTH=124 HEIGHT=79 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/teamwork_pdf_cover_08.gif" WIDTH=488 HEIGHT=79 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/spacer.gif" WIDTH=37 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=87 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=320 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=168 HEIGHT=1 ALT=""></TD>
	</TR>
</TABLE>
<wxprinter PageBreak>
<%=strTopPgSpacing%>

<table WIDTH="700"><tr><td>

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
Teams that Work
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
<%=AppModParaFont%>
<%=AppModTitleFont%>
Group vs. Team
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Challenged on every front by intensified competition at home and abroad and increasing 
demands for quality and customer service, organizations around the world have 
undergone profound changes over the past several decades. Many companies have cut 
excess layers of management and staff, flattening their organizational structures to 
allow for increased efficiencies and agility. The demand for faster, higher-quality 
decisions requires more effective communication and better teamwork.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
New kinds of partnerships are forming within and among organizations as more and 
more people realize that working with each other can be more advantageous to 
everyone, both collectively and individually, than competing against each other.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Today most of us work in a group setting in which we are dependent, at least to some 
degree, on the performance of others. But simply functioning as a group is not enough. 
Organizations are discovering that to achieve exceptional results, groups must become 
teams.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
Teamwork is cooperation at its highest level. Effective teams produce outstanding 
results because of the synergistic effect. For a group, the results are additive: 1+1=2. 
For a team, however, the results are synergistic. In such cases, 1+1=3, 4, or even 5!
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
Team &amp; Temperament
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
If the benefits are so clear, why don't we see more teams and teamwork&#149; We encounter 
many pitfalls and barriers along the path to effective teamwork: misdirected competition, 
poor communication, interpersonal conflicts and antagonism, rejection, and resentment. 
Often we describe such tensions as personality conflicts. However, the difficulties arise 
not so much from several different personalities in conflict as from an ignorance of 
differences and dynamics between these personalities and the resulting behavioral 
styles.
<%=EndAppModParaFont%>


<%=AppModParaFont%>
Relationships are key to the success of any organization. The more we know about 
ourselves and others, the better we can avoid pitfalls, leverage our strengths, and move 
into new levels of team effectiveness.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
To function as a high performance team, all members must know and appreciate the 
strengths and needs of  the other team members:
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149; What motivates them<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149; How do we best communicate with them<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149; What creates tension between us<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149; In what situations do they work best<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149; What are the strengths and gifts they bring to our team<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Temperament Influences Teams
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Each temperament brings unique strengths and weaknesses to the team setting. Our 
behavioral styles influence the way we plan and organize our work, communicate, and 
make decisions. In addition, people tend to behave differently in groups than they do 
individually. So along with the effect our individual behavioral styles have on a team 
effort, the interactions among the various members become major factors in a team's 
success or failure. This application module will give you an opportunity to identify, 
explore, and discuss the effects of individual behavioral styles on your team.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Team Profiles
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Below we provide space for each team member's pattern. Draw your pattern on the 
graph designated &quot;My Profile.&quot; Then exchange patterns with your team members, and 
reproduce their patterns in the remaining graphs. You will use this information later in 
this module. It will also provide an ongoing reference for better understanding your 
teammates. Depending on the size of your team, you may need to photocopy the Profile 
Sheet on the facing page in order to have sufficient space.
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td VALIGN="TOP" ALIGN="MIDDLE">
		<% If NOT IsFakeResults then%>
			<img src="../disccomposite_small.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>">
		<% Else%>
			<img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<% End If %>
		<br>
		<font size="2">My Profile
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE">
		<img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br>Name:___________________<br>Pattern:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE">
		<img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br>Name:___________________<br>Pattern:__________________
		</td>
	</tr>
	<tr>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br>Name:___________________<br>Pattern:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br>Name:___________________<br>Pattern:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br>Name:___________________<br>Pattern:__________________
		</td>
	</tr>
	<tr>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br>Name:___________________<br>Pattern:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br>Name:___________________<br>Pattern:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br>Name:___________________<br>Pattern:__________________
		</td>
	</tr>
</table>



<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
Identifying the Style of Others
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
To successfully adapt our own style to better match the temperament of another person, 
we must first be able to identify the style of that individual. Obviously, we can't always 
administer the Personal DISCernment® Inventory (PDI), so how can we recognize the 
temperament of others&#149; One of the strengths of the PDI, as well as other DISC 
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
needs of various styles, can greatly increase your effectiveness as a team member.
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
<img SRC="images/appmodteamwork_figure3.gif" WIDTH="652" HEIGHT="564">
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Team Communication Styles
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
On a Team High D's
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%> 

<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>
		<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<tr>
				<td>&#149;</td>
				<td><font size="2">Stay goal-oriented</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Overcome obstacles</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Don't get bogged down</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Aren't afraid to speak out</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Take on challenges without fear</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are direct and straightforward</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Provide leadership</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Push the group toward decisions</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Usually keep a positive attitude</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are willing to take risks</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Handle multiple projects well</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Can function with heavy workloads</td>
			</tr>
		</table>

		
		</td>
		<td><img SRC="images/GOALS.gif" WIDTH="257" HEIGHT="324"></td>
	</tr>
</table>


<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
On a Team High I's
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%> 

<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td>
		<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<tr>
				<td>&#149;</td>
				<td><font size="2">Motivate</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are enthusiastic</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Enjoy working with people</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Provide leadership</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Will speak up</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are optimistic</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are agreeable</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Can create an atmosphere of goodwill</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Verbalize ideas</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Function well as spokespersons</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Can argue persuasively</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Stay people-oriented to achieve results</td>
			</tr>
		</table>

		
		</td>
		<td><img SRC="images/GOALS.gif" WIDTH="254" HEIGHT="324"></td>
	</tr>
</table>


<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
On a Team High S's
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%> 
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
	</td>
		<td><img SRC="images/GOALS.gif" WIDTH="254" HEIGHT="324"></td>
		<td>
		<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<tr>
				<td>&#149;</td>
				<td><font size="2">Buy into team goals</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Support other team members</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are dependable and faithful</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Identify strongly with the team</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Provide stabilility</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Focus on components of a total project</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Work toward building relationships</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are even-tempered</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are practical</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Offer specialized skills</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are patient</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are loyal</td>
			</tr>
		</table>

		
		
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
On a Team High C's
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%> 
<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
	
		
		</td>
		<td><img SRC="images/GOALS.gif" WIDTH="254" HEIGHT="324"></td>
		
		<td>
		<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<tr>
				<td>&#149;</td>
				<td><font size="2">Pay attention to details</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are conscientious</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Measure progress</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Ask important questions</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Prefer to share responsibilities and risks</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are systematic</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are willing to work toward consensus</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Are diplomatic</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Analyze problems</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Stress quality</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Think logically</td>
			</tr>
			<tr>
				<td>&#149;</td>
				<td><font size="2">Stay task-oriented</td>
			</tr>
		</table>

	</tr>
</table>


<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
The Behavior Style of a High <%=HighType1%> Team Member
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Application and Discussion
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=UserName1%> as a high <%=HighType1%>, aspects of your work or social style will affect the way you 
team up with others. Below is a list of descriptors for the high <%=HighType1%> temperament
<%=EndAppModParaFont%>

<%=AppModParaFont%>
1.	Personalize this list by checking those items you feel accurately describe you.
<br><br>
2.	Of those you checked, indicate with a &quot;+&quot; or a &quot;-&quot; any attribute you believe has a 
positive (+) or negative (-) effect on the team.
<br><br>

3.	If the team is large enough to include several members in each of the four 
behavioral styles, break into groups of styles and discuss your conclusions. 
Identify points of agreement and difference.
<%=EndAppModParaFont%>


<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_tm_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_tm_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_tm_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_tm_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Barriers to Team Effectiveness
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Attitudes
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
We tend to view team members in terms of their weaknesses, not 
their strengths&#151;especially those who have different patterns than 
our own.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=UserName1%>, as 
a High <%=HighType1%>&#133;
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_att_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_att_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_att_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_att_c.asp" -->
<% end if %>

<%=AppModParaFont%>
<%=AppModTitleFont%>
How to overcome the attitude barrier and build commitment to team 
members:
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
1.	View team members in terms of their strengths, not their weaknesses.<br>
2.	Become a champion of their strengths.<br>
3.	Be available to complement their weaknesses with your strengths.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Actions
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
We tend to cause tension in other people's lives by what we do as 
well as what we don't do. When tension occurs, we want others to 
change, but we don't see the need to change ourselves.
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_act_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_act_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_act_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_act_c.asp" -->
<% end if %>



<%=AppModParaFont%>
<%=AppModTitleFont%>
Application:
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
1. Review the descriptive terms for your style in the Attitudes and Actions charts. 
Are they accurate? Add and delete items on the two lists that would make 
them more descriptive of you.<br><br>
2. Compare notes with others of your style.
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
Working Together on Teams
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=UserName1%>, as a high <%=HighType1%> you have a unique style of working with other people. 
Here is how your style works with . . .
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_ww_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_ww_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_ww_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_ww_c.asp" -->
<% end if %>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Team Communication
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
With a<nother> High D...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
To communicate better with a<nother> High D do...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide direct answers and be brief and to the point.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress what has to be done, not why it has to be done.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress results.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide options and possibilities.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Emphasize logic of ideas and approaches.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Agree with the facts, position, or idea&#151;not just the person.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Avoid rambling.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Summarize and close.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
To communicate better with a<nother> High D don't...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Appear indecisive.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be problem-oriented.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be overly friendly.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Generalize.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide too many details.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Repeat yourself or talk too much.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Make unsupportable statements.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Make decisions for them.<br>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
As <other> High D's hear and analyze information, they may...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not consider risks.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not weigh pros and cons.
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
With a<nother>  High I . . .
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
To communicate better with a<nother>  High I do...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress the new, the special, and the novel.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Demonstrate the ability to be articulate.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress testimonies or feedback from &quot;experts.&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide opportunity for give and take.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be open, friendly, and warm.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be enthusiastic.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Listen attentively.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Spend time developing the relationship.<br>
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
To communicate better with a<nother>  High I don't...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Ignore the social dimensions.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Do all the talking.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Restrict suggestions or interruptions.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Let him or her take you too far off track.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be curt, cold, or tight-lipped.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Talk down to them.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
As <other> High I's hear and analyze information, they may&#133;
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not concentrate.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Ignore important facts.
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
With a<nother>  High S . . .
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
To communicate better with a<nother>  High S do...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Use patience in drawing out his/her goals.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Emphasize how a deliberate approach will work.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Talk service and dependability.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Ask how questions and get feedback.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Listen attentively.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be sincere.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Communicate in a low-key, relaxed manner.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
To communicate better with a<nother>  High S don't...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be too directive.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Push too aggressively or demand.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Move too fast.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Omit too many details.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be abrupt.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
As <other> High S's hear and analyze information, they may&#133;
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be quietly unyielding.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not be assertive in communicating their concerns.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Not provide a lot of feedback during presentations.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Hesitate to make a decision, particularly if unpopular.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Slow down the action.<br>
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
With a<nother>  High C . . .
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
To communicate better with a<nother>  High C do...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Use comparative data.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Appeal to logic, showing facts and benefits.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Concentrate on specifics.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Have all the facts, and stick to them.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be organized.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide written proposals for major decisions.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Appeal to interest in research, statistics, etc.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Provide detailed responses to questions.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Deal fully with objections.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Stress quality, reliability, and security.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
To communicate better with a<nother>  High C don't...
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be vague or casual, particularly when answering questions.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Move to the bottom line too quickly.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Get personal about family if you don't know him/her well.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Pat them on the back or otherwise be too familiar.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Speak too loudly.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Threaten, cajole, wheedle, or coax.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
As <other> High C's hear and analyze information, they may&#133;
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Be too conservative and cautious.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Bog down in the collection process.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Become buried in detail.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#149;	Delay or avoid decisions, particularly if risky.<br>
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
Team Relationships: Perplexing or Productive
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
We each have a distinctive personal style that is based on our unique personality, and 
we tend to deal with others based on the style that is comfortable for us. As team 
members, we normally tend to deliver information in the way that we would like to 
receive it.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
However, other people's styles may differ drastically from ours. What satisfies our need 
to give and receive information may be a complete turnoff to someone else. We must 
learn to recognize and appreciate their temperaments so that we can adapt our 
approach to suit an individual's behavioral style. Doing so will create the synergy that 
delivers outstanding results within an organization. 
<%=EndAppModParaFont%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
To clarify this concept, answer the following questions.
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	Think of a person on your team who frustrates you or makes you uncomfortable and 
less effective in achieving team goals. What characteristics does this person have 
that may cause conflict or make it difficult for you to achieve excellent results when 
you work together (e.g., has trouble making decisions, demonstrates a lack of focus, 
bogs down in details, moves too fast, etc.)? Describe these characteristics.
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
		<td>____________________________________________________________________
		</td>
	</tr>
	</table>
<%=EndAppModParaFont%>
<br><br>
<%=AppModParaFont%>
&#149;	Now describe a team member with whom you work especially well. What 
characteristics make you feel comfortable and more effective?
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
&#149;	In a situation where you have found your personal style to be different or even 
incompatible with someone else, what adjustments have you made? What 
adjustments has the other person made?
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
opportunities and potential for compatibility or for conflict. Although not set in stone, the 
following matrices present typical relational and task compatibilities of the various styles 
and rank them on a scale from Excellent to Poor.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
First, let's consider Relational Compatibility. How well do two styles interact in casual or 
general situations? For example, how do you get along with a coworker who may be in 
your department but rarely intersects with your job? Or, in your experience with 
roommates, which ones stand out as either delights or disasters? Relational 
Compatibility involves the aspects and attributes of a relationship, whether casual or 
intimate.
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
<%=AppModParaFont%>
Notice also that these are <em>tendencies</em> or <em>potential</em> compatibilities. They aren't rules for 
behavior, and people find many ways to adapt and compensate to offset the potential 
for conflict.   
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
When the Heat is On: Teamwork Under Stress
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
The workings of a high performance team become even more complex in our highly 
charged workplaces when tempers flare, fatigue sets in, and people resist or resent the 
message. Indeed, the most challenging communication situations occur when things 
aren't going well. A rise in stress levels introduces an interesting dimension to 
temperament that we call stress behavior. People with similar temperaments tend to 
behave alike in those situations in which we find ourselves &quot;at the end of our rope,&quot; 
feeling as though we just can't take it anymore. 
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
cautious, and accommodating in conflict and stress. They tend to pull back and may be 
slower to make decisions or take action.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Notice we described the above behavior with the qualifier &quot;initial.&quot; An interesting 
phenomenon occurs under sustained conflict and stress. If the conflict is not quickly 
resolved and the stress continues unabated, people tend to move into an alternate or 
reserve style of behavior. For example, the High D team member may initially become 
demanding (dictatorial and perhaps even tyrannical), but under sustained conflict will 
move to detachment. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Under stress, the High I will initially go on the attack. They can really zing you with their 
verbal skills, often using sarcasm or exaggeration to alleviate their frustration. However, 
if the stress increases and victory looks uncertain, the need for social approval will win 
out and the High I will often agree in order to maintain the group's positive feelings 
about him or her.  
<%=EndAppModParaFont%>

<%=AppModParaFont%>
The High S's normally agreeable disposition will not prepare others for what's boiling 
beneath the surface. If a High S reaches secondary stress levels, he or she may 
demonstrate attacking behavior, sending everyone running for cover.
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
Conflict is not the only cause of stress. Getting ready for the big presentation, rolling out 
a new ad campaign or logo, or even getting that big increase in the budget can produce 
stress.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Below is a list of more sources of stress for your temperament. Check the items you 
have found create stress for you, and add additional items if relevant.
<%=EndAppModParaFont%>


<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_es_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_es_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_es_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_es_c.asp" -->
<% end if %>

<%=AppModParaFont%>
Now think of those on your team. What situations create stress for them? How do their 
stressors differ from yours?
<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>


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
2.	Think of someone on your team who has a different behavioral style. How would 
you describe his/her behavior under stress? Again, check the behaviors on the 
list for his/her temperament below. List additional behaviors if relevant.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
<% if UCase(HighType1) = "D" then%>
Your Style - The High D Under Stress 
<% else %>
The High D Under Stress 
<% end if %>
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td>Can become very controlling</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td>Tries even harder to impose will on others</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td>Asserts self with body or language, may invade &quot;personal space&quot; or point fingers</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td>May demonstrate stony silence or get very vocal, raising volume and energy level</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td>Becomes even less willing to compromise</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td>Pulls rank on those with less power</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td>If stress produces conflict, gets over it quickly</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox1" name="checkbox1"></td>
		<td>________________________________________________________________</td>
	</tr>
</table>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
<% if UCase(HighType1) = "I" then%>
Your Style - The High I Under Stress 
<% else %>
The High I Under Stress 
<% end if %>
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
		<td>Focuses frustrations on other people</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
		<td>Blames others</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
		<td>Can become emotional even to the point of shouting, making extreme statements, or gesturing belligerently</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
		<td>Makes wounding, sarcastic remarks</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
		<td>Attempts to control others through words and emotion</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
		<td>If stress produces conflict, gets over it quickly and will go out of their way to make things right</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox9" name="checkbox9"></td>
		<td>________________________________________________________________</td>
	</tr>
</table>

<%=EndAppModParaFont%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
<% if UCase(HighType1) = "S" then%>
Your Style - The High S Under Stress 
<% else %>
The High S Under Stress 
<% end if %>

<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td>Voice, facial expressions, and gestures become mechanical and perfunctory</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td>May lack commitment even though voicing agreement</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td>Can be passive aggressive, i.e., uninvolvement, silence, or lack of expression</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td>Often complies rather than cooperates, producing minimal results</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td>If stress produces conflict, is sometimes slow to forgive and forget</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox16" name="checkbox16"></td>
		<td>________________________________________________________________</td>
	</tr>
</table>

<%=EndAppModParaFont%>

<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
<% if UCase(HighType1) = "C" then%>
Your Style - The High C Under Stress 
<% else %>
The High C Under Stress 
<% end if %>

<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>

<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td>Becomes even less responsive</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td>Limits vocal intonation, facial expression, and gestures (which are normally limited) even further</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td>Withdraws emotionally</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td>May avoid contact with others if conflicts arise</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td>May become hyper-sensitive to work-related criticisms</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td>May adopt a victimized attitude</td>
	</tr>
	<tr>
		<td><input type="checkbox" id="checkbox22" name="checkbox22"></td>
		<td>________________________________________________________________</td>
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
its effects on members of your team.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	Improve your attitude and perceptions by creating support systems, 
alleviating stress through humor, balancing work and play, talking it out, or 
seeking counseling if necessary.<br><br>
&#149;	If appropriate, learn a new skill, discuss your situation openly with team 
members, or just slow down a bit.<br><br>
&#149;	Improve your physical ability to cope by making sure that you get proper 
nutrition, adequate rest, and regular exercise.<br><br>
&#149;	Create a less stressful environment by structuring time off from work, ceasing 
to attend certain meetings, taking a class you enjoy, or possibly changing jobs 
or vocation.<br>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<%=AppModTitleFont%>
When a Team Member is Under Stress: How to Handle It
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
or under the gun to make quota. It's harder to pinpoint when stress is coming 
from someone's personal life, since we may not know a lot about that person 
away from the office. Take responsibility to look for clues that may give you 
an idea of the cause, and give people the benefit of the doubt, at least initially.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	Try to keep from reacting in kind. Many times, someone's behavior can be so 
unpleasant that we begin to demonstrate our own stress behavior. Keep your 
focus on the stress that is causing this behavior, and find ways to alleviate it, 
if possible. For example, if that person seems unable to deal with one more 
problem, delay telling him/her about the unhappy customer who called to 
complain.
<%=EndAppModParaFont%>  

<%=AppModParaFont%>
&#149;	If possible, avoid doing important business with someone who is exhibiting 
stress behavior. Wait until the person's stress level is lower and you can work 
under more normal circumstances.
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
Exercise: Teamwork Under Stress
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	Think of the last time you were in a stressful situation at work. How did your behavior 
differ from your normal work-related behavior?
<br><br>
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
</table>


<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	How did the behaviors of some of your colleagues differ? What was most noticeable 
to you?
<br><br>
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
</table>


<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	What was the effect on relationships and productivity?
<br><br>
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
</table>


<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	When the stress subsided, what changes took place in the workplace?
<br><br>
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
</table>


<%=EndAppModParaFont%>

<%=AppModParaFont%>
&#149;	What can you do to improve the situation the next time stress occurs?
<br><br>
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
</table>
<%=EndAppModParaFont%>


<wxprinter PageBreak><%=strTopPgSpacing%>


<%=AppModParaFont%>
<%=AppModTitleFont%>
Quick Tips
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Working with a team demands a willingness to modify your behavior in response to 
others' behavioral styles. Flexibility and openness can reduce tension, meet the needs 
of your fellow team members, and pave the way for the synergism that produces 
excellent results. As a High <%=HighType1%> team member, you may need to adapt in these 
ways when working with others:
<%=EndAppModParaFont%>

<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_adapt_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_adapt_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_adapt_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleTeamwork_adapt_c.asp" -->
<% end if %>





<%=AppModParaFont%>
<%=AppModTitleFont%>
Team Building Worksheet
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Instructions: The following pages will help team members exchange information about 
their behavioral styles and will help them work together more effectively. This exercise 
is designed for you to address each team member individually, answering several key 
questions about your relationship with that person. Answer each question as though you 
were speaking directly to that team member.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
<table WIDTH="600" BORDER="1" CELLSPACING="1" CELLPADDING="5">
	<tr>
		<td></td>
		<td><font size="2"><strong>Name:<br>_____________<br>Temperament:<br>_______</strong></td>
		<td><font size="2"><strong>Name:<br>_____________<br>Temperament:<br>_______</strong></td>
		<td><font size="2"><strong>Name:<br>_____________<br>Temperament:<br>_______</strong></td>
		<td><font size="2"><strong>Name:<br>_____________<br>Temperament:<br>_______</strong></td>
		<td><font size="2"><strong>Name:<br>_____________<br>Temperament:<br>_______</strong></td>
	</tr>
	<tr>
		
		<td><font size="3"><strong>What could be barriers to team effectiveness between us?</strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><font size="3"><strong>What may create conflict between us?</strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><font size="3"><strong>How do I need to communicate with you?</strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><font size="3"><strong>Given my personal style, how do you think I need you to communicate with me?</strong></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
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