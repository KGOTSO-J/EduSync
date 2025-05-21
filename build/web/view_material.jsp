<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="za.ac.tut.bl.ContentUpload" %>

<%
    // Getting the material object set in the ViewMaterialServlet
    ContentUpload content = (ContentUpload) request.getAttribute("material");
    if (content == null) {
        response.sendRedirect("uploadedmaterial.jsp?error=notfound");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Material</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
        }
        header {
            background: #4e54c8;
            color: white;
            padding: 20px 40px;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        h2 {
            color: #4e54c8;
            margin-bottom: 20px;
        }
        p {
            margin-bottom: 15px;
        }
        .download-btn {
            display: inline-block;
            padding: 12px 20px;
            background-color: #4e54c8;
            border-radius: 8px;
            color: white;
            text-decoration: none;
            margin-top: 20px;
        }
        .download-btn:hover {
            background-color: #3c44b0;
        }
    </style>
</head>

<body>

<header>
    <h1>Material Details</h1>
</header>

<div class="container">
    <h2><%= content.getTitle() %></h2>
    <p><strong>Description:</strong> <%= content.getDescription() %></p>
    
    <%-- You may not have "subject" in ContentUpload, remove if not needed --%>
    <%-- <p><strong>Subject:</strong> <%= content.getSubject() %></p> --%>

    <p><strong>Uploaded File:</strong> 
        <a class="download-btn" href="<%= content.getFileName() %>" target="_blank">View / Download File</a>
    </p>
</div>

</body>
</html>
