<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Calendar"%>
<%@page import="za.ac.tut.entities.AppUser"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fetch Report </title>
        <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 20px;
        }
        table {
            border-collapse: collapse;
            width: 90%;
            margin: auto;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 12px;
        }
        th {
            background: #4e54c8;
            color: white;
        }
        .export-buttons {
            text-align: center;
            margin: 20px;
        }
        .export-buttons a {
            margin: 0 10px;
            padding: 10px 15px;
            background-color: #4e54c8;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        </style>
    </head>
        <%
            String status = request.getParameter("status");
            if ("success".equals(status)) {
        %>
            <p style="color:green;text-align:center;">Your consultation has been successfully booked.</p>
        <%
            } else if ("error".equals(status)) {
        %>
            <p style="color:red;text-align:center;">There was an error booking your consultation.</p>
        <%
            }
        %>
<body>
    <%
        AppUser user = (AppUser) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String url = "jdbc:mysql://172.20.10.3:3306/edusync_db";
        String dbUser = "kgj";
        String dbPass = "kgotso";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String filterDate = request.getParameter("filter_date");
        String filterReason = request.getParameter("filter_reason");

        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        int year = cal.get(Calendar.YEAR);
    %>

    <h2 style="text-align:center;">Your Consultations - <%= new java.text.DateFormatSymbols().getMonths()[month-1] + " " + year %></h2>

    <form method="get" action="fetch_report.jsp" style="text-align:center; margin-bottom: 20px;">
        <label for="filter_date">Filter by Date:</label>
        <input type="date" name="filter_date" value="<%= filterDate != null ? filterDate : "" %>"/>
        &nbsp;&nbsp;
        <label for="filter_reason">Filter by Reason:</label>
        <input type="text" name="filter_reason" value="<%= filterReason != null ? filterReason : "" %>"/>
        &nbsp;&nbsp;
        <input type="submit" value="Apply Filter"/>
    </form>

    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, dbUser, dbPass);

            StringBuilder sql = new StringBuilder("SELECT booking_date, time_slot, reason FROM tutorial_booking WHERE userid = ? AND MONTH(booking_date) = ? AND YEAR(booking_date) = ?");
            if (filterDate != null && !filterDate.isEmpty()) {
                sql.append(" AND booking_date = ?");
            }
            if (filterReason != null && !filterReason.isEmpty()) {
                sql.append(" AND reason LIKE ?");
            }

            ps = conn.prepareStatement(sql.toString());
            int i = 1;
            ps.setLong(i++, user.getUserId());
            ps.setInt(i++, month);
            ps.setInt(i++, year);
            if (filterDate != null && !filterDate.isEmpty()) {
                ps.setDate(i++, java.sql.Date.valueOf(filterDate));
            }
            if (filterReason != null && !filterReason.isEmpty()) {
                ps.setString(i++, "%" + filterReason + "%");
            }

            rs = ps.executeQuery();
    %>

    <table>
        <tr>
            <th>Date</th>
            <th>Time Slot</th>
            <th>Reason</th>
        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getDate("booking_date") %></td>
            <td><%= rs.getString("time_slot") %></td>
            <td><%= rs.getString("reason") %></td>
        </tr>
        <% } %>
    </table>

    <div class="export-buttons">
        <form method="get" action="ExportReportServlet">
            <input type="hidden" name="format" value="csv"/>
            <input type="hidden" name="filter_date" value="<%= filterDate != null ? filterDate : "" %>"/>
            <input type="hidden" name="filter_reason" value="<%= filterReason != null ? filterReason : "" %>"/>
            <input type="submit" value="Export Filtered Report to CSV"/>
        </form>
    </div>

    <%
        } catch(Exception e) {
            out.println("<p style='color:red;text-align:center;'>Error fetching report.</p>");
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        }
    %>
</body>

</html>
