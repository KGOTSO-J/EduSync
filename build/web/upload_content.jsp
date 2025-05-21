<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*, java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<%
    HttpSession sessionObj = request.getSession(false);
    Long userId = (sessionObj != null) ? (Long) sessionObj.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String message = request.getParameter("message");
    String filter = request.getParameter("filter") != null ? request.getParameter("filter").toLowerCase() : "";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage content tutor</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
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
            font-size: 1.6em;
        }

        .container {
            width: 95%;
            max-width: 1100px;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        h2 {
            text-align: center;
            color: #333;
        }
        
        .message {
            margin-top: 20px;
            padding: 10px;
            text-align: center;
            border-radius: 5px;
            background-color: #dff0d8;
            color: #3c763d;
            display: <%= (message != null) ? "block" : "none" %>;
        }
        
        form, table {
            margin-top: 20px;
            width: 100%;
        }
        
        input[type="text"], input[type="file"], textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        
        input[type="submit"], button {
            padding: 8px 15px;
            background-color: #38a169;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 10px;
        }
        
        .delete-btn {
            background-color: #e74c3c;
        }
        
        .delete-btn:hover {
            background-color: #c0392b;
        }
        
        .download-link {
            color: #38a169;
            text-decoration: none;
            font-weight: bold;
        }
        
        table {
            border-collapse: collapse;
        }
        
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }
        
        th {
            background: #38a169;
            color: white;
        }
        
    </style>
</head>
<body>
    <header>
        <h1>Upload Content</h1>
    </header>
    
<div class="container">
    <h2>Upload Academic Content</h2>
    <form action="UploadContentServlet.do" method="post" enctype="multipart/form-data">
        <input type="text" name="title" placeholder="Title" required />
        <textarea name="description" placeholder="Description" required></textarea>
        <input type="text" name="subject" placeholder="Subject" required />
        <input type="file" name="file" required />
        <input type="submit" value="Upload Content" />
    </form>

    <h2>All Uploaded Materials</h2>
    <div class="message"><%= (message != null) ? message : "" %></div>

<form method="get" action="upload_content.jsp" style="display: flex; gap: 15px; align-items: center; margin-bottom: 20px;">
    <input type="text" name="filter" placeholder="Search by Title or Subject" value="<%= filter %>" 
           style="padding: 8px; border-radius: 5px; border: 1px solid #ccc;" />

    <input type="submit" value="Filter" 
           style="padding: 8px 14px; background-color: #38a169; color: white; border: none; border-radius: 5px; cursor: pointer;" />

    <select name="upload_date" 
            style="padding: 8px; border-radius: 5px; border: 1px solid #ccc;">
        <option value="">Sort by Upload Date</option>
        <option value="recent">Most Recent</option>
        <option value="oldest">Oldest</option>
    </select>

    <button type="submit" 
            style="padding: 8px 14px; background-color: #38a169; color: white; border: none; border-radius: 5px; cursor: pointer;">
        Apply
    </button>

    <a href="DownloadUploadServlet.do" 
       style="padding: 8px 14px; background-color: #38a169; color: white; border-radius: 5px; text-decoration: none; font-weight: bold;">
        Download Full Report as CSV
    </a>
</form>



    <table id="materialsTable">
        <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Subject</th>
            <th>Upload Date</th>
            <th>File</th>
            <th>Action</th>
        </tr>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://172.20.10.3:3306/edusync_db", "kgj", "kgotso");

                String query = "SELECT * FROM academic_content ORDER BY upload_date DESC";
                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                while (rs.next()) {
                    int contentId = rs.getInt("contentid");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String subject = rs.getString("subject");
                    Timestamp uploadDate = rs.getTimestamp("upload_date");
                    String fileName = rs.getString("file_name");
                    String contentUrl = rs.getString("contenturl");
                    int ownerId = rs.getInt("userid");

                    boolean show = filter.isEmpty() ||
                                   title.toLowerCase().contains(filter) ||
                                   subject.toLowerCase().contains(filter);

                    if (show) {
        %>
        <tr>
            <td><%= title %></td>
            <td><%= description %></td>
            <td><%= subject %></td>
            <td><%= formatter.format(uploadDate) %></td>
            <td><a class="download-link" href="<%= contentUrl %>" target="_blank"><%= fileName %></a></td>
            <td>
                <% if (ownerId == userId) { %>
                    <form method="POST" action="DeleteContentServlet.do" style="display:inline;">
                        <input type="hidden" name="contentId" value="<%= contentId %>" />
                        <input type="hidden" name="filePath" value="<%= contentUrl %>" />
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                <% } else { %> - <% } %>
            </td>
        </tr>
        <%
                    }
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </table>
</div>
</body>
</html>
