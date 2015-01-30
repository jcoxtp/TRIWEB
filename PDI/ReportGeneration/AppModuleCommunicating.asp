<%@ Language=VBScript %>

<HTML>
  <HEAD>
<% intPageID = 64 
   Dim strTemp
%>
<!--#Include virtual="/pdi/Include/common.asp" -->
		<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
		<link rel="stylesheet" href="AppModStyle.css" type="text/css">
  </HEAD>
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
	Dim countOfTypes
		 countOfTypes = 0
	
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
	oConn.Open strDbConnString
	oCmd.ActiveConnection = oConn
	oRs.CursorLocation = 3
	oRs.Open oCmd, , 0, 1
	If oConn.Errors.Count > 0 Then
		Response.Write "Unable to retrieve PDI Profile information from database. Please try again."
		Response.End
	End If
	
	If Not oRs.EOF Then
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
		If (nC1=0) and (nC2=0) and (nC3=0) and (nC4=0) Then
			If (oRs("M_NumberD")=0) and (oRs("M_NumberI")=0) and (oRs("M_NumberS")=0) and (oRs("M_NumberC")=0) Then
				If (oRs("L_NumberD")=0) and (oRs("L_NumberI")=0) and (oRs("L_NumberS")=0) and (oRs("L_NumberC")=0) Then
					If (isNull(oRs("CPD"))) and (isNull(oRs("CPI"))) and (isNull(oRs("CPS"))) and (isNull(oRs("CPC"))) Then
						IsFakeResults = True
					End If
				End If
			End If
		End If
		'==================================================================================================
	Else
		Response.Write "Unable to retrieve PDI Profile information from database. Please try again."
		Response.End
	End If
	
%>
		<TABLE WIDTH="612" BORDER="0" align="center" CELLPADDING="0" CELLSPACING="0">
			<TR>
				<TD COLSPAN="4"><IMG SRC="images/communicating_pdf_cover_01.gif" WIDTH="612" HEIGHT="44" ALT=""></TD>
			</TR>
			<TR>
				<TD><IMG SRC="images/communicating_pdf_cover_02.gif" WIDTH="37" HEIGHT="282" ALT=""></TD>
				<TD COLSPAN="2"><IMG SRC="images/communicating_pdf_cover_03.jpg" WIDTH="407" HEIGHT="282" ALT=""></TD>
				<TD><IMG SRC="images/communicating_pdf_cover_04.gif" WIDTH="168" HEIGHT="282" ALT=""></TD>
			</TR>
			<TR>
				<TD COLSPAN="4"><IMG SRC="images/<%=strLanguageCode%>/communicating_pdf_cover_05.gif" WIDTH=612 HEIGHT=125 ALT=""></TD>
			</TR>
			<TR>
				<TD background="images/communicating_pdf_cover_06.gif" WIDTH="612" HEIGHT="261" COLSPAN="4"><%=UserName%><br>
					<%=TestDate%>
				</TD>
			</TR>
			<TR>
				<TD COLSPAN="2"><IMG SRC="images/<%=strLanguageCode%>/PDICover.gif" WIDTH=127 HEIGHT=80 ALT=""></TD>
				<TD COLSPAN="2"><IMG SRC="images/communicating_pdf_cover_08.gif" WIDTH="485" HEIGHT="80" ALT=""></TD>
			</TR>
			<TR>
				<TD><IMG SRC="images/spacer.gif" WIDTH="37" HEIGHT="1" ALT=""></TD>
				<TD><IMG SRC="images/spacer.gif" WIDTH="90" HEIGHT="1" ALT=""></TD>
				<TD><IMG SRC="images/spacer.gif" WIDTH="317" HEIGHT="1" ALT=""></TD>
				<TD><IMG SRC="images/spacer.gif" WIDTH="168" HEIGHT="1" ALT=""></TD>
			</TR>
		</TABLE>
		<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<div id="Content">
<p>
	<% strTemp = Replace(strTextWhenYouCompletedThePersonalDisce, "{{HighType1}}", HighType1)
	strTemp = Replace(strTemp, "{{UserName1}}", UserName1) %>
	<%= strTemp %> <!--When you completed the Personal DISCernment® Inventory, you identified the 
	particular pattern that best reflects your behavioral tendencies. <%=UserName1%>, based on the 
	&quot;Composite Graph&quot; of your Personal DISCernment® Inventory, your predominant style is 
	that of a high &quot;<%=HighType1%>&quot;.-->
</p>
<p>
	<% If NOT IsFakeResults Then %>
	<img src="../disccompositesmall.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" align="left" hspace="12" v:shapes="_x0000_s1026">
	<% End If %>
	<%= strTextThePersonalDiscernmentInventory %> <!--The Personal DISCernment® Inventory measures 
	four factors (D, I, S, and C) that influence behavioral styles. Although everyone has 
	threads of all four factors woven into our basic temperament, most of us find that one or 
	perhaps two of the factors express themselves more strongly than the others in our 
	behavioral style. Each person's temperament is, in part, an expression of the way the 
	four factors combine. For example, a High I who is also a fairly High D will approach 
	things differently than a High I whose D is low.-->
</p>
<h1>
	<%= strTextCommunicatingWithStyleInTheInf %> <!--Communicating with Style in the Information Age-->
</h1>
<p>
	<%= strTextInTheMidstOfTheInformationExpl %> <!--In the midst of the information explosion, communication has     become a critical 
	necessity to doing business as well as an integral part of management strategy. The 
	Information Age, with all its vast resources, has created its own particular challenges 
	and difficulties. Indeed, technology has made transferring and storing information so 
	easy that we are literally drowning in emails, voice mails, web pages, printed materials, 
	and a 24/7 bombardment of multimedia.-->
</p>
<p>
	<%= strTextTheAverageSoundBiteHasDroppedF %> <!--The average sound bite has dropped from 45 to 8 seconds, and an average weekday 
	issue of the New York Times contains more information than someone in 17th century 
	England received in a lifetime.-->
</p>
<p>
	<%= strTextFurthermoreMuchCommunicationIs %> <!--Furthermore, much communication is designed to conceal rather than reveal. Spin 
	doctors, corporate executives, attorneys, and bureaucrats subject us to what author 
	William Lutz calls &quot;double-speak&quot;&#151;a barrage of euphemisms, jargon, and 
	gobbledygook that obscures in the name of communication. Cemeteries become 
	&quot;memorial gardens,&quot; and taxes become &quot;revenue enhancements.&quot;-->
</p>
<p>
	<%= strTextInTheWorkplaceGlitzyPresentati %> <!--In the workplace, glitzy presentations substitute for software and flash for substance. 
	Meetings last too long and accomplish too little, with executives spending as much as 
	four days a week in meetings. In addition, we receive hundreds of emails, voice mails, 
	and phone calls that drain our energy and productivity.-->
</p>
<p>
	<%= strTextAsWeBecomeAnIncreasinglyGlobal %> <!--As we become an increasingly global economy, many clients, customers, and 
	associates struggle with second, third, and even fourth languages while doing business 
	around the corner or across the world. Add to that the cultural differences of nonverbal 
	communication, and we have some severe obstacles to overcome.-->
</p>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
							
<h1>
	<%= strTextMakingTheConnectionOpportuniti %> <!--Making the Connection: Opportunities and Obstacles-->
</h1>
<p>
	<%= strTextAtItsBestCommunicationPresents %> <!--At its best, communication presents a number of formidable challenges. Some of the 
	greatest difficulties arise because the sender gets to choose the words, and the receiver 
	gets to choose the meaning.-->
</p>
<p>
	<%= strTextInAnyCommunicationSituationYour %> <!--In any communication situation, your goal is to accomplish certain objectives: gain 
	agreement on a major project, negotiate the best deal for your company, formulate a 
	corporate mission statement, motivate a disgruntled employee. Often, you have only 
	one shot at getting your message across, and not much time to do it. In addition, you 
	are competing with a variety of issues and media for your audience's attention. 
	Distractions are constant and everywhere.-->
</p>
<p>
	<%= strTextQuiteFranklyYourAudienceMayHav %> <!--Quite frankly, your audience may have neither the time nor the inclination to work very 
	hard to receive your message. You have to make it easy for your audience to receive it, 
	and you have to show them why it's in their best interest.-->
</p>
<p>
	<%= strTextToCommunicateEffectivelyYouMus %> <!--To communicate effectively, you must establish common ground with your audience so 
	that your goals and your audience's needs and wants come together&#151;not an easy task, 
	especially when you consider the many filters between you and your audience that can 
	further compound the problem.-->
</p>

<div style="text-align:center">
	<h3><%= strTextAudienceFilters %><!--Audience Filters--></h3>
	<img SRC="images/<%=strLanguageCode%>/appmodcomm_audrec.gif" WIDTH="340" HEIGHT="249">
</div>
<br>
<br>
<h1>
	<%= strTextPersonalStyleAndTheCommunicati %> <!--Personal Style and the Communication Process-->
