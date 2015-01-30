<%@ Language=VBScript %>
<HTML>
	<HEAD>
		<% intPageID = 73 %>
		<!--#Include virtual="/pdi/Include/common.asp" -->
		<meta content="Microsoft Visual Studio 6.0" name="GENERATOR">
		<link rel="stylesheet" href="AppModStyle.css" type="text/css">
	</HEAD>
	<body>
		<%
Dim strTopPgSpacing
Dim AppModTitleFont
Dim EndAppModTitleFont
Dim HighType1
Dim HighType2
Dim TestDate
Dim AppModHugeFont
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
Dim nRepProfile1
Dim TestCodeID
Dim strTemp

strTopPgSpacing = "<br>"
HighType1 = UCase(Request.QueryString("HT1"))
HighType2 = UCase(Request.QueryString("HT2"))
AppModTitleFont = "<strong><font size=4>"
EndAppModTitleFont = "</strong></font>"
AppModParaFont = "<blockquote><font size=3>"
EndAppModParaFont = "</font></blockquote>"
PDITestSummaryID = Request.QueryString("PDITSID")
UserID = Request.QueryString("UID")
TestCodeID = Request.QueryString("TCID")

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
TestDate = oRs("FileCreationDate")
nRepProfile1 = oRs("ProfileID1")
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
		<div id="Content">
			<div style="Z-INDEX: 200; LEFT: 36px; POSITION: absolute; TOP: 54px"><IMG id="IMG1" alt="" src="images/financial_pdf_cover_03.jpg"></div>
			<div style="Z-INDEX: 100; LEFT: 32px; POSITION: absolute; TOP: 50px"><IMG id="imgMat" height="283" alt="" src="images/blackmat.gif" width="421"></div>
			<div style="Z-INDEX: 50; LEFT: 11px; POSITION: absolute; TOP: 314px"><IMG alt="" src="images/financial_title.gif"></div>
			<div style="Z-INDEX: 50; LEFT: 11px; POSITION: absolute; TOP: 420px"><IMG alt="" src="images/DISC_Footer.gif"></div>
			&nbsp;&nbsp; <IMG height="580" alt="" src="images/spacer.gif" width="200"> <IMG alt="" src="images/CFPN_logo.gif">
			<IMG height="168" alt="" src="images/spacer.gif" width="200"><BR>
			<%=UserName%>
			<br>
			<%=TestDate%>
			<br>
			<IMG height="20" alt="" src="images/spacer.gif" width="200"><BR>
			<BR>
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<h1>The Art of Financial Counsel</h1>
			<p>Assisting others in becoming good stewards and achieving their financial 
				objectives involves a complex mix of skills and knowledge that includes 
				technical expertise, counsel, spiritual insight and wisdom, and leadership.</p>
			<p>In many cases, clients are committed to biblical stewardship and merely need the 
				technical help and planning to achieve this end. With others, their heart 
				desires to let God have His way with their finances, but old habits, past 
				decisions, and distracting influences stand in the way. In this instance, the 
				advisor must act as much as counselor, cheerleader, and accountability partner 
				as he or she does as technical advisor. Finally, there are those who are open 
				but uncertain as to the degree of biblical stewardship they want to exercise. 
				Now, the advisor becomes a discipler and leader as well.</p>
			<p>In fact, across the entire spectrum of financial counsel, the financial advisor, 
				to be effective, must exercise leadership in the lives of his or her clients. 
				Leadership is, at its very essence, influence. Anytime you attempt to influence 
				another person’s attitude of behavior, you are exercising leadership.</p>
			<h1>The Art of Influence and Persuasion</h1>
			<p>Webster defines the word persuasion as being able "to win over to a course of 
				action by reasoning or inducement. To make a person believe something."</p>
			<p>When we persuade, we successfully influence another's thinking toward a decision 
				or in a direction, yet still within that person's own boundaries of 
				willingness. To persuade means to resolve, change, or form another's feelings 
				or opinion in an effective but reputable manner.
			</p>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" ID="Table2">
				<tr>
					<td align="center">
						<div align="center" style="BORDER-TOP:gray 1px solid; FONT-SIZE:9pt; WIDTH:150px; COLOR:gray; BORDER-BOTTOM:gray 1px solid; FONT-FAMILY:garamond">
							"Since, then, we know what it is to fear the Lord, we try to persuade men..."<br>
							Paul, 2 Corinthians 5:11 NIV</div>
					</td>
				</tr>
			</table>
			<p>
				Human history attests to the power of persuasion. The ancient Romans believed 
				that of all the liberal arts, rhetoric (or the ability to use language 
				persuasively) overrode all other talents. Every social, religious, or political 
				revolution has had, at its very core, a powerful catalyst known as persuasion. 
				In a free enterprise system, it is the way we do business.
			</p>
			
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<H1>The Role of the Financial Advisor</H1>
			<P>The role of financial advisor goes well beyond leadership and providing 
				technical expertise. A very short list of the more typical responsibilities and 
				activities of a financial advisor might include the following:
			</P>
			<ul>
				<li>
				<span class="look">Business Development:</span><br>
				Networking, Handling Referrals, Establishing Relationships</li>
				<li>
				<span class="look">Client Interaction:</span><br>
				Gathering Information<br>
				Delivering Plan and Gaining Alignment<br>
				Implementing Plan and Performing Ongoing Follow Through</li>
				<li>
				<span class="look">Practice Management:</span><br>
				Hiring, Staff Development, Goal Setting, Dealing with Operational Issues</li>
			</ul>

			<p>All of us have discovered that the more we know about ourselves and others, the 
				better we can anticipate behavior and, therefore, the better we can serve and 
				relate to other people.
			</p>
			<P>This specially designed application module will provide insight into how the 
				strengths and weaknesses of your God-given temperament play out as you work 
				through the five responsibilities shown above. Not only that, but you will be 
				able to recognize the temperament of your clients and discern how best to 
				communicate, serve, and lead them based on their temperament, while at the same 
				time taking your own temperament into account. This module will help you apply 
				the insights that you gained from your Personal DISCernment Inventory<SUP style="FONT-SIZE: 8pt">®</SUP>
				to become effective in finding clients, serving them, and managing your 
				practice.
			</P>

			<p>First, let's look at our different behavioral tendencies in influencing and 
				decision making, using the DISC Profile System<sup style="FONT-SIZE:8pt">®</sup>.
				When you took the Personal DISCernment® Inventory, you discovered your Representative Pattern, 
				along with that Pattern’s specific strengths and weaknesses.  You will see those charts as a reminder of your unique style.</> 
			<p>
				Next, we will identify behavioral tendencies as they apply to providing financial advice and counsel, 
				as you seek to apply the principles of the PDI to the activities of your profession, 
				particularly your relationships with your clients. 
			</p>
			
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<!--#Include FILE="RepTypeGraph.asp" -->
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<!-- #Include FILE="PDI_SW_Chart.asp" -->
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			
			<h1>Advisor Styles: An Overview</h1>
			<% if UCase(HighType1) = "D" then %>
			<!--#Include FILE="AppModuleFinancial_Style_D.asp" -->
			<% elseif UCase(HighType1) = "I" then %>
			<!--#Include FILE="AppModuleFinancial_Style_I.asp" -->
			<% elseif UCase(HighType1) = "S" then %>
			<!--#Include FILE="AppModuleFinancial_Style_S.asp" -->
			<% elseif UCase(HighType1) = "C" then %>
			<!--#Include FILE="AppModuleFinancial_Style_C.asp" -->
			<% end if %>
			<h1>Summary of Other Advisor Styles</h1>
			<table border="0" ID="Table4">
				<% if UCase(HighType1) <> "D" then %>
				<tr>
					<td>
						<!--#Include FILE="AppModuleFinancial_Style_DNot.asp" --><br>
					</td>
				</tr>
				<% end if %>
				<% if UCase(HighType1) <> "I" then %>
				<tr>
					<td>
						<!--#Include FILE="AppModuleFinancial_Style_INot.asp" --><br>
					</td>
				</tr>
				<% end if %>
				<% if UCase(HighType1) <> "S" then %>
				<tr>
					<td>
						<!--#Include FILE="AppModuleFinancial_Style_SNot.asp" --><br>
					</td>
				</tr>
				<% end if %>
				<% if UCase(HighType1) <> "C" then %>
				<tr>
					<td>
						<!--#Include FILE="AppModuleFinancial_Style_CNot.asp" --><br>
					</td>
				</tr>
				<% end if %>
			</table>
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<h1>High
				<%= UCase(HighType1) %>
				Financial Advisor
			</h1>
			<% if UCase(HighType1) = "D" then %>
			<!--#Include FILE="AppModuleFinancial_sw_D.asp" -->
			<% elseif UCase(HighType1) = "I" then %>
			<!--#Include FILE="AppModuleFinancial_sw_I.asp" -->
			<% elseif UCase(HighType1) = "S" then %>
			<!--#Include FILE="AppModuleFinancial_sw_S.asp" -->
			<% elseif UCase(HighType1) = "C" then %>
			<!--#Include FILE="AppModuleFinancial_sw_C.asp" -->
			<% end if %>
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<h1>Identifying the Style of Clients
			</h1>
			<p>
				To adapt our own style to better match the temperament of another person, in 
				particular, our clients,&nbsp;we must first be able to identify the style of 
				those individuals. Obviously, we can’t always administer the Personal 
				DISCernment Inventory<sup>®</sup> (PDI<sup>®</sup>), so how can we recognize 
				the temperament of others?
			</p>
			<p>Further, in dealing with clients, you will frequently be discussing issues with 
				couples rather than simply individuals. Being able to judge how each person is 
				responding to the information will allow you to address concerns and make the 
				necessary adaptations. One of the strengths of PDI, as well as other DISC 
				instruments, is that they deal largely with "observable" behavior. A careful, 
				informed observation can help you develop a reasonably accurate "guesstimate" 
				of someone's personal style.
			</p>
			<p>First, let’s review the four-element model that we introduced in the PDI.
			</p>
			<center><IMG alt="" src="images/Financial_Fig1.gif"></center>
			<p>Next, we expand on this model to identify the more visible behavioral tendencies 
				of different styles.
			</p>
			<H3>People vs. Task
			</H3>
			<p>Using this model, we can see in Figure 2 that those to the right of the vertical 
				line are more people-oriented and those to the left are more task-oriented. 
				These groups also have certain “observable” characteristics. People-oriented 
				individuals tend to connect more readily with others, often with warmth and 
				openness. On the other hand, task-oriented people are generally cooler, more 
				reserved, and somewhat less expressive.
			</p>
			<center><IMG alt="" src="images/Financial_Fig2.gif"></center>
			<H3>Action vs. Response
			</H3>
			<p>Now, notice the horizontal line. People above the horizontal line tend to be 
				active or assertive – These individuals generally demonstrate a bold, 
				confident, and directive demeanor to others. Those below the line are more 
				responsive or accommodating, being seen by others as low key, collaborative, 
				and self-controlled. Detailed descriptions of tendencies in assertive and the 
				responsive temperaments are shown in the diagram below:
			</p>
			<center><IMG src="images/Financial_Fig3.gif"></center>
			<P>In identifying the styles of others the following principles will help:
			</P>
			<UL>
				<LI>
					<SPAN class="look">Understand the limitations of trying to identify 
        others’ styles by observation alone.</SPAN>
				Although certainly influenced by inner, unseen forces, behavior is not clear 
				evidence of values, motives, intelligence, feelings, or attitudes. As you 
				observe a person behaving or "acting" in certain manner, don’t ascribe the 
				underlying emotion or motive. Confine your conclusions to "observable" 
				behavior.
				<LI>
					<SPAN class="look">Withhold final judgment until you have more than 
        one encounter.</SPAN>
				Often it takes time and even several exposures to develop the confidence that 
				you have accurately assessed an individual. If others don’t trust you or 
				perceive the environment as safe, they may put up a mask. Create an atmosphere 
				that encourages others to be themselves.
				<LI>
					<SPAN class="look">Pay particular attention to non-verbal 
        communication</SPAN>
				– Words account for less than 10% of any communication. Watch the body 
				language, facial expressions, and gestures of the other individual. For 
				example, we saw in the information above that a people-oriented person would 
				tend to be more animated with their gestures, use more vocal inflection and 
				facial expressions.
				<LI>
					<SPAN class="look">Use your knowledge to increase your understanding 
        of and response to others’ needs.</SPAN>
					Your ability to recognize styles in others, coupled with an understanding of 
					the needs of various styles, can greatly increase your effectiveness as a 
					trusted advisor.</LI></UL>
			<H2>How to Identify a High D Client
			</H2>
			<p>High D clients come on strong, often testing a advisor by applying pressure 
				early in the relationship to see what the reaction will be. Frequently, the 
				High D client will run late and may appear abrupt or uninterested when first 
				approached. During the meeting, the High D may interrupt you, take calls, read 
				letters, and converse with others, all the time saying something like, "Keep 
				talking. I'm listening."
			</p>
			<p>High D's are usually interested in new products and innovations that produce 
				proven results. The High D's office and desk may be disorganized, but what the 
				advisor will most quickly recognize is this client's impatience and 
				impulsiveness. The High D client will want options, rapidly presented, from 
				which to make a decision. High D clients can be intimidating and may take 
				control of the situation.
			</p>
			<H4>Questions that High D Clients Might Ask
			</H4>
			<UL>
				<LI>
				Will this plan produce results that achieve my goals?
				<LI>
				Exactly how will this investment help me meet my goals?
				<LI>
				What is this provider's record?
				<LI>
				How quickly will I see positive results?
				<LI>
				Will I get real-time information?
				<LI>
				Can I access my information online?
				<LI>
				How regularly do you monitor or update results?
				<LI>
					Have you presented me with the best options?</LI></UL>
			<P><b>The High D's Expectations</b>
			</P>
			<p>High D's expect advisors to adopt a businesslike attitude. They have other 
				things to do, and they prefer to concentrate on the highest priority items. 
				They expect advisors to make efficient use of their time and get to the bottom 
				line quickly. They tend to be busy people who operate from schedules and lists 
				of things to do. They like to see that they are making progress.
			</p>
			<p>
				D's want you to provide them with evidence of plan effectiveness&nbsp;early in 
				the process. They want to deal with someone who is competent and 
				self-confident—someone they can respect. They expect you to present your advice 
				in terms of how it will solve their problems. They aren't afraid to take risks, 
				but they expect you to provide them with probabilities associated with the 
				risk.
			</p>
			<H2>How to Identify a High I Client
			</H2>
			<p style="PAGE-BREAK-AFTER:always">High I clients are friendly, people-oriented folks who usually would rather talk 
				and socialize than to be involved in highly detailed information. &nbsp;They 
				like the limelight and will often have awards, certificates, trophies, photos 
				featured on the walls of home and office. You'll know who lives there, and the 
				ego will be evident. High I's will be glad to see you arrive; in some cases, 
				they will trade jokes and stories, and won't want to discuss business 
				initially. They talk a lot about themselves. They will interrupt and digress 
				occasionally, but they are generally enthusiastic and receptive, particularly 
				if your product or service is innovative and leading edge.
			</p>
			<p><b>Questions that High I Clients Might Ask</b>
			</p>
			<UL>
				<LI>
				Do you know . . . . .?
				<LI>
				I belong to the same Church, Club, Organization as XX.&nbsp; Do you know 
				him/her?
				<LI>
				Can you tell me a little about yourself?&nbsp; Your firm?&nbsp;
				<LI>
				Are there any special plans available?
				<LI>
				What do your other clients say about this product/offering?
				<LI>
				Can you tell me about your typical client?
				<LI>
				What happens if I change my mind?
				<LI>
					Will you be the person I should call if I have questions or concerns?</LI></UL>
			<P><b>The High I's Expectations</b>
			</P>
			<p>High I clients expect you to be tolerant of their casual use of time. They 
				operate in the present and&nbsp;aren't clock watchers. They don't want you to 
				be either. Once they make a decision, however, they want quick results.
			</p>
			<p>High I's like to know who they're dealing with. They want to know what you think 
				and how you feel about things. &nbsp;High I's want you to support them 
				personally and may be sensitive to how you work with their spouse. &nbsp;They 
				like positive feedback that helps them relate to you personally.
			</p>
			<H2>How to Identify a High S Client
			</H2>
			<p>
				High S clients are devoted to family and close friends.&nbsp; Homes and offices 
				abound with pictures and mementos of valued relationships.&nbsp; After an 
				initial reserved demeanor, the High S client will be sincere, warm, amiable, 
				and relationship-oriented.&nbsp; They need to be able to trust you.
			</p>
			<p>Although they appear easygoing and personable, the High S client is very 
				security conscious and possessive, so be careful what you touch or pick 
				up.&nbsp; They also resist urgency&nbsp;or&nbsp;sudden change and prefer 
				proven, traditional concepts.&nbsp; You can't judge this book by its cover: 
				&nbsp;Appearances vary among High S clients, ranging from conservative or even 
				frumpy to high style.
			</p>
			<p><b>Questions that High S Clients Might Ask</b>
			</p>
			<UL>
				<LI>
				Why should I do anything different from what I'm currently doing?&nbsp;
				<LI>
				I've been very pleased with XYZ.&nbsp; Why should I change?
				<LI>
					Why do
					<span class="look">you</span>
				want to switch me from XX?&nbsp; What's better about this approach?
				<LI>
				How quickly do I have to give you an answer?
				<LI>
				What are the risks?
				<LI>
				May I give you an answer after I&nbsp;talk this over with my attorney?
				<LI>
				Can we meet again after I've had time to think/pray about it?
				<LI>
				How will this benefit my family?
				<LI>
					Have many problems occurred?</LI></UL>
			<P><b>The High S's Expectations</b>
			</P>
			<p>High S clients expect you to spend time developing the relationship and to 
				demonstrate a willingness to build a personal as well as a business ties with 
				them. They prefer to proceed deliberately at a measured pace.
			</p>
			<p>High S clients expect you to present the benefits of your product or service in 
				terms of why it is the best solution to their problem. They want guarantees and 
				assurances, since they are not assertive risk takers. They make decisions 
				cautiously, and they want others to affirm those decisions.&nbsp; The will most 
				certainly involve the spouse in discussions and ultimate decisions.
			</p>
			<H2>How to Identify a High C Client
			</H2>
			<p>The High C will be prepared for the visit, on time, and will have read any 
				advance material you may have provided.&nbsp; The atmosphere will be 
				businesslike, but unhurried and deliberate. The High C client may appear to be 
				initially wary of you and skeptical about your advice. Although precise and 
				restrained, this client will be courteous and diplomatic.
			</p>
			<p>A stickler for accuracy and thoroughness, the High C will be process oriented, 
				with emphasis on detailed organization. High C clients are not innovators. They 
				will not readily try out new and unproven approaches.&nbsp; Generally, their 
				appearance will be neat, conservative, and unobtrusive.&nbsp; High C's resist 
				anything that calls unnecessary attention to themselves.
			</p>
			<p><b>Questions that High C Clients Might Ask</b>
			</p>
			<UL>
				<LI>
				Can you tell me more?&nbsp;
				<LI>
				Who underwrites this product/service?
				<LI>
				What is the company's rating?
				<LI>
				Do you have some more information on performance?
				<LI>
				Can I access information on-line?
				<LI>
				What fees are involved?
				<LI>
				How does this compare to my current investments?
				<LI>
				May I contact you after I've&nbsp;had time to go over this proposal?
				<LI>
					Do you have offering circular, policy, etc.?</LI></UL>
			<P><b>The High C's Expectations</b>
			</P>
			<p>High C clients expect the meeting to move at a pace that provides them with just 
				enough time to consider key points thoughtfully.&nbsp; They will want you to 
				present all the facts you have at your disposal and will then want the time to 
				think about the data before making a decision.&nbsp;
			</p>
			<p>You may find them hard to read.&nbsp; You won't get an immediate sense of the 
				direction in which they are leaning.&nbsp; They may be delighted with your 
				proposal, yet show little evidence of a positive reaction. Like High S's, High 
				C clients want guarantees and assurances to protect them if something goes 
				sour.
			</p>
			<h1>DISC Compatibility Matrix</h1>
			<p>Different personal style combinations present opportunities and potential for 
				compatibility or for conflict. Although not carved in stone, the following 
				matrices present typical relational and task compatibilities of the various 
				styles and rank them on a scale from Excellent to Poor.
			</p>
			<p>First, let's consider Relational Compatibility. How well do two styles interact 
				in casual or general situations? For example, how do you get along with a 
				coworker who may be in your department but rarely intersects with your job? Or, 
				in your experience with roommates, which ones stand out as delights or 
				disasters? Relational Compatibility involves the aspects and attributes of a 
				relationship, whether casual or intimate.
			</p>
			<p>
				<h1 align="center">Relational Compatibility
				</h1>
			<P align="center"></P>
			<P align="center">
				<table id="Table18" cellSpacing="1" cellPadding="5" width="75%" border="0">
					<tr>
						<td align="center" class="grid"><font size="2">&nbsp;</font></td>
						<td align="center" class="grid"><font size="2"><STRONG>D</STRONG></font></td>
						<td align="center" class="grid"><font size="2"><STRONG>I</STRONG></font></td>
						<td align="center" class="grid"><font size="2"><STRONG>S</STRONG></font></td>
						<td align="center" class="gridRC"><font size="2"><STRONG>C</STRONG></font></td>
					</tr>
					<tr>
						<td align="center" class="grid"><font size="2"><STRONG>D</STRONG></font></td>
						<td align="center" class="grid"><font size="2">Good</font></td>
						<td align="center" class="grid"><font size="2">Good</font></td>
						<td align="center" class="grid"><font size="2">Fair</font></td>
						<td align="center" class="gridRC">Poor</FONT></td>
					</tr>
					<tr>
						<td align="center" class="grid"><font size="2"><STRONG>I</STRONG></font></td>
						<td align="center" class="grid"><font size="2">Good</font></td>
						<td align="center" class="grid"><font size="2">Excellent</font></td>
						<td align="center" class="grid"><font size="2">Fair</font></td>
						<td align="center" class="gridRC">Poor</FONT></td>
					</tr>
					<tr>
						<td align="center" class="grid"><font size="2"><STRONG>S</STRONG></font></td>
						<td align="center" class="grid"><font size="2">Fair</font></td>
						<td align="center" class="grid"><font size="2">Fair</font></td>
						<td align="center" class="grid"><font size="2">Excellent</font></td>
						<td align="center" class="gridRC"><font size="2">Excellent</font></td>
					</tr>
					<tr>
						<td align="center" class="gridBR"><font size="2"><STRONG>C</STRONG></font></td>
						<td align="center" class="gridBR"><font size="2">Poor</font></td>
						<td align="center" class="gridBR"><font size="2">Poor</font></td>
						<td align="center" class="gridBR"><font size="2">Excellent</font></td>
						<td align="center"><font size="2">Excellent</font></td>
					</tr>
				</table>
			</P>
			<p>Next, let's look at Task Compatibility. Some combinations that rank low on 
				Relational Compatibility have excellent Task Compatibility. You may work 
				extremely well on a project with someone whom you might not want to take on 
				vacation!
			</p>
			<h1 align="center">Task Compatibility
			</h1>
			<P align="center"></P>
			<P align="center">
				<table id="Table19" cellSpacing="1" cellPadding="5" width="75%" border="0">
					<tr>
						<td align="center" class="grid"><font size="2">&nbsp;</font></td>
						<td align="center" class="grid"><font size="2"><STRONG>D</STRONG></font></td>
						<td align="center" class="grid"><font size="2"><STRONG>I</STRONG></font></td>
						<td align="center" class="grid"><font size="2"><STRONG>S</STRONG></font></td>
						<td align="center" class="gridRC"><font size="2"><STRONG>C</STRONG></font></td>
					</tr>
					<tr>
						<td align="center" class="grid"><font size="2"><STRONG>D</STRONG></font></td>
						<td align="center" class="grid"><font size="2">Fair</font></td>
						<td align="center" class="grid"><font size="2">Fair</font></td>
						<td align="center" class="grid"><font size="2">Excellent</font></td>
						<td align="center" class="gridRC"><font size="2">Fair</font></td>
					</tr>
					<tr>
						<td align="center" class="grid"><font size="2"><STRONG>I</STRONG></font></td>
						<td align="center" class="grid"><font size="2">Fair</font></td>
						<td align="center" class="grid"><font size="2">Poor</font></td>
						<td align="center" class="grid"><font size="2">Excellent</font></td>
						<td align="center" class="gridRC"><font size="2">Good</font></td>
					</tr>
					<tr>
						<td align="center" class="grid"><font size="2"><STRONG>S</STRONG></font></td>
						<td align="center" class="grid"><font size="2">Excellent</font></td>
						<td align="center" class="grid"><font size="2">Excellent</font></td>
						<td align="center" class="grid"><font size="2">Good</font></td>
						<td align="center" class="gridRC"><font size="2">Excellent</font></td>
					</tr>
					<tr>
						<td align="center" class="gridBR"><font size="2"><STRONG>C</STRONG></font></td>
						<td align="center" class="gridBR"><font size="2">Fair</font></td>
						<td align="center" class="gridBR"><font size="2">Good</font></td>
						<td align="center" class="gridBR"><font size="2">Excellent</font></td>
						<td align="center"><font size="2">Good</font></td>
					</tr>
				</table>
			</P>
			<P>Notice, for example that although the D/S relational compatibility is only 
				“Fair” when you give the two personal styles a task to complete, the task 
				compatibility improves to “Excellent.” Each of these styles possesses strengths 
				that offset the other’s possible weaknesses. The High D can set the goals and 
				direction, and the High S can create the road map for getting to the 
				destination.
			</P>
			<P>In another example, you will see that two High I’s have an Excellent relational 
				compatibility. They are both engaging, communicative, and enthusiastic. They 
				have a good time interacting with each other. However, when you give them a job 
				to do, the task compatibility drops to “Poor.” They may be having too much fun 
				to complete the assignment!
			</P>
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<h1>Strategies for Relating to Different Clients
			</h1>
			<P></P>
			<% if UCase(HighType1) = "D" then %>
			<!--#Include FILE="AppModuleFinancial_Strat_D.asp" -->
			<% elseif UCase(HighType1) = "I" then %>
			<!--#Include FILE="AppModuleFinancial_Strat_I.asp" -->
			<% elseif UCase(HighType1) = "S" then %>
			<!--#Include FILE="AppModuleFinancial_Strat_S.asp" -->
			<% elseif UCase(HighType1) = "C" then %>
			<!--#Include FILE="AppModuleFinancial_Strat_C.asp" -->
			<% end if %>
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<H1>Communication Strategy</H1>
			<H2>With a High D Client...</H2>
			<H3>To Communicate more effectively with a High D Client
			</H3>
			<TABLE id="Table11" cellSpacing="0" cellPadding="2" border="0">
				<TR>
					<TD vAlign="top" width="50%" class="grid"><STRONG>Do...</STRONG></TD>
					<TD vAlign="top" width="50%" class="gridRC"><STRONG>Don't...</STRONG></TD>
				</TR>
				<TR>
					<TD vAlign="top" width="50%" class="gridBR">
						<UL class="do">
							<LI>
							Avoid rambling; get to the bottom line.
							<LI>
							Provide direct answers and be brief and to the point.
							<LI>
							Stress results.
							<LI>
							Provide options and possibilities.
							<LI>
							Emphasize logic of ideas and approaches.
							<LI>
								Summarize and create closure.</LI></UL>
					</TD>
					<TD vAlign="top" width="50%">
						<UL class="dont">
							<LI>
							Appear indecisive.
							<LI>
							Be overly friendly.
							<LI>
							Provide too many details.
							<LI>
							Make unsupportable statements.
							<LI>
								Make decisions for them.</LI></UL>
					</TD>
				</TR>
			</TABLE>
			<H2>With a High I Client...</H2>
			<H3>To Communicate more effectively with a High I Client
			</H3>
			<TABLE id="Table12" cellSpacing="0" cellPadding="2" border="0">
				<TR>
					<TD vAlign="top" width="50%" class="grid"><STRONG>Do...</STRONG></TD>
					<TD vAlign="top" width="50%" class="gridRC"><STRONG>Don't...</STRONG></TD>
				</TR>
				<TR>
					<TD vAlign="top" width="50%" class="gridBR">
						<UL class="do">
							<LI>
							Spend time developing the relationship.
							<LI>
							Stress the new, the special, and the unique.
							<LI>
							Communicate expressively and with variety.
							<LI>
							Avoid dominating the conversation; provide opportunity for give and take.
							<LI>
							Be open, friendly, warm, and enthusiastic.
							<LI>
								Listen attentively.</LI></UL>
					</TD>
					<TD vAlign="top" width="50%">
						<UL class="dont">
							<LI>
							Ignore the social dimensions.
							<LI>
							Do all the talking.
							<LI>
							Restrict client suggestions or interruptions.
							<LI>
								Let him or her take you too far off track.</LI></UL>
					</TD>
				</TR>
			</TABLE>
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<H2>With a High S Client...</H2>
			<H3>To Communicate more effectively with a High S Client
			</H3>
			<TABLE id="Table13" cellSpacing="0" cellPadding="2" border="0">
				<TR>
					<TD vAlign="top" width="50%" class="grid"><STRONG>Do...</STRONG></TD>
					<TD vAlign="top" width="50%" class="gridRC"><STRONG>Don't...</STRONG></TD>
				</TR>
				<TR>
					<TD vAlign="top" width="50%" class="gridBR">
						<UL class="do">
							<LI>
							Use patience in drawing out his/her goals.
							<LI>
							Talk service and dependability.
							<LI>
							Listen attentively, and solicit feedback.
							<LI>
							Be sincere.
							<LI>
								Communicate in a low-key, relaxed manner.</LI></UL>
					</TD>
					<TD vAlign="top" width="50%">
						<UL class="dont">
							<LI>
							Ignore the personal dimension.
							<LI>
							Push too aggressively or demand.
							<LI>
							Move too fast.
							<LI>
							Omit too many details.
							<LI>
							Be abrupt.
							<LI>
								Create a sense of urgency to motivate a decision.</LI></UL>
					</TD>
				</TR>
			</TABLE>
			<H2>With a High C Client...</H2>
			<H3>To Communicate more effectively with a High C Client
			</H3>
			<TABLE id="Table14" cellSpacing="0" cellPadding="2" border="0">
				<TR>
					<TD vAlign="top" width="50%" class="grid"><STRONG>Do...</STRONG></TD>
					<TD vAlign="top" width="50%" class="gridRC"><STRONG>Don't...</STRONG></TD>
				</TR>
				<TR>
					<TD vAlign="top" width="50%" class="gridBR">
						<UL class="do">
							<LI>
							Organize information logically.
							<LI>
							Use comparative data, facts, and specifics
							<LI>
							Appeal to interest in research, statistics, etc.
							<LI>
							Provide detailed responses to questions.
							<LI>
							Deal fully with objections.
							<LI>
								Stress quality, reliability, and security.</LI>
						</UL>
					<TD vAlign="top" width="50%">
						<UL class="dont">
							<LI>
							Be vague or casual, particularly when answering questions.
							<LI>
							Move to the bottom line too quickly.
							<LI>
							Get personal about family if you don't know this person.
							<LI>
							Become impatient, agitated, or aggressive.
							<LI>
							Use&nbsp;aggressive techniques that cajole, coax, or instill fear.
							</LI>
						</UL>
					</TD>
				</TR>
			</TABLE>
			<DIV style="PAGE-BREAK-AFTER: always">&nbsp;</DIV>
			<h1>How to Influence and Persuade Clients Who Are...</h1>
			<H2>The High D Style</H2>
			<H3>Build credibility for yourself</H3>
			<UL>
				<LI>
				Let them know you value their time.
				<LI>
				Be confident and straightforward.
				<LI>
					Focus on results.</LI></UL>
			<H3>Build credibility for your advice</H3>
			<UL>
				<LI>
				Stress why your plan will help the client and meet his or her objectives.
				<LI>
				Be prepared to show proof of results.
				<LI>
					Demonstrate what's in it for the client.
				</LI>
			</UL>
			<H3>Structure your presentation to fit the High D style</H3>
			<UL>
				<LI>
				Be brief, direct, and fast-paced, and get to the point quickly.
				<LI>
				Suggest solutions with clearly-defined and agreed-upon consequences as well as 
				rewards that relate to the client's goals.
				<LI>
					Clarify risks and probabilities, and provide options.</LI>
			</UL>
			<H2>The High I Style</H2>
			<H3>Build credibility for yourself</H3>
			<UL>
				<LI>
				Give special attention and be interested and enthusiastic, without dominating 
				the discussion.
				<LI>
				Affirm the client's dreams and goals.
				<LI>
					Inform the client of your personal and corporate reputation.
				</LI>
			</UL>
			<H3>
				Build credibility for your&nbsp;advice</H3>
			<UL>
				<LI>
				Appeal to the client's affinity for the new, the special, the novel.
				<LI>
				Focus on the product's prestige and reputation.
				<LI>
					Give testimonials of "experts."
				</LI>
			</UL>
			<H3>Structure your presentation to fit the High I style</H3>
			<UL>
				<LI>
				Present with style and enthusiasm.
				<LI>
				Involve the client in the selling process; solicit his/her ideas and opinions.
				<LI>
					Illustrate your ideas with anecdotes and emotional descriptions.</LI></UL>
			<H2>The High S Style</H2>
			<H3>Build credibility for yourself</H3>
			<UL>
				<LI>
				Take a sincere, personal interest in the client as a person.
				<LI>
				Take the time to build a relationship; find common interests, and build trust.
				<LI>
					Focus on your reliability and loyalty.</LI></UL>
			<H3>
				Build credibility for your advice</H3>
			<UL>
				<LI>
				Talk security, service, safety, dependability, support.
				<LI>
				Focus on the benefits the offering provides.
				<LI>
					Emphasize proven products.
				</LI>
			</UL>
			<H3>Structure your presentation to fit the High S style
			</H3>
			<UL>
				<LI>
				Don't move too fast, and avoid high pressure tactics.
				<LI>
				Provide reassurance that the client is making the right decision and assurances 
				that all promises will be kept.
				<LI>
					Identify the client's emotional needs as well as the task or business 
					expectations.</LI></UL>
			<H2>The High C Style</H2>
			<H3>Build credibility for yourself</H3>
			<UL>
				<LI>
				Get down to business quickly; avoid personal or social chit-chat.
				<LI>
				Demonstrate your expertise—your knowledge of the product or service, the 
				process, the industry.
				<LI>
					Be well prepared so that you can answer all questions.
				</LI>
			</UL>
			<H3>
				Build credibility for your&nbsp;advice
			</H3>
			<UL>
				<LI>
				Appeal to logic, showing facts and benefits.
				<LI>
				Use detailed, documented evidence to support claims.
				<LI>
					Stress quality and reliability, and be able to show precedent; appeal to the 
					client's cautious nature.
				</LI>
			</UL>
			<H3>Structure your presentation to fit the High C style</H3>
			<UL>
				<LI>
				Pace your delivery to give the client time to think.
				<LI>
				Answer all questions carefully, and deal with objections completely.
				<LI>
					Stress reliability and safety to minimize risk.</LI></UL>
		</div>
	</body>
</HTML>
