Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class MedicamentosService
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function CalcularPrecioVenta(pMedicamento As String, pCantidad As Integer) As Double
        Dim precio As Double = 0

        Select Case pMedicamento
            Case "ibuprofeno"
                precio = 15
            Case "armonil"
                precio = 20
            Case "medicamento1"
                precio = 25
            Case "medicamento4"
                precio = 30
            Case "medicameto5"
                precio = 35
            Case Else
                precio = 50
        End Select

        Return precio * pCantidad

    End Function

    <WebMethod()>
    Public Function ObtenerPrecioUnitario(pMedicamento As String) As Double
        Dim precio As Double = 0

        Select Case pMedicamento
            Case "ibuprofeno"
                precio = 15
            Case "armonil"
                precio = 20
            Case "medicamento1"
                precio = 25
            Case "medicamento4"
                precio = 30
            Case "medicameto5"
                precio = 35
            Case Else
                precio = 50
        End Select

        Return precio
    End Function

End Class