<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String nomePagina = request.getServletPath().replace("/", "").replace(".jsp", "");

    java.util.Map<String, String> breadcrumbs = new java.util.LinkedHashMap<>();
    breadcrumbs.put("infantarios", "Infantários");
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
        <img src="img/logo_escola_1.png" alt="ESFUMA">
        <div class="logo-texto">
            <h1>SITE OFICIAL</h1>
        </div>
    </div>

    <% if (!nomePagina.equals("index") && breadcrumbs.containsKey(nomePagina)) { %>
        <div class="breadcrumb">
            <a href="index.jsp">Início</a>
            <span>›</span>
            <span class="current"><%= breadcrumbs.get(nomePagina) %></span>
        </div>
    <% } %>

    <!-- Menu desktop -->
    <nav class="menu">
    <% if (nomePagina.equals("index") || nomePagina.isEmpty()) { %>
        <a href="#inicio">Início</a>
        <a href="#sobre">Missão</a>
        <a href="#treinos">Escalões</a>
        <a href="#contactos">Contactos</a>
    <% } else { %>
        <a href="index.jsp">Início</a>
        <a href="index.jsp#treinos">Escalões</a>
        <a href="#contactos">Contactos</a>
    <% } %>
    </nav>

    <!-- Botão hamburger (só aparece em mobile) -->
    <button class="hamburger" id="hamburger" aria-label="Abrir menu">
        <span></span>
        <span></span>
        <span></span>
    </button>

</header>

<!-- Menu mobile (fora do header para ficar abaixo dele) -->
<nav class="menu-mobile" id="menu-mobile">
    <% if (nomePagina.equals("index") || nomePagina.isEmpty()) { %>
        <a href="#inicio">Início</a>
        <a href="#sobre">Missão</a>
        <a href="#treinos">Escalões</a>
        <a href="#contactos">Contactos</a>
    <% } else { %>
        <a href="index.jsp">Início</a>
        <a href="index.jsp#treinos">Escalões</a>
        <a href="#contactos">Contactos</a>
    <% } %>
</nav>
