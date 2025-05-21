<%@page import="za.ac.tut.entities.AppUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>EduSync - Student Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f8;
            color: #333;
        }

        header {
            background: #4e54c8;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
        }

        header h1 {
            margin: 0;
            font-size: 1.8em;
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropbtn {
            background-color: #4e54c8;
            color: white;
            padding: 10px;
            font-size: 14px;
            border: none;
            cursor: pointer;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            min-width: 160px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 6px;
        }

        .dropdown-content a {
            color: #333;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dashboard {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin: 40px auto;
            max-width: 1000px;
            gap: 20px;
        }

        .card {
            background: white;
            width: 220px;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.15);
        }

        .card h3 {
            color: #4e54c8;
            margin-bottom: 10px;
        }

        .card p {
            font-size: 0.9em;
            color: #555;
        }

        .card a {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            background: #4e54c8;
            color: white;
            padding: 10px 15px;
            border-radius: 6px;
            transition: background 0.3s;
        }

        .card a:hover {
            background: #3c44b0;
        }

        .chat-button {
            position: fixed;
            bottom: 25px;
            right: 25px;
            background-color: #4e54c8;
            color: white;
            padding: 15px 20px;
            border-radius: 50px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            text-decoration: none;
            transition: transform 0.3s, background 0.3s;
        }

        .chat-button:hover {
            background-color: #3c44b0;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .dashboard {
                flex-direction: column;
                align-items: center;
            }
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
    <h1>Welcome Aboard, Student</h1>
    <div class="dropdown">
        <button class="dropbtn">☰</button>
        <div class="dropdown-content">
            <a href="profile.jsp">Profile</a>
            <a href="notifications.jsp">Notifications</a>
            <a href="settings.jsp">Settings</a>
            <a href="index.html">Logout</a>
        </div>
    </div>
</header>

<div class="dashboard">
    <div class="card">
        <h3>Book Consultation</h3>
        <p>Schedule a session with a tutor to get personalized guidance on your modules.</p>
        <a href="book_consultation.jsp">Book Now</a>
    </div>

    <div class="card">
        <h3>Uploaded Materials</h3>
        <p>Browse and download study resources uploaded by tutors and students.</p>
        <a href="view_materials.jsp">View Materials</a>
    </div>

    <div class="card">
        <h3>Leave a Review</h3>
        <p>Share your feedback about a session or your experience with a tutor.</p>
        <a href="review.jsp">Write Review</a>
    </div>

    <div class="card">
        <h3>View History</h3>
        <p>Check your past consultations and academic activity log.</p>
        <a href="history.jsp">See History</a>
    </div>

    <div class="card">
        <h3>Questions & Responses</h3>
        <p>Raise any questions and get responses from tutors.</p>
        <a href="question_response.jsp">Ask</a>
    </div>
</div>

<a href="chat.jsp" class="chat-button">Chat with EduBot</a>

</body>
</html>
