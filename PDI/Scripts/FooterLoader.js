var docPathCss = 'include/';
var docPathHTML = '/PDI/Include/';

(function loadFooter(func) {

    var previousOnLoad = window.onload;

    if (typeof window.onload != 'function') {

        window.onload = func;
    } else {
        window.onload = function () {

            previousOnLoad();

            func();
        }
    }
})(initalizer)

function lightFootLoader() {
    var footer = $('#footer');
    footer.load(docPathHTML + 'footer2.html');
};

function initalizer () { 
    var mainDiv = $('#main'),
        head = $('head');

    mainDiv.after('<div id="footer"></div>');
    head.append($("<link rel='stylesheet' href='" + docPathCss + "footer2.css' type='text/css'/>"));

    if ($('#footer').length > 0) {
        lightFootLoader();
    } else {
        setTimeout(lightFootLoader, 100);
    }
}