<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master"  CodeBehind="ventas.aspx.vb" Inherits="FarmaciaWeb.ventas" %>
<%@ Import Namespace="BLL.Seguridad"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">CALCULAR PRECIO DE VENTA</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Medicamentos
                        </div>
                        <!-- /.panel-heading -->
                    <div class="panel panel-body">
                        <div class="form-group">
                            <label>medicamento:</label>
                             <asp:DropDownList ID="cmbMedicamentos" runat="server">
                            </asp:DropDownList>
                            <label>Cantidad:</label>
                             <asp:TextBox ID="cantidad" runat="server"></asp:TextBox>
                        </div>
                    <asp:Button ID="btnCalcular" runat="server" Text="Calcular" class="btn btn-primary"  />
                    </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
         </div>
        <!-- /#page-wrapper -->

        <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
        $(document).ready(function () {
            $('#dgUsuarios').DataTable({
                responsive: true
            });
        });
    </script>
</asp:Content>
