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

	strTopPgSpacing = "<center><img SRC='images/DreamAssessmentTopBanner2.jpg' width='700' height='83'></center><br><br>"
	HighType1 = UCase(Request.QueryString("HT1"))
	HighType2 = UCase(Request.QueryString("HT2"))
	AppModBigGreyFont = "<strong><font face='helvetica,arial,sans-serif' size=7 color='#999999'>"
	AppModHugeFont = "<strong><font face='helvetica,arial,sans-serif' size=7>"
	AppModTitleFont = "<strong><font face='helvetica,arial,sans-serif' size=5>"
	EndAppModTitleFont = "</strong></font>"
	AppModParaFont = "<p><font face='helvetica,arial,sans-serif' size='3'>"
	EndAppModParaFont = "</font></p>"
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

<font face="helvetica,arial,sans-serif">

<%=AppModParaFont%>
<center>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<IMG SRC="images/DreamAssessmentTopBanner2.jpg" WIDTH="700" HEIGHT="83" ALT="">
			<br><br>
			<IMG SRC="images/DreamAssessmentTitle2.jpg" WIDTH="700" HEIGHT="430" ALT="">
			<br><br><br><br><br><br>
			<%=UserName%><br><%=TestDate%>
			<br>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>


<wxprinter PageBreak><%=strTopPgSpacing%>
<table width="700" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
<%=AppModParaFont%>
<%=AppModTitleFont%>
<i>Welcome to the Dreamscape...</i>
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Everyone's personality contains both strengths and weaknesses. In many cases our 
weaknesses are simply our strengths taken to extremes. For example, perseverance 
can become stubbornness, or optimism can become overconfidence.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
When we find ourselves in an environment that lends itself to our strengths, we 
generally move quickly and easily through that situation. On the other hand, when 
we find ourselves in a circumstance that highlights our weaknesses, the going gets 
extremely difficult.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
So it is at various stages along the way to fulfilling our dream. Certain stages 
will pose greater challenges than others, largely because of our personal style and 
the environment in which that style excels or struggles.
<%=EndAppModParaFont%>

<%=AppModParaFont%>
Think about your own style as you identified it in the Personal DISCernment Inventory . 
How do you respond to change? What is your risk tolerance? What about peer pressure-from 
a large group or a single person? Do you need quick results, or can you persevere without 
seeing much progress? How do you handle conflict, either external or internal? Disapproval? 
Delay? Let's look at the various places you will visit on the way to fulfilling your Dream 
and explore the major issue or challenge that each one presents.
<%=EndAppModParaFont%>
</td></tr></table>

<center>
<%=AppModParaFont%>
<br>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="images/feather2.jpg" WIDTH="96" HEIGHT="125">
		</td>
		<td align="left">
			<table width="560" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
							<%=AppModTitleFont%>
								<i>Stage 1: Recognizing and Embracing the Dream</i>
							<%=EndAppModTitleFont%>
							<br>
							<br><strong>Issue:</strong> <i>Purpose</i>
							<br><strong>Fear:</strong> <i>Inadequacy or Lack of Understanding</i>
							<br><strong>Valuable Attributes:</strong> <i>Perceptive, Discerning, Open, Prepared</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="1" CELLPADDING="1" align="center"><tr><td>
<%=AppModParaFont%>At this point, the Dreamer is still safely in the land of the Familiar, 
in his recliner in front of the mesmerizing box. Over time, as he realizes that something 
very big is missing from his life, and he begins to realizes that he was born to do whatever 
the Dream requires.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Deciding to pursue the Dream involves making hard choices and difficult 
changes. People who resolve to pursue the Dream struggle with denial and self doubt. "Maybe 
it's not the right time." "I'm not capable." "I'm trapped within my circumstances." "I have 
responsibilities." Embracing the Dream is the first step to pursuing it.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Are you someone who chooses to grow in self-awareness? Do you spend a 
significant amount of time focused on the future, or do you feel more comfortable 
concentrating on the immediate and the tangible? Are you sensitive to nuances and open to 
discovering hidden meanings? Do you to take sole responsibility for situations or are you 
more comfortable operating as part of a group? Do you work better in a predictable pattern? 
Are you quick to make decisions or do you prefer to let time solve most problems?
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<wxprinter PageBreak>
<%=strTopPgSpacing%>

