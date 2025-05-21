<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
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
        }

        header h1 {
            margin: 0;
            font-size: 1.8em;
        }

        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #38a169;
            margin-bottom: 30px;
        }

        .profile-item {
            margin-bottom: 20px;
        }

        .profile-item label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .profile-item span {
            display: block;
            padding: 10px;
            background-color: #f0f0f0;
            border-radius: 6px;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            text-decoration: none;
            color: #38a169;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<header>
    <h1>Your Profile</h1>
</header>
<div class="container">
    <h2>Profile Details</h2>
    <div class="profile-item">
        <label>Name</label>
        <span><%= session.getAttribute("name") != null ? session.getAttribute("name") : "N/A" %></span>
    </div>
    <div class="profile-item">
        <label>Email</label>
        <span><%= session.getAttribute("email") != null ? session.getAttribute("email") : "N/A" %></span>
    </div>
    <div class="profile-item">
        <label>Role</label>
        <span><%= session.getAttribute("role") != null ? session.getAttribute("role") : "N/A" %></span>
    </div>

    <a class="back-link" href="tutor_dashboard.jsp">← Back to Dashboard</a>
</div>
</body>
</html>
