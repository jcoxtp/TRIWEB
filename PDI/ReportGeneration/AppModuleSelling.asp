<%@ Language=VBScript %>
<% intPageID = 66 %>
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
	Dim pageFull

	strTopPgSpacing = ""
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
		username1 = oRs("FirstName")
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

<!-- Beginning of Cover Page --------------------------------------------------------------------------------->
		<TABLE WIDTH="612" BORDER="0" align="center" CELLPADDING="0" CELLSPACING="0">
			<TR>
				<TD COLSPAN="4"><IMG SRC="images/selling_pdf_cover_01.gif" WIDTH="612" HEIGHT="45" ALT=""></TD>
			</TR>
			<TR>
				<TD><IMG SRC="images/selling_pdf_cover_02.gif" WIDTH="37" HEIGHT="279" ALT=""></TD>
				<TD COLSPAN="2"><IMG SRC="images/selling_pdf_cover_03.jpg" WIDTH="406" HEIGHT="279" ALT=""></TD>
				<TD><IMG SRC="images/selling_pdf_cover_04.gif" WIDTH="169" HEIGHT="279" ALT=""></TD>
			</TR>
			<TR>
				<TD COLSPAN="4"><IMG SRC="images/<%=strLanguageCode%>/selling_pdf_cover_05.gif" WIDTH="612" HEIGHT="128" ALT=""></TD>
			</TR>
			<TR>
				<TD background="images/selling_pdf_cover_06.gif" WIDTH="612" HEIGHT="259" COLSPAN="4"><%=UserName%><br>
					<%=TestDate%>
				</TD>
			</TR>
			<TR>
				<TD COLSPAN="2"><IMG SRC="images/<%=strLanguageCode%>/PDICover.gif" WIDTH="126" HEIGHT="81" ALT=""></TD>
				<TD COLSPAN="2"><IMG SRC="images/selling_pdf_cover_08.gif" WIDTH="486" HEIGHT="81" ALT=""></TD>
			</TR>
			<TR>
				<TD><IMG SRC="images/spacer.gif" WIDTH="37" HEIGHT="1" ALT=""></TD>
				<TD><IMG SRC="images/spacer.gif" WIDTH="89" HEIGHT="1" ALT=""></TD>
				<TD><IMG SRC="images/spacer.gif" WIDTH="317" HEIGHT="1" ALT=""></TD>
				<TD><IMG SRC="images/spacer.gif" WIDTH="169" HEIGHT="1" ALT=""></TD>
			</TR>
		</TABLE>
		<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<!-- END OF Cover Page --------------------------------------------------------------------------------->
		
		<div id="SellingContent" style="width:750px; margin:0px auto; align:center; text-align:left; padding:15px; background-color:#ffffff;">
<!-- Beginning of PAGE 1 --------------------------------------------------------------------------------->		
		
						<br>
						<br>
						<p>
						<% strTemp=Replace(strTextWhenYouCompletedThePDI, "{{UserName1}}", UserName1) 
strTemp = Replace(strTemp, "{{HighType1}}", HighType1) 
Response.Write strTemp%> <!--	When you completed the Personal DISCernment® Inventory, you identified the 
	particular pattern that best reflects your behavioral tendencies. <%=UserName1%>, based on the 
	&quot;Composite Graph&quot; of your Personal DISCernment® Inventory, your predominant style is 
	that of a high &quot;<%=HighType1%>&quot;. -->
						</p>
						<p>
						<% If NOT IsFakeResults then%>
						<img src="../disccompositesmall.asp?nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" align="left" hspace="12" v:shapes="_x0000_s1026">
						<% End If %>
						<em>
							<%= strTextThePersonalDiscernmentInventory %>
						</em>
						<BR> <!--The Personal DISCernment® Inventory measures-->
						<%= strTextFourFactorsdISAndCThatInfluenc %> <!--four factors (D, I, S, and C) that influence behavioral styles. Although everyone has 
	threads of all four factors woven into our basic temperament, most of us find that one or 
	perhaps two of the factors express themselves more strongly than the others in our 
	behavioral style. Each person's temperament is, in part, an expression of the way the 
	four factors combine. For example, a High I who is also a fairly High D will approach 
	things differently than a High I whose D is low. -->
						<br>
						<br>
						<%= strTextHoweverInOrderToMaximizeUnders %> <!--However, in order to maximize understanding and application in this module, we focus 
	primarily on the &quot;pure&quot; types, considering only the tendencies we can expect from our 
	most predominant factor. Although these are brief summaries, describing only a few of 
	the elements that influence behavior in a given arena, even this level of understanding 
	can greatly improve the way you relate to others.-->
						</p>
						
						<h1>
						<%= strTextTheArtOfPersuasion%> <!--The Art of Persuasion-->
						</h1>
						
						<p>
						<%= strTextWebsterDefinesTheWordPersuasio%> <!--Webster defines the word persuasion as being able &quot;to win over to a course of action by 
	reasoning or inducement. To make a person believe something.&quot;-->
						</p>
						<p>
						<%= strTextWhenWePersuadeWeSuccessfullyIn %> <!--When we persuade, we successfully influence another's thinking toward a decision or in 
	a direction, yet within that person's own boundaries of willingness. To persuade means 
	to resolve, change, or form another's feelings or opinion in an effective but reputable 
	manner.-->
						</p>
						<p>
						<%= strTextHumanHistoryAttestsToThePowerO %> <!--Human history attests to the power of persuasion. The ancient Romans believed that of 
	all the liberal arts, rhetoric (the ability to use language persuasively) overrode all other 
	talents. Every social, religious, or political revolution has had at its core a powerful 
	catalyst known as persuasion. In a free enterprise system, it is the way we do business.-->
						</p>
						
						<h1>
						<%= strTextPersuasionCommunicationAndSale %> <!--Persuasion, Communication, and Sales-->
						</h1>
						
						<p>
						<%= strTextNowhereIsThePowerOfPersuasionM %> <!--Nowhere is the power of persuasion more graphically exemplified than in that unique 
	human interaction known as the buyer/seller relationship. Today, as never before, the 
	professional salesperson's job is as complex as it is interesting and rewarding. 
	Successful selling requires a broad range of skills and knowledge, and, most of all, 
	selling requires effective communication. This module concentrates on that aspect of 
	sales.-->
						</p>
						<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<!-- END of PAGE 1 --------------------------------------------------------------------------------------->

<!-- Beginning of PAGE 2 --------------------------------------------------------------------------------->		
	<h1>
		<%= strTextInAnyCommunicationSituationYou %><!--In any communication situation, you want to accomplish certain objectives:-->
	</h1>


<ul>
	<li><%= strTextGetTheOrderSetAnAppointment %><!--Get the order, set an appointment--></li>
	<li><%= strTextTakeTheNextStepInTheProcess %>,<!--Take the next step in the process-->&nbsp;<%= strTextOr%><!--, or--></li>
	<li><%= strTextGetApprovalToStartAProject %><!--Get approval to start a project. --></li>
</ul>

<p>
	<%= strTextItIsImportantToUnderstandThatA %><!--It is important to understand that a buyer also has objectives when faced with a selling 
	situation, and understanding the buyer's objectives, wants, and needs is critical to 
	success.-->
</p>

<p>
	<%= strTextThisModuleWillHelpYouToRecogni %><!--This module will help you to recognize your personal persuasion style and the particular 
	strengths and weaknesses that go with it. Buyers also have their own decision-making 
	styles. Not only will you learn how to identify those styles, but you will also discover 
	ways of adapting your style to meet the buyer's needs.-->
</p>


	<h1>
		<%= strTextHowHasSalesChanged %><!--How has Sales Changed?-->
	</h1>


<p>
	<%= strTextThisCenturyWillBeTurbulentRisk %><!--This century will be turbulent, risky, and unforgiving, but at the same time full of 
	opportunity, challenge, and adventure. The promises of the 90s are no longer sufficient 
	for success, or even survival. The business environment of the current decade will be 
	characterized by increasing competitive intensity, continued consolidation of 
	customer/client base, and more stringent demands for quality products and services. 
	The old ways of doing business just won't work, and nowhere is this challenge greater 
	than in sales.-->
</p>

<p>
	<%= strTextThe90sTaughtUsTheLessonsOfOnti %><!--The 90s taught us the lessons of on-time delivery, high levels of customer service, and 
	superior quality. For the most part, the companies that did not learn these lessons did 
	not survive. With the turn of the century come new lessons to be learned, one of which 
	is how to differentiate our product or services in the face of increasing commodity 
	pressures, or &quot;me too&quot; competition. What, then, differentiates one offering from another? 
	More than ever before, the critical ingredient becomes the salesperson who 
	understands the needs of the customer and who controls the intangible side of the sale 
	as well.-->
</p>

<p>
	<%= strTextTheLoudestVoiceAndTheMostOutra %><!--The loudest voice and the most outrageous claims no longer win the prize. Today's 
	market is buyer-oriented, and the salesperson must find out what the buyer needs as 
	well as how the buyer likes to be approached. Success demands that the salesperson 
	find common ground and build a relationship from the inside out.-->
</p>

