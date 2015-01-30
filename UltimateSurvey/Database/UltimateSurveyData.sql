DELETE usd_answers
DELETE usd_conditionMapping
DELETE usd_conditions
DELETE usd_conditionTypes
DELETE usd_itemTypes
DELETE usd_privacyLevels
DELETE usd_response
DELETE usd_responseDetails
DELETE usd_restrictedSurveyUsers
DELETE usd_survey
DELETE usd_surveyItem
DELETE usd_surveyUser
DELETE usd_surveySettings
DELETE usd_styleTemplates

--Insert all condition types
SET IDENTITY_INSERT usd_conditionTypes ON
INSERT INTO usd_conditionTypes(conditionTypeID, conditionTypeText, orderByID)
	VALUES(1,'Equals',1)
SET IDENTITY_INSERT usd_conditionTypes ON
INSERT INTO usd_conditionTypes(conditionTypeID, conditionTypeText, orderByID)
	VALUES(2,'Does Not Equal',2)
INSERT INTO usd_conditionTypes(conditionTypeID, conditionTypeText, orderByID)
	VALUES(3,'Is Greater Than',3)
INSERT INTO usd_conditionTypes(conditionTypeID, conditionTypeText, orderByID)
	VALUES(4,'Is Less Than',4)
INSERT INTO usd_conditionTypes(conditionTypeID, conditionTypeText, orderByID)
	VALUES(5,'Contains',5)
INSERT INTO usd_conditionTypes(conditionTypeID, conditionTypeText, orderByID)
	VALUES(6,'Does Not Contain',6)
INSERT INTO usd_conditionTypes(conditionTypeID, conditionTypeText, orderByID)
	VALUES(7,'Answered Question',7)
INSERT INTO usd_conditionTypes(conditionTypeID, conditionTypeText, orderByID)
	VALUES(8,'Did Not Answer Question',8)
SET IDENTITY_INSERT usd_conditionTypes OFF

--Insert all item types
SET IDENTITY_INSERT usd_itemTypes ON
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(1,'Header',4,'displays a plain text header.  "Header Text" displayed in large letters, and "Sub Text" is displayed in smaller letters.')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(2,'Message',9,'message text is displayed in bold red letters')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(3,'Image',7,'allows you to specify an image on the web, or upload an image, for display in the survey')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(4,'Horizontal Line',5,'displays a plain horizontal line across the screen')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(5,'HTML',6,'allows you to add freeform HTML.  Take care to make sure the HTML is in good form, to avoid it affecting other HTML in the page')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(6,'Multiple Line Text Area',10,'allows you to gather freeform text from the user.  An example of this is to ask "What are your thoughts on this product?"')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(7,'Single Line Text Field',12,'users can type in responses.  You can specify answer format, minimum value, maximum value, and whether or not an answer is required')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(8,'Date',2,'allows users to enter a date value.  You can specify default date, first date allowed, last date allowed, and whether or not a response is required')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(9,'Checkboxes',1,'allows you to gather multiple answers to the same question.  For example, the question could be "What activities do you enjoy?" and the answers could be "Reading, golfing, watching theater" etc. You can specify which answers are checked by default, and minimum and maximum number of answers the user can choose.  Also, you can randomize the order in which the answers are displayed, and add number labels for each answer.')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(10,'Radio Buttons',11,'allow the user to choose one answer from a list.  These are ideal for questions with a small number of answers.  You can specify whether the user can choose "other", and the text to display in that case.  You can also choose which answer is selected by default, whether an answer is required, to label the answers with numbers, and to randomize the answer order.')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(11,'Dropdown Menu',3,'allow users to choose from multiple answers without taking up much room on the page. These are especially useful for questions with a large number of potential answers, or pages with a large number or questions or other items. You can specify a which answer is selected by default, and whether an answer is required. Also, you can randomize the order in which the answers are displayed, and add number labels for each answer.')
INSERT INTO usd_itemTypes(itemTypeID, itemTypeText, orderByID, description)
	VALUES(12,'Matrix Question',8,'Matrix questions are used to rank multiple items on the same scale.  Another word for this is Likert Scale.')

SET IDENTITY_INSERT usd_itemTypes OFF


--Insert all privacy levels
SET IDENTITY_INSERT usd_privacyLevels ON
INSERT INTO usd_privacyLevels(privacyLevelID, privacyLevelText, orderByID)
	VALUES(1,'All Results Private',1)
INSERT INTO usd_privacyLevels(privacyLevelID, privacyLevelText, orderByID)
	VALUES(2,'Summary Results Public',2)
INSERT INTO usd_privacyLevels(privacyLevelID, privacyLevelText, orderByID)
	VALUES(3,'Detailed Results Public',3)
SET IDENTITY_INSERT usd_privacyLevels OFF

--Insert default user
SET IDENTITY_INSERT usd_surveyUser ON
INSERT INTO usd_surveyUser(userID, username, pword, usertype, loginType)
	VALUES(1,'admin','admin',1, 1)
SET IDENTITY_INSERT usd_surveyUser OFF

--Insert default settings
INSERT INTO usd_surveySettings
(topColor, menuColor, titleColor, siteName, rootPath, uploadedImageFolder, uploadedImageURL,
 indexPageHeader, indexPageText, emailCDONTS, emailASPMAIL, emailJMAIL, smtpMailHost,
 mainEmail, emailFromAddress, inviteUsersCheckboxes, defaultUserType, allowPublicRegistration,
 nonLoggedInNavLinks, sessionTimeout, resultsPerPage, emailRequired, dropdownDefault,defaultReportType, securityType, emailObjectType,preventConcurrentLogin,cookieName)
VALUES
('#4348B1','#E5E5E5','#FFFFFF','Ultimate Survey','http://www.yoursitename.com/UltimateSurvey/',
'c:\yourfoldername\UltimateSurvey\Images\Upload\','http://www.yoursitename.com/UltimateSurvey/Images/upload/',
'Welcome to our Survey System','This system allows you to take various complex surveys.  You may customize this message from the settings page.',
'1','0','0','yourmailhost','username@yourdomain.com','username@yourdomain.com',
'0','3','1','1','30','10','1','Please Select:',1,1,0,0,'UltimateSurvey')

--Insert graph colors
INSERT INTO usd_graphColors(color)
VALUES('F23456')
INSERT INTO usd_graphColors(color)
VALUES('33FF66')
INSERT INTO usd_graphColors(color)
VALUES('FF6600')
INSERT INTO usd_graphColors(color)
VALUES('3399FF')
INSERT INTO usd_graphColors(color)
VALUES('009966')
INSERT INTO usd_graphColors(color)
VALUES('CC3399')
INSERT INTO usd_graphColors(color)
VALUES('FFCC33')


--Insert basic template
INSERT INTO usd_styleTemplates
(header, footer, templateName, baseFont, backgroundColor, titleSize, titleColor, surveyDescriptionSize, surveyDescriptionColor, questionSize, questionColor, questionDescriptionSize,
questionDescriptionColor, answerSize, answerColor, useStandardUI, oddRowColor, evenRowColor, headerColor)
VALUES('<table width="100%" bgcolor="black"><tr><td>&nbsp;</td></tr></table>','<table width="100%" bgcolor="black"><tr><td>&nbsp;</td></tr></table>','Basic','Arial','#FFFFFF',5,'#000000', 2, '#000000',4,'#000000',2,'#000000',2,'#000000',0,'#EEEEEE','','')






