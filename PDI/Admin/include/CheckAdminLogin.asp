<%
	'== Validate the User ===========
	' this runs all the time - make sure they are even logged in...
	if Request.Cookies("login") <> "1" then 
		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	end if

	'== Authorize the User =============
	' this function receives an input and returns True/False if the current user's rights 
	' are equal to or greater than the input - MG 2/27/04 - 
	' Note: I know that using the UserTypeID for this task is not the best method but this
	' function is an incremental step toward doing things the right way... :-)
	'	
	'== USER TYPES as of 2/27/2004 ================================
	'UserTypeID		UserType						Description
	'==========		====================		========================
	'	1				Webuser						Normal web user
	'	2				ResellerL1					Reseller Level 1
	'	3				CorpL1						Corporate Level 1
	'	4				Administrative User		Administrative User
	'==============================================================
	function IsAuthorized(level)
		IsAuthorized = False
		Dim UserLevel : UserLevel = Request.Cookies("UserTypeID")
		If cint(UserLevel) >= cint(level) Then
			IsAuthorized = True
		End If
	end function
	'Example usage =====================================
	'	If Not IsAuthorized(4) Then 
	'		Response.Redirect("/pdi/login.asp?res=" & intResellerID)
	'	End If
	'===================================================
	
	
%>