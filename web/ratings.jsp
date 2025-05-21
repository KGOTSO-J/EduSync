<%-- 
    Document   : ratings
    Created on : 07 May 2025, 6:57:00 PM
    Author     : jonas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Ratings Page</title>
    </head>
    <body>
        <h1>Student Ratings!</h1>
        <p>Click the button below to generate your report.</p>
        <form method="post" action="GenerateReviewReportServlet.do">
            <input type="submit" value="Generate Review Report">
        </form>
    </body>
</html>
