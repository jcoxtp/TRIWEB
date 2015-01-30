<p>
<% strTemp = Replace(strTextAspectsOfYourBehavioralStyleMa, "{{HighType1}}", HighType1) %>
<%=UserName%>, <%= strTemp %><!--aspects of your behavioral style may prove a help or hindrance as you work in sales. Below are listed the strengths and weaknesses commonly found in a high <%=HighType1%> temperament. They are organized around the key components of sales. Personalize this list by checking those items you believe accurately describe you and adding other items that come to mind as you review the list.-->
</p>


<TABLE WIDTH=100% BORDER=0 CELLSPACING=0 CELLPADDING=3>
	<TR>
		<TD style="border-top: 1px black solid; border-bottom: 1px black solid;">&nbsp;</TD>
		<TD style="border-top: 1px black solid; border-bottom: 1px black solid;" ALIGN=MIDDLE><font size=3><STRONG><%= strTextTheHighISalespersonsStrengths %><!--The High I Salesperson's Strengths--></STRONG></TD>
		<TD style="border-top: 1px black solid; border-bottom: 1px black solid;" ALIGN=MIDDLE><font size=3><STRONG><%= strTextTheHighISalespersonsWeaknesses %><!--The High I Salesperson's Weaknesses--></STRONG></TD>
	</TR>
	<TR>
		<TD style="border-bottom: 1px black solid;"><font size=3><STRONG><%= strTextTargeting %><!--Targeting--></STRONG></TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextOptimisticAndSelfconfident %><!--Optimistic and self-confident--></li>
					<li><%= strTextMeetsPeopleEasily %><!--Meets people easily--></li>
					<li><%= strTextAtEaseWithStrangers %><!--At ease with strangers--></li>
					
			</ul>
		</TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextNeedsControlOverTime %><!--Needs control over time--></li>
					<li><%= strTextMayOverestimatePotential %><!--May overestimate potential--></li>
					
			</ul>
		</TD>
	</TR>
	<TR>
		<TD style="border-bottom: 1px black solid;"><font size=3><STRONG><%= strTextPreparation %><!--Preparation--></STRONG></TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextTakesInitiativeKeepsLivelyPace %><!--Takes initiative; keeps lively pace--></li>
					<li><%= strTextComplimentaryAndUpbeat %><!--Complimentary and upbeat--></li>
					<li><%= strTextMentionsPrestigiousCustomers %><!--Mentions prestigious customers--></li>
					<li><%= strTextMentionsOwnAchievements %><!--Mentions own achievements--></li>
					<li><%= strTextReactsEnthusiasticallyToCustom %><!--Reacts enthusiastically to customer's situation--></li>
					<li><%= strTextFeelsTheImpactOfCustomerNeeds %><!--Feels the impact of customer needs--></li>
					
			</ul>
		</TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextMayRunLateToAppointments %><!--May run late to appointments--></li>
					<li><%= strTextTendsToTalkMoreThanListen %><!--Tends to talk more than listen--></li>
					<li><%= strTextMayFailToStayFocused %><!--May fail to stay focused--></li>
					<li><%= strTextMayTalkTooMuchAboutSelf %><!--May talk too much about self--></li>
					<li><%= strTextMayAppearSuperficialOrInsincer %><!--May appear superficial or insincere--></li>
					
			</ul>
		</TD>
	</TR>
	<TR>
		<TD style="border-bottom: 1px black solid;"><font size=3><STRONG><%= strTextPresentation %><!--Presentation--></STRONG></TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextLovesToTalk %><!--Loves to talk--></li>
					<li><%= strTextLikesToCombineBusinessWithSoci %><!--Likes to combine business with social situations--></li>
					<li><%= strTextBuildsRapportWithBuyer %><!--Builds rapport with buyer--></li>
					<li><%= strTextPrefersOralPresentations %><!--Prefers oral presentations--></li>
					<li><%= strTextLikesToUseStrongVisualSupport %><!--Likes to use strong visual support--></li>
					<li><%= strTextUsesExamplesToShowHowProblemsW %><!--Uses examples to show how problems were solved--></li>
					<li><%= strTextQuickToPromise %><!--Quick to promise--></li>
					
			</ul>
		</TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextMayBeTooWordy %><!--May be too wordy--></li>
					<li><%= strTextPrefersTheImpromptuToTheWellTh %><!--Prefers the impromptu to the well thought-out--></li>
					<li><%= strTextTendsNotToListenToAndForReacti %><!--Tends not to listen to and for reactions--></li>
					<li><%= strTextMayRelyTooHeavilyOnPersonality %><!--May rely too heavily on personality--></li>
					<li><%= strTextMayDealInGeneralitiesAndPromis %><!--May deal in generalities and promises more than facts--></li>
					<li><%= strTextMayTryTooHardToBeLikedAndThusW %><!--May try too hard to be liked and thus will back off--></li>
					
			</ul>
		</TD>
	</TR>
<!--
page and table break
-->
	<TR>
		<TD style="border-bottom: 1px black solid;"><font size=3><STRONG><%= strTextCommitment %><!--Commitment--></STRONG></TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextProvidesIncentivesToEncourageD %><!--Provides incentives to encourage decisions--></li>
					
			</ul>
		</TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextMayTryquotgimmicksquot %><!--May try &quot;gimmicks&quot;--></li>
					<li><%= strTextMayTalkRightPastTheTimeToClose %><!--May talk right past the time to close, oblivious to buying signals--></li>
					
			</ul>
		</TD>
	</TR>
	<TR>
		<TD style="border-bottom: 1px black solid;"><font size=3><STRONG><%= strTextPartnering %><!--Partnering--></STRONG></TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextStaysInTouchWithBuyers %><!--Stays in touch with buyers--></li>
					<li><%= strTextCommunicatesByPhoneToMaintainP %><!--Communicates by phone to maintain personal contact--></li>
					<li><%= strTextKeepsPaperworkToAMinimum %><!--Keeps paperwork to a minimum--></li>
					
			</ul>
		</TD>
		<TD style="border-bottom: 1px black solid;" VALIGN=TOP>
			<ul class="checkbox">
					<li><%= strTextNotUsuallyGoodAtFollowthrough %><!--Not usually good at follow-through--></li>
					<li><%= strTextMayMakePromisesThatCannotBeKep %><!--May make promises that cannot be kept--></li>
					<li><%= strTextWillBeProneToErrorsOfOmissionA %><!--Will be prone to errors of omission and neglect--></li>
					<li><%= strTextMayAvoidPaperwork %><!--May avoid paperwork--></li>
					
			</ul>
		</td>
	</TR>
</TABLE>

