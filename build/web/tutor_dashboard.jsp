<%@page import="za.ac.tut.entities.AppUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>EduSync - Tutor Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f5f7fa;
            color: #333;
        }

        header {
            background: #38a169;
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
            background-color: #38a169;
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
            width: 240px;
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
            color: #38a169;
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
            background: #38a169;
            color: white;
            padding: 10px 15px;
            border-radius: 6px;
            transition: background 0.3s;
        }

        .card a:hover {
            background: #2f855a;
        }

        .chat-button {
            position: fixed;
            bottom: 25px;
            right: 25px;
            background-color: #38a169;
            color: white;
            padding: 15px 20px;
            border-radius: 50px;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            text-decoration: none;
            transition: transform 0.3s, background 0.3s;
        }

        .chat-button:hover {
            background-color: #2f855a;
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
    <h1>Welcome Aboard, Teaching Partner</h1>
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
        <h3>Upload Content</h3>
        <p>Share study materials, presentations, or videos to support your students.</p>
        <a href="upload_content.jsp">Upload Now</a>
    </div>

    <div class="card">
        <h3>Confirm Bookings</h3>
        <p>View and approve consultation requests submitted by students.</p>
        <a href="confirm_bookings.jsp">View Bookings</a>
    </div>

    <div class="card">
        <h3>Answer Questions</h3>
        <p>Respond to students' questions to help them better understand the material.</p>
        <a href="answer_questions.jsp">Answer Now</a>
    </div>

    <div class="card">
        <h3>View History</h3>
        <p>Review previous sessions and materials you’ve shared with students.</p>
        <a href="view_history.jsp">View History</a>
    </div>

    <div class="card">
        <h3>Student Ratings</h3>
        <p>See feedback and ratings from students to improve your teaching impact.</p>
        <a href="ratings.jsp">View Ratings</a>
    </div>
</div>

<a href="chat.jsp" class="chat-button">Chat with EduBot</a>

</body>
</html>
