USE master
GO

CREATE FUNCTION dbo.RemoveNonAlphaNumericAndSpaces (@inputString varchar(100))
RETURNS varchar(100)
AS
BEGIN

DECLARE @k int
DECLARE @outputString varchar(100)
SET @outputString = @inputString
SET @k=32

WHILE @k <= 255
BEGIN
   IF (@k between 32 and 47)
   or (@k between 58 and 64) 
   or (@k between 91 and 96) 
   or (@k between 123 and 255) 
   SET @outputString = REPLACE(@outputString, char(@k), '')
   SET @k=@k+1 
END

RETURN @outputString
END
GO

CREATE FUNCTION udf_GenerateUsername 
	(@FirstName nvarchar(64), 
	@LastName nvarchar(64))
RETURNS nvarchar(24)
AS
BEGIN
DECLARE @username nvarchar(32), 
		  @cleanFirst nvarchar(64), 
		  @cleanLast nvarchar(64), 
		  @lastLen int

	SET @cleanFirst = lower(master.dbo.RemoveNonAlphaNumericAndSpaces(@FirstName))
	SET @cleanLast = lower(master.dbo.RemoveNonAlphaNumericAndSpaces(@LastName))

	SET @username = substring(@cleanFirst, 1, 1)
	SET @lastLen = Len(@cleanLast)
	IF @lastLen > 11
		SET @lastLen = 11
	SET @username = @username + LTRIM(substring(@cleanLast, 1, @lastLen))

	RETURN @username
END
GO


USE TeamResources

ALTER TABLE TeamMembers
	ADD ProfileCode nvarchar(50) NULL
GO


ALTER Procedure sp_GetTeamMembers
	@teamID int
AS

/******************************************************************************
**		File: sp_GetTeamMembers.sql
**		Name: sp_GetTeamMembers
**		Desc: 
**
**		Auth: Marc L. Porlier
**		Date: 8/27/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------				-------------------------------------------
**    11/23/2005	M. Porlier			Added column: ProfileCode
*******************************************************************************/
SET NOCOUNT ON

SELECT u.UserID, i.FirstName, i.LastName, u.Username, u.[Password], 
		 i.EmailAddress, c.CompanyName [Company], m.TeamSummaryID [TeamID],
		 m.ProfileCode
FROM trUser u
INNER JOIN UserInfo i ON u.Userinfoid = i.Userinfoid
INNER JOIN Company c ON i.Companyid = c.Companyid
INNER JOIN TeamMembers m ON u.UserID = m.TeamMemberID
WHERE m.TeamSummaryID = @teamID

SET NOCOUNT OFF
GO
/*****************************************************************************/

CREATE Procedure sp_SaveTrUser
	@xml ntext,
	@admin varchar(50)
AS

/******************************************************************************
**		File: sp_SaveTrUser.sql
**		Name: sp_SaveTrUser
**		Desc: 
**
**		Auth: Marc L. Porlier
**		Date: 11/23/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------				-------------------------------------------
**
*******************************************************************************/
SET NOCOUNT ON
DECLARE @DocHandle int, @adminID int, @userinfoID int, 
		  @tempName nvarchar(50), @counter int

DECLARE @UserID int,
	@UserName nvarchar (50),		@Password nvarchar (50),		
	@FirstName nvarchar (100),		@LastName nvarchar (100),
	@EmailAddress nvarchar (100),	@Area NVarChar(100),
	-- Company Info ---------------------
	@CompanyID int,					@Department nvarchar(50),
	-- Demographics ---------------------
	@Position nvarchar(100),		@TeamName nvarchar(50),
	@Gender nchar(1),					@Age int,
	@Education int,					@Occupation int,
	@MgtResp nchar(1)					

SELECT @adminID = UserID FROM trUser WHERE UserName = @admin

IF NOT EXISTS (
	SELECT r.*
	FROM UserRoles r
		INNER JOIN UserUserRoleAffiliations ra ON r.UserRoleID = ra.UserRoleID
	WHERE ra.UserID = @adminID AND r.Name IN ('Manager','Administrator')
)
BEGIN
	RAISERROR('Unauthorized access to sp_SaveTrUser', 16, 1)
	RETURN 0
END

EXEC sp_xml_preparedocument @DocHandle OUTPUT, @xml

