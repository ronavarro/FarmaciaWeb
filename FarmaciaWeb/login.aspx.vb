Public Class login
    Inherits System.Web.UI.Page

    Dim UsuarioBLL As New BLL.Usuario
    Dim DVH_BLL As New BLL.DVH
    Dim BitacoraBE As New BE.Bitacora
    Dim UsuarioBE As New BE.Usuario
 
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        If Trim(txtUsuario.Text) = "" Then
            errorMsj.Text = "Ingrese el usuario!"
            showErroMsj("show")
        Else
            If txtContraseña.Text = "" Then
                errorMsj.Text = "Ingrese la Contraseña!"
                showErroMsj("show")
            Else
                LogIn()
            End If
        End If
    End Sub


    Public Sub showErroMsj(active As String)
        Dim sb As New System.Text.StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("document.getElementsByClassName('alert-danger')[0].className = 'alert alert-danger " + active + "'")
        sb.Append("</script>")
        ClientScript.RegisterClientScriptBlock(Me.GetType(), "", sb.ToString())
    End Sub

    Public Sub showOkMsj(active As String)
        Dim sb As New System.Text.StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("document.getElementsByClassName('alert-success')[0].className = 'alert alert-success " + active + "'")
        sb.Append("</script>")
        ClientScript.RegisterClientScriptBlock(Me.GetType(), "", sb.ToString())
    End Sub

    Public Sub LogIn()
        Dim entro As Boolean = True
        UsuarioBE.NombreUsuario = BLL.Seguridad.GetInstance.EncriptarRSA(Trim(txtUsuario.Text))
        UsuarioBE = BLL.Usuario.GetInstance.ValidarContraseña(UsuarioBE)
        If UsuarioBE.UsuarioId = 0 Then
            RegistrarBitacora("Ingreso Incorrecto: " & txtUsuario.Text, "Media")
            txtContraseña.Text = ""
            errorMsj.Text = "Ingreso incorrecto a la apliacion, por favor intentelo de nuevo!"
            showErroMsj("show")
        Else
            If UsuarioBE.Eliminado = True Then
                txtUsuario.Text = ""
                txtContraseña.Text = ""
                txtUsuario.Focus()
                errorMsj.Text = "El usuario se encuentra eliminado. Contacte al Administrador."
                showErroMsj("show")
            Else
                If UsuarioBE.Bloqueado = True Then
                    txtUsuario.Text = ""
                    txtContraseña.Text = ""
                    txtUsuario.Focus()
                    errorMsj.Text = "El usuario se encuentra bloqueado. Contacte al Administrador."
                    showErroMsj("show")
                Else
                    If UsuarioBE.Contraseña = BLL.Seguridad.GetInstance.EncriptarMD5(Trim(txtContraseña.Text)) Then
                        If UsuarioBE.Eliminado = False Then
                            If (DVH_BLL.VerificarDVH(UsuarioBE) = False) Then
                                Dim PatenteBE As New BE.Patente
                                PatenteBE.Nombre = "RecalcularDV"
                                PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
                                If UsuarioBLL.VerificarPatente(UsuarioBE, PatenteBE) Then
                                    If MsgBox("Error al verificar la integridad de la Base de Datos. ¿Desea Recalcular los Digitos Verificadores? ", MsgBoxStyle.YesNo, "Confirmacion") = MsgBoxResult.Yes Then

                                        DVH_BLL.RecalcularDVH()
                                    Else
                                        entro = False
                                    End If
                                Else
                                    errorMsj.Text = "Error al verificar la integridad de la Base de Datos. Por favor a contacte al Administrador del sistema."
                                    showErroMsj("show")
                                    entro = False
                                End If
                            End If
                            If entro Then
                                UsuarioBE.Cci = 0
                                BLL.Usuario.GetInstance.Update(UsuarioBE)
                                RegistrarBitacora("LogIn", "Baja")
                                txtUsuario.Text = ""
                                txtContraseña.Text = ""
                                Session("UsuarioBE") = UsuarioBE
                                Response.Redirect("~/appCode/index.aspx")
                            End If
                        End If
                    Else
                        UsuarioBE.Cci = UsuarioBE.Cci + 1
                        BLL.Usuario.GetInstance.Update(UsuarioBE)
                        If UsuarioBE.Cci >= 3 Then
                            If UsuarioBLL.ValidarEliminarUsuario(UsuarioBE) Then
                                UsuarioBE.Bloqueado = True
                                BLL.Usuario.GetInstance.BloquearDesbloquearUsuario(UsuarioBE)
                                errorMsj.Text = "Contraseña incorrecta. El usuario ha sido bloqueado!"
                                showErroMsj("show")
                                RegistrarBitacora("Se bloqueo el usuario:" & txtUsuario.Text, "Alta")
                            Else
                                UsuarioBE.Contraseña = BLL.Seguridad.GetInstance.EncriptarMD5(Trim(BLL.Seguridad.GetInstance.AutoGenerarContraseña(UsuarioBE, True)))
                                UsuarioBE.Cci = 0
                                BLL.Usuario.GetInstance.Update(UsuarioBE)
                                RegistrarBitacora("Modifico Usuario (restablecio la contraseña): " & txtUsuario.Text, "Alta")
                                errorMsj.Text = "Contraseña incorrecta, Como el usuario contiene patentes esenciales se restableció la contraseña!"
                                showErroMsj("show")
                                RegistrarBitacora("Ingreso incorrecto contraseña:" & txtUsuario.Text, "Media")
                            End If
                        Else
                            RegistrarBitacora("Ingreso incorrecto contraseña:" & txtUsuario.Text, "Media")
                            txtContraseña.Text = ""
                            errorMsj.Text = "Contraseña incorrecta!"
                            showErroMsj("show")
                        End If
                    End If
                    End If
            End If
        End If
    End Sub

    Public Sub RegistrarBitacora(evento As String, nivel As String)
        BitacoraBE.Descripcion = BLL.Seguridad.GetInstance.EncriptarRSA(evento)
        BitacoraBE.usuario = UsuarioBE
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE)
    End Sub
 

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

    End Sub
End Class