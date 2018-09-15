<%-- 
    Document   : amortizacao-constante
    Created on : 01/09/2018, 21:54:12
    Author     : safju
--%>

<%@page import="java.text.DecimalFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>
<div class="col-md-12 mt-4">
    <div class="card">
        <div class="card-header text-center">
            <h5>Amortização Constante</h5>
        </div>
        <div class="card-body">
            <form class="col-md-9" style="margin: 0 auto;">
                <div class="form-group">
                    <label for="valor">Valor financiado</label>
                    <input type="number" class="form-control" name="valor"/>
                </div>
                <div class="form-group">
                    <label for="meses">Meses</label>
                    <input type="number" class="form-control" name="meses"/>
                </div>
                <div class="form-group">
                    <label for="juros">Taxa de juros</label>
                    <input type="number" class="form-control" name="juros"/>
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
    double valor = Double.parseDouble(request.getParameter("valor"));
    int meses = Integer.parseInt(request.getParameter("meses"));
    double juros = Double.parseDouble(request.getParameter("juros")) / 100;
    DecimalFormat formatar = new DecimalFormat("0.##");
    double amortizacao = valor / meses;
    double aux1 = 0, aux2 = 0, aux3 = 0;
%>
<div class="col-md-12 mt-4">
    <table class="table table-dark">
        <tr>
            <th>#</th>
            <th>Parcelas</th>
            <th>Amortização</th>
            <th>Juros</th>
            <th>Saldo devedor</th>
        </tr>
        <tr>
                <% for (int i = 0; i < meses; i++) {
                            double saldoDevedor = (valor - i * amortizacao);
                            double parcela = amortizacao + (juros * saldoDevedor);
                    %>
        <tr>
            <td><%= (i + 1)%>
            </td>
            <td><%= formatar.format(parcela)%>
            </td>
            <td><%= formatar.format(amortizacao)%>
            </td>
            <td><%= formatar.format(saldoDevedor * juros)%>
            </td>
            <td><%= formatar.format(saldoDevedor - amortizacao)%>
            </td>
        </tr>
        <% aux1 = aux1 + parcela;
            aux2 = aux2 + amortizacao;
            aux3 = aux3 + (saldoDevedor * juros);
            ;
        }%>
        <tr class="bg-danger">
            <td><strong>Total</strong></td>
            <td><%= formatar.format(aux1) %>
            </td>
            <td><%= formatar.format(aux2) %>
            </td>
            <td><%= aux3 %>
            </td>
            <th>-</th>
        </tr>
        <% } %>
    </table>
</div>
<%@ include file="WEB-INF/jspf/footer.jspf" %>
