<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="auth.jsp" %>
<%@ include file="/includes/db.jsp" %>
<%
    // Contagens para o dashboard
    Connection conn = getConnection();

    ResultSet rs;
    PreparedStatement ps;

    ps = conn.prepareStatement("SELECT COUNT(*) FROM escaloes WHERE ativo = 1");
    rs = ps.executeQuery(); rs.next();
    int totalEscaloes = rs.getInt(1);
    rs.close(); ps.close();

    ps = conn.prepareStatement("SELECT COUNT(*) FROM treinadores");
    rs = ps.executeQuery(); rs.next();
    int totalTreinadores = rs.getInt(1);
    rs.close(); ps.close();

    ps = conn.prepareStatement("SELECT COUNT(*) FROM treinos");
    rs = ps.executeQuery(); rs.next();
    int totalTreinos = rs.getInt(1);
    rs.close(); ps.close();

    conn.close();

    String adminUser = (String) session.getAttribute("adminUser");
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ESFUMA — Painel Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="icon" type="image/png" href="../img/logo_escola_1.png">
    <link rel="stylesheet" href="admin.css">
</head>
<body>

<%@ include file="sidebar.jsp" %>

<main class="main-content">
    <div class="page-header">
        <h2>Dashboard</h2>
        <p>Bem-vindo, <strong><%= adminUser %></strong></p>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-layer-group"></i></div>
            <div class="stat-info">
                <span class="stat-num"><%= totalEscaloes %></span>
                <span class="stat-label">Escalões ativos</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-user-tie"></i></div>
            <div class="stat-info">
                <span class="stat-num"><%= totalTreinadores %></span>
                <span class="stat-label">Treinadores</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
            <div class="stat-info">
                <span class="stat-num"><%= totalTreinos %></span>
                <span class="stat-label">Sessões de treino</span>
            </div>
        </div>
    </div>

    <div class="quick-links">
        <h3>Acesso rápido</h3>
        <div class="quick-grid">
            <a href="escaloes.jsp" class="quick-card">
                <i class="fas fa-layer-group"></i>
                <span>Gerir Escalões</span>
            </a>
            <a href="treinadores.jsp" class="quick-card">
                <i class="fas fa-user-tie"></i>
                <span>Gerir Treinadores</span>
            </a>
            <a href="horarios.jsp" class="quick-card">
                <i class="fas fa-calendar-alt"></i>
                <span>Gerir Horários</span>
            </a>
        </div>
    </div>
</main>

</body>
</html>
