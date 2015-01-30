function trUser() {
	this.UserID = "";
	this.UserName = "";
	this.Name = "";
	this.Email = "";
	this.Company = "";
}

function trUser_toXML() {
	var xml = "<User>";
	xml += "<UserID>" + this.UserID + "</UserID>";
	xml += "<UserName>" + this.UserName + "</UserName>";
	xml += "<Name>" + this.Name + "</Name>";
	xml += "<Email>" + this.Email + "</Email>";
	xml += "<Company>" + this.Company + "</Company";
	xml += "</User>";
	
	return xml;
}
trUser.prototype.toXML = trUser_toXML;

function Company() {
	this.CompanyID = "";
	this.Name = "";
	this.Address = "";
	this.City = ""; 
	this.Province = "";
	this.Country = "";
}

function Team() {
	this.TeamID = "";
	this.Name = "";
	this.LeaderID = "";
	this.Leader = "";
	this.CompanyID = "";
	this.Company = "";
}

function Team_toXML() { 
	var xml = "<Team>";
	xml += "<TeamID>" + this.TeamID + "</TeamID>";
	xml += "<Name>" + this.Name + "</Name>";
	xml += "<LeaderID>" + this.LeaderID + "</LeaderID>";
	xml += "<Leader>" + this.Leader + "</Leader>";
	xml += "<CompanyID>" + this.CompanyID + "</CompanyID>";
	xml += "<Company>" + this.Company + "</Company>";
	xml += "</Team>";
	
	return xml;
}
Team.prototype.toXML = Team_toXML;