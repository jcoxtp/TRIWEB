<%
' Set initial critical page parameters
	Response.Buffer = True
	'On Error Resume Next
	intPageID = 35	' Credit Card Information Collection Page
%>
<!--#Include file="Include/Common.asp" -->
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Transaction Search</title>
    <link href="Content/themes/base/all.css" rel="stylesheet" />
    <link rel="stylesheet" href="Include/Default.css" type="text/css">
	<link rel="stylesheet" href="/RS/<%=SitePathName%>/Reseller.css" type="text/css">
    <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/smoothness/jquery-ui.css" />


	<!--#Include file="Include/HeadStuff.asp" -->
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>

</head>
<body>
    <!--#Include file="Include/TopBanner.asp" -->
    <div id="main">
        <div id="maincontent">
            <div class="transaction-search">
                <div class="date transaction-search-field">
                    <label for="transDate">Transaction Date:<span class="required">*</span></label>
                    <input id="transDate" type="date" required /><span><em> to present</em></span>
                    <script type="text/javascript">
                        $("#transDate").datepicker();
                    </script>
                </div>
                <div class="card transaction-search-field">
                    <label for="last4CreditCard">Last 4 digits of Credit Card:<span class="required">*</span></label>
                    <input id="last4CreditCard" maxlength="4" required />
                </div>
                <div class="key"><span class="required">*</span>Required field</div>
            </div>
            <div class="submit">
                <img id="loadingImg" class="spinner" src="images/blue-spinner.gif" /><input type="button" value="Submit" />
            
            </div>
            <div id="msg">
    <!--            <p class="success msg-response"><b>Your transaction has been found</b> and added to your account page.<a class="return" href="EnterTestCode.asp">Click here to return to your account page.</a></p>
                <p class="error msg-response"><b>Please try again.</b> If you continue to recieve this message, please contact Triaxia Partners at (770) 956-0986 or email us at <a href="mailto:info@triaxiapartners.com">info@triaxiapartners.com</a><a class="return" href="EnterTestCode.asp">Click here to return to your account page.</a></p>
                <p class="no-match msg-response"><b>We are unable to find a transaction that matches this criteria.</b> <a class="return" href="EnterTestCode.asp">Click here to return to your account page.</a></p>-->
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var $pMsg = $('#msg');
        var $loadingImg = $("#loadingImg");
        $loadingImg.hide();
        $("input[type=button]").click(function () {
            var userId = getParameterByName("userId");
            var languageId = getParameterByName("lid");
            var resellerId = getParameterByName("res");
            var transactionDate = $("#transDate").val();
            var last4CreditCard = $("#last4CreditCard").val();
            var valid = Validate(last4CreditCard);

            //removes appended elements between submit clicks
            var m = $pMsg.children().length;
            if (m > 0) {
                $pMsg.children().remove();
            }

            if (valid) {
                $loadingImg.show();

                var data = {};
                data.transactionDate = transactionDate;
                data.cardNumber = last4CreditCard;
                data.customerId = userId;
                data.resellerId = resellerId;
                data.languageId = languageId;

                var url = "http://192.0.0.86:8080/api/transactiondetailsapi";
                $.ajax({
                    url: url,
                    data: data,
                    async: false,
                    jsonpCallback: "callback",
                    type: "GET",
                    dataType: "jsonp",
                    callbackParameter: 'callback'
                })
                //.done(function (data, status) {
                //    $pMsg.append('Please click <a href="EnterTestCode.asp">HERE</a> to view you previously purchased Profile codes.');
                //})
                //.fail(function (response,status) {
                //    var spanTag = $(document.createElement('h3'));
                //    spanTag.text('There is not a transaction that matches this.')
                //    $pMsg.append(spanTag);
                //    var statusCode = response.statusCode;
                //    console.log(status);
                //})
                .always(function (response, status) {
                    $loadingImg.hide();
                    if (status === 'parsererror') {
                        callback(status);
                    }
                });
            }
        });

        function callback(msg) {
            if (msg === "Transaction purchase updated.") {
                var spanTag = $(document.createElement('p'));
                spanTag.html('<b>Your transaction has been found</b> and added to your account page.<a class="return" href="EnterTestCode.asp">Click here to return to your account page.</a>')
                spanTag.addClass("success");
                spanTag.addClass("msg-response");

                $pMsg.append(spanTag);
            }
            else if (msg === "Internal server error.") {
                var spanTag = $(document.createElement('p'));
                spanTag.addClass("error");
                spanTag.addClass("msg-response");
                spanTag.html('<b>Please try again.</b> If you continue to recieve this message, please contact Triaxia Partners at (770) 956-0986 or email us at <a href="mailto:info@triaxiapartners.com">info@triaxiapartners.com</a><a class="return" href="EnterTestCode.asp">Click here to return to your account page.</a>');

                $pMsg.append(spanTag);
            }
            else {
                var spanTag = $(document.createElement('p'));
                spanTag.addClass("no-match");
                spanTag.addClass("msg-response");
                spanTag.html('<b>We are unable to find a transaction that matches this criteria.</b> <a class="return" href="EnterTestCode.asp">Click here to return to your account page.</a>')

                $pMsg.append(spanTag);
            }
        }

        function parseQuery(qstr) {
            var query = {};
            var a = qstr.split('&');
            for (var i in a) {
                var b = a[i].split('=');
                query[decodeURIComponent(b[0])] = decodeURIComponent(b[1]);
            }

            return query;
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        function Validate(last4CreditCard) {
            var valid = true;
            var input = $("#last4CreditCard").removeClass("error");

            if (isNaN(last4CreditCard)) {
                //notify user to enter a number.
                valid = false;
                //console.log("this is not a number.");
            }

            if (last4CreditCard.length !== 4) {
                //notify user to enter last 4 of credit card.
                valid = false;
                //console.log("this is not vaild input.");
            }

            if (valid !== true) {
                var input = $("#last4CreditCard").addClass("error");
                return false;
            }

            return true;
        }
    </script>


    <style>
        #maincontent {
            display: block;
            left: 100px !important;
        }

        a {
            color: #127BD1;
        }

        em {
            color:#777;
            font-size: .85em;
        }

        .transaction-search {
            display: block;
            background-color: #E1E1E1;
            border: thin solid #DCDDDC;
            padding:1em;
        }

        .transaction-search-field {
            margin:1em auto 1em 30%;
            display: block;
        }

        .transaction-search-field label {
            display: block;
        }

        .transaction-search-field input {
            text-align: center;
            font-size: 1.25em;

        }

        .submit {
            width:100%;
            margin:0 auto 1em;
            display: block;
            text-align: right;
        }

        .submit input {
            display: inline-block;
            vertical-align: middle;
            margin:1em 0 1em 1em;
            background:none #127BD1;
            border: none;
            border-radius: 2px;
            padding:.5em 1.5em;
            font-size: 1.25em;
            color: white;
        }
        .spinner {
            display: inline-block;
            vertical-align: middle;
        }
        .msg-response {
            display: block;
            width:100%;
            border-radius: 2px;
            padding:1em;
            margin:0 auto;
        }

        .success {
            background-color: #eaffb2;
            border: thin solid #A0C25C;
            color: #2B7533;
            font-size: 1.25em;
            font-style: italic;
            font-weight: normal;
            text-align: center;
        }

        .error {
            background-color: #ffd7d7;
            border: thin solid #ff7e7e;
            color: #F00;
            font-size: 1.25em;
            font-style: italic;
            font-weight: normal;
            text-align: center;
        }
        .no-match {
            background-color: #f0f0f0;
            border: thin solid #a5a5a5;
            color: black;
            font-size: 1.25em;
            font-style: italic;
            font-weight: normal;
            text-align: center;
        }

        .return {
            border-radius: 2px;
            display: inline-block;
            font-size: 0.9em;
            font-style: normal;
            margin: 0.5em;
            padding: 0.15em 0.5em;
            text-decoration: none;
            background-color: #127BD1;
            color:white;
        }

        .error .return {
            background-color: #bbbbbb;
            color: #2d2d2d;
            border: thin solid #111
        }

        .required {
            font-weight: bold;
            color: #DE5E30;
        }

        .key {
            font-size: .85em;
            width:100%;
            text-align: right;
            
            display: block;
        }
        

    </style>
</body>
</html>
