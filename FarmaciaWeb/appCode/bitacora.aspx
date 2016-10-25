<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="bitacora.aspx.vb" Inherits="FarmaciaWeb.bitacora" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Bitacora</h1>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                        <div class="form-group">
                                            <label>Fecha Desde</label>
                                            <asp:Calendar ID="dtpFechaDesde" runat="server"></asp:Calendar>                
                                        </div>
                                </div>
                                <!-- /.col-lg-6 (nested) -->
                                <div class="col-lg-6">
                                        <div class="form-group">
                                            <label>Fecha Hasta</label>
                                            <asp:Calendar ID="dtpFechaHasta" runat="server"></asp:Calendar>
                                        </div>
                                </div>
                                <!-- /.col-lg-6 (nested) -->
                                <div class="col-lg-6">
                                        <div class="form-group">
                                            <label>Usuario</label>
                                            <asp:DropDownList ID="cmbUsuario" runat="server"></asp:DropDownList>
                                        </div>
                                        <div class="form-group">
                                            <label>Criticidad</label>
                                            <asp:DropDownList ID="cmbCriticidad" runat="server"></asp:DropDownList>
                                        </div>
                                        <asp:Button ID="btnBuscar" class="btn btn-default" runat="server" Text="Buscar" PostBackUrl="~/appCode/bitacora.aspx" />
                                </div>
                                <!-- /.col-lg-6 (nested) -->

                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /.panel-body -->
                </div>  
                <!-- /.col-lg-12 -->
            </div>            
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Bitacora
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="dataTable_wrapper">
                            <asp:GridView ID="dgBitacoras" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover">
                                <Columns>
                                    <asp:TemplateField HeaderText="bitacora_id" ItemStyle-Width="150">
                                        <ItemTemplate>
                                            <asp:Label ID="lblbitacora_id" runat="server" Text='<%# Eval("bitacora_id")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Usuario_id" ItemStyle-Width="150">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUsuarioId" runat="server" Text='<%# Eval("usuario.UsuarioId")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Usuario">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNombreUsuario" runat="server" Text='<%# BLL.Seguridad.GetInstance().DesencriptarRSA(Eval("usuario.NombreUsuario"))%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Descripcion">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescripcion" runat="server" Text='<%# BLL.Seguridad.GetInstance.DesencriptarRSA(Eval("Descripcion"))%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fecha_Hora">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFecha_Hora" runat="server" Text='<%# Eval("fecha")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Criticidad">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCriticidad" runat="server" Text='<%# Eval("Criticidad")%>'></asp:Label>
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
            $('#dgBitacoras').DataTable({
                responsive: true
            });
        });
    </script>

</asp:Content>

