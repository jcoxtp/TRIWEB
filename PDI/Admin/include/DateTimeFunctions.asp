<%
	' does what it says...
	function getDaysInMonth(strMonth,strYear)
	dim strDays	 
		Select Case cint(strMonth)
			Case 1,3,5,7,8,10,12:
				strDays = 31
			Case 4,6,9,11:
				strDays = 30
			Case 2:
				if ((cint(strYear) mod 4 = 0 and cint(strYear) mod 100 <> 0) or (cint(strYear) mod 400 = 0)) then
					strDays = 29
				else
					strDays = 28 
				end if	
		End Select 
		getDaysInMonth = strDays
	end function
	
	' returns now in yyyy-mm-dd
	function getToday()
		getToday = year(Now())
		If Len(month(Now())) > 1 then
			getToday = getToday & "-" & month(Now())
		Else
			getToday = getToday & "-0" & month(Now())
		End If
		If Len(day(Now())) > 1 then
			getToday = getToday & "-" & day(Now())
		Else
			getToday = getToday & "-0" & day(Now())
		End If
	end function
	
	
%>
