
<%

Dim HP(4)
Dim HPValue(4)
Dim HPHPT(4)
Dim CHPT(4)


' retrieve the most, least and composite numbers 
' from the database

Set oConn = CreateObject("ADODB.Connection")
Set oCmd = CreateObject("ADODB.Command")
Set oRs = CreateObject("ADODB.Recordset")

With oCmd

     .CommandText = "spTestSummarySelect"
     .CommandType = 4

     .Parameters.Append .CreateParameter("@RETURN_VALUE", 3, 4, 0)
     .Parameters.Append .CreateParameter("@TestCodeID",3, 1,4, TestCodeID)

End With

oConn.Open strDBaseConnString

oCmd.ActiveConnection = oConn

oRs.CursorLocation = 3

oRs.Open oCmd, , 0, 1

If oConn.Errors.Count < 1 then

	nM1 = oRs("M_NumberD")
	nM2 = oRs("M_NumberI")
	nM3 = oRs("M_NumberS")
	nM4 = oRs("M_NumberC")

	nL1 = oRs("L_NumberD")
	nL2 = oRs("L_NumberI")
	nL3 = oRs("L_NumberS")
	nL4 = oRs("L_NumberC")

	nC1 = oRs("C_NumberD")
	nC2 = oRs("C_NumberI")
	nC3 = oRs("C_NumberS")
	nC4 = oRs("C_NumberC")
	
	HP(1) = oRs("HighFactorType1")
	HP(2) = oRs("HighFactorType2")
	HP(3) = oRs("HighFactorType3")
	HP(4) = oRs("HighFactorType4")

	HPValue(1) = oRs("HighFactorType1Value")
	HPValue(2) = oRs("HighFactorType2Value")
	HPValue(3) = oRs("HighFactorType3Value")
	HPValue(4) = oRs("HighFactorType4Value")
	
else 

	Response.Write "Unable to retrieve results from database. Please try again."
	Response.End
	
end if 

IF ISNULL(HPValue(1)) = TRUE then 
	HPValue(1) = 0 
end if

IF ISNULL(HPValue(2)) = TRUE then 
	HPValue(2) = 0 
end if

IF ISNULL(HPValue(3)) = TRUE then 
	HPValue(3) = 0 
end if

IF ISNULL(HPValue(4)) = TRUE then 
	HPValue(4) = 0 
end if

HPHPT(1) = 0
HPHPT(2) = 0 
HPHPT(3) = 0 
HPHPT(4) = 0 
	
CHPT(1) = 0
CHPT(2) = 0 
CHPT(3) = 0 
CHPT(4) = 0 

' Calculate what items are the highpoints
' You have the highpoints in letter in order and their values
' but you have to calculate because you don't know which ones are equal 
' etc, etc. 
' HPValue array contains the value of the highpoint in order of highest point to 
' lowest point
' The HP array contains the character of the highpoint in order of highest point to 
' lowest point
if CInt(HPValue(1)) = CInt(HPValue(2)) AND CInt(HPValue(2)) = CInt(HPValue(3)) AND CInt(HPValue(3)) = CInt(HPValue(4)) then
	
	HPHPT(1) = 1
	HPHPT(2) = 1 
	HPHPT(3) = 1 
	HPHPT(4) = 1  
	
else 
		   if HPValue(1) = HPValue(2) AND HPValue(2) = HPValue(3) then 
				HPHPT(1) = 1
				HPHPT(2) = 1 
				HPHPT(3) = 1 
		   else 
				' the 4 pts are not equal
				' the 3 pts are not equal
				' then check for 2 points equal
						
				if HPValue(1) = HPValue(2) then				
					' 2 points are equal
				
					HPHPT(1) = 1
					HPHPT(2) = 1 
				 
				else 
				' display the 2 highest points
					
					HPHPT(1) = 1
					
					' [SM] Disabled the following if...end if block because TR only wants the highest point shown, not
					' [SM] the highest and second highest points, unless of course they are equal, which is addressed above.
					'if ISNULL(HP(2)) = FALSE then  
					
						'Your second highest point is HP(2)
						'HPHPT(2) = 1		
					
					'end if
						
				end if
				
		   end if 
				
