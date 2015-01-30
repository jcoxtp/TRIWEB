<%@  language="VBScript" codepage="65001" %>

<!--#Include file="Include/authorizeredirect.asp" -->

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  	<style type="text/css">
		h2#main-message {
			font-family: "Times New Roman", Times, serif;
			font-size: 24px;
			font-weight: normal;
			font-style: italic;
			color: #001A8E;
			margin:2em auto 1em;
			display: block;
			width:80%;
			text-align: center;
		}

		div#loader {
			display: block;
			width:60%;
			margin:1em auto;
			text-align: center;
		}

	</style>
	<title>Please allow us a moment to process your payment.</title>
</head>
<body onload="SubmitForm()">
    <form id="form" method="post" action="authresponse.asp">
        	<h2 id="main-message">Please allow us a moment to process your payment.</h2>
	    <div id="loader">
		    <img src="images/blue-spinner.gif" alt="loading" />
	    </div>
        <div>
            <script type="text/javascript">
                function SubmitForm() {
                    $("#form").submit();
                }
            </script>
        </div>
        <input type="HIDDEN" name="x_response_code" value="<%=responseCode%>">
        <input type="HIDDEN" name="x_response_subcode" value="<%=responseSubcode %>">
        <input type="HIDDEN" name="x_response_reason_code" value="<%=responseReasonCode %>">
        <input type="HIDDEN" name="x_response_reason_text" value="<%=responseReasonText %>">
        <input type="HIDDEN" name="x_auth_code" value="<%=authorizationCode%>">
        <input type="HIDDEN" name="x_avs_code" value="<%=avsCode %>">
        <input type="HIDDEN" name="x_trans_id" value="<%=transId %>">
        <input type="HIDDEN" name="x_invoice_num" value="<%=invoiceNumber%>">
        <input type="HIDDEN" name="x_description" value="<%=description %>">
        <input type="HIDDEN" name="x_amount" value="<%=amount%>">
        <input type="HIDDEN" name="x_method" value="<%=method %>">
        <input type="HIDDEN" name="x_type" value="<%=paytype %>">
        <input type="HIDDEN" name="x_cust_id" value="<%=customerId%>">
        <input type="HIDDEN" name="x_first_name" value="<%=firstName%>">
        <input type="HIDDEN" name="x_last_name" value="<%=lastName%>">
        <input type="HIDDEN" name="x_company" value="<%=company %>">
        <input type="HIDDEN" name="x_address" value="<%=address %>">
        <input type="HIDDEN" name="x_city" value="<%=city %>">
        <input type="HIDDEN" name="x_state" value="<%=state %>">
        <input type="HIDDEN" name="x_zip" value="<%=zip %>">
        <input type="HIDDEN" name="x_country" value="">
        <input type="HIDDEN" name="x_phone" value="">
        <input type="HIDDEN" name="x_fax" value="">
        <input type="HIDDEN" name="x_email" value="<%=emailAddress%>">
        <input type="HIDDEN" name="x_ship_to_first_name" value="">
        <input type="HIDDEN" name="x_ship_to_last_name" value="">
        <input type="HIDDEN" name="x_ship_to_company" value="">
        <input type="HIDDEN" name="x_ship_to_address" value="">
        <input type="HIDDEN" name="x_ship_to_city" value="">
        <input type="HIDDEN" name="x_ship_to_state" value="">
        <input type="HIDDEN" name="x_ship_to_zip" value="">
        <input type="HIDDEN" name="x_ship_to_country" value="">
        <input type="HIDDEN" name="x_tax" value="<%=tax %>">
        <input type="HIDDEN" name="x_duty" value="<%=duty %>">
        <input type="HIDDEN" name="x_freight" value="<%=frieght%>">
        <input type="HIDDEN" name="x_tax_exempt" value="<%=taxExempt %>">
        <input type="HIDDEN" name="x_po_num" value="">
        <input type="HIDDEN" name="x_MD5_Hash" value="<%=md5Hash %>">
        <input type="HIDDEN" name="x_cvv2_resp_code" value="">
        <input type="HIDDEN" name="x_cavv_response" value="">
        <input type="HIDDEN" name="intUserID" value="<%=userId %>">
        <input type="HIDDEN" name="intResellerID" value="<%=intResellerId%>">
        <input type="HIDDEN" name="intPurchaseID" value="<%=purchaseId %>">
        <input type="HIDDEN" name="txtProductsDescription" value="">
        <input type="HIDDEN" name="intNumberOfProducts" value="<%=numProducts %>">
        <input type="HIDDEN" name="mnyTotalDiscounted" value="<%=totalDiscount %>">
        <input type="HIDDEN" name="intTestID1" value="<%=testId1 %>">
        <input type="HIDDEN" name="mnyProductAmount1" value="<%=prodAmount1 %>">
        <input type="HIDDEN" name="intProductQuantity1" value="<%=prodQuantity1 %>">
        <input type="HIDDEN" name="intTestID2" value="<%=testId2 %>">
        <input type="HIDDEN" name="mnyProductAmount2" value="<%=prodAmount2 %>">
        <input type="HIDDEN" name="intProductQuantity2" value="<%=prodQuantity2 %>">
        <input type="HIDDEN" name="intTestID3" value="<%=testId3 %>">
        <input type="HIDDEN" name="mnyProductAmount3" value="<%=prodAmount3 %>">
        <input type="HIDDEN" name="intProductQuantity3" value="<%=prodQuantity3 %>">
        <input type="HIDDEN" name="intTestID4" value="<%=testId4 %>">
        <input type="HIDDEN" name="mnyProductAmount4" value="<%=prodAmount4 %>">
        <input type="HIDDEN" name="intProductQuantity4" value="<%=prodQuantity4 %>">
        <input type="HIDDEN" name="intTestID5" value="<%=testId5 %>">
        <input type="HIDDEN" name="mnyProductAmount5" value="<%=prodAmount5 %>">
        <input type="HIDDEN" name="intProductQuantity5" value="<%=prodQuantity5 %>">
        <input type="HIDDEN" name="intTestID6" value="<%=testId6 %>">
        <input type="HIDDEN" name="mnyProductAmount6" value="<%=prodAmount6 %>">
        <input type="HIDDEN" name="intProductQuantity6" value="<%=prodQuantity6 %>">
        <input type="HIDDEN" name="intTestID7" value="<%=testId7 %>">
        <input type="HIDDEN" name="mnyProductAmount7" value="<%=prodAmount7 %>">
        <input type="HIDDEN" name="intProductQuantity7" value="<%=prodQuantity7 %>">
        <input type="HIDDEN" name="add" value="<%=add %>">
    </form>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</body>
</html>