<table border="0">
	<tr>
		<td>
			<%= strTextSuccessfulSalesStrategiesInThe %><!--Successful sales strategies in the next century will move:--><br><br>
		</td>
		<td rowspan="2" valign="top">
			<img SRC="images/appmodselling_common<%= strLanguageCode %>.jpg">
		</td>
	</tr>
	<tr>
		<td>
			<ul>
				<li><%= strTextFromOneshotDealsToLongtermRela %><!--From one-shot deals to long-term relationships--></li>
				<li><%= strTextFromTransactionalToConsultativ %><!--From transactional to consultative approaches--></li>
				<li><%= strTextTowardIncreasedCommitmentAndPa %><!--Toward increased commitment and partnering with key customers/clients--></li>
				<li><%= strTextTowardOfferingGreaterExpertise %>&nbsp;<%= strTextProductsOrServicesButAlsoLogis %><!--Toward offering greater expertise to customers/clients, not only about products or services, but also logistics, systems, methods, and marketing--></li>
			</ul>
		</td>
	</tr>
</table>


<p>
	<%= strTextTheIncreasedComplexitiesOfSust %><!--The increased complexities of sustaining long-term/team relationships and dealing with 
	augmented definitions of products and services place greater demands on our ability to 
	communicate. As a result, salespeople today succeed only when they can:-->
</p>

<ul>
	<li><%= strTextEarnBuyerTrustByBuildingPositi %><!--Earn buyer trust by building positive interpersonal relationships--></li>
	<li><%= strTextUnderstandTheBuyersSpecificHie %><!--Understand the buyer's specific hierarchy of needs and wants--></li>
	<li><%= strTextStrengthenRelationshipsWithExi %><!--Strengthen relationships with existing buyers by aligning the strategic intents of both companies--></li>
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


	<h1>
		<%= strTextTheSecretOfSuccessfulSelling %><!--The Secret of Successful Selling-->
	</h1>
<br>
<div style="float:right"><img SRC="images/perfectsalesmen.gif" WIDTH="224" HEIGHT="252"></div>
<%= strTextItWouldBeNiceIfWeCouldCombineT %> <!--It would be nice if we could combine the perfect sales system with the perfect 
salesperson. Obviously, the perfect salesperson doesn't exist. Each person sells 
differently, and certainly more than one sales style can be effective.-->
<br>
<br>
<%= strTextEachOfUsHasADistinctivePersonal %> <!--Each of us has a distinctive personal style that is based on our unique personality, and 
we tend to use it most of the time in sales situations. As salespeople, we tend to &quot;sell to 
ourselves,&quot; making points and behaving in a manner that would lead us to buy.-->





<p>
	<%= strTextHoweverPsychologistsTellUsThat %><!--However, psychologists tell us that the average salesperson, using his or her own sales 
	style, tends to make the wrong sales approach in three out of four calls! Seventy-five 
	percent of the time, salespeople are actually turning off target customers.-->
</p>

<p>
	<%= strTextWhy %><!--Why-->? <%= strTextBecauseOurTargetCustomersAreAs %><!--Because our target customers are as individual as fingerprints, and their 
	behavioral styles may differ drastically from ours. Successful salespeople must be 
	experts at diagnosing all components of a selling situation: the market, the competition, 
	the timing, the corporate culture, and especially the buyer and the decision-making process.-->
</p>

<p>
	<%= strTextOurObjectiveHereIsToLookAtOneP %><!--Our objective here is to look at one particular facet of selling: how personality impacts 
	the way sellers and buyers communicate with each other. We can generally view any 
	sales effort from two broad dimensions: process (the selling cycle) and approach (how 
	we implement the process). The process seldom varies. However, the approach always 
	varies depending on the selling situation.-->
</p>

<p>
	<%= strTextTheSecretIsToLearnToSellPeople %><!--The secret is to learn to sell people the way they want to be sold, not the way we want 
	to sell them. We must recognize the buyer's temperament so that we can adapt our 
	approach to suit each buyer's individual behavioral style. We must react to the total 
	situation, and that Includes the buyer's personality. -->
</p>

<p>
	<%= strTextTheSpecificObjectiveOfThisAppl %><!--The specific objective of this application module is to help you increase your 
	sales/communication effectiveness by:-->
</p>

<ul>
	<li><%= strTextUnderstandingTheStrengthsAndWe %><!--Understanding the strengths and weaknesses of different selling styles&#151; especially your own.--></li>
	<li><%= strTextReadingTheUniqueWantsAndNeedsO %><!--Reading the unique wants and needs of your listeners (customers, decision-makers, team members, colleagues).--></li>
	<li><%= strTextAdaptingApproachesToCommunicat %><!--Adapting approaches to communicate most effectively with individual target customers.--></li>
</ul>

<p>
	<%= strTextFirstLetsLookAtYourBehavioralT %>&#153;<!--First, let's look at your behavioral tendencies in selling/communication situations, using 
	the <strong>DISC</strong> Profile System.&#153;-->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


	<h1>
		<%= strTextPersuasionampPersonality %><!--Persuasion &amp; Personality-->
	</h1>


<p>
	<% strTemp = Replace(strTextYourPredominantStyleIsThatOfAH, "{{HighType1}}", HighType1) %>
	<%=UserName1%>, <%= strTemp %><!--your predominant style is that of a high <%=HighType1%>. In the very broadest of 
	terms, we might describe the high {{HighType1}} sales person as follows:-->
</p>


<% If HighType1 = "D" then %>
		<!--#Include FILE="AppModuleSelling_pp_d.asp" -->
<% elseif HighType1 = "I" then %>
	<!--#Include FILE="AppModuleSelling_pp_i.asp" -->
<% elseif HighType1 = "S" then %>
	<!--#Include FILE="AppModuleSelling_pp_s.asp" -->
<% else %>
	<!--#Include FILE="AppModuleSelling_pp_c.asp" -->
<% end if %>

<%If HighType1 <> "D" then %>
	<!--#Include FILE="AppModuleSelling_pp_d_b.asp" -->
	<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	<h1>
		<%= strTextPersuasionampPersonality %><!--Persuasion &amp; Personality-->
	</h1>
<% End If


  If HighType1 <> "I" then %>
	<!--#Include FILE="AppModuleSelling_pp_i_b.asp" -->
<%
		If HighType1 = "D" then %>
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<h1>
				<%= strTextPersuasionampPersonality %><!--Persuasion &amp; Personality-->
			</h1>
	<% End If
  End If

  If HighType1 <> "S" then %>
	<!--#Include FILE="AppModuleSelling_pp_s_b.asp" -->
<%End If 

  If  HighType1 <> "C" then%>
	<!--#Include FILE="AppModuleSelling_pp_c_b.asp" -->
<% end if 
	pageFull = 0
%>


<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
										
										
<h1>
<% strTemp = Replace(strTextStrengthsampWeaknessesAsAHighh, "{{HighType1}}", HighType1) %>
<%= strTemp %> <!--Strengths &amp; Weaknesses as a High <%=HighType1%> Salesperson-->
</h1>

<%If HighType1 = "D" then %>
<!--#Include FILE="AppModuleSelling_sw_d.asp" -->
<% elseif HighType1 = "I" then %>
<!--#Include FILE="AppModuleSelling_sw_i.asp" -->
<% elseif HighType1 = "S" then %>
<!--#Include FILE="AppModuleSelling_sw_s.asp" -->
<% else %>
<!--#Include FILE="AppModuleSelling_sw_c.asp" -->
<% end if %>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


	<h1>
		<%= strTextIdentifyingTheStyleOfOthers %><!--Identifying the Style of Others-->
	</h1>


<p>
	<%= strTextToSuccessfullyAdaptYourSalesSt %><!--To successfully adapt your sales style to better match the temperament of your 
	customer, you must first be able to identify the style of that individual. Obviously, we 
	can't always administer the Personal DISCernment® Inventory (PDI), so how can we 
	recognize the temperament of others? One of the strengths of the PDI, as well as other 
	DISC instruments, is that it deals largely with &quot;observable&quot; behavior. A careful, informed 
	observation can help you develop a reasonably accurate &quot;guesstimate&quot; 
	of someone's personal style. -->
</p>


	<h1>
		<%= strTextInIdentifyingTheStylesOfOthers %><!--In identifying the styles of others the following principles will help:-->
	</h1>


<ul>
	<li><em><%= strTextUnderstandTheLimitationsOfTryin %></em><!--Understand the limitations of trying to identify others' styles by observation alone.--></em><br>
	<%= strTextAlthoughCertainlyInfluencedByI %><br /><br /><!--Although certainly influenced by inner, unseen forces, behavior is not clear evidence 
	of values, motives, intelligence, feelings, or attitudes. As you observe a person 
	behaving or &quot;acting&quot; in a certain manner, don't ascribe the underlying emotion or 
	motive. Confine your conclusions to &quot;observable&quot; behavior. -->
	</li>
	<li>
	<em><%= strTextWithholdFinalJudgmentUntilYouHa %></em> <!--Withhold final judgment until you have had more than one encounter.--></em><br>
	<%= strTextOftenItTakesTimeToDevelopTheCo %><br /><br /><!--Often it takes time to develop the confidence that you have accurately assessed an 
	individual. If others don't trust you or don't perceive the environment as safe, they 
	may put up a mask. Create an atmosphere that encourages others to be themselves.-->
	</li>
	<li>
	<em><%= strTextPayParticularAttentionToNonverb %></em><!--Pay particular attention to nonverbal communication.--></em><br>
	<%= strTextWordsAccountForLessThan10Perce %><br /><br /><!--Words account for less than 10 percent of any communication. Watch the body 
	language, facial expressions, and gestures of the other individual. For example, an 
	action-oriented person may be more animated with gestures, use more vocal inflection and facial expressions.-->
	</li>
	<li>
	<em><%= strTextUseYourKnowledgeToIncreaseYourU %></em><!--Use your knowledge to increase your understanding of and response to others' needs.--></em> <br>
	<%= strTextYourAbilityToRecognizeStylesIn %><br /><br /><!--Your ability to recognize styles in others, coupled with an understanding of the 
	needs of various styles, can greatly increase your effectiveness as a salesperson.-->
	</li>
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>

