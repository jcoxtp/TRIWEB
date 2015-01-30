<%@ Language=VBScript %>
<% intPageID = 67 %>
<!--#Include virtual="/pdi/Include/common.asp" -->
<html>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link rel="stylesheet" href="AppModStyle.css" type="text/css">
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
	Dim strTemp
	
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
		<TD COLSPAN=4><IMG SRC="images/<%=strLanguageCode%>/teamwork_pdf_cover_05.gif" WIDTH=612 HEIGHT=126 ALT=""></TD>
	</TR>
	<TR>
		<TD background="images/teamwork_pdf_cover_06.gif" WIDTH=612 HEIGHT=262 COLSPAN=4><%=UserName%><br><%=TestDate%></TD>
	</TR>
	<TR>
		<TD COLSPAN=2><IMG SRC="images/<%=strLanguageCode%>/PDICover.gif" WIDTH=124 HEIGHT=79 ALT=""></TD>
		<TD COLSPAN=2><IMG SRC="images/teamwork_pdf_cover_08.gif" WIDTH=488 HEIGHT=79 ALT=""></TD>
	</TR>
	<TR>
		<TD><IMG SRC="images/spacer.gif" WIDTH=37 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=87 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=320 HEIGHT=1 ALT=""></TD>
		<TD><IMG SRC="images/spacer.gif" WIDTH=168 HEIGHT=1 ALT=""></TD>
	</TR>
</TABLE>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<div id="Content">


<!-- Beginning of PAGE 1 --------------------------------------------------------------------------------->
<h1>
<%= strTextTeamsThatWork %><!--Teams that Work-->
</h1>

<p>
<%= strTextWhenYouCompletedThePersonalDis %><!--When you completed the Personal DISCernment® Inventory, you identified the 
particular pattern that best reflects your behavioral tendencies.-->
</p>

<p>
<% 
   strTemp = Replace(strTextusername1BasedOnThequotcomposi, "{{UserName1}}", UserName1)
   strTemp = Replace(strTemp, "{{HighType1}}", HighType1)
%>
<%= strTemp %><!--<%=UserName1%>, based on the &quot;Composite Graph&quot; of your Personal DISCernment® Inventory, 
your predominant style is that of a high &quot;<%=HighType1%>&quot;.-->
</p>

<p>
	<% If NOT IsFakeResults then%>
		<img src="../disccompositesmall.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" align="left" hspace="12" v:shapes="_x0000_s1026">
	<% End If %>

<%= strTextThePersonalDiscernmentInventor %><!--The Personal DISCernment® Inventory measures four factors (D, I, S, and C) that 
influence behavioral styles. Although everyone has threads of all four factors woven into 
our basic temperament, most of us find that one or perhaps two of the factors express 
themselves more strongly than the others in our behavioral style. Each person's 
temperament is, in part, an expression of the way the four factors combine. For 
example, a High I who is also a fairly High D will approach things differently than a High 
I whose D is low.-->
<br><br>
<%= strTextHoweverInOrderToMaximizeUnders %><!--However, in order to maximize understanding and application in this module, we focus 
primarily on the &quot;pure&quot; types, considering only the tendencies we can expect from our 
most predominant factor. Although these are brief summaries, describing only a few of 
the elements that influence behavior in a given arena, even this level of understanding 
can greatly improve the way you relate to others.-->
</p>

<br><br>




<h3>
<%= strTextGroupVsTeam %><!--Group vs. Team-->
</h3>


<p>
<%= strTextChallengedOnEveryFrontByIntens %><!--Challenged on every front by intensified competition at home and abroad and increasing 
demands for quality and customer service, organizations around the world have 
undergone profound changes over the past several decades. Many companies have cut 
excess layers of management and staff, flattening their organizational structures to 
allow for increased efficiencies and agility. The demand for faster, higher-quality 
decisions requires more effective communication and better teamwork.-->
</p>

<p>
<%= strTextNewKindsOfPartnershipsAreFormi %><!--New kinds of partnerships are forming within and among organizations as more and 
more people realize that working with each other can be more advantageous to 
everyone, both collectively and individually, than competing against each other.-->
</p>

<p>
<%= strTextTodayMostOfUsWorkInAGroupSetti %><!--Today most of us work in a group setting in which we are dependent, at least to some 
degree, on the performance of others. But simply functioning as a group is not enough. 
Organizations are discovering that to achieve exceptional results, groups must become 
teams.-->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END of PAGE 1 --------------------------------------------------------------------------------------->

<!-- Beginning of PAGE 2 --------------------------------------------------------------------------------->
<p>
<%= strTextTeamworkIsCooperationAtItsHigh %><!--Teamwork is cooperation at its highest level. Effective teams produce outstanding 
results because of the synergistic effect. For a group, the results are additive: 1+1=2. 
For a team, however, the results are synergistic. In such cases, 1+1=3, 4, or even 5!-->
</p>



<h3>
<%= strTextTeamampTemperament %><!--Team &amp; Temperament-->
</h3>


<p>
<%= strTextIfTheBenefitsAreSoClearWhyDont %><!--If the benefits are so clear, why don't we see more teams and teamwork&#149; We encounter 
many pitfalls and barriers along the path to effective teamwork: misdirected competition, 
poor communication, interpersonal conflicts and antagonism, rejection, and resentment. 
Often we describe such tensions as personality conflicts. However, the difficulties arise 
not so much from several different personalities in conflict as from an ignorance of 
differences and dynamics between these personalities and the resulting behavioral 
styles.-->
</p>


<p>
<%= strTextRelationshipsAreKeyToTheSucces %><!--Relationships are key to the success of any organization. The more we know about 
ourselves and others, the better we can avoid pitfalls, leverage our strengths, and move 
into new levels of team effectiveness.-->
</p>

<p>
<%= strTextToFunctionAsAHighPerformanceTe %><!--To function as a high performance team, all members must know and appreciate the 
strengths and needs of  the other team members:-->
</p>

<ul>
<li> <%= strTextWhatMotivatesThem3 %><!--What motivates them--></li>
<li> <%= strTextHowDoWeBestCommunicateWithThem %><!--How do we best communicate with them--></li>
<li> <%= strTextWhatCreatesTensionBetweenUs %><!--What creates tension between us--></li>
<li> <%= strTextInWhatSituationsDoTheyWorkBest %><!--In what situations do they work best--></li>
<li> <%= strTextWhatAreTheStrengthsAndGiftsThe %><!--What are the strengths and gifts they bring to our team--></li>
</ul>


<h3>
<%= strTextTemperamentInfluencesTeams %><!--Temperament Influences Teams-->
</h3>


<p>
<%= strTextEachTemperamentBringsUniqueStre %><!--Each temperament brings unique strengths and weaknesses to the team setting. Our 
behavioral styles influence the way we plan and organize our work, communicate, and 
make decisions. In addition, people tend to behave differently in groups than they do 
individually. So along with the effect our individual behavioral styles have on a team 
effort, the interactions among the various members become major factors in a team's 
success or failure. This application module will give you an opportunity to identify, 
explore, and discuss the effects of individual behavioral styles on your team.-->
</p>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END of PAGE 2 --------------------------------------------------------------------------------------->

<!-- Beginning of PAGE 3 --------------------------------------------------------------------------------->

<h1>
<%= strTextTeamProfiles %><!--Team Profiles-->
</h1>


<p>
<%= strTextBelowWeProvideSpaceForEachTeam %><!--Below we provide space for each team member's pattern. Draw your pattern on the 
graph designated &quot;My Profile.&quot; Then exchange patterns with your team members, and 
reproduce their patterns in the remaining graphs. You will use this information later in 
this module. It will also provide an ongoing reference for better understanding your 
teammates. Depending on the size of your team, you may need to photocopy the Profile 
Sheet on the facing page in order to have sufficient space.-->
</p>