</h1>
<p>
	<%= strTextOneOfTheMostPowerfulFiltersTha %> <!--One of the most powerful filters that inhibits, prohibits, or distorts communication is the 
	issue of personal style: the way that each of us likes to give and receive information. In 
	many cases, we erroneously assume that if we like to communicate in a certain way, 
	then everyone else must also prefer that method. Unfortunately, we are wrong about 75 
	percent of the time, and we are left wondering how we could have miscommunicated so 
	abysmally.-->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<p>
	<%= strTextOnTheOtherHandWeHaveTroubleRec %><!--On the other hand, we have trouble receiving information from certain people because 
	of the way they deliver it: they take too long to get to the point; they get to the point too 
	quickly, without sufficient details; they don't appear to have a sense of humor; they're all 
	business; or they're nosy, always asking personal questions. Why don't they just stick to 
	the topic at hand and be done with it?-->
</p>

<p>
	<%= strTextTheseFiltersAreOftenTheResultO %><!--These filters are often the result of the personal styles that you discovered when you 
	completed the Personal DISCernment® Inventory. You found that the more you know 
	about yourself and others, the better you can anticipate behavior 
	in certain situations and relate more effectively to others.-->
</p>

<h1>
	<%= strTextHowThisApplicationModuleCanHel %><!--How this Application Module Can Help-->
</h1>

<p>
	<%= strTextCommunicatingWithStyleWillHelp %><!--Communicating with Style will help you understand your personal communication 
	style in light of your DISC profile. You will identify how your style potentially helps or 
	hinders you in delivering messages and achieving your objectives as you:-->
</p>
<ul>
	<li> <%= strTextSpeak %><!--Speak-->
	<li> <%= strTextWrite %><!--Write-->
	<li> <%= strTextResolveConflictsnegotiate %><!--Resolve conflicts/Negotiate-->
	<li> <%= strTextCoachAndGiveFeedback %><!--Coach and give feedback-->
	<li> <%= strTextListen %><!--Listen--></li>
</ul>
<p>
	<%= strTextWhatAboutTheRequirementsAndDem %><!--What about the requirements and demands of those who receive your messages? How 
	can you work within the strengths and limitations of your style to adapt to the particular 
	needs of your audience? This application module can help you discover how to 
	communicate effectively in order to meet the challenges of a changing world. -->
</p>

<% If intLanguageID = 1 Then %>

<h2>Table of Contents</h2>
		<table width="80%" ID="Table13">
			<tr>
				<td width="100"><b>A Quick Review</b></td>
				<td style="border-bottom:1px dotted black">&nbsp;</td>
				<td width="5">4</td>
			</tr>
		</table>
		<table width="80%" ID="Table14">
			<tr>
				<td width="224"><b>Overview of Communication Styles</b></td>
				<td style="border-bottom:1px dotted black">&nbsp;</td>
				<td width="5">6</td>
			</tr>
		</table>
		<b>
			<TABLE id="Table15" width="80%">
				<TR>
					<TD width="300"><STRONG>Temperament and the Communication Process</STRONG></TD>
					<td style="border-bottom:1px dotted black">&nbsp;</td>
					<TD width="5">9</TD>
				</TR>
			</TABLE>
		</b>
		<TABLE id="Table16" width="80%">
			<TR>
				<TD width="280"><B>Communication Strengths and Weaknesses</B></TD>
				<td style="border-bottom:1px dotted black">&nbsp;</td>
				<TD width="5">12</TD>
			</TR>
		</TABLE>
		<TABLE id="Table17" width="80%">
			<TR>
				<TD width="200"><B>Identifying the Style of Others</B></TD>
				<td style="border-bottom:1px dotted black">&nbsp;</td>
				<TD width="5">14</TD>
			</TR>
		</TABLE>
		<TABLE id="Table19" width="80%">
			<TR>
				<TD width="123"><B>Style Compatibility</B></TD>
				<td style="border-bottom:1px dotted black">&nbsp;</td>
				<TD width="5">18</TD>
			</TR>
		</TABLE>
		<TABLE id="Table20" width="80%">
			<TR>
				<TD width="317"><B>What Different Styles Look for in Communication</B></TD>
				<td style="border-bottom:1px dotted black">&nbsp;</td>
				<TD width="5">19</TD>
			</TR>
		</TABLE>
		<TABLE id="Table21" width="80%">
			<TR>
				<TD width="162"><B>Communication Strategy</B></TD>
				<td style="border-bottom:1px dotted black">&nbsp;</td>
				<TD width="5">20</TD>
			</TR>
		</TABLE>
		<TABLE id="Table22" width="80%">
			<TR>
				<TD width="186"><B>Communication Under Stress</B></TD>
				<td style="border-bottom:1px dotted black">&nbsp;</td>
				<TD width="5">24</TD>
			</TR>
		</TABLE>
		<TABLE id="Table23" width="80%">
			<TR>
				<TD width="102"><B>Action Planning</B></TD>
				<td style="border-bottom:1px dotted black">&nbsp;</td>
				<TD width="5">29</TD>
			</TR>
		</TABLE>

<% End If %>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
									
									<h1>
									<%= strTextExerciseAQuickReview %> <!--Exercise: A Quick Review-->
									</h1>
									<p>
									<%= strTextLetsSeeHowMuchYouObservedFromT %> <!--Let's see how much you observed from the Personal DISCernment® Inventory (PDI) 
	and from the people you know who manifest different styles. Write down how you think 
	the characteristics of each style impact their communication.-->
									</p>
									<h2>
									<%= strTextCommunicationStyleOfTheHighD %> <!--Communication Style of the High D-->
									</h2>
									<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="5">
										<tr>
											<td><font size="2"><%= strTextWhatILike %><!--What I Like--></font>
											</td>
											<td><font size="2"><%= strTextWhatFrustratesMe %><!--What Frustrates Me--></font></td>
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
									<br>
									<br>
									<h2>
									<%= strTextCommunicationStyleOfTheHighI %> <!--Communication Style of the High I-->
									</h2>
									<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="5">
										<tr>
											<td><font size="2"><%= strTextWhatILike %><!--What I Like--></font>
											</td>
											<td><font size="2"><%= strTextWhatFrustratesMe %><!--What Frustrates Me--></font></td>
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
									<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
										
										<h2>
										<%= strTextCommunicationStyleOfTheHighS %> <!--Communication Style of the High S-->
										</h2>
										<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="5">
											<tr>
												<td><font size="2"><%= strTextWhatILike %><!--What I Like--></font>
												</td>
												<td><font size="2"><%= strTextWhatFrustratesMe %><!--What Frustrates Me--></font></td>
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
										<br>
										<br>
										<h2>
										<%= strTextCommunicationStyleOfTheHighC %> <!--Communication Style of the High C-->
										</h2>
										<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="5">
											<tr>
												<td><font size="2"><%= strTextWhatILike %><!--What I Like--></font>
												</td>
												<td><font size="2"><%= strTextWhatFrustratesMe %><!--What Frustrates Me--></font></td>
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
										<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
											
											<h1>
											<%= strTextCommunicationStylesAnOverview %> <!--Communication Styles: an Overview-->
											</h1>
											<% If UCase(HighType1) = "D" Then %>
											<!-- #Include File = "AppModuleCommunicating_style_d.asp" -->
											<% ElseIf UCase(HighType1) = "I" Then %>
											<!-- #Include File = "AppModuleCommunicating_style_i.asp" -->
											<% ElseIf UCase(HighType1) = "S" Then %>
											<!-- #Include File = "AppModuleCommunicating_style_s.asp" -->
											<% ElseIf UCase(HighType1) = "C" Then %>
											<!-- #Include File = "AppModuleCommunicating_style_c.asp" -->
											<% End If %>
											<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
											<%
												If UCase(HighType1) <> "D" Then 
													countOfTypes = countOfTypes + 1
											%>
											<!-- #Include File ="AppModuleCommunicating_shortstyle_d.asp" -->
											<%
												End If 
												Response.Write "<BR><BR><BR>"
												If UCase(HighType1) <> "I" Then 
													countOfTypes = countOfTypes + 1
											%>
											<!-- #Include File ="AppModuleCommunicating_shortstyle_i.asp" -->
											<%
												End If
												'Response.Write "countOfTypes: " & countOfTypes
												If countOfTypes >= 2 Then
													Response.Write Chr(13) & Chr(10) & "<DIV style=""PAGE-BREAK-AFTER: always"">&nbsp;</DIV>" & Chr(13) & Chr(10)
													countOfTypes = 0
												Else
													Response.Write "<BR><BR><BR>"
												End If
												
												If UCase(HighType1) <> "S" Then 
													countOfTypes = countOfTypes + 1
											%>
											<!-- #Include File ="AppModuleCommunicating_shortstyle_s.asp" -->
											<%
												End If
												'Response.Write "countOfTypes: " & countOfTypes
												If countOfTypes >= 2 Then
													Response.Write Chr(13) & Chr(10) & "<DIV style=""PAGE-BREAK-AFTER: always"">&nbsp;</DIV>" & Chr(13) & Chr(10)
												Else
													Response.Write "<BR><BR><BR>"
												End If
												If UCase(HighType1) <> "C" Then 
											%>
											<!-- #Include File ="AppModuleCommunicating_shortstyle_c.asp" -->
											<%
												End If
											%>
					<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<h1>
	<%= strTextTemperamentAndTheCommunication %> <!--Temperament and the Communication Process-->
