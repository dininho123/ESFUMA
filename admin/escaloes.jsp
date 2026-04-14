<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="auth.jsp" %>
<%@ include file="/includes/db.jsp" %>
<%
    String mensagem = null;
    String tipoMensagem = "success";

    // ── APAGAR ──────────────────────────────────────────
    if ("apagar".equals(request.getParameter("acao"))) {
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM escaloes WHERE id = ?");
        ps.setInt(1, id);
        ps.executeUpdate();
        ps.close(); conn.close();
        mensagem = "Escalão apagado com sucesso.";
    }

    // ── ADICIONAR ────────────────────────────────────────
    if ("POST".equals(request.getMethod()) && "adicionar".equals(request.getParameter("acao"))) {
        String nome    = request.getParameter("nome").trim();
        int idadeMax   = Integer.parseInt(request.getParameter("idade_max"));

        if (!nome.isEmpty()) {
            Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO escaloes (nome, idade_max) VALUES (?, ?)"
            );
            ps.setString(1, nome);
            ps.setInt(2, idadeMax);
            ps.executeUpdate();
            ps.close(); conn.close();
            mensagem = "Escalão \"" + nome + "\" adicionado com sucesso.";
        }
    }

    // ── EDITAR ───────────────────────────────────────────
    if ("POST".equals(request.getMethod()) && "editar".equals(request.getParameter("acao"))) {
        int    id      = Integer.parseInt(request.getParameter("id"));
        String nome    = request.getParameter("nome").trim();
        int    idadeMax = Integer.parseInt(request.getParameter("idade_max"));

        Connection conn = getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "UPDATE escaloes SET nome = ?, idade_max = ? WHERE id = ?"
        );
        ps.setString(1, nome);
        ps.setInt(2, idadeMax);
        ps.setInt(3, id);
        ps.executeUpdate();
        ps.close(); conn.close();
        mensagem = "Escalão atualizado com sucesso.";
    }

    // ── LISTAR ───────────────────────────────────────────
    Connection conn = getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT id, nome, idade_max, ativo FROM escaloes ORDER BY idade_max ASC"
    );
    ResultSet rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ESFUMA — Escalões</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="icon" type="image/png" href="../img/logo_escola_1.png">
    <link rel="stylesheet" href="admin.css">
</head>
<body>

<%@ include file="sidebar.jsp" %>

<main class="main-content">
    <div class="page-header">
        <h2>Escalões</h2>
        <p>Adiciona, edita ou apaga escalões.</p>
    </div>

    <% if (mensagem != null) { %>
        <div class="alert-<%= tipoMensagem %>"><%= mensagem %></div>
    <% } %>

    <div style="display: grid; grid-template-columns: 1fr 340px; gap: 24px; align-items: start;">

        <!-- TABELA -->
        <div class="card">
            <div class="card-header-bar">
                <h3>Lista de Escalões</h3>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Idade máx.</th>
                        <th>Estado</th>
                        <th style="width:120px;">Ações</th>
                    </tr>
                </thead>
                <tbody>
                <% while (rs.next()) {
                    int    eid    = rs.getInt("id");
                    String enome  = rs.getString("nome");
                    int    eidade = rs.getInt("idade_max");
                    boolean eativo = rs.getBoolean("ativo");
                %>
                    <tr>
                        <td><strong><%= enome %></strong></td>
                        <td>Sub-<%= eidade %></td>
                        <td>
                            <span style="
                                background: <%= eativo ? "#dcfce7" : "#fee2e2" %>;
                                color: <%= eativo ? "#166534" : "#991b1b" %>;
                                padding: 3px 10px; border-radius: 20px; font-size: 12px; font-weight: 600;">
                                <%= eativo ? "Ativo" : "Inativo" %>
                            </span>
                        </td>
                        <td>
                            <div style="display:flex;gap:8px;">
                            <a href="escalao-detalhe.jsp?id=<%= eid %>" class="btn btn-primary">
                                <i class="fas fa-pen"></i> Gerir
                            </a>
                            <a href="escaloes.jsp?acao=apagar&id=<%= eid %>"
                               class="btn btn-danger"
                               onclick="return confirm('Apagar <%= enome %>? Os treinadores e horários associados também serão apagados.')">
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
        <div style="display: flex; flex-direction: column; gap: 20px;">

            <!-- Adicionar -->
            <div class="card" id="form-adicionar">
                <div class="card-header-bar"><h3><i class="fas fa-plus"></i> Novo Escalão</h3></div>
                <div style="padding: 20px;">
                    <form method="POST" action="escaloes.jsp">
                        <input type="hidden" name="acao" value="adicionar">
                        <div class="form-group">
                            <label>Nome</label>
                            <input type="text" name="nome" placeholder="Ex: Sub-14" required>
                        </div>
                        <div class="form-group">
                            <label>Idade máxima</label>
                            <input type="number" name="idade_max" min="3" max="25" placeholder="Ex: 14" required>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width:100%;">
                            <i class="fas fa-plus"></i> Adicionar
                        </button>
                    </form>
                </div>
            </div>

            <!-- Editar (oculto até clicar) -->
            <div class="card" id="form-editar" style="display: none;">
                <div class="card-header-bar"><h3><i class="fas fa-pen"></i> Editar Escalão</h3></div>
                <div style="padding: 20px;">
                    <form method="POST" action="escaloes.jsp">
                        <input type="hidden" name="acao" value="editar">
                        <input type="hidden" name="id"   id="editar-id">
                        <div class="form-group">
                            <label>Nome</label>
                            <input type="text" name="nome" id="editar-nome" required>
                        </div>
                        <div class="form-group">
                            <label>Idade máxima</label>
                            <input type="number" name="idade_max" id="editar-idade" min="3" max="25" required>
                        </div>
                        <div style="display: flex; gap: 10px;">
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
function abrirEditar(id, nome, idade) {
    document.getElementById('editar-id').value    = id;
    document.getElementById('editar-nome').value  = nome;
    document.getElementById('editar-idade').value = idade;
    document.getElementById('form-editar').style.display = 'block';
    document.getElementById('form-editar').scrollIntoView({ behavior: 'smooth' });
}
function fecharEditar() {
    document.getElementById('form-editar').style.display = 'none';
}
</script>

</body>
</html>
