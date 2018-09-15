<%-- 
    Document   : tabela-price
    Created on : 02/09/2018, 00:12:47
    Author     : safju
--%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.lang.Math" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>
<div class="col-md-12 mt-4">
    <div class="card">
        <div class="card-header text-center">
            <h5>Tabela Price</h5>
        </div>
        <div class="card-body">
            <form class="col-md-9" style="margin: 0 auto;">
                <div class="form-group">
                    <label for="valor">Valor financiado</label>
                    <input type="text" class="form-control" name="valor"/>
                </div>
                <div class="form-group">
                    <label for="meses">Meses</label>
                    <input type="text" class="form-control" name="meses"/>
                </div>
                <div class="form-group">
                    <label for="juros">Taxa de juros</label>
                    <input type="text" class="form-control" name="juros"/>
                </div>
                <input type="submit" class="btn btn-success" name="enviar" value="Calcular"/>
                <input type="reset" class="btn btn-danger" name="" value="Resetar"/>
            </form>
        </div>
    </div>
</div>
<% if (request.getParameter("valor") != null
        & request.getParameter("meses") != null
        & request.getParameter("juros") != null) {
    double valorPresente = Double.parseDouble(request.getParameter("valor"));
    int meses = Integer.parseInt(request.getParameter("meses"));
    double taxa = Double.parseDouble(request.getParameter("juros")) / 100;
    DecimalFormat formatar = new DecimalFormat("0.##");
    double juros = 0, soma1 = 0, somaJuros = 0, somaValor = 0, saldoDevedor = 0, parcela = 0, amortizacao = 0;
    saldoDevedor = valorPresente;
%>
<div class="col-md-12 mt-4">
    <table class="table table-dark">
        <thead>
            <tr>
                <th>Período</th>
                <th>Saldo devedor</th>
                <th>Parcela</th>
                <th>Juros</th>
                <th>Amortização</th>
            </tr>
        </thead>

        <tbody>
            <% for (int i = 0; i <= meses; i++) { %>
            <tr>
                <th><%= i %>
                </th>
                <td><%= formatar.format(saldoDevedor)%>
                </td>
                <td><%= formatar.format(parcela)%>
                </td>
                <td><%= formatar.format(juros)%>
                </td>
                <td><%= formatar.format(amortizacao)%>
                </td>
            </tr>
            <%
                    parcela = valorPresente * taxa / (1 - (1 / (Math.pow((1 + taxa), meses))));
                    juros = saldoDevedor * taxa;
                    amortizacao = parcela - juros;
                    saldoDevedor = saldoDevedor - amortizacao;
                    somaJuros += juros;
                }%>
            <tr class="bg-danger">
                <td colspan="1">Total Pago:
                </td>
                <td class="text-center" colspan="4"><%=formatar.format(valorPresente + somaJuros)%></td>
            </tr>
            <% }%>
        </tbody>
    </table>
</div>
<%@ include file="WEB-INF/jspf/footer.jspf" %>