<center>
<%=AppModParaFont%>
<br>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="images/suitcase2.jpg" WIDTH="96" HEIGHT="125">
		</td>
		<td align="left">
			<table width="560" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 2: Leaving the Comfort Zone and Encountering the Wall of Fear</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Change</i>
						<br><b>Fear:</b> <i>The Unknown</i>
						<br><b>Valuable Attributes:</b> <i>Goal-oriented, Confident, Decisive, Committed, Assertive</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>Change is difficult for everyone. If it doesn't make us 
uncomfortable, it probably isn't change. However, some of us embrace change 
more quickly and enthusiastically than others. Some people tire easily of the 
status quo and look actively for new challenges and opportunities, while others 
long for the stability and familiarity of comfortable routine and well-known 
surroundings. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Regardless of our response to change, whenever we encounter 
the unknown or the deeply challenging, everyone, at some point, hits the 
invisible Wall of Fear-the deep-seated concerns that plague us all. It may be 
a fear of missing a goal, a fear of looking foolish, a fear of disapproval 
from those we admire, a fear of hurting or disappointing someone else, a fear 
of making a mistake or looking inept. We may even experience a fear of what we 
will happen if we actually do achieve our Dream. Sometimes what we want the 
most is also what we dread the most. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Are you more pleased with where you've been than where you 
might go? Do you tend to act on your own initiative or wait for instructions 
from others? Do you relish the opportunity to tackle new challenges, to strike 
out on your own into uncharted territory? Or, do you need to receive confirmation 
of the correctness of your actions from events or from others? Do you value 
predictable patterns? Do you need time to adjust to new situations? 
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<center>
<br><br>
<%=AppModParaFont%>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="images/boat2.jpg" WIDTH="90" HEIGHT="125">
		</td>
		<td align="left">
			<table width="560" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 3: The Borderland</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Validation</i>
						<br><b>Fear:</b> <i>Fear of the Disapproval and Resistance of Others</i>
						<br><b>Valuable Attributes:</b> <i>Persuasive, Confident, Self-Reliant, Persistent</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>The Borderland is filled with people whose own lives will be affected by the actions of someone pursuing a Dream. They are often people with whom we are close and whom we admire and respect. Pursuing the Dream may involve separation or even estrangement from those we respect, admire, or love.
<%=EndAppModParaFont%>

<%=AppModParaFont%>When we make difficult decisions, how easy is it for us to detach issues from people? How important are relationships in our everyday choices? Do we need the approval of others, and to what degree? How do we react when someone is obviously displeased with us or hurt by something we choose to do? How well can we differentiate between following a Dream and pursuing a selfish desire?
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<wxprinter PageBreak>
<%=strTopPgSpacing%>

