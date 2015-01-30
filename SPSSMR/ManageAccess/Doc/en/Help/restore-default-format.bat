@ECHO OFF

if exist help-screen-reader-off.js do (
  if exist help-screen-reader.js do (
    rename help-screen-reader.js help-screen-reader-on.js
  )
  rename help-screen-reader-off.js help-screen-reader.js
)
