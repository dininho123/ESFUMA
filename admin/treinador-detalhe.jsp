<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="auth.jsp" %>
<%@ include file="/includes/db.jsp" %>
<%
    int treinadorId = Integer.parseInt(request.getParameter("id"));
    String mensagem = null;

    // ── EDITAR TREINADOR ─────────────────────────────────
    if ("POST".equals(request.getMethod()) && "editar-treinador".equals(request.getParameter("acao"))) {
        String nome = request.getParameter("nome").trim();
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE treinadores SET nome = ? WHERE id = ?"
        );
        ps.setString(1, nome); ps.setInt(2, treinadorId);
        ps.executeUpdate(); ps.close(); conn.close();
        mensagem = "Treinador atualizado.";
    }

    // ── ATRIBUIR ESCALÃO ─────────────────────────────────
    if ("POST".equals(request.getMethod()) && "adicionar-escalao".equals(request.getParameter("acao"))) {
        int escalaoId = Integer.parseInt(request.getParameter("escalao_id"));
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "INSERT IGNORE INTO escalao_treinador (escalao_id, treinador_id) VALUES (?, ?)"
        );
        ps.setInt(1, escalaoId); ps.setInt(2, treinadorId);
        ps.executeUpdate(); ps.close(); conn.close();
        mensagem = "Escalão atribuído ao treinador.";
    }

    // ── REMOVER ESCALÃO DO TREINADOR ─────────────────────
    if ("apagar-escalao".equals(request.getParameter("acao"))) {
        int eid = Integer.parseInt(request.getParameter("eid"));
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "DELETE FROM escalao_treinador WHERE escalao_id = ? AND treinador_id = ?"
        );
        ps.setInt(1, eid); ps.setInt(2, treinadorId);
        ps.executeUpdate(); ps.close(); conn.close();
        mensagem = "Escalão removido do treinador.";
    }

    // ── CARREGAR DADOS ───────────────────────────────────
    Connection conn = getConnection();

    PreparedStatement psTrein = conn.prepareStatement(
        "SELECT nome FROM treinadores WHERE id = ?"
    );
    psTrein.setInt(1, treinadorId);
    ResultSet rsTrein = psTrein.executeQuery(); rsTrein.next();
    String nomeTreinador = rsTrein.getString("nome");
    rsTrein.close(); psTrein.close();

    // Escalões atribuídos
    PreparedStatement psEsc = conn.prepareStatement(
        "SELECT e.id, e.nome FROM escaloes e " +
        "JOIN escalao_treinador et ON e.id = et.escalao_id " +
        "WHERE et.treinador_id = ? ORDER BY e.idade_max ASC"
    );
    psEsc.setInt(1, treinadorId);
    ResultSet rsEsc = psEsc.executeQuery();

    // Escalões disponíveis
    PreparedStatement psDisp = conn.prepareStatement(
        "SELECT id, nome FROM escaloes " +
        "WHERE ativo = 1 AND id NOT IN (" +
        "   SELECT escalao_id FROM escalao_treinador WHERE treinador_id = ?" +
        ") ORDER BY idade_max ASC"
    );
    psDisp.setInt(1, treinadorId);
    ResultSet rsDisp = psDisp.executeQuery();
    java.util.List<Integer> dispIds   = new java.util.ArrayList<>();
    java.util.List<String>  dispNomes = new java.util.ArrayList<>();
    while (rsDisp.next()) {
        dispIds.add(rsDisp.getInt("id"));
        dispNomes.add(rsDisp.getString("nome"));
    }
    rsDisp.close(); psDisp.close();
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ESFUMA — <%= nomeTreinador %></title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="icon" type="image/png" href="../img/logo_escola_1.png">
    <link rel="stylesheet" href="admin.css">
</head>
<body>

<%@ include file="sidebar.jsp" %>

<main class="main-content">

    <div class="page-header">
        <div>
            <a href="treinadores.jsp" style="color:#6b7280;font-size:13px;text-decoration:none;">
                <i class="fas fa-arrow-left"></i> Voltar aos Treinadores
            </a>
            <h2 style="margin-top:6px;"><%= nomeTreinador %></h2>
        </div>
    </div>

    <% if (mensagem != null) { %>
        <div class="alert-success"><i class="fas fa-check-circle"></i> <%= mensagem %></div>
    <% } %>

    <!-- INFORMAÇÕES DO TREINADOR -->
    <div class="card" style="margin-bottom:24px;">
        <div class="card-header-bar"><h3><i class="fas fa-user-tie"></i> Informações do Treinador</h3></div>
        <div style="padding:20px;">
            <form method="POST" action="treinador-detalhe.jsp?id=<%= treinadorId %>" style="display:flex;gap:16px;align-items:flex-end;">
                <input type="hidden" name="acao" value="editar-treinador">
                <div class="form-group" style="flex:1;margin:0;">
                    <label>Nome completo</label>
                    <input type="text" name="nome" value="<%= nomeTreinador %>" required>
                </div>
                <button type="submit" class="btn btn-primary" style="height:42px;">
                    <i class="fas fa-check"></i> Guardar
                </button>
            </form>
        </div>
    </div>

    <!-- ESCALÕES ATRIBUÍDOS -->
    <div class="card">
        <div class="card-header-bar"><h3><i class="fas fa-layer-group"></i> Escalões Atribuídos</h3></div>
        <table>
            <thead>
                <tr><th>Nome</th><th style="width:60px;"></th></tr>
            </thead>
            <tbody>
            <% if (!rsEsc.isBeforeFirst()) { %>
                <tr><td colspan="2" style="color:#9ca3af;font-style:italic;padding:16px 20px;">Nenhum escalão atribuído.</td></tr>
            <% }
            while (rsEsc.next()) {
                int    eid   = rsEsc.getInt("id");
                String enome = rsEsc.getString("nome");
            %>
                <tr>
                    <td><strong><%= enome %></strong></td>
                    <td>
                        <a href="treinador-detalhe.jsp?id=<%= treinadorId %>&acao=apagar-escalao&eid=<%= eid %>"
                           class="btn btn-danger"
                           style="padding:5px 10px;"
                           onclick="return confirm('Remover <%= enome %>?')">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
            <% } rsEsc.close(); psEsc.close(); conn.close(); %>
            </tbody>
        </table>
        <div style="padding:16px 20px;border-top:1px solid #f3f4f6;">
            <% if (dispIds.isEmpty()) { %>
                <p style="color:#9ca3af;font-size:13px;font-style:italic;">
                    Todos os escalões já estão atribuídos a este treinador.
                </p>
            <% } else { %>
                <form method="POST" action="treinador-detalhe.jsp?id=<%= treinadorId %>" style="display:flex;gap:10px;">
                    <input type="hidden" name="acao" value="adicionar-escalao">
                    <select name="escalao_id" required
                            style="flex:1;padding:8px 12px;border:1.5px solid #e5e7eb;border-radius:8px;font-family:'Poppins',sans-serif;font-size:13px;outline:none;">
                        <option value="">-- Selecionar escalão --</option>
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

</main>

</body>
</html>
