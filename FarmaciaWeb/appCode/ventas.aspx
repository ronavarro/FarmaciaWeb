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
                            <label>Medicamento:</label>
                             <asp:DropDownList ID="cmbMedicamentos" runat="server">
                            </asp:DropDownList>
                            <label>Cantidad:</label>
                            <asp:TextBox ID="txtCantidad" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfCantidad" runat="server" ControlToValidate="txtCantidad" Display="Dynamic" Text="Debe ingresar una cantidad" ValidationGroup="vgMedicamentos" ></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="rgValidator" ControlToValidate="txtCantidad" runat="server" Type="Double" ValidationGroup="vgMedicamentos" Display="Dynamic" Text="Ingrese una cantidad entre 0 y 100" MaximumValue="100" MinimumValue="0"></asp:RangeValidator>

                        </div>
                    <asp:Button ID="btnCalcular" runat="server" Text="Calcular" class="btn btn-primary" ValidationGroup="vgMedicamentos" />
                    <asp:Button ID="btnAgregarMedicamento" runat="server" Text="Agregar Medicamento a XML" class="btn btn-primary"  ValidationGroup="vgMedicamentos" /> 
                    <asp:Button ID="btnLeerMedicamentos" runat="server" Text="Leer Medicamentos" class="btn btn-primary"  /> <br /> <br />
                    <asp:Label ID="lblPrecioVenta" Font-Bold="true" runat="server" Text=""></asp:Label>
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