<center>
<%=AppModParaFont%>
<br>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="images/tree2.jpg" WIDTH="95" HEIGHT="125">
		</td>
		<td align="left">
			<table width="560" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 4: The Wasteland</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Unmet Expectations</i>
						<br><b>Fear:</b> <i>Not Knowing/Being Lost</i>
						<br><b>Valuable Attributes:</b> <i>Persistent, Patient, Calm, Optimistic, Adaptable</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>The Wasteland is characterized by the absence rather than the presence of anything or anyone who poses a threat. It's barren and empty-miles and miles of nothing. Every attempt to overcome it or escape its dismal boundaries leads to a dead end. Day after day delivers a bitter sameness that makes no advancement toward the Dream.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Are you someone who perseveres against great odds? How well do you deal with routine that seems to have little reward or shows limited progress? How do you deal with loneliness and isolation? How do you control disappointment and disillusionment? What happens when you feel betrayed? Do you need people around with whom you can talk through issues and setbacks?
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<br>
<br>
<center>
<%=AppModParaFont%>
<br>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="images/waterfall2.jpg" WIDTH="89" HEIGHT="125">
		</td>
		<td align="left">
			<table width="560" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 5: Sanctuary</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Control</i>
						<br><b>Fear:</b> <i>Losing Control/Recognition for Achievement</i>
						<br><b>Valuable Attributes:</b> <i>Obedient, Adaptable, Accommodating, Trustworthy, Conscientious</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>The Sanctuary is a place full of restoration, relief, and re-connection. It provides a time for self-evaluation and reflection. But it is also a place of surprises, an unexpected turn of events. After all the struggle, hardship, and self-denial, the pursuer of the Dream is asked to relinquish his or her control and possession of the Dream.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Do you easily surrender control of something in which you have invested tremendous energy and emotions? How much do you need recognition for your achievements and hard work? Perhaps you are comfortable being a facilitator or an implementer, and the final credit for achievement isn't that important. Or, you may find it difficult to turn over something to another because you fear it may not retain the quality or precision that you can ensure when it's under your care. Perhaps it's difficult for you to comply with instructions that, in your opinion, just don't make any sense. You need to understand all the facts before you can make that kind of decision.
<%=EndAppModParaFont%>
</td></tr></table>
</center>


<wxprinter PageBreak>
<%=strTopPgSpacing%>
<%=AppModParaFont%>
<br>
<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="images/sword2.jpg" WIDTH="94" HEIGHT="125">
		</td>
		<td align="left">
			<table width="560" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 6: Valley of the Giants</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>External Obstacles</i>
						<br><b>Fear:</b> <i>Failure/Loss of the Dream</i>
						<br><b>Valuable Attributes:</b> <i>Trusting, Resourceful, Alert, Self-Controlled, Courageous</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>Whereas the Border Bullies oppose the person, the Giants oppose the Dream (task). This gigantic opposition may take the form of loss of resources, fierce opposition by a group, or any other intimidating circumstances, even including a health crisis in the life of the Dreamer. Unlike the Border Bullies, the Giants create obstacles that cannot be reasoned away or circumvented. Nor is overcoming them within the power of the Dreamer. Only the Dream Giver can handle these obstacles, and He will receive all the credit for doing so.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Are you easily intimidated, particularly by big systems or powerful people? When circumstances turn out to be greater or more difficult than you anticipated, how do you respond? Do you tend to see overwhelming resistance as just another hurdle to surmount, or do you see its magnitude as validation that perhaps you shouldn't be attempting anything of this scale.
<%=EndAppModParaFont%>

<%=AppModParaFont%>How optimistic can you be when everything around you seems destined to fail? Is it easy or difficult for you to trust what you can't see or come to terms with logically? Are impossible situations a springboard to launch your creativity to the next level?
<%=EndAppModParaFont%>

<%=AppModParaFont%>When these obstacles are shattered, how do you deal with the fact that you yourself could not overcome them?
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<br>
<center>
<%=AppModParaFont%>
<br>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0">
	<tr>
		<td align="left" width="100">
			<img SRC="images/hands2.jpg" WIDTH="99" HEIGHT="125">
		</td>
		<td align="left">
			<table width="560" border="0" cellspacing="1" cellpadding="1">
				<tr>
					<tr>
						<%=AppModParaFont%>
						<%=AppModTitleFont%>
							<i>Stage 7: Land of Promise</i>
						<%=EndAppModTitleFont%>
						<br>
						<br><b>Issue:</b> <i>Sacrifice</i>
						<br><b>Fear:</b> <i>Success Behind for a New Unknown</i>
						<br><b>Valuable Attributes:</b> <i>Flexible, Open, Enterprising, Enthusiastic, Adaptable</i>
						<%=EndAppModParaFont%>
					</tr>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>The Land of Promise is the place where Big Needs match the Big Dream. And when this convergence occurs, the time to do the Dream has arrived-meeting the Big Needs by doing what one loves most. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>The further the Dreamer goes into doing the Dream, however, he once again feels the uncomfortable pull that leads him to yet another distant Unknown, and on the horizon he sees many more Valleys, and Wide Waters, and Lands of Promise. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>How difficult is it for you to look at something you have created with fresh eyes? Would you rather continue to refine and develop an existing situation rather than change it completely or move on to something else? How do you feel about leaving your achievements in the care of others who lack your experience and/or commitment? 
