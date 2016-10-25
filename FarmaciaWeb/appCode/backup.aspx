<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="backup.aspx.vb" Inherits="FarmaciaWeb.backup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Backup</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-body">
                        <div class="form-group">
                            <label>Ingrese el directorio donde desea realizar el Backup</label>
                             <asp:TextBox ID="ruta" runat="server"></asp:TextBox>
                        </div>
                    <asp:Button ID="btnBackup" runat="server" Text="Backup" class="btn btn-primary"  />
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div>

</asp:Content>