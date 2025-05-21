<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>EduSync - Sign Up</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #667eea, #764ba2);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 15px;
            width: 400px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            animation: slideIn 0.6s ease-out;
        }

        h2 {
            text-align: center;
            color: #4e54c8;
            margin-bottom: 25px;
            font-size: 1.8em;
        }

        label {
            margin-bottom: 6px;
            color: #333;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #4e54c8;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        button:hover {
            background-color: #3b44b4;
            transform: scale(1.03);
        }

        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .link-container {
            text-align: center;
            margin-top: 15px;
        }

        .link-container a {
            color: #4e54c8;
            text-decoration: none;
            font-weight: bold;
        }

        .link-container a:hover {
            text-decoration: underline;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #4e54c8;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 480px) {
            .container {
                width: 90%;
                padding: 25px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Create Your EduSync Account</h2>

    <% if (request.getParameter("error") != null) { %>
        <div class="error-message">
            <% if ("exists".equals(request.getParameter("error"))) { %>
                User already exists.
            <% } else if ("failed".equals(request.getParameter("error"))) { %>
                Failed to create account.
            <% } else { %>
                An unexpected error occurred.
            <% } %>
        </div>
    <% } %>

    <form action="SignupServlet.do" method="post">
        <label for="first_name">First Name:</label>
        <input type="text" name="first_name" id="first_name" required />

        <label for="last_name">Last Name:</label>
        <input type="text" name="last_name" id="last_name" required />

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required />

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required />

        <label for="role">Register As:</label>
        <select name="role" id="role" required>
            <option value="student">Student</option>
            <option value="tutor">Tutor</option>
        </select>

        <button type="submit">Sign Up</button>
    </form>

    <div class="back-link">
        <p><a href="index.html"> ← Go Back </a></p>
    </div>

    <div class="link-container">
        Already have an account? <a href="login.jsp">Log in</a>
    </div>
</div>
</body>
</html>