</h1>
<p>
	<%
	strTemp = Replace(strTextAlthoughCommunicationEncompass, "{{UserName1}}", UserName1)
	strTemp = Replace(strTemp, "{{HighType1}}", HighType1)
	%>
	<%= strTemp %> <!--Although communication encompasses a variety of forms and functions, the following 
	activities represent ways that we communicate on the job and in professional and 
	personal relationships. <%=UserName1%>, take a minute to think about how your high <%=HighType1%> 
	style helps or hinders you in performing each of these basic communication functions. 
	Note specific examples when possible.-->
</p>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
<tr>
	<td COLSPAN="6" ALIGN="center"><h2><% Response.Write Replace(strTextMyHighhightype1StyleIs, "{{HighType1}}", HighType1) %><!--My High <%=HighType1%> Style is...--></h2></td>
</tr>
<tr>
	<td WIDTH="50%"><font size="2"><strong><%= strTextInSpeaking %><!--In Speaking--></strong></font></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHelp %><!--A Big Help--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatHelpful %><!--Somewhat Helpful--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextLittlenoEffect %><!--Little/No Effect--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatOfAHindrance %><!--Somewhat of a Hindrance--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHindrance %><!--A Big Hindrance--></span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextProposingIdeas %><!--Proposing Ideas--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextDescribingCapabilities %><!--Describing Capabilities--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextPersuadingmotivating %><!--Persuading/Motivating--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextReadingAudience %><!--Reading Audience--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextPreparingForAndConductingMeeti %><!--Preparing for and conducting meetings--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextManagingTimeConstraints %><!--Managing Time Constraints--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextHandlingObjections %><!--Handling Objections--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
</table>
<br>

<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
<tr>
	<td COLSPAN="6" ALIGN="center"><h2><% Response.Write Replace(strTextMyHighhightype1StyleIs, "{{HighType1}}", HighType1) %><!--My High <%=HighType1%> Style is...--></h2></td>
</tr>
<tr>
	<td WIDTH="50%"><font size="2"><strong><%= strTextInResolvingConflictnegotiating %><!--In Resolving Conflict/Negotiating--></strong></font></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHelp %><!--A Big Help--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatHelpful %><!--Somewhat Helpful--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextLittlenoEffect %><!--Little/No Effect--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatOfAHindrance %><!--Somewhat of a Hindrance--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHindrance %><!--A Big Hindrance--></span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextThinkingBeforeSpeaking %><!--Thinking before speaking--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextDealingWithConflictsPromptly %><!--Dealing with conflicts promptly--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextSeparatingIssuesFromPersonalit %><!--Separating issues from personalities--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextCreatingAlternatives %><!--Creating alternatives--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextCreatingACooperativeAtmosphere %><!--Creating a cooperative atmosphere--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextMakingEveryoneFeelLikeAWinner %><!--Making everyone feel like a winner--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextBeingAbleToForgiveAndForget %><!--Being able to forgive and forget--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
</table>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
<tr>
	<td COLSPAN="6" ALIGN="center"><h2><% Response.Write Replace(strTextMyHighhightype1StyleIs, "{{HighType1}}", HighType1) %><!--My High <%=HighType1%> Style is...--></h2></td>
</tr>
<tr>
	<td WIDTH="50%"><font size="2"><strong><%= strTextInCoachinggivingFeedback %><!--In Coaching/Giving Feedback--></strong></font></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHelp %><!--A Big Help--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatHelpful %><!--Somewhat Helpful--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextLittlenoEffect %><!--Little/No Effect--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatOfAHindrance %><!--Somewhat of a Hindrance--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHindrance %><!--A Big Hindrance--></span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextSharingInformationExplainingTh %><!--Sharing information, explaining things clearly--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextBeingDescriptiveRatherThanEval %><!--Being descriptive rather than evaluative--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextCriticizingWithoutCrippling %><!--Criticizing without crippling--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextActivelyConfrontingTheIssue %><!--Actively confronting the issue--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextProvidingSpecificExamplesVsVag %><!--Providing specific examples vs vague generalities--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextSeparatingBehaviorFromBothMoti %><!--Separating behavior from both motive and personality--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
<tr>
	<td><font size="2"><%= strTextExpressingSupportWithoutBeingO %><!--Expressing support without being overly lenient--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
</tr>
</table>
<br><br><br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td COLSPAN="6" ALIGN="center"><h2><% Response.Write Replace(strTextMyHighhightype1StyleIs, "{{HighType1}}", HighType1) %><!--My High <%=HighType1%> Style is...--></h2></td>
	</tr>
	<tr>
		<td WIDTH="50%"><font size="2"><strong><%= strTextInWriting %><!--In Writing--></strong></font></td>
		<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHelp %><!--A Big Help--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatHelpful %><!--Somewhat Helpful--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextLittlenoEffect %><!--Little/No Effect--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatOfAHindrance %><!--Somewhat of a Hindrance--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHindrance %><!--A Big Hindrance--></span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextMakingObjectivesClear %><!--Making objectives clear--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextAnalyzingAudienceAndEstablishi %><!--Analyzing audience and establishing common ground--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextOrganizingInformationForReadab %><!--Organizing information for readability--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextDesigningReaderfriendlyDocumen %><!--Designing reader-friendly documents--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextWritingClearlyConciselyAndRead %><!--Writing clearly, concisely, and readably to express rather than to impress--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
</table>
<br><br><br>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td COLSPAN="6" ALIGN="center"><h2><% Response.Write Replace(strTextMyHighhightype1StyleIs, "{{HighType1}}", HighType1) %><!--My High <%=HighType1%> Style is...--></h2></td>
	</tr>
	<tr>
		<td WIDTH="50%"><font size="2"><strong><%= strTextInListening %><!--In Listening--></strong></font></td>
		<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHelp %><!--A Big Help--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatHelpful %><!--Somewhat Helpful--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextLittlenoEffect %><!--Little/No Effect--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextSomewhatOfAHindrance %><!--Somewhat of a Hindrance--></span></td>
	<td WIDTH="10%" valign="bottom" align="center"><span class="small-text"><%= strTextABigHindrance %><!--A Big Hindrance--></span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextGenuineInterestInWhatSomeoneHa %><!--Genuine interest in what someone has to say; wants to listen--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextListeningForBothFactsAndFeelin %><!--Listening for both facts and feelings--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextControllingFiltersThatDistortH %><!--Controlling filters that distort how listening occurs--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextAvoidingOrEliminatingDistracti %><!--Avoiding or eliminating distractions--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
	<tr>
		<td><font size="2"><%= strTextProvidingListeningChecksAndAsk %><!--Providing listening checks and asking questions--></font></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	<td align="center"><span class="boxed">q</span></td>
	</tr>
</table>
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
													<p>
													<%= strTextPutACircleAroundEachPhraseYouv %><!--Put a circle around each phrase you've marked as &quot;A Big Help,&quot; and a square 
													around all those you've marked as &quot;A Big Hindrance.&quot;-->
													</p>

													<p>
													<%= strTextRankEachActivityYouveMarkedInO %><!--Rank each activity you've marked in order of its importance to you and your personal effectiveness.-->
													</p>
													<table BORDER="0" CELLSPACING="1" CELLPADDING="5">
														<tr>
															<td><font size="2"><strong><%= strTextABigHelp %><!--A Big Help--></strong></font></td>
															<td><font size="2"><strong><%= strTextABigHindrance %><!--A Big Hindrance--></strong></font></td>
														</tr>
														<tr>
															<td><font size="2">1.____________________________________</font></td>
															<td><font size="2">1.____________________________________</font></td>
														</tr>
														<tr>
															<td><font size="2">2.____________________________________</font></td>
															<td><font size="2">2.____________________________________</font></td>
														</tr>
														<tr>
															<td><font size="2">3.____________________________________</font></td>
															<td><font size="2">3.____________________________________</font></td>
														</tr>
														<tr>
															<td><font size="2">4.____________________________________</font></td>
															<td><font size="2">4.____________________________________</font></td>
														</tr>
														<tr>
															<td><font size="2">5.____________________________________</font></td>
															<td><font size="2">5.____________________________________</font></td>
														</tr>
													</table>

<p>
<%
strTemp = Replace(strTextAmongThoseActivitiesYouveRanke, "{{UserName1}}", UserName1)
%>
	<%= strTemp %><!--Among those activities you've ranked as &quot;A Big Hindrance&quot; to your effectiveness, let's 
	examine the top three. <%=UserName1%>, what action steps can you take immediately to help 
	you improve your effectiveness in these activities?-->
</p>

<p>
1. <%= strTextTheActivityIs %><!--The activity is--> _______________________________________________________
<br><br>
<%= strTextICanStrengthenMyEffectivenessI %><!--I can strengthen my effectiveness in this activity by:-->
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

</p>

<p>
2. <%= strTextTheActivityIs %><!--The activity is--> _______________________________________________________
<br><br>
<%= strTextICanStrengthenMyEffectivenessI %><!--I can strengthen my effectiveness in this activity by:-->
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

</p>

<p>
3. <%= strTextTheActivityIs %><!--The activity is--> _______________________________________________________
<br><br>
<%= strTextICanStrengthenMyEffectivenessI %><!--I can strengthen my effectiveness in this activity by:-->
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

</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
															
