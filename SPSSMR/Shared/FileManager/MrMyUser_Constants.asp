<%
' Constant Values to use with function calls on MrFileMgt component

' MRFM_FOLDER_TYPE			// the type of folder to be used...
Dim FT_ROOT            			' the FMROOT folder name (must have DPMAdministrator role)
Dim FT_INTERVIEW_ROOT       		' returns mrInterview master folder, ProjectName can be empty string when this option is specified
Dim FT_INTERVIEW_PROJECT_ROOT		' returns mrInterview master project folder
Dim FT_USER_PROJECT_ROOT			
Dim FT_USER_PROJECT_MEDIA			
Dim FT_USER_PROJECT_TEMPLATES		
Dim FT_SHARED_FAVORITES			' ProjectName can be empty string when this option is specified
Dim FT_SHARED_PROJECT_ROOT			
Dim FT_SHARED_PROJECT_MEDIA		
Dim FT_SHARED_PROJECT_TEMPLATES	
Dim FT_RERSERVED					

' MRFM_FOLDER_ACCESSTYPE	// how the folder will be accessed by the client...
Dim FAT_DEFAULT					' will determine whether to return local path name or shared UNC path name based on server the object is being called from and the server in the DPM
Dim FAT_USELOCAL					' will be used locally so return local path e.g. c:\fmroot\<project>
Dim FAT_USESHARED					' will be used remotely so return shared path e.g. //MyMachine\fmroot_sharename\<project>
Dim FAT_RESERVED				

' MRFM_FOLDER_CREATEOPTION	// determines whether to create the folder is it doesn't exist, prior to returning the folder string
Dim FCO_NULL			    		' do nothing
Dim FCO_CREATEIFNOTEXIST			' create if folder exists
Dim FCO_FAILIFNOTEXIST				' fail if folder does not exist
Dim FCO_RESERVED				

' MRFM_FILE_COPYOPTION		// determines how to handle the files. Can be more than one...
Dim FCPY_COPYFILE					' copy file
Dim FCPY_BACKUPDESTFILEIFEXISTS	' back up file if it exists in the destination folder
Dim FCPY_DELETESRCFILEAFTERCOPY	' delete source file when copied to the destination folder (move)
Dim FCPY_MERGEMDM					' merge source MDM file with file in destination folder (must be same name)	
Dim FCPY_FAILIFDESTFILEEXISTS		' fail if destination file exists
Dim FCPY_RERSERVED					


' MRFM_FOLDER_TYPE			// the type of folder to be used...
FT_ROOT            			= &H00
FT_INTERVIEW_ROOT       		= &H10
FT_INTERVIEW_PROJECT_ROOT		= &H20
FT_USER_PROJECT_ROOT			= &H30
FT_USER_PROJECT_MEDIA			= FT_USER_PROJECT_ROOT ' &H31
FT_USER_PROJECT_TEMPLATES		= FT_USER_PROJECT_ROOT ' &H32
FT_SHARED_FAVORITES			= &H40
FT_SHARED_PROJECT_ROOT			= &H50
FT_SHARED_PROJECT_MEDIA		= FT_SHARED_PROJECT_ROOT ' &H51
FT_SHARED_PROJECT_TEMPLATES	= FT_SHARED_PROJECT_ROOT ' &H52
FT_RERSERVED					= &HFF

' MRFM_FOLDER_ACCESSTYPE	// how the folder will be accessed by the client...
FAT_DEFAULT			    	= &H00
FAT_USELOCAL					= &H01
FAT_USESHARED					= &H02
FAT_RESERVED					= &HFF

' MRFM_FOLDER_CREATEOPTION	// determines whether to create the folder is it doesn't exist, prior to returning the folder string
FCO_NULL			    		= &H00
FCO_CREATEIFNOTEXIST			= &H01
FCO_FAILIFNOTEXIST				= &H02
FCO_RESERVED					= &HFF

' MRFM_FILE_COPYOPTION		// determines how to handle the files. Can be more than one...
FCPY_COPYFILE					= &H00
FCPY_BACKUPDESTFILEIFEXISTS	= &H01
FCPY_DELETESRCFILEAFTERCOPY	= &H02
FCPY_MERGEMDM					= &H04
FCPY_FAILIFDESTFILEEXISTS		= &H10
FCPY_RERSERVED					= &HFF
%>