<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
	<tr>
		<td VALIGN="TOP" ALIGN="MIDDLE">
		<% If NOT IsFakeResults then%>
			<img src="../disccompositesmall.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>">
		<% Else%>
			<img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<% End If %>
		<br>
		<font size="2"><%= strTextMyProfile %><!--My Profile-->
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE">
		<img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br><%= strTextName %><!--Name-->:___________________<br><%= strTextPattern %><!--Pattern-->:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE">
		<img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br><%= strTextName %><!--Name-->:___________________<br><%= strTextPattern %><!--Pattern-->:__________________
		</td>
	</tr>
	<tr>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br><%= strTextName %><!--Name-->:___________________<br><%= strTextPattern %><!--Pattern-->:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br><%= strTextName %><!--Name-->:___________________<br><%= strTextPattern %><!--Pattern-->:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br><%= strTextName %><!--Name-->:___________________<br><%= strTextPattern %><!--Pattern-->:__________________
		</td>
	</tr>
	<tr>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br><%= strTextName %><!--Name-->:___________________<br><%= strTextPattern %><!--Pattern-->:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br><%= strTextName %><!--Name-->:___________________<br><%= strTextPattern %><!--Pattern-->:__________________
		</td>
		<td VALIGN="TOP" ALIGN="MIDDLE"><img SRC="images/composite_small.gif" WIDTH="89" HEIGHT="218">
		<font size="2"><br><br><%= strTextName %><!--Name-->:___________________<br><%= strTextPattern %><!--Pattern-->:__________________
		</td>
	</tr>
</table>





<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END of PAGE 3 --------------------------------------------------------------------------------------->

<!-- Beginning of PAGE 4 --------------------------------------------------------------------------------->
<h1>
<%= strTextIdentifyingTheStyleOfOthers %><!--Identifying the Style of Others-->
</h1>


<p>
<%= strTextToSuccessfullyAdaptOurOwnStyleT %><!--To successfully adapt our own style to better match the temperament of another person, 
we must first be able to identify the style of that individual. Obviously, we can't always 
administer the Personal DISCernment® Inventory (PDI), so how can we recognize the 
temperament of others&#149; One of the strengths of the PDI, as well as other DISC 
instruments, is that it deals largely with &quot;observable&quot; behavior. A careful, informed 
observation can help you develop a reasonably accurate &quot;guesstimate&quot; 
of someone's personal style. -->



<h3>
<%= strTextInIdentifyingTheStylesOfOthers %><!--In identifying the styles of others the following principles will help:-->
</h3>


<ul>
<li>	<%= strTextUnderstandTheLimitationsOfTrying %><br><br><!--Understand the limitations of trying to identify others' styles by observation alone. 
Although certainly influenced by inner, unseen forces, behavior is not clear evidence 
of values, motives, intelligence, feelings, or attitudes. As you observe a person 
behaving or &quot;acting&quot; in a certain manner, don't ascribe the underlying emotion or 
motive. Confine your conclusions to &quot;observable&quot; behavior. -->
</li>

<li><%= strTextWithholdFinalJudgmentUntilYouHav %><br><br><!--Withhold final judgment until you have had more than one encounter. 
Often it takes time to develop the confidence that you have accurately assessed an 
individual. If others don't trust you or don't perceive the environment as safe, they 
may put up a mask. Create an atmosphere that encourages others to be 
themselves.-->
</li>

<li><%= strTextPayParticularAttentionToNonverba %><br><br><!--Pay particular attention to nonverbal communication. 
Words account for less than 10 percent of any communication. Watch the body 
language, facial expressions, and gestures of the other individual. For example, an 
action-oriented person may be more animated with gestures, use more vocal 
inflection and facial expressions.-->
</li>

<li><%= strTextUseYourKnowledgeToIncreaseYourUnd %><!--Use your knowledge to increase your understanding of and response to others' 
needs. 
Your ability to recognize styles in others, coupled with an understanding of the 
needs of various styles, can greatly increase your effectiveness as a team member.-->
</li>
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END of PAGE 4 --------------------------------------------------------------------------------------->


<!-- Beginning of PAGE 5 --------------------------------------------------------------------------------->
<h1>
<%= strTextLetsReviewTheFourelementModelT %><!--Let's review the four-element model that we introduced in the PDI.-->
</h1>


<table border="0"><tr><td align="center">
<img SRC="images/<%=strLanguageCode%>/fourelementmodel.gif">
<b><%= strTextFigure1 %></b>
</td></tr>
</table>

<p>
<%= strTextOnTheFollowingPagesWeExpandOnTh %><!--On the following pages, we expand on this model to identify the more visible behavioral 
tendencies of different styles.--></p>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END of PAGE 5 --------------------------------------------------------------------------------------->


<!-- Beginning of PAGE 6 --------------------------------------------------------------------------------->
<h1>
<%= strTextPeopleVsTask %><!--People vs. Task-->
</h1>


<p>
<%= strTextUsingThisModelWeCanSeeInFigure %><!--Using this model, we can see in Figure 2 that those to the right of the vertical line are 
more people-oriented and those to the left are more task-oriented. These groups also 
have certain &quot;observable&quot; characteristics. People-oriented individuals tend to connect 
more readily with others, often with warmth and openness. On the other hand, task-
oriented people are generally cooler, more reserved, and somewhat less expressive. -->
</p>


<p align="center">
<img SRC="images/<%=strLanguageCode%>/peoplevtaskvertical.gif">
<b><%= strTextFigure2 %></b>
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END of PAGE 6 --------------------------------------------------------------------------------------->

<!-- Beginning of PAGE 7 --------------------------------------------------------------------------------->
<h1>
<%= strTextActionVsResponse %><!--Action vs. Response-->
</h1>


<p>
<%= strTextNowNoticeTheHorizontalLinePeop %><!--Now, notice the horizontal line. People above the horizontal line tend to be active or 
assertive; these individuals generally demonstrate a bold, confident, and directive 
demeanor to others. Those below the line are more responsive or accommodating; 
others see them as low key, collaborative, and self-controlled. Detailed descriptions of 
tendencies in assertive and responsive temperaments are shown in the diagram below:-->
</p>



<p align="center">
<img SRC="images/<%=strLanguageCode%>/peoplevtaskhorizontal.gif">
<b><%= strTextFigure3 %></b><!--Figure 3-->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END of PAGE 7 --------------------------------------------------------------------------------------->

<!-- Beginning of PAGE 8 --------------------------------------------------------------------------------->
<h1>
<%= strTextTeamCommunicationStyles %><!--Team Communication Styles-->
</h1>

<IMG SRC="images/spacer.gif" WIDTH="600" HEIGHT="3">

<h2>
<%= strTextOnATeamHighDs %><!--On a Team High D's-->
</h2>
<table width="100%" border="0">
	<tr valign="top">
		<td width="50%">
			<ul>
				<li><%= strTextStayGoaloriented %><!--Stay goal-oriented--></li>
				<li><%= strTextOvercomeObstacles %><!--Overcome obstacles--></li>
				<li><%= strTextDontGetBoggedDown %><!--Don't get bogged down--></li>
				<li><%= strTextArentAfraidToSpeakOut %><!--Aren't afraid to speak out--></li>
				<li><%= strTextTakeOnChallengesWithoutFear %><!--Take on challenges without fear--></li>
				<li><%= strTextAreDirectAndStraightforward %><!--Are direct and straightforward--></li>
				<li><%= strTextProvideLeadership %><!--Provide leadership--></li>
				<li><%= strTextPushTheGroupTowardDecisions %><!--Push the group toward decisions--></li>
				<li><%= strTextUsuallyKeepAPositiveAttitude %><!--Usually keep a positive attitude--></li>
				<li><%= strTextAreWillingToTakeRisks %><!--Are willing to take risks--></li>
				<li><%= strTextHandleMultipleProjectsWell %><!--Handle multiple projects well--></li>
				<li><%= strTextCanFunctionWithHeavyWorkloads %><!--Can function with heavy workloads--></li>
			</ul>
		</td>
		<td width="50%">
			<IMG SRC="images/<%=strLanguageCode%>/GOALS_D.jpg" width="294px" height="376px">
		</td>
	</tr>
</table>
<IMG SRC="images/spacer.gif" WIDTH="600" HEIGHT="3">

<h2>
<%= strTextOnATeamHighIs %><!--On a Team High I's-->
</h2>
<table width="100%" border="0" ID="Table1">
	<tr valign="top">
		<td width="50%">
			<ul>
				<li><%= strTextMotivate %><!--Motivate--></li>
				<li><%= strTextAreEnthusiastic %><!--Are enthusiastic--></li>
				<li><%= strTextEnjoyWorkingWithPeople %><!--Enjoy working with people--></li>
				<li><%= strTextProvideLeadership %><!--Provide leadership--></li>
				<li><%= strTextWillSpeakUp %><!--Will speak up--></li>
				<li><%= strTextAreOptimistic %><!--Are optimistic--></li>
				<li><%= strTextAreAgreeable %><!--Are agreeable--></li>
				<li><%= strTextCanCreateAnAtmosphereOfGoodwil %><!--Can create an atmosphere of goodwill--></li>
				<li><%= strTextVerbalizeIdeas %><!--Verbalize ideas--></li>
				<li><%= strTextFunctionWellAsSpokespersons %><!--Function well as spokespersons--></li>
				<li><%= strTextCanArguePersuasively %><!--Can argue persuasively--></li>
				<li><%= strTextStayPeopleorientedToAchieveRes %><!--Stay people-oriented to achieve results--></li>
			</ul>
		</td>
		<td width="50%">				
			<IMG SRC="images/<%=strLanguageCode%>/GOALS_I.jpg" width="294px" height="376px">
		</td>
	</tr>
