<%-- 
    Document   : fileUpload
    Created on : Apr 5, 2025, 8:33:15 PM
    Author     : KTYJ
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html> 
<head> 
<title> Java File Upload Servlet Example </title> 
</head> 
<body>

  <form method="post" action="UploadServlet" enctype="multipart/form-data">
    <input type="file" name="file" multiple/>
    <input type="submit" value="Upload" />
  </form>

</body>
</html>
