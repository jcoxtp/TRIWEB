var docPathCss = 'include/';
var docPathHTML = '/PDI/';

function loadFooter(func) {

    var previousOnLoad = window.onload;

    if (typeof window.onload != 'function') {

        window.onload = func
    } else {
        window.onload = function () {

            previousOnLoad();

            func();
        }
    }
}

loadFooter(function () {

    if ($('.loginbody').length > 0) {

        //var languageChooser = $('.LoginLanguageChooser'),
		//	lcLocation = languageChooser.offset(),
		//	lcHeight = languageChooser.height(),
		//	bodyTable = $('#background-table'),
		//	btHeight = bodyTable.height(),
        //    lcBottom;
        //if (typeof lcLocation === 'undefined') {
        //    lcBottom = 0;
        //}
        //else {
        //    lcBottom = (lcLocation.top + lcHeight);
        //}

        function darkFootLoader() {
            //$('#footer').load(docPathHTML + 'dark-footer.html');
            $('#footer').load(docPathHTML + 'footer2.html');
            $('#footer').css('border-top', 'thin solid #333333');
        };

        $('.loginbody').append('<div id="footer"></div>');
        //$('head').append($("<link rel='stylesheet' href='" + docPathCss + "dark-footer.css' type='text/css'/>"));
        $('head').append($("<link rel='stylesheet' href='" + docPathCss + "footer2.css' type='text/css'/>"));
        //bodyTable.attr('height', lcBottom);
        if ($('#footer').length > 0) {
            darkFootLoader();
        } else {
            setTimeout(darkFootLoader, 100);
        }

    } else if ($('#maincontent').length > 0) {

        function lightFootLoader() {
            var footer = $('#footer'),
                footOff = footer.offset();
            //footer.load(docPathHTML + 'light-footer.html');
            footer.load(docPathHTML + 'footer2.html');

            if (footOff.top > 200) {
                footer.css({
                    //'margin':'1em auto',
                    'border-top': 'thin solid #D9D9D9'
                });
            }
        };

        $('#main').after('<div id="footer"></div>');
        //$('head').append($("<link rel='stylesheet' href='" + docPathCss + "light-footer.css' type='text/css'/>"));
        $('head').append($("<link rel='stylesheet' href='" + docPathCss + "footer2.css' type='text/css'/>"));

        if ($('#footer').length > 0) {
            lightFootLoader();
        } else {
            setTimeout(lightFootLoader, 100);
        }

    } else if ($('#maincontent_tab').length > 0) {

        function lightFootLoader() {
            var footer = $('#footer'),
                footOff = footer.offset();
            //footer.load(docPathHTML + 'light-footer.html');
            footer.load(docPathHTML + 'footer2.html');

            if (footOff.top > 200) {
                footer.css({
                    //'margin': '1em auto',
                    'border-top': 'thin solid #D9D9D9'
                });
            }
        };

        $('#main').after('<div id="footer"></div>');
        //$('head').append($("<link rel='stylesheet' href='" + docPathCss + "light-footer.css' type='text/css'/>"));
        $('head').append($("<link rel='stylesheet' href='" + docPathCss + "footer2.css' type='text/css'/>"));

        if ($('#footer').length > 0) {
            lightFootLoader();
        } else {
            setTimeout(lightFootLoader, 100);
        }
    }
});
