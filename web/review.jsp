<%@page import="za.ac.tut.entities.AppUser"%>
<%@page import="java.sql.*, za.ac.tut.db.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Write Review - EduSync</title>
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
        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
        }
        input[type="text"], select, textarea, input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        textarea {
            resize: vertical;
            height: 100px;
        }
        input[type="submit"] {
            background: #4e54c8;
            color: white;
            font-weight: bold;
            margin-top: 20px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        input[type="submit"]:hover {
            background: #3c44b0;
        }
    </style>
</head>
<body>

<%
    AppUser user = (AppUser) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<header>
    <h1>Write a Review</h1>
</header>

<div class="container">
    <h2>Share your experience</h2>
    <form method="post" action="ReviewServlet.do">
        <label for="tutor_name">Tutor's Full Name:</label>
        <input type="text" name="tutor_name" id="tutor_name" placeholder="Enter tutor's name" required>

        <label for="rate">Rating (1-5):</label>
        <select name="rate" id="rate" required>
            <option value="">-- Select Rating --</option>
            <% for (int i = 1; i <= 5; i++) { %>
                <option value="<%= i %>"><%= i %></option>
            <% } %>
        </select>

        <label for="review_comment">Your Comment:</label>
        <textarea name="review_comment" id="review_comment" placeholder="Write your feedback here..." required></textarea>

        <input type="submit" value="Submit Review">
    </form>
        
</div>

</body>
</html>