<%=EndAppModParaFont%>
</td></tr></table>
</center>


<wxprinter PageBreak>
<%=strTopPgSpacing%>
<br>

<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>
<%=AppModTitleFont%>
<i>Style and the Seven Stages </i>
<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
</td></tr></table>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>Each place on the Dreamscape poses different challenges, deals with different issues, strikes at different fears, and requires different aptitudes and abilities. Rarely does one personal style possess all the strengths that are necessary at each stage of the journey. Some stages require decisive action, while others demand patience and endurance. At times the journey demands confidence, enthusiasm, and assertiveness; at other points, the need is for accommodation, self-sacrifice, adaptability, and precision. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>This application report will help you recognize how the particular strengths and weakness of your style will impact your Dream Journey. You will find that in certain stages your personal style may have strengths that assist you in meeting the challenges. However, in other stages along the way, you may need to find ways to overcome the weakness of your particular style. You can successfully navigate through the entire process to achieve your Dream, but in some instances you will need to create an action plan to help you compensate for the particular challenges that a stage presents.
<%=EndAppModParaFont%>

<%=AppModParaFont%>This application report can be a valuable tool, along with other resources, to help you arrive safely at the Land of Promise. Wherever you are in your Dreamscape, increasing your self-awareness will be of great help to you in completing the Journey to your Big Dream.
<%=EndAppModParaFont%>
</td></tr></table>
</center>

<wxprinter PageBreak>
<%=strTopPgSpacing%>
<br>

<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>
	<%=AppModTitleFont%>
		<i>The Styles and Dreaming: an Overview</i>
	<%=EndAppModTitleFont%>
<%=EndAppModParaFont%>
</td></tr></table>

<%=AppModParaFont%>
<br>
<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
	<img SRC="images/PDID_High_D.jpg" WIDTH="269" HEIGHT="152" align="right">
	<table WIDTH="400" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="left">
		<tr>
			<td align="left">
				<%=AppModParaFont%>
				<%=AppModTitleFont%>
					High D
				<%=EndAppModTitleFont%>
				<br><b>Focus:</b> <i>Overcoming Opposition to Achieve the Dream</i>
				<br><b>Motivation:</b> <i>Challenge/Adventure</i>
				<br><b>Basic Intent:</b> <i>To Overcome, to Triumph</i>
				<br><b>Greatest Fear:</b> <i>Loss of Control/Being Blocked from Achieving Goal</i>
				<%=EndAppModParaFont%>
			</td>
		</tr>
	</table>
</td></tr></table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>D quadrant people are active and task-oriented. Not usually much for extended self-reflection and inner conflict, D's will act quickly when the Dream is revealed to them. A High D won't need too many details; he or she will accumulate information on a need-to-know basis. They are energized by the fact that it's their goal rather than someone else's. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Leaving the Comfort Zone will not create much anxiety in a D. By nature, they hate routine and are prone to changing jobs until they find the challenge they need. Their encounter with the Wall of Fear should be short-lived. Since D's embrace change and risk, the only fear associated with the Wall would be the inability to surmount it-the Wall's potential ability to control the D. Once they realize that the Wall is an invisible barrier, they move through it easily.
<%=EndAppModParaFont%>

