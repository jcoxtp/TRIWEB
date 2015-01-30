<%@ Language=VBScript %>
<%Option Explicit%>
<!-- #include file="fm.asp" -->
<!-- #include file="fmutil.asp" -->
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="dialog.js"></script>
	</head>
	<body>
		<%
			Call HandleInput()
			
			Sub HandleInput()
				Dim selection, alias, returnvalue
				Dim bConfirmAsked, bConfirmAnswer
				
				selection = unescape(Request.QueryString("selection"))
				alias = unescape(Request.QueryString("alias"))
				returnvalue = unescape(Request.QueryString("returnvalue"))
				
				bConfirmAsked  = ( Len(Request.QueryString("confirm")) > 0 )
				If bConfirmAsked Then 
					bConfirmAnswer = CBool(Request.QueryString("confirm"))
				Else
					bConfirmAnswer = False
				End If
				
				Dim oFM
				Set oFM = New FileManager
				oFM.SetXML(unescape(Session.Value("FMData")))
				
				Dim strResourceDoc, strLanguage
				strLanguage = oFM.GetLanguage()
				strResourceDoc = Server.MapPath( "res/literals" )
				
				Dim IsSaveCommand
				IsSaveCommand = CBool(oFM.GetOptionsAttribute("mode") = "save" Or oFM.GetOptionsAttribute("mode") = "saveas" )
				If ( returnvalue = "ok" And IsSaveCommand ) Then
					If ( Not bConfirmAsked ) Then
						Dim oFS
						Set oFS = Server.CreateObject("Scripting.FileSystemObject")
						If ( oFS.FileExists( oFM.GetDirectoryFromAlias(unescape(alias)) & "\" & selection ) ) Then
							%>
							<script language="javascript">
								var paramSep = this.location.href.indexOf('?')==-1 ? '?' : '&';
								if ( confirm('<%=GetLanguageLiteral( "confirm_save_overwritefile", strResourceDoc, strLanguage )%>') ) {
									this.location.href += paramSep + 'confirm=true';
								}
								else {
									this.location.href += paramSep + 'confirm=false';
								}
							</script>
							<%
							Set oFS = Nothing
							Exit Sub
						End If
					ElseIf ( bConfirmAsked And bConfirmAnswer = False ) Then
						Exit Sub
					End If
				End If
				
				' Change returnvalue
				If Not returnvalue = "" Then
					oFM.SetReturnValue returnvalue
				End If
				
				' Change dirselection attribute based on value of alias
				If Not alias = "" Then
					oFM.SetDirectoriesAttribute "dirselected", alias
				End If
				
				' Change file selection value
				If Not selection = "" Then
					oFM.SetSelection(selection)
				End If
				
				Session.Value("FMData") = escape(oFM.GetXML())
				Set oFM = Nothing
				
				If ( returnvalue = "ok" ) Then
					Response.Write( "<script type=""text/javascript"">closeDialog(unescape('" & escape(alias & "\" & selection) & "'));</script>" )
				ElseIf ( returnvalue = "cancel" ) Then
					Response.Write( "<script type=""text/javascript"">closeDialog('');</script>" )
				End If
			End Sub
		%>
		<form name="action_form" method="post" enctype="multipart/form-data">
			<input type="FILE" size="1" name="File1" ID="File1" />
		</form>
	</body>
</html>
