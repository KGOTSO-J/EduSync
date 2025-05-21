<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>EduSync - Login</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #667eea, #764ba2);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }

        .login-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 15px;
            width: 350px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 0.6s ease-out;
        }

        .login-container h2 {
            text-align: center;
            color: #4e54c8;
            margin-bottom: 25px;
            font-size: 1.8em;
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1em;
        }

        .login-container input[type="submit"] {
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

        .login-container input[type="submit"]:hover {
            background-color: #3b44b4;
            transform: translateY(-2px);
        }

        .forgot-password,
        .create-account {
            display: inline-block;
            text-align: center;
            font-size: 0.9em;
            width: 100%;
            margin-top: 10px;
        }

        .forgot-password a,
        .create-account a {
            color: #4e54c8;
            text-decoration: none;
            transition: color 0.3s;
        }

        .forgot-password a:hover,
        .create-account a:hover {
            color: #2d34a3;
        }

        .or-separator {
            text-align: center;
            margin: 10px 0;
            font-size: 0.9em;
            color: #999;
            position: relative;
        }

        .or-separator::before,
        .or-separator::after {
            content: "";
            display: inline-block;
            width: 40%;
            height: 1px;
            background-color: #ccc;
            vertical-align: middle;
            margin: 0 5px;
        }

        .go-back {
            text-align: center;
            margin-top: 20px;
        }

        .go-back a {
            color: #4e54c8;
            text-decoration: none;
            font-weight: bold;
        }

        .go-back a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 15px;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .popup {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #4BB543;
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            z-index: 999;
            opacity: 0;
            animation: slideIn 0.5s forwards, fadeOut 0.5s 3s forwards;
        }

        @keyframes slideIn {
            to {
                opacity: 1;
                transform: translateY(0);
            }
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
        }

        @keyframes fadeOut {
            to {
                opacity: 0;
                transform: translateY(-20px);
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>EduSync Login</h2>
        <form action="LoginServlet.do" method="post">
            <input type="text" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>

        <div class="forgot-password">
            <a href="forgotPassword.jsp">Forgot Password?</a>
        </div>

        <div class="or-separator">or</div>

        <div class="create-account">
            <a href="signup.jsp">Create Account</a>
        </div>

        <div class="go-back">
            <p><a href="index.html">← Go Back</a></p>
        </div>

        <% if (request.getParameter("error") != null) { %>
            <div class="error-message">
                <%
                    String error = request.getParameter("error");
                    if ("invalidemail".equals(error)) {
                %>
                    No account found with that email.
                <% } else if ("invalidpassword".equals(error)) { %>
                    Incorrect password. Please try again.
                <% } else if ("unknownrole".equals(error)) { %>
                    Your account role is not recognized.
                <% } else { %>
                    An unexpected error occurred.
                <% } %>
            </div>
        <% } %>
    </div>

    <% if ("true".equals(request.getParameter("success"))) { %>
        <div class="popup">✅ Login Successful! Redirecting...</div>
        <script>
            setTimeout(() => {
                window.location.href = "index.html";
            }, 3500);
        </script>
    <% } %>
</body>
</html>