</table>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END of PAGE 8 --------------------------------------------------------------------------------------->


<!-- Beginning of PAGE 9 --------------------------------------------------------------------------------->
<h1>
<%= strTextTeamCommunicationStyles %><!--Team Communication Styles-->
</h1>

<IMG SRC="images/spacer.gif" WIDTH="600" HEIGHT="3">

<h2>
<%= strTextOnATeamHighSs %><!--On a Team High S's-->
</h2>
 
<table width="100%" border="0" ID="Table2">
	<tr valign="top">
		<td width="50%">
			<ul>
				<li><%= strTextBuyIntoTeamGoals %><!--Buy into team goals--></li>
				<li><%= strTextSupportOtherTeamMembers %><!--Support other team members--></li>
				<li><%= strTextAreDependableAndFaithful %><!--Are dependable and faithful--></li>
				<li><%= strTextIdentifyStronglyWithTheTeam %><!--Identify strongly with the team--></li>
				<li><%= strTextProvideStabilility %><!--Provide stabilility--></li>
				<li><%= strTextFocusOnComponentsOfATotalProje %><!--Focus on components of a total project--></li>
				<li><%= strTextWorkTowardBuildingRelationship %><!--Work toward building relationships--></li>
				<li><%= strTextAreEventempered %><!--Are even-tempered--></li>
				<li><%= strTextArePractical %><!--Are practical--></li>
				<li><%= strTextOfferSpecializedSkills %><!--Offer specialized skills--></li>
				<li><%= strTextArePatient %><!--Are patient--></li>
				<li><%= strTextAreLoyal %><!--Are loyal--></li>
			</ul>
		</td>
		<td width="50%">	
			<IMG SRC="images/<%=strLanguageCode%>/GOALS_S.jpg" width="294px" height="376px">
		</td>
	</tr>
</table>

<IMG SRC="images/spacer.gif" WIDTH="600" HEIGHT="3">
<h2>
<%= strTextOnATeamHighCs %><!--On a Team High C's-->
</h2>
<table width="100%" border="0" ID="Table3">
	<tr valign="top">
		<td width="50%">
			<ul>
				<li><%= strTextPayAttentionToDetails %><!--Pay attention to details--></li>
				<li><%= strTextAreConscientious %><!--Are conscientious--></li>
				<li><%= strTextMeasureProgress %><!--Measure progress--></li>
				<li><%= strTextAskImportantQuestions %><!--Ask important questions--></li>
				<li><%= strTextPreferToShareResponsibilitiesA %><!--Prefer to share responsibilities and risks--></li>
				<li><%= strTextAreSystematic %><!--Are systematic--></li>
				<li><%= strTextAreWillingToWorkTowardConsensu %><!--Are willing to work toward consensus--></li>
				<li><%= strTextAreDiplomatic %><!--Are diplomatic--></li>
				<li><%= strTextAnalyzeProblems %><!--Analyze problems--></li>
				<li><%= strTextStressQuality %><!--Stress quality--></li>
				<li><%= strTextThinkLogically %><!--Think logically--></li>
				<li><%= strTextStayTaskoriented %><!--Stay task-oriented--></li>
			</ul>
		</td>
		<td width="50%">
			<IMG SRC="images/<%=strLanguageCode%>/GOALS_C.jpg" width="294px" height="376px">
		</td>
	</tr>
</table>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END of PAGE 9 --------------------------------------------------------------------------------------->


<!-- Beginning of PAGE 10 --------------------------------------------------------------------------------->
<h1>
<% strTemp = Replace(strTextTheBehaviorStyleOfAHighhightyp, "{{HighType1}}", HighType1) %>
<%= strTemp %><!--The Behavior Style of a High <%=HighType1%> Team Member-->
</h1>

<p>
<span class="h3-no-linespace">
<%= strTextApplicationAndDiscussion %><!--Application and Discussion-->
</span><br>

<%
   strTemp = Replace(strTextusername1AsAHighhightype1Aspec, "{{UserName1}}", UserName1)
   strTemp = Replace(strTemp, "{{HighType1}}", HighType1)
%>
<%= strTemp %><!--<%=UserName1%> as a high <%=HighType1%>, aspects of your work or social style will affect the way you 
team up with others. Below is a list of descriptors for the high <%=HighType1%> temperament-->


<ol style="margin-top:2px;padding-top:2px">
<li>	<%= strTextPersonalizeThisListByCheckingT %><!--Personalize this list by checking those items you feel accurately describe you.--></li>
<li>	<%= strTextOfThoseYouCheckedIndicateWithA %><!--Of those you checked, indicate with a &quot;+&quot; or a &quot;-&quot; any attribute you believe has a 
positive (+) or negative (-) effect on the team.--></li>
<li>	<%= strTextIfTheTeamIsLargeEnoughToInclud %><!--If the team is large enough to Include several members in each of the four 
behavioral styles, break into groups of styles and discuss your conclusions. 
Identify points of agreement and difference.--></li>
</ol>
</p>

<% if UCase(HighType1) = "D" then %>
	<!--#Include FILE="AppModuleTeamwork_tm_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#Include FILE="AppModuleTeamwork_tm_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#Include FILE="AppModuleTeamwork_tm_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#Include FILE="AppModuleTeamwork_tm_c.asp" -->
<% end if %>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<!-- Print the Other Behavioral Styles -->

<% if UCase(HighType1) <> "D" Then %>
	<!--#Include FILE="AppModuleTeamwork_tm_d.asp" -->
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<% End If

	If UCase(HighType1) <> "I" Then %>
	<!--#Include FILE="AppModuleTeamwork_tm_i.asp" -->
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<% End If

	If UCase(HighType1) <> "S" Then %>
	<!--#Include FILE="AppModuleTeamwork_tm_s.asp" -->
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<% End If

	If UCase(HighType1) <> "C" Then %>
	<!--#Include FILE="AppModuleTeamwork_tm_c.asp" -->
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<% End If %>


<!-- END Print ALL Behavioral Styles -->
<h1>
<%= strTextBarriersToTeamEffectiveness %><!--Barriers to Team Effectiveness-->
</h1>



<h2>
<%= strTextAttitudes %><!--Attitudes-->
</h2>


<p>
<%= strTextWeTendToViewTeamMembersInTerms %><!--We tend to view team members in terms of their weaknesses, not 
their strengths&#151;especially those who have different patterns than 
our own.-->
</p>

<p>
<%
   strTemp = Replace(strTextusername1AsAHighhightype1133, "{{UserName1}}", UserName1)
   strTemp = Replace(strTemp, "{{HighType1}}", HighType1)
%>
<%= strTemp %><!--<%=UserName1%>, as 
a High <%=HighType1%>&#133;-->
</p>

<% if UCase(HighType1) = "D" then %>
	<!--#Include FILE="AppModuleTeamwork_att_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#Include FILE="AppModuleTeamwork_att_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#Include FILE="AppModuleTeamwork_att_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#Include FILE="AppModuleTeamwork_att_c.asp" -->
<% end if %>


<h3>
<%= strTextHowToOvercomeTheAttitudeBarrie %><!--How to overcome the attitude barrier and build commitment to team 
members:-->
</h3>


<ol>
<li>	<%= strTextViewTeamMembersInTermsOfTheirS %><!--View team members in terms of their strengths, not their weaknesses.--></li>
<li>	<%= strTextBecomeAChampionOfTheirStrength %><!--Become a champion of their strengths.--></li>
<li>	<%= strTextBeAvailableToComplementTheirWe %><!--Be available to complement their weaknesses with your strengths.--></li>
</ol>


<h2>
<%= strTextActions %><!--Actions-->
</h2>


<p>
<%= strTextWeTendToCauseTensionInOtherPeo %><!--We tend to cause tension in other people's lives by what we do as 
well as what we don't do. When tension occurs, we want others to 
change, but we don't see the need to change ourselves.-->
</p>

