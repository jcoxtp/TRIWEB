<%
    	Dim strThisLocation, strVarValue 
		'strThisLocation = "production"
		strThisLocation = "development"
	    
		'== Site Domain ============
			If strThisLocation = "production" Then
				strDbConnString = "Provider=SQLOLEDB.1;Data Source=216.52.198.215,1433;Network Library=DBMSSOCN;Trusted_Connection=False;Initial Catalog=TeamResources;User Id=sa;Password=s3rv3r pa33word!;"
				
				Application("SiteDomain") = "www.pdiprofile.com"
				Application("strDbConnString") = strDbConnString
				Application("ActivePDF_IP") = "216.52.198.213"
				Application("PDFOut_DiskPath") = "C:\PDFReports"
				Application("PDFOut_SitePath") = "/PDFReports/"
				Application("ChartBackgroundDir") = "C:\TRIWEB\DISC_PDF_IMAGES\"
			Else
			    Dim SqlUserName : SqlUserName = "sa"
			    Dim SqlPassword : SqlPassword = "s3rv3r pa33word!"
				
				strDbConnString = "DRIVER={SQL Server};SERVER=216.52.198.215,1433;DATABASE=TeamResources_Test;UID=" & SqlUserName & ";PWD=" & SqlPassword
				
				Application("SiteDomain") = "Triaxia5.triaxia1.triaxiapartners.com"
				Application("strDbConnString") = strDbConnString
				Application("ActivePDF_IP") = "209.155.96.6" '"192.0.0.7"
				Application("PDFOut_DiskPath") = "C:\PDFReports"
				Application("PDFOut_SitePath") = "/PDFReports/"
				Application("ChartBackgroundDir") = "C:\TRIWEB\DISC_PDF_IMAGES\"
			End If

			Set oConn = CreateObject("ADODB.Connection")
            oConn.Open strDbConnString, SqlUserName, SqlPassword
    
 %>
