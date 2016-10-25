Public Class Restore
    Inherits System.Web.UI.Page
    Dim UsuarioBE As BE.Usuario
    Dim BackupBLL As New BLL.Backup
    Dim BitacoraBE As New BE.Bitacora

    Private Sub frmRestore_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Dim PatenteBE As New BE.Patente
        UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
        PatenteBE.Nombre = "Restore"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) = False) Then
            MsgBox("Sus permisos han sido modificados, por favor inicie sesion nuevamente", MsgBoxStyle.Critical, "Error")
            Response.Redirect("logout.aspx")
        End If
    End Sub

    Protected Sub btnRestore_Click(sender As Object, e As EventArgs) Handles btnRestore.Click
        If Validar() Then
            Dim BackupBE As New BE.Backup

            BackupBE.archivo = String.Format("{0}{1}", "D:\", FileUpload1.PostedFile.FileName)

            BackupBLL.ImportarRar(BackupBE)
            MsgBox("El restore fue hecho con exito", MsgBoxStyle.DefaultButton1, "Restore")
            RegistrarBitacora("Se hizo un restore del sistema", "Alta")
        End If
    End Sub
 
 
    Private Function Validar() As Boolean
        Dim valido = True
        If FileUpload1.HasFile = False Then
            valido = False
            MsgBox("Campo requerido")
        End If
        Return valido
    End Function

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        BitacoraBE.Descripcion = BLL.Seguridad.GetInstance.EncriptarRSA(evento)
        BitacoraBE.usuario = UsuarioBE
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'If FileUpload1.HasFile Then
        '    Dim LfilesInDir As New List(Of String)
        '    'For Each File In  Dir.
        '    '    Dim sinExt = File.Substring(0, File.Length - 4)
        '    '    If sinExt.EndsWith(".dbk") Then LfilesInDir.Add(sinExt)
        '    'Next
        '    LfilesInDir.Sort()
        '    lstArchivo.DataSource = Nothing
        '    lstArchivo.Items.Clear()
        '    lstArchivo.DataSource = LfilesInDir.Distinct().ToArray()
        'End If

    End Sub
End Class