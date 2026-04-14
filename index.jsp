<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/includes/functions.jsp" %>
<%@ include file="/includes/db.jsp" %>

<%-- PHP: include("includes/header.php") --%>
<%@ include file="/includes/header.jsp" %>

<section class="hero" id="inicio">
    <div class="hero-content">
        <h2>Formando Homens, Atletas e Campeões</h2>
        <p>Formação desportiva dos 3 aos 19 anos.</p>
        <a href="#contactos" class="btn">Inscreve-te</a>
    </div>
    <a href="#sobre" class="scroll-indicator" aria-label="Continuar">
        <i class="fas fa-chevron-down"></i>
    </a>
</section>

<section class="sobre reveal" id="sobre">
    <div class="container sobre-grid">

        <div class="sobre-texto">
            <h3>MISSÃO</h3>
            <p class="sobre-lead">
                A ESFUMA tem como missão formar jovens atletas com disciplina, respeito e verdadeira paixão pelo futebol.
                Cada criança é tratada como um campeão em potencial.
            </p>
            <div class="sobre-stats">
                <div class="stat">
                    <span class="stat-num" data-target="300" data-prefix="+">+300</span>
                    <span class="stat-label">Atletas</span>
                </div>
                <div class="stat">
                    <span class="stat-num" data-target="13">13</span>
                    <span class="stat-label">Escalões</span>
                </div>
                <div class="stat">
                    <span class="stat-num" data-target="25" data-suffix="+">25+</span>
                    <span class="stat-label">Anos</span>
                </div>
            </div>
        </div>

        <div class="sobre-imagem">
            <img src="img/treino.png" alt="Treino de futebol" loading="lazy">
        </div>

    </div>
</section>

<section class="treinos reveal" id="treinos">
    <div class="containe_escaloes">
        <div class="treinos-layout">

            <!-- ESQUERDA -->
            <div class="treinos-left">
                <h3>Os Nossos Escalões</h3>
                <div class="cards">

                <%
                    Connection conn = getConnection();

                    PreparedStatement psEscalaos = conn.prepareStatement(
                        "SELECT id, nome, idade_max FROM escaloes WHERE ativo = 1 ORDER BY idade_max ASC"
                    );
                    ResultSet rsEscalaos = psEscalaos.executeQuery();

                    while (rsEscalaos.next()) {
                        int    escalaoId   = rsEscalaos.getInt("id");
                        String nomeEscalao = rsEscalaos.getString("nome");
                        int    idadeMax    = rsEscalaos.getInt("idade_max");

                        // Treinadores deste escalão
                        PreparedStatement psTrein = conn.prepareStatement(
                            "SELECT t.nome FROM treinadores t " +
                            "JOIN escalao_treinador et ON t.id = et.treinador_id " +
                            "WHERE et.escalao_id = ?"
                        );
                        psTrein.setInt(1, escalaoId);
                        ResultSet rsTrein = psTrein.executeQuery();
                        java.util.List<String> treinadores = new java.util.ArrayList<>();
                        while (rsTrein.next()) treinadores.add(rsTrein.getString("nome"));
                        rsTrein.close(); psTrein.close();

                        // Horários deste escalão
                        PreparedStatement psTreinos = conn.prepareStatement(
                            "SELECT dia, hora, local FROM treinos WHERE escalao_id = ?"
                        );
                        psTreinos.setInt(1, escalaoId);
                        ResultSet rsTreinos = psTreinos.executeQuery();
                %>

                    <div class="card">
                        <div class="card-header"><%= nomeEscalao %></div>

                        <div class="card-content">

                            <p class="ano">Nascidos em <%= anoNascimentoEscalao(idadeMax) %></p>

                            <p class="label">Treinadores</p>
                            <p class="value"><%= String.join(", ", treinadores) %></p>

                            <p class="label">Horários</p>
                            <ul class="horarios">
                                <% while (rsTreinos.next()) { %>
                                    <li>
                                        <span class="dia"><%=  rsTreinos.getString("dia")   %></span>
                                        <span class="hora"><%= rsTreinos.getString("hora")  %></span>
                                        <span class="local"><%= rsTreinos.getString("local") %></span>
                                    </li>
                                <% } %>
                            </ul>

                        </div>
                    </div>

                <%
                        rsTreinos.close(); psTreinos.close();
                    } // fim while escalões

                    rsEscalaos.close(); psEscalaos.close();
                    conn.close();
                %>

                </div>
            </div>

            <!-- DIREITA -->
            <div class="treinos-right">

                <div class="extra-card">
                    <div class="extra-card-icon"><i class="fas fa-child"></i></div>
                    <h4>Esfuma Infantários</h4>
                    <p>Para os mais pequenos começarem no futebol de forma divertida.</p>
                    <a href="infantarios.jsp" class="btn">Saber mais</a>
                </div>

                <div class="extra-card">
                    <div class="extra-card-icon"><i class="fas fa-person-walking"></i></div>
                    <h4>Esfuma Walking Football</h4>
                    <p>Futebol adaptado para adultos e convívio saudável.</p>
                    <a href="#" class="btn">Saber mais</a>
                </div>

            </div>

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

        <div class="contacto-social">
            <a href="https://www.facebook.com/esfumadeira" target="_blank" class="social-btn facebook">
                <i class="fab fa-facebook-f"></i> Facebook
            </a>
            <a href="https://www.instagram.com/esfumadeira/" target="_blank" class="social-btn instagram">
                <i class="fab fa-instagram"></i> Instagram
            </a>
        </div>

        <a href="https://wa.me/351912562328" class="btn whatsapp">
            <i class="fab fa-whatsapp"></i> Falar no WhatsApp
        </a>

        <div class="mapa-wrapper">
            <iframe
                src="https://maps.google.com/maps?q=Caminho+do+Pilar,+Funchal,+Madeira&output=embed"
                loading="lazy"
                allowfullscreen
                title="Localização ESFUMA">
            </iframe>
        </div>

    </div>
</section>

<%-- PHP: include("includes/footer.php") --%>
<%@ include file="/includes/footer.jsp" %>