<%=AppModParaFont%>The Border Bullies will not deter the D Dreamer significantly. D's are real individualists and very self-sufficient. Once they set their course, other people have limited influence. They will make a token attempt to state their case, and then move on. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>One of the more difficult stages of the DreamScape will be when a D finds him or herself alone in the Wasteland. D's thrive on keeping their eye on the Goal, and the frustrating delay and doubt, without the encouragement of making progress, will be extremely maddening. However, the Ds' dogged perseverance will see them through.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Sanctuary will create perhaps the biggest challenge for the goal-oriented D, when he or she attains the summit and sees the Land of Promise on the Horizon. Not surprisingly, the High D's difficulty with relinquishing control will be acute at this critical juncture. Making the right choice, however, the D will overcome the tendencies of his or her personal style and surrender the Dream to the Dream Giver, comforted by the knowledge that the Dream is now even more significant. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>The D Dreamer is a fighter and a striver, and he or she rarely shirks conflict. The Land of the Giants calls on a D's affinity for competition, tough assignments, stressful situations, and huge demands. Even though D's like to be in charge, the fact that the Dream Giver receives the credit is not inordinately troubling to D Dreamers as long as it moves them ever closer to their goals. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Thriving in the Promised Land, with its ever-increasing demands and overwhelming needs is exhilarating to the D, but as he or she arrives at the back gate of the city, a familiar and uncomfortable pull exerts its influence. The D Dreamer is ready to take on the next Dream and encounter bigger and bolder opportunities. The High D's discontent with the status quo creates the motivation to pursue a new Dream.
<%=EndAppModParaFont%>
</td></tr></table>
</center>


<wxprinter PageBreak>
<%=strTopPgSpacing%>
<br>

<%=AppModParaFont%>
<br>
<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
	<img SRC="images/PDID_High_I.jpg" WIDTH="242" HEIGHT="168" align="right">
	<table WIDTH="400" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="left">
		<tr>
			<td align="left">
				<%=AppModParaFont%>
				<%=AppModTitleFont%>
					High I
				<%=EndAppModTitleFont%>
				<br><b>Focus:</b> <i>Motivating and Aligning Others in Achieving the Dream</i>
				<br><b>Motivation:</b> <i>Recognition/Approval</i>
				<br><b>Basic Intent:</b> <i>To Persuade/Energize</i>
				<br><b>Greatest Fear:</b> <i>Lack of Recognition for Accomplishments or Failure that Creates Negative Recognition</i>
				<%=EndAppModParaFont%>
			</td>
		</tr>
	</table>
</td></tr></table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>High I's, because of their innate optimism and enthusiasm, are quick to grasp new ideas and see the big picture. Because they seek recognition for their achievements, Big Dreams are part and parcel of their plans. Their natural energy and enthusiasm tend to make them restless and eager to try new things, particularly if they are able to gain agreement from other people in their endeavors. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Change is not particularly unsettling to them, as they are poised and at ease with strangers and new environments, both at work and in social situations. High I's will pursue the Dream with innovation and creativity, being willing to try new or non-traditional approaches. But as they come to the end of this stage, they encounter their particular Wall of Fear: "What if the Dream isn't a success? What if others disapprove of it?"
<%=EndAppModParaFont%>

<%=AppModParaFont%>That same concern with the recognition and approval of others makes the resistance of the Border Bullies particularly troubling to this people-focused Dreamer. Fortunately, High I's can be amazingly persuasive and excellent at getting others on board, so their powers of influence and their confidence will aid them in this situation. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Although the Wasteland will be frustrating and lonely for the people-oriented High I, their innate belief that things will turn out well will help them get through this tough period. And although surrendering the Dream to the Dream Giver at Sanctuary may be difficult, the I's urge to please and be admired will enable him or her to relinquish with grace, believing that it's ultimately for the best and will win the Dream Giver's approval. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Task-based obstacles pose difficult times for High I's because they are more accustomed to solving problems through people. For this reason, High I's will do well in some encounters in the Land of the Giants and struggle in others-depending on whether the obstacle involves systems or people. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Once High I's reach the Land of Promise, they are in their element-successful, interactive, affiliated, and probably admired. The recognition and esteem that come from their accomplishments in meeting the Big Needs fuels their energy to work even harder. They will experience mixed feelings when it is time to pursue a different and bigger Dream. But it's also their nature to look for the next great experience.
<%=EndAppModParaFont%>
</td></tr></table>
</center>


