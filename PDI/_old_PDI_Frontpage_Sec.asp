<h1><%=strTextPersonalDISCernmentInventoryRegMark%></h1>
<h2><i><%=strTextIncreasingPersonalEffectiveness%></i></h2>
<hr>

<br>
<% 	If strSiteType = "DG" Then %>
		<img class="report_image_left" align="left" src="images/TakingDISC_TDG.gif"  alt="" />
<% 	Else %>
		<img class="report_image_left" align="left" src="images/TakingDISC.gif"  alt="" />
      <div style="padding-left: 10px;">
<%
	End If
	Response.Write "<br><br>" & strTextEachOfUsHasStrengthsAndWeaknessesThat
	Response.Write "<br><br>" & strTextTheAbilityToPredictHowWeAndOtherPeopleWill
	Response.Write "<br><br>" & strTextBehaviorIsInfluencedByANumberOf
	Response.Write "<br><br>" & strTextManyOfUsHavediscoveredThatTheMoreWeKnow
	Response.Write "<br><br>" & strTextThePDIWillEnableYouToDiscoverAndDefine
%>
	</div>
<br><hr>