end if 

Dim nCounter

' the highpoints are in an array listed in order of the highpoint, convert this to the 
' order of the params passed into the asp chart page
' CHPT(1) - if 1 means that D is the highpoint
' CHPT(2) - if 1 means that I is the highpoint 
' CHPT(3) - if 1 means that S is the highpoint 
' CHPT(4) - if 1 means that C is the highpoint 

For nCounter = 1 to 4

	If HP(nCounter) = "D" and CInt(HPHPT(nCounter)) = 1 then
		CHPT(1) = 1 
	end if 

	If HP(nCounter) = "I" and CInt(HPHPT(nCounter)) = 1 then
		CHPT(2) = 1 
	end if
	
	If HP(nCounter) = "S" and CInt(HPHPT(nCounter)) = 1 then
		CHPT(3) = 1 
	end if
	
	If HP(nCounter) = "C" and CInt(HPHPT(nCounter)) = 1 then
		CHPT(4) = 1 
	end if

Next 

Set oConn = Nothing
Set oCmd = Nothing
Set oRs = Nothing

%>

<h1>Behavioral Characteristics</h1>

<div align="center">
<table class="addtable" border="0" cellspacing="0" cellpadding="0" width="570">
	<tr>
		<td valign="top" align="center" width="120">
			<img src="disccomposite_small_withHPtsCircled.asp?nD1H=<%=CHPT(1)%>&amp;nD2H=<%=CHPT(2)%>&amp;nD3H=<%=CHPT(3)%>&amp;nD4H=<%=CHPT(4)%>&amp;nD1=<%=nC1%>&amp;nD2=<%=nC2%>&amp;nD3=<%=nC3%>&amp;nD4=<%=nC4%>" alt="" /><br />
			<strong>Composite Graph</strong>
		</td>
		
		<td valign="top" width="450">
			<table border="0" cellspacing="0" cellpadding="6" width="450">
				<tr>
					<td valign="top" align="center" colspan="2"><strong>Click on a letter to read more about that style</strong></td>
				</tr>
				
				<tr>
					<td valign="top" align="center" colspan="2"><span id="discimage"></span>
					
						<map name="disc">
							<area shape=poly alt="" coords="310,1,381,1,381,14,345,28,310,14" href="javascript:CClicked()">
							<area shape=poly alt="" coords="222,1,293,1,293,14,257,28,222,14" href="javascript:SClicked()">
							<area shape=poly alt="" coords="135,1,206,1,206,14,170,28,135,14" href="javascript:IClicked()">
							<area shape=poly alt="" coords="48,1,119,1,119,14,83,28,48,14" href="javascript:DClicked()">
						</map>
					</td>
				</tr>
							
				<tr>
					<td valign="top" align="left" colspan="2"><span id="instrtext"></span></td>
				</tr>
							
				<tr>
					<td valign="top" align="right" width="150"><strong><span id="othertermsttl"></strong></span></td>
					<td valign="top" align="left" width="300"><span id="otherterms"></span></td>
				</tr>
							
				<tr>
					<td valign="top" align="right" width="150"><strong><span id="emphasisttl"></strong></span></td>
					<td valign="top" align="left" width="300"><span id="emphasis"></span></td>
				</tr>
							
				<tr>
					<td valign="top" align="right" width="150"><strong><span id="keytomotivationttl"></strong></span></td>
					<td valign="top" align="left" width="300"><span id="keytomotivation"></span></td>
				</tr>
							
				<tr>
					<td valign="top" align="right" width="150"><strong><span id="basicintentttl"></strong></span></td>
					<td valign="top" align="left" width="300"><span id="basicintent"></span></td>
				</tr>
							
				<tr>
					<td valign="top" align="center" colspan="2"><span id="pdiimage"></span></td>
				</tr>
							
				<tr>
					<td valign="top" align="left" colspan="2"><span id="description"></span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>

<!--#INCLUDE FILE="print_profile_link.asp" -->

