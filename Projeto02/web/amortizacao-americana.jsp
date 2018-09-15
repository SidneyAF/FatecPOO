<%--
    Document   : amortizacao-americana
    Created on : 14/09/2018, 19:38:52
    Author     : Weslley
--%>


<%@page import="java.text.DecimalFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="WEB-INF/jspf/header.jspf" %>
<div class="col-md-12 mt-4">
    <div class="card">
        <div class="card-header text-center">
            <h5>Amortização Americana</h5>
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
    double valor = Double.parseDouble(request.getParameter("valor"));
    int meses = Integer.parseInt(request.getParameter("meses"));
    double juros = Double.parseDouble(request.getParameter("juros")) / 100;
    DecimalFormat formatar = new DecimalFormat("0.##");
    double amortizacao = 0, aux1 = 0, aux2 = 0, aux3 = 0;
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
                    double parcela = valor * juros;
                    double saldoDevedor = valor;
                    if (i == (meses - 1)) {
                        parcela = parcela + valor;
                        amortizacao = valor;
                        saldoDevedor = saldoDevedor - valor;
                    }
            %>
        <tr>
            <td><%= (i + 1)%>
            </td>
            <td><%= formatar.format(parcela)%>
            </td>
            <td><%= formatar.format(amortizacao)%>
            </td>
            <td><%= formatar.format(valor * juros)%>
            </td>
            <td><%= formatar.format(saldoDevedor)%>
            </td>
        </tr>
        <% aux1 = aux1 + parcela;
            aux2 = aux2 + amortizacao;
            aux3 = aux3 + (valor * juros);
        }%>
        <tr class="bg-danger">
            <td><strong>Total</strong></td>
            <td><%= aux1%>
            </td>
            <td><%= aux2%>
            </td>
            <td><%= aux3%>
            </td>
            <th>-</th>
        </tr>
        <%}%>
    </table>
</div>
<table border="1">

</table>
<%@ include file="WEB-INF/jspf/footer.jspf" %>
