<%@page import="java.sql.*, za.ac.tut.db.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String questionText = "";
    int questionId = -1;
    int studentId = -1;

    try {
        Connection conn = DBConnection.getConnection();
        String sql = "SELECT id, userid, question_text FROM question WHERE id NOT IN (SELECT questionid FROM answer) LIMIT 1";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            questionId = rs.getInt("id");
            studentId = rs.getInt("userid");
            questionText = rs.getString("question_text");
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Answer Questions</title>
    <style>
        body { margin:0; font-family:'Segoe UI',sans-serif; background:#f5f7fa; color:#333; }
        header { background:#38a169; color:white; padding:20px 40px; display:flex; justify-content:space-between; align-items:center; }
        header h1 { margin:0; font-size:1.8em; }
        .container { max-width:600px; margin:50px auto; padding:30px; background:white; border-radius:12px; box-shadow:0 8px 16px rgba(0,0,0,0.1); }
        h2 { text-align:center; color:#38a169; margin-bottom:30px; }
        label { font-weight:bold; margin-bottom:8px; margin-top:20px; }
        textarea { padding:12px; border:1px solid #ccc; border-radius:6px; font-size:1em; resize:vertical; width:100%; }
        button { margin-top:30px; padding:12px; background-color:#38a169; color:white; font-size:1em; border:none; border-radius:6px; cursor:pointer; }
        button:hover { background-color:#2f855a; }
        .back-link { display:block; text-align:center; margin-top:20px; text-decoration:none; color:#38a169; font-weight:bold; }
        .back-link:hover { text-decoration:underline; }
    </style>
</head>
<body>

<header>
    <h1>Answer Student Questions</h1>
</header>

<div class="container">
    <h2>Respond to a Question</h2>

    <% if (questionId != -1) { %>
        <form action="AnswerUpdateServlet.do" method="post">
            <label>Question from Student (UserID: <%= studentId %>):</label>
            <p><%= questionText %></p>

            <label for="answer">Your Answer:</label>
            <textarea id="answer" name="answer" rows="5" required></textarea>

            <!-- Pass the question ID to the servlet -->
            <input type="hidden" name="questionid" value="<%= questionId %>" />

            <button type="submit">Submit Answer</button>
        </form>
    <% } else { %>
        <p>No unanswered questions at the moment.</p>
    <% } %>

    <a class="back-link" href="tutor_dashboard.jsp">← Back to Dashboard</a>
</div>

</body>
</html>
