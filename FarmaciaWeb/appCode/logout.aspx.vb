Public Class logout
    Inherits System.Web.UI.Page
    Dim UsuarioBE As BE.Usuario
    Dim BitacoraBE As New BE.Bitacora

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
        RegistrarBitacora("LogOut", "Baja")
        Session.Abandon()
        FormsAuthentication.SignOut()
        Response.Redirect("../login.aspx")
    End Sub


    Public Sub RegistrarBitacora(evento As String, nivel As String)
        BitacoraBE.Descripcion = BLL.Seguridad.GetInstance.EncriptarRSA(evento)
        BitacoraBE.usuario = UsuarioBE
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub
End Class