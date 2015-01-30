<%
'****************************************************
'
' Name:		categories_inc.asp Server-Side Include
' Purpose:		Provides functions relating to Categories in general
'
' Author:	      Ultimate Software Designs
' Date Written:	2/13/2003
' Modified:		
' Changes:
'****************************************************
Function categories_getParentCategory(intCategoryID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT parentCategoryID FROM usd_itemCategories WHERE " &_
					 "categoryID = " & intCategoryID  
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		categories_getParentCategory = rsResults("parentCategoryID")
	End If
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function categories_getNumberItems(intCategoryID)
	Dim strSQL
	Dim rsResults
	
	strSQL = "SELECT categoryID FROM usd_itemCategoryMap WHERE categoryID = " & intCategoryID
	
	Set rsResults = Server.CreateObject("ADODB.Recordset")
	rsResults.CursorLocation = adUseClient
	rsResults.Open utility_ConvertSQL(strSQL), DB_CONNECTION
	categories_getNumberItems = rsResults.RecordCount
	rsResults.Close
	Set rsResults = NOTHING
End Function

Function categories_deleteInvalidItems()
	Dim strSQL
	

	strSQL = "DELETE FROM usd_surveyItem WHERE surveyID = 0 " &_
			 "AND itemID NOT IN (SELECT itemID FROM usd_itemCategoryMap)"
	Call utility_executeCommand(strSQL)
	
	strSQL = "DELETE FROM usd_itemCategoryMap WHERE itemID NOT IN (SELECT itemID FROM usd_surveyItem)"
	Call utility_executeCommand(strSQL)

End Function
%>


