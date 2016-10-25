Public Class backup
    Inherits System.Web.UI.Page
    Dim UsuarioBE As BE.Usuario
    Dim BackupBLL As New BLL.Backup
    Dim BitacoraBE As New BE.Bitacora
 
 
    Private Function Validar() As Boolean
        Dim valido = True
        If ruta.Text = "" Then
            valido = False
            MsgBox("Ingrese la ruta!", MsgBoxStyle.Critical, "Error")
        End If
        Return valido
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim PatenteBE As New BE.Patente
        UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
        PatenteBE.Nombre = "Backup"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) = False) Then
            MsgBox("Sus permisos han sido modificados, por favor inicie sesion nuevamente", MsgBoxStyle.Critical, "Error")
            Response.Redirect("logout.aspx")
        End If
    End Sub

    Protected Sub btnBackup_Click(sender As Object, e As EventArgs) Handles btnBackup.Click
        If Validar() Then
            DescargarRar()
        End If
    End Sub

    Public Sub DescargarRar()
        If ruta.Text <> "" Then
            Dim BackupBE As New BE.Backup
            BackupBE.ubicacion = ruta.Text
            Dim valor = 0
            BackupBE.cantidad = 1
            valor = 1
            If (BackupBLL.GenerarRar(BackupBE)) Then
                RegistrarBitacora("Se hizo un backup del sistema", "Media")
                MsgBox("El backup fue hecho con exito", MsgBoxStyle.DefaultButton1, "Backup")
            Else
                MsgBox("El backup no puede realizarse en el directorio indicado, por favor seleccione otro", MsgBoxStyle.Critical, "Error")
            End If
        End If
    End Sub

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        BitacoraBE.Descripcion = BLL.Seguridad.GetInstance.EncriptarRSA(evento)
        BitacoraBE.usuario = UsuarioBE
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub
End Class