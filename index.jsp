<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- PHP: include("includes/functions.php") --%>
<%@ include file="/includes/functions.jsp" %>

<%-- PHP: include("includes/header.php") --%>
<%@ include file="/includes/header.jsp" %>

<section class="hero" id="inicio">
    <div class="hero-content">
        <h2>Formando Homens, Atletas e Campeões</h2>
        <p>Dos 3 aos 19 anos!!</p>
        <a href="#contactos" class="btn">Inscreve-te</a>
    </div>
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
                    <span class="stat-num">+200</span>
                    <span class="stat-label">Atletas</span>
                </div>
                <div class="stat">
                    <span class="stat-num">11</span>
                    <span class="stat-label">Escalões</span>
                </div>
                <div class="stat">
                    <span class="stat-num">25+</span>
                    <span class="stat-label">Anos</span>
                </div>
            </div>
        </div>

        <div class="sobre-imagem">
            <img src="img/treino.png" alt="Treino de futebol">
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
                    // PHP: $escalaos = [ [...], [...], ... ];
                    // Em Java criamos um array de objectos Escalao
                    Escalao[] escalaos = {
                        new Escalao("Sub-6", 6,
                            new String[]{"Afonso Azevedo", "Francisco Sombreireiro"},
                            new Treino[]{
                                new Treino("Segunda", "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Quarta",  "19h00 - 20h00", "Campo ESFUMA")
                            }
                        ),
                        new Escalao("Sub-7", 7,
                            new String[]{"Treinador A", "Treinador B"},
                            new Treino[]{
                                new Treino("Terça",   "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Sábado",  "19h00 - 20h00", "Campo ESFUMA")
                            }
                        ),
                        new Escalao("Sub-8", 8,
                            new String[]{"Treinador C", "Treinador D"},
                            new Treino[]{
                                new Treino("Quarta",  "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Sábado",  "19h00 - 20h00", "Campo ESFUMA")
                            }
                        ),
                        new Escalao("Sub-9", 9,
                            new String[]{"Treinador E", "Treinador F"},
                            new Treino[]{
                                new Treino("Terça",   "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Sábado",  "19h00 - 20h00", "Campo ESFUMA")
                            }
                        ),
                        new Escalao("Sub-10", 10,
                            new String[]{"Treinador G", "Treinador H"},
                            new Treino[]{
                                new Treino("Segunda", "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Quinta",  "19h00 - 20h00", "Campo ESFUMA")
                            }
                        ),
                        new Escalao("Sub-11", 11,
                            new String[]{"João Pedro Ramos"},
                            new Treino[]{
                                new Treino("Segunda", "19h00 - 20h15", "Liceu Jaime Moniz"),
                                new Treino("Quinta",  "18h40 - 19h50", "Escola da Ajuda")
                            }
                        ),
                        new Escalao("Sub-12", 12,
                            new String[]{"Treinador K", "Treinador L"},
                            new Treino[]{
                                new Treino("Terça",   "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Quarta",  "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Quinta",  "19h00 - 20h00", "Campo ESFUMA")
                            }
                        ),
                        new Escalao("Sub-13", 13,
                            new String[]{"Treinador M", "Treinador N"},
                            new Treino[]{
                                new Treino("Terça",   "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Quarta",  "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Quinta",  "19h00 - 20h00", "Campo ESFUMA")
                            }
                        ),
                        new Escalao("Iniciados", 15,
                            new String[]{"Treinador O", "Treinador P"},
                            new Treino[]{
                                new Treino("Terça",   "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Quarta",  "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Sexta",   "19h00 - 20h00", "Campo ESFUMA")
                            }
                        ),
                        new Escalao("Juvenis", 17,
                            new String[]{"Treinador Q", "Treinador R"},
                            new Treino[]{
                                new Treino("Segunda", "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Quarta",  "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Sexta",   "19h00 - 20h00", "Campo ESFUMA")
                            }
                        ),
                        new Escalao("Juniores", 19,
                            new String[]{"Treinador S", "Treinador T"},
                            new Treino[]{
                                new Treino("Segunda", "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Quarta",  "19h00 - 20h00", "Campo ESFUMA"),
                                new Treino("Sexta",   "19h00 - 20h00", "Campo ESFUMA")
                            }
                        )
                    };

                    // PHP: usort($escalaos, fn($a,$b) => $a["idade"] <=> $b["idade"]);
                    java.util.Arrays.sort(escalaos, (a, b) -> a.idade - b.idade);

                    // PHP: foreach ($escalaos as $escalao):
                    for (Escalao escalao : escalaos) {
                %>

                    <div class="card">
                        <%-- PHP: <?= htmlspecialchars($escalao["nome"]) ?> --%>
                        <div class="card-header"><%= escalao.nome %></div>

                        <div class="card-content">

                            <p class="ano">
                                <%-- PHP: Nascidos em <?= anoNascimentoEscalao($escalao["idade"]) ?> --%>
                                Nascidos em <%= anoNascimentoEscalao(escalao.idade) %>
                            </p>

                            <p class="label">Treinadores</p>
                            <p class="value">
                                <%-- PHP: implode(", ", $escalao["treinadores"]) --%>
                                <%= String.join(", ", escalao.treinadores) %>
                            </p>

                            <p class="label">Horários</p>

                            <ul class="horarios">
                                <%-- PHP: foreach ($escalao["treinos"] as $treino): --%>
                                <% for (Treino treino : escalao.treinos) { %>
                                    <li>
                                        <span class="dia"><%= treino.dia %></span>
                                        <span class="hora"><%= treino.hora %></span>
                                        <span class="local"><%= treino.local %></span>
                                    </li>
                                <% } %>
                            </ul>

                        </div>
                    </div>

                <% } // fim foreach %>

                </div>
            </div>

            <!-- DIREITA -->
            <div class="treinos-right">

                <div class="extra-card">
                    <h4>Esfuma Infantários</h4>
                    <p>Para os mais pequenos começarem no futebol de forma divertida.</p>
                    <%-- PHP: href="infantarios.php" → JSP: href="infantarios.jsp" --%>
                    <a href="infantarios.jsp" class="btn">Saber mais</a>
                </div>

                <div class="extra-card">
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

        <a href="https://wa.me/351912562328" class="btn whatsapp">
            <i class="fab fa-whatsapp"></i> Falar no WhatsApp
        </a>
    </div>
</section>

<%-- PHP: include("includes/footer.php") --%>
<%@ include file="/includes/footer.jsp" %>
