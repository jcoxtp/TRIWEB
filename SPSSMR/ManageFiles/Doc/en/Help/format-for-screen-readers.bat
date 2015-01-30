@ECHO OFF

if exist help-screen-reader-on.js do (
  if exist help-screen-reader.js do (
    rename help-screen-reader.js help-screen-reader-off.js
  )
  rename help-screen-reader-on.js help-screen-reader.js
)
