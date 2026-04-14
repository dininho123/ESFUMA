<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="auth.jsp" %>
<%@ include file="/includes/db.jsp" %>
<%
    int escalaoId = Integer.parseInt(request.getParameter("id"));
    String mensagem = null;

    // ── EDITAR ESCALÃO ───────────────────────────────────
    if ("POST".equals(request.getMethod()) && "editar-escalao".equals(request.getParameter("acao"))) {
        String nome    = request.getParameter("nome").trim();
        int    idadeMax = Integer.parseInt(request.getParameter("idade_max"));
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE escaloes SET nome = ?, idade_max = ? WHERE id = ?"
        );
        ps.setString(1, nome); ps.setInt(2, idadeMax); ps.setInt(3, escalaoId);
        ps.executeUpdate(); ps.close(); conn.close();
        mensagem = "Informações do escalão atualizadas.";
    }

    // ── ATRIBUIR TREINADOR ───────────────────────────────
    if ("POST".equals(request.getMethod()) && "adicionar-treinador".equals(request.getParameter("acao"))) {
        int treinadorId = Integer.parseInt(request.getParameter("treinador_id"));
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "INSERT IGNORE INTO escalao_treinador (escalao_id, treinador_id) VALUES (?, ?)"
        );
        ps.setInt(1, escalaoId); ps.setInt(2, treinadorId);
        ps.executeUpdate(); ps.close(); conn.close();
        mensagem = "Treinador atribuído ao escalão.";
    }

    // ── REMOVER TREINADOR DO ESCALÃO ─────────────────────
    if ("apagar-treinador".equals(request.getParameter("acao"))) {
        int tid = Integer.parseInt(request.getParameter("tid"));
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "DELETE FROM escalao_treinador WHERE escalao_id = ? AND treinador_id = ?"
        );
        ps.setInt(1, escalaoId); ps.setInt(2, tid);
        ps.executeUpdate(); ps.close(); conn.close();
        mensagem = "Treinador removido do escalão.";
    }

    // ── ADICIONAR HORÁRIO ────────────────────────────────
    if ("POST".equals(request.getMethod()) && "adicionar-treino".equals(request.getParameter("acao"))) {
        String dia   = request.getParameter("dia").trim();
        String hora  = request.getParameter("hora").trim();
        String local = request.getParameter("local").trim();
        if (!dia.isEmpty() && !hora.isEmpty()) {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO treinos (escalao_id, dia, hora, local) VALUES (?, ?, ?, ?)"
            );
            ps.setInt(1, escalaoId); ps.setString(2, dia);
            ps.setString(3, hora);   ps.setString(4, local);
            ps.executeUpdate(); ps.close(); conn.close();
            mensagem = "Horário adicionado.";
        }
    }

    // ── APAGAR HORÁRIO ───────────────────────────────────
    if ("apagar-treino".equals(request.getParameter("acao"))) {
        int id = Integer.parseInt(request.getParameter("hid"));
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM treinos WHERE id = ?");
        ps.setInt(1, id); ps.executeUpdate(); ps.close(); conn.close();
        mensagem = "Horário removido.";
    }

    // ── CARREGAR DADOS ───────────────────────────────────
    Connection conn = getConnection();

    PreparedStatement psEsc = conn.prepareStatement(
        "SELECT nome, idade_max FROM escaloes WHERE id = ?"
    );
    psEsc.setInt(1, escalaoId);
    ResultSet rsEsc = psEsc.executeQuery(); rsEsc.next();
    String nomeEscalao = rsEsc.getString("nome");
    int    idadeMax    = rsEsc.getInt("idade_max");
    rsEsc.close(); psEsc.close();

    // Treinadores já atribuídos
    PreparedStatement psTrein = conn.prepareStatement(
        "SELECT t.id, t.nome FROM treinadores t " +
        "JOIN escalao_treinador et ON t.id = et.treinador_id " +
        "WHERE et.escalao_id = ? ORDER BY t.nome ASC"
    );
    psTrein.setInt(1, escalaoId);
    ResultSet rsTrein = psTrein.executeQuery();

    // Treinadores disponíveis (ainda não atribuídos a este escalão)
    PreparedStatement psDisp = conn.prepareStatement(
        "SELECT id, nome FROM treinadores " +
        "WHERE id NOT IN (" +
        "   SELECT treinador_id FROM escalao_treinador WHERE escalao_id = ?" +
        ") ORDER BY nome ASC"
    );
    psDisp.setInt(1, escalaoId);
    ResultSet rsDisp = psDisp.executeQuery();
    java.util.List<Integer> dispIds   = new java.util.ArrayList<>();
    java.util.List<String>  dispNomes = new java.util.ArrayList<>();
    while (rsDisp.next()) {
        dispIds.add(rsDisp.getInt("id"));
        dispNomes.add(rsDisp.getString("nome"));
    }
    rsDisp.close(); psDisp.close();

    PreparedStatement psTreinos = conn.prepareStatement(
        "SELECT id, dia, hora, local FROM treinos WHERE escalao_id = ?"
    );
    psTreinos.setInt(1, escalaoId);
    ResultSet rsTreinos = psTreinos.executeQuery();
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ESFUMA — <%= nomeEscalao %></title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="icon" type="image/png" href="../img/logo_escola_1.png">
    <link rel="stylesheet" href="admin.css">