<% if UCase(HighType1) = "D" then %>
	<!--#Include FILE="AppModuleTeamwork_act_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#Include FILE="AppModuleTeamwork_act_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#Include FILE="AppModuleTeamwork_act_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#Include FILE="AppModuleTeamwork_act_c.asp" -->
<% end if %>




<h1>
<%= strTextApplication %><!--Application:-->
</h1>


<ol>
<li> <%= strTextReviewTheDescriptiveTermsForYo %><!--Review the descriptive terms for your style in the Attitudes and Actions charts. 
Are they accurate? Add and delete items on the two lists that would make 
them more descriptive of you.--></li>
<li> <%= strTextCompareNotesWithOthersOfYourSt %><!--Compare notes with others of your style.--></li>
</ol>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>



<h1>
<%= strTextWorkingTogetherOnTeams %><!--Working Together on Teams-->
</h1>


<p>
<%
   strTemp = Replace(strTextusername1AsAHighhightype1YouHa, "{{UserName1}}", UserName1)
   strTemp = Replace(strTemp, "{{HighType1}}", HighType1)
%>
<%= strTemp %><!--<%=UserName1%>, as a high <%=HighType1%> you have a unique style of working with other people. -->
<%= strTextHereIsHowYourStyleWorksWith %><!--Here is how your style works with . . .-->
</p>

<% if UCase(HighType1) = "D" then %>
	<!--#Include FILE="AppModuleTeamwork_ww_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#Include FILE="AppModuleTeamwork_ww_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#Include FILE="AppModuleTeamwork_ww_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#Include FILE="AppModuleTeamwork_ww_c.asp" -->
<% end if %>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h1>
<%= strTextTeamCommunication %><!--Team Communication-->
</h1>




<h2>
<%= strTextWithAHighD %><!--With a High D...-->
</h2>



<h3>
<%= strTextToCommunicateBetterWithAHighDD3 %><!--To communicate better with a High D do...-->
</h3>


<ul>
<li>	<%= strTextProvideDirectAnswersAndBeBrief %><!--Provide direct answers and be brief and to the point.--></li>
<li>	<%= strTextStressWhatHasToBeDoneNotWhyItH %><!--Stress what has to be done, not why it has to be done.--></li>
<li>	<%= strTextStressResults1 %><!--Stress results.--></li>
<li>	<%= strTextProvideOptionsAndPossibilities1 %><!--Provide options and possibilities.--></li>
<li>	<%= strTextEmphasizeLogicOfIdeasAndApproa %><!--Emphasize logic of ideas and approaches.--></li>
<li>	<%= strTextAgreeWithTheFactsPositionOrIde %><!--Agree with the facts, position, or idea&#151;not just the person.--></li>
<li>	<%= strTextAvoidRambling %><!--Avoid rambling.--></li>
<li>	<%= strTextSummarizeAndClose3 %><!--Summarize and close.--></li>
</ul>


<h3>
<%= strTextToCommunicateBetterWithAHighDDon %><!--To communicate better with a High D don't...-->
</h3>


<ul>
<li>	<%= strTextAppearIndecisive %><!--Appear indecisive.--></li>
<li>	<%= strTextBeProblemoriented1234 %><!--Be problem-oriented.--></li>
<li>	<%= strTextBeOverlyFriendly %><!--Be overly friendly.--></li>
<li>	<%= strTextGeneralize %><!--Generalize.--></li>
<li>	<%= strTextProvideTooManyDetails %><!--Provide too many details.--></li>
<li>	<%= strTextRepeatYourselfOrTalkTooMuch %><!--Repeat yourself or talk too much.--></li>
<li>	<%= strTextMakeUnsupportableStatements %><!--Make unsupportable statements.--></li>
<li>	<%= strTextMakeDecisionsForThem %><!--Make decisions for them.--></li>
</ul>



<h3>
<%= strTextAsHighDsHearAndAnalyzeInformati %><!--As High D's hear and analyze information, they may...-->
</h3>


<ul>
<li>	<%= strTextNotConsiderRisks %><!--Not consider risks.--></li>
<li>	<%= strTextNotWeighProsAndCons %><!--Not weigh pros and cons.-->
</ul>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h1>
<%= strTextTeamCommunication %><!--Team Communication-->
</h1>

<h2>
<%= strTextWithAHighI %><!--With a High I . . .-->
</h2>



<h3>
<%= strTextToCommunicateBetterWithAHighID3 %><!--To communicate better with a High I do...-->
</h3>


<ul>
<li>	<%= strTextStressTheNewTheSpecialAndTheNo %><!--Stress the new, the special, and the novel.--></li>
<li>	<%= strTextDemonstrateTheAbilityToBeArtic %><!--Demonstrate the ability to be articulate.--></li>
<li>	<%= strTextStressTestimoniesOrFeedbackFro %><!--Stress testimonies or feedback from &quot;experts.&quot;--></li>
<li>	<%= strTextProvideOpportunityForGiveAndTa %><!--Provide opportunity for give and take.--></li>
<li>	<%= strTextBeOpenFriendlyAndWarm %><!--Be open, friendly, and warm.--></li>
<li>	<%= strTextBeEnthusiastic %><!--Be enthusiastic.--></li>
<li>	<%= strTextListenAttentively %><!--Listen attentively.--></li>
<li>	<%= strTextSpendTimeDevelopingTheRelation %><!--Spend time developing the relationship.--></li>
</ul>



<h3>
<%= strTextToCommunicateBetterWithAHighIDon %><!--To communicate better with a High I don't...-->
</h3>


<ul>
<li>	<%= strTextIgnoreTheSocialDimensions %><!--Ignore the social dimensions.--></li>
<li>	<%= strTextDoAllTheTalking %><!--Do all the talking.--></li>
<li>	<%= strTextRestrictSuggestionsOrInterrupt %><!--Restrict suggestions or interruptions.--></li>
<li>	<%= strTextLetHimOrHerTakeYouTooFarOffTra %><!--Let him or her take you too far off track.--></li>
<li>	<%= strTextBeCurtColdOrTightlipped %><!--Be curt, cold, or tight-lipped.--></li>
<li>	<%= strTextTalkDownToThem %><!--Talk down to them.--></li>
</ul>


<h3>
<%= strTextAsHighIsHearAndAnalyzeInformat %><!--As High I's hear and analyze information, they may-->&#133;
</h3>


<ul>
<li>	<%= strTextNotConcentrate %><!--Not concentrate.--></li>
<li>	<%= strTextIgnoreImportantFacts %><!--Ignore important facts.--></li>
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h1>
<%= strTextTeamCommunication %><!--Team Communication-->
</h1>

<h2>
<%= strTextWithAHighS3 %><!--With a High S . . .-->
</h2>



<h3>
<%= strTextToCommunicateBetterWithAHighSD3 %><!--To communicate better with a High S do...-->
</h3>


<ul>
<li>	<%= strTextUsePatienceInDrawingOutHisherG %><!--Use patience in drawing out his/her goals.--></li>
<li>	<%= strTextEmphasizeHowADeliberateApproac %><!--Emphasize how a deliberate approach will work.--></li>
<li>	<%= strTextTalkServiceAndDependability %><!--Talk service and dependability.--></li>
<li>	<%= strTextAskHowQuestionsAndGetFeedback %><!--Ask how questions and get feedback.--></li>
<li>	<%= strTextListenAttentively %><!--Listen attentively.--></li>
<li>	<%= strTextBeSincere %><!--Be sincere.--></li>
<li>	<%= strTextCommunicateInALowkeyRelaxedMan %><!--Communicate in a low-key, relaxed manner.--></li>
</ul>


<h3>
<%= strTextToCommunicateBetterWithAHighSDon %><!--To communicate better with a High S don't...-->
</h3>


<ul>
<li>	<%= strTextBeTooDirective %><!--Be too directive.--></li>
<li>	<%= strTextPushTooAggressivelyOrDemand %><!--Push too aggressively or demand.--></li>
<li>	<%= strTextMoveTooFast %><!--Move too fast.--></li>
<li>	<%= strTextOmitTooManyDetails %><!--Omit too many details.--></li>
<li>	<%= strTextBeAbrupt %><!--Be abrupt.--></li>
</ul>


<h3>
<%= strTextAsHighSsHearAndAnalyzeInformat %><!--As High S's hear and analyze information, they may-->&#133;
</h3>