<h1>
<%= strTextExerciseCommunicationStrengths %> <!--Exercise: Communication Strengths and Weaknesses-->
</h1>
<p>
<%
strTemp = Replace(strTextusername1AspectsOfYourBehavior, "{{UserName1}}", UserName1)
strTemp = Replace(strTemp, "{{HighType1}}", HighType1)
%>
<%= strTemp %> <!--<%=UserName1%>, aspects of your behavioral style may prove a help or hindrance as you 
communicate. Below are listed the strengths and weaknesses commonly found in a 
high <%=HighType1%> temperament. They are organized around the key components of 
communication. Take a few moments to read through the list, and check those items 
you believe accurately describe you.-->
</p>
<p>
<%= strTextInTheStrengthsColumnExamineThe %> <!--In the strengths column, examine the item(s) that you did not check. Circle those which, 
if developed, could most improve your personal effectiveness as a communicator.-->
</p>
<p>
<%= strTextInTheWeaknessesColumnExamineTh %> <!--In the weaknesses column, examine the item(s) that you checked. Circle those which, if 
strengthened, could most improve your personal effectiveness as a communicator.-->
</p>

<% If UCase(HighType1) = "D" Then %>
<!-- #Include File = "AppModuleCommunicating_style_sw_d.asp" -->
<% ElseIf UCase(HighType1) = "I" Then %>
<!-- #Include File = "AppModuleCommunicating_style_sw_i.asp" -->
<% ElseIf UCase(HighType1) = "S" Then %>
<!-- #Include File = "AppModuleCommunicating_style_sw_s.asp" -->
<% ElseIf UCase(HighType1) = "C" Then %>
<!-- #Include File = "AppModuleCommunicating_style_sw_c.asp" -->
<% End If %>
<br>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h1>
	<%= strTextIdentifyingTheStyleOfOthers %><!--Identifying the Style of Others-->
</h1>

<p>
	<%= strTextToSuccessfullyAdaptOurOwnStyle %><!--To successfully adapt our own style to match the temperament of another person, we 
	must first be able to identify the style of that individual. Obviously, we can't always 
	administer the Personal DISCernment® Inventory (PDI), so how can we recognize the 
	temperament of others? One of the strengths of the PDI, as well as other DISC 
	instruments, is that it deals largely with &quot;observable&quot; behavior. A careful, informed 
	observation can help you develop a reasonably accurate &quot;guesstimate&quot; 
	of someone's personal style.-->
</p>

<h3>
	<%= strTextInIdentifyingTheStylesOfOthers %><!--In identifying the styles of others the following principles will help:-->
</h3>

<ul>
	<li>
		<%= strTextUnderstandTheLimitationsOfTrying %><!--Understand the limitations of trying to identify others' styles by observation alone. 
		Although certainly influenced by inner, unseen forces, behavior is not clear evidence 
		of values, motives, intelligence, feelings, or attitudes. As you observe a person 
		behaving or &quot;acting&quot; in a certain manner, don't ascribe the underlying emotion or 
		motive. Confine your conclusions to &quot;observable&quot; behavior.-->
		<br><br></li>
	<li>
		<%= strTextWithholdFinalJudgmentUntilYouHav %><!--Withhold final judgment until you have had more than one encounter. 
		Often it takes time to develop the confidence that you have accurately assessed an 
		individual. If others don't trust you or don't perceive the environment as safe, they 
		may put up a mask. Create an atmosphere that encourages others to be themselves.-->
		<br><br></li>
	<li>
		<%= strTextPayParticularAttentionToNonverba %><!--Pay particular attention to nonverbal communication. 
		Words account for less than 10 percent of any communication. Watch the body 
		language, facial expressions, and gestures of the other individual. For example, an 
		action-oriented person may be more animated with gestures, use more vocal 
		inflection and facial expressions.-->
		<br><br></li>
	<li>
		<%= strTextUseYourKnowledgeToIncreaseYourUn %><!--Use your knowledge to increase your understanding of and response to others' needs. 
		Your ability to recognize styles in others, coupled with an understanding of the 
		needs of various styles, can greatly increase your effectiveness as a communicator.-->
	</li>
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
																	
<h3>
<%= strTextLetsReviewTheFourelementModelT %> <!--Let's review the four-element model that we introduced in the PDI.-->
</h3>

<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/fourelementmodel.gif"><br>
	<b><%= strTextFigure1 %> <!--Figure 1--></b>
</div>

<p>
<%= strTextOnTheFollowingPagesWeExpandOnTh %> <!--On the following pages, we expand on this model to identify the more visible behavioral 
tendencies of different styles.-->
</p>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
																		
<h3>
<%= strTextPeopleVsTask %> <!--People vs. Task-->
</h3>
<p>
<%= strTextUsingThisModelWeCanSeeInFigure %> <!--Using this model, we can see in Figure 2 that those to the right of the vertical line are 
more people-oriented and those to the left are more task-oriented. These groups also 
have certain &quot;observable&quot; characteristics. People-oriented individuals tend to connect 
more readily with others, often with warmth and openness. On the other hand, task-
oriented people are generally cooler, more reserved, and somewhat less expressive.-->
</p>
<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/peoplevtaskvertical.gif"><br>
	<b><%= strTextFigure2 %> <!--Figure 2--></b>
</div>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
																			
<h3>
<%= strTextActionVsResponse %> <!--Action vs. Response-->
</h3>
<p>
<%= strTextNowNoticeTheHorizontalLinePeop %> <!--Now, notice the horizontal line. People above the horizontal line tend to be active or 
assertive; these individuals generally demonstrate a bold, confident, and directive 
demeanor to others. Those below the line are more responsive or accommodating; 
others see them as low key, collaborative, and self-controlled. Detailed descriptions of 
tendencies in assertive and responsive temperaments are shown in the diagram below:-->
</p>

<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/peoplevtaskhorizontal.gif"><br>
	<b><%= strTextFigure3 %> <!--Figure 3--></b>
</div>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
																				
<h1>
<%= strTextDiscCompatibilityMatrix %> <!--DISC Compatibility Matrix-->
</h1>
<p>
<%= strTextAsYouObservedInThePreviousExer %> <!--As you observed in the previous exercise, different personal style combinations present 
opportunities and potential for compatibility or for conflict. Although not carved in stone, 
the following matrices present typical relational and task compatibilities of the various 
styles and rank them on a scale from Excellent to Poor.-->
</p>
<p>
<%= strTextFirstLetsConsiderRelationalCom %> <!--First, let's consider Relational Compatibility. How well do two styles interact in casual or 
general situations? For example, how do you get along with a coworker who may be in 
your department but rarely intersects with your job? Or, in your experience with 
roommates, which ones stand out as delights or disasters? Relational Compatibility 
involves the aspects and attributes of a relationship, whether casual or intimate.-->
</p>
<h3 style="text-align:center">
<%= strTextRelationalCompatibility %> <!--Relational Compatibility-->
</h3>
<div align="center"><!--#Include FILE="relationshipcompatibility.asp" --></div>
<p>
<%= strTextNextLetsLookAtTaskCompatibilit %> <!--Next, let's look at Task Compatibility. Some combinations that rank low on Relational 
Compatibility have excellent Task Compatibility. You may work extremely well on a 
project with someone that you might not want to take on vacation!-->
</p>
<h3 style="text-align:center">
<%= strTextTaskCompatibility %> <!--Task Compatibility-->
</h3>

<div align="center"><!--#Include FILE="taskcompatibility.asp" --></div>

	<p>
	<%= strTextNoticeAlsoThatTheseAreTendenci %> <!--Notice also that these are tendencies or potential compatibilities. They aren't 
rules for behavior, and people find many ways to adapt and compensate to offset 
the potential for conflict.-->
	</p>
	<p>
	<%= strTextTheNextFewPagesWillProvideYouW %> <!--The next few pages will provide you with tools and exercises to help you 
communicate with people of different temperaments. Now that you know how to 
identify other styles and have seen how they work together, you can learn a 
strategy for communicating with people of each style.-->
	</p>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h1>
