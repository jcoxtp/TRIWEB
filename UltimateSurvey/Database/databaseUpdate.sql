
ALTER TABLE [usd_Answers] 

ADD [orderByID] [int] NULL
GO

ALTER TABLE [usd_matrixSets] 

ADD [fieldLength] [int] NULL
GO

ALTER TABLE [usd_surveyItem] 

ADD [pipedItemID1] [int] NULL
GO

ALTER TABLE [usd_surveyItem] 

ADD [pipedItemID2] [int] NULL
GO

ALTER TABLE [usd_surveyItem] 

ADD [pipedItemID3] [int] NULL
GO

ALTER TABLE [usd_surveyItem] 

ADD [numberRows] [int] NULL
GO

ALTER TABLE [usd_surveyItem] 

ADD [numberColumns] [int] NULL
GO

ALTER TABLE [usd_surveyItem] 

ADD [fieldLength] [int] NULL
GO

ALTER TABLE [usd_surveyItem] 

ADD [variableName] [varchar] (255)
GO

ALTER TABLE [usd_surveySettings] 

ADD [preventConcurrentLogin] [INT]
GO

ALTER TABLE [usd_surveySettings] 

ADD [cookieName] [varchar] (255)
GO

ALTER TABLE [usd_surveyUser] 

ADD [userGUID] [varchar] (255)
GO