<ul>
<li>	<%= strTextBeQuietlyUnyielding %><!--Be quietly unyielding.--></li>
<li>	<%= strTextNotBeAssertiveInCommunicatingT %><!--Not be assertive in communicating their concerns.--></li>
<li>	<%= strTextNotProvideALotOfFeedbackDuring %><!--Not provide a lot of feedback during presentations.--></li>
<li>	<%= strTextHesitateToMakeADecisionParticu %><!--Hesitate to make a decision, particularly if unpopular.--></li>
<li>	<%= strTextSlowDownTheAction %><!--Slow down the action.--></li>
</ul>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h1>
<%= strTextTeamCommunication %><!--Team Communication-->
</h1>

<h2>
<%= strTextWithAHighC3 %><!--With a High C . . .-->
</h2>



<h3>
<%= strTextToCommunicateBetterWithAHighCD3 %><!--To communicate better with a High C do...-->
</h3>


<ul>
<li>	<%= strTextUseComparativeData %><!--Use comparative data.--></li>
<li>	<%= strTextAppealToLogicShowingFactsAndBe %><!--Appeal to logic, showing facts and benefits.--></li>
<li>	<%= strTextConcentrateOnSpecifics %><!--Concentrate on specifics.--></li>
<li>	<%= strTextHaveAllTheFactsAndStickToThem %><!--Have all the facts, and stick to them.--></li>
<li>	<%= strTextBeOrganized %><!--Be organized.--></li>
<li>	<%= strTextProvideWrittenProposalsForMajorDe %><!--Provide written proposals for major decisions.--></li>
<li>	<%= strTextAppealToInterestInResearchStat %><!--Appeal to interest in research, statistics, etc.--></li>
<li>	<%= strTextProvideDetailedResponsesToQues %><!--Provide detailed responses to questions.--></li>
<li>	<%= strTextDealFullyWithObjections %><!--Deal fully with objections.--></li>
<li>	<%= strTextStressQualityReliabilityAndSec %><!--Stress quality, reliability, and security.--></li>
</ul>


<h3>
<%= strTextToCommunicateBetterWithAHighCDon %><!--To communicate better with a High C don't...-->
</h3>


<ul>
<li>	<%= strTextBeVagueOrCasualParticularlyWhe %><!--Be vague or casual, particularly when answering questions.--></li>
<li>	<%= strTextMoveToTheBottomLineTooQuickly %><!--Move to the bottom line too quickly.--></li>
<li>	<%= strTextGetPersonalAboutFamilyIfYouDont %><!--Get personal about family if you don't know him/her well.--></li>
<li>	<%= strTextPatThemOnTheBackOrOtherwiseBeT %><!--Pat them on the back or otherwise be too familiar.--></li>
<li>	<%= strTextSpeakTooLoudly %><!--Speak too loudly.--></li>
<li>	<%= strTextThreatenCajoleWheedleOrCoax %><!--Threaten, cajole, wheedle, or coax.--></li>
</ul>


<h3>
<%= strTextAsHighCsHearAndAnalyzeInformati %><!--As High C's hear and analyze information, they may-->&#133;
</h3>


<ul>
<li>	<%= strTextBeTooConservativeAndCautious %><!--Be too conservative and cautious.--></li>
<li>	<%= strTextBogDownInTheCollectionProcess %><!--Bog down in the collection process.--></li>
<li>	<%= strTextBecomeBuriedInDetail %><!--Become buried in detail.--></li>
<li>	<%= strTextDelayOrAvoidDecisionsParticula %><!--Delay or avoid decisions, particularly if risky.--></li>
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h1>
<%= strTextTeamRelationshipsPerplexingOrP %><!--Team Relationships: Perplexing or Productive-->
</h1>


<p>
<%= strTextWeEachHaveADistinctivePersonal %><!--We each have a distinctive personal style that is based on our unique personality, and 
we tend to deal with others based on the style that is comfortable for us. As team 
members, we normally tend to deliver information in the way that we would like to 
receive it.-->
</p>

<p>
<%= strTextHoweverOtherPeoplesStylesMayDif %><!--However, other people's styles may differ drastically from ours. What satisfies our need 
to give and receive information may be a complete turnoff to someone else. We must 
learn to recognize and appreciate their temperaments so that we can adapt our 
approach to suit an individual's behavioral style. Doing so will create the synergy that 
delivers outstanding results within an organization. -->
</p>



<p>
<%= strTextToClarifyThisConceptAnswerTheFo %><!--To clarify this concept, answer the following questions.-->
</p>

<ul style="padding-left:8; margin-left:8">
	<li>
		<%= strTextThinkOfAPersonOnYourTeamWhoFru %>
			<!--Think of a person on your team who frustrates you or makes you uncomfortable and 
			less effective in achieving team goals. What characteristics does this person have 
			that may cause conflict or make it difficult for you to achieve excellent results when 
			you work together (e.g., has trouble making decisions, demonstrates a lack of focus, 
			bogs down in details, moves too fast, etc.)? Describe these characteristics.-->

		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table5">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<%= strTextNowDescribeATeamMemberWithWhom %><!--Now describe a team member with whom you work especially well. What 
			characteristics make you feel comfortable and more effective?-->
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table4">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>		
	<li>
		<%= strTextInASituationWhereYouHaveFoundY %><!--In a situation where you have found your personal style to be different or even 
			incompatible with someone else, what adjustments have you made? What 
			adjustments has the other person made?-->
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table11">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
		

		


</ul>



<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>



<h1>
<%= strTextDiscCompatibilityMatrix %><!--DISC Compatibility Matrix-->
</h1>


<p>
<%= strTextAsYouObservedInThePreviousExerc %><!--As you observed in the previous exercise, different personal style combinations present 
opportunities and potential for compatibility or for conflict. Although not set in stone, the 
following matrices present typical relational and task compatibilities of the various styles 
and rank them on a scale from Excellent to Poor.-->
</p>

<p>
<%= strTextFirstLetsConsiderRelationalComp %><!--First, let's consider Relational Compatibility. How well do two styles interact in casual or 
general situations? For example, how do you get along with a coworker who may be in 
your department but rarely intersects with your job? Or, in your experience with 
roommates, which ones stand out as either delights or disasters? Relational 
Compatibility involves the aspects and attributes of a relationship, whether casual or 
intimate.-->
</p>


<div style="text-align:center">
<h3>
<%= strTextRelationalCompatibility %><!--Relational Compatibility-->
</h3>

<!--#Include FILE="relationshipcompatibility.asp" -->
</div>
<br>

<%= strTextNextLetsLookAtTaskCompatibilit %><!--Next, let's look at Task Compatibility. Some combinations that rank low on Relational 
Compatibility have excellent Task Compatibility. You may work extremely well on a 
project with someone that you might not want to take on vacation!-->


<div style="text-align:center">
<h3>
<%= strTextTaskCompatibility %><!--Task Compatibility-->
</h3>

<!--#Include FILE="taskcompatibility.asp" -->

</div>
<p>
<%= strTextNoticeAlsoThatTheseAreemtenden %><!--Notice also that these are <em>tendencies</em> or <em>potential</em> compatibilities. They aren't rules for 
behavior, and people find many ways to adapt and compensate to offset the potential 
for conflict.   -->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h1>
<%= strTextWhenTheHeatIsOnTeamworkUnderSt %><!--When the Heat is On: Teamwork Under Stress-->
</h1>


<p>
<%= strTextTheWorkingsOfAHighPerformanceT %><!--The workings of a high performance team become even more complex in our highly 
charged workplaces when tempers flare, fatigue sets in, and people resist or resent the 
message. Indeed, the most challenging communication situations occur when things 
aren't going well. A rise in stress levels introduces an interesting dimension to 
temperament that we call stress behavior. People with similar temperaments tend to 
behave alike in those situations in which we find ourselves &quot;at the end of our rope,&quot; 
feeling as though we just can't take it anymore. -->
</p>

<p>
<%= strTextInThePdiInstrumentWeIntroduced %><!--In the PDI Instrument we introduced a model that explained DISC theory. The High D's 
and I's are active/assertive in nature. They tend to shape their environments to better 
suit their needs and expectations. The High S's and C's are more responsive/
accommodating in nature. Their standards are not any lower, but they tend to accept 
their environment the way it is and respond appropriately within that context.-->
</p>

<p>
<%= strTextBecauseDsAndIsTendToSeeThemselv %><!--Because D's and I's tend to see themselves as able to shape the environment, their 
initial response to conflict and stress is assertive&#151; &quot;We missed that deadline. I won't 
accept that behavior from anyone!&quot; The S's and C's tend to see themselves as needing 
to work within the existing environment and therefore are initially more responsive, 
cautious, and accommodating in conflict and stress. They tend to pull back and may be 
slower to make decisions or take action.-->
</p>