<h1>
	<%= strTextIdentifyingTheStyleOfOthers %><!--Identifying the Style of Others-->
</h1>			

<p><%= strTextLetsReviewTheFourelementModelT %></p> <!--Let's review the four-element model that we introduced in the PDI.-->

<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/fourelementmodel.gif"><br>
	<b><%= strTextFigure1 %> <!--Figure 1--></b>
</div>

<p>
<%= strTextOnTheFollowingPagesWeExpandOnTh %> <!--On the following pages, we expand on this model to identify the more visible behavioral 
tendencies of different styles.-->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h1>
<%= strTextPeopleVsTask %> <!--People vs. Task-->
</h1>

<p>
<%= strTextUsingThisModelWeCanSeeInFigure %> <!--Using this model, we can see in Figure 2 that those to the right of the vertical line are 
more people-oriented and those to the left are more task-oriented. These groups also 
have certain &quot;observable&quot; characteristics. People-oriented individuals tend to connect 
more readily with others, often with warmth and openness. On the other hand, task-
oriented people are generally cooler, more reserved, and somewhat less expressive. -->
</p>

<div style="text-align:center">
	<img SRC="images/<%=strLanguageCode%>/peoplevtaskvertical.gif"><br>
	<b><%= strTextFigure2 %> <!--Figure 2--></b>
</div>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h1>
<%= strTextActionVsResponse %> <!--Action vs. Response-->
</h1>

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
<%= strTextHowToIdentifyAHighDBuyer %> <!--How to Identify a High D Buyer-->
</h1>

<p>
<%= strTextHighDBuyersComeOnStrongOftenTe %> <!--High D buyers come on strong, often testing a seller by applying pressure early in the 
relationship to see what the reaction will be. Frequently, the High D buyer will run late 
and may appear rude when first approached. During the sales call, the High D may 
interrupt you, take calls, read letters, and give instructions to his or her administrative 
assistant, all the time saying something like, &quot;Keep talking. I'm listening.&quot;-->
</p>

<h3>
<%= strTextHighDsAreUsuallyInterestedInNe %> <!--High D's are usually interested in new products and innovations.-->
</h3>

<p>
<%= strTextTheHighDsOfficeAndDeskMayBeDis %> <!--The High D's office and desk may be disorganized, but what the seller will most quickly 
recognize is this buyer's impatience and impulsiveness. The High D buyer will want 
options, presented at a rapid pace, from which to make a decision. High D buyers can 
be intimidating and may take control of the situation.-->
</p>

<h3>
<%= strTextTheHighDsExpectations %> <!--The High D's Expectations-->
</h3>

<p>
<%= strTextHighDsExpectSellersToAdoptABus %> <!--High D's expect sellers to adopt a businesslike attitude. They have a job to do, and they 
prefer to concentrate on that. They expect sellers to make efficient use of their time. 
They tend to be busy people who operate from schedules and lists of things to do. They 
like to see that they are making progress.-->
</p>
<p>
<%= strTextDsWantYouToProvideThemWithEvid %> <!--D's want you to provide them with evidence early in the process. They want to deal with 
someone who is competent and self-confident&#151;someone they can respect. They 
expect you to present your product or service in terms of how it will solve their 
problems. They aren't afraid to take risks, but they expect you to provide them with 
probabilities associated with the risk.-->
</p>

<br><br>

<h1>
<%= strTextHowToIdentifyAHighIBuyer %> <!--How to Identify a High I Buyer-->
</h1>

<p>
<%= strTextHighIBuyersAreFriendlyPeopleor %> <!--High I buyers are friendly, people-oriented folks who usually would rather talk and 
socialize than do detail work. They will have awards, certificates, trophies, and photos 
featured on the wall. You'll know who lives there, and the ego will be evident. High I's 
will be glad to see you arrive; they will trade jokes and stories, and won't want to 
discuss business too much. They talk a lot about themselves. They will interrupt and 
digress occasionally, but they are generally enthusiastic and receptive, particularly if 
your product or service is innovative and the latest.-->
</p>
<p>
<%= strTextTheHighIBuyerWillBeWelldressed %> <!--The High I buyer will be well-dressed and poised. They are motivated by how an 
offering will impact their goals and personal expectations. The approval of the High I's 
management is extremely important.-->
</p>

<h3>
<%= strTextTheHighIsExpectations %> <!--The High I's Expectations-->
</h3>

<p>
<%= strTextHighIBuyersExpectYouToBeTolera %> <!--High I buyers expect you to be tolerant of their casual use of time. They aren't clockwatchers and don't want you to be 
either. Once they make a decision, however, they want quick results.-->
</p>
<p>
<%= strTextHighIsLikeToKnowWhoTheyreDeali %> <!--High I's like to know who they're dealing with. They want to know what you think and 
how you feel about things.-->
</p>
<p>
<%= strTextHighIsExpectYouToSupportThemPe %> <!--High I's expect you to support them personally and may be sensitive to how you work 
with their management. They like positive feedback that helps them relate to you 
personally.-->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
	
<h1>
<%= strTextHowToIdentifyAHighSBuyer %> <!--How to Identify a High S Buyer-->
</h1>

<p>
<%= strTextHighSBuyersWillUsuallyHavePict %> <!--High S buyers will usually have pictures on the office wall&#151;not only of themselves, but 
also of family members and possessions.-->
</p>
<p>
<%= strTextThisPersonWillMostLikelyHaveAN %> <!--This person will most likely have a name plate on the door or desk, or both.-->
</p>
<p>
<%= strTextAlthoughTheyAppearEasygoingAnd %> <!--Although they appear easygoing and personable, the High S buyer is very security 
conscious and possessive, so be careful what you touch. They also resist sudden 
change. They like proven, traditional concepts.-->
</p>
<p>
<%= strTextThisPersonWillBeSincereOpenAmi %> <!--This person will be sincere, open, amiable, and relationship-oriented, after an initial 
shyness. They need to be able to trust you.-->
</p>
<p>
<%= strTextYouCantJudgeThisBookByItsCover %> <!--You can't judge this book by its cover: dress will be varied, ranging from frumpy to high 
style.-->
</p>

<h3>
<%= strTextTheHighSsExpectations %> <!--The High S's Expectations-->
</h3>

<p>
<%= strTextHighSBuyersExpectYouToTakeTime %> <!--High S buyers expect you to take time to develop the relationship: to be willing to build a 
personal as well as a business relationship. They want to make fairly slow, deliberate 
progress.-->
</p>
<p>
<%= strTextHighSBuyersExpectYouToPresentT %> <!--High S buyers expect you to present the benefits of your product or service in terms of 
why it is the best solution to their problem. They want guarantees and assurances, 
since they are not assertive risk takers. They make decisions cautiously, and they want 
others to affirm those decisions.-->
</p>

<br><br>

<h1>
<%= strTextHowToIdentifyAHighCBuyer %> <!--How to Identify a High C Buyer-->
</h1>

<p>
<%= strTextHighCBuyersWorkInNeatOrderlyOf %> <!--High C buyers work in neat, orderly offices. In most cases, their desks will be clean. 
The High C will be prepared for the visit, on time, and will have read any advance 
material. The atmosphere will be businesslike, but unhurried and deliberate. The High C 
buyer may be suspicious of you and your products.-->
</p>
<p>
<%= strTextTheHighCWillExhibitAPreciseRes %> <!--The High C will exhibit a precise, restrained manner, but will be courteous and 
diplomatic. A stickler for accuracy and thoroughness, the High C will be process-
oriented, with an emphasis on detailed organization. High C buyers are not innovators. 
They will not readily try out new and innovative technology.-->
</p>
<p>
<%= strTextHighCsWillDressConservativelyA %> <!--High C's will dress conservatively and unobtrusively. They don't want their clothes to 
call attention to them.-->
</p>

<h3>
<%= strTextTheHighCsExpectations %> <!--The High C's Expectations-->
</h3>

<p>
<%= strTextHighCBuyersExpectTheSalesCallT %> <!--High C buyers expect the sales call to move at a pace that provides them with just 
enough time to consider the key points thoughtfully.-->
</p>
<p>
<%= strTextHighCBuyersWillWantYouToPresen %> <!--High C buyers will want you to present all the facts you have at your disposal and will 
then want time to think about the data before making a decision.-->
</p>
<p>
<%= strTextLikeHighSsHighCBuyersWantGuara %> <!--Like High S's, High C buyers want guarantees and assurances to protect them if 
something goes wrong.-->
</p>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
																	
																	
<h1>
<%= strTextQuestionsThatBuyersMightAsk %> <!--Questions that Buyers Might Ask-->
</h1>

<p>
<%= strTextInSalesSituationsYouCanOftenId %> <!--In sales situations, you can often identify buyers' behavioral styles by listening carefully 
to the questions they ask. Here are some typical questions that D, I, S, and C buyers 
will ask about your product or service.-->
</p>

