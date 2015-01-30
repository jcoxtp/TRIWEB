
Function ShowYesNoQuestion(Prompt, Title)
	If MsgBox(Prompt, vbYesNo+vbQuestion, Title) = vbYes Then
		ShowYesNoQuestion = True
	Else
		ShowYesNoQuestion = False
	End If
End Function


Sub ShowInformationMessage(Prompt, Title)
	Call MsgBox(Prompt, vbOKOnly+vbInformation, Title)
End Sub

Sub ShowWarningMessage(Prompt, Title)
	Call MsgBox(Prompt, vbOKOnly+vbExclamation, Title)
End Sub

Sub ShowErrorMessage(Prompt, Title)
	Call MsgBox(Prompt, vbOKOnly+vbCritical, Title)
End Sub