<p>
<%= strTextNoticeWeDescribedTheAboveBehavi %><!--Notice we described the above behavior with the qualifier &quot;initial.&quot; An interesting 
phenomenon occurs under sustained conflict and stress. If the conflict is not quickly 
resolved and the stress continues unabated, people tend to move into an alternate or 
reserve style of behavior. For example, the High D team member may initially become 
demanding (dictatorial and perhaps even tyrannical), but under sustained conflict will 
move to detachment. -->
</p>

<p>
<%= strTextUnderStressTheHighIWillInitiall %><!--Under stress, the High I will initially go on the attack. They can really zing you with their 
verbal skills, often using sarcasm or exaggeration to alleviate their frustration. However, 
if the stress increases and victory looks uncertain, the need for social approval will win 
out and the High I will often agree in order to maintain the group's positive feelings 
about him or her.  -->
</p>

<p>
<%= strTextTheHighSsNormallyAgreeableDispo %><!--The High S's normally agreeable disposition will not prepare others for what's boiling 
beneath the surface. If a High S reaches secondary stress levels, he or she may 
demonstrate attacking behavior, sending everyone running for cover.
High C's will initially deal with stress by detaching, perhaps by withdrawing and working 
in a solitary setting, but as stress moves to the next level, they will cling more 
tenaciously to their position and their resolve becomes demanding. Rigidity is the order 
of the day. It's &quot;by the book&quot; at all costs.-->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<p>
<%= strTextTheTableBelowShowsTheInitialAn %><!--The table below shows the initial and alternative style under stress for each of the four 
temperaments.-->
</p>





<table WIDTH="100%" CELLSPACING="0" CELLPADDING="5">
	<tr>
		<td COLSPAN="3" ALIGN="MIDDLE"><font size="2"><strong><%= strTextInitialStressResponse %><!--Initial Stress Response--></strong></td>
		<td COLSPAN="2" ALIGN="MIDDLE"><font size="2"><strong><%= strTextAlternativeStressResponse %><!--Alternative Stress Response--></strong></td>
	</tr>
	<tr>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="4"><strong>D</strong></td>
		<td style="border-bottom: solid 1px #bbbbbb; border-left: solid 1px black; border-top: solid 1px black;"><font size="3"><%= strTextDemands %><!--Demands--></td>
		<td style="border-bottom: solid 1px #bbbbbb; border-top: solid 1px black;"><font size="2"><%= strTextMessagequotwhatDoYouMeanWeDont %><!--Message: &quot;What do you mean we don't have the budget to complete my project? No way will I accept that.&quot;--></td>
		<td style="border-bottom: solid 1px #bbbbbb; border-left: solid 1px #bbbbbb; border-top: solid 1px black;"><font size="3"><%= strTextDetaches %><!--Detaches--></td>
		<td style="border-right: solid 1px black; border-bottom: solid 1px #bbbbbb; border-top: solid 1px black;"><font size="2"><%= strTextMessagequotiDontHaveTimeToBoth %><!--Message: &quot;I don't have time to bother with this. I have bigger issues to be concerned with.&quot;--></td>
	</tr>
	<tr>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="4"><strong>I</strong></td>
		<td style="border-left: solid 1px black; border-bottom: solid 1px #bbbbbb;"><font size="3"><%= strTextAttacks %><!--Attacks--></td>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="2"><%= strTextMessagequotimNotAboutToGoToThe %><!--Message: &quot;I'm not about to go to the board with this absurd proposal. We'll get killed if we present it this way.&quot;--></td>
		<td style="border-left: solid 1px #bbbbbb; border-bottom: solid 1px #bbbbbb;"><font size="3"><%= strTextAgrees %><!--Agrees--></td>
		<td style="border-right: solid 1px black; border-bottom: solid 1px #bbbbbb;"><font size="2"><%= strTextMessagequotokayWellTryItYourWa %><!--Message: &quot;Okay, we'll try it your way. But don't forget that I warned you.&quot;--></td>
	</tr>
	<tr>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="4"><strong>S</strong></td>
		<td style="border-left: solid 1px black; border-bottom: solid 1px #bbbbbb;"><font size="3"><%= strTextAgrees %><!--Agrees--></td>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="2"><%= strTextMessagequotiKnowYouveBeenSwamp %><!--Message: &quot;I know you've been swamped, or you wouldn't have missed that critical deadline.&quot;--></td>
		<td style="border-left: solid 1px #bbbbbb; border-bottom: solid 1px #bbbbbb;"><font size="3"><%= strTextAttacks %><!--Attacks--></td>
		<td style="border-right: solid 1px black; border-bottom: solid 1px #bbbbbb;"><font size="2"><%= strTextMessagequotyouveTakenAdvantage %><!--Message: &quot;You've taken advantage of my good nature for the last time!&quot;--></td>
	</tr>
	<tr>
		<td style="border-bottom: solid 1px #bbbbbb;"><font size="4"><strong>C</strong></td>
		<td style="border-left: solid 1px black; border-bottom: solid 1px black;"><font size="3"><%= strTextDetaches %><!--Detaches--></td>
		<td style="border-bottom: solid 1px black;"><font size="2"><%= strTextMessagequotiJustDontHaveTimeTo %><!--Message: &quot;I just don't have time to consider your request. I have too much on my plate as it is.&quot;--></td>
		<td style="border-left: solid 1px #bbbbbb; border-bottom: solid 1px black;"><font size="3"><%= strTextDemands %><!--Demands--></td>
		<td style="border-right: solid 1px black; border-bottom: solid 1px black;"><font size="2"><%= strTextMessagequotifIBendTheRulesForY %><!--Message: &quot;If I bend the rules for you, I'll have to bend them for everyone, and that's not going to happen. We'll stick to procedure.&quot;--></td>
	</tr>
</table>

<br><br>

<p>
<%= strTextConflictIsNotTheOnlyCauseOfStr %><!--Conflict is not the only cause of stress. Getting ready for the big presentation, rolling out 
a new ad campaign or logo, or even getting that big increase in the budget can produce 
stress.-->
</p>

<p>
<%= strTextBelowIsAListOfMoreSourcesOfStr %><!--Below is a list of more sources of stress for your temperament. Check the items you 
have found create stress for you, and add additional items if relevant.-->
</p>


<% if UCase(HighType1) = "D" then %>
	<!--#Include FILE="AppModuleTeamwork_es_d.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#Include FILE="AppModuleTeamwork_es_i.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#Include FILE="AppModuleTeamwork_es_s.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#Include FILE="AppModuleTeamwork_es_c.asp" -->
<% end if %>

<p>
<%= strTextNowThinkOfThoseOnYourTeamWhatS %><!--Now think of those on your team. What situations create stress for them? How do their 
stressors differ from yours?-->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>



<h1>
<%= strTextReactingToStress %><!--Reacting to Stress-->
</h1>


<p>
<%= strTextInMostCasesTheFourTemperaments %><!--In most cases, the four temperaments react to stress in the following ways. Take the 
following steps to identify stress behaviors in yourself and others:-->
</p>

<ol>
<li>	<%= strTextReadThroughTheListForYourTempe %><!--Read through the list for your temperament and check the items you believe 
describe your behavior under stress. Add additional behaviors you believe are 
descriptive if not Included in the list.--></li>
<li>	<%= strTextThinkOfSomeoneOnYourTeamWhoHas %><!--Think of someone on your team who has a different behavioral style. How would 
you describe his/her behavior under stress? Again, check the behaviors on the 
list for his/her temperament below. List additional behaviors if relevant.--></li>
</ol>


<h2>
<% if UCase(HighType1) = "D" then%>
<%= strTextYourStyleTheHighDUnderStress %><!--Your Style - The High D Under Stress -->
<% else %>
<%= strTextTheHighDUnderStress %><!--The High D Under Stress -->
<% end if %>
</h2>

