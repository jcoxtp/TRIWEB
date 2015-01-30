<%
'*****************************************************************************************
'   System: Ultimate Survey
'
'   Page Description: This page contains the database connections
'
'   COPYRIGHT NOTICE								
'
'   See attached Software License Agreement
'
'   (c) Copyright 2002 - 2006 by Ultimate Software Designs.  All rights reserved.
'*****************************************************************************************

'Depending on whether you are using Access or SQL Server, you must comment out one of the lines
'that initialize the constant DB_CONNECTION.  The other line should be updated with
'the appropriate details to connect to your database.  SQL Server is highly recommended.

'***** SQL SERVER FORMAT *****
'Update the string, replacing the words YourServerName, YourDatabaseName, YourUsername, and YourPassword 
'with the appropriate values.
Const DB_CONNECTION = "Provider=SQLOLEDB.1;Data Source=65.205.160.188,1433;Network Library=DBMSSOCN;Trusted_Connection=False;Initial Catalog=UltimateSurvey;User Id=sa;Password=s3rv3r pa33word!;"
Const DATABASE_TYPE = "SQLServer"

'***** MS ACCESS FORMAT *****
'Update the string, making the "Data Source" point to the location of your database on the hard drive.
'By default, the Access databases use the password 'admin' to be opened.  We suggest that you change this

'Const DB_CONNECTION = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=c:\inetpub\wwwroot\UltimateSurvey\Database\UltimateSurvey.mdb;"
'Const DATABASE_TYPE = "MSAccess"



%>