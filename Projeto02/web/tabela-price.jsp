<%-- 
    Document   : tabela-price
    Created on : 02/09/2018, 00:12:47
    Author     : safju
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.lang.Math"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="WEB-INF/jspf/header.jspf" %>
        <h1>Tabela Price</h1>
        <form>
            Valor financiado <input type="text" name="valor"/>
            Meses <input type="text" name="meses"/>
            Taxa de juros <input type="text" name="juros"/>
            <input type="submit" name="enviar" value="Enviar"/>
            <a href="tabela-price.jsp">Resetar</a>
            <%  if (request.getParameter("valor") != null
                        & request.getParameter("meses") != null
                        & request.getParameter("juros") != null) {
                    double valorPresente = Double.parseDouble(request.getParameter("valor"));
                    int meses = Integer.parseInt(request.getParameter("meses"));
                    double taxa = Double.parseDouble(request.getParameter("juros")) / 100;
                    DecimalFormat formatar = new DecimalFormat("0.##");
                    double juros = 0, soma1 = 0, somaJuros = 0, somaValor = 0, saldoDevedor = 0, parcela = 0, amortizacao = 0;
                    saldoDevedor = valorPresente;
            %>
            <br><br>
            <table border="1">
                <tr>
                    <th>Período</th><th>Saldo devedor</th><th>Parcela</th><th>Juros</th><th>Amortização</th>
                </tr>


                <% for (int i = 0; i <= meses; i++) {


                %>
                <tr>
                    <td><%= i%></td>
                    <td><%= formatar.format(saldoDevedor)%></td>
                    <td><%= formatar.format(parcela)%></td>
                    <td><%= formatar.format(juros)%></td>
                    <td><%= formatar.format(amortizacao)%></td>
                </tr>
                <%
                        parcela = valorPresente * taxa / (1 - (1 / (Math.pow((1 + taxa), meses))));
                        juros = saldoDevedor * taxa;
                        amortizacao = parcela - juros;
                        saldoDevedor = saldoDevedor - amortizacao;
                        somaJuros+=juros;
                    }%>
                    <tr><td colspan="5">Total Pago:<%=formatar.format(valorPresente + somaJuros)%></td></tr>
                    
                    
                    
                <% }%>
                
            </table>
        </form>
<%@ include file="WEB-INF/jspf/footer.jspf" %>
