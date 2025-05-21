<%@ page import="java.util.*" %>
<%@ page import="za.ac.tut.bl.ViewHistoryServlet.Consultation" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View History</title>
    <!-- (keep your existing styles here) -->
</head>
<body>

<header>
    <h1>View History</h1>
</header>

<div class="container">
    <h2>Consultation History</h2>

    <!-- Filter Form -->
    <form method="get" action="ViewHistoryServlet">
        <label for="filterDate">Filter by date:</label>
        <input type="date" name="filterDate" id="filterDate" value="<%= request.getAttribute("selectedDate") != null ? request.getAttribute("selectedDate") : "" %>" />
        <input type="submit" value="Filter">
    </form>

    <ul>
        <%
            List<Consultation> consultations = (List<Consultation>) request.getAttribute("consultations");
            if (consultations != null && !consultations.isEmpty()) {
                for (Consultation c : consultations) {
        %>
            <li>
                <strong>Date:</strong> <%= c.getDate() %><br>
                <strong>Student:</strong> <%= c.getStudent() %><br>
                <strong>Topic:</strong> <%= c.getTopic() %>
            </li>
        <%
                }
            } else {
        %>
            <li>No consultations found for the selected date.</li>
        <%
            }
        %>
    </ul>

    <a class="back-link" href="tutor_dashboard.jsp">← Back to Dashboard</a>
    
</div>
    <form method="get" action="ExportCSVServlet" style="margin-top:20px;">
    <input type="hidden" name="filterDate" value="<%= request.getAttribute("selectedDate") != null ? request.getAttribute("selectedDate") : "" %>">
    <button type="submit">Export to CSV</button>
</form>


</body>
</html>
