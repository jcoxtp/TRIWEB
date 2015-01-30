<%
	'Arrays for option lists
		Dim Gender(2) '-------------------------------------------
			Gender(1) = strTextMale
			Gender(2) = strTextFemale
		
		Dim Age(6) '-------------------------------------------
			Age(1) = "18-25"
			Age(2) = "26-35"
			Age(3) = "36-45"
			Age(4) = "46-55"
			Age(5) = "56-65"
			Age(6) = strTextOver & " 65"
		
		Dim Education(6) '-------------------------------------------
			Education(1) = strTextSomeHighSchool
			Education(2) = strTextHighSchoolGraduate
			Education(3) = strTextSomeCollege
			Education(4) = strTextCollegeGraduate
			Education(5) = strTextSomeGraduateSchool
			Education(6) = strTextPostGraduateDegree
		
		Dim Occupation(20) '-------------------------------------------
			Occupation(1) = strTextAccountingFinance
			Occupation(2) = strTextComputerRelated
			Occupation(3) = strTextConsulting
			Occupation(4) = strTextCustomerService
			Occupation(5) = strTextEducationTraining
			Occupation(6) = strTextEngineering
			Occupation(7) = strTextSeniorManagement
			Occupation(8) = strTextAdministrative
			Occupation(9) = strTextGovernmentMilitary
			Occupation(10) = strTextHomemaker
			Occupation(11) = strTextManufacturing
			Occupation(12) = strTextMedicalLegal
			Occupation(13) = strTextRetired
			Occupation(14) = strTextMarketingAdvising
			Occupation(15) = strTextSelfEmployedOwner
			Occupation(16) = strTextSales
			Occupation(17) = strTextTradesmanCraftsman
			Occupation(18) = strTextStudent
			Occupation(19) = strTextBetweenJobs
			Occupation(20) = strTextOther
		
		Dim MgtResp(2) '-------------------------------------------
			MgtResp(1) = Application("strTextYes" & strLanguageCode)
			MgtResp(2) = Application("strTextNo" & strLanguageCode)
%>