<table align="center" width="100%" cellpadding="1px" class="with-border" ID="Table1">
	<tr>
		<td height="410px" width="50%" class="with-border">
			<div style="position: relative; height: 100%;"> 
			<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;
							font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
				D
			</div>
			<div style="LEFT: 0px; POSITION: absolute; TOP: 10px; Z-Index:100">
				<!-- D Content -->
				<ul>
					<li><%= strTextWillItGetResults %><!--Will it get results?--></li>
					<li><%= strTextWillItDoWhatYouSayItWillDo %><!--Will it do what you say it will do?--></li>
					<li><%= strTextHowWillThisProductHelpMeMeetMy %><!--How will this product help me meet my goals?--></li>
					<li><%= strTextHowWillItImproveMyBottomLine %><!--How will it improve my bottom line?--></li>
					<li><%= strTextWillItWorkNow %><!--Will it work now?--></li>
					<li><%= strTextWhatDoesItCost %><!--What does it cost?--></li>
					<li><%= strTextWhatsTheValue %><!--What's the value?--></li>
					<li><%= strTextWhatIsYourCompanysRecord %><!--What is your company's record?--></li>
					<li><%= strTextHowLongHaveYouBeenSellingThis %><!--How long have you been selling this?--></li>
					<li><%= strTextAreYouSureYouKnowWhatYoureTalk %><!--Are you sure you know what you're talking about?--></li>
					<li><%= strTextHowManyHaveYouSold %><!--How many have you sold?--></li>
					<li><%= strTextHowFastCanIGetIt %><!--How fast can I get it?--></li>
					<li><%= strTextWhatWillItDoForMyCompany %><!--What will it do for my company?--></li>
					<li><%= strTextIsThisTheBestYouHaveToOffer %><!--Is this the best you have to offer?--></li>
					<li><%= strTextHowQuicklyWillItBeOnLine %><!--How quickly will it be on line?--></li>
					<li><%= strTextIsThisProductUptodate %><!--Is this product up-to-date?--></li>
					<li><%= strTextIfItDoesntWorkHowWillYouFixIt %><!--If it doesn't work, how will you fix it?--></li>
					<li><%= strTextWhatAreTheOptions %><!--What . . . 	are the options?--><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;. . .
						<%= strTextAreTheProbabilities %> <!--are the probabilities?-->
						<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;. . .
						<%= strTextAreTheResults %> <!--are the results?--></li>
				</ul>
			</div>
			</div>
		</td>
		<td height="410px" width="50%" class="with-border">
			<div style="position: relative; height: 100%";> 
			<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;		font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
				I
			</div>
			<div style="LEFT: 0px; POSITION: absolute; TOP: 10px; Z-Index:100">
				<!-- I Content -->
				<ul>
					<li><%= strTextWillYouSitDownSoWeCanTalkAbout %><!--Will you sit down so we can talk about this? Coffee?--></li>
					<li><%= strTextCanYouTellMeALittleAboutYourse %><!--Can you tell me a little about yourself? Your company?--></li>
					<li><%= strTextWhatKindsOfPremiumsOrIncentive %><!--What kinds of premiums or incentives are available?--></li>
					<li><%= strTextCanYouGiveMeASpecialDeal %><!--Can you give me a special deal?--></li>
					<li><%= strTextWhatWillItTakeForUsToWinTheCon %><!--What will it take for us to win the contest?--></li>
					<li><%= strTextImExcitedAboutThePurchaseDidYo %><!--I'm excited about the purchase. Did you watch the game Sunday?--></li>
					<li><%= strTextWillMyBossesApproveOfThisProdu %><!--Will my bosses approve of this product?--></li>
					<li><%= strTextHowWillThisHelpMeWithThePeople %><!--How will this help me with the people I work with?--></li>
					<li><%= strTextWhoElseUsesThisProduct %><!--Who else uses this product?--></li>
					<li><%= strTextWhatDoOthersSayAboutTheProduct %><!--What do others say about the product?--></li>
					<li><%= strTextWhyIsThisTheBestAvailable %><!--Why is this the best available?--></li>
					<li><%= strTextIsThisTheFirstApplicationOfThi %><!--Is this the first application of this product?--></li>
					<li><%= strTextIsThisYourBestSellingProduct %><!--Is this your best selling product?--></li>
					<li><%= strTextHowSoonCanITellMyBossWellHaveI %><!--How soon can I tell my boss we'll have it?--></li>
					<li><%= strTextWhenCanISayItWillBeOnLine %><!--When can I say it will be on line?--></li>
					<li><%= strTextIsThisTheNewestOnTheMarket %><!--Is this the newest on the market?--></li>
					<li><%= strTextIsThisProductWellacceptedByOth %><!--Is this product well-accepted by others? Who?--></li>
					<li><%= strTextWhatHappensIfIChangeMyMind %><!--What happens if I change my mind?--></li>
					<li><%= strTextWillYouBeThePersonIShouldCallI %><!--Will you be the person I should call if something goes wrong?--></li>
					<li><%= strTextWhoAreYou %><!--Who . . . 	are you?--><br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;. . .
							<%= strTextDoYouKnow %> <!-- do you know?-->
							<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;. . .
							<%= strTextUsesYourProductOrService %> <!--uses your product or service?--></li>
				</ul>
			</div>
			</div>
		</td>
	</tr>
	<tr>
		<td height="455px" width="50%" class="with-border">
			<div style="position: relative; height: 100%";> 
			<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;		font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
				C
			</div>
			<div style="LEFT: 0px; POSITION: absolute; TOP: 10px; Z-Index:100">
				<ul>
					<li><%= strTextWhoHasUsedorTestedThisProductB %><!--Who has used (or tested) this product before?--></li>
					<li><%= strTextCanYouTellMeMoreIStillDontSeeH %><!--Can you tell me more? I still don't see how this works.--></li>
					<li><%= strTextWhoMakesThisProduct %><!--Who makes this product?--></li>
					<li><%= strTextHowIsItMade %><!--How is it made?--></li>
					<li><%= strTextHowLongHaveYouBeenMakingIt %><!--How long have you been making it?--></li>
					<li><%= strTextCanYouTellMeAboutTheWarranty %><!--Can you tell me about the warranty?--></li>
					<li><%= strTextHowMuchDoesTheExtendedWarranty %><!--How much does the extended warranty cost?--></li>
					<li><%= strTextWhoWillPayForDelivery %><!--Who will pay for delivery?--></li>
					<li><%= strTextHowCanYouBeSureThatThisWillHav %><!--How can you be sure that this will have the same quality as the previous model?--></li>
					<li><%= strTextCanISeeTheTestResults %><!--Can I see the test results?--></li>
					<li><%= strTextCanIThinkAboutItAndGetBackToYo %><!--Can I think about it and get back to you?--></li>
					<li><%= strTextHowSoonMustIDecideINeedTimeToR %><!--How soon must I decide? I need time to read your material.--></li>
					<li><%= strTextWillYouBeAbleToFollowMyExactSp %><!--Will you be able to follow my exact specifications?--></li>
					<li><%= strTextIsThisYourBestValueForTheMoney %><!--Is this your best value for the money?--></li>
					<li><%= strTextHowSoonWillItPayForItself %><!--How soon will it pay for itself?--></li>
					<li><%= strTextHasThisProductBeenThoroughlyTe %><!--Has this product been thoroughly tested?--></li>
					<li><%= strTextWillItDoTheJobRight %><!--Will it do the job right?--></li>
					<li><%= strTextIfItDoesntWorkHowDoIGetMyMoney %><!--If it doesn't work, how do I get my money back?--></li>
					<li><%= strTextWillItFitWithinMyEstablishedPr %><!--Will it fit within my established procedures and guidelines?--></li>
					<li><%= strTextCanYouPutYourOfferInWriting %><!--Can you put your offer in writing?--></li>
					<li><%= strTextHowCanThisProductMeetMyNeed %><!--How . . . can this product meet my need?-->
						<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;. . .
						<%= strTextDoesItWork %> <!--does it work?-->
						<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;. . .
						<%= strTextCanIBeSure %> <!--can I be sure?--></li>
				</ul>
			</div>
			</div>
		</td>
		<td height="455px" width="50%" class="with-border">
			<div style="position: relative; height: 100%";> 
			<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;		font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
				S
			</div>
			<div style="LEFT: 0px; POSITION: absolute; TOP: 10px; Z-Index:100">
				<!-- S Content -->
				
				<ul>
					<li><%= strTextWhyShouldIChangeIveBoughtFromX %><!--Why should I change? I've bought from XYZ for years with good service.  (new customer)--></li>
					<li><%= strTextWhatsThePriceIAlwaysBuyOnYourR %><!--What's the price? I always buy on your recommendations. (old customer)--></li>
					<li><%= strTextWhyHaveYouChangedTheProductorS %><!--Why have you changed the product (or service)? I was just getting used to it the way it was.--></li>
					<li><%= strTextCanIStillGetTheOldVersion %><!--Can I still get the old version?--></li>
					<li><%= strTextIfIBuyTodayCanIBeSureOfDeliver %><!--If I buy today, can I be sure of delivery in three months?--></li>
					<li><%= strTextCanYouCallMeBackInAWeekidLikeT %><!--Can you call me back in a week?	I'd like to check with some other people.?--></li>
					<li><%= strTextHowLongHasThisBeenOnTheMarket %><!--How long has this been on the market?--></li>
					<li><%= strTextIsThisYourMostReliableProduct %><!--Is this your most reliable product?--></li>
					<li><%= strTextHowSoonCanMyPeopleLearnToUseIt %><!--How soon can my people learn to use it?--></li>
					<li><%= strTextWillItProvideTheSameQualityAsT %><!--Will it provide the same quality as the old version?--></li>
					<li><%= strTextWillThisReduceTensionInMyDepar %><!--Will this reduce tension in my department?--></li>
					<li><%= strTextWhatsTheBestWayToGetMyPeopleIn %><!--What's the best way to get my people involved with this product?--></li>
					<li><%= strTextHasAnyoneHadTroubleWithThisPro %><!--Has anyone had trouble with this product?--></li>
					<li><%= strTextIfSomethingGoesWrongWhatDoIDo %><!--If something goes wrong, what do I do?--></li>
					<li><%= strTextWillItDisruptOurWayOfDoingThin %><!--Will it disrupt our way of doing things?--></li>
					<li><%= strTextCanYouMeetWithSomeOtherMembers %><!--Can you meet with some other members of my team to explain the product?--></li>
					<li><%= strTextWhyIsYourProductBest %><!--Why . . . 	is your product best?--><br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;. . .
						<%= strTextShouldIChange %> <!--should I change?-->
						<br>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;. . .
						<%= strTextShouldIDoItNow %> <!--should I do it now?--></li>
				</ul>
				
			</div>
			</div>
		</td>
	</tr>
