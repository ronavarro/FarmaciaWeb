Imports System.Xml

Public Class ventas
    Inherits System.Web.UI.Page
    Dim UsuarioBE As BE.Usuario
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Not IsPostBack) Then
            Dim PatenteBE As New BE.Patente
            UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
            PatenteBE.Nombre = "Venta"
            PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
            If (BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) = False) Then
                MsgBox("Sus permisos han sido modificados, por favor inicie sesion nuevamente", MsgBoxStyle.Critical, "Error")
                Response.Redirect("logout.aspx")
            End If
            ObtenerMedicamentos()
        End If

    End Sub

    Public Sub ObtenerMedicamentos()

        Dim myList As New Dictionary(Of Integer, String)
         For Each _medicamentoBE In BLL.Medicamento.GetInstance.ListAll()
            myList.Add(_medicamentoBE.medicamentoId, (_medicamentoBE.descripcion))
        Next
        cmbMedicamentos.DataSource = myList.Values
        cmbMedicamentos.DataBind()

     End Sub


    Protected Sub btnLeer_Click(sender As Object, e As EventArgs) Handles btnLeerMedicamentos.Click
        Me.LeerXmlConReader()
    End Sub

    Protected Sub btnAgregarMedicamento_Click(sender As Object, e As EventArgs) Handles btnAgregarMedicamento.Click
        Me.ActualizarXml()
    End Sub

    Private Sub ActualizarXml()

        Dim medicamentosService As New MedicamentosService.MedicamentosServiceSoapClient

        Dim xmlDocument As New XmlDocument()
        xmlDocument.Load(Server.MapPath("medicamentos.xml"))

        Dim xmlMedicamento As XmlElement = xmlDocument.CreateElement("Medicamento")
        Dim xmlMedicamentoNombre As XmlElement = xmlDocument.CreateElement("NombreMedicamento")
        xmlMedicamento.AppendChild(xmlMedicamentoNombre)
        xmlMedicamentoNombre.InnerText = Me.cmbMedicamentos.SelectedItem.Text
        Dim xmlPrecioUnitario As XmlElement = xmlDocument.CreateElement("PrecioUnitario")
        xmlPrecioUnitario.InnerText = medicamentosService.ObtenerPrecioUnitario(Me.cmbMedicamentos.SelectedItem.Text)
        xmlMedicamento.AppendChild(xmlPrecioUnitario)
        Dim xmlCantidad As XmlElement = xmlDocument.CreateElement("Cantidad")
        xmlCantidad.InnerText = Me.txtCantidad.Text
        xmlMedicamento.AppendChild(xmlCantidad)

        xmlDocument.DocumentElement.AppendChild(xmlMedicamento)

        xmlDocument.Save(Server.MapPath("medicamentos.xml"))

    End Sub

    Private Sub LeerXmlConReader()
        Dim milector As New XmlTextReader(Server.MapPath("medicamentos.xml"))

        Dim n As Integer
        While milector.Read()
            Response.Write(milector.NodeType.ToString + ":" +
                           milector.Name + ":" + milector.Value + "<br/>")
            If milector.HasAttributes Then
                For n = 0 To milector.AttributeCount - 1
                    milector.MoveToAttribute(n)
                    Response.Write("<b>" + milector.NodeType.ToString + ": " +
                                   milector.Name + ": " + milector.Value + "<br/>")
                Next
                milector.MoveToElement()
            End If
        End While
        milector.Close()
    End Sub

    Protected Sub btnCalcular_Click(sender As Object, e As EventArgs) Handles btnCalcular.Click
        Dim medicamentoNombre As String = cmbMedicamentos.SelectedItem.Text
        Dim medicamentoCantidad As Integer = CInt(Me.txtCantidad.Text)

        Dim medicamentosService As New MedicamentosService.MedicamentosServiceSoapClient
        Dim precio As Double = medicamentosService.CalcularPrecioVenta(medicamentoNombre, medicamentoCantidad)

        Me.lblPrecioVenta.Text = "El " & medicamentoNombre & " por " & medicamentoCantidad & " le sale " & precio.ToString() & " pesos."

    End Sub
End Class