SELECT @UserID = userid,	@UserName = Username,
	@Password = Password,	@FirstName = firstname,
	@LastName = lastname,	@EmailAddress = emailaddress,
	@Area = area,				@Department = department,
	@CompanyID = companyid,	@Position = position,
	@Gender = gender,			@Age = age,
	@Education = education,	@Occupation = occupation,
	@MgtResp = mgtresp,		@TeamName = teamname
FROM 
	OPENXML (@DocHandle, '/truser', 2)
	WITH (
	userid int,						username nvarchar (50),	
	[password] nvarchar (50),	firstname nvarchar (100),
	lastname nvarchar (100),	emailaddress nvarchar (100),
	area NVarChar(100),			department nvarchar(50),
	companyid int,					position nvarchar(100),
	gender nchar(1),				age int,
	education int,					occupation int,
	mgtresp nchar(1),				teamname nvarchar(50)
	) AS x

EXEC sp_xml_removedocument @DocHandle 

IF EXISTS (SELECT * FROM UserInfo WHERE EmailAddress = @EmailAddress)
BEGIN -- Update of CompanyID
	UPDATE UserInfo
	SET CompanyID = @CompanyID,
		 LastModificationDate = getdate(),
		 LastModifiedBy = @adminID
	WHERE EmailAddress = @EmailAddress
END -- Update of CompanyID
ELSE
BEGIN -- INSERT of New User

/************* Generate a unique username and password ***********************/
SET @username = master.dbo.udf_GenerateUsername(@FirstName, @LastName)
	SET @counter = 0
	SET @tempName = @userName
	
	WHILE EXISTS (SELECT * FROM trUser WHERE Username = @userName)
	BEGIN
		SET @counter = @counter + 1
		SET @userName = @tempName + RTRIM(LTRIM(CAST(@counter AS varchar(5))))
	END
	
	SET @counter = 0
	SET @password = CHAR(ROUND(65 + (RAND() * (90 - 65)),0))
	
	WHILE @counter < 4
	BEGIN
		SET @password = @password + CHAR(ROUND(65 + (RAND() * (90 - 65)),0))
		SET @counter = @counter + 1
	END
/*****************************************************************************/

BEGIN TRANSACTION -- INSERT INTO UserInfo, TRUser, & UserDemographics

INSERT INTO [UserInfo] (
		CompanyResolved,	FirstName,		LastName, 
		CompanyID, 			Postition, 		Department, 
		TeamName, 			EmailAddress,	Area,
		CreationDate,		CreatedBy, 		LastModificationDate, 
		LastModifiedBy)
	VALUES (
		1, 					@FirstName, 	@LastName, 
		@CompanyID, 		@Position, 		@Department, 
		@TeamName, 			@EmailAddress, @Area,
		getdate(), 			@adminID, 		getdate(), 
		@adminID)

SELECT @userinfoID = @@IDENTITY

INSERT INTO [TRUser] (
		UserInfoID, 		UserName, 		[Password], 
		CreationDate, 		CreatedBy, 		LastModificationDate, 
		LastModifiedBy)
	VALUES (
		@userinfoID, 		@UserName, 		@Password, 
		getdate(), 			@adminID, 		getdate(), 
		@adminID)

SELECT @userID = @@IDENTITY

INSERT INTO [UserDemographics] (
		UserID, 				Gender, 			Age, 
		Education, 			Occupation, 	MgtResp)
	VALUES (
		@UserID, 			@Gender, 		@Age, 
		@Education, 		@Occupation, 	@MgtResp)

IF (@@error != 0)
	BEGIN
		ROLLBACK TRAN
		EXEC ins_OperationNote 'Errors occurred - execution of sp_SaveTrUser fails - transaction rolled back', 5
		RAISERROR 96001 'Execution of sp_SaveTrUser failed. This error has been logged. Please contact a system administrator.'
		RETURN 0 
	END

COMMIT TRANSACTION  -- INSERT INTO UserInfo, TRUser, & UserDemographics

END -- INSERT of New User

SELECT u.UserID, u.Username, u.Password, i.Firstname, i.Lastname,
	i.EmailAddress, c.CompanyName Company, i.CompanyID, i.Postition Position,
	i.TeamName,	i.Department, i.Area, d.Gender, d.Age, d.Education, d.Occupation, 
	d.MgtResp
FROM trUser u
	INNER JOIN UserInfo i ON u.UserInfoID = i.UserInfoID
	INNER JOIN UserDemographics d ON d.UserID = u.UserID
	INNER JOIN Company c ON i.CompanyID = c.CompanyID
