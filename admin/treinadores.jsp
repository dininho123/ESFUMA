<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="auth.jsp" %>
<%@ include file="/includes/db.jsp" %>
<%
    String mensagem = null;

    // ── APAGAR ──────────────────────────────────────────
    if ("apagar".equals(request.getParameter("acao"))) {
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM treinadores WHERE id = ?");
        ps.setInt(1, id);
        ps.executeUpdate();
        ps.close(); conn.close();
        mensagem = "Treinador apagado.";
    }

    // ── ADICIONAR ────────────────────────────────────────
    if ("POST".equals(request.getMethod()) && "adicionar".equals(request.getParameter("acao"))) {
        String nome = request.getParameter("nome").trim();
        if (!nome.isEmpty()) {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO treinadores (nome) VALUES (?)"
            );
            ps.setString(1, nome);
            ps.executeUpdate();
            ps.close(); conn.close();
            mensagem = "Treinador \"" + nome + "\" adicionado.";
        }
    }

    // ── EDITAR ───────────────────────────────────────────
    if ("POST".equals(request.getMethod()) && "editar".equals(request.getParameter("acao"))) {
        int    id   = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome").trim();
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE treinadores SET nome = ? WHERE id = ?"
        );
        ps.setString(1, nome);
        ps.setInt(2, id);
        ps.executeUpdate();
        ps.close(); conn.close();
        mensagem = "Treinador atualizado.";
    }

    // ── LISTAR ───────────────────────────────────────────
    Connection conn = getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT t.id, t.nome, " +
        "GROUP_CONCAT(e.nome ORDER BY e.idade_max SEPARATOR ', ') AS escaloes " +
        "FROM treinadores t " +
        "LEFT JOIN escalao_treinador et ON t.id = et.treinador_id " +
        "LEFT JOIN escaloes e ON et.escalao_id = e.id " +
        "GROUP BY t.id, t.nome ORDER BY t.nome ASC"
    );
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ESFUMA — Treinadores</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="icon" type="image/png" href="../img/logo_escola_1.png">
    <link rel="stylesheet" href="admin.css">
</head>
<body>

<%@ include file="sidebar.jsp" %>

<main class="main-content">
    <div class="page-header">
        <h2>Treinadores</h2>
        <p>Adiciona, edita ou apaga treinadores.</p>    </div>

    <% if (mensagem != null) { %>
        <div class="alert-success"><i class="fas fa-check-circle"></i> <%= mensagem %></div>
    <% } %>

    <div style="display:grid;grid-template-columns:1fr 320px;gap:24px;align-items:start;">

        <!-- TABELA -->
        <div class="card">
            <div class="card-header-bar"><h3>Lista de Treinadores</h3></div>
            <table>
                <thead>
                    <tr><th>Nome</th><th>Escalões atribuídos</th><th style="width:120px;">Ações</th></tr>
                </thead>
                <tbody>
                <% while (rs.next()) {
                    int    tid      = rs.getInt("id");
                    String tnome    = rs.getString("nome");
                    String tescalao = rs.getString("escaloes");
                %>
                    <tr>
                        <td><strong><%= tnome %></strong></td>
                        <td>
                            <% if (tescalao != null) { %>
                                <span style="background:#f0fdf4;color:#166534;padding:3px 10px;border-radius:20px;font-size:12px;font-weight:600;"><%= tescalao %></span>
                            <% } else { %>
                                <span style="color:#9ca3af;font-size:13px;font-style:italic;">Sem escalão</span>
                            <% } %>
                        </td>
                        <td>
                            <div style="display:flex;gap:8px;">
                            <a href="treinador-detalhe.jsp?id=<%= tid %>" class="btn btn-primary">
                                <i class="fas fa-pen"></i> Gerir
                            </a>
                            <a href="treinadores.jsp?acao=apagar&id=<%= tid %>"
                               class="btn btn-danger"
                               onclick="return confirm('Apagar <%= tnome %>? Será removido de todos os escalões.')">
                                <i class="fas fa-trash"></i>
                            </a>
                            </div>
                        </td>
                    </tr>
                <% } rs.close(); ps.close(); conn.close(); %>
                </tbody>
            </table>
        </div>

        <!-- FORMULÁRIOS -->
        <div style="display:flex;flex-direction:column;gap:20px;">

            <!-- Adicionar -->
            <div class="card">
                <div class="card-header-bar"><h3><i class="fas fa-plus"></i> Novo Treinador</h3></div>
                <div style="padding:20px;">
                    <form method="POST" action="treinadores.jsp">
                        <input type="hidden" name="acao" value="adicionar">
                        <div class="form-group">
                            <label>Nome completo</label>
                            <input type="text" name="nome" placeholder="Ex: João Silva" required>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width:100%;">
                            <i class="fas fa-plus"></i> Adicionar
                        </button>
                    </form>
                </div>
            </div>

            <!-- Editar -->
            <div class="card" id="form-editar" style="display:none;">
                <div class="card-header-bar"><h3><i class="fas fa-pen"></i> Editar Treinador</h3></div>
                <div style="padding:20px;">
                    <form method="POST" action="treinadores.jsp">
                        <input type="hidden" name="acao" value="editar">
                        <input type="hidden" name="id"   id="editar-id">
                        <div class="form-group">
                            <label>Nome completo</label>
                            <input type="text" name="nome" id="editar-nome" required>
                        </div>
                        <div style="display:flex;gap:10px;">
                            <button type="submit" class="btn btn-primary" style="flex:1;">
                                <i class="fas fa-check"></i> Guardar
                            </button>
                            <button type="button" class="btn btn-secondary" onclick="fecharEditar()">
                                Cancelar
                            </button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</main>

<script>
function fecharEditar() {
    document.getElementById('form-editar').style.display = 'none';
}
</script>

</body>
</html>