</head>
<body>

<%@ include file="sidebar.jsp" %>

<main class="main-content">

    <div class="page-header" style="display:flex;justify-content:space-between;align-items:center;">
        <div>
            <a href="escaloes.jsp" style="color:#6b7280;font-size:13px;text-decoration:none;">
                <i class="fas fa-arrow-left"></i> Voltar aos Escalões
            </a>
            <h2 style="margin-top:6px;"><%= nomeEscalao %></h2>
        </div>
    </div>

    <% if (mensagem != null) { %>
        <div class="alert-success"><i class="fas fa-check-circle"></i> <%= mensagem %></div>
    <% } %>

    <!-- INFORMAÇÕES DO ESCALÃO -->
    <div class="card" style="margin-bottom:24px;">
        <div class="card-header-bar"><h3><i class="fas fa-layer-group"></i> Informações do Escalão</h3></div>
        <div style="padding:20px;">
            <form method="POST" action="escalao-detalhe.jsp?id=<%= escalaoId %>" style="display:flex;gap:16px;align-items:flex-end;">
                <input type="hidden" name="acao" value="editar-escalao">
                <div class="form-group" style="flex:1;margin:0;">
                    <label>Nome</label>
                    <input type="text" name="nome" value="<%= nomeEscalao %>" required>
                </div>
                <div class="form-group" style="width:160px;margin:0;">
                    <label>Idade máxima</label>
                    <input type="number" name="idade_max" value="<%= idadeMax %>" min="3" max="25" required>
                </div>
                <button type="submit" class="btn btn-primary" style="height:42px;">
                    <i class="fas fa-check"></i> Guardar
                </button>
            </form>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:24px;">

        <!-- TREINADORES -->
        <div class="card">
            <div class="card-header-bar"><h3><i class="fas fa-user-tie"></i> Treinadores</h3></div>
            <table>
                <thead>
                    <tr><th>Nome</th><th style="width:60px;"></th></tr>
                </thead>
                <tbody>
                <% if (!rsTrein.isBeforeFirst()) { %>
                    <tr><td colspan="2" style="color:#9ca3af;font-style:italic;padding:16px 20px;">Nenhum treinador atribuído.</td></tr>
                <% }
                while (rsTrein.next()) {
                    int    tid   = rsTrein.getInt("id");
                    String tnome = rsTrein.getString("nome");
                %>
                    <tr>
                        <td><strong><%= tnome %></strong></td>
                        <td>
                            <a href="escalao-detalhe.jsp?id=<%= escalaoId %>&acao=apagar-treinador&tid=<%= tid %>"
                               class="btn btn-danger"
                               style="padding:5px 10px;"
                               onclick="return confirm('Remover <%= tnome %>?')">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                <% } rsTrein.close(); psTrein.close(); %>
                </tbody>
            </table>
            <div style="padding:16px 20px;border-top:1px solid #f3f4f6;">
                <% if (dispIds.isEmpty()) { %>
                    <p style="color:#9ca3af;font-size:13px;font-style:italic;">
                        Todos os treinadores já estão atribuídos.
                        <a href="treinadores.jsp" style="color:#27ae60;">Adicionar novo treinador</a>
                    </p>
                <% } else { %>
                    <form method="POST" action="escalao-detalhe.jsp?id=<%= escalaoId %>" style="display:flex;gap:10px;">
                        <input type="hidden" name="acao" value="adicionar-treinador">
                        <select name="treinador_id" required
                                style="flex:1;padding:8px 12px;border:1.5px solid #e5e7eb;border-radius:8px;font-family:'Poppins',sans-serif;font-size:13px;outline:none;">
                            <option value="">-- Selecionar treinador --</option>
                            <% for (int i = 0; i < dispIds.size(); i++) { %>
                                <option value="<%= dispIds.get(i) %>"><%= dispNomes.get(i) %></option>
                            <% } %>
                        </select>
                        <button type="submit" class="btn btn-primary" style="height:38px;">
                            <i class="fas fa-plus"></i>
                        </button>
                    </form>
                <% } %>
            </div>
        </div>

        <!-- HORÁRIOS -->
        <div class="card">
            <div class="card-header-bar"><h3><i class="fas fa-calendar-alt"></i> Horários de Treino</h3></div>
            <table>
                <thead>
                    <tr><th>Dia</th><th>Hora</th><th>Local</th><th style="width:60px;"></th></tr>
                </thead>
                <tbody>
                <% if (!rsTreinos.isBeforeFirst()) { %>
                    <tr><td colspan="4" style="color:#9ca3af;font-style:italic;padding:16px 20px;">Nenhum horário definido.</td></tr>
                <% }
                while (rsTreinos.next()) {
                    int    hid   = rsTreinos.getInt("id");
                    String hdia  = rsTreinos.getString("dia");
                    String hhora = rsTreinos.getString("hora");
                    String hloc  = rsTreinos.getString("local");
                %>
                    <tr>
                        <td><strong><%= hdia %></strong></td>
                        <td style="color:#27ae60;font-weight:600;"><%= hhora %></td>
                        <td style="color:#888;font-size:13px;"><%= hloc %></td>
                        <td>
                            <a href="escalao-detalhe.jsp?id=<%= escalaoId %>&acao=apagar-treino&hid=<%= hid %>"
                               class="btn btn-danger"
                               style="padding:5px 10px;"
                               onclick="return confirm('Remover este horário?')">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                <% } rsTreinos.close(); psTreinos.close(); conn.close(); %>
                </tbody>
            </table>
            <div style="padding:16px 20px;border-top:1px solid #f3f4f6;">
                <form method="POST" action="escalao-detalhe.jsp?id=<%= escalaoId %>">
                    <input type="hidden" name="acao" value="adicionar-treino">
                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-bottom:8px;">
                        <input type="text" name="dia" placeholder="Dia (ex: Segunda)" required
                               style="padding:8px 12px;border:1.5px solid #e5e7eb;border-radius:8px;font-family:'Poppins',sans-serif;font-size:13px;outline:none;">
                        <input type="text" name="hora" placeholder="Ex: 19h00 - 20h00" required
                               style="padding:8px 12px;border:1.5px solid #e5e7eb;border-radius:8px;font-family:'Poppins',sans-serif;font-size:13px;outline:none;">
                    </div>
                    <div style="display:flex;gap:8px;">
                        <input type="text" name="local" placeholder="Local (ex: Campo ESFUMA)" required
                               style="flex:1;padding:8px 12px;border:1.5px solid #e5e7eb;border-radius:8px;font-family:'Poppins',sans-serif;font-size:13px;outline:none;">
                        <button type="submit" class="btn btn-primary" style="height:38px;">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</main>

</body>
</html>
