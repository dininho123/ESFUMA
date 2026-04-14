<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/includes/db.jsp" %>
<%@ page import="java.security.MessageDigest" %>
<%!
    String sha256(String input) throws Exception {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(input.getBytes("UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (byte b : hash) sb.append(String.format("%02x", b));
        return sb.toString();
    }
%>
<%
    // Se já está logado, vai direto para o painel
    if (session.getAttribute("adminLogado") != null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String erro = null;

    if ("POST".equals(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            String hashPassword = sha256(password);

            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT id FROM utilizadores WHERE username = ? AND password = ?"
            );
            ps.setString(1, username);
            ps.setString(2, hashPassword);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("adminLogado", true);
                session.setAttribute("adminUser", username);
                rs.close(); ps.close(); conn.close();
                response.sendRedirect("index.jsp");
                return;
            } else {
                erro = "Utilizador ou password incorretos.";
            }

            rs.close(); ps.close(); conn.close();
        }
    }
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ESFUMA — Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="icon" type="image/png" href="../img/logo_escola_1.png">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #1e8449, #145a32);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-box {
            background: white;
            padding: 50px 40px;
            border-radius: 16px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.25);
            width: 100%;
            max-width: 380px;
            text-align: center;
        }

        .login-box img {
            height: 80px;
            margin-bottom: 10px;
        }

        .login-box h1 {
            font-size: 15px;
            font-weight: 600;
            color: #555;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-group {
            margin-bottom: 16px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-size: 12px;
            font-weight: 600;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 6px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 14px;
            border: 1.5px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            font-family: 'Poppins', sans-serif;
            transition: border-color 0.2s;
            outline: none;
        }

        .form-group input:focus {
            border-color: #27ae60;
        }

        .erro {
            background: #fef2f2;
            border: 1px solid #fca5a5;
            color: #dc2626;
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 13px;
            margin-bottom: 16px;
        }

        .btn-login {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #27ae60, #1e8449);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            cursor: pointer;
            transition: opacity 0.2s, transform 0.2s;
            margin-top: 8px;
        }

        .btn-login:hover {
            opacity: 0.92;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<div class="login-box">
    <img src="../img/logo_escola_1.png" alt="ESFUMA">
    <h1>Painel de Administração</h1>

    <% if (erro != null) { %>
        <div class="erro"><%= erro %></div>
    <% } %>

    <form method="POST" action="login.jsp">
        <div class="form-group">
            <label>Utilizador</label>
            <input type="text" name="username" autocomplete="username" required autofocus>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" autocomplete="current-password" required>
        </div>
        <button type="submit" class="btn-login">Entrar</button>
    </form>
</div>

</body>
</html>
