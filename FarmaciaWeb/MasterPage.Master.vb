Public Class MasterPage
    Inherits System.Web.UI.MasterPage

    Dim UsuarioBE As BE.Usuario
    Dim BitacoraBE As New BE.Bitacora
    Dim PatenteBE As New BE.Patente

    Public Sub ValidarMenu()
        PatenteBE.Nombre = "Usuario"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            LinkSeguridad.Visible = True
            LinkUsuarios.Visible = True
            LinkFamilias.Visible = True
        End If

        PatenteBE.Nombre = "Familia"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            LinkSeguridad.Visible = True
            LinkFamilias.Visible = True
        End If

        PatenteBE.Nombre = "Backup"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            LinkSeguridad.Visible = True
            LinkBackup.Visible = True
        End If

        PatenteBE.Nombre = "Restore"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            LinkSeguridad.Visible = True
            LinkRestaurar.Visible = True
        End If

        PatenteBE.Nombre = "Bitacora"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            LinkSeguridad.Visible = True
            LinkBitacora.Visible = True
        End If

        PatenteBE.Nombre = "Venta"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            LinkVentas.Visible = True
        End If

        PatenteBE.Nombre = "Cliente"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            LinkClientes.Visible = True
        End If

        PatenteBE.Nombre = "Medicamento"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) Then
            LinkMedicamentos.Visible = True
        End If
    End Sub
 
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
        userLogin.Text = BLL.Seguridad.GetInstance.DesencriptarRSA(UsuarioBE.NombreUsuario)
        ValidarMenu()
    End Sub

End Class