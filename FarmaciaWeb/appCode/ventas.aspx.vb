Imports System.Xml

Public Class ventas
    Inherits System.Web.UI.Page
    Dim UsuarioBE As BE.Usuario
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim PatenteBE As New BE.Patente
        UsuarioBE = CType(Session("UsuarioBE"), BE.Usuario)
        PatenteBE.Nombre = "Venta"
        PatenteBE.PatenteId = BLL.Usuario.GetInstance.ObtenerPantenteID(PatenteBE.Nombre)
        If (BLL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE) = False) Then
            MsgBox("Sus permisos han sido modificados, por favor inicie sesion nuevamente", MsgBoxStyle.Critical, "Error")
            Response.Redirect("logout.aspx")
        End If
        ObtenerMedicamentos()
    End Sub

    Public Sub ObtenerMedicamentos()

        Dim myList As New Dictionary(Of Integer, String)
         For Each _medicamentoBE In BLL.Medicamento.GetInstance.ListAll()
            myList.Add(_medicamentoBE.medicamentoId, (_medicamentoBE.descripcion))
        Next
        cmbMedicamentos.DataSource = myList.Values
        cmbMedicamentos.DataBind()

     End Sub


    Protected Sub btnCalcular_Click(sender As Object, e As EventArgs) Handles btnCalcular.Click
        Dim milector As New XmlTextReader(Server.MapPath("medicamentos.xml"))
        Dim n As Integer
        While milector.Read()
            Response.Write(milector.NodeType.ToString + ":" + _
                           milector.Name + ":" + milector.Value + "<br/>")
            If milector.HasAttributes Then
                For n = 0 To milector.AttributeCount - 1
                    milector.MoveToAttribute(n)
                    Response.Write("<b>" + milector.NodeType.ToString + ": " + _
                                   milector.Name + ": " + milector.Value + "<br/>")
                Next
                milector.MoveToElement()
            End If
        End While
        milector.Close()
    End Sub
End Class