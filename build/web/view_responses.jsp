<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="za.ac.tut.db.DBConnection" %>
<%
    request.setCharacterEncoding("UTF-8");
    String error = "";
    String success = "";

    // Handle question submission
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("question") != null) {
        String questionText = request.getParameter("question");
        String userIdStr = request.getParameter("student_id");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("INSERT INTO question (question_text, userid) VALUES (?, ?)")) {
            ps.setString(1, questionText);
            ps.setInt(2, Integer.parseInt(userIdStr));
            ps.executeUpdate();
            success = "Question submitted successfully.";
        } catch (Exception e) {
            error = "Failed to submit question: " + e.getMessage();
        }
    }

    // Handle question deletion
    if (request.getParameter("delete_question_id") != null) {
        int questionId = Integer.parseInt(request.getParameter("delete_question_id"));
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM question WHERE questionid = ?")) {
            ps.setInt(1, questionId);
            ps.executeUpdate();
            success = "Question deleted successfully.";
        } catch (Exception e) {
            error = "Failed to delete question: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Answered Questions</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f5f7fa; color: #333; margin: 0; }
        header { background: #2b6cb0; color: white; padding: 20px 40px; }
        header h1 { margin: 0; font-size: 1.8em; }
        .container { max-width: 900px; margin: 40px auto; padding: 20px; background: white; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px 15px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #2b6cb0; color: white; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .button { padding: 8px 12px; background-color: #e53e3e; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .button:hover { background-color: #c53030; }
        .form-group { margin-bottom: 15px; }
        .form-control { width: 100%; padding: 10px; margin-top: 5px; }
        .submit-btn { background-color: #2b6cb0; color: white; border: none; padding: 10px 15px; border-radius: 5px; }
    </style>
</head>
<body>

<header>
    <h1>Answered Questions</h1>
</header>

<div class="container">
    <form action="view_responses.jsp" method="post">
        <div class="form-group">
            <label for="student_id">Your Student ID:</label>
            <input type="text" name="student_id" class="form-control" required />
        </div>
        <div class="form-group">
            <label for="question">Ask a Question:</label>
            <textarea name="question" class="form-control" rows="3" required></textarea>
        </div>
        <button type="submit" class="submit-btn">Submit Question</button>
    </form>

    <% if (!success.isEmpty()) { %>
        <p style="color:green;"><%= success %></p>
    <% } %>
    <% if (!error.isEmpty()) { %>
        <p style="color:red;"><%= error %></p>
    <% } %>

    <form action="DownloadCSVServlet.do" method="post">
        <button type="submit" class="submit-btn" style="margin-top:20px;">Download as CSV</button>
    </form>

    <table>
        <tr>
            <th>Question</th>
            <th>Student ID</th>
            <th>Answer</th>
            <th>Tutor ID</th>
            <th>Answered On</th>
            <th>Delete</th>
        </tr>

        <%
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                     "SELECT q.questionid, q.question_text, q.userid AS studentid, " +
                     "a.answer_text, a.tutorid, a.answer_date " +
                     "FROM question q " +
                     "LEFT JOIN answer a ON q.questionid = a.questionid " +
                     "ORDER BY q.questionid DESC");
                 ResultSet rs = stmt.executeQuery()) {

                while (rs.next()) {
                    int qid = rs.getInt("questionid");
                    String question = rs.getString("question_text");
                    int studentId = rs.getInt("studentid");
                    String answer = rs.getString("answer_text");
                    int tutorId = rs.getInt("tutorid");
                    Timestamp date = rs.getTimestamp("answer_date");
        %>
        <tr>
            <td><%= question %></td>
            <td><%= studentId %></td>
            <td><%= (answer != null ? answer : "Awaiting response") %></td>
            <td><%= (answer != null ? tutorId : "-") %></td>
            <td><%= (date != null ? date.toString() : "-") %></td>
            <td>
                <form method="post" action="view_responses.jsp" style="margin:0;">
                    <input type="hidden" name="delete_question_id" value="<%= qid %>" />
                    <button type="submit" class="button" onclick="return confirm('Are you sure you want to delete this question?');">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</div>

</body>
</html>
