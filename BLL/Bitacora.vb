'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
Public Class Bitacora
    Dim DigitoVerificadorHorizontalBLL As New BLL.DVH
    Dim DigitoVerificadorVerticalBLL As New BLL.DVV
    Dim dvhBE As BE.DVH
    Dim dvvBE As BE.DVV
    Private Sub New()

    End Sub

    Private Shared _instancia As BLL.Bitacora

    Public Shared Function GetInstance() As BLL.Bitacora

        If _instancia Is Nothing Then

            _instancia = New BLL.Bitacora

        End If

        Return _instancia
    End Function
    Public Function RegistrarBitacora(objAdd As BE.Bitacora) As Boolean
        Try
            If DAL.Bitacora.GetInstance().RegistrarBitacora(objAdd) Then
                GenerarDV(DAL.Bitacora.GetInstance.ObtenerMaxId())
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListarBitacoraPorParametros(usuario_id As Integer, fechaDesde As DateTime, fechaHasta As DateTime, criticidad As String) As List(Of BE.Bitacora)
        Try
            Return DAL.Bitacora.GetInstance().ListarBitacoraPorParametros(usuario_id, fechaDesde, fechaHasta, criticidad)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Private Sub GenerarDV(Optional ByVal Id As Short = 0)
        If Id > 0 Then
            dvhBE = New BE.DVH("Bitacora")
            dvhBE.AgregarRestriccion("bitacora_id", Id)
            DigitoVerificadorHorizontalBLL.GenerarDVH(dvhBE, False)
        End If
        dvvBE = New BE.DVV("Bitacora")
        DigitoVerificadorVerticalBLL.GenerarDVV(dvvBE)
    End Sub

End Class ' Bitacora