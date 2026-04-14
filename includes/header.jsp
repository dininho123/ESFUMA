<%
    String nomePagina = request.getServletPath().replace("/", "").replace(".jsp", "");

    java.util.Map<String, String> breadcrumbs = new java.util.LinkedHashMap<>();
    breadcrumbs.put("infantarios", "Infantários");
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>ESFUMA</title>
    <link rel="stylesheet" href="css/style.css?v=1.2">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;600;700&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

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
        <a href="#inicio">Início</a>
        <a href="#sobre">Missão</a>
        <a href="#treinos">Escalões</a>
        <a href="#contactos">Contactos</a>
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
    <a href="#inicio">Início</a>
    <a href="#sobre">Missão</a>
    <a href="#treinos">Escalões</a>
    <a href="#contactos">Contactos</a>
</nav>
