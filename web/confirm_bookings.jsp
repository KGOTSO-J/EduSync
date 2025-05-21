<%@page import="java.sql.*, java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Bookings</title>
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
        .booking-item {
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }
        button {
            margin-top: 15px;
            padding: 12px;
            background-color: #38a169;
            color: white;
            font-size: 1em;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2f855a;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
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
        <h1>Confirm Bookings</h1>
    </header>
    <div class="container">
        <h2>Pending Consultations</h2>

        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://172.20.10.3:3306/edusync_db", "kgj", "kgotso");
                ps = con.prepareStatement("SELECT booking_id, student_name, booking_date, time_slot FROM bookings WHERE status = 'Pending'");
                rs = ps.executeQuery();
                while (rs.next()) {
                    int bookingId = rs.getInt("booking_id");
                    String studentName = rs.getString("student_name");
                    String bookingDate = rs.getString("booking_date");
                    String bookingTime = rs.getString("time_slot");
        %>
            <div class="booking-item">
                <p><strong>Student:</strong> <%= studentName %></p>
                <p><strong>Date:</strong> <%= bookingDate %></p>
                <p><strong>Time:</strong> <%= bookingTime %></p>

                <form action="ConfirmBookingServlet" method="post" style="display:inline;">
                    <input type="hidden" name="bookingId" value="<%= bookingId %>" />
                    <input type="hidden" name="action" value="confirm" />
                    <button type="submit">Confirm</button>
                </form>

                <form action="ConfirmBookingServlet.do" method="post" style="display:inline;">
                    <input type="hidden" name="bookingId" value="<%= bookingId %>" />
                    <input type="hidden" name="action" value="reject" />
                    <button type="submit" style="background-color: #e53e3e;">Reject</button>
                </form>
            </div>
        <%
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            }
        %>

        <a class="back-link" href="tutor_dashboard.jsp">← Back to Dashboard</a>
    </div>
</body>
</html>
