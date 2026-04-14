<%--
    functions.jsp — equivalente ao functions.php
    Contém funções e classes auxiliares partilhadas
--%>
<%!
    // PHP: function anoNascimentoEscalao($idade) { ... }
    int anoNascimentoEscalao(int idade) {
        java.time.LocalDate hoje = java.time.LocalDate.now();
        int anoBase = (hoje.getMonthValue() < 7) ? hoje.getYear() : hoje.getYear() + 1;
        return anoBase - idade;
    }

    // Classes auxiliares para os escalões
    static class Treino {
        String dia, hora, local;
        Treino(String dia, String hora, String local) {
            this.dia = dia; this.hora = hora; this.local = local;
        }
    }

    static class Escalao {
        String nome;
        int idade;
        String[] treinadores;
        Treino[] treinos;
        Escalao(String nome, int idade, String[] treinadores, Treino[] treinos) {
            this.nome = nome;
            this.idade = idade;
            this.treinadores = treinadores;
            this.treinos = treinos;
        }
    }
%>