<ul>
	<li><%= strTextCanBecomeVeryControlling %><!--Can become very controlling--></li>
	<li><%= strTextTriesEvenHarderToImposeWillOnO %><!--Tries even harder to impose will on others--></li>
	<li><%= strTextAssertsSelfWithBodyOrLanguageM %><!--Asserts self with body or language, may invade &quot;personal space&quot; or point fingers--></li>
	<li><%= strTextMayDemonstrateStonySilenceOrGe %><!--May demonstrate stony silence or get very vocal, raising volume and energy level--></li>
	<li><%= strTextBecomesEvenLessWillingToCompro %><!--Becomes even less willing to compromise--></li>
	<li><%= strTextPullsRankOnThoseWithLessPower %><!--Pulls rank on those with less power--></li>
	<li><%= strTextIfStressProducesConflictGetsOv %><!--If stress produces conflict, gets over it quickly--></li>
	
</ul>


<h2>
<% if UCase(HighType1) = "I" then%>
<%= strTextYourStyleTheHighIUnderStress %><!--Your Style - The High I Under Stress -->
<% else %>
<%= strTextTheHighIUnderStress %><!--The High I Under Stress -->
<% end if %>
</h2>

<ul>
	<li><%= strTextFocusesFrustrationsOnOtherPeop %><!--Focuses frustrations on other people--></li>
	<li><%= strTextBlamesOthers %><!--Blames others--></li>
	<li><%= strTextCanBecomeEmotionalEvenToThePoi %><!--Can become emotional even to the point of shouting, making extreme statements, or gesturing belligerently--></li>
	<li><%= strTextMakesWoundingSarcasticRemarks %><!--Makes wounding, sarcastic remarks--></li>
	<li><%= strTextAttemptsToControlOthersThrough %><!--Attempts to control others through words and emotion--></li>
	<li><%= strTextIfStressProducesConflictGetsOve %><!--If stress produces conflict, gets over it quickly and will go out of their way to make things right--></li>
	
</ul>




<h2>
<% if UCase(HighType1) = "S" then%>
<%= strTextYourStyleTheHighSUnderStress %><!--Your Style - The High S Under Stress -->
<% else %>
<%= strTextTheHighSUnderStress %><!--The High S Under Stress -->
<% end if %>
</h2>

<ul>
	<li><%= strTextVoiceFacialExpressionsAndGestu %><!--Voice, facial expressions, and gestures become mechanical and perfunctory--></li>
	<li><%= strTextMayLackCommitmentEvenThoughVoi %><!--May lack commitment even though voicing agreement--></li>
	<li><%= strTextCanBePassiveAggressiveIeUninvo %><!--Can be passive aggressive, i.e., uninvolvement, silence, or lack of expression--></li>
	<li><%= strTextOftenCompliesRatherThanCoopera %><!--Often complies rather than cooperates, producing minimal results--></li>
	<li><%= strTextIfStressProducesConflictIsSome %><!--If stress produces conflict, is sometimes slow to forgive and forget--></li>
	
</ul>


<h2>
<% if UCase(HighType1) = "C" then%>
<%= strTextYourStyleTheHighCUnderStress %><!--Your Style - The High C Under Stress -->
<% else %>
<%= strTextTheHighCUnderStress %><!--The High C Under Stress -->
<% end if %>
</h2>
<ul>
	<li><%= strTextBecomesEvenLessResponsive %><!--Becomes even less responsive--></li>
	<li><%= strTextLimitsVocalIntonationFacialExp %><!--Limits vocal intonation, facial expression, and gestures (which are normally limited) even further--></li>
	<li><%= strTextWithdrawsEmotionally %><!--Withdraws emotionally--></li>
	<li><%= strTextMayAvoidContactWithOthersIfCon %><!--May avoid contact with others if conflicts arise--></li>
	<li><%= strTextMayBecomeHypersensitiveToWorkr %><!--May become hyper-sensitive to work-related criticisms--></li>
	<li><%= strTextMayAdoptAVictimizedAttitude %><!--May adopt a victimized attitude--></li>
	
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>



<h3>
<%= strTextCommunicatingWhenYoureUnderStr %><!--Communicating When You're Under Stress: How to Handle It-->
</h3>


<p>
<%= strTextWhenYoureUnderStressYouCanTakeC %><!--When you're under stress, you can take certain steps to relieve the stress you feel and 
its effects on members of your team.-->
</p>

<ul>
<li>	<%= strTextImproveYourAttitudeAndPerceptio %><br><br><!--Improve your attitude and perceptions by creating support systems, 
alleviating stress through humor, balancing work and play, talking it out, or 
seeking counseling if necessary.--></li>
<li>	<%= strTextIfAppropriateLearnANewSkillDisc %><br><br><!--If appropriate, learn a new skill, discuss your situation openly with team 
members, or just slow down a bit.--></li>
<li>	<%= strTextImproveYourPhysicalAbilityToCo %><!--Improve your physical ability to cope by making sure that you get proper 
nutrition, adequate rest, and regular exercise.--><br><br></li>
<li>	<%= strTextCreateALessStressfulEnvironmen %><!--Create a less stressful environment by structuring time off from work, ceasing 
to attend certain meetings, taking a class you enjoy, or possibly changing jobs 
or vocation.--></li>
</ul>


<h3>
<%= strTextWhenATeamMemberIsUnderStressHo %><!--When a Team Member is Under Stress: How to Handle It-->
</h3>


<ul>
<li>	<%= strTextAcknowledgeThatSomeoneIsDemons %><br><br><!--Acknowledge that someone is demonstrating stress behavior. People aren't 
always going to be at their best; we all have rough days. The faster you 
determine that someone's behavior is stress-related, the more effectively you 
can deal with the situation.--><br></li>

<li>	<%= strTextRecognizeTheEnvironmenteitherIn %><br><br><!--Recognize the environment (either internal or external) that is causing the 
stress. If you are causing or contributing to that stress, evaluate what you can 
change and what you can't. Many times we know if someone is on deadline 
or under the gun to make quota. It's harder to pinpoint when stress is coming 
from someone's personal life, since we may not know a lot about that person 
away from the office. Take responsibility to look for clues that may give you 
an idea of the cause, and give people the benefit of the doubt, at least initially.--><br></li>

<li>	<%= strTextTryToKeepFromReactingInKindMany %><br><br><!--Try to keep from reacting in kind. Many times, someone's behavior can be so 
unpleasant that we begin to demonstrate our own stress behavior. Keep your 
focus on the stress that is causing this behavior, and find ways to alleviate it, 
if possible. For example, if that person seems unable to deal with one more 
problem, delay telling him/her about the unhappy customer who called to 
complain.--><br></li>

<li>	<%= strTextIfPossibleAvoidDoingImportantB %><!--If possible, avoid doing important business with someone who is exhibiting 
stress behavior. Wait until the person's stress level is lower and you can work 
under more normal circumstances.--></li>
</ul>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>



<h1>
<%= strTextExerciseTeamworkUnderStress %><!--Exercise: Teamwork Under Stress-->
</h1>


<ul style="margin-left:8; padding-left:8">
	<li>
		<%= strTextThinkOfTheLastTimeYouWereInAStr %><!--Think of the last time you were in a stressful situation at work. How did your behavior 
				differ from your normal work-related behavior?-->
				
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table6">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<%= strTextHowDidTheBehaviorsOfSomeOfYour %><!--How did the behaviors of some of your colleagues differ? What was most noticeable 
				to you?-->
		
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table7">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<%= strTextWhatWasTheEffectOnRelationship %>
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table10">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<%= strTextWhenTheStressSubsidedWhatChang %><!--When the stress subsided, what changes took place in the workplace?-->
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table12">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
	<li>
		<%= strTextWhatCanYouDoToImproveTheSituat %><!--What can you do to improve the situation the next time stress occurs?-->
		<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table13">
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
			<tr><td style="border-bottom: black 1px solid">&nbsp;</td></tr>
		</table><br><br>
	</li>
</ul>



<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>



<h1>
<%= strTextQuickTips %><!--Quick Tips-->
</h1>


<p>
<% strTemp = Replace(strTextWorkingWithATeamDemandsAWillin, "{{HighType1}}", HighType1) %>
<%= strTemp %><!--Working with a team demands a willingness to modify your behavior in response to 
others' behavioral styles. Flexibility and openness can reduce tension, meet the needs 
of your fellow team members, and pave the way for the synergism that produces 
excellent results. As a High <%=HighType1%> team member, you may need to adapt in these 
ways when working with others:-->
</p>

