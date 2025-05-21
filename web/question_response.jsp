<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f5f9;
            padding: 50px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            color: #333;
            margin-bottom: 30px;
        }

        form {
            background-color: #fff;
            padding: 20px;
            margin: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            border-radius: 4px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
        }

        input[type="submit"] {
            background-color: #0066cc;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #004d99;
        }
    </style>
</head>
<body>
    <h1>Ask a Question</h1>

    <form action="QuestionUpdateServlet.do" method="POST">
        <label for="question">Type Question:</label>
        <input type="text" name="question" id="question" required />
        <input type="submit" value="Submit Question" />
    </form>

    <p>
        Click <a href="view_responses.jsp">here</a> View and download questions & responses.
    </p>
</body>
</html>