<%= strTextWhatDifferentStylesLookForInem %> <!--What Different Styles Look for in <em>Communication</em>-->
</h1>
<table WIDTH="100%" class="with-border" CELLSPACING="0" CELLPADDING="2">
	<tr>
		<td height="350px" width="50%" class="with-border">
			<div style="position: relative; height: 100%;"> 
				<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;
								font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
					D
				</div>
				<div style="LEFT: 30px; POSITION: absolute; TOP: 30px; Z-Index:100">
					<!-- D Content -->
					<ul>
						<li><%= strTextBrevity %><!--Brevity-->
						<li><%= strTextCommandOfTheSubject %><!--Command of the subject-->
						<li><%= strTextLogicalOrganization %><!--Logical organization-->
						<li><%= strTextBottomLine %><!--Bottom line-->
						<li><%= strTextBenefitsStatedEarly %><!--Benefits stated early-->
						<li><%= strTextPresentationOfOptions %><!--Presentation of options-->
						<li><%= strTextInnovation %><!--Innovation-->
						<li><%= strTextAuthority %><!--Authority-->
						<li><%= strTextBusinesslikeAttitude %><!--Businesslike attitude-->
						<li><%= strTextEfficientUseOfTimeinPresentati %><!--Efficient use of time (in presentation, meetings)-->
						<li><%= strTextCompetenceAndSelfconfidence %><!--Competence and self-confidence-->
						<li><%= strTextFocusOnResults %><!--Focus on results-->
						<li><%= strTextLogic %><!--Logic--></li>
					</ul>
				</div>
			</div>
		</td>
		<td height="350px" width="50%" class="with-border">
			<div style="position: relative; height: 100%;"> 
				<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;
								font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
					I
				</div>
				<div style="LEFT: 30px; POSITION: absolute; TOP: 30px; Z-Index:100">
					<!-- I Content -->
					<ul>
						<li><%= strTextEnthusiasm %><!--Enthusiasm-->
						<li><%= strTextCreativity %><!--Creativity-->
						<li><%= strTextHighenergyFriendlyTone %><!--High-energy, friendly tone-->
						<li><%= strTextOpportunityForLotsOfFeedback %><!--Opportunity for lots of feedback-->
						<li><%= strTextClearPresentationOfRewardsAndB %><!--Clear presentation of rewards and benefits-->
						<li><%= strTextBenefitsTiedToPersonalRecognit %><!--Benefits tied to personal recognition-->
						<li><%= strTextHumor %><!--Humor-->
						<li><%= strTextRelaxedAttitudeTowardTime %><!--Relaxed attitude toward time-->
						<li><%= strTextAttentiongrabbingDelivery %><!--Attention-grabbing delivery-->
						<li><%= strTextPresentsBigPicture %><!--Presents big picture-->
						<li><%= strTextReferencesToOthersReaction %><!--References to others reaction-->
						<li><%= strTextHighlyVisualApproach %><!--Highly Visual Approach-->
						<li><%= strTextLotsOfPersonalAnecdotesstories %><!--Lots of personal anecdotes/stories-->
						<li><%= strTextAppealsToTheHighIsNeedToBeInTh %><!--Appeals to the High I's need to be in the spotlight--></li>
					</ul>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td height="400px" width="50%" class="with-border">
			<div style="position: relative; height: 100%;"> 
				<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;
								font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
					C
				</div>
				<div style="LEFT: 30px; POSITION: absolute; TOP: 30px; Z-Index:100">
					<!-- C Content -->
					<ul>
						<li><%= strTextFactsAndData %><!--Facts and data-->
						<li><%= strTextPlentyOfTimeAndInformationToEx %><!--Plenty of time and information to examine and evaluate-->
						<li><%= strTextReassurance %><!--Reassurance-->
						<li><%= strTextClearAssessmentOfRisk %><!--Clear assessment of risk-->
						<li><%= strTextHighQualityCommunicationwritte %><!--High quality communication (written and spoken)-->
						<li><%= strTextPersonalAttention %><!--Personal attention-->
						<li><%= strTextClearDescriptionOfProcesses %><!--Clear description of processes-->
						<li><%= strTextAppealsToPrinciples %><!--Appeals to principles-->
						<li><%= strTextTheRightOrBestAnswer %><!--The right or best answer-->
						<li><%= strTextAppealsToExcellenceAccuracyDeta %><!--Appeals to excellence, accuracy, detail, quality-->
						<li><%= strTextLogicalDetailedPresentationOfI %><!--Logical, detailed presentation of ideas-->
						<li><%= strTextClearProceduresGuidelinesSpeci %><!--Clear procedures, guidelines, specifications-->
						<li><%= strTextPreciseChoiceOfWords %><!--Precise choice of words-->
						<li><%= strTextExactFigures %><!--Exact figures-->
						<li><%= strTextExactJobDescription %><!--Exact job description-->
						<li><%= strTextTheRightOrBestAnswer %><!--The right or best answer--></li>
					</ul>
				</div>
			</div>
		</td>
		<td height="400px" width="50%" class="with-border">
			<div style="position: relative; height: 100%;"> 
				<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;
								font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
					S
				</div>
				<div style="LEFT: 30px; POSITION: absolute; TOP: 30px; Z-Index:100">
					<!-- S Content -->
					<ul>
						<li><%= strTextSincereTone %><!--Sincere tone-->
						<li><%= strTextTraditionalLowkeyPresentation %><!--Traditional, low-key presentation-->
						<li><%= strTextNewIdeasTiedToOldMethods %><!--New ideas tied to old methods-->
						<li><%= strTextLogicFactsAndStructure1234 %><!--Logic, facts, and structure-->
						<li><%= strTextHighlySpecializedApproach %><!--Highly specialized approach-->
						<li><%= strTextGuaranteesAndAssurances %><!--Guarantees and assurances-->
						<li><%= strTextOrganizedToShowClearlyHowCompo %><!--Organized to show clearly how components and ideas work together-->
						<li><%= strTextAffirmationFromOthers %><!--Affirmation from others-->
						<li><%= strTextAssuranceOfSupport %><!--Assurance of support-->
						<li><%= strTextEmphasisOnBenefitsAsTheyRelate %><!--Emphasis on benefits as they relate to the most people-->
						<li><%= strTextAbsenceOfControversy %><!--Absence of controversy-->
						<li><%= strTextPersonalAsWellAsBusinessRelati %><!--Personal as well as business relationship-->
						<li><%= strTextAppealsToTheHighSsNeedForSecur %><!--Appeals to the High S's need for security and stability--></li>
					</ul>
				</div>
			</div>
		</td>
	</tr>
</table>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h2>
<%= strTextCommunicationStrategyWithAHigh %><!--Communication Strategy With a High D...-->
</h2>

<h3>
<%= strTextToCommunicateBetterWithAHighDD %><!--To communicate better with a High D do-->…
</h3>

<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><span class="boxed">q</span></td>
		<td><%= strTextProvideDirectAnswersAndBeBrief %><!--Provide direct answers and be brief and to the point.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextStressWhatHasToBeDoneNotWhyItH %><!--Stress what has to be done, not why it has to be done.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextStressResults1 %><!--Stress results.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextProvideOptionsAndPossibilities1 %><!--Provide options and possibilities.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextEmphasizeLogicOfIdeasAndApproa %><!--Emphasize logic of ideas and approaches.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextAgreeWithTheFactsPositionOrIde %><!--Agree with the facts, position, or idea&#151;not just the person.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextAvoidRambling %><!--Avoid rambling.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextSummarizeAndClose %><!--Summarize and close--></td>
	</tr>
</table>


<h3>
<%= strTextToCommunicateBetterWithAHighDDo %><!--To communicate better with a High D don't-->…
</h3>


<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextAppearIndecisive %><!--Appear indecisive.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeProblemoriented1234 %><!--Be problem-oriented.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeOverlyFriendly %><!--Be overly friendly.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextGeneralize %><!--Generalize.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextProvideTooManyDetails %><!--Provide too many details.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextRepeatYourselfOrTalkTooMuch %><!--Repeat yourself or talk too much.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextMakeUnsupportableStatements %><!--Make unsupportable statements.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextMakeDecisionsForThem %><!--Make decisions for them.--></td>
	</tr>
</table>

<h3>
<%= strTextAshighDsHearAndAnalyzeInformat %><!--As  High D's hear and analyze information, they may-->…
</h3>

<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextNotConsiderRisks %><!--Not consider risks.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextNotWeighProsAndCons %><!--Not weigh pros and cons.--></td>
	</tr>
</table>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h2>
<%= strTextCommunicationStrategyWithAHighI %><!--Communication Strategy With a High I...-->
</h2>
<h3>
<%= strTextToCommunicateBetterWithAHighID %><!--To communicate better with a High I do-->…
</h3>

<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextStressTheNewTheSpecialAndTheNo %><!--Stress the new, the special, and the novel.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextDemonstrateTheAbilityToBeArtic %><!--Demonstrate the ability to be articulate.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextStressTestimoniesOrFeedbackFro %><!--Stress testimonies or feedback from &quot;experts.&quot;--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextProvideOpportunityForGiveAndTa %><!--Provide opportunity for give and take.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeOpenFriendlyAndWarm %><!--Be open, friendly, and warm.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeEnthusiastic %><!--Be enthusiastic.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextListenAttentively %><!--Listen attentively.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextSpendTimeDevelopingTheRelation %><!--Spend time developing the relationship.--></td>
	</tr>
</table>


<h3>
<%= strTextToCommunicateBetterWithAHighIDo %><!--To communicate better with a High I don't-->…
</h3>

<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextIgnoreTheSocialDimensions %><!--Ignore the social dimensions.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextDoAllTheTalking %><!--Do all the talking.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextRestrictSuggestionsOrInterrupt %><!--Restrict suggestions or interruptions.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextLetHimOrHerTakeYouTooFarOffTra %><!--Let him or her take you too far off track.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeCurtColdOrTightlipped %><!--Be curt, cold, or tight-lipped.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextTalkDownToThem %><!--Talk down to them.--></td>
	</tr>
</table>

<h3>
<%= strTextAsHighIsHearAndAnalyzeInformat %><!--As  High I's hear and analyze information, they may-->…
</h3>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextNotConcentrate %><!--Not concentrate.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextIgnoreImportantFacts %><!--Ignore important facts.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextInterrupt %><!--Interrupt.--></td>
	</tr>
</table>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h2>
	<%= strTextCommunicationStrategyWithAHighS %><!--Communication Strategy With a High S...-->
</h2>
<h3>
	<%= strTextToCommunicateBetterWithAHighSD %><!--To communicate better with a High S do-->…