<table align="center" width="600px" cellpadding="7px" class="with-border" ID="Table8">
		<tr>
			<td height="250px" width="50%" class="with-border">
				<div style="position: relative; height: 100%;"> 
				<div class="type-watermark">
					D
				</div>
				<div style="LEFT: 0px; POSITION: absolute; TOP: 30px; Z-Index:100">
					<ul>
						<li>	<%= strTextLearnToListenBePatientAsTheTea %><!--Learn to listen; be patient as the team tries to reach consensus.--></li>
						<li>	<%= strTextBeLessControlling %><!--Be less controlling.--></li>
						<li>	<%= strTextDevelopGreaterOpennessToPeople %><!--Develop greater openness to people's opinions and feelings.--></li>
						<li>	<%= strTextFocusMoreOnPersonalRelationshi %><!--Focus more on personal relationships.--></li>
						<li>	<%= strTextBeMoreSupportiveOfOtherTeamMem %><!--Be more supportive of other team members.--></li>
						<li>	<%= strTextTakeTimeToExplainWhy %><!--Take time to explain why.--></li>
						<li>	<%= strTextBeWarmer %><!--Be warmer.--></li>
					</ul>
				</div>
				</div>
			</td>
			<td height="250px" width="50%" class="with-border">
				<div style="position: relative; height: 100%";> 
				<div class="type-watermark">
					I
				</div>
				<div style="LEFT: 0px; POSITION: absolute; TOP: 30px; Z-Index:100">
					<ul>
						<li>	<%= strTextBeLessImpulsive %><!--Be less impulsive.--></li>
						<li>	<%= strTextBeMoreResultsOriented %><!--Be more results oriented.--></li>
						<li>	<%= strTextControlActionsAndEmotions %><!--Control actions and emotions.--></li>
						<li>	<%= strTextFocusOnDetailsAndFacts %><!--Focus on details and facts.--></li>
						<li>	<%= strTextSlowDownThePaceForOtherTeamMem %><!--Slow down the pace for other team members.--></li>
						<li>	<%= strTextListenDontTalkAsMuch %><!--Listen; don't talk as much.--></li>
						<li>	<%= strTextEvaluateOtherMembersIdeas %><!--Evaluate other members' ideas.--></li>
						<li>	<%= strTextFollowThroughWithAssignmentsTh %><!--Follow through with assignments the team gives you.--></li>
					</ul>
				</div>
				</div>
			</td>
		</tr>
		<tr>
			<td height="250px" width="50%" class="with-border">
				<div style="position: relative; height: 100%";> 
				<div class="type-watermark">
					C
				</div>
				<div style="LEFT: 0px; POSITION: absolute; TOP: 30px; Z-Index:100">
					<ul>
						<li>	<%= strTextFocusOnDoingTheRightThingsNotJ %><!--Focus on doing the right things, not just doing things right.--></li>
						<li>	<%= strTextRespondMoreQuicklyToAccomplish %><!--Respond more quickly to accomplish team goals.--></li>
						<li>	<%= strTextBeMoreDecisive %><!--Be more decisive.--></li>
						<li>	<%= strTextBeLessFactOrientedAndMorePeopl %><!--Be less fact oriented and more people focused.--></li>
						<li>	<%= strTextJoinTeamMembersInTakingRisks %><!--Join team members in taking risks.--></li>
						<li>	<%= strTextDevelopRelationshipsWithinTheT %><!--Develop relationships within the team.--></li>
						<li>	<%= strTextBeMoreOpenToOthersIdeasAndMeth %><!--Be more open to others' ideas and methods.--></li>
					</ul>
				</div>
				</div>
			</td>
			<td height="250px" width="50%" class="with-border">
				<div style="position: relative; height: 100%";> 
				<div class="type-watermark">
					S
				</div>
				<div style="LEFT: 0px; POSITION: absolute; TOP: 30px; Z-Index:100">
					<ul>
						<li>	<%= strTextBeOpenToChange %><!--Be open to change.--></li>
						<li>	<%= strTextBeMoreDirect %><!--Be more direct.--></li>
						<li>	<%= strTextBeMoreConcernedWithOverallTeam %><!--Be more concerned with overall team goals than with specific functions.--></li>
						<li>	<%= strTextFaceConfrontationConstructivel %><!--Face confrontation constructively.--></li>
						<li>	<%= strTextBeMoreFlexible %><!--Be more flexible.--></li>
						<li>	<%= strTextIncreasePaceToAccomplishResult %><!--Increase pace to accomplish results.--></li>
						<li>	<%= strTextInitiateMore %><!--Initiate more.--></li>
					</ul>
				</div>
				</div>
			</td>
		</tr>
	</table>




<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h1>
<%= strTextTeamBuildingWorksheet %><!--Team Building Worksheet-->
</h1>


<p>
<%= strTextInstructionsTheFollowingPagesW %><!--Instructions: The following pages will help team members exchange information about 
their behavioral styles and will help them work together more effectively. This exercise 
is designed for you to address each team member individually, answering several key 
questions about your relationship with that person. Answer each question as though you 
were speaking directly to that team member.-->
</p>


<table WIDTH="100%" BORDER="1" CELLSPACING="1" CELLPADDING="5" class="with-border">
	<tr>
		<td class="with-border" width="10%">&nbsp;</td>
		<td class="with-border"><font size="2"><span class="small-text"><%= strTextName %><!--Name-->:<br><br><%= strTextTemperament %><!--Temperament-->:<br><br></span></td>
		<td class="with-border"><font size="2"><span class="small-text"><%= strTextName %><!--Name-->:<br><br><%= strTextTemperament %><!--Temperament-->:<br><br></span></td>
		<td class="with-border"><font size="2"><span class="small-text"><%= strTextName %><!--Name-->:<br><br><%= strTextTemperament %><!--Temperament-->:<br><br></span></td>
	</tr>
	<tr>
		
		<td class="with-border" valign="top" height="175px" width="10%"><span class="small-text"><%= strTextWhatCouldBeBarriersToTeamEffec %><!--What could be barriers to team effectiveness between us?--></span></td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
	</tr>
	<tr>
		<td class="with-border" valign="top" height="175px" width="10%"><font size="3"><span class="small-text"><%= strTextWhatMayCreateConflictBetweenUs %><!--What may create conflict between us?--></span></td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
	</tr>
	<tr>
		<td class="with-border" valign="top" height="175px" width="10%"><font size="3"><span class="small-text"><%= strTextHowDoINeedToCommunicateWithYou %><!--How do I need to communicate with you?--></span></td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
	</tr>
	<tr>
		<td class="with-border" valign="top" height="175px" width="10%"><font size="3"><span class="small-text"><%= strTextGivenMyPersonalStyleHowDoYouTh %><!--Given my personal style, how do you think I need you to communicate with me?--></span></td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
	</tr>
</table>




 <DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h1>
<%= strTextTeamBuildingWorksheet %><!--Team Building Worksheet-->
</h1>


<table WIDTH="100%" BORDER="1" CELLSPACING="1" CELLPADDING="5" class="with-border" ID="Table9">
	<tr>
		<td class="with-border" width="10%">&nbsp;</td>
		<td class="with-border"><font size="2"><span class="small-text"><%= strTextName %><!--Name-->:<br><br><%= strTextTemperament %><!--Temperament-->:<br><br></span></td>
		<td class="with-border"><font size="2"><span class="small-text"><%= strTextName %><!--Name-->:<br><br><%= strTextTemperament %><!--Temperament-->:<br><br></span></td>
		<td class="with-border"><font size="2"><span class="small-text"><%= strTextName %><!--Name-->:<br><br><%= strTextTemperament %><!--Temperament-->:<br><br></span></td>
	</tr>
	<tr>
		
		<td class="with-border" valign="top" height="175px" width="10%"><span class="small-text"><%= strTextWhatCouldBeBarriersToTeamEffec %><!--What could be barriers to team effectiveness between us?--></span></td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
	</tr>
	<tr>
		<td class="with-border" valign="top" height="175px" width="10%"><font size="3"><span class="small-text"><%= strTextWhatMayCreateConflictBetweenUs %><!--What may create conflict between us?--></span></td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
	</tr>
	<tr>
		<td class="with-border" valign="top" height="175px" width="10%"><font size="3"><span class="small-text"><%= strTextHowDoINeedToCommunicateWithYou %><!--How do I need to communicate with you?--></span></td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
	</tr>
	<tr>
		<td class="with-border" valign="top" height="175px" width="10%"><font size="3"><span class="small-text"><%= strTextGivenMyPersonalStyleHowDoYouTh %><!--Given my personal style, how do you think I need you to communicate with me?--></span></td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
		<td class="with-border">&nbsp;</td>
	</tr>
</table>




 <DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h1><%= strTextTheDISCProfileSystem %></h1>

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
</html>