</table>
<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h1>
	<%= strTextHowToInfluenceAndSellBuyersWho %><!--How to Influence and Sell Buyers who are-->
</h1>




<h2>
	<%= strTextTheHighDStyle %><!--The High D Style--> &#133;
</h2>

<div style="padding-left:20px">

<table ID="Table27">
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextBuildCredibilityForYourself %><!--Build credibility for yourself-->
			</h3>		
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li>	<%= strTextLetThemKnowYouValueTheirTime %><!--Let them know you value their time.--></li>
				<li>	<%= strTextBeSureOfYourselfUseStraightfor %><!--Be sure of yourself; use straightforward communication.--></li>
				<li>	<%= strTextBeConfident %><!--Be confident.--></li>
			</ul>			
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextDemonstrateResults %><!--Demonstrate results.--></li>
				<li>	<%= strTextInformTheBuyerOfYourPersonalAn %><!--Inform the buyer of your personal and corporate qualifications.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextBuildCredibilityForYourProduct %><!--Build credibility for your product or service-->
			</h3>		
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<ul>
				<li> <%= strTextStressWhyYourProductOrServiceW %><!--Stress why your product or service will help the buyer and meet his/her objectives.--></li>
				<li> <%= strTextBePreparedToShowProofOfResults %><!--Be prepared to show proof of results.--></li>
				<li> <%= strTextDemonstrateValue %><!--Demonstrate value.--></li>
			</ul>		
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextStructureYourPresentationToFit %><!--Structure your presentation to fit this style-->
			</h3>		
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">
			<ul>
				<li><%= strTextLearnAndStudyTheirGoalsAndObje %><!--Learn and study their goals and objectives.--></li>
				<li><%= strTextBePreparedAndWellorganized %><!--Be prepared and well-organized.--></li>
				<li><%= strTextBeProfessionalAndBusinesslike1 %><!--Be professional and businesslike.--></li>
				<li><%= strTextBeBriefDirectAndFastpacedAndGe %><!--Be brief, direct, and fast-paced, and get to the point quickly. &quot;What's the bottom line?&quot;--></li>
				<li><%= strTextProvideOptions1 %><!--Provide options.--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li><%= strTextSuggestSolutionsWithClearlydef %><!--Suggest solutions with clearly-defined and agreed-upon consequences as well as rewards that relate to the buyer's goals.--></li>
				<li><%= strTextClarifyRisksAndProbabilities %><!--Clarify risks and probabilities.--></li>
				<li><%= strTextHitTheBuyerQuicklyAndHardBecau %><!--Hit the buyer quickly and hard, because High D's are decisive and act on impulse.--></li>
			</ul>
		</td>
	</tr>
</table>
	
</div>

<h2>
	<%= strTextTheHighIStyle %><!--The High I Style--> &#133;
</h2>

<div style="padding-left:20px">

<table ID="Table26">
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextBuildCredibilityForYourself %><!--Build credibility for yourself-->
			</h3>	
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li><%= strTextGiveSpecialAttentionAndBeInter %><!--Give special attention and be interested and enthusiastic, without dominating the discussion.--></li>
				<li><%= strTextAffirmTheBuyersDreamsAndGoals %><!--Affirm the buyer's dreams and goals.--></li>
				<li><%= strTextProvidePlentyOfFollowup %><!--Provide plenty of follow-up.--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li><%= strTextStressHowYourProductOrServiceW %><!--Stress how your product or service will make the buyer look good or provide attention and recognition.--></li>
				<li><%= strTextInformTheBuyerOfYourPersonalAnd %><!--Inform the buyer of your personal and corporate reputation.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextBuildCredibilityForYourProduct %><!--Build credibility for your product or service-->
			</h3>
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li><%= strTextIndicateThatTheBuyerWillBeTheF %><!--Indicate that the buyer will be the first to use the product or service.--></li>
				<li><%= strTextGiveTestimonialsOfquotexpertsq %><!--Give testimonials of &quot;experts.&quot;--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li><%= strTextAppealToTheBuyersAffinityForTh %><!--Appeal to the buyer's affinity for the new, the special, and the novel.--></li>
				<li><%= strTextFocusOnTheProductsPrestigeAndR %><!--Focus on the product's prestige and reputation.--> </li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextStructureYourPresentationToFit %><!--Structure your presentation to fit this style-->
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">
			<ul>
				<li><%= strTextPresentWithStyle %><!--Present with style.--></li>
				<li><%= strTextInvolveTheBuyerInTheSellingPro %><!--Involve the buyer in the selling process; solicit his/her ideas and opinions.--></li>
				<li><%= strTextStressTheSpecialOrNovelAspects %><!--Stress the special or novel aspects of the product or service.--></li>
				<li><%= strTextPresentTestimonialsFromOthersU %><!--Present testimonials from others using the product or service.--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li><%= strTextIllustrateYourIdeasWithAnecdot %><!--Illustrate your ideas with anecdotes and emotional descriptions.--></li>
				<li><%= strTextClearlySummarizeDetailAndDirec %><!--Clearly summarize detail and direct the buyer toward mutually agreeable objectives and action steps.--></li>
				<li><%= strTextEncourageThePurchaseDecisionBy %><!--Encourage the purchase decision by offering incentives.--></li>
				<li><%= strTextBeOpenToTopicsTheBuyerIntroduc %><!--Be open to topics the buyer introduces.--></li>
				
			</ul>
		</td>
	</tr>
</table>

</div>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h2>
	<%= strTextTheHighSStyle %><!--The High S Style--> &#133;
</h2>

<div style="padding-left:20px">

<table ID="Table16">
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextBuildCredibilityForYourself %><!--Build credibility for yourself-->
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextSellYourselfFirstYouMustWinThe %><!--Sell yourself first. You must win the High S as a friend.--></li>
				<li>	<%= strTextTakeASincerePersonalInterestIn %><!--Take a sincere, personal interest in the buyer as a person.--></li>
				<li>	<%= strTextDevelopTrustFriendshipAndCredi %><!--Develop trust, friendship, and credibility slowly.--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextTakeTheTimeToBuildARelationshi %><!--Take the time to build a relationship; find common interests.--></li>
				<li>	<%= strTextFocusOnYourReliabilityAndLoyal %><!--Focus on your reliability and loyalty.--></li>
				<li>	<%= strTextCommunicateRegularlyMakeRepeat %><!--Communicate regularly; make repeat visits.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextBuildCredibilityForYourProduct %><!--Build credibility for your product or service-->
			</h3>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<ul>
				<li><%= strTextTalkSecurityServiceSafetyDepen %><!--Talk security, service, safety, dependability, and backup.--></li>
				<li><%= strTextEmphasizeThatTheProductOrServi %><!--Emphasize that the product or service won't disrupt the way things are done or have been done.--></li>
				<li><%= strTextFocusOnWhyTheProductShouldBeUs %><!--Focus on why the product should be used.--></li>
				<li><%= strTextEmphasizeProvenProducts %><!--Emphasize proven products.--></li>
			</ul>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextStructureYourPresentationToFit %><!--Structure your presentation to fit this style-->
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li><%= strTextDontMoveTooFastHighSsCanHandle %><!--Don't move too fast. High S's can handle change, but at their own pace.--></li>
				<li><%= strTextAvoidHighpressureTactics %><!--Avoid high-pressure tactics.--></li>
				<li><%= strTextDontAppearToCreateProblemsForT %><!--Don't appear to create problems for the buyer or let your product or service seem to threaten the buyer or his/her standing with the company.--></li>
				<li><%= strTextStressReliabilityServiceAndSaf %><!--Stress reliability, service, and safety.--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li><%= strTextGiveReassurancesThatTheBuyerIs %><!--Give reassurances that the buyer is making the right decision and assurances that all promises will be kept.--></li>
				<li><%= strTextIdentifyTheBuyersEmotionalNeed %><!--Identify the buyer's emotional needs as well as the task or business expectations.--></li>
				<li><%= strTextProvidePlentyOfProofAndStatist %><!--Provide plenty of proof and statistics, and give the buyer a chance to digest facts.--></li>
			</ul>
		</td>
	</tr>
</table>

</div>


<h2>
	<%= strTextTheHighCStyle %><!--The High C Style--> &#133;
</h2>


<div style="padding-left:20px">

