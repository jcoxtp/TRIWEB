<%
Function EncodeForJavaScript( strInputString )
	EncodeForJavaScript = Replace(Replace( strInputString, "'", "\'"), """", "\""" )
End Function

Function IsLike(strText, match)
	Dim i, str, spec, temp, token, nPos, awildcard, aInputList, aInput

	' Turn strings to lower case
	str = LCase(strText)
	spec = LCase(match)

	aInputList = split(spec, ";")
	IsLike = false
	For Each awildcard In aInputList
		
		' Split the various components of the match string
		aInput = split(awildcard, "*")      ' "c*.*m" becomes Array("c", ".", "m")

		' Walk the array of specification sub-components
		i = 0
		IsLike = true
		For Each token In aInput

			' The first token plays an important role: the file name must begin
			'  with a substring identical to the token.
			If i = 0 Then
				temp = Left(str, Len(token))

				' Don't match...
				If temp <> token Then
					IsLike = False
					Exit for
				End If

				' Removes the leading substring before next step
				str = Right(str, Len(str) - Len(token))
			Else
				temp = str

				' For each asterisk we come accross, we check that what remains of
				' the filename contains the next token of the match string.
				nPos = Instr(1, temp, token)

				' Don't match...
				If nPos = 0 Then
					IsLike = False
					Exit for
				End If

				' Removes the leading substring before next step
				str = Right(str, Len(str) - nPos + 1)
			End If

			i = i + 1
		Next
		if IsLike then
			exit function
		end if
	Next	
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' GetLanguageLiteral()
' 
' Function that finds a literal in the filename 'strLanguageDocName'.
' The documentname should only specify the path and name of the
' language file without any file extension.
' E.g. "C:\MyApp\MyFile"
' Finds the string resource with attribute name='strLiteralName'.
Function GetLanguageLiteral( strLiteralName, strDocumentName, strLanguage )
	Dim strLanguageDocName
	
	If Len(strLanguage) <> 0 Then
		strLanguageDocName = strDocumentName & "." & strLanguage & ".resx"
	Else
		strLanguageDocName = strDocumentName & ".resx"
	End If
	
	Dim xd
	Set xd = CreateObject( "MSXML2.DOMDocument.3.0" )
	xd.async = False
	xd.setProperty "SelectionLanguage", "XPath"
	xd.Load ( strLanguageDocName )
	
	Dim docElem
	Set docElem = xd.documentElement
	
	Dim literalNode
	Set literalNode = docElem.selectSingleNode("//root/data[@name='"+strLiteralName+"']/value")
	
	If literalNode Is Nothing Then
		GetLanguageLiteral = ""
	Else
		GetLanguageLiteral = literalNode.Text
	End If
	
	Set literalNode = Nothing
	Set xd = Nothing
End Function


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' ResourceFileExists()
'
' The function checks if a resource file exists for the given language
' The documentname should only specify the path and name of the
' language file without any file extension.
' E.g. "C:\MyApp\MyFile"
Function ResourceFileExists( strDocumentName, strLanguage )
	ResourceFileExists = False
	
	Dim oFS
	Dim strLanguageDocName
	
	If Len(strLanguage) <> 0 Then
		strLanguageDocName = strDocumentName & "." & strLanguage & ".resx"
	Else
		strLanguageDocName = strDocumentName & ".resx"
	End If
	
	Set oFS = CreateObject("Scripting.FileSystemObject")
	If oFS.FileExists(strLanguageDocName) Then
		ResourceFileExists = True
	End If
	
	Set oFS = Nothing
End Function

'****************************************************************************************************************
' Function : WriteErrorScript()
'
' Render a javascript block, that displayes the text from a resource file.
'
' Input  : 
'	strLiteralName  - Name of resource string to lookup
'   strDocumentName - Name of resource file to use
'   strLanguage     - 3 to 5 letter language-culture specifier
Sub WriteErrorScript( strLiteralName, strDocumentName, strLanguage )
	Dim strErrorMsg
	strErrorMsg = GetLanguageLiteral(strLiteralName, strDocumentName, strLanguage)
	Response.Write( "<script type=""text/javascript"">" )
		Response.Write( "alert('" & strErrorMsg & "');" )
	Response.Write( "</script>" )
End Sub

'****************************************************************************************************************
' Function : SetLCIDByName()
'
' Sets the session locale id to the id specified by the parameter
'
' Input  : 
'   strLanguage     - 3 to 5 letter language-culture specifier
' Return :
'   LCID of current session
Function SetLCIDByName(strLanguage)
	Dim newLCID
	newLCID = 0
	Select Case LCase(strLanguage)
		Case "af"
		newLCID = 1078  ' Afrikaans 
		Case "sq"
		newLCID = 1052  ' Albanian 
		Case "ar-sa"
		newLCID = 1025  ' Arabic(Saudi Arabia) 
		Case "ar-iq"
		newLCID = 2049  ' Arabic(Iraq) 
		Case "ar-eg"
		newLCID = 3073  ' Arabic(Egypt) 
		Case "ar-ly"
		newLCID = 4097  ' Arabic(Libya) 
		Case "ar-dz"
		newLCID = 5121  ' Arabic(Algeria) 
		Case "ar-ma"
		newLCID = 6145  ' Arabic(Morocco) 
		Case "ar-tn"
		newLCID = 7169  ' Arabic(Tunisia) 
		Case "ar-om"
		newLCID = 8193  ' Arabic(Oman) 
		Case "ar-ye"
		newLCID = 9217  ' Arabic(Yemen) 
		Case "ar-sy"
		newLCID = 10241 ' Arabic(Syria) 
		Case "ar-jo"
		newLCID = 11265 ' Arabic(Jordan) 
		Case "ar-lb"
		newLCID = 12289 ' Arabic(Lebanon) 
		Case "ar-kw"
		newLCID = 13313 ' Arabic(Kuwait) 
		Case "ar-ae"
		newLCID = 14337 ' Arabic(U.A.E.) 
		Case "ar-bh"
		newLCID = 15361 ' Arabic(Bahrain) 
		Case "ar-qa"
		newLCID = 16385 ' Arabic(Qatar) 
		Case "eu"
		newLCID = 1069  ' Basque 
		Case "bg"
		newLCID = 1026  ' Bulgarian 
		Case "be"
		newLCID = 1059  ' Belarusian 
		Case "ca"
		newLCID = 1027  ' Catalan 
		Case "zh-tw"
		newLCID = 1028  ' Chinese(Taiwan) 
		Case "zh-cn"
		newLCID = 2052  ' Chinese(PRC) 
		Case "zh-hk"
		newLCID = 3076  ' Chinese(Hong Kong) 
		Case "zh-sg"
		newLCID = 4100  ' Chinese(Singapore) 
		Case "hr"
		newLCID = 1050  ' Croatian 
		Case "cs"
		newLCID = 1029  ' Czech 
		Case "da"
		newLCID = 1030  ' Danish 
		Case "n"
		newLCID = 1043  ' Dutch(Standard) 
		Case "nl-be"
		newLCID = 2067  ' Dutch(Belgian) 
		Case "en"
		newLCID = 9     ' English 
		Case "en-us"
		newLCID = 1033  ' English(United States) 
		Case "en-gb"
		newLCID = 2057  ' English(British) 
		Case "en-au"
		newLCID = 3081  ' English(Australian) 
		Case "en-ca"
		newLCID = 4105  ' English(Canadian) 
		Case "en-nz"
		newLCID = 5129  ' English(New Zealand) 
		Case "en-ie"
		newLCID = 6153  ' English(Ireland) 
		Case "en-za"
		newLCID = 7177  ' English(South Africa) 
		Case "en-jm"
		newLCID = 8201  ' English(Jamaica) 
		Case "en"
		newLCID = 9225  ' English(Caribbean) 
		Case "en-bz"
		newLCID = 10249 ' English(Belize) 
		Case "en-tt"
		newLCID = 11273 ' English(Trinidad) 
		Case "et"
		newLCID = 1061  ' Estonian 
		Case "fo"
		newLCID = 1080  ' Faeroese 
		Case "fa"
		newLCID = 1065  ' Farsi 
		Case "fi"
		newLCID = 1035  ' Finnish 
		Case "fr"
		newLCID = 1036  ' French(Standard) 
		Case "fr-be"
		newLCID = 2060  ' French(Belgian) 
		Case "fr-ca"
		newLCID = 3084  ' French(Canadian) 
		Case "fr-ch"
		newLCID = 4108  ' French(Swiss) 
		Case "fr-lu"
		newLCID = 5132  ' French(Luxembourg) 
		Case "mk"
		newLCID = 1071  ' FYRO Macedonian 
		Case "gd"
		newLCID = 1084  ' Gaelic(Scots) 
		Case "gd-ie"
		newLCID = 2108  ' Gaelic(Irish) 
		Case "de"
		newLCID = 1031  ' German(Standard) 
		Case "de-ch"
		newLCID = 2055  ' German(Swiss) 
		Case "de-at"
		newLCID = 3079  ' German(Austrian) 
		Case "de-lu"
		newLCID = 4103  ' German(Luxembourg) 
		Case "de-li"
		newLCID = 5127  ' German(Liechtenstein) 
		Case "e"
		newLCID = 1032  ' Greek 
		Case "he"
		newLCID = 1037  ' Hebrew 
		Case "hi"
		newLCID = 1081  ' Hindi 
		Case "hu"
		newLCID = 1038  ' Hungarian 
		Case "is"
		newLCID = 1039  ' Icelandic 
		Case "in"
		newLCID = 1057  ' Indonesian 
		Case "it"
		newLCID = 1040  ' Italian(Standard) 
		Case "it-ch"
		newLCID = 2064  ' Italian(Swiss) 
		Case "ja"
		newLCID = 1041  ' Japanese 
		Case "ko"
		newLCID = 1042  ' Korean 
		Case "ko"
		newLCID = 2066  ' Korean(Johab) 
		Case "lv"
		newLCID = 1062  ' Latvian 
		Case "lt"
		newLCID = 1063  ' Lithuanian 
		Case "ms"
		newLCID = 1086  ' Malaysian 
		Case "mt"
		newLCID = 1082  ' Maltese 
		Case "no"
		newLCID = 1044  ' Norwegian(Bokmal) 
		Case "no"
		newLCID = 2068  ' Norwegian(Nynorsk) 
		Case "p"
		newLCID = 1045  ' Polish 
		Case "pt-br"
		newLCID = 1046  ' Portuguese(Brazil) 
		Case "pt"
		newLCID = 2070  ' Portuguese(Portugal) 
		Case "rm"
		newLCID = 1047  ' Rhaeto-Romanic 
		Case "ro"
		newLCID = 1048  ' Romanian 
		Case "ro-mo"
		newLCID = 2072  ' Romanian(Moldavia) 
		Case "ru"
		newLCID = 1049  ' Russian 
		Case "ru-mo"
		newLCID = 2073  ' Russian(Moldavia) 
		Case "sz"
		newLCID = 1083  ' Sami(Lappish) 
		Case "sr"
		newLCID = 3098  ' Serbian(Cyrillic) 
		Case "sr"
		newLCID = 2074  ' Serbian(Latin) 
		Case "sk"
		newLCID = 1051  ' Slovak 
		Case "s"
		newLCID = 1060  ' Slovenian 
		Case "sb"
		newLCID = 1070  ' Sorbian 
		Case "es"
		newLCID = 1034  ' Spanish(Spain - Traditional Sort) 
		Case "es-mx"
		newLCID = 2058  ' Spanish(Mexican) 
		Case "es"
		newLCID = 3082  ' Spanish(Spain - Modern Sort) 
		Case "es-gt"
		newLCID = 4106  ' Spanish(Guatemala) 
		Case "es-cr"
		newLCID = 5130  ' Spanish(Costa Rica) 
		Case "es-pa"
		newLCID = 6154  ' Spanish(Panama) 
		Case "es-do"
		newLCID = 7178  ' Spanish(Dominican Republic) 
		Case "es-ve"
		newLCID = 8202  ' Spanish(Venezuela) 
		Case "es-co"
		newLCID = 9226  ' Spanish(Colombia) 
		Case "es-pe"
		newLCID = 10250 ' Spanish(Peru) 
		Case "es-ar"
		newLCID = 11274 ' Spanish(Argentina) 
		Case "es-ec"
		newLCID = 12298 ' Spanish(Ecuador) 
		Case "es-c"
		newLCID = 13322 ' Spanish(Chile) 
		Case "es-uy"
		newLCID = 14346 ' Spanish(Uruguay) 
		Case "es-py"
		newLCID = 15370 ' Spanish(Paraguay) 
		Case "es-bo"
		newLCID = 16394 ' Spanish(Bolivia) 
		Case "es-sv"
		newLCID = 17418 ' Spanish(El Salvador) 
		Case "es-hn"
		newLCID = 18442 ' Spanish(Honduras) 
		Case "es-ni"
		newLCID = 19466 ' Spanish(Nicaragua) 
		Case "es-pr"
		newLCID = 20490 ' Spanish(Puerto Rico) 
		Case "sx"
		newLCID = 1072  ' Sutu 
		Case "sv"
		newLCID = 1053  ' Swedish 
		Case "sv-fi"
		newLCID = 2077  ' Swedish(Finland) 
		Case "th"
		newLCID = 1054  ' Thai 
		Case "ts"
		newLCID = 1073  ' Tsonga 
		Case "tn"
		newLCID = 1074  ' Tswana 
		Case "tr"
		newLCID = 1055  ' Turkish 
		Case "uk"
		newLCID = 1058  ' Ukrainian 
		Case "ur"
		newLCID = 1056  ' Urdu 
		Case "ve"
		newLCID = 1075  ' Venda 
		Case "vi"
		newLCID = 1066  ' Vietnamese 
		Case "xh"
		newLCID = 1076  ' Xhosa 
		Case "ji"
		newLCID = 1085  ' Yiddish 
		Case "zu"
		newLCID = 1077  ' Zulu 
		Case Else
		newLCID = 2048  ' default
	End Select 
	
	SetLCIDByName = Session.LCID	' Return previous LCID
	If newLCID <> 0 Then Session.LCID = newLCID
End Function

Function SetLCID(newLCID)
	SetLCID = Session.LCID	' Return previous LCID
	If newLCID <> 0 Then Session.LCID = newLCID
End Function
%>
