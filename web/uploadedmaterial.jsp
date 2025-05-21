<%@page import="za.ac.tut.bl.ContentUpload"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%
    List<ContentUpload> uploadedMaterials = (List<ContentUpload>) request.getAttribute("uploadedMaterials");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Uploaded Materials</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header h1 {
            margin: 0;
            font-size: 1.6em;
        }
        .container {
            max-width: 800px;
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
        .material {
            background: #f0f0ff;
            border-left: 5px solid #4e54c8;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 6px;
        }
        .material h3 {
            margin: 0 0 10px;
            color: #333;
        }
        .material p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
<header>
    <h1>EduSync - Uploaded Materials</h1>
</header>

<div class="container">
    <h2>Your Uploaded Content</h2>
    <%
        if (uploadedMaterials != null && !uploadedMaterials.isEmpty()) {
            for (ContentUpload item : uploadedMaterials) {
    %>
    <div class="material">
        <h3><%= item.getTitle() %></h3>
        <p><strong>Description:</strong> <%= item.getDescription() %></p>
        <p><strong>Subject:</strong> <%= item.getSubject() != null ? item.getSubject() : "N/A" %></p>
        <p><strong>Uploaded on:</strong> <%= item.getUploadDate() %></p>
        <p>
            <a href="<%= request.getContextPath() + "/" + item.getContentUrl() %>" target="_blank" style="color: green; margin-right: 20px;">Download</a>
            <a href="DeleteContentServlet.do?title=<%= item.getTitle() %>" onclick="return confirm('Are you sure you want to delete this material?')" style="color: red;">Delete</a>
        </p>
    </div>
    <%
            }
        } else {
    %>
    <p>No content uploaded yet.</p>
    <%
        }
    %>
</div>

<div class="container">
    <h2>Search & Filter Materials</h2>
    <form method="get" action="UploadedMaterial.do">
        <label for="search">Search by Title:</label>
        <input type="text" id="search" name="search" placeholder="Enter title keyword..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">

        <label for="subject">Filter by Subject:</label>
        <select name="subject" id="subject">
            <option value="">-- All Subjects --</option>
            <option value="math" <%= "math".equalsIgnoreCase(request.getParameter("subject")) ? "selected" : "" %>>Math</option>
            <option value="science" <%= "science".equalsIgnoreCase(request.getParameter("subject")) ? "selected" : "" %>>Science</option>
            <option value="english" <%= "english".equalsIgnoreCase(request.getParameter("subject")) ? "selected" : "" %>>English</option>
        </select>

        <input type="submit" value="Apply">
    </form>
</div>

</body>
</html>