<table ID="Table18">
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextBuildCredibilityForYourself %><!--Build credibility for yourself-->
			</h3>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<ul>
				<li><%= strTextGreetCordiallyAndGetRightToThe %><!--Greet cordially and get right to the task. Don't begin with personal or social talk.--></li>
				<li><%= strTextDemonstrateYourExpertiseYourKn %><!--Demonstrate your expertise: your knowledge of the product or service, the process, and the industry.--></li>
				<li><%= strTextBeWellPreparedSoThatYouCanAnsw %><!--Be well prepared so that you can answer all questions.--><br>
					<%= strTextFollowThroughAndDeliverWhatYou %> <!--Follow through and deliver what you promise.--></li>
			</ul>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextBuildCredibilityForYourProduct %><!--Build credibility for your product or service-->
			</h3>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<ul>
				<li>	<%= strTextUseComparativeDataResearchStat %><!--Use comparative data: research statistics, test results, etc.--></li>
				<li>	<%= strTextAppealToLogicShowingFactsAndBe %><!--Appeal to logic, showing facts and benefits.--></li>
				<li>	<%= strTextUseDetailedDocumentedEvidenceT %><!--Use detailed, documented evidence to support product or service claims.--></li>
				<li>	<%= strTextStressQualityAndReliabilityAnd %><!--Stress quality and reliability, and be able to show precedent to appeal to the buyer's caution.--></li>
			</ul>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextStructureYourPresentationToFit %><!--Structure your presentation to fit this style-->
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li>	<%= strTextBeLogicalFactualAndDetailedInY %><!--Be logical, factual, and detailed in your presentation.--></li>
				<li>	<%= strTextBePreciseAndTechnicallyCorrect %><!--Be precise and technically correct in response to the buyer's detailed questions.--></li>
				<li>	<%= strTextAskQuestionsThatRevealAClearDi %><!--Ask questions that reveal a clear direction and that fit into the overall scheme of things.--></li>
				<li>	<%= strTextAnswerAllQuestionsCarefully1 %><!--Answer all questions carefully.--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextDealWithObjectionsCompletely %><!--Deal with objections completely.--></li>
				<li>	<%= strTextStressReliabilityAndSafetyToMi %><!--Stress reliability and safety to minimize risk.--></li>
				<li>	<%= strTextGiveTheBuyerTimeToThink %><!--Give the buyer time to think.--></li>
				<li>	<%= strTextFollowUpWithAWrittenProposalTh %><!--Follow up with a written proposal; the High C buyer will usually require it.--></li>
			</ul>
		</td>
	</tr>
</table>
		
</div>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h1>
	<%= strTextCommunicationStrategy %><!--Communication Strategy-->
</h1>



<h2>
	<%= strTextWithAHighDBuyer %><!--With a High D Buyer...-->
</h2>

<div style="padding-left:20px">

<table ID="Table19">
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextToCommunicateBetterWithAHighDB %><!--To communicate better with a High D Buyer do--> &#133;
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li>	<%= strTextProvideDirectAnswersAndBeBrief %><!--Provide direct answers and be brief and to the point.--></li>
				<li>	<%= strTextStressWhatHasToBeDoneNotWhyItH %><!--Stress what has to be done, not why it has to be done.--></li>
				<li>	<%= strTextStressResults1 %><!--Stress results.--></li>
				<li>	<%= strTextProvideOptionsAndPossibilities1 %><!--Provide options and possibilities.--></li>
			</ul>	
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextEmphasizeLogicOfIdeasAndApproa %><!--Emphasize logic of ideas and approaches.--></li>
				<li>	<%= strTextAgreeWithTheFactsPositionOrIde %><!--Agree with the facts, position, or idea&#151;not just the person.--></li>
				<li>	<%= strTextAvoidRambling %><!--Avoid rambling.--></li>
				<li>	<%= strTextSummarizeAndClose %><!--Summarize and close.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextToCommunicateBetterWithAHighDBu %><!--To communicate better with a High D Buyer don't--> &#133; 
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li>	<%= strTextAppearIndecisive %><!--Appear indecisive.--></li>
				<li>	<%= strTextBeProblemOriented %><!--Be problem oriented.--></li>
				<li>	<%= strTextOverlyFriendly %><!--overly friendly.--></li>
				<li>	<%= strTextGeneralize %><!--Generalize.--></li>
			</ul>			
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextProvideTooManyDetails %><!--Provide too many details.--></li>
				<li>	<%= strTextRepeatYourselfOrTalkTooMuch %><!--Repeat yourself or talk too much.--></li>
				<li>	<%= strTextMakeUnsupportableStatements %><!--Make unsupportable statements.--></li>
				<li>	<%= strTextMakeDecisionsForThem %><!--Make decisions for them.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextAsHighDBuyersHearAndAnalyzeInf %><!--As High D Buyers hear and analyze information, they may -->&#133;
			</h3>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<ul>
				<li>	<%= strTextNotConsiderRisks %><!--Not consider risks.--></li>
				<li>	<%= strTextNotWeighProsAndCons %><!--Not weigh pros and cons.--></li>
			</ul>			
		</td>
	</tr>
</table>

</div>


<h2>
	<%= strTextWithAHighIBuyer %><!--With a High I Buyer...-->
</h2>

<div style="padding-left:20px">

<table ID="Table21">
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextToCommunicateBetterWithAHighIB %><!--To communicate better with a High I Buyer do--> &#133;
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li>	<%= strTextStressTheNewTheSpecialAndTheNo %><!--Stress the new, the special, and the novel.--></li>
				<li>	<%= strTextDemonstrateTheAbilityToBeArtic %><!--Demonstrate the ability to be articulate.--></li>
				<li>	<%= strTextStressTestimoniesOrFeedbackFro %><!--Stress testimonies or feedback from &quot;experts.&quot;--></li>
				<li>	<%= strTextProvideOpportunityForGiveAndTa %><!--Provide opportunity for give and take.--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextBeOpenFriendlyAndWarm %><!--Be open, friendly, and warm.--></li>
				<li>	<%= strTextBeEnthusiastic %><!--Be enthusiastic.--></li>
				<li>	<%= strTextListenAttentively %><!--Listen attentively.--></li>
				<li>	<%= strTextSpendTimeDevelopingTheRelation %><!--Spend time developing the relationship.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextToCommunicateBetterWithAHighIBu %><!--To communicate better with a High I Buyer don't--> &#133;
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li>	<%= strTextIgnoreTheSocialDimensions %><!--Ignore the social dimensions.--></li>
				<li>	<%= strTextDoAllTheTalking %><!--Do all the talking.--></li>
				<li>	<%= strTextRestrictSuggestionsOrInterrupt %><!--Restrict suggestions or interruptions.--></li>
				
			</ul>			
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextLetHimOrHerTakeYouTooFarOffTra %><!--Let him or her take you too far off track.--></li>
				<li>	<%= strTextBeCurtColdOrTightlipped %><!--Be curt, cold, or tight-lipped.--></li>
				<li>	<%= strTextTalkDownToThem %><!--Talk down to them.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextAsHighIBuyersHearAndAnalyzeInf %><!--As High I Buyers hear and analyze information, they may--> &#133;
			</h3>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<ul>
				<li>	<%= strTextNotConcentrate %><!--Not concentrate.--></li>
				<li>	<%= strTextIgnoreImportantFacts %><!--Ignore important facts.--></li>
				<li>	<%= strTextInterrupt %><!--Interrupt.--></li>
			</ul>			
		</td>
	</tr>
</table>
	
</div>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h2>
	<%= strTextWithAHighS %><!--With a High S...-->
</h2>

<div style="padding-left:20px">

<table ID="Table23">
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextToCommunicateBetterWithAHighSB %><!--To communicate better with a High S Buyer do--> &#133;
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li>	<%= strTextUsePatienceInDrawingOutHisherG %><!--Use patience in drawing out his/her goals.--></li>
				<li>	<%= strTextEmphasizeHowADeliberateApproac %><!--Emphasize how a deliberate approach will work.--></li>
				<li>	<%= strTextTalkServiceAndDependability %><!--Talk service and dependability.--></li>
				<li>	<%= strTextAskHowQuestionsAndGetFeedback %><!--Ask how questions and get feedback.--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextListenAttentively %><!--Listen attentively.--></li>
				<li>	<%= strTextBeSincere %><!--Be sincere.--></li>
				<li>	<%= strTextCommunicateInALowkeyRelaxedMan %><!--Communicate in a low-key, relaxed manner.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextToCommunicateBetterWithAHighSBu %><!--To communicate better with a High S Buyer don't-->&#133; 
			</h3>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<ul>
				<li>	<%= strTextBeTooDirective %><!--Be too directive.--></li>
				<li>	<%= strTextPushTooAggressivelyOrDemand %><!--Push too aggressively or demand.--></li>
				<li>	<%= strTextMoveTooFast %><!--Move too fast.--></li>
				<li>	<%= strTextOmitTooManyDetails %><!--Omit too many details.--></li>
				<li>	<%= strTextBeAbrupt %><!--Be abrupt.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextAsHighSBuyersHearAndAnalyzeInf %><!--As High S Buyers hear and analyze information, they may--> &#133;
			</h3>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<ul>
				<li>	<%= strTextBeQuietlyUnyielding %><!--Be quietly unyielding.--></li>
				<li>	<%= strTextNotBeAssertiveInCommunicatingT %><!--Not be assertive in communicating their concerns.--></li>
				<li>	<%= strTextNotProvideALotOfFeedbackDuring %><!--Not provide a lot of feedback during presentations.--></li>
				<li>	<%= strTextHesitateToMakeADecisionParticu %><!--Hesitate to make a decision, particularly if unpopular.--></li>
				<li>	<%= strTextSlowDownTheAction %><!--Slow down the action.--></li>
			</ul>			
		</td>
	</tr>
</table>

</div>



<h2>
	<%= strTextWithAHighC %><!--With a High C...-->
</h2>

<div style="padding-left:20px">