WHERE u.UserID = @userID

SET NOCOUNT OFF
GO

GRANT EXECUTE ON sp_SaveTrUser TO TRWebsite
GO

/*****************************************************************************/

ALTER Procedure sp_GetTeamMembers
	@teamID int
AS

/******************************************************************************
**		File: sp_GetTeamMembers.sql
**		Name: sp_GetTeamMembers
**		Desc: 
**
**		Auth: Marc L. Porlier
**		Date: 8/27/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------				-------------------------------------------
**    11/23/2005	M. Porlier			Added column: ProfileCode, and addt'l
**												UserInfo and UserDemographics columns
*******************************************************************************/
SET NOCOUNT ON

SELECT u.UserID, i.FirstName, i.LastName, u.Username, u.[Password], 
		 i.EmailAddress, c.CompanyName [Company], m.TeamSummaryID [TeamID],
		 m.ProfileCode, i.CompanyID, i.Postition Position, i.TeamName,
		 i.Department, i.Area, d.Age, d.Education, d.Occupation, d.MgtResp,
		 d.Gender
FROM trUser u
INNER JOIN UserInfo i ON u.Userinfoid = i.Userinfoid
INNER JOIN UserDemographics d ON u.UserID = d.UserID
INNER JOIN Company c ON i.Companyid = c.Companyid
INNER JOIN TeamMembers m ON u.UserID = m.TeamMemberID
WHERE m.TeamSummaryID = @teamID

SET NOCOUNT OFF
GO

/*****************************************************************************/
PRINT 'Must change ALTER to CREATE for installation of sp_ResellerTeamImport'
GO

CREATE PROCEDURE sp_ResellerTeamImport
	@firstname nvarchar(100),
	@lastname nvarchar(100),
	@emailaddress nvarchar(100),
	@companyid int,
	@teamID int,
	@profileMgr nvarchar(50)
AS

/******************************************************************************
**		File: sp_ResellerTeamImport.sql
**		Name: sp_ResellerTeamImport
**		Desc: Used for team list import.
**
**		Auth: Marc L. Porlier
**		Date: 11/29/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
SET NOCOUNT ON
DECLARE @adminID int, @userinfoID int, @teamName nvarchar(100), @userID int,
		  @tempName nvarchar(50), @counter int, @testcode nvarchar(50), 
		  @username varchar(50), @password varchar(50), @testcodeid int,
		  @errMsg varchar(255), @returnCode int

SET @returnCode = 0
SELECT @adminID = UserID FROM trUser WHERE UserName = @profileMgr AND IsProfileMgr = 1

IF @adminID IS NULL
BEGIN
	RAISERROR 96000 'Unauthorized access to sp_ResellerTeamImport'
	RETURN 1
END

SELECT @teamName = TeamName FROM TeamSummary WHERE TeamSummaryID = @teamID

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

BEGIN TRANSACTION -- INSERT INTO UserInfo, TRUser, UserDemographics, & Team tables

IF EXISTS (SELECT * FROM UserInfo WHERE EmailAddress = @EmailAddress)
BEGIN -- Update of CompanyID
	UPDATE UserInfo
	SET CompanyID = @CompanyID,
		 LastModificationDate = getdate(),
		 LastModifiedBy = @adminID
	WHERE EmailAddress = @EmailAddress

	SELECT @userID = UserID
	FROM trUser u
		INNER JOIN UserInfo i ON u.userinfoid = i.userinfoid
	WHERE EmailAddress = @EmailAddress

	SELECT @tempName = CompanyName FROM Company WHERE CompanyID = @companyid
	SET @errMsg = 'User email already in database. User company association was changed to ' +
					  @tempName + ' and user was added to team list.'
	RAISERROR(@errMsg, 2, 1)
	SET @returnCode = 2
END -- Update of CompanyID
ELSE
BEGIN -- INSERT of New User

/************* Generate a unique username and password ***********************/
	SET @username = master.dbo.udf_GenerateUsername(@FirstName, @LastName)
	SET @counter = 0
	SET @tempName = @userName
	
	WHILE EXISTS (SELECT * FROM trUser WHERE Username = @userName)
	BEGIN
		SET @counter = @counter + 1
		SET @userName = @tempName + RTRIM(LTRIM(CAST(@counter AS varchar(5))))
	END
	
	SET @counter = 0
	SET @password = CHAR(ROUND(65 + (RAND() * (90 - 65)),0))
	
	WHILE @counter < 4
	BEGIN
		SET @password = @password + CHAR(ROUND(65 + (RAND() * (90 - 65)),0))
		SET @counter = @counter + 1
	END
