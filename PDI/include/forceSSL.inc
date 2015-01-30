<%
   If Request.ServerVariables("SERVER_PORT")=80 Then
      Dim strSecureURL
      strSecureURL = "https://"
      strSecureURL = strSecureURL & Request.ServerVariables("SERVER_NAME")
      strSecureURL = strSecureURL & Request.ServerVariables("URL")
      Response.Redirect strSecureURL
   End If
%>