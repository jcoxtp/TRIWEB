<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<?outfile modules.js?>
<xsl:output method="text"/>
<xsl:template match="/">
<xsl:text>// modules.js
//
// This script file defines the modules that exist for
// this documentation system. This allows the content to
// dynamically update to be in synch with the installed
// modules or options.

var module_array = [
</xsl:text>
<xsl:text>];
			
	// ******DO NOT MODIFY ANYTHING BELOW THIS POINT********
			
// Let the system know if modules are defined
var modules_defined = false;</xsl:text>
<xsl:text disable-output-escaping="yes">
			
for (iter=0;iter&lt;module_array.length;iter++) {
	eval("var " + module_array[iter][0] + " = " + module_array[iter][1] + ";");
}
</xsl:text>
</xsl:template>
</xsl:stylesheet>
