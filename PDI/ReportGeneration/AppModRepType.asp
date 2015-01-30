<%
	Response.Write "<h2><i>" & strTextOverviewOfYourPrimaryBehavioralCharacteristic & "</i></h2>" & VbCrLf
	Response.Write "<hr>" & VbCrLf
If UCase(HighType1) = "D" Then
	Response.Write "	<!-- <p class=""aligncenter""><img src=""images/pdi_overview_d.gif"" alt="""" width=""480"" height=""287"" /></p> -->" & VbCrLf
	Response.Write "	<br>" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><span class=""headertext2"">" & strTextDominant & " (""D"")" & "</span></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right"" width=""35%""><strong>" & strTextOtherTerms & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"" width=""65%"">" & strTextDriverDirector & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextEmphasis & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextControllingTheEnvironmentByOvercoming & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextKeyToMotivation & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextChallenge & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextBasicIntent & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextToOvercome & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextGreatestFear & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextLossOfControl & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><img src=""images/dominance.gif"" alt="""" width=""370"" height=""213"" /></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "<br>" & strUser2Name & ", " & strTextAsAHighDYouAreActiveAndTaskOriented & VbCrLf
	Response.Write "<br><br>" & strTextYouWillFightHardForWhatYouThink & VbCrLf
	Response.Write "<br><br>" & strTextDsThriveOnCompetitionToughAssignments & VbCrLf
	Response.Write "<br><br>" & strTextYouAreARealIndividualistAndVery & VbCrLf
ElseIf UCase(HighType1) = "I" Then
	Response.Write "	<!-- <p class=""aligncenter""><img src=""images/pdi_overview_i.gif"" alt="""" width=""480"" height=""287"" /></p> -->" & VbCrLf
	Response.Write "<br><br>" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><span class=""headertext2"">" & strTextInfluential & " (""I"")" & "</span></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right"" width=""35%""><strong>" & strTextOtherTerms & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"" width=""65%"">" & strTextExpressive & ", " & strTextPersuader & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextEmphasis & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextCreatingTheEnvironmentByMotivatingAnd & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextKeyToMotivation & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextRecognition & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextBasicIntent & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextToPersuade & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextGreatestFear & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextLackOfRecognitionAndAdmiration & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><img src=""images/influence.gif"" alt="""" width=""331"" height=""209"" /></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "<br>" & strUser2Name & ", " & strTextAsAHighIYouAreActiveAnd & VbCrLf
	Response.Write "<br><br>" & strTextIsAreOftenEffectiveMotivatorsUsing & VbCrLf
	Response.Write "<br><br>" & strTextYourBasicInterestIsPeopleWhether & VbCrLf
ElseIf UCase(HighType1) = "S" Then
	Response.Write "	<!-- <p class=""aligncenter""><img src=""images/pdi_overview_s.gif"" alt="""" width=""480"" height=""287"" /></p> -->" & VbCrLf
	Response.Write "	<br><br>" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><span class=""headertext2"">" & strTextSteady & " (""S"")</span></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right"" width=""35%""><strong>" & strTextOtherTerms & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"" width=""65%"">" & strTextAmicable & ", " & strTextSupporter & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextEmphasis & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextMaintainingTheEnvironmentToCarryOut & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextKeyToMotivation & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextAppreciation & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextBasicIntent & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextToSupport & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextGreatestFear & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextConflictDamageToRelationships & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><img src=""images/steadiness.gif"" alt="""" width=""344"" height=""200"" /></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "<br>" & strUser2Name & ", " & strTextAsAHighSYouAreResponsiveAndRelationship & VbCrLf
	Response.Write "<br><br>" & strTextYouAreUsuallyAmiableEasyGoing & VbCrLf
	Response.Write "<br><br>" & strTextUsuallySPeopleAreEvenTemperedLowKey & VbCrLf
	Response.Write "<br><br>" & strTextSPeopleDislikeChangeOnce & VbCrLf
ElseIf UCase(HighType1) = "C" Then
	Response.Write "	<!-- <p class=""aligncenter""><img src=""images/pdi_overview_c.gif"" alt="""" width=""480"" height=""287"" /></p> -->" & VbCrLf
	Response.Write "	<br><br>" & VbCrLf
	Response.Write "	<table class=""addtable"" border=""0"" cellspacing=""0"" cellpadding=""6"" width=""100%"">" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><span class=""headertext2"">" & strTextConscientious & "(""C"")</span></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right"" width=""35%""><strong>" & strTextOtherTerms & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"" width=""65%"">" & strTextCautious & ", " & strTextAnalytical & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextEmphasis & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextStructuringTheEnvironmentToProduce & VbCrLf
	Response.Write "			</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextKeyToMotivation & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextProtectionSecurity & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextBasicIntent & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextToBeCorrect & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""right""><strong>" & strTextGreatestFear & ":</strong></td>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""left"">" & strTextBeingWrongMakingAMistake & "</td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "		<tr>" & VbCrLf
	Response.Write "			<td valign=""top"" align=""center"" colspan=""2""><img src=""images/conscientiousness.gif"" alt="""" width=""372"" height=""187"" /></td>" & VbCrLf
	Response.Write "		</tr>" & VbCrLf
	Response.Write "	</table>" & VbCrLf
	Response.Write "	<br>" & strUser2Name & ", " & strTextAsAHighCYouAreResponsiveAndTask & VbCrLf
	Response.Write "<br><br>" & strTextCsArePreciseAndAttentiveTodetail & VbCrLf
	Response.Write "<br><br>" & strTextNaturallyCautiousYouPreferToWaitAnd & VbCrLf
Else
	Response.Write "	<br><br>" & strTextOurDatabaseDoesNotContainAValid & VbCrLf
End If
%>
