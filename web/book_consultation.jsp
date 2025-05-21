<%@page import="za.ac.tut.entities.AppUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Consultation - EduSync</title>
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
        }

        header h1 {
            margin: 0;
            font-size: 1.6em;
        }

        .container {
            max-width: 600px;
            background: white;
            margin: 40px auto;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        .container h2 {
            text-align: center;
            color: #4e54c8;
            margin-bottom: 25px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin: 10px 0 5px;
            font-weight: bold;
        }

        input[type="date"],
        select,
        textarea,
        input[type="submit"] {
            padding: 12px;
            font-size: 1em;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        textarea {
            resize: vertical;
        }

        input[type="submit"] {
            background-color: #4e54c8;
            color: white;
            border: none;
            margin-top: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        input[type="submit"]:hover {
            background-color: #3c44b0;
            transform: translateY(-2px);
        }

        .success-message {
            text-align: center;
            color: green;
            margin-top: 20px;
        }

        .error-message {
            text-align: center;
            color: red;
            margin-top: 20px;
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
    <h1>Book a Consultation</h1>
</header>

<div class="container">
    <h2>Hello, <%= user.getFirstName() %>! Let's schedule your session.</h2>
    <form action="BookConsultationServlet.do" method="post">
        <label for="booking_date">Booking Date:</label>
        <input type="date" id="booking_date" name="booking_date" required>

        <label for="time_slot">Time Slot:</label>
        <select id="time_slot" name="time_slot" required>
            <option value="">--Select a Time--</option>
            <option value="08:00 - 09:00">08:00 - 09:00</option>
            <option value="09:00 - 10:00">09:00 - 10:00</option>
            <option value="10:00 - 11:00">10:00 - 11:00</option>
            <option value="11:00 - 12:00">11:00 - 12:00</option>
            <option value="13:00 - 14:00">13:00 - 14:00</option>
            <option value="14:00 - 15:00">14:00 - 15:00</option>
            <option value="15:00 - 16:00">15:00 - 16:00</option>
        </select>

        <label for="reason">Reason for Consultation:</label>
        <textarea id="reason" name="reason" rows="4" maxlength="100" placeholder="Briefly describe your issue..." required></textarea>

        <input type="submit" value="Book Consultation">
    </form>

    <% 
        String status = request.getParameter("status");
        if ("success".equals(status)) {
    %>
        <div class="success-message">Your consultation has been successfully booked!</div>
    <% } else if ("error".equals(status)) { %>
        <div class="error-message">Something went wrong. Please try again later.</div>
    <% } %>
</div>

</body>
</html>