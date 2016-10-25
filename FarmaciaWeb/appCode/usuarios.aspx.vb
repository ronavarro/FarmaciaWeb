Public Class usuarios
    Inherits System.Web.UI.Page
    Dim UsuarioBE As BE.Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim PatenteBE As New BE.Patente

        UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
        PatenteBE.Nombre = "Usuario"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) = False) Then
            MsgBox("Sus permisos han sido modificados, por favor inicie sesion nuevamente", MsgBoxStyle.Critical, "Error")
            Response.Redirect("logout.aspx")
        End If
        ObtenerUsuarios()
    End Sub

    Public Sub ObtenerUsuarios()
        Dim UsuarioBE As New BE.Usuario
        dgUsuarios.DataSource = BLL.Usuario.GetInstance.ListAll()
        dgUsuarios.DataBind()
    End Sub

    Protected Sub dgUsuarios_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dgUsuarios.SelectedIndexChanged

    End Sub
End Class

