/* FUNCTIONS USED ONLY IN menu.aspx */
function handleOnLoad() {
	window.name = "right_window"
}

window.onload = handleOnLoad;

/* MENU ACTION FUNCTIONS */
function menuHelpIndex() {
	window.open("Help.aspx");
}

function menuExit() {
	try {
		top.frames[1].frames[1].closeCommand();
	}
	catch(e) {}
}

function isProjectLoaded() {
	try {
		return top.frames[1].frames[1].getProjectName() != '';
	}
	catch(e) {}
	return false;
}