<wxprinter PageBreak>
<%=strTopPgSpacing%>
<br>

<%=AppModParaFont%>
<br>
<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
	<img SRC="images/PDID_High_S.jpg" WIDTH="239" HEIGHT="139" align="right">
	<table WIDTH="400" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="left">
		<tr>
			<td align="left">
				<%=AppModParaFont%>
				<%=AppModTitleFont%>
					High S
				<%=EndAppModTitleFont%>
				<br><b>Focus:</b> <i>Pursuing the Dream within the Status Quo</i>
				<br><b>Motivation:</b> <i>Appreciation</i>
				<br><b>Basic Intent:</b> <i>To Support/Align</i>
				<br><b>Greatest Fear:</b> <i>Conflict/Damage to Relationships/Sudden Change</i>
				<%=EndAppModParaFont%>
			</td>
		</tr>
	</table>
</td></tr></table>
<%=EndAppModParaFont%>
</center>

<center>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>The High S's supportive and compassionate nature makes them particularly receptive to Dreams that involve service to others. Meeting needs is part of their relationship-based approach. However, High S's are by nature realistic and down-to-earth. The magnitude of the Dream may make it initially difficult for them to embrace. The High S will most likely spend extra time in the first stage of the Dream Journey, processing the idea, adjusting to the necessary change ahead, and planning for it. For the same reason, leaving the Comfort Zone may take more time, perhaps even occurring in stages. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>The Wall of Fear for High S's will relate to the possibility that their Dream may cause discomfort and pain in others. Since S's are responsive and relationship-oriented, they are most sensitive to how their actions affect close associates-friends, family, valued coworkers. The Border Bullies will pose almost overwhelming obstacles for the S, as they work best in situations where everyone stays involved in solving problems, making decisions, and reviewing progress. To strike out on one's own, without the endorsement and support of those close to the High S will be difficult indeed. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Once in the Wasteland, however, the S's even-tempered, low-key, emotionally mature nature will serve well during this difficult period. High S's are patient, predictable, and dogged in pursuit of a goal. The problems of this part of the journey will not be overwhelming. Once through the Wasteland and into the Sanctuary, the S will experience great contentment. Although they will feel a strong sense of ownership or possession about the Dream and may experience some internal disappointment about relinquishing it, turning over the Dream to the Dream Giver will be consistent with the S's supportive and amiable personal style. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>The S will have difficulty with the conflict and upheavals that occur in the Land of the Giants, but he or she will be persistent in working to overcome these external obstacles to the task. Further, a High S will be willing and happy to see the glory assigned to the Dream Giver when miraculous solutions dispel the threats to the Dream. 
<%=EndAppModParaFont%>

<%=AppModParaFont%>Once in the Land of Promise where the S's Dream meets the Big Need, the S will be in an environment that coincides with the S's natural strengths-serving, supporting, and collaborating. Because of the S's desire to maintain the status quo, however, expanding, re-shaping, and redefining the Dream leading to a new cycle will not be easy. The tendency will be to stay and work with the current demands. As in the first sequence, the S will need more time to process the concept of the New Dream and once again move out of the Comfort Zone.
<%=EndAppModParaFont%>
</td></tr></table>
</center>


<wxprinter PageBreak>
<%=strTopPgSpacing%>
<br>