/*****************************************************************************/


--1. UserInfo INSERT
	INSERT INTO [UserInfo] (
		CompanyResolved,	FirstName,		LastName, 
		CompanyID, 			Postition, 		Department, 
		TeamName, 			EmailAddress,	Area,
		CreationDate,		CreatedBy, 		LastModificationDate, 
		LastModifiedBy)
	VALUES (
		1, 					@FirstName, 	@LastName, 
		@CompanyID, 		'', 				'', 
		@teamName,			@EmailAddress, '',
		getdate(), 			@adminID, 		getdate(), 
		@adminID)

	SELECT @userinfoID = @@IDENTITY

--2. TRUser INSERT
	INSERT INTO [TRUser] (
		UserInfoID, 		UserName, 		[Password], 
		CreationDate, 		CreatedBy, 		LastModificationDate, 
		LastModifiedBy)
	VALUES (
		@userinfoID, 		@UserName, 		@Password, 
		getdate(), 			@adminID, 		getdate(), 
		@adminID)

	SELECT @userID = @@IDENTITY

--3. UserDemographics INSERT
	INSERT INTO [UserDemographics] (
		UserID, 				Gender, 			Age, 
		Education, 			Occupation, 	MgtResp)
	VALUES (
		@UserID, 			'', 				0, 
		0, 					0, 				'')
END -- INSERT of New User
	
IF (@@error != 0)
BEGIN
	ROLLBACK TRAN
	EXEC ins_OperationNote 'Errors occurred - execution of sp_ResellerTeamImport fails in attempt to insert new user - transaction rolled back', 5
	RAISERROR 96001 'Execution of sp_ResellerTeamImport failed in attempt to insert new user. Please contact a system administrator.'
	RETURN 1
END

--4. Assign new user to an available profile code

-- Pop an available profile code from the profile manager's purchases (NOTE: uses F.I.F.O. logic)
SELECT @testcode = TestCode, @testcodeid = TestCodeID
FROM TestCode
WHERE 
	TRTestID = 1 AND
	TestCodeID = (
		SELECT MIN(ptc.TestCodeID)
		FROM Purchase_TestCode ptc
			INNER JOIN Purchase p ON p.PurchaseID = ptc.PurchaseID
		WHERE TestTakerID IS NULL AND 
				p.UserID = @adminID)
 

IF @testcode IS NULL
BEGIN
	ROLLBACK TRAN
	RAISERROR 96002 'Profile Manager does not have any remaining profile codes available for assignment. No changes were committed.' 
	RETURN 1
END


--5. TeamMembers INSERT
IF NOT EXISTS (SELECT * FROM TeamMembers WHERE TeamSummaryID = @teamID AND TeamMemberID = @userID)
BEGIN
	INSERT INTO TeamMembers (
		TeamSummaryID,	TeamMemberID,	ProfileCode)
	VALUES (
		@teamID,			@userID,			@testCode)

	UPDATE Purchase_TestCode
	SET TestTakerID = @userID
	WHERE TestCodeID = @testcodeid
END

IF (@@error != 0)
BEGIN
	ROLLBACK TRAN
	EXEC ins_OperationNote 'Errors occurred - execution of sp_ResellerTeamImport fails in attempt to insert user as team member - transaction rolled back', 5
	RAISERROR 96001 'Execution of sp_ResellerTeamImport failed in attempt to insert user as team member. Please contact a system administrator.'
	RETURN 1
END


COMMIT TRANSACTION  -- INSERT INTO UserInfo, TRUser, UserDemographics, & Team tables

SELECT @returnCode

SET NOCOUNT OFF
GO

GRANT EXECUTE ON sp_ResellerTeamImport TO TRWebsite
GO
-------------------------------------------------------------------------------

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sp_DeleteTeamMember')
	BEGIN
		PRINT 'Dropping Procedure sp_DeleteTeamMember'
		DROP  Procedure  sp_DeleteTeamMember
	END

GO

PRINT 'Creating Procedure sp_DeleteTeamMember'
GO
CREATE Procedure sp_DeleteTeamMember
	@memberID int,
	@teamID int