<% if (SPN <> "0") and (oldButtons = true) then %>

<table border="0" cellspacing="0" cellpadding="0" width="570">
		<tr>
			<td align="right">
				<a href="PDIProfileBehavioralChar1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>"><img alt="" src="images/PDIPrevPage.gif" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="PDIProfileRepProfile1.asp?res=<%=intResellerID%>&TCID=<%=TestCodeID%>"><img alt="" src="images/PDINextPage.gif" /></a>
			</td>
		</tr>
</table>


<% end if %>


<script>
<!--

InstClicked();

function ShowTitles()
{
	document.getElementById("othertermsttl").innerHTML = "Other Terms:";
	document.getElementById("emphasisttl").innerHTML = "Emphasis:";
	document.getElementById("keytomotivationttl").innerHTML = "Key to Motivation:";
	document.getElementById("basicintentttl").innerHTML = "Basic Intent:";
	//document.getElementById("greatestfearttl").innerHTML = "Greatest Fear:";
}


function HideTitles()
{
	document.getElementById("othertermsttl").innerHTML = "";
	document.getElementById("emphasisttl").innerHTML = "";
	document.getElementById("keytomotivationttl").innerHTML = "";
	document.getElementById("basicintentttl").innerHTML = "";
	//document.getElementById("greatestfearttl").innerHTML = "";
}


function DClicked()
{
	ShowTitles();
		
	document.getElementById("otherterms").innerHTML = "Driving, Directing";
	document.getElementById("emphasis").innerHTML = "Controlling the environment by overcoming opposition to achieve desired goals";
	document.getElementById("keytomotivation").innerHTML = "Challenge";
	document.getElementById("basicintent").innerHTML = "To Overcome";
	//document.getElementById("greatestfear").innerHTML = "Loss of Control";
	document.getElementById("description").innerHTML = "<p>'D' Quadrant people are self-starters who get going when things get tough. You thrive on competition and are usually direct, positive, and straightforward - sometimes blunt. You like to be center stage and in charge.</p><p>You will fight hard for what you think is the way to go but can accept momentary defeat without holding grudges. You hate routine and are prone to changing jobs, especially early in your career, until you find the challenge you need.</p><p>D's thrive on competition, tough assignments, heavy work loads, pressure, opportunities for individual accomplishment. You are discontented with the status quo.</p><p>You are a real individualist and very self-sufficent. You demand a great deal of yourself and others.</p>";
	document.getElementById("pdiimage").innerHTML = "<img src='images/dominance.gif' alt='' width='370' height='213' />"
	document.getElementById("instrtext").innerHTML = "<span class='headertext'>Dominant</span>";
	document.getElementById("discimage").innerHTML = "<img src='images/discbox_d.gif' alt='' width='431' height='28' usemap='#disc' />";
}


function IClicked()
{
	ShowTitles();

	document.getElementById("otherterms").innerHTML = "Expressive, Persuasive";
	document.getElementById("emphasis").innerHTML = "Creating the environment by motivating and aligning others to accomplish results";
	document.getElementById("keytomotivation").innerHTML = "Recognition";
	document.getElementById("basicintent").innerHTML = "To Persuade";
	//document.getElementById("greatestfear").innerHTML = "Fear Itself";
	document.getElementById("description").innerHTML = "<p>'I' quadrant people thrive on social contact, one-on-one situations, and freedom from control and detail. I's are friendly, outgoing, persuasive and confident.</p><p>Your basic interest is people. You are poised and meet strangers well. People seem to respond to you naturally, and you usually have a wide range of acquantainces. Your innate optimism and people skills help you get along with most people, including competitors.</p><p>Often very fashionable dressers, I's join organizations for prestige and personal recognition.</p>";
	document.getElementById("pdiimage").innerHTML = "<img src='images/influence.gif' alt='' border='0' width='331' height='209' />"
	document.getElementById("instrtext").innerHTML = "<span class='headertext'>Influential</span>";
	document.getElementById("discimage").innerHTML = "<img src='images/discbox_i.gif' alt='' width='431' height='28' usemap='#disc' />";
}


