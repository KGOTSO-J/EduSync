<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Notifications</title>
    <style>
        body {
            font-family: Arial;
            padding: 20px;
            background-color: #f9f9f9;
        }
        h2 {
            color: #333;
        }
        .notification {
            background-color: #e8f4fd;
            padding: 15px;
            margin: 10px 0;
            border-left: 5px solid #2196F3;
            border-radius: 4px;
        }
        .notification:hover {
            background-color: #dbeefc;
        }
        .back {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 15px;
            background-color: #555;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .back:hover {
            background-color: #333;
        }
    </style>
</head>
<body>
    <h2>Notifications</h2>
    <%
        List<String> notifications = (List<String>) request.getAttribute("notifications");
        if (notifications != null && !notifications.isEmpty()) {
            for (String note : notifications) {
    %>
        <div class="notification">
            <%= note %>
        </div>
    <%
            }
        } else {
    %>
        <p>You have no notifications.</p>
    <%
        }
    %>
    <a class="back" href="student_dashboard.jsp">⬅ Back to Dashboard</a>
</body>
</html>
