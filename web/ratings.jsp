<%-- 
    Document   : ratings
    Created on : 07 May 2025, 6:57:00 PM
    Author     : jonas
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, za.ac.tut.db.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Ratings - EduSync</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
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
            max-width: 700px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        form {
            margin-top: 20px;
        }
        input[type="text"], select {
            padding: 10px;
            margin: 10px 5px 10px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 1em;
        }
        input[type="submit"] {
            background-color: #4e54c8;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1em;
            border-radius: 6px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #3b40a4;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4e54c8;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .no-data {
            text-align: center;
            color: #666;
            margin-top: 20px;
        }
    </style>
    <script>
        // Function to trigger CSV download after table display
        function triggerCsvDownload(tutorName, rate) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'GenerateReviewReportServlet.do';
            if (tutorName) {
                const tutorInput = document.createElement('input');
                tutorInput.type = 'hidden';
                tutorInput.name = 'tutor_name';
                tutorInput.value = tutorName;
                form.appendChild(tutorInput);
            }
            if (rate) {
                const rateInput = document.createElement('input');
                rateInput.type = 'hidden';
                rateInput.name = 'rate';
                rateInput.value = rate;
                form.appendChild(rateInput);
            }
            document.body.appendChild(form);
            form.submit();
            document.body.removeChild(form);
        }
    </script>
</head>
<body>
    <header>
        <h1>EduSync - Student Ratings</h1>
    </header>
    <div class="container">
        <h2>View and Generate Review Report</h2>
        <form method="post" action="ratings.jsp" onsubmit="setTimeout(() => triggerCsvDownload(this.tutor_name.value, this.rate.value), 0);">
            <label for="tutor_name">Tutor Name:</label>
            <input type="text" name="tutor_name" id="tutor_name" placeholder="Enter tutor name" value="<%= request.getParameter("tutor_name") != null ? request.getParameter("tutor_name") : "" %>" />
            <label for="rate">Rating:</label>
            <select name="rate" id="rate">
                <option value="">-- Select Rating --</option>
                <option value="5" <%= "5".equals(request.getParameter("rate")) ? "selected" : "" %>>5 - Excellent</option>
                <option value="4" <%= "4".equals(request.getParameter("rate")) ? "selected" : "" %>>4 - Good</option>
                <option value="3" <%= "3".equals(request.getParameter("rate")) ? "selected" : "" %>>3 - Average</option>
                <option value="2" <%= "2".equals(request.getParameter("rate")) ? "selected" : "" %>>2 - Poor</option>
                <option value="1" <%= "1".equals(request.getParameter("rate")) ? "selected" : "" %>>1 - Bad</option>
            </select>
            <input type="submit" value="Generate Review Report" />
        </form>

        <%
            String tutorName = request.getParameter("tutor_name");
            String rateStr = request.getParameter("rate");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            boolean hasData = false;

            if (request.getMethod().equalsIgnoreCase("POST")) {
                try {
                    conn = DBConnection.getConnection();
                    StringBuilder sql = new StringBuilder("SELECT tutor_name, rate, student_comment FROM ratings WHERE 1=1");

                    if (tutorName != null && !tutorName.trim().isEmpty()) {
                        sql.append(" AND tutor_name LIKE ?");
                    }
                    if (rateStr != null && !rateStr.trim().isEmpty()) {
                        try {
                            Integer.parseInt(rateStr);
                            sql.append(" AND rate = ?");
                        } catch (NumberFormatException e) {
                            out.println("<p class='no-data'>Invalid rating value.</p>");
                            return;
                        }
                    }

                    ps = conn.prepareStatement(sql.toString());
                    int paramIndex = 1;
                    if (tutorName != null && !tutorName.trim().isEmpty()) {
                        ps.setString(paramIndex++, "%" + tutorName.trim() + "%");
                    }
                    if (rateStr != null && !rateStr.trim().isEmpty()) {
                        ps.setInt(paramIndex++, Integer.parseInt(rateStr));
                    }

                    rs = ps.executeQuery();
        %>

        <table>
            <thead>
                <tr>
                    <th>Tutor Name</th>
                    <th>Rating</th>
                    <th>Comment</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        hasData = true;
                        String name = rs.getString("tutor_name");
                        int rate = rs.getInt("rate");
                        String comment = rs.getString("student_comment");
                %>
                <tr>
                    <td><%= name != null ? name : "" %></td>
                    <td><%= rate %></td>
                    <td><%= comment != null ? comment : "" %></td>
                </tr>
                <%
                    }
                    rs.close();
                %>
            </tbody>
        </table>
        <%
            if (!hasData) {
                out.println("<p class='no-data'>No reviews found for the specified criteria.</p>");
            }
                } catch (SQLException e) {
                    out.println("<p class='no-data'>Database error occurred.</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                    try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                    try { if (conn != null) conn.close(); } catch (Exception ignored) {}
                }
            }
        %>
    </div>
</body>
</html>