<table ID="Table24">
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextToCommunicateBetterWithAHighCB %><!--To communicate better with a High C Buyer do--> &#133;
			</h3>			
		</td>
	</tr>
	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li>	<%= strTextUseComparativeData %><!--Use comparative data.--></li>
				<li>	<%= strTextAppealToLogicShowingFactsAndBe %><!--Appeal to logic, showing facts and benefits.--></li>
				<li>	<%= strTextConcentrateOnSpecifics %><!--Concentrate on specifics.--></li>
				<li>	<%= strTextHaveAllTheFactsAndStickToThem %><!--Have all the facts, and stick to them.--></li>
				<li>	<%= strTextBeOrganized %><!--Be organized.--></li>
			</ul>
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextProvideWrittenProposalsForMajorDe %><!--Provide written proposals for major decisions.--></li>
				<li>	<%= strTextAppealToInterestInResearchStat %><!--Appeal to interest in research, statistics, etc.--></li>
				<li>	<%= strTextProvideDetailedResponsesToQues %><!--Provide detailed responses to questions.--></li>
				<li>	<%= strTextDealFullyWithObjections %><!--Deal fully with objections.--></li>
				<li>	<%= strTextStressQualityReliabilityAndSec %><!--Stress quality, reliability, and security.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextToCommunicateBetterWithAHighCBu %><!--To communicate better with a High C Buyer don't--> &#133;
			</h3>			
		</td>
	</tr>
 	<tr>
		<td width="50%" valign="top">	
			<ul>
				<li>	<%= strTextBeVagueOrCasualParticularlyWhe %><!--Be vague or casual, particularly when answering questions.--></li>
				<li>	<%= strTextMoveToTheBottomLineTooQuickly %><!--Move to the bottom line too quickly.--></li>
				<li>	<%= strTextGetPersonalAboutFamilyIfYouDon %><!--Get personal about family if you don't know this him/her.--></li>
			</ul>
			
		</td>
		<td width="50%" valign="top">
			<ul>
				<li>	<%= strTextPatOnTheBackOrOtherwiseBeTooFa %><!--Pat on the back or otherwise be too familiar.--></li>
				<li>	<%= strTextSpeakTooLoudly %><!--Speak too loudly.--></li>
				<li>	<%= strTextThreatenCajoleWheedleOrCoax %><!--Threaten, cajole, wheedle, or coax.--></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<h3>
				<%= strTextAsHighCBuyersHearAndAnalyzeInf %><!--As High C Buyers hear and analyze information, they may--> &#133;
			</h3>			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<ul>
				<li>	<%= strTextBeTooConservativeAndCautious %><!--Be too conservative and cautious.--></li>
				<li>	<%= strTextBogDownInTheCollectionProcess %><!--Bog down in the collection process.--></li>
				<li>	<%= strTextBecomeBuriedInDetail %><!--Become buried in detail.--></li>
				<li>	<%= strTextDelayOrAvoidDecisionsParticula %><!--Delay or avoid decisions, particularly if risky.--></li>
			</ul>			
		</td>
	</tr>
</table>

</div>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


	<h1>
		<%= strTextStrategiesForDealingWithDiffer %><!--Strategies for Dealing with Different Buyers-->
	</h1>



	<h3>
	<% strTemp = Replace(strTextAsAHighhightype1SalespersonYou, "{{HighType1}}", HighType1) %>
		<%= strTemp %><!--As a High {{HighType1}} salesperson, you may need to adapt your style to match the situation.-->
	</h3>


<%If HighType1 = "D" then %>
	<!--#Include FILE="AppModuleSelling_sdb_d.asp" -->
<% elseif HighType1 = "I" then %>
	<!--#Include FILE="AppModuleSelling_sdb_i.asp" -->
<% elseif HighType1 = "S" then %>
	<!--#Include FILE="AppModuleSelling_sdb_s.asp" -->
<% else %>
	<!--#Include FILE="AppModuleSelling_sdb_c.asp" -->
<% end if %>
<br><br>

<h1>
	<%= strTextSellingSituationsFrustrationOr %><!--Selling Situations: Frustration or Fulfillment-->
</h1>

<ul>
	<li>
		<%= strTextThinkOfASellingSituationThatFr %><!--Think of a selling situation that frustrates you or makes you uncomfortable and 
		ineffective. Describe the typical elements of this situation (such as buyer personality, 
		environment, timing, presentation, presence of competitors, appropriateness of your 
		product or service for the situation, economic conditions).--><br><br>
	
		<table WIDTH="650px" BORDER="0" CELLSPACING="1" CELLPADDING="1">
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
		</table>
	</li>
</ul>
<br><br>
<ul>
	<li><%= strTextHowCouldYouAdjustYourSellingSt %><!--How could you adjust your selling style to be more effective in this selling situation?-->
		<br><br>
		<table WIDTH="650px" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table2">
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
			<tr>
				<td style="border-bottom: 1px solid black">&nbsp;</td>
			</tr>
		</table>
	</li>
</ul>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


	<h1>
		<%= strTextPersonalityAndTheSellingProces %><!--Personality and the Selling Process-->
	</h1>


<p>
	<% strTemp = Replace(strTextLetsReflectForAMomentOnHowYour, "{{HighType1}}", HighType1) %>
	<%=UserName1%>, <%= strTemp %><!--let's reflect for a moment on how your high {{HighType1}} behavioral style impacts 
	your approach: the way you implement the process&#151;sometimes helping, other times 
	hindering. Every personality will bring different strengths and weaknesses to each stage 
	of the sales process (targeting, preparation, presentation, commitment, and partnering).-->
</p>	

<p>
	<%= strTextBelowAreTheMoreTypicalProcessE %><!--Below are the more typical process elements. Please adapt accordingly to fit your situation.-->
	<%= strTextTakeAMinuteToConsiderThePossib %><!--Take a minute to consider the possibilities, and jot down your ideas in the spaces provided.-->
</p>


<table WIDTH="100%" class="with-border" CELLSPACING="1" CELLPADDING="3" ID="Table3">
	<tr bgcolor="#cccccc">
		<td class="with-border" WIDTH="20%">&nbsp;</td>
		<td class="with-border" WIDTH="40%" ALIGN="MIDDLE"><font size="3"><strong><%= strTextHelps %><!--Helps--></strong></td>
		<td class="with-border" WIDTH="40%" ALIGN="MIDDLE"><font size="3"><strong><%= strTextHinders %><!--Hinders--></strong></td>
	</tr>
	<tr>
		<td class="with-border" valign="top">
			<font size="3"><strong><%= strTextTargeting %><!--Targeting--></strong></font><br>
			<font size="2"><%= strTextGatheringInformation %><!--Gathering Information--></font><br>
			<font size="2"><%= strTextInitialContact %><!--Initial Contact--></font>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table4">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table5">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr bgcolor="#eeeeee">
		<td class="with-border" valign="top">
			<font size="3"><strong><%= strTextPreparation %><!--Preparation--></strong></font><br>
			<font size="2"><%= strTextPreliminaryMeeting %><!--Preliminary Meeting--></font><br>
			<font size="2"><%= strTextDevelopingRapport %><!--Developing Rapport--></font><br>
			<font size="2"><%= strTextFindingTheNeed %><!--Finding the Need--></font><br>
			<font size="2"><%= strTextAnalysis %><!--Analysis--></font>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table6">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table7">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="with-border" valign="top">
			<font size="3"><strong><%= strTextPresentation %><!--Presentation--></strong></font><br>
			<font size="2"><%= strTextProposingSolutionsbenefits %><!--Proposing Solutions/Benefits--></font><br>
			<font size="2"><%= strTextHandlingObjections %><!--Handling Objections--></font><br>
			<font size="2"><%= strTextPresentingCapabilities %><!--Presenting Capabilities--></font>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table8">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table9">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr bgcolor="#eeeeee">
		<td class="with-border" valign="top">
			<font size="3"><strong><%= strTextCommitment %><!--Commitment--></strong></font><br>
			<font size="2"><%= strTextObtainingDecision %><!--Obtaining Decision--></font><br>
			<font size="2"><%= strTextOutliningNextSteps %><!--Outlining Next Steps--></font>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table10">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table11">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="with-border" valign="top">
			<font size="3"><strong><%= strTextPartnering %><!--Partnering--></strong>
			<font size="2"><%= strTextProvidingFollowup %><!--Providing Follow-up--></font><br>
			<font size="2"><%= strTextBuildingCredibility %><!--Building Credibility--></font><br>
			<font size="2"><%= strTextContinuingService %><!--Continuing Service--></font>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table12">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
		<td class="with-border">
			<table WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1" ID="Table13">
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid black">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</table>




<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>


<h1>
	<%= strTextTipsToTheSalesManagerWhenManag %><!--Tips to the Sales Manager When managing different styles-->&#133;
</h1>



