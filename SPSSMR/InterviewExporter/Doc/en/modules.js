// modules.js
//
// This script file defines the modules that exist for
// this documentation system. This allows the content to
// dynamically update to be in synch with the installed
// modules or options.

var module_array = [
];

  // ******DO NOT MODIFY ANYTHING BELOW THIS POINT********

// Let the system know if modules are defined
var modules_defined = false;

for (iter=0;iter<module_array.length;iter++) {
  eval("var " + module_array[iter][0] + " = " + module_array[iter][1] + ";");
}
