<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="medicamentos.aspx.vb" Inherits="FarmaciaWeb.medicamentos" %>
<%@ Import Namespace="BLL.Seguridad"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Administrar Medicamentos</h1>
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
                        <div class="panel-body">
                            <div class="dataTable_wrapper">
                            <asp:GridView ID="dgMedicamentos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover">
                                <Columns>
                                    <asp:TemplateField HeaderText="Laboratorio">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNombreLaboratorio" runat="server" Text='<%# Eval("NombreLaboratorio")%>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="150px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Medicamento">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNombreMedicamento" runat="server" Text='<%# Eval("descripcion") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="150px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Cantidad">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCantidad" runat="server" Text='<%# BLL.Seguridad.GetInstance().DesencriptarRSA(Eval("cantidad")) %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="150px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Precio">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPrecio" runat="server" Text='<%# BLL.Seguridad.GetInstance().DesencriptarRSA(Eval("precio")) %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="150px" />
                                    </asp:TemplateField>
                                    <asp:CommandField ButtonType="Button" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150">
                                        <ItemStyle Width="150px"></ItemStyle>
                                    </asp:CommandField>
                                </Columns>
                              </asp:GridView>
                               </div>
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
