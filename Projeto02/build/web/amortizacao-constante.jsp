<%-- 
    Document   : amortizacao-constante
    Created on : 01/09/2018, 21:54:12
    Author     : safju
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@ include file="WEB-INF/jspf/menu.jspf" %>
        <h1>Amortização Constante</h1>
        <form>
            Valor financiado <input type="text" name="valor"/>
            Meses <input type="text" name="meses"/>
            Taxa de juros <input type="text" name="juros"/>
            <input type="submit" name="enviar" value="Enviar"/>
            <a href="amortizacao-constante.jsp">Resetar</a>
            <%  if (request.getParameter("valor") != null
                        & request.getParameter("meses") != null
                        & request.getParameter("juros") != null) {
                    double valor = Double.parseDouble(request.getParameter("valor"));
                    int meses = Integer.parseInt(request.getParameter("meses"));
                    double juros = Double.parseDouble(request.getParameter("juros")) / 100;
                    DecimalFormat formatar = new DecimalFormat("0.##");
                    double amortizacao = valor / meses;
                    double aux1 = 0, aux2 = 0, aux3 = 0;
            %>
            <br><br>
            <table border="1">
                <tr>
                    <th>#</th><th>Parcelas</th><th>Amortização</th><th>Juros</th><th>Saldo devedor</th>
                </tr>
                <tr>
                    <% for (int i = 0; i < meses; i++) {
                            double saldoDevedor = (valor - i * amortizacao);
                            double parcela = amortizacao + (juros * saldoDevedor);
                    %>
                <tr>
                    <td><%= (i + 1)%></td>
                    <td><%= formatar.format(parcela)%></td>
                    <td><%= formatar.format(amortizacao)%></td>
                    <td><%= formatar.format(saldoDevedor * juros)%></td>
                    <td><%= formatar.format(saldoDevedor - amortizacao)%></td>
                </tr>
                   <%  aux1=aux1+parcela;
                       aux2=aux2+amortizacao;
                      aux3=aux3+(saldoDevedor * juros);
                    ;}%>
                    <tr>
                        <th>#</th>
                        <td><%= aux1 %></td>
                        <td><%= formatar.format(aux2) %></td>
                        <td><%= aux3 %></td>
                        <td><strong>Total</strong></td>
                    </tr>
            <% } %>
            </table>
        </form>
    </body>
</html>
