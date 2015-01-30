<%

	'=============================================
	' Convert a boolean value to presentable text
	'=============================================
	function FmtBool(val,tru,fal)
		If IsNull(val) Then
			FmtBool = "&nbsp;"
		Else
			If cint(val) Then
				FmtBool = tru
			Else
				FmtBool = fal		
			End If
		End If
	end function

	'=============================================
	' Join a City/State/Zip combination w/o messing up the commas
	'=============================================
	function FmtLocation(city,st,zip)
		FmtLocation = ""
		If Not (city = "") Then
			FmtLocation = FmtLocation & city
		End If
		If Not (st = "") Then
			If FmtLocation = "" Then
				FmtLocation = st
			Else
				FmtLocation = FmtLocation & ", " & st
			End If
		End If
		If Not (zip = "") Then
			If FmtLocation = "" Then
				FmtLocation =  zip
			Else
				FmtLocation = FmtLocation & " " & zip
			End If
		End If
	end function
	
	'=============================================
	' Return the date only when given a date time value
	'=============================================
	function FmtGetDate(myDateTime)
		If IsDate(myDateTime) then
			FmtGetDate = Month(myDateTime) & "/" & Day(myDateTime) & "/" & Year(myDateTime)
		Else
			FmtGetDate = myDateTime
		End If
	end function

	'=============================================
	' Return the datepart you want when given a datetime value
	'=============================================
	function FmtGetDatePart(myDateTime,myDatePart)
		dim DispHr
		Select Case myDatePart
			Case "hour"
				DispHr = myDateTime
				If cint(DispHr) > 11 Then
					DispHr = cint(DispHr) - 12
					If DispHr = 0 then DispHr = 12
					FmtGetDatePart = DispHr & ":00 - " & DispHr & ":59 PM"
				Else 
					If DispHr = 0 then DispHr = 12
					FmtGetDatePart = DispHr & ":00 - " & DispHr & ":59 AM"
				End If
			Case "day"
				FmtGetDatePart = myDateTime
			Case "weekday"
				FmtGetDatePart = WeekdayName(myDateTime)
			Case "month"
				FmtGetDatePart = MonthName(myDateTime)
			Case "year"
				FmtGetDatePart = myDateTime
			Case "quarter"
				FmtGetDatePart = "Q" & myDateTime
			Case Else
				FmtGetDatePart = "&nbsp;"
		End Select
	end function

	'=============================================
	' Determine if a given item should be marked as "selected" in html
	'	checkval= the element value particular to the line in question
	'	inputvar= the incoming value, usually will come from the Request object
	'=============================================
	function CheckSelected(checkval,inputvar)
		if checkval = inputvar then
			CheckSelected = "selected"
		else
			CheckSelected = ""
		end if 
	end function

	'=============================================
	' Determine if a given item should be marked as "checked" in html
	'	checkval= the element value particular to the line in question
	'	inputvar= the incoming value, usually will come from the Request object
	'=============================================
	function CheckChecked(checkval,inputvar)
		if checkval = inputvar then
			CheckChecked = "checked"
		else
			CheckChecked = ""
		end if 
	end function

	'=============================================
	' Determine if a given item should be marked as "selected" in html
	'	checkval= the element value particular to the line in question
	'	inputvar= the incoming csv, usually will come from the Request object
	'=============================================
	function CheckSelectedCSV(checkval, ByVal inputcsv)
		dim pos
		inputcsv = "," & inputcsv & "," 'pad the incoming csv with commas
		checkval = "," & checkval & "," 'pad the check value with commas
		if InStr(1,inputcsv,checkval,1) > 0 then
			CheckSelectedCSV = "selected"
		else
			CheckSelectedCSV = ""
		end if 
	end function




%>
	