<%@page import="java.sql.*"%>
<%@page import="za.ac.tut.entities.AppUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Report Outcome</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; padding: 20px; }
        h2 { text-align: center; color: #333; }
        table { border-collapse: collapse; width: 90%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background: #4e54c8; color: white; }
        .filter-form { text-align: center; margin: 20px; }
        .download-link { text-align: center; margin-top: 10px; }
        .download-link a { padding: 10px 15px; background-color: #4e54c8; color: white; text-decoration: none; border-radius: 5px; }
    </style>
</head>
<body>

<%
    AppUser user = (AppUser) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String filterStatus = request.getParameter("status");
    if (filterStatus == null) {
        filterStatus = "Confirmed";
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    String url = "jdbc:mysql://172.20.10.3:3306/edusync_db";
    String dbUser = "kgj";
    String dbPass = "kgotso";
%>

<h2>Filtered Bookings: <%= filterStatus %></h2>

<div class="filter-form">
    <form method="get" action="booking_report_outcome_page.jsp">
        <label for="status">Filter by Status:</label>
        <select name="status" id="status">
            <option value="Confirmed" <%= "Confirmed".equals(filterStatus) ? "selected" : "" %>>Confirmed</option>
            <option value="Rejected" <%= "Rejected".equals(filterStatus) ? "selected" : "" %>>Rejected</option>
        </select>
        <input type="submit" value="Filter" />
    </form>
</div>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPass);

        String sql = "SELECT booking_id, student_name, booking_date, booking_time FROM confirmBookingsTBL WHERE status = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, filterStatus);
        rs = ps.executeQuery();
%>

<table>
    <tr>
        <th>ID</th>
        <th>Student Name</th>
        <th>Date</th>
        <th>Time</th>
    </tr>
    <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getInt("booking_id") %></td>
            <td><%= rs.getString("student_name") %></td>
            <td><%= rs.getDate("booking_date") %></td>
            <td><%= rs.getString("booking_time") %></td>
        </tr>
    <% } %>
</table>

<div class="download-link">
    <a href="DownloadFilteredReportServlet?status=<%= filterStatus %>">Download CSV</a>
</div>

<%
    } catch (Exception e) {
        out.println("<p style='color:red;text-align:center;'>Error fetching filtered bookings</p>");
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

</body>
</html>