<%=AppModParaFont%>
<br>
<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<img SRC="images/PDID_High_C.jpg" WIDTH="258" HEIGHT="130" align="right">
	<table WIDTH="400" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="left">
		<tr>
			<td align="left">
				<%=AppModParaFont%>
				<%=AppModTitleFont%>
					High C
				<%=EndAppModTitleFont%>
				<br><b>Focus:</b> <i>Pursuing the Right Dream with the Highest Standards</i>
				<br><b>Motivation:</b> <i>Security/Accuracy</i>
				<br><b>Basic Intent:</b> <i>To Be Correct/Prepared</i>
				<br><b>Greatest Fear:</b> <i>Making a Mistake</i>
				<%=EndAppModParaFont%>
			</td>
		</tr>
	</table>
</td></tr></table>
<%=EndAppModParaFont%>

<table WIDTH="700" BORDER="0" CELLSPACING="0" CELLPADDING="0" align="center"><tr><td>
<%=AppModParaFont%>The High C will embrace a Dream only after doing the due diligence necessary to come to a measured and painstaking decision. He or she will research the subject extensively, pursuing the answers to a seemingly endless supply of questions. Weighing the pros and cons of following the Dream will take considerable time and energy, but once the plan is in place the C will be unwaveringly committed. Leaving the Comfort Zone will be easier for the High C if he or she has gathered facts and developed a system with adequate checkpoints and clearly defined goals.
<%=EndAppModParaFont%>

<%=AppModParaFont%>For the High C, the Wall of Fear symbolizes the concern that perhaps he or she isn't going in the right direction and is headed into harm's way. Once through the Wall, however, the C's confrontation with the Border Bullies is characterized by his or her attempt to explain logically why the decision is a right one. Even though the C prefers to avoid conflict, because the High C is more task-oriented than relationship-focused, he or she can be more objective in dealing with the resistance from people when fortified with an internal assurance about the rightness of the task.
<%=EndAppModParaFont%>

<%=AppModParaFont%>The Wasteland will be troubling to the High C because things aren't going according to plan. The delay and seeming chaos will cause this person to question and second-guess the decision. "If it's the right decision, then things should be turning out the way I planned!" Therefore, choosing to follow the path of Faith may be difficult for the C and will be an option only as a last resort.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Sanctuary provides validation for the High C's decisions, who welcomes the safety and security of this stage. However, the Dream Giver's request for the Dream is most unsettling to the High C who wants to go by the book and not deviate from the original plan. High C's believe inherently that if you want something done right, you must do it yourself, and relinquishing control of a task is difficult.
<%=EndAppModParaFont%>

<%=AppModParaFont%>Circumstances in the Land of the Giants conflict with the C's desire to avoid trouble and turmoil. Even with all the careful planning, obstacles to the Dream are everywhere and ominous. Yet since the C sees the world as challenging, he or she isn't overly surprised by the turn of events and diligently looks for ways to solve problems. At times, solutions that occur miraculously rather than logically may be perplexing to the High C.
<%=EndAppModParaFont%>

<%=AppModParaFont%>The Land of Promise presents the C with the happy convergence of the Big Dream and the Big Need and the opportunity to put the careful planning and organization to work. Because the C is a master at anticipating eventualities and having clear contingency plans in place, he or she should thrive in administering the Dream. Redefining the Dream and accepting the never-ending horizon will require more thought, research, and planning.
<%=EndAppModParaFont%>
</td></tr></table>

<wxprinter PageBreak><%=strTopPgSpacing%>
<% if UCase(HighType1) = "D" then %>
	<!--#INCLUDE FILE="AppModuleDream_Style_D.asp" -->
<% elseif UCase(HighType1) = "I" then %>
	<!--#INCLUDE FILE="AppModuleDream_Style_I.asp" -->
<% elseif UCase(HighType1) = "S" then %>
	<!--#INCLUDE FILE="AppModuleDream_Style_S.asp" -->
<% elseif UCase(HighType1) = "C" then %>
	<!--#INCLUDE FILE="AppModuleDream_Style_C.asp" -->
<% end if %>
</font>
</body>
</html>