function SClicked()
{
	ShowTitles();
	
	//document.form1.DESC.value = "S Description";
	document.getElementById("otherterms").innerHTML = "Amicable, Supportive";
	document.getElementById("emphasis").innerHTML = "Maintaining the environment to carry out specific tasks";
	document.getElementById("keytomotivation").innerHTML = "Appreciation";
	document.getElementById("basicintent").innerHTML = "To Support";
	//document.getElementById("greatestfear").innerHTML = "Fear Itself";
	document.getElementById("description").innerHTML = "<p>The 'S' quadrant person thrives in a relaxed, friendly atmosphere without much pressure, one that offers security, limited territory, predictable routine, and credit for work accomplished.</p><p>You are usually amiable, easy going, warm hearted, home-loving, and neighborly. On the other hand, you may be undemonstrative and controlled. You conceal your feelings and sometimes hold a grudge.</p><p>Most of the time S people are even-tempered, low-key, emotionally mature, and unobtrusive. You are generally content with the status quo and prone to leniency with yourself and others.</p><p>S people dislike change. Once under way, you work steadily and patiently, and you dislike deadlines. You are usually very possessive and develop strong attachments for your things, your famliy, your department, your position.</p>";
	document.getElementById("pdiimage").innerHTML = "<img src='images/steadiness.gif' alt='' border='0' width='344' height='200'>"
	document.getElementById("instrtext").innerHTML = "<span class='headertext'>Steady</span>";
	document.getElementById("discimage").innerHTML = "<img src='images/discbox_s.gif' alt='' width='431' height='28' usemap='#disc' />";
}


function CClicked()
{
	ShowTitles();
	
	//document.form1.DESC.value = "C Description";
	document.getElementById("otherterms").innerHTML = "Cautious, Analytical";
	document.getElementById("emphasis").innerHTML = "Structuring the environment to produce products and services that meet high standards";
	document.getElementById("keytomotivation").innerHTML = "Protection/Security";
	document.getElementById("basicintent").innerHTML = "To Be Correct";
	//document.getElementById("greatestfear").innerHTML = "Fear Itself";
	document.getElementById("description").innerHTML = "<p>The 'C' quadrant person thrives on order, pre-determined methods, tradition, and conflict-free atmospheres with ample opportunity for careful planning and without sudden changes.</p><p>C methods are pre-determined, precise, and attentive to detail. You prefer to adapt to situations to avoid conflict and antagonism. Your need for self-preservation causes you to document everything that you do, and you try to do whatever others want you to do.</p><p>Naturally cautious, you prefer to wait and see which way the wind is blowing. Once your mind is made up, however, you can be very firm in adhering to procedures.</p>";
	document.getElementById("pdiimage").innerHTML = "<img src='images/conscientiousness.gif' alt='' width='372' height='187'>"
	document.getElementById("instrtext").innerHTML = "<span class='headertext'>Conscientious</span>";
	document.getElementById("discimage").innerHTML = "<img src='images/discbox_c.gif' alt='' width='431' height='28' usemap='#disc' />";
}


function InstClicked()
{
	HideTitles();
	
	document.getElementById("otherterms").innerHTML = "";
	document.getElementById("emphasis").innerHTML = "";
	document.getElementById("keytomotivation").innerHTML = "";
	document.getElementById("basicintent").innerHTML = "";
	//document.getElementById("greatestfear").innerHTML = "";
	document.getElementById("description").innerHTML = "";
	document.getElementById("pdiimage").innerHTML = "";
	document.getElementById("instrtext").innerHTML = "Although everyone is a mixture of all four styles, most of us have one predominant style: D, I, S, or C. This predominant style is the highest point on your composite graph (circled on the left). Identify your high point (D, I, S, or C) and then click on the corresponding letter above. If a second point is close to or even with the highest point, click on that letter as well. When you have read the description of your high point(s), take a moment to read about the other styles as well.";
	document.getElementById("discimage").innerHTML = "<img src='images/discbox.gif' alt='' width='431' height='28' usemap='#disc' />";
}

-->
</script>