</h3>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextUsePatienceInDrawingOutHisherG %><!--Use patience in drawing out his/her goals.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextEmphasizeHowADeliberateApproac %><!--Emphasize how a deliberate approach will work.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextTalkServiceAndDependability %><!--Talk service and dependability.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextAskHowQuestionsAndGetFeedback %><!--Ask how questions and get feedback.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextListenAttentively %><!--Listen attentively.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeSincere %><!--Be sincere.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextCommunicateInALowkeyRelaxedMan %><!--Communicate in a low-key, relaxed manner.--></td>
	</tr>
</table>

<h3>
	<%= strTextToCommunicateBetterWithAHighSDo %><!--To communicate better with a High S don't-->…
</h3>

<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeTooDirective %><!--Be too directive.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextPushTooAggressivelyOrDemand %><!--Push too aggressively or demand.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextMoveTooFast %><!--Move too fast.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextOmitTooManyDetails %><!--Omit too many details.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeAbrupt %><!--Be abrupt.--></td>
	</tr>
</table>

<h3>
	<%= strTextAsHighSsHearAndAnalyzeInformat %><!--As  High S's hear and analyze information, they may-->…
</h3>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeQuietlyUnyielding %><!--Be quietly unyielding.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextNotBeAssertiveInCommunicatingT %><!--Not be assertive in communicating their concerns.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextNotProvideALotOfFeedbackDuring %><!--Not provide a lot of feedback during presentations.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextHesitateToMakeADecisionParticu %><!--Hesitate to make a decision, particularly if unpopular.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextSlowDownTheAction %><!--Slow down the action.--></td>
	</tr>
</table>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h2>
	<%= strTextCommunicationStrategyWithAHighC %><!--Communication Strategy With a High C...-->
</h2>

<h3>
	<%= strTextToCommunicateBetterWithAHighCD %><!--To communicate better with a High C do-->…
</h3>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextUseComparativeData %><!--Use comparative data.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextAppealToLogicShowingFactsAndBe %><!--Appeal to logic, showing facts and benefits.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextConcentrateOnSpecifics %><!--Concentrate on specifics.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextHaveAllTheFactsAndStickToThem %><!--Have all the facts, and stick to them.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeOrganized %><!--Be organized.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextProvideWrittenProposalsForMajorDe %><!--Provide written proposals for major decisions.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextAppealToInterestInResearchStat %><!--Appeal to interest in research, statistics, etc.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextProvideDetailedResponsesToQues %><!--Provide detailed responses to questions.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextDealFullyWithObjections %><!--Deal fully with objections.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextStressQualityReliabilityAndSec %><!--Stress quality, reliability, and security.--></td>
	</tr>
</table>

<h3>
	<%= strTextToCommunicateBetterWithAHighCDo %><!--To communicate better with a High C don't-->…
</h3>

<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeVagueOrCasualParticularlyWhe %><!--Be vague or casual, particularly when answering questions.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextMoveToTheBottomLineTooQuickly %><!--Move to the bottom line too quickly.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextGetPersonalAboutFamilyIfYouDont %><!--Get personal about family if you don't know him/her well.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextPatThemOnTheBackOrOtherwiseBeT %><!--Pat them on the back or otherwise be too familiar.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextSpeakTooLoudly %><!--Speak too loudly.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextThreatenCajoleWheedleOrCoax %><!--Threaten, cajole, wheedle, or coax.--></td>
	</tr>
</table>
<h3>
	<%= strTextAshighCsHearAndAnalyzeInformat %><!--As  High C's hear and analyze information, they may-->…
</h3>
<table BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td WIDTH="5%"><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBeTooConservativeAndCautious %><!--Be too conservative and cautious.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBogDownInTheCollectionProcess %><!--Bog down in the collection process.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextBecomeBuriedInDetail %><!--Become buried in detail.--></td>
	</tr>
	<tr>
		<td><SPAN class=boxed>q</SPAN></td>
		<td><%= strTextDelayOrAvoidDecisionsParticula %><!--Delay or avoid decisions, particularly if risky.--></td>
	</tr>
</table>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<h1>
<%= strTextWhenTheHeatIsOnCommunicationUn %> <!--When the Heat is On: Communication Under Stress-->
</h1>

<p><%= strTextCommunicationChallengingAtBest %> <!--Communication, challenging at best, becomes even more complex in our highly 
charged workplaces when tempers flare, fatigue sets in, and people resist or resent the 
message. Indeed, the most challenging communication situations occur in instances 
that involve conflict or that require delivering and receiving unwelcome information when 
things aren't going well. A rise in stress levels introduces an interesting dimension to 
temperament that we call stress behavior. People with similar temperaments tend to 
behave alike in those situations in which we find ourselves &quot;at the end of 
our rope,&quot; feeling as though we just can't take it anymore.-->
</p>
<p>
<%= strTextInThePdiInstrumentWeIntroducedA %> <!--In the PDI Instrument we introduced a model that explained DISC theory. The High D's 
and I's are active/assertive in nature. They tend to shape their environments to better 
suit their needs and expectations. The High S's and C's are more responsive/ 
accommodating in nature. Their standards are not any lower, but they tend to accept 
their environment the way it is and respond appropriately within that context.
Because D's and I's tend to see themselves as able to shape the environment, their 
initial response to conflict and stress is assertive&#151; &quot;We missed that deadline. I won't 
accept that behavior from anyone!&quot; The S's and C's tend to see themselves as needing 
to work within the existing environment and therefore are initially more responsive, 
cautious, and accommodating in conflict and stress. They tend to pull back and may be 
slower to make decisions or take action.-->
</p>
<p>
<%= strTextNoticeWeDescribedTheAboveBehav %> <!--Notice we described the above behavior with the qualifier &quot;initial.&quot; An interesting 
phenomenon occurs under sustained conflict and stress. If the conflict is not quickly 
resolved and the stress continues unabated, people tend to move into an alternate or 
reserve style of behavior. For example, the High D may initially become demanding 
(dictatorial and perhaps even tyrannical), but under sustained conflict will move to 
detachment. -->
<p>
</p>
<%= strTextUnderStressTheHighIWillInitial %> <!--Under stress, the High I will initially go on the attack. They can really zing you with their 
verbal skills, often using sarcasm or exaggeration to alleviate their frustration. However, 
if the stress increases and victory looks uncertain, the need for social approval will win 
out and the High I will often agree in order to maintain your positive feelings about him 
or her.-->
<P></P>
<p>
<%= strTextTheHighSsNormallyAgreeableDisp %> <!--The High S's normally agreeable disposition will not prepare others for what's boiling 
beneath the surface. If a High S reaches secondary stress levels, he or she may 
demonstrate attacking behavior, sending everyone running for cover.-->
</p>
<p>
<%= strTextHighCsWillInitiallyDealWithStr %> <!--High C's will initially deal with stress by detaching, perhaps by withdrawing and working 
in a solitary setting, but as stress moves to the next level, they will cling more 
tenaciously to their position and their resolve becomes demanding. Rigidity is the order 
of the day. It's &quot;by the book&quot; at all costs.-->
</p>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<p>
	<%= strTextTheTableBelowShowsTheInitialAn %><!--The table below shows the initial and alternative style under stress for each of the four 
	temperaments.-->
</p>

<table WIDTH="75%" BORDER="0" CELLSPACING="5" CELLPADDING="1">
	<tr>
		<td COLSPAN="3" ALIGN="center"><font size="2"><strong><%= strTextInitialStressResponse %><!--Initial Stress Response--></strong></font></td>
		<td COLSPAN="2" ALIGN="center"><font size="2"><strong><%= strTextAlternativeStressResponse %><!--Alternative Stress Response--></strong></font></td>
	</tr>
	<tr>
		<td><font size="4"><strong>D</strong></font></td>
		<td><font size="3"><%= strTextDemands %><!--Demands--></font></td>
		<td><font size="2"><%= strTextMessagequotwhatDoYouMeanWeDont %><!--Message: &quot;What do you mean we don't have the budget to complete my project? No way will I accept that.&quot;--></font></td>
		<td><font size="3"><%= strTextDetaches %><!--Detaches--></font></td>
		<td><font size="2"><%= strTextMessagequotiDontHaveTimeToBoth %><!--Message: &quot;I don't have time to bother with this. I have bigger issues to be concerned with.&quot;--></font></td>
	</tr>
	<tr>
		<td><font size="4"><strong>I</strong></font></td>
		<td><font size="3"><%= strTextAttacks %><!--Attacks--></font></td>
		<td><font size="2"><%= strTextMessagequotimNotAboutToGoToThe %><!--Message: &quot;I'm not about to go to the board with this absurd proposal. We'll get killed if we present it this way.&quot;--></font></td>
		<td><font size="3"><%= strTextAgrees %><!--Agrees--></font></td>
		<td><font size="2"><%= strTextMessagequotokayWellTryItYourWa %><!--Message: &quot;Okay, we'll try it your way. But don't forget that I warned you.&quot;--></font></td>
	</tr>
	<tr>
		<td><font size="4"><strong>S</strong></font></td>
		<td><font size="3"><%= strTextAgrees %><!--Agrees--></font></td>
		<td><font size="2"><%= strTextMessagequotiKnowYouveBeenSwamp %><!--Message: &quot;I know you've been swamped, or you wouldn't have missed that critical deadline.&quot;--></font></td>
		<td><font size="3"><%= strTextAttacks %><!--Attacks--></font></td>
		<td><font size="2"><%= strTextMessagequotyouveTakenAdvantage %><!--Message: &quot;You've taken advantage of my good nature for the last time!&quot;--></font></td>
	</tr>
	<tr>
		<td><font size="4"><strong>C</strong></font></td>
		<td><font size="3"><%= strTextDetaches %><!--Detaches--></font></td>
		<td><font size="2"><%= strTextMessagequotiJustDontHaveTimeTo %><!--Message: &quot;I just don't have time to consider your request. I have too much on my plate as it is.&quot;--></font></td>
		<td><font size="3"><%= strTextDemands %><!--Demands--></font></td>
		<td><font size="2"><%= strTextMessagequotifIBendTheRulesForY %><!--Message: &quot;If I bend the rules for you, I'll have to bend them for everyone, and that's not going to happen. We'll stick to procedure.&quot;--></font></td>
	</tr>
