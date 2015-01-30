<%
'***********************************************************************************************
'
' Name:		Constants_inc.asp Server-Side Include
' Purpose:		Provides all the constants used in the application
'
' Author:	      Ultimate Software Designs
' Date Written:	6/18/2002
'***********************************************************************************************
	Const SV_FLASH_GRAPHS = True
	
	
	Dim strConstantsSQL
	Dim rsConstants
	strConstantsSQL = "SELECT topColor, menuColor, titleColor, siteName, rootPath, uploadedImageFolder, uploadedImageURL, " &_
			 "indexPageHeader, indexPageText, emailObjectType, emailCDONTS, emailASPMail, emailJMail, smtpMailHost, mainEmail, " &_
			 "emailFromAddress, inviteUsersCheckboxes, defaultUserType, allowPublicRegistration, nonLoggedInNavLinks, " &_
			 "sessionTimeout, resultsPerPage, emailRequired, dropdownDefault, defaultReportType, customUserField1, customUserField2, customUserField3, securityType, " &_
			 "preventConcurrentLogin, cookieName " &_
			 "FROM usd_surveySettings"

	'Set rsConstants = server.CreateObject("ADODB.Recordset")
	
	Set rsConstants = utility_getRecordset(strConstantsSQL)
	
	
	'Constants for colors
	Dim SV_TOP_COLOR
	Dim SV_MENU_COLOR
	Dim SV_TITLE_COLOR
	SV_TOP_COLOR = rsConstants("topColor")
	SV_MENU_COLOR = rsConstants("menuColor")
	SV_TITLE_COLOR = rsConstants("titleColor")
	
	'Constants for URLs and paths
	Dim SV_SITENAME
	Dim SV_ROOT_PATH
	Dim SV_UPLOADED_IMAGE_FOLDER
	Dim SV_UPLOADED_IMAGE_URL
	SV_SITENAME = rsConstants("siteName")  'Used in header and HTML Title, and emails sent to users
	'path to the root directory of survey application
	SV_ROOT_PATH = rsConstants("rootPath")
	'system path of folder to upload images to
	SV_UPLOADED_IMAGE_FOLDER = rsConstants("uploadedImageFolder")
	'URL path of folder to upload images to
	SV_UPLOADED_IMAGE_URL = rsConstants("uploadedImageURL")
	
	'Constants for text on index page
	Dim SV_INDEX_PAGE_HEADER
	Dim SV_INDEX_PAGE_TEXT
	SV_INDEX_PAGE_HEADER = rsConstants("indexPageHeader")
	SV_INDEX_PAGE_TEXT = rsConstants("indexPageText")

	
	'Constants to set up email	
	Const SV_EMAIL_NO_EMAIL	= 0
	Const SV_EMAIL_CDONTS	= 1
	Const SV_EMAIL_CDOSYS	= 2
	Const SV_EMAIL_ASPMAIL	= 3
	Const SV_EMAIL_JMAIL	= 4
	
	Dim SV_EMAIL_OBJECT_TYPE
	Dim SV_SMTPMAIL_HOST
	Dim SV_MAIN_EMAIL
	Dim SV_EMAIL_FROM_ADDRESS
	
	SV_EMAIL_OBJECT_TYPE = cint(rsConstants("emailObjectType"))
	
	SV_SMTPMAIL_HOST = rsConstants("smtpMailHost")
	SV_MAIN_EMAIL = rsConstants("mainEmail")
	SV_EMAIL_FROM_ADDRESS = rsConstants("emailFromAddress")
	
	'whether or not to show checbox for each current user when inviting users to take a survey.
	'If you have over 100 users, this should definitely be set to false, for usability.
	Dim SV_INVITE_USER_CHECKBOXES
	SV_INVITE_USER_CHECKBOXES = cbool(rsConstants("inviteUsersCheckboxes"))

	'default user type when a user registers
	'3 = take surveys only
	'2 = take and create surveys
	'1 = administrator (not suggested)
	Dim SV_DEFAULT_USER_TYPE
	SV_DEFAULT_USER_TYPE = rsConstants("defaultUserType")
	
	'Decide to allow open registration.  Setting this to true means that anyone with access to the main URL
	'of your survey application can register to be a user
	Dim SV_ALLOW_PUBLIC_REGISTRATION 
	SV_ALLOW_PUBLIC_REGISTRATION = cbool(rsConstants("allowPublicRegistration"))
		
	'Decide whether links are shown to non-logged in users
	Dim SV_NON_LOGGED_IN_NAV_LINKS
	SV_NON_LOGGED_IN_NAV_LINKS = cbool(rsConstants("nonLoggedInNavLinks"))
	
	