AS

/******************************************************************************
**		File: sp_DeleteTeamMember.sql
**		Name: sp_DeleteTeamMember
**		Desc: 
**
**		Auth: Marc L. Porlier
**		Date: 12/7/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
SET NOCOUNT ON

DECLARE @profileCode nvarchar(50)

BEGIN TRANSACTION -- Release Profile Code, DELETE Team Member

SELECT @profileCode = ProfileCode 
FROM TeamMembers
WHERE TeamSummaryID = @teamID AND
		TeamMemberID = @memberID
		
UPDATE Purchase_TestCode SET TestTakerID = null
WHERE TestTakerID = @memberID AND
		TestCodeID = (
			SELECT TestCodeID
			FROM TestCode
			WHERE TestCode = @profileCode)
		
DELETE TeamMembers
WHERE TeamSummaryID = @teamID AND
		TeamMemberID = @memberID
		
IF (@@error != 0)
BEGIN
	ROLLBACK TRAN
	EXEC ins_OperationNote 'Errors occurred - execution of sp_DeleteTeamMember fails in attempt to remove team member - transaction rolled back', 5
	RAISERROR 96001 'Execution of sp_DeleteTeamMember failed in attempt to remove team member. Please contact a system administrator.'
	RETURN 1
END

COMMIT TRANSACTION -- Release Profile Code, DELETE Team Member

SET NOCOUNT OFF
GO

GRANT EXEC ON sp_DeleteTeamMember TO TRWebsite

GO

----------------------------------------

CREATE Procedure sp_GroupStatusReport
	@groupID INT
AS

/******************************************************************************
**		File: sp_GroupStatusReport.sql
**		Name: sp_GroupStatusReport
**		Desc: 
**
**		Auth: Marc L. Porlier
**		Date: 12/8/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------				-------------------------------------------
**    
*******************************************************************************/
SET NOCOUNT ON

SELECT
	TestCode.TestCode, 
	Purchase.CreationDate AS PurchaseDate,
	Purchase_TestCode.Redeemed, 
	UserInfo.FirstName + ' ' + UserInfo.LastName AS TestTaker, 
	UserInfo.LastName TestTakerLastName,
	UserInfo.EmailAddress,
	UserInfo.Area AS Area,
	Results.TestStartDate, 
	Results.TestCompleteDate, 
	Results.FileCreated, 
	Results.PDFFileName, 
	Results.HighFactorType1, 
	Results.HighFactorType2, 
	Results.ProfileName As RepProfileName,
	Purchase_TestCode.AppModFileName,
	Purchase_TestCode.AppModCreated
FROM (
	Purchase 
	INNER JOIN Purchase_TestCode ON Purchase.PurchaseID = Purchase_TestCode.PurchaseID
	INNER JOIN TestCode ON Purchase_TestCode.TestCodeID = TestCode.TestCodeID
	INNER JOIN TeamMembers ON TeamMembers.ProfileCode = TestCode.TestCode
	INNER JOIN TRUser TestTaker ON Purchase_TestCode.TestTakerID = TestTaker.UserID
	INNER JOIN UserInfo ON UserInfo.UserInfoID = TestTaker.UserInfoID)
	LEFT JOIN (
		SELECT TestResults.TestCodeID, TextTexts.[Text] ProfileName, PDITestSummary.HighFactorType1,
					PDITestSummary.HighFactorType2, PDITestSummary.FileCreated, PDITestSummary.PDFFileName, 
					TestResults.TestStartDate, TestResults.TestCompleteDate
		FROM PDIRepProfile 
		INNER JOIN Texts ON PDIRepProfile.RepProfileNAmeTextID = Texts.TextID
		INNER JOIN TextTexts ON TextTexts.TextID = Texts.TextID AND TextTexts.LanguageID = 1
		INNER JOIN PDITestSummary ON PDIRepProfile.PDIRepProfileID = PDITestSummary.ProfileID1
		INNER JOIN TestResults ON PDITestSummary.TestResultsID = TestResults.TestResultsID
	) AS Results ON Results.TestCodeID = TestCode.TestCodeID
WHERE
	Purchase.PurchaseComplete = 1 AND
	TeamMembers.TeamSummaryID = @groupID
ORDER BY
	UserInfo.LastName

SET NOCOUNT OFF
GO

GRANT EXECUTE ON sp_GroupStatusReport TO TRWebsite
