'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Cliente

    Implements BE.ICrud(Of BE.Cliente)
    Dim DigitoVerificadorHorizontalBLL As New BLL.DVH
    Dim DigitoVerificadorVerticalBLL As New BLL.DVV
    Dim dvhBE As BE.DVH
    Dim dvvBE As BE.DVV

    Private Shared _instancia As BLL.Cliente

    Public Shared Function GetInstance() As BLL.Cliente

        If _instancia Is Nothing Then

            _instancia = New BLL.Cliente

        End If

        Return _instancia
    End Function
    Public Function Add(objAdd As BE.Cliente) As Boolean Implements BE.ICrud(Of BE.Cliente).Add
        Try
            If DAL.Cliente.GetInstance().Add(objAdd) Then
                Dim id = DAL.Cliente.GetInstance.ObtenerMaxId()
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Delete(objDel As BE.Cliente) As Boolean Implements BE.ICrud(Of BE.Cliente).Delete
        Try
            If DAL.Cliente.GetInstance().Delete(objDel) Then
                Dim id = objDel.clienteId
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListAll() As List(Of BE.Cliente) Implements BE.ICrud(Of BE.Cliente).ListAll
        Try
            Return DAL.Cliente.GetInstance().ListAll
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListById(objId As BE.Cliente) As BE.Cliente Implements BE.ICrud(Of BE.Cliente).ListById
        Try
            Return DAL.Cliente.GetInstance().ListById(objId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Update(objUpd As BE.Cliente) As Boolean Implements BE.ICrud(Of BE.Cliente).Update
        Try
            If DAL.Cliente.GetInstance().Update(objUpd) Then
                Dim id = objUpd.clienteId
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ObtenerClientesDisponibles() As List(Of BE.Cliente)
        Try
            Return DAL.Cliente.GetInstance().ObtenerClientesDisponibles()
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ObtenerClientePorDNI(dni As String) As List(Of BE.Cliente)
        Try
            Return DAL.Cliente.GetInstance().ObtenerClientePorDNI(dni)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ObtenerClientePorApellido_Nombre(apellido_nombre As String) As List(Of BE.Cliente)
        Try
            Return DAL.Cliente.GetInstance().ObtenerClientePorApellido_Nombre(apellido_nombre)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function VerificarExistencia(dni As Integer) As Boolean
        Try
            Return DAL.Cliente.GetInstance().VerificarExistencia(dni)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GenerarDV(Optional ByVal Id As Integer = 0)
        Dim Cliente As New BE.Cliente
        Cliente.clienteId = Id
        If Id > 0 Then
            Dim ClienteBE = DAL.Cliente.GetInstance.ListById(Cliente)
            dvhBE = New BE.DVH("Cliente")
            dvhBE.AgregarRestriccion("cliente_id", ClienteBE.clienteId)
            DigitoVerificadorHorizontalBLL.GenerarDVH(dvhBE)
        End If
        dvvBE = New BE.DVV("Cliente")
        DigitoVerificadorVerticalBLL.GenerarDVV(dvvBE)
    End Sub

End Class ' Cliente