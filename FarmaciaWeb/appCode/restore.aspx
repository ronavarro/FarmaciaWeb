<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/MasterPage.Master" CodeBehind="restore.aspx.vb" Inherits="FarmaciaWeb.Restore" %>

<%@ Import Namespace="BLL.Seguridad"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
            <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Restore</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Restore
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <asp:FileUpload ID="FileUpload1" runat="server" Width="489px"  />
                            <br />
                            <asp:Button ID="btnRestore" runat="server" Text="Restore" class="btn btn-primary"  />
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

 
</asp:Content>