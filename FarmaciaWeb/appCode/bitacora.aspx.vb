Public Class bitacora
    Inherits System.Web.UI.Page
    Dim UsuarioBE As BE.Usuario

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim PatenteBE As New BE.Patente

        UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
        PatenteBE.Nombre = "Bitacora"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) = False) Then
            MsgBox("Sus permisos han sido modificados, por favor inicie sesion nuevamente", MsgBoxStyle.Critical, "Error")
            Response.Redirect("logout.aspx")
        End If
        MuestraCamposBitacora()
    End Sub


    Public Sub MuestraCamposBitacora()
        cmbUsuario.Items.Clear()

        Dim myList As New Dictionary(Of Integer, String)
        myList.Add(0, "Todos los Usuarios")
        For Each _UsuarioBE In BLL.Usuario.GetInstance.ListAll()
            myList.Add(_UsuarioBE.UsuarioId, BLL.Seguridad.GetInstance.DesencriptarRSA(_UsuarioBE.NombreUsuario))
        Next
        cmbUsuario.DataSource = myList.Values
        cmbUsuario.DataBind()

        Dim myListNivel As New Dictionary(Of String, String)
        myListNivel.Add("Todos los niveles", "Todos los niveles")
        myListNivel.Add("Alta", "Alta")
        myListNivel.Add("Media", "Media")
        myListNivel.Add("Baja", "Baja")

        cmbCriticidad.DataSource = myListNivel.Values
        cmbCriticidad.DataBind()
    End Sub

    Public Function ListarBitacoras()
        Dim fechaDesde = New DateTime(dtpFechaDesde.SelectedDate.Year, dtpFechaDesde.SelectedDate.Month, dtpFechaDesde.SelectedDate.Day, 0, 0, 0)
        Dim fechaHasta = New DateTime(dtpFechaHasta.SelectedDate.Year, dtpFechaHasta.SelectedDate.Month, dtpFechaHasta.SelectedDate.Day, 23, 59, 59)
        Dim bitacoras As New List(Of BE.Bitacora)

        bitacoras = BLL.Bitacora.GetInstance.ListarBitacoraPorParametros(cmbUsuario.SelectedIndex, fechaDesde, fechaHasta, cmbCriticidad.SelectedValue)
        dgBitacoras.DataSource = bitacoras
 
        dgBitacoras.DataBind()

        Return bitacoras
    End Function

 
    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        MsgBox(cmbUsuario.SelectedValue)
        ListarBitacoras()

    End Sub
End Class