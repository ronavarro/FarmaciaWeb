'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 

Public Class Venta

    Dim DigitoVerificadorHorizontalBLL As New BLL.DVH
    Dim DigitoVerificadorVerticalBLL As New BLL.DVV
    Dim dvhBE As BE.DVH
    Dim dvvBE As BE.DVV

    Private Sub New()

    End Sub

    Private Shared _instancia As BLL.Venta

    Public Shared Function GetInstance() As BLL.Venta

        If _instancia Is Nothing Then

            _instancia = New BLL.Venta

        End If

        Return _instancia
    End Function
    Public Function RegistrarVenta(objAdd As BE.Venta) As Boolean
        Try
            If DAL.Venta.GetInstance().RegistrarVenta(objAdd) Then
                GenerarDV(ObtenerMaxId())
                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ModificarVenta(objUpd As BE.Venta) As Boolean
        Try
            If DAL.Venta.GetInstance().ModificarVenta(objUpd) Then
                GenerarDV(ObtenerMaxId())
                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ListarVentasPorParametros(fechaDesde As DateTime, fechaHasta As DateTime, cliente_fk As Integer) As List(Of BE.Venta)
        Try
            Return DAL.Venta.GetInstance().ListarVentasPorParametros(fechaDesde, fechaHasta, cliente_fk)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListarVentaById(VentaBE As BE.Venta) As BE.Venta
        Try
            Return DAL.Venta.GetInstance().ListarVentaById(VentaBE)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ObtenerMaxId() As Integer
        Try
            Return DAL.Venta.GetInstance().ObtenerMaxId()
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ObtenerMaxIdVenta_Medicamento() As Integer
        Try
            Return DAL.Venta.GetInstance().ObtenerMaxIdVenta_Medicamento()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GenerarDV(Optional ByVal Id As Integer = 0)
        Dim Venta As New BE.Venta
        Venta.ventaId = Id
        If Id > 0 Then
            Dim VentaBE = DAL.Venta.GetInstance.ListarVentaById(Venta)
            dvhBE = New BE.DVH("Venta")
            dvhBE.AgregarRestriccion("venta_id", Venta.ventaId)
            DigitoVerificadorHorizontalBLL.GenerarDVH(dvhBE)
            For Each MedicamentoBE In VentaBE.medicamentos
                dvhBE = New BE.DVH("Venta_Medicamento")
                dvhBE.AgregarRestriccion("venta_medicamento_id", MedicamentoBE.ventaMedicamentoId)
                dvhBE.AgregarRestriccion("venta_id", VentaBE.ventaId)
                dvhBE.AgregarRestriccion("medicamento_id", MedicamentoBE.Medicamento.medicamentoId)
                DigitoVerificadorHorizontalBLL.GenerarDVH(dvhBE, False)
            Next
        End If
        dvvBE = New BE.DVV("Venta")
        DigitoVerificadorVerticalBLL.GenerarDVV(dvvBE)
        dvvBE = New BE.DVV("Venta_Medicamento")
        DigitoVerificadorVerticalBLL.GenerarDVV(dvvBE)
    End Sub



End Class ' Venta