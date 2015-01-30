<%
'****************************************************
'
' Name:		common_ui_inc.asp 
' Purpose:	common user interface functions
'
'
' Author:	    Ultimate Software Designs
' Date Written:	6/28/2002
'
' Dependencies:	
'				
'
' Modified:		
'
' Changes:
'****************************************************

'***********************************************************************
'Name:		common_helpLink(strPageName)
'
'Purpose:	create link to help section
'
'Inputs:	strPageName - name of page in help section to show first
'			strImageLocation - location of help image
'***********************************************************************
Function common_helpLink(strDoc, strImageLocation)
	Dim intUserType

	'Get the user info out of the session or cookie
	Call user_getSessionInfo("", intUserType, "","", "",False)

	'popup(URL,name,toolbar,scrollbars,location,statusbar,menubar,resizable,width,height,left,top)
%>
	<a href="javascript:popup('helpIndex.asp?doc=<%=strDoc%>&userType=<%=intUserType%>','help','0','0','0','0','0','0','700','700','150','150')">
		<img src="<%=strImageLocation%>" alt="Help" border="0" hspace="2" /></a>

<%
End Function

Function common_helpLinkText(strDoc, strTitle)
	'popup(URL,name,toolbar,scrollbars,location,statusbar,menubar,resizable,width,height,left,top)
%><a href="javascript:popup('helpIndex.asp?doc=<%=strDoc%>&userType=<%=intUserType%>','help','0','0','0','0','0','0','700','700','150','150')"><%=StrTitle%></a><%
End Function

'***********************************************************************
'Name:		common_tableRow(intCounter)
'
'Purpose:	create a table row with alternating background color
'
'Inputs:	intCounter - number to determine what color table row background is
'
'***********************************************************************
Function common_tableRow(intCounter)
	If intCounter mod 2 = 0 Then
%>
		<tr class="oddRows" bgcolor="#FFFFFF">
<%	
	Else
%>
		<tr class="evenRows" bgcolor="#EEEEEE">
<%
	End If
End Function

'***********************************************************************
'Name:		common_requiredFlag()
'
'Purpose:	create indication to show that a field is required
'
'Inputs:	none
'
'***********************************************************************
Function common_requiredFlag()
%>
	<span class="requiredFlag">*</span>
<%
End Function

'***********************************************************************
'Name:		common_backLink()
'
'Purpose:	create javascript link to go back 1 in the browser history
'
'Inputs:	none
'
'***********************************************************************
Function common_backLink()
%>
	<a href="javascript:history.go(-1);">
		<img src="images/goback.gif" alt="Go Back" height="15" width="80" border="0" hspace="2"></a>
<%
End Function

'***********************************************************************
'Name:		common_dateSelect(strHTMLName, dtmDefaultDate, dtmStartYear, intNumberYears)
'
'Purpose:	create a set of selects to allow user to select a date
'
'Inputs:	strHTMLName - name of the selects in the html form
'			dtmDefaultDate - date to default selects to (optional)	
'			dtmStartYear - first year in dropdown
'			intNumberYears - number of years in dropdown
'
'***********************************************************************
Function common_dateSelect(strHTMLName, dtmDefaultDate, dtmStartYear, intNumberYears)
	Dim intMonth
	Dim intDay
	Dim intYear
	Dim intYearCounter
	Dim intMonthCounter
	Dim intDayCounter
	Dim intLastYear
	Dim intDefaultYear
	
	If isDate(dtmDefaultDate) Then
		intMonth = datePart("m",dtmDefaultDate)
		intDay = datePart("d",dtmDefaultDate)
		intYear = datePart("yyyy",dtmDefaultDate)
	ElseIf len(trim(dtmDefaultDate)) <> 0 and len(trim(intMonth)) <> 0 and len(trim(intDay)) <> 0 and len(trim(intYear)) <> 0 Then
		dtmDefaultDate = Cdate(dtmDefaultDate)
	Else
		intMonth = 0
		intDay = 0
		intYear = 0
	End If
	
	If isDate(dtmDefaultDate) Then
		intDefaultYear = datepart("yyyy",dtmDefaultDate)
	End If
	If utility_isPositiveInteger(intDefaultYear) Then
		intDefaultYear = cint(intDefaultYear)
	Else
		intDefaultYear = 0
	End If
	
	intMonthCounter = 1
	intDayCounter = 1
	intYearCounter = dtmStartYear
	intLastYear = dtmStartYear + intNumberYears - 1
%>
	<select name="<%=strHTMLName%>Month">
		<option></option>
<%
		Do until intMonthCounter > 12
%>
			<option value="<%=intMonthCounter%>"
<%
			If intMonthCounter = intMonth Then
%>
				selected
<%
			End If
%>
			>
				<%=utility_getMonthText(intMonthCounter)%>
			</option>
<%
			intMonthCounter = intMonthCounter + 1
		Loop
%>
	</select>
	<select name="<%=strHTMLName%>Day">
		<option></option>
<%
		Do until intDayCounter > 31
%>
			<option value="<%=intDayCounter%>"
<%
			If intDayCounter = intDay Then
%>
				selected
<%
			End If
%>
			>
				<%=intDayCounter%>
			</option>
<%
			intDayCounter = intDayCounter + 1
		Loop