<table align="center" width="600px" cellpadding="7px" class="with-border" ID="Table14">
	<tr>
		<td height="350px" width="50%" class="with-border">
			<div style="position: relative; height: 100%";> 
			<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;		font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
				D
			</div>
			<div style="LEFT: 30px; POSITION: absolute; TOP: 30px; Z-Index:100">
				<!-- D Content -->
				<ul>
					<li><%= strTextOfferCommissionCompensation %><!--Offer commission compensation.--></li>
					<li><%= strTextCreateContestsInWhichThereAreA %><!--Create contests in which there are a limited number of winners.--></li>
					<li><%= strTextGiveDifficultAssignmentsThatCha %><!--Give difficult assignments that challenge logic and analytical ability.--></li>
					<li><%= strTextMakeTheHighDAwareOfPossibleOve %><!--Make the High D aware of possible overbearing manner with buyers.--></li>
					<li><%= strTextGiveAsMuchFreedomAsPossibleToR %><!--Give as much freedom as possible to run things.--></li>
					<li><%= strTextMakeTheHighDUnderstandTheLimit %><!--Make the High D understand the limits to authority.--></li>
					<li><%= strTextAllowTheHighDToquottellItLikeI %><!--Allow the High D to &quot;tell it like it is&quot; and openly discuss 
					what is expected on a no-holds-barred basis.--></li>
					<li><%= strTextAcknowledgeSuccessesOpenlyAndO %><!--Acknowledge successes openly and often.--></li>
					<li><%= strTextTolerateCriticism %><!--Tolerate criticism.--></li>
					<li><%= strTextDelegateWheneverPossible %><!--Delegate whenever possible.--></li>
				</ul>
			</div>
			</div>
		</td>
		<td height="350px" width="50%" class="with-border">
			<div style="position: relative; height: 100%";> 
			<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;		font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
				I
			</div>
			<div style="LEFT: 30px; POSITION: absolute; TOP: 30px; Z-Index:100">
				<!-- I Content -->
				<ul>
					<li><%= strTextEncourageTheHighIToSetGoalsTha %><!--Encourage the High I to set goals that provide awards and 
					recognition.--></li>
					<li><%= strTextGiveFreedomAndTheOpportunityTo %><!--Give freedom and the opportunity to be &quot;number one.&quot;--></li>
					<li><%= strTextBeGenerousWithRecognition %><!--Be generous with recognition.--></li>
					<li><%= strTextDiscussSalesSituationsOpenlyAn %><!--Discuss sales situations openly and freely.--></li>
					<li><%= strTextMakeStatusSymbolsAndPerksAvail %><!--Make status symbols and perks available.--></li>
					<li><%= strTextAllowTheHighITheChanceToSpeakA %><!--Allow the High I the chance to speak and be heard.--></li>
					<li><%= strTextExchangeIdeasAndAdvice %><!--Exchange ideas and advice.--></li>
					<li><%= strTextBeInvolvedSocially %><!--Be involved socially.--></li>
					<li><%= strTextKeepSupervisionToAMinimumToEnc %><!--Keep supervision to a minimum to encourage independence.--></li>
					<li><%= strTextProvideClearButGeneralInstruct %><!--Provide clear but general instructions.--></li>
					<li><%= strTextMotivateWithEmotionalAppeals %><!--Motivate with emotional appeals.--></li>
				</ul>
			</div>
			</div>
		</td>
	</tr>
	<tr>
		<td height="350px" width="50%" class="with-border">
			<div style="position: relative; height: 100%";> 
			<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;		font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
				C
			</div>
			<div style="LEFT: 30px; POSITION: absolute; TOP: 30px; Z-Index:100">
				<!-- C Content -->
				<ul>
					<li><%= strTextAllowTheHighCToCompeteAgainstL %><!--Allow the High C to compete against long-term commitments 
					rather than short-term, &quot;contest&quot; goals.--></li>
					<li><%= strTextBeSupportiveAndResponsive1 %><!--Be supportive and responsive.--></li>
					<li><%= strTextOutlineExactlyWhatIsExpected %><!--Outline exactly what is expected.--></li>
					<li><%= strTextProvideProjectsThatRequirePreci %><!--Provide projects that require precision, organization, and planning.--></li>
					<li><%= strTextBeAvailableToDiscussKeyMovesAn %><!--Be available to discuss key moves and make useful suggestions in 
					stressful situations.--></li>
					<li><%= strTextDeflectPressureWheneverPossible %><!--Deflect pressure whenever possible.--></li>
					<li><%= strTextProvideSupportAndBackupInDiffic %><!--Provide support and backup in difficult situations.--></li>
					<li><%= strTextProvideDetailedInstructionsAnd %><!--Provide detailed instructions and develop exact job descriptions.--></li>
					<li><%= strTextEncourageTheHighCToCompletePro %><!--Encourage the High C to complete projects.--></li>
				</ul>
			</div>
			</div>
		</td>
		<td height="350px" width="50%" class="with-border">
			<div style="position: relative; height: 100%";> 
			<div style="font-family:verdana,helvetica,arial; font-size:72pt; font-style:italic;		font-weight:bold; color: #c7c7c7; LEFT: 0px; POSITION: relative; TOP: 0px; Z-Index:10">
				S
			</div>
			<div style="LEFT: 30px; POSITION: absolute; TOP: 30px; Z-Index:100">
				<!-- S Content -->
				<ul>
					<li><%= strTextDevelopContestsInWhichEveryoneC %><!--Develop contests in which everyone can win something.--></li>
					<li><%= strTextTakeAnInterestInTheHighSBothAsA %><!--Take an interest in the High S both as a producer and as a person.--></li>
					<li><%= strTextAllowTheHighSToWorkAtAnEstablishe %><!--Allow the High S to work at an established and self-regulated pace.--></li>
					<li><%= strTextProvideAStableEnvironmentThatEv %><!--Provide a stable environment that evidences permanence, security, and 
					consistency.-->
					<br>
					<li><%= strTextProvideSincereAppreciation1 %><!--Provide sincere appreciation.--></li>
					<li><%= strTextGiveHelpInMeetingDeadlines %><!--Give help in meeting deadlines.--></li>
					<li><%= strTextGiveAdvanceWarningBeforeChange %><!--Give advance warning before change.--></li>
					<li><%= strTextExpressSincereAppreciationForC %><!--Express sincere appreciation for contributions.--></li>
					<li><%= strTextBePatient1 %><!--Be patient.--></li>
				</ul>
			</div>
			</div>
		</td>
	</tr>
</table>

<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
<p>
	<%= strTextThestrongdiscProfileSystemstro %><!--The <strong>DISC Profile System®</strong> is a family of instruments and workbooks designed specifically to increase 
	understanding of yourself and others to achieve greater personal and interpersonal effectiveness.-->
</p>
<p>
	<%= strTextThestrongpersonalDiscernmentIn %><!--The <strong>Personal DISCernment® Inventory</strong>, the basic module, provides a unique insight into your 
	temperament, producing both a general and a detailed description of your behavioral style. This 
	instrument also allows you to develop a comprehensive list of your strengths and weaknesses.-->
</p>


<h1>
	<%= strTextFiveApplicationModulesAreAvaila %><!--Five application modules are available:-->
</h1>

<p>
	<%= strTextThestrongdiscProfileSystemstron %><!--The <strong>DISC Profile® System</strong> Includes a series of application modules that will guide you in applying these 
	insights to specific situations. The module workbooks provide additional information each behavioral style 
	as it relates to that arena and suggest how you may apply this information to yourself and your 
	teammates.-->
</p>

<h3>
	<%= strTextTeamworkWithStyle %><!--Teamwork with Style-->
</h3>

<p>
	<%= strTextEachTemperamentBringsUniqueStr %><!--Each temperament brings unique strengths and weaknesses to the team setting. Your behavioral 
	style influences the way you plan and organize your work, communicate and make decisions. 
	This workbook will provide the opportunity for you to identify, explore, and discuss the effects of 
	the individual behavioral styles on your team. The result will be enhanced understanding of how 
	to build on individual differences for greater team effectiveness.-->
</p>
	

<h3>
	<%= strTextLeadingWithStyle %><!--Leading with Style-->
</h3>


<p>
	<%= strTextOurBehavioralTraitsAreNotOnlyA %><!--Our behavioral traits are not only a major influence on our leadership style, but also provide the 
	template through which we view the leadership of others. When we are led by those with different 
	behavioral styles from our own, we have a tendency to feel overled. Understanding these 
	differences will not only help you to better serve those you lead, but also help you to better 
	respond to the leadership of others.-->
</p>
	

<h3>
	<%= strTextCommunicatingWithStyle %><!--Communicating with Style-->
</h3>


<p>
	<%= strTextThisModuleWillHelpYouRecognizeHow %><!--This module will help you recognize how your personal communication style enhances or 
	impedes the messages that you send to others. In addition, you will learn to identify the styles of 
	those receiving your message, and discover ways to adapt your style to meet their needs. As a 
	result, you will greatly improve the effectiveness of your written and spoken communication in a 
	variety of situations.-->
</p>


<h3>
	<%= strTextSellingWithStyle %><!--Selling with Style-->
</h3>


<p>
	<%= strTextBehavioralStyleNotOnlyInfluencesHow %><!--Behavioral style not only influences how we persuade or convince others, but how we ourselves 
	are persuaded. This module, designed for the sales environment, provides insights into the 
	strengths and weaknesses of each behavioral style as we attempt to communicate with and 
	convince others. You will also discover how different temperaments receive and respond to such 
	overtures. These insights can greatly increase your effectiveness in communicating a point of 
	view, as well as understanding and meeting the needs of others.-->
</p>
	

<h3>
	<%= strTextTimeManagementWithStyle %><!--Time Management with Style-->
</h3>


<p>
	<%= strTextOurPersonalitiesOftenDetermineOur %><!--Our personalities often determine our attitudes toward time: how we respond to time constraints, 
	how we discipline ourselves, how much energy we have to get things done, and how we view 
	deadlines. This workbook outlines each behavioral style's response to the various aspects of time 
	and personal management.-->
</p>

<p>
	<%= strTextForMoreInformationCallTeamReso %><!--For more information call Team Resources at 1.800.214.3917 or visit our website: www.teamresources.com-->
</p>
</div>

	</body>
</html>
