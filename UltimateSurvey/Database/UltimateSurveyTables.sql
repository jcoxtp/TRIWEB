if exists (select * from sysobjects where id = object_id(N'[usd_Answers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_Answers]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_branching]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_branching]
GO


if exists (select * from sysobjects where id = object_id(N'[usd_ConditionMapping]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_ConditionMapping]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_ConditionTypes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_ConditionTypes]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_Conditions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_Conditions]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usd_emailListDetails]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_emailListDetails]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usd_emailLists]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_emailLists]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_graphColors]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_graphColors]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_invitedList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_invitedList]
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usd_itemCategories]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[usd_itemCategories]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usd_itemCategoryMap]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[usd_itemCategoryMap]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_itemResponses]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_itemResponses]
GO


if exists (select * from sysobjects where id = object_id(N'[usd_ItemTypes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_ItemTypes]
GO


if exists (select * from sysobjects where id = object_id(N'[usd_matrixAnswers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_matrixAnswers]
GO


if exists (select * from sysobjects where id = object_id(N'[usd_matrixCategories]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_matrixCategories]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_matrixSets]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_matrixSets]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_privacyLevels]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_privacyLevels]
GO


if exists (select * from sysobjects where id = object_id(N'[usd_Response]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_Response]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_ResponseDetails]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_ResponseDetails]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_restrictedSurveyUsers]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_restrictedSurveyUsers]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_scoringMessages]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_scoringMessages]
GO



if exists (select * from sysobjects where id = object_id(N'[usd_styleTemplates]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_styleTemplates]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_Survey]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_Survey]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_SurveyItem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_SurveyItem]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_surveySettings]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_surveySettings]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usd_surveyToGroupMap]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_surveyToGroupMap]
GO

if exists (select * from sysobjects where id = object_id(N'[usd_SurveyUser]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_SurveyUser]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usd_userGroupMap]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_userGroupMap]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usd_userGroups]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [usd_userGroups]
GO



CREATE TABLE [usd_Answers] (
	[answerID] [int] IDENTITY (1, 1) NOT NULL ,
	[itemID] [int] NULL ,
	[answerText] [varchar] (255),
	[isDefault] [int] NULL ,
	[points] [int] NULL,
	[alias] [varchar] (255),
	[orderByID] [int]
) ON [PRIMARY]
GO

ALTER TABLE [usd_Answers] WITH NOCHECK ADD 
	CONSTRAINT [DF_usd_Answers_isDefault] DEFAULT (0) FOR [isDefault],
	CONSTRAINT [DF_usd_Answers_points] DEFAULT (0) FOR [points]
GO

CREATE TABLE [usd_branching] (
	[branchID] [int] IDENTITY (1, 1) NOT NULL ,
	[itemID] [int] NULL ,
	[response] [ntext],
	[currentPage] [int] NULL ,
	[nextPage] [int] NULL,
	[surveyID] [int],
	[answerID] [int]
) ON [PRIMARY]
GO

CREATE TABLE [usd_ConditionMapping] (
	[conditionID] [int] NULL ,
	[itemID] [int] NULL ,
	[conditionGroupID] [int] NULL ,
	[pageID] [int] NULL ,
	[surveyID] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [usd_ConditionTypes] (
	[conditionTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[conditionTypeText] [varchar] (255),
	[orderByID] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [usd_Conditions] (
	[conditionID] [int] IDENTITY (1, 1) NOT NULL ,
	[questionAnsweredID] [int] NULL ,
	[conditionValue] [varchar] (255),
	[ConditionType] [int] NULL ,
	[conditionGUID] [varchar] (255),
	[answerID] [int]
) ON [PRIMARY]
GO

CREATE TABLE [usd_emailListDetails] (
	[listName] [nvarchar] (255),
	[email] [nvarchar] (255)
) ON [PRIMARY]
GO	

CREATE TABLE [usd_emailLists] (
	[listID] [int] IDENTITY (1, 1) NOT NULL ,
	[listName] [nvarchar] (255),
	[description] [ntext],
	[listGUID] [varchar] (255)
) ON [PRIMARY]
GO	


CREATE TABLE [usd_graphColors] (
	[colorID] [int] IDENTITY (1, 1) NOT NULL ,
	[color] [varchar] (255)
) on [PRIMARY]
GO



CREATE TABLE [usd_invitedList] (
	[invitationID] [int] IDENTITY (1,1) NOT NULL,
	[surveyID] [int] NULL,
	[email] [varchar] (255),
	[responded] [int]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[usd_itemCategories] (
	[categoryID] [int] IDENTITY (1, 1) NOT NULL ,
	[categoryName] [nvarchar] (255),
	[description] [ntext],
	[parentCategoryID] [int]
) ON [PRIMARY]
GO	

CREATE TABLE [dbo].[usd_itemCategoryMap] (
	[categoryID] [int],
	[itemID] [int]
) ON [PRIMARY]
GO	

CREATE TABLE [usd_itemResponses] (
	[itemID] [int] NULL ,
	[responseText] [text],
	[numberResponses] [int] NULL,
	[category] [varchar] (255),
	[matrixSetID] [int],
	[setText] [varchar] (255),
	[answerID] [int],
	[matrixCategoryID] [int]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [usd_itemResponses] WITH NOCHECK ADD 
	CONSTRAINT [DF_usd_itemResponses_numberResponses] DEFAULT (0) FOR [numberResponses]
GO


CREATE TABLE [usd_ItemTypes] (
	[itemTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[itemTypeText] [varchar] (255),
	[orderByID] [int] NULL,
	[description] [ntext] 
) ON [PRIMARY]
GO

CREATE TABLE [usd_matrixAnswers]
(
	[matrixAnswerID] [int] IDENTITY (1,1) NOT NULL,
	[matrixSetID] [int],
	[answerText] [varchar] (255),
	[alias] [varchar] (255),
	[points] [int],
	[isDefault] [int]
)
GO


CREATE TABLE [usd_matrixCategories] (
	[categoryID] [int] IDENTITY (1, 1) NOT NULL ,
	[itemID] [integer],
	[category] [varchar] (255),
	[alias] [varchar] (255)
) on [PRIMARY]
GO

CREATE TABLE [usd_matrixSets]
(
	[matrixSetID] [int] IDENTITY (1,1) NOT NULL,
	[itemID] [int],
	[setText] [varchar] (255),
	[matrixSetType] [int],
	[scaleStart] [int],
	[scaleEnd] [int],
	[scaleStartText] [varchar] (255),
	[scaleEndText] [varchar] (255),
	[alias] [varchar] (255),
	[orderByID] [int],
	[isRequired] [int],
	[setGUID] [varchar] (255),
	[numberResponses] [int],
	[enforceUnique] [int],
	[fieldLength] [int]
)
GO



CREATE TABLE [usd_privacyLevels] (
	[privacyLevelID] [int] IDENTITY (1, 1) NOT NULL ,
	[privacyLevelText] [varchar] (255) ,
	[orderByID] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [usd_Response] (
	[responseID] [int] IDENTITY (1, 1) NOT NULL ,
	[userID] [int] NULL ,
	[surveyID] [int] NULL ,
	[dateStarted] [datetime] NULL ,
	[dateCompleted] [datetime] NULL ,
	[userIP] [varchar] (255)  ,
	[responseGUID] [varchar] (255),
	[completed] [int] NULL,
	[lastPageAnswered] [int] NULL,
	[points] [int] NULL,
	[NTUser] [varchar] (255)
) ON [PRIMARY]
GO
ALTER TABLE [usd_Response] WITH NOCHECK ADD 
	CONSTRAINT [DF_usd_Response_completed] DEFAULT (0) FOR [completed],
	CONSTRAINT [DF_usd_Response_points] DEFAULT (0) FOR [points],
	CONSTRAINT [DF_usd_Response_lastPageAnswered] DEFAULT (0) FOR [lastPageAnswered]
GO

CREATE TABLE [usd_ResponseDetails] (
	[responseDetailID] [int] IDENTITY (1, 1) NOT NULL ,
	[responseID] [int] NULL ,
	[itemID] [int] NULL ,
	[response] [ntext]  ,
	[timeAnswered] [datetime] NULL ,
	[isOther] [int] NULL,
	[matrixCategory] [varchar] (255),
	[matrixSetID] [int],
	[setText] [varchar] (255),
	[responseAlias] [varchar] (255),
	[matrixSetType] [int],
	[answerID] [int],
	[matrixCategoryID] [int]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [usd_restrictedSurveyUsers] (
	[surveyID] [int] NULL ,
	[userID] [int] NULL,
	[invited] [int] NULL,
	[isPermitted] [int] NULL,
	[permissionType] [int]
) ON [PRIMARY]
GO

CREATE TABLE [usd_scoringMessages] (
	[messageID] [int] IDENTITY (1, 1) NOT NULL ,
	[surveyID] [int] NULL ,
	[lowPoints] [int] NULL ,
	[highPoints] [int] NULL ,
	[message] [ntext] NULL
) ON [PRIMARY]
GO


CREATE TABLE [usd_styleTemplates] (
	[templateID] [int] IDENTITY (1, 1) NOT NULL ,
	[templateName] [varchar] (255),
	[header] [ntext],
	[footer] [ntext],
	[baseFont] [varchar] (255),
	[backgroundColor] [varchar] (255),
	[titleSize] [varchar] (255),
	[titleColor] [varchar] (255),
	[surveyDescriptionSize] [varchar] (255),
	[surveyDescriptionColor] [varchar] (255),
	[questionSize] [varchar] (255),
	[questionColor] [varchar] (255),
	[questionDescriptionSize] [varchar] (255),
	[questionDescriptionColor] [varchar] (255),
	[answerSize] [varchar] (255),
	[answerColor] [varchar] (255),
	[ownerUserID] [int],
	[useStandardUI] [int],
	[oddRowColor] [varchar] (255),
	[evenRowColor] [varchar] (255),
	[headerColor] [varchar] (255)
) ON [PRIMARY]
GO
	

CREATE TABLE [usd_Survey] (
	[surveyID] [int] IDENTITY (1, 1) NOT NULL ,
	[surveyType] [int] NULL ,
	[surveyTitle] [varchar] (255) ,
	[surveyDescription] [varchar] (255) ,
	[startDate] [datetime] NULL ,
	[endDate] [datetime] NULL ,
	[orderByID] [int] NULL ,
	[responsesPerUser] [int] NULL ,
	[isActive] [int] NULL ,
	[createdDate] [datetime] NULL ,
	[numberResponses] [int] NULL ,
	[maxResponses] [int] NULL ,
	[completionMessage] [ntext]  ,
	[completionRedirect] [ntext]  ,
	[ownerUserID] [int] NULL ,
	[privacyLevel] [int] NULL ,
	[allowContinue] [int] NULL ,
	[resultsEmail] [varchar] (255),
	[isScored] [int] NULL,
	[showProgress] [int] NULL,
	[logNTUser] [int] NULL,
	[numberLabels] [int] NULL,
	[templateID] [int],
	[editable] [int],
	[userInfoAvailable] [int]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [usd_Survey] WITH NOCHECK ADD 
	CONSTRAINT [DF_usd_Survey_isScored] DEFAULT (0) FOR [isScored],
	CONSTRAINT [DF_usd_Survey_showProgress] DEFAULT (0) FOR [showProgress]
GO

ALTER TABLE [usd_Survey] WITH NOCHECK ADD 
	CONSTRAINT [DF_usd_Survey_isActive] DEFAULT (0) FOR [isActive]
GO

CREATE TABLE [usd_SurveyItem] (
	[itemID] [int] IDENTITY (1, 1) NOT NULL ,
	[surveyID] [int] NULL ,
	[pageID] [int] NULL ,
	[itemType] [int] NULL ,
	[itemText] [ntext],
	[itemDescription] [ntext] ,
	[orderByID] [int] NULL ,
	[isRequired] [int] NULL ,
	[isActive] [int] NULL ,
	[allowOther] [int] NULL ,
	[otherText] [varchar] (255) ,
	[dataType] [int] NULL ,
	[minimumValue] [varchar] (255) ,
	[defaultValue] [ntext] ,
	[maximumValue] [varchar] (255)  ,
	[layoutStyle] [int] NULL ,
	[itemGUID] [varchar] (255),
	[randomize] [int] NULL,
	[numberLabels] [int] NULL,
	[numberResponses] [int] NULL,
	[alias] [varchar] (255),
	[graphType] [int] NULL,
	[conditional] [int],
	[pipedItemID1] [int],
	[pipedItemID2] [int],
	[pipedItemID3] [int],
	[numberRows] [int],
	[numberColumns] [int],
	[variableName] [varchar] (255),
	[fieldLength] [int]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [usd_SurveyItem] WITH NOCHECK ADD 
	CONSTRAINT [DF_usd_Survey_numberResponse] DEFAULT (0) FOR [numberResponses]
GO

CREATE TABLE [usd_surveySettings] (
	[topColor] [varchar] (255),
	[menuColor] [varchar] (255),
	[titleColor] [varchar] (255),
	[siteName] [text],
	[rootPath] [text],
	[uploadedImageFolder] [text],
	[uploadedImageURL] [text],
	[indexPageHeader] [text],
	[indexPageText] [text],
	[emailCDONTS] [integer],
	[emailASPMAIL] [integer],
	[emailJMAIL] [integer],
	[smtpMailHost] [text],
	[mainEmail] [text],
	[emailFromAddress] [text],
	[inviteUsersCheckboxes] [integer],
	[defaultUserType] [integer],
	[allowPublicRegistration] [integer],
	[nonLoggedInNavLinks] [integer],
	[sessionTimeout] [integer],
	[resultsPerPage] [integer],
	[emailRequired] [integer],
	[dropdownDefault] [varchar] (255),
	[defaultReportType] [integer],
	[customUserField1] [varchar] (255),
	[customUserField2] [varchar] (255),
	[customUserField3] [varchar] (255),
	[securityType] [int],
	[emailObjectType] [int],
	[preventConcurrentLogin] [int],
	[cookieName] [varchar] (255)
) on [PRIMARY]
GO

CREATE TABLE [usd_surveyToGroupMap] (
	[groupName] [nvarchar] (255),
	[surveyID] [int],
	[isPermitted] [int]
) ON [PRIMARY]
GO

CREATE TABLE [usd_SurveyUser] (
	[userID] [int] IDENTITY (1, 1) NOT NULL ,
	[username] [varchar] (255),
	[pword] [varchar] (255) ,
	[userType] [int] NULL ,
	[firstName] [varchar] (255) ,
	[lastName] [varchar] (255)  ,
	[email] [varchar] (255) ,
	[title] [varchar] (55)  ,
	[company] [varchar] (255)  ,
	[location] [varchar] (255),
	[networkDomain] [varchar] (255),
	[loginType] [int] NULL,
	[customField1] [varchar] (255),
    	[customField2] [varchar] (255),
    	[customField3] [varchar] (255),
	[userGUID] [varchar] (255)
) ON [PRIMARY]
GO

CREATE TABLE [usd_userGroupMap] (
	[groupID] [nvarchar] (255),
	[userID] [int],
	[groupName] [nvarchar] (255)
) ON [PRIMARY]
GO	

CREATE TABLE [usd_userGroups] (
	[groupID] [int] IDENTITY (1, 1) NOT NULL ,
	[groupName] [nvarchar] (255),
	[description] [ntext],
	[groupGUID] [varchar] (255)
) ON [PRIMARY]
GO	
















