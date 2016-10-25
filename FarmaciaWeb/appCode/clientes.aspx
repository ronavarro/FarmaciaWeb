<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master"  CodeBehind="clientes.aspx.vb" Inherits="FarmaciaWeb.clientes" %>
<%@ Import Namespace="BLL.Seguridad"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Clientes</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Clientes
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="dataTable_wrapper">
                            <asp:GridView ID="dgUsuarios" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover">
                                <Columns>
                                    <asp:TemplateField HeaderText="clienteId" ItemStyle-Width="150">
                                        <ItemTemplate>
                                            <asp:Label ID="lblclienteId" runat="server" Text='<%# Eval("clienteId")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Nombre y Apellido">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNombreApellido" runat="server" Text='<%# Eval("nombre") & ", " & Eval("apellido")%>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="150px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="dni" ItemStyle-Width="150">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldni" runat="server" Text='<%# Eval("dni")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="email" ItemStyle-Width="150">
                                        <ItemTemplate>
                                            <asp:Label ID="lblemail" runat="server" Text='<%# Eval("email")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
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