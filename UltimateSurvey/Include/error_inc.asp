<%
'****************************************************
'
' Name:		Error_inc.asp Server-Side Include
' Purpose:		Provides general functions used for handling of errors
'
' Author:	      Ultimate Software Designs, Inc. 
' Date Written:	  6/3/2002
' Modified:		
'
' Changes:
'****************************************************

'*****************************************************************************************
'Name:		error_displayError()
'
'Purpose:	display an error message in a format that is clear to the user
'
'Inputs:	none
'******************************************************************************************
Function error_displayError()
	Call header_errorPage()

	

%>
	<!--#INCLUDE FILE="Include/footer_inc.asp"-->
<%
	Response.End
End Function
%>


