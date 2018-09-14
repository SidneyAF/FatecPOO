<%-- 
    Document   : amortizacao-americana
    Created on : 14/09/2018, 19:38:52
    Author     : Weslley
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
        <h1>Amortização Americana</h1>
        <form>
            Valor financiado <input type="text" name="valor"/>
            Meses <input type="text" name="meses"/>
            Taxa de juros <input type="text" name="juros"/>
            <input type="submit" name="enviar" value="Enviar"/>
            
            <%  if (request.getParameter("valor") != null
                        & request.getParameter("meses") != null
                        & request.getParameter("juros") != null) {
                    double valor = Double.parseDouble(request.getParameter("valor"));
                    int meses = Integer.parseInt(request.getParameter("meses"));
                    double juros = Double.parseDouble(request.getParameter("juros")) / 100;
                    DecimalFormat formatar = new DecimalFormat("0.##");
                    double amortizacao = 0, aux1 = 0, aux2 = 0, aux3 = 0;
            %>
            <br><br>
            <table border="1">
                <tr>
                    <th>#</th><th>Parcelas</th><th>Amortização</th><th>Juros</th><th>Saldo devedor</th>
                </tr>
                <tr>
                    <% for (int i = 0; i < meses; i++) {
                            double parcela = valor * juros;
                            double saldoDevedor = valor;
                            if (i == (meses - 1)) {
                                parcela = parcela + valor;
                                amortizacao = valor;
                                saldoDevedor = saldoDevedor - valor;
                            }
                    %>
                <tr>
                    <td><%= (i + 1)%></td>
                    <td><%= formatar.format(parcela)%></td>
                    <td><%= formatar.format(amortizacao)%></td>
                    <td><%= formatar.format(valor * juros)%></td>
                    <td><%= formatar.format(saldoDevedor)%></td>
                </tr>
                <%  aux1 = aux1 + parcela;
                    aux2 = aux2 + amortizacao;
                    aux3 = aux3 + (valor * juros);
                    }%>
                <tr>
                    <th>#</th>
                    <td><%= aux1%></td>
                    <td><%= aux2%></td>
                    <td><%= aux3%></td>
                    <td><strong>Total</strong></td>
                </tr>
                <%}%>
            </table>
        </form>
    </body>
</html>
