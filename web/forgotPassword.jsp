<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>EduSync - Forgot Password</title>
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
            background-color: #ffffff;
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

        p {
            text-align: center;
            color: #555;
            font-size: 0.95em;
            margin-bottom: 20px;
        }

        label {
            margin-bottom: 6px;
            color: #333;
            font-weight: bold;
        }

        input[type="email"] {
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
    <h2>Forgot Your Password?</h2>
    <p>Enter your email address and we’ll send you instructions to reset your password.</p>
    <form action="ForgotPasswordServlet.do" method="post">
        <label for="email">Email Address:</label>
        <input type="email" name="email" id="email" required />
        <button type="submit">Send Reset Link</button>
    </form>
    <div class="back-link">
        <p><a href="login.jsp">Back to Login</a></p>
    </div>
</div>
</body>
</html>
