<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- PHP: include("includes/header.php") --%>
<%@ include file="/includes/header.jsp" %>

<section class="hero-infantarios">
    <div class="hero-infantarios-content">
        <h1>ESFUMA Infantários</h1>
        <a href="#contactos" class="btn">Inscreva o seu filho</a>
    </div>
</section>

<section class="intro">
    <div class="container">
        <h2>O Projeto</h2>
        <p>
            O ESFUMA Infantários é dedicado aos mais pequenos, proporcionando um ambiente seguro,
            divertido e educativo onde podem dar os primeiros passos no futebol.
        </p>
    </div>
</section>

<section class="objetivos">
    <div class="container">
        <h2>Objetivos</h2>

        <div class="objetivos-grid">
            <div class="obj">
                <h4>⚽ Diversão</h4>
                <p>Aprender através do jogo e da brincadeira.</p>
            </div>

            <div class="obj">
                <h4>🤝 Socialização</h4>
                <p>Desenvolver amizades e espírito de equipa.</p>
            </div>

            <div class="obj">
                <h4>🏃 Coordenação</h4>
                <p>Melhorar capacidades motoras básicas.</p>
            </div>

            <div class="obj">
                <h4>💚 Valores</h4>
                <p>Respeito, disciplina e fair-play desde cedo.</p>
            </div>
        </div>
    </div>
</section>

<section class="infor">
    <div class="container info-grid">

        <div class="info-card">
            <h3>Idades</h3>
            <p>Dos 3 aos 5 anos</p>
        </div>

        <div class="info-card">
            <h3>Horários</h3>
            <p>Segundas e Quartas</p>
            <p>18h00 - 19h00</p>
        </div>

        <div class="info-card">
            <h3>Local</h3>
            <p>Campo ESFUMA</p>
        </div>

    </div>
</section>

<section class="contacto reveal" id="contactos">
    <div class="container">
        <h3>Contactos</h3>
        <p class="section-subtitle">Estamos aqui para ti. Entra em contacto connosco.</p>

        <div class="contacto-grid">

            <div class="contacto-card">
                <div class="contacto-icon"><i class="fas fa-phone"></i></div>
                <h4>Telemóvel</h4>
                <a href="tel:912562328">912 562 328</a>
            </div>

            <div class="contacto-card">
                <div class="contacto-icon"><i class="fas fa-envelope"></i></div>
                <h4>Email</h4>
                <a href="mailto:esfuminha@gmail.com">esfuminha@gmail.com</a>
            </div>

            <div class="contacto-card">
                <div class="contacto-icon"><i class="fas fa-map-marker-alt"></i></div>
                <h4>Morada</h4>
                <p>Caminho do Pilar<br>Funchal, Madeira</p>
            </div>

        </div>

        <a href="https://wa.me/351912562328" class="btn whatsapp">
            <i class="fab fa-whatsapp"></i> Falar no WhatsApp
        </a>
    </div>
</section>

<%-- PHP: include("includes/footer.php") --%>
<%@ include file="/includes/footer.jsp" %>