'************************************************************************************************************
'THE FOLLOWING CAN BE CHANGED IF DESIRED, BUT IS UNNECESSARY IN MOST CASES
	'Application version number
	Const SV_VERSION_NUMBER = "6.7.4 Advanced Edition"
	
	'minutes before cookie expires in administration section
	
	Dim SV_SESSION_TIMEOUT
	SV_SESSION_TIMEOUT = rsConstants("sessionTimeout")

	'Constants for location of help images
	Const SV_LARGE_HELP_IMAGE = "images/help-big.gif"
	Const SV_SMALL_HELP_IMAGE = "images/help.gif"
	
	'Default number of results per page on pages with dynamic "paging"
	Dim SV_RESULTS_PER_PAGE
	SV_RESULTS_PER_PAGE = rsConstants("resultsPerPage")
	
	'default number of inputs for "answers" on item types
	Const SV_NUMBER_ANSWERS = 10
		
	'max length of value in a dropdown menu for the admin module
	Const SV_DROPDOWN_MAX_LENGTH = 25
	
	'Defaults number of years in date select fields
	Const USD_DROPDOWN_YEARS = 5
	
	'default year in date selects without default date specified
	Const SV_DEFAULT_START_YEAR = 2000
	
	'Constants for default dates in date dropdown items
	Const SV_EARLIEST_DATE = "1/1/1900"
	Const SV_LATEST_DATE = "1/1/2999"
			
	'default message for completing surveys (you can still change this message for each survey
	Const SV_DEFAULT_COMPLETION_MESSAGE = "Thank you for taking this survey."
				
	'indicate True/False of whether users who register must specify an email address
	Dim SV_EMAIL_REQUIRED
	SV_EMAIL_REQUIRED = cbool(rsConstants("emailRequired"))
	
	'indictate True/False of whether to display separate pages when editing survey
	Const SV_PAGE_VIEW_SURVEY = True
	
	'default value in various dropdown menus
	Dim  SV_DROPDOWN_DEFAULT
	SV_DROPDOWN_DEFAULT = rsConstants("dropdownDefault")
	
	Dim SV_DEFAULT_REPORT_TYPE
	SV_DEFAULT_REPORT_TYPE = rsConstants("defaultReportType")
	
	Dim SV_CUSTOM_USER_FIELD_1
	Dim SV_CUSTOM_USER_FIELD_2
	Dim SV_CUSTOM_USER_FIELD_3
	
	SV_CUSTOM_USER_FIELD_1 = rsConstants("customUserField1")
	SV_CUSTOM_USER_FIELD_2 = rsConstants("customUserField2")
	SV_CUSTOM_USER_FIELD_3 = rsConstants("customUserField3")
	
	'Constants for security types
	Const SV_SECURITY_TYPE_COOKIES = 1
	Const SV_SECURITY_TYPE_SESSION = 2
	
	Dim SV_SECURITY_TYPE 
	SV_SECURITY_TYPE = rsConstants("securitytype")
	
	Dim SV_PREVENT_CONCURRENT_LOGIN
	SV_PREVENT_CONCURRENT_LOGIN = rsConstants("preventConcurrentLogin")
	
	If len(SV_PREVENT_CONCURRENT_LOGIN) > 0 and not isNull(SV_PREVENT_CONCURRENT_LOGIN) Then
		SV_PREVENT_CONCURRENT_LOGIN = cbool(SV_PREVENT_CONCURRENT_LOGIN)
	Else
		SV_PREVENT_CONCURRENT_LOGIN = False
		strConstantsSQL = "UPDATE usd_surveySettings SET preventConcurrentLogin = 0"
		Call utility_executeCommand(strConstantsSQL)
	End If
	
	Dim SV_COOKIE_NAME
	SV_COOKIE_NAME = rsConstants("cookieName")
	
	If len(SV_COOKIE_NAME) = 0 or isNull(SV_COOKIE_NAME) Then
		SV_COOKIE_NAME = "UltimateSurvey"
		strConstantsSQL = "UPDATE usd_surveySettings SET cookieName = 'UltimateSurvey'"
		Call utility_executeCommand(strConstantsSQL)
	End If
	
	rsConstants.Close
	Set rsConstants = NOTHING
	
	strConstantsSQL = "SELECT color FROM usd_graphColors ORDER by colorID"
	
	Dim objConnDB
	Set objConnDB = Server.CreateObject("ADODB.Connection")
	objConnDB.Open DB_CONNECTION
	Set rsConstants = objConnDB.Execute(strConstantsSQL)
	
	If not rsConstants.EOF Then
		Dim arrColors
		Dim intArraySize


		arrColors = rsConstants.GetRows
		intArraySize = (Ubound(arrColors, 2) - LBound(arrColors, 2)) + 1
	End If
	rsConstants.Close
	
	Set rsConstants = NOTHING
	
	
