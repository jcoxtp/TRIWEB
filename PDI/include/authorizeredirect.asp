<%
    dim amount
    dim firstName
    dim lastName
    dim customerId
    dim description
    dim invoiceNumber
    dim frieght
    dim authorizationCode
    dim responseCode
    dim poNumber
    dim testRequest
    dim emailAddess
    dim resellerId
    dim responseSubcode
    dim responseReasonText
    dim avsCode
    dim transId
    dim totalDiscount
    dim numProducts
    dim intResellerId
    dim md5Hash
    dim userId
    dim taxExempt
    dim duty
    dim tax
    dim zip
    dim state
    dim city
    dim address
    dim company
    dim paytype
    dim method
    dim testId1
    dim testId2
    dim testId3
    dim testId4
    dim testId5
    dim testId6
    dim prodAmount1
    dim prodAmount2
    dim prodAmount3
    dim prodAmount4
    dim prodAmount5
    dim prodAmount6
    dim prodQuantity1
    dim prodQuantity2
    dim prodQuantity3
    dim prodQuantity4
    dim prodQuantity5
    dim prodQuantity6

    amount = request.Form("x_Amount")
    firstName = request.Form("x_First_Name")
    lastName = request.Form("x_Last_Name")
    customerId = request.Form("x_Cust_ID")
    description = Request.Form("x_Description")
    invoiceNumber = request.Form("x_Invoice_Num")
    frieght = request.Form("x_freight")
    authorizationCode = request.Form("x_Auth_Code")
    responseCode = request.Form("x_Response_Code")
    poNumber = request.Form("x_po_num")
    testRequest = request.Form("x_test_request")
    emailAddress = request.Form("x_email")
    resellerId = request.Form("ResellerId")
    intResellerId = request.Form("intResellerID")
    responseSubcode = request.Form("x_response_subcode")
    responseReasonText = request.Form("x_response_reason_text")
    avsCode = request.Form("x_avs_code")
    transId = request.Form("x_trans_id")
    method = Request.Form("x_method")
    paytype = request.Form("x_type")
    company = request.Form("x_company")
    address = request.Form("x_address")
    city = request.Form("x_city")
    state = request.Form("x_state")
    zip = request.Form("x_zip")
    tax = request.Form("x_tax")
    duty = request.Form("x_duty")
    taxExempt = request.Form("x_tax_exempt")
    md5Hash = request.Form("x_MD5_Hash")
    userId = request.Form("intUserID")
    purchaseId = Request.Form("intPurchaseID")
    numProducts = request.Form("intNumberOfProducts")
    totalDiscount = request.Form("mnyTotalDiscounted")
    
    testId1 = request.Form("intTestID1")
    prodAmount1 = request.Form("mnyProductAmount1")
    prodQuantity1 = request.Form("intProductQuantity1")
    
    testId2 = request.Form("intTestID2")
    prodAmount2 = request.Form("mnyProductAmount2")
    prodQuantity2 = request.Form("intProductQuantity2")
    
    testId3 = request.Form("intTestID3")
    prodAmount3 = request.Form("mnyProductAmount3")
    prodQuantity3 = request.Form("intProductQuantity3")
    
    testId4 = request.Form("intTestID4")
    prodAmount4 = request.Form("mnyProductAmount4")
    prodQuantity4 = request.Form("intProductQuantity4")
    
    testId5 = request.Form("intTestID5")
    prodAmount5 = request.Form("mnyProductAmount5")
    prodQuantity5 = request.Form("intProductQuantity5")

    testId6 = request.Form("intTestID6")
    prodAmount6 = request.Form("mnyProductAmount6")
    prodQuantity6 = request.Form("intProductQuantity6")

    testId7 = request.Form("intTestID7")
    prodAmount7 = request.Form("mnyProductAmount7")
    prodQuantity7 = request.Form("intProductQuantity7")
%>
