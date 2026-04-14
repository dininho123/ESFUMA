<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<aside class="sidebar">
    <div class="sidebar-logo">
        <img src="../img/logo_escola_1.png" alt="ESFUMA">
        <span>Admin</span>
    </div>

    <nav class="sidebar-nav">
        <a href="index.jsp"       class="<%= request.getServletPath().contains("index")       ? "active" : "" %>"><i class="fas fa-gauge"></i> Dashboard</a>
        <a href="escaloes.jsp"    class="<%= request.getServletPath().contains("escaloe")     ? "active" : "" %>"><i class="fas fa-layer-group"></i> Escalões</a>
        <a href="treinadores.jsp" class="<%= request.getServletPath().contains("treinadores") ? "active" : "" %>"><i class="fas fa-user-tie"></i> Treinadores</a>
    </nav>

    <div class="sidebar-footer">
        <a href="../index.jsp" target="_blank"><i class="fas fa-arrow-up-right-from-square"></i> Ver site</a>
        <a href="logout.jsp" class="logout"><i class="fas fa-right-from-bracket"></i> Sair</a>
    </div>
</aside>
