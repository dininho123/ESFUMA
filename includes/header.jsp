<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String nomePagina = request.getServletPath().replace("/", "").replace(".jsp", "");
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="ESFUMA — EScola de FUtebol da MAdeira. Formação desportiva para jovens dos 3 aos 19 anos em Funchal, Madeira.">
    <meta property="og:title" content="ESFUMA — EScola de FUtebol da MAdeira">
    <meta property="og:description" content="Formando homens, atletas e campeões desde 1998. Inscrições abertas dos 3 aos 19 anos.">
    <meta property="og:image" content="img/hero.jpg">
    <meta property="og:type" content="website">
    <meta name="theme-color" content="#27ae60">
    <title>ESFUMA — EScola de FUtebol da MAdeira</title>
    <link rel="icon" type="image/png" href="img/logo_escola_1.png">
    <link rel="apple-touch-icon" href="img/logo_escola_1.png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="css/style.css?v=2.1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&family=Oswald:wght@400;600;700&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<div id="preloader">
    <img src="img/logo_escola_1.png" alt="ESFUMA">
</div>

<header class="header">

    <div class="logo">
        <a href="<%= (nomePagina.equals("index") || nomePagina.isEmpty()) ? "#inicio" : "index.jsp" %>">
            <img src="img/logo_escola_1.png" alt="ESFUMA">
        </a>
        <div class="logo-texto">
            <h1>SITE OFICIAL</h1>
        </div>
    </div>

    <!-- Tudo à direita -->
    <div class="header-right">

        <!-- Menu de páginas -->
        <div class="pages-menu">
            <button class="pages-btn" id="pages-btn" aria-label="Navegar entre páginas">
                <i class="fas fa-bars"></i>
                <span><%= nomePagina.equals("infantarios") ? "Infantários" : "Início" %></span>
                <i class="fas fa-chevron-down pages-chevron"></i>
            </button>
            <div class="pages-dropdown" id="pages-dropdown">
                <a href="index.jsp" class="pages-item <%= (nomePagina.equals("index") || nomePagina.isEmpty()) ? "current" : "" %>">
                    <div class="pages-item-icon"><i class="fas fa-home"></i></div>
                    <div class="pages-item-text">
                        <span>Início</span>
                        <small>Página principal</small>
                    </div>
                    <% if (nomePagina.equals("index") || nomePagina.isEmpty()) { %><i class="fas fa-check pages-item-check"></i><% } %>
                </a>
                <a href="infantarios.jsp" class="pages-item <%= nomePagina.equals("infantarios") ? "current" : "" %>">
                    <div class="pages-item-icon"><i class="fas fa-child"></i></div>
                    <div class="pages-item-text">
                        <span>Infantários</span>
                        <small>ESFUMA Infantários</small>
                    </div>
                    <% if (nomePagina.equals("infantarios")) { %><i class="fas fa-check pages-item-check"></i><% } %>
                </a>
            </div>
        </div>

        <!-- Separador vertical -->
        <div class="header-sep"></div>

        <!-- Atalhos às secções -->
        <nav class="menu">
        <% if (nomePagina.equals("index") || nomePagina.isEmpty()) { %>
            <a href="#sobre">Missão</a>
            <a href="#treinos">Escalões</a>
            <a href="#contactos">Contactos</a>
        <% } else if (nomePagina.equals("infantarios")) { %>
            <a href="#infantarios">Infantários</a>
            <a href="#contactos">Contactos</a>
        <% } %>
        </nav>

        <!-- Botão hamburger (mobile) -->
        <button class="hamburger" id="hamburger" aria-label="Abrir menu">
            <span></span>
            <span></span>
            <span></span>
        </button>

    </div>

</header>

<!-- Menu mobile (fora do header para ficar abaixo dele) -->
<nav class="menu-mobile" id="menu-mobile">
    <% if (nomePagina.equals("index") || nomePagina.isEmpty()) { %>
        <a href="#sobre">Missão</a>
        <a href="#treinos">Escalões</a>
        <a href="#contactos">Contactos</a>
    <% } else if (nomePagina.equals("infantarios")) { %>
        <a href="#infantarios">Infantários</a>
        <a href="#contactos">Contactos</a>
    <% } %>
    <div class="menu-mobile-divider"></div>
    <p class="menu-mobile-pages-title">Páginas</p>
    <a href="index.jsp"       class="<%= (nomePagina.equals("index") || nomePagina.isEmpty()) ? "current" : "" %>"><i class="fas fa-home"></i> Início</a>
    <a href="infantarios.jsp" class="<%= nomePagina.equals("infantarios") ? "current" : "" %>"><i class="fas fa-child"></i> Infantários</a>
</nav>