</table>

<p>
	<%= strTextConflictIsNotTheOnlyCauseOfStre %><!--Conflict is not the only cause of stress. Getting ready for the big interview or 
	presentation, conducting an unfavorable performance review, rolling out a new ad 
	campaign or logo, or even getting that big promotion can produce stress.-->
</p>

<p>
	<%= strTextBelowIsAListOfMoreSourcesOfStre %><!--Below is a list of more sources of stress for your temperament. Check the items you 
	have found create stress for you and add additional items if relevant.-->
</p>

<% If UCase(HighType1) = "D" Then %>
	<!-- #Include File = "AppModuleCommunicating_style_es_d.asp" -->
<% ElseIf UCase(HighType1) = "I" Then %>
	<!-- #Include File = "AppModuleCommunicating_style_es_i.asp" -->
<% ElseIf UCase(HighType1) = "S" Then %>
	<!-- #Include File = "AppModuleCommunicating_style_es_s.asp" -->
<% ElseIf UCase(HighType1) = "C" Then %>
	<!-- #Include File = "AppModuleCommunicating_style_es_c.asp" -->
<% End If %>

	<h3>
		<%= strTextReactingToStress %><!--Reacting to Stress-->
	</h3>

<p>
	<%= strTextInMostCasesTheFourTemperaments %><!--In most cases, the four temperaments react to stress in the following ways. Take the 
	following steps to identify stress behaviors in yourself and others:-->
</p>

<ol>
	<li>
		<%= strTextReadThroughTheListForYourTempe %><!--Read through the list for your temperament and check the items you believe 
		describe your behavior under stress. Add additional behaviors you believe are 
		descriptive if not Included in the list.--><br><br>
	</li>
	<li>
		<%= strTextThinkOfSomeoneYouKnowWellWhoHa %><!--Think of someone you know well who has a different behavioral style. How would 
		you describe his/her behavior under stress? Again, check the behaviors on the 
		list for his/her temperament below. List additional behaviors if relevant.-->
	</li>
</ol>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
																											
		<h2>
		<%= strTextTheHighDUnderStress %> <!-- The High D Under Stress -->
		</h2>
		<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextCanBecomeVeryControlling %><!--Can become very controlling--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextTriesEvenHarderToImposeWillOnO %><!--Tries even harder to impose will on others--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextAssertsSelfWithBodyOrLanguageM %><!--Asserts self with body or language, may invade &quot;personal space&quot; or point fingers--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextMayDemonstrateStonySilenceOrGe %><!--May demonstrate stony silence or get very vocal, raising volume and energy level--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextBecomesEvenLessWillingToCompro %><!--Becomes even less willing to compromise--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextPullsRankOnThoseWithLessPower %><!--Pulls rank on those with less power--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextIfStressProducesConflictGetsOv %><!--If stress produces conflict, gets over it quickly--></font></td>
			</tr>
		</table>
		
		<h2>
		<%= strTextTheHighIUnderStress %> <!--The High I Under Stress-->
		</h2>
		
		<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextFocusesFrustrationsOnOtherPeop %><!--Focuses frustrations on other people--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextBlamesOthers %><!--Blames others--></font>
				</td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextCanBecomeEmotionalEvenToThePoi %><!--Can become emotional even to the point of shouting, making extreme statements, or gesturing belligerently--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextMakesWoundingSarcasticRemarks %><!--Makes wounding, sarcastic remarks--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextAttemptsToControlOthersThrough %><!--Attempts to control others through words and emotion--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextIfStressProducesConflictGetsOve %><!--If stress produces conflict, gets over it quickly and will go out of their way to make things right--></font></td>
			</tr>
		</table>
		
		<h2>
		<%= strTextTheHighSUnderStress %> <!--The High S Under Stress-->
		</h2>
	
		<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextVoiceFacialExpressionsAndGestu %><!--Voice, facial expressions, and gestures become mechanical and perfunctory--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextMayLackCommitmentEvenThoughVoi %><!--May lack commitment even though voicing agreement--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextCanBePassiveAggressiveIeUninvo %><!--Can be passive aggressive, i.e., uninvolvement, silence, or lack of expression--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextOftenCompliesRatherThanCoopera %><!--Often complies rather than cooperates, producing minimal results--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextIfStressProducesConflictIsSome %><!--If stress produces conflict, is sometimes slow to forgive and forget--></font></td>
			</tr>
		</table>
		
		<h2>
		<%= strTextTheHighCUnderStress %> <!--The High C Under Stress-->
		</h2>
		
		<table WIDTH="75%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextBecomesEvenLessResponsive %><!--Becomes even less responsive--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextLimitsVocalIntonationFacialExp %><!--Limits vocal intonation, facial expression, and gestures (which are normally limited) even further--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextWithdrawsEmotionally %><!--Withdraws emotionally--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextMayAvoidContactWithOthersIfCon %><!--May avoid contact with others if conflicts arise--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextMayBecomeHypersensitiveToWorkr %><!--May become hyper-sensitive to work-related criticisms--></font></td>
			</tr>
			<tr>
				<td vAlign=top><SPAN class=boxed>q</SPAN></td>
				<td><font size="2"><%= strTextMayAdoptAVictimizedAttitude %><!--May adopt a victimized attitude--></font></td>
			</tr>
		</table>
		
		<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			

	<h3>
	<%= strTextCommunicatingWhenYoureUnderStr %> <!--Communicating When You're Under Stress: How to Handle It-->
	</h3>

	
		
	<p><%= strTextWhenYoureUnderStressYouCanTake %> <!--When you're under stress, you can take certain steps to relieve the stress you feel and 
	its effects on others.--></p>
		
	<ul>
		<li>
		<%= strTextImproveYourAttitudeAndPerceptio %> <!--Improve your attitude and perceptions by creating support systems, alleviating stress 
		through humor, balancing work and play, talking it out, or seeking counseling if 
		necessary.--><br><br>
		</li>
		<li>
		<%= strTextIfAppropriateLearnANewSkillDis %> <!--If appropriate, learn a new skill, discuss your situation openly with peers, or just slow 
		down a bit.--><br><br>
		</li>
		<li>
		<%= strTextImproveYourPhysicalAbilityToCo %> <!--Improve your physical ability to cope by making sure that you get proper nutrition, 
		adequate rest, and regular exercise. --><br><br>
		</li>
		<li>
		<%= strTextCreateALessStressfulEnvironmen %> <!--Create a less stressful environment by structuring time off from work, ceasing to 
		attend certain meetings, taking a class you enjoy, or possibly changing jobs or 
		vocation.-->
		</li>
	</ul>
	
	
	<h3>
	<%= strTextCommunicatingWhenOthersAreUnde %> <!--Communicating When Others are Under Stress: How to Handle It-->
	</h3>

	<ul>
		<li>
		<%= strTextAcknowledgeThatSomeoneIsDemons %> <!--Acknowledge that someone is demonstrating stress behavior. People aren't always 
		going to be at their best; we all have rough days. The faster you determine that 
		someone's behavior is stress-related, the more effectively you can deal with the 
		situation.--><br><br>
		</li>
		<li>
		<%= strTextRecognizeTheEnvironmenteitherI %> <!--Recognize the environment (either internal or external) that is causing the stress. If 
		you are causing or contributing to that stress, evaluate what you can change and 
		what you can't. Many times we know if someone is on deadline or under the gun to 
		make a quota. It's harder to pinpoint when stress is coming from someone's 
		personal life, since we may not know a lot about that person away from the office. 
		Take responsibility to look for clues that may give you an idea of the cause, and give 
		people the benefit of the doubt, at least initially.--><br><br>
		</li>
		<li>
		<%= strTextTryToKeepFromReactingInKindMan %> <!--Try to keep from reacting in kind. Many times, someone's behavior can be so 
		unpleasant that we begin to demonstrate our own stress behavior. Keep your focus 
		on the stress that is causing this behavior, and find ways to alleviate it, if possible. 
		For example, if the person seems unable to deal with one more problem, delay 
		telling her about the unhappy customer who called to complain. --><br><br>
		</li>
		<li>
		<%= strTextIfPossibleAvoidDoingImportantB %> <!--If possible, avoid doing important business with someone who is exhibiting stress 
		behavior. Wait until the person's stress level is lower and you can work under more 
		normal circumstances.-->
		</li>
	</ul>
	
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
		
		<h3>
		<%= strTextExercise %> <!--Exercise-->
		</h3>
		<p>
		<%= strTextThinkOfTheLastTimeYouWereInAStr %> <!--Think of the last time you were in a stressful situation at work. How did your behavior 
