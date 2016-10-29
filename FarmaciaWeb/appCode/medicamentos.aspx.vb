Public Class medicamentos
    Inherits System.Web.UI.Page
    Dim UsuarioBE As BE.Usuario
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim PatenteBE As New BE.Patente
        UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
        PatenteBE.Nombre = "Medicamento"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) = False) Then
            MsgBox("Sus permisos han sido modificados, por favor inicie sesion nuevamente", MsgBoxStyle.Critical, "Error")
            Response.Redirect("logout.aspx")
        End If
        ObtenerMedicamentos()
    End Sub

    Public Sub ObtenerMedicamentos()
        Dim ClienteBE As New BE.Cliente
        dgMedicamentos.DataSource = BLL.Medicamento.GetInstance.ListAll()
        dgMedicamentos.DataBind()
    End Sub

End Class