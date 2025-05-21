<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View History</title>
    <style>
        body { margin:0; font-family:'Segoe UI',sans-serif; background:#f5f7fa; color:#333; }
        header { background:#38a169; color:white; padding:20px 40px; display:flex; justify-content:space-between; align-items:center; }
        header h1 { margin:0; font-size:1.8em; }
        .container { max-width:600px; margin:50px auto; padding:30px; background:white; border-radius:12px; box-shadow:0 8px 16px rgba(0,0,0,0.1); }
        h2 { text-align:center; color:#38a169; margin-bottom:30px; }
        ul { list-style:none; padding:0; }
        li { margin-bottom:15px; padding:10px; border:1px solid #ddd; border-radius:6px; background:#f9f9f9; }
        .back-link { display:block; text-align:center; margin-top:20px; text-decoration:none; color:#38a169; font-weight:bold; }
        .back-link:hover { text-decoration:underline; }
    </style>
</head>
<body>

<header>
    <h1>View History</h1>
</header>

<div class="container">
    <h2>Consultation History</h2>

    <ul>
        <li><strong>Date:</strong> 2025-04-20<br><strong>Student:</strong> Alice Smith<br><strong>Topic:</strong> Linked Lists</li>
        <li><strong>Date:</strong> 2025-04-25<br><strong>Student:</strong> Bob Johnson<br><strong>Topic:</strong> Recursion</li>
    </ul>

    <a class="back-link" href="tutor_dashboard.jsp">← Back to Dashboard</a>
</div>

</body>
</html>