%>		
	</select>
	<select name="<%=strHTMLName%>Year">
		<option></option>
<%
		Do until intYearCounter > intLastYear and intYearCounter > intDefaultYear
%>
			<option value="<%=intYearCounter%>"
<%		
			If intYearCounter = intYear Then
%>
				selected
<%
			End If
%>
		
			><%=intYearCounter%></option>
<%
			intYearCounter = intYearCounter + 1
		Loop
%>
	</select>
<%
End Function

'***********************************************************************
'Name:		common_itemTypeDescription
'
'Purpose:	display description of an item type
'
'Inputs:	intItemTypeID - unique ID of item type
'***********************************************************************
Function common_itemTypeDescription(intItemTypeID)
	Dim strSQL
	Dim rsResults
	Dim strText
	Dim strDescription
	strSQL = "SELECT itemTypeText, description " &_
			 "FROM usd_itemTypes " &_
			 "WHERE itemTypeID = " & intItemTypeID
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		strText = rsResults("itemTypeText")
		strDescription = rsResults("description")
%>
		<span class="normalBold">
			<%=strText%>:
		</span>
		<span class="normal">
			<%=strDescription%>
		</span>
<%
	End If
	rsResults.Close
	Set rsResults = NOTHING
		
End Function

'***********************************************************************
'Name:		common_allTypeDescriptions
'
'Purpose:	display descriptions for each item type
'
'Inputs:	NONE
'***********************************************************************
Function common_allTypeDescriptions()
	Dim strSQL
	Dim rsResults
	Dim strText
	Dim strDescription
	strSQL = "SELECT itemTypeText, description " &_
			 "FROM usd_itemTypes " &_
			 "ORDER BY orderByID "
	Set rsResults = utility_getRecordset(strSQL)
	If not rsResults.EOF Then
		Do until rsResults.EOF
			strText = rsResults("itemTypeText")
			strDescription = rsResults("description")
%>
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td width="200" class="normalBold-Big" valign="top">
						<%=strText%>
					</td>
					<td class="normal" valign="top">
						<%=strDescription%>
					</td>
				</tr>
			</table>
			<hr noshade color="#C0C0C0" size="2">
<%
			rsResults.MoveNext
		Loop

	End If
	rsResults.Close
	Set rsResults = NOTHING
		
End Function

Function common_categoryBreadCrumb(intCategoryID, strURL)
	Dim rsResults
	Dim strTreeSQL
	Dim intCurrentCategory
	Dim boolEnd
	Dim strCategories
	Dim strSQL
	Dim boolShown
	Dim strCategoryName
	
	intCurrentCategory = intCategoryID
	boolEnd = False
	Set rsResults = server.CreateObject("ADODB.Recordset")
	
	Do until boolEnd = True
		strTreeSQL = "SELECT categoryName, parentCategoryID " &_
				 "FROM usd_itemCategories " &_
				 "WHERE categoryID = " & intCurrentCategory
		rsResults.Open strTreeSQL, DB_CONNECTION
		If not rsResults.EOF Then
			strCategoryName = rsResults("categoryName")
			If boolShown = True Then
				strCategories = "<a href=""" & strURL & "?categoryID=" & intCurrentCategory &_
									""">" & strCategoryName & "</a> >> " & strCategories
			Else
				strCategories = "<a href=""" & strURL & "?categoryID=" & intCurrentCategory &_
									""">" & strCategoryName & "</a> " & strCategories
				boolShown = True
			End If
			intCurrentCategory = rsResults("parentCategoryID")
			If not utility_isPositiveInteger(intCurrentCategory) Then
				boolEnd = True
			End If
		Else
			boolEnd = True
		End If		
		rsResults.Close
			
	Loop
		
	Set rsResults = NOTHING
	Response.Write strCategories
End Function

Function common_basicTableTag()
%>
	<table border="1" cellpadding="2" bordercolor="#CCCCCC" cellspacing="0" width="100%" ID="Table1">
<%
End Function

Function common_basicTableHeaderRow()
%>
	<tr bgcolor="black" class="tableHeader">
<%
End Function

Function common_orderByLinks(strText, strOrderBy, strOrderByDirection, strURL, strOrderByString)
	If (strOrderByDirection = "ASC" or strOrderByDirection = "" or strOrderByDirection = "asc") and strOrderBy = strOrderByString Then
%>	
		<a href="<%=strURL%>&orderBy=<%=strOrderByString%>&orderByDirection=DESC"><%=strText%></a>
		
<%
	Else
%>	
	<a href="<%=strURL%>&orderBy=<%=strOrderByString%>&orderByDirection=ASC"><%=strText%></a>
<%
	End If

	If strOrderBy = strOrderByString Then
		If (strOrderByDirection = "ASC" or strOrderByDirection = "" or strOrderByDirection = "asc") Then
%>
		<img src="images/ascOn.gif" border="0" alt="Sorted Ascending">
<%
		Else
%>
		<img src="images/descOn.gif" border="0" alt="Sorted Descending">
<%
		End If

		Else
%>
		&nbsp;
<%

	End If
End Function

Function common_checkAllLink(strArrayName,strFieldName)
%>
<input type="checkbox" name="abcd" onclick="javascript:checkAll(<%=strArrayName%>, <%=strFieldName%>);" >
<%
End Function
%>

