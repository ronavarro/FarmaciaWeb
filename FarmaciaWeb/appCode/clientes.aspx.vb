Public Class clientes
    Inherits System.Web.UI.Page
    Dim UsuarioBE As BE.Usuario

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim PatenteBE As New BE.Patente
        UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
        PatenteBE.Nombre = "Cliente"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) = False) Then
            MsgBox("Sus permisos han sido modificados, por favor inicie sesion nuevamente", MsgBoxStyle.Critical, "Error")
            Response.Redirect("logout.aspx")
        End If
        ObtenerClientes()
    End Sub

    Public Sub ObtenerClientes()
        Dim ClienteBE As New BE.Cliente
        dgUsuarios.DataSource = BLL.Cliente.GetInstance.ListAll()
        dgUsuarios.DataBind()
    End Sub
End Class