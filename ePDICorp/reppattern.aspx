<%@ Page language="c#" Codebehind="reppattern.aspx.cs" AutoEventWireup="false" Inherits="ePDICorp.reppattern" %>
<%@ Register TagPrefix="uc1" TagName="CorpBanner" Src="CorpBanner.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD>
		<title>reppattern</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
<script type="text/javascript" src="scripts/jquery-1.4.2.js"></script>
<script type="text/javascript" src="scripts/jquery.corners.js"></script>
		<LINK href="rs/<%= CorporateFolder %>/styles.css" type=text/css rel=stylesheet >
		<script type="text/javascript" src="wz_jsgraphics.js"></script>
		<script language="javascript">
			
			function suggestPatterns() {
				var imgPath = "images/" + culture + "/";
				for(var idx = 0; idx < algoSelect.length; idx++) {
					var imgID = "img_" + algoSelect[idx];
					var img = document.getElementById(imgID);
					
					var imgSrc = imgPath + algoSelect[idx]
					if(idx < 1) 
						imgSrc += "_TOP.GIF";
					else
						imgSrc += "_SEL.GIF";
						
					img.src = imgSrc;
				}
			}
		</script>
	</HEAD>
	<body onLoad="suggestPatterns();">
		<form id="Form1" method="post" runat="server">
			<%= getHTML("header.inc") %>
			<div id="main-content">
			<TABLE align="center" id="Table1" cellSpacing="0" cellPadding="0" border="0">
				<TR>
					<TD class="left-column" style="WIDTH: 260px">&nbsp;&nbsp;&nbsp;</TD>
					<TD class="style1" align="center">Click on the pattern below that matches your 
						DISC chart (left)<br>
					</TD>
					<TD class="right-column" style="WIDTH: 260px">&nbsp;</TD>
				</TR>
				<tr>
					<td class="left-column" style="WIDTH: 260px">&nbsp;</td>
					<td class="center-column"></td>
					<td class="right-column" style="WIDTH: 260px"></td>
				</tr>
				<TR>
					<TD style="PADDING-RIGHT: 1px;PADDING-LEFT: 1px;PADDING-BOTTOM: 1px;PADDING-TOP: 1px"
						vAlign="top" align="left" class="left-column">
						<div style="PADDING-RIGHT:5px;FLOAT:left;PADDING-BOTTOM:5px"><asp:Image id="imgComposite" runat="server"></asp:Image></div>
						Look at your DISC graph (left) and find the pattern in the Representative 
						Patterns Chart (right) that is the closest match. It doesn't have to be exactly 
						the same shape, but pay particular attention to which elements (D,I,S, and C) 
						are above or below the center line.<BR>
						<BR>
						Based on your scores, we recommend the blue and red highlighted patterns, but 
						these selected patterns are only a suggestion:
						<asp:Repeater id="rptSuggestions" runat="server">
							<HeaderTemplate>
								<ul>
							</HeaderTemplate>
							<ItemTemplate>
								<li>
									<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&sessionid=<%= SessionID %>&index=<%# Container.DataItem %>">
										<asp:Literal ID="Value" Runat="server" /></a></li>
							</ItemTemplate>
							<FooterTemplate>
								</ul>
							</FooterTemplate>
						</asp:Repeater>
						Click on individual patterns to read more about the personality type each 
						represents.
						<BR>
					</TD>
					<TD align="center" valign="top" class="center-column">
						<div id="canvas" style="WIDTH:5px;POSITION:relative;HEIGHT:5px">
							<img id="imgRepChart" style="BORDER-RIGHT:0px; BORDER-TOP:0px; BORDER-LEFT:0px; BORDER-BOTTOM:0px"
								src="images/en/chart.GIF"> <a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=1" style="LEFT:59px; POSITION:absolute; TOP:9px"
								title="Director (1)"><img id="img_01_Director" src="images/en/01_Director.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=2" style="LEFT:143px; POSITION:absolute; TOP:10px"
								title="Entrepreneur (2)"><img id="img_02_Entrepreneur" src="images/en/02_Entrepreneur.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=3" style="LEFT:226px; POSITION:absolute; TOP:11px"
								title="03_Organizer (3)"><img id="img_03_Organizer" src="images/en/03_Organizer.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=4" style="LEFT:12px; POSITION:absolute; TOP:132px"
								title="Pioneer (4)"><img id="img_04_Pioneer" src="images/en/04_Pioneer.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=5" style="LEFT:101px; POSITION:absolute; TOP:133px"
								title="Prevailer (5)"><img src="images/en/05_Prevailer.GIF" name="img_05_Prevailer" id="img_05_Prevailer" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=6" style="LEFT:216px; POSITION:absolute; TOP:119px"
								title="Cooperator (6)"><img id="img_06_Cooperator" src="images/en/06_Cooperator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=7" style="LEFT:343px; POSITION:absolute; TOP:9px"
								title="Affiliator (7)"><img id="img_07_Affiliator" src="images/en/07_Affiliator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=8" style="LEFT:425px; POSITION:absolute; TOP:10px"
								title="Negotiator (8)"><img id="img_08_Negotiator" src="images/en/08_Negotiator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=9" style="LEFT:508px; POSITION:absolute; TOP:12px"
								title="Motivator (9)"><img id="img_09_Motivator" src="images/en/09_Motivator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=10" style="LEFT:591px; POSITION:absolute; TOP:58px"
								title="Persuader (10)"><img id="img_10_Persuader" src="images/en/10_Persuader.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=11" style="LEFT:491px; POSITION:absolute; TOP:149px"
								title="Colleague (11)"><img id="img_11_Colleague" src="images/en/11_Colleague.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=12" style="LEFT:589px; POSITION:absolute; TOP:145px"
								title="Diplomat (12)"><img id="img_12_Diplomat" src="images/en/12_Diplomat.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=13" style="LEFT:395px; POSITION:absolute; TOP:120px"
								title="Strategist (13)"><img id="img_13_Strategist" src="images/en/13_Strategist.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=14" style="LEFT:599px; POSITION:absolute; TOP:247px"
								title="Persister (14)"><img id="img_14_Persister" src="images/en/14_Persister.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=15" style="LEFT:494px; POSITION:absolute; TOP:254px"
								title="Investigator (15)"><img id="img_15_Investigator" src="images/en/15_Investigator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=16" style="LEFT:596px; POSITION:absolute; TOP:348px"
								title="Specialist (16)"><img id="img_16_Specialist" src="images/en/16_Specialist.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=17" style="LEFT:522px; POSITION:absolute; TOP:393px"
								title="Advisor (17)"><img id="img_17_Advisor" src="images/en/17_Advisor.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=18" style="LEFT:442px; POSITION:absolute; TOP:394px"
								title="Associate (18)"><img id="img_18_Associate" src="images/en/18_Associate.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=19" style="LEFT:349px; POSITION:absolute; TOP:392px"
								title="Coordinator (19)"><img id="img_19_Coordinator" src="images/en/19_Coordinator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=20" style="LEFT:372px; POSITION:absolute; TOP:290px"
								title="Whirlwind (20)"><img id="img_20_Whirlwind" src="images/en/20_Whirlwind.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=21" style="LEFT:13px; POSITION:absolute; TOP:250px"
								title="Perfectionist (21)"><img id="img_21_Perfectionist" src="images/en/21_Perfectionist.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=22" style="LEFT:116px; POSITION:absolute; TOP:253px"
								title="Analyst (22)"><img id="img_22_Analyst" src="images/en/22_Analyst.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=23" style="LEFT:95px; POSITION:absolute; TOP:398px"
								title="Adaptor (23)"><img id="img_23_Adaptor" src="images/en/23_Adaptor.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=24" style="LEFT:181px; POSITION:absolute; TOP:397px"
								title="Creator (24)"><img id="img_24_Creator" src="images/en/24_Creator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=25" style="LEFT:262px; POSITION:absolute; TOP:395px"
								title="Administrator (25)"><img id="img_25_Administrator" src="images/en/25_Administrator.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=26" style="LEFT:7px; POSITION:absolute; TOP:352px"
								title="Advocate (26)"><img id="img_25_Advocate" src="images/en/26_Advocate.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=27" style="LEFT:233px; POSITION:absolute; TOP:278px"
								title="Individualist (27)"><img id="img_27_Individualist" src="images/en/27_Individualist.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a>
							<a href="RepPatternDesc.aspx?tc=<%= TestCode %>&amp;sessionid=<%= SessionID %>&amp;index=28" style="LEFT:303px; POSITION:absolute; TOP:204px"
								title="Level Patter (28)"><img id="img_28_LevelPattern" src="images/en/28_LevelPattern.GIF" style="BORDER-RIGHT:0px;BORDER-TOP:0px;BORDER-LEFT:0px;BORDER-BOTTOM:0px"></a></div>
						&nbsp;
					</TD>
					<TD class="right-column"></TD>
				</TR>
				<TR class="bottom-row">
					<TD class="left-column"></TD>
					<TD class="center-column"></TD>
					<TD class="right-column"></TD>
				</TR>
			</TABLE>
			</div>
		<%= getHTML("footer.inc") %>
		</form>
<script src="http://www.google-analytics.com/urchin.js" type="text/javascript">
</script>
<script type="text/javascript">
_uacct = "UA-368995-2";
urchinTracker();
</script>
	</body>
</HTML>
