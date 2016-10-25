'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Explicit On
Option Strict On

Public Class Medicamento

    Implements BE.ICrud(Of BE.Medicamento)

    Dim DigitoVerificadorHorizontalBLL As New BLL.DVH
    Dim DigitoVerificadorVerticalBLL As New BLL.DVV
    Dim dvhBE As BE.DVH
    Dim dvvBE As BE.DVV
    Private Sub New()

    End Sub

    Private Shared _instancia As BLL.Medicamento

    Public Shared Function GetInstance() As BLL.Medicamento

        If _instancia Is Nothing Then

            _instancia = New BLL.Medicamento

        End If

        Return _instancia
    End Function
    Public Function Add(objAdd As BE.Medicamento) As Boolean Implements BE.ICrud(Of BE.Medicamento).Add
        Try
            If DAL.Medicamento.GetInstance().Add(objAdd) Then
                Dim id = DAL.Medicamento.GetInstance.ObtenerMaxId()
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Delete(objDel As BE.Medicamento) As Boolean Implements BE.ICrud(Of BE.Medicamento).Delete
        Try
            If DAL.Medicamento.GetInstance().Delete(objDel) Then
                Dim id = objDel.medicamentoId
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListAll() As List(Of BE.Medicamento) Implements BE.ICrud(Of BE.Medicamento).ListAll
        Try
            Return DAL.Medicamento.GetInstance.ListAll
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ObtenerMedicamentosDisponibles(cantidad As String) As List(Of BE.Medicamento)
        Try
            Return DAL.Medicamento.GetInstance.ObtenerMedicamentosDisponibles(cantidad)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListById(objId As BE.Medicamento) As BE.Medicamento Implements BE.ICrud(Of BE.Medicamento).ListById
        Try
            Return DAL.Medicamento.GetInstance().ListById(objId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Update(objUpd As BE.Medicamento) As Boolean Implements BE.ICrud(Of BE.Medicamento).Update
        Try
            If DAL.Medicamento.GetInstance().Update(objUpd) Then
                Dim id = objUpd.medicamentoId
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ActualizarStock(objUpd As BE.Medicamento) As Boolean
        Try
            If DAL.Medicamento.GetInstance().ActualizarStock(objUpd) Then
                Dim id = objUpd.medicamentoId
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ObtenerMedicamentoPorDescripcion(strDescripcion As String) As List(Of BE.Medicamento)
        Try
            Return DAL.Medicamento.GetInstance.ObtenerMedicamentoPorDescripcion(strDescripcion)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ObtenerMedicamentoPorLaboratorio(laboratorio As BE.Laboratorio) As List(Of BE.Medicamento)
        Try
            Return DAL.Medicamento.GetInstance.ObtenerMedicamentoPorLaboratorio(laboratorio)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

  
    Public Function ObtenerMedicamentoPorParametros(descripcion As String, laboratorio As BE.Laboratorio, check As Boolean) As List(Of BE.Medicamento)
        Try
            Return DAL.Medicamento.GetInstance.ObtenerMedicamentoPorParametros(descripcion, laboratorio, check)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function VerificarExistencia(unMedicamento As BE.Medicamento) As Boolean
        Try
            Return DAL.Medicamento.GetInstance().VerificarExistencia(unMedicamento)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GenerarDV(Optional ByVal Id As Integer = 0)
        Dim Medicamento As New BE.Medicamento
        Medicamento.medicamentoId = Id
        If Id > 0 Then
            Dim MedicamentoBE = DAL.Medicamento.GetInstance.ListById(Medicamento)
            dvhBE = New BE.DVH("Medicamento")
            dvhBE.AgregarRestriccion("medicamento_id", MedicamentoBE.medicamentoId)
            DigitoVerificadorHorizontalBLL.GenerarDVH(dvhBE)
        End If
        dvvBE = New BE.DVV("Medicamento")
        DigitoVerificadorVerticalBLL.GenerarDVV(dvvBE)
    End Sub

End Class ' Medicamento