differ from your normal work-related behavior? -->
		</p>
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
		
		<p>
		<%= strTextHowDoTheBehaviorsOfSomeOfYourCo %> <!--How do the behaviors of some of your colleagues differ? What was most noticeable 
to you? -->
		</p>
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
		<p>
		<%= strTextWhatWasTheEffectOnRelationship %> <!--What was the effect on relationships and productivity?-->
		</p>
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
		<p>
		<%= strTextWhenTheStressSubsidedWhatChang %> <!--When the stress subsided, what changes took place in the workplace?-->
		</p>
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
	
<p>
<%= strTextWhatCanYouDoToImproveTheSituat %> <!--What can you do to improve the situation the next time stress occurs?-->
</p>
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
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h2>
	<%= strTextActionPlanningWhenCommunicatin %><!--Action Planning: When Communicating with a High D-->
</h2>

<p>
	<%=UserName1%>, <%= strTextNowThatYoureMoreAwareOfWhatOth %><!--now that you're more aware of what other styles need from you (and what you 
	need from other styles), try your hand at some dialogue with coworkers of different 
	styles to apply your knowledge to real world situations.-->
</p>
<p>
<%= strTextWhenWeCommunicateWhatAreTheThr %><!--When we communicate, what are the three main things you need from me?-->
</p>
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

<p>
<%= strTextGivenMyPersonalStyleWhatDoYouT %><!--Given my personal style, what do you think I need from you in communication? 
(Then you can affirm or modify the answers.)-->
</p>
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

<p>
<%= strTextWhatAspectOfOurCommunicationSt %><!--What aspect of our communication styles could create conflict, particularly in 
stressful situations?-->
</p>
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

<p>
<%= strTextWhatMajorChangeDoINeedToMakeTo %><!--What major change do I need to make to adapt my style when communicating with you?-->
</p>
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

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h2>
	<%= strTextActionPlanningWhenCommunicating %><!--Action Planning: When Communicating with a High I-->
</h2>

<p>
	<%=UserName1%>, <%= strTextNowThatYoureMoreAwareOfWhatOth %><!--now that you're more aware of what other styles need from you (and what you 
	need from other styles), try your hand at some dialogue with coworkers of different 
	styles to apply your knowledge to real world situations.-->
</p>
<p>
<%= strTextWhenWeCommunicateWhatAreTheThr %><!--When we communicate, what are the three main things you need from me?-->
</p>
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

<p>
<%= strTextGivenMyPersonalStyleWhatDoYouTh %><!--Given my personal style, what do you think I need from you in communication? 
(Then you can affirm or modify the answers.)-->
</p>
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

<p>
<%= strTextWhatAspectOfOurCommunicationSt %><!--What aspect of our communication styles could create conflict, particularly in 
stressful situations?-->
</p>
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

<p>
<%= strTextWhatMajorChangeDoINeedToMakeTo %><!--What major change do I need to make to adapt my style when communicating with you?-->
</p>
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

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h2>
	<%= strTextActionPlanningWhenCommunicatingW %><!--Action Planning: When Communicating with a High S-->
</h2>

<p>
	<%=UserName1%>, <%= strTextNowThatYoureMoreAwareOfWhatOth %><!--now that you're more aware of what other styles need from you (and what you 
	need from other styles), try your hand at some dialogue with coworkers of different 
	styles to apply your knowledge to real world situations.-->
</p>
<p> 
<%= strTextWhenWeCommunicateWhatAreTheThr %><!--When we communicate, what are the three main things you need from me?-->
</p>
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
<P></P>
<p>
<%= strTextGivenMyPersonalStyleWhatDoYouT %><!--Given my personal style, what do you think I need from you in communication? 
(Then you can affirm or modify the answers.)-->
</p>
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
<p>
<%= strTextWhatAspectOfOurCommunicationSt %><!--What aspect of our communication styles could create conflict, particularly in 
stressful situations?-->
</p>
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
<p>
<%= strTextWhatMajorChangeDoINeedToMakeTo %><!--What major change do I need to make to adapt my style when communicating with you?-->
</p>
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

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h2>
	<%= strTextActionPlanningWhenCommunicatingWi %><!--Action Planning: When Communicating with a High C-->
</h2>

<p>
	<%=UserName1%>, <%= strTextNowThatYoureMoreAwareOfWhatOth %><!--now that you're more aware of what other styles need from you (and what you 
	need from other styles), try your hand at some dialogue with coworkers of different 
	styles to apply your knowledge to real world situations.-->
</p>
 
<p> 
<%= strTextWhenWeCommunicateWhatAreTheThr %><!--When we communicate, what are the three main things you need from me?-->
</p>
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

<p> 
<%= strTextGivenMyPersonalStyleWhatDoYouT %><!--Given my personal style, what do you think I need from you in communication? 
(Then you can affirm or modify the answers.)-->
</p>
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
<p> 
<%= strTextWhatAspectOfOurCommunicationSt %><!--What aspect of our communication styles could create conflict, particularly in 
stressful situations?-->
</p>
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
<p> 
<%= strTextWhatMajorChangeDoINeedToMakeTo %><!--What major change do I need to make to adapt my style when communicating with you?-->
</p>
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

 <DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
				
				<p>
				<%= strTextThestrongdiscProfileSystemstro %> <!--The <strong>DISC Profile System®</strong> is a family of instruments and workbooks designed specifically to increase 
understanding of yourself and others to achieve greater personal and interpersonal effectiveness.-->
				</p>
				<p>
				<%= strTextThestrongpersonalDiscernmentIn %> <!--The <strong>Personal DISCernment® Inventory</strong>, the basic module, provides a unique insight into your 
temperament, producing both a general and a detailed description of your behavioral style. This 
instrument also allows you to develop a comprehensive list of your strengths and weaknesses.-->
				</p>
				<p>
				<%= strTextThestrongdiscProfileSystemstron %> <!--The <strong>DISC Profile® System</strong> Includes a series of application modules that will guide you in applying these 
insights to specific situations. The module workbooks provide additional information each behavioral style 
as it relates to that arena and suggest how you may apply this information to yourself and your 
teammates.-->
				</p>
				<h1>
				<%= strTextFiveApplicationModulesAreAvaila %> <!--Five application modules are available:-->
				</h1>
				<h3>
				<%= strTextTeamworkWithStyle %> <!--Teamwork with Style-->
				</h3>
				<p>
				<%= strTextEachTemperamentBringsUniqueStr %> <!--Each temperament brings unique strengths and weaknesses to the team setting. Your behavioral 
style influences the way you plan and organize your work, communicate and make decisions. 
This workbook will provide the opportunity for you to identify, explore, and discuss the effects of 
the individual behavioral styles on your team. The result will be enhanced understanding of how 
to build on individual differences for greater team effectiveness.-->
				</p>
				<h3>
				<%= strTextLeadingWithStyle %> <!--Leading with Style-->
				</h3>
				<p>
				<%= strTextOurBehavioralTraitsAreNotOnlyA %> <!--Our behavioral traits are not only a major influence on our leadership style, but also provide the 
template through which we view the leadership of others. When we are led by those with different 
behavioral styles from our own, we have a tendency to feel overled. Understanding these 
differences will not only help you to better serve those you lead, but also help you to better 
respond to the leadership of others.-->
				</p>
				<h3>
				<%= strTextCommunicatingWithStyle %> <!--Communicating with Style-->
				</h3>
				<p>
				<%= strTextThisModuleWillHelpYouRecognizeHow %> <!--This module will help you recognize how your personal communication style enhances or 
impedes the messages that you send to others. In addition, you will learn to identify the styles of 
those receiving your message, and discover ways to adapt your style to meet their needs. As a 
result, you will greatly improve the effectiveness of your written and spoken communication in a 
variety of situations.-->
				</p>
				<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
					
					<h3>
					<%= strTextSellingWithStyle %> <!--Selling with Style-->
					</h3>
					<p>
					<%= strTextBehavioralStyleNotOnlyInfluencesHow %> <!--Behavioral style not only influences how we persuade or convince others, but how we ourselves 
are persuaded. This module, designed for the sales environment, provides insights into the 
strengths and weaknesses of each behavioral style as we attempt to communicate with and 
convince others. You will also discover how different temperaments receive and respond to such 
overtures. These insights can greatly increase your effectiveness in communicating a point of 
view, as well as understanding and meeting the needs of others.-->
					</p>
					<h3>
					<%= strTextTimeManagementWithStyle %> <!--Time Management with Style-->
					</h3>
					<p>
					<%= strTextOurPersonalitiesOftenDetermineOur %> <!--Our personalities often determine our attitudes toward time: how we respond to time constraints, 
how we discipline ourselves, how much energy we have to get things done, and how we view 
deadlines. This workbook outlines each behavioral style's response to the various aspects of time 
and personal management.-->
					</p>
					<p>
					<%= strTextForMoreInformationCallTeamReso %> <!--For more information call Team Resources at 1.800.214.3917 or visit our website: www.teamresources.com-->
					</p>
					</div>
	</body>
</HTML>