'**************************************************************************************************************

'IT IS HIGHLY DANGEROUS TO CHANGE ANY OF THE REST OF THE CONSTANTS IN THIS FILE, AND IS NOT RECOMMENDED WITHOUT
'		A THOROUGH UNDERSTANDING OF WHAT EACH IS USED FOR. 

	'Constant for errors
	Const SV_ERROR_NO_PERMISSION = 1
	Const SV_ERROR_NOT_LOGGED_IN = 2
		
	Const SV_REPORT_TYPE_GRAPHS = 1
	Const SV_REPORT_TYPE_TABLE = 2	

	'Constant used for the email list templates
	Const SV_EMAIL_DELIMCHAR = "@@"
		
	'Constants for messages passed in query strings
	Const SV_MESSAGE_USER_ADDED = 1
	Const SV_MESSAGE_LOGGED_IN = 2
	Const SV_MESSAGE_NO_PERMISSION = 3
	Const SV_MESSAGE_LOGIN_INFO_CHANGED = 4
	Const SV_MESSAGE_SURVEY_DELETED = 5
	Const SV_MESSAGE_UNKNOWN_ERROR = 6 
	Const SV_MESSAGE_SURVEY_UNAVAILABLE = 7
	Const SV_MESSAGE_USERS_INVITED = 8
	Const SV_MESSAGE_RESPONSE_DELETED = 9
	Const SV_MESSAGE_ITEM_EDITED = 10
	Const SV_MESSAGE_PROPERTIES_EDITED = 11
	Const SV_MESSAGE_CONDITIONS_UNAVAILABLE = 12
	Const SV_MESSAGE_USER_TYPE_EDITED = 13
	Const SV_MESSAGE_NETWORKUSERS_ADDED = 14
	Const SV_MESSAGE_TEMPLATE_EDITED = 15
	Const SV_MESSAGE_USERS_ADDED = 16
	Const SV_MESSAGE_USERS_REMINDED = 17
	Const SV_MESSAGE_INFORMATION_SENT = 18
	Const SV_MESSAGE_CATEGORY_ADDED = 19
	Const SV_MESSAGE_CATEGORYITEM_ADDED = 20
	Const SV_MESSAGE_CATEGORY_EDITED = 21
	Const SV_MESSAGE_PERMISSION_GIVEN = 22
	Const SV_MESSAGE_NO_ITEMS = 23
	Const SV_MESSAGE_OTHER_USER_LOGGED_IN = 24
	Const SV_MESSAGE_SECURITY_SETTINGS_CHANGED = 25
	Const SV_MESSAGE_HIDDEN_FIELD_ADDED = 26
	
	'Constants for user types
	Const SV_USER_TYPE_ADMINISTRATOR = 1
	Const SV_USER_TYPE_CREATOR = 2
	Const SV_USER_TYPE_TAKE_ONLY = 3
	
	'Constants for survey types
	Const SV_SURVEY_TYPE_PUBLIC = 1
	Const SV_SURVEY_TYPE_REGISTERED_ONLY = 2
	Const SV_SURVEY_TYPE_RESTRICTED = 3
	
	'Constants used by multiple Ultimate Software Designs Application
	Const USD_MINUTES = "N"
	Const USD_HOURS = "h"
	Const USD_DAYS = "d"
	Const USD_MONTHS = "m"
	Const USD_YEARS = "yyyy"
	
	'Constants for question/item types
	Const SV_ITEM_TYPE_HEADER = 1
	Const SV_ITEM_TYPE_MESSAGE = 2
	Const SV_ITEM_TYPE_IMAGE = 3
	Const SV_ITEM_TYPE_LINE = 4
	Const SV_ITEM_TYPE_HTML = 5
	Const SV_ITEM_TYPE_TEXTAREA = 6
	Const SV_ITEM_TYPE_SINGLE_LINE = 7
	Const SV_ITEM_TYPE_DATE = 8
	Const SV_ITEM_TYPE_CHECKBOXES = 9
	Const SV_ITEM_TYPE_RADIO = 10
	Const SV_ITEM_TYPE_DROPDOWN = 11
	Const SV_ITEM_TYPE_MATRIX = 12
	Const SV_ITEM_TYPE_HIDDEN = 13
	
	'Constants for hidden field types
	Const SV_HIDDEN_FIELD_TYPE_COOKIE = 14
	Const SV_HIDDEN_FIELD_TYPE_QUERYSTRING = 15
	Const SV_HIDDEN_FIELD_TYPE_SESSION = 16
	
	'Constants for required data types of questions
	Const SV_DATA_TYPE_NUMBER = 1
	Const SV_DATA_TYPE_INTEGER = 2
	Const SV_DATA_TYPE_DECIMAL = 3
	Const SV_DATA_TYPE_MONEY = 4
	Const SV_DATA_TYPE_DATE = 5
	Const SV_DATA_TYPE_EMAIL = 6
	
	'Constants for conditions
	Const SV_CONDITION_EQUALS_ID = 1
	Const SV_CONDITION_NOT_EQUAL_ID = 2
	Const SV_CONDITION_GREATER_THAN_ID = 3
	Const SV_CONDITION_LESS_THAN_ID = 4
	Const SV_CONDITION_CONTAINS_ID = 5
	Const SV_CONDITION_DOES_NOT_CONTAIN_ID = 6
	Const SV_CONDITION_ANSWERED = 7
	Const SV_CONDITION_DID_NOT_ANSWER = 8
 
	'Constants for query string when moving items up and down within a page when editing survey
	Const SV_UP = 1
	Const SV_DOWN = 2
	
	'Constants for privacy level IDs - correspond to ID in database
	Const SV_PRIVACY_LEVEL_PRIVATE = 1
	Const SV_PRIVACY_LEVEL_SUMMARY = 2
	Const SV_PRIVACY_LEVEL_DETAILS = 3
	
	'Constants for various actions
	Const SV_ACTION_DELETE_SURVEY = 1
	Const SV_ACTION_CLEAR_RESULTS = 2
	Const SV_ACTION_CONTINUE_SURVEY = 3
	Const SV_ACTION_RESTART_SURVEY = 4
	
	'Constants for radio button layouts
	Const SV_RADIO_LAYOUT_HORIZONTAL = 1
	Const SV_RADIO_LAYOUT_VERTICAL = 2

	'Constants for page types
	Const SV_PAGE_TYPE_SURVEYS = 1
	Const SV_PAGE_TYPE_REPORTS = 2
	Const SV_PAGE_TYPE_USERS = 3
	Const SV_PAGE_TYPE_MYINFO = 4
	Const SV_PAGE_TYPE_SETTINGS = 5
	
	'Constants for reporting permission per survey
	Const SV_REPORT_PERMISSION_FULL = 1
	Const SV_REPORT_PERMISSION_DENIED = 2
	Const SV_REPORT_PERMISSION_SUMMARY = 3
	
	'Constants for login type
	Const SV_LOGIN_TYPE_PASSWORD = 1
	Const SV_LOGIN_TYPE_NETWORK = 2
	
	'Constants for graph types
	Const SV_GRAPH_TYPE_COLUMN = 1
	Const SV_GRAPH_TYPE_PIE = 2
	Const SV_GRAPH_TYPE_DONUT = 3
	Const SV_GRAPH_TYPE_LINE = 4
	
	Const SV_GRAPH_TYPE_SHOWN = 0
	Const SV_GRAPH_TYPE_HIDDEN = 1

	Const SV_MATRIX_LAYOUT_RADIO = 1
	Const SV_MATRIX_LAYOUT_CHECKBOX = 2
	Const SV_MATRIX_LAYOUT_DROPDOWN = 3
	Const SV_MATRIX_LAYOUT_SINGLE = 4
	Const SV_MATRIX_LAYOUT_SCALE = 5
	Const SV_MATRIX_LAYOUT_ALPHASCALE = 6
	
	Const SV_PERMISSION_TYPE_GROUP = 1
	Const SV_PERMISSION_TYPE_INDIVIDUAL = 2
	
	Set rsConstants = Nothing
%>