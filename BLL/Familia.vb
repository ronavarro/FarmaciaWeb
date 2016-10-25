'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Familia
    Implements BE.ICrud(Of BE.Familia)

    Dim DigitoVerificadorHorizontalBLL As New BLL.DVH
    Dim DigitoVerificadorVerticalBLL As New BLL.DVV
    Dim dvhBE As BE.DVH
    Dim dvvBE As BE.DVV

    Private Sub New()

    End Sub

    Private Shared _instancia As BLL.Familia

    Public Shared Function GetInstance() As BLL.Familia

        If _instancia Is Nothing Then

            _instancia = New BLL.Familia

        End If

        Return _instancia
    End Function


    Public Function Add(objAdd As BE.Familia) As Boolean Implements BE.ICrud(Of BE.Familia).Add
        Try
            If DAL.Familia.GetInstance().Add(objAdd) Then
                Dim id = DAL.Familia.GetInstance.ObtenerMaxId()
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Delete(objDel As BE.Familia) As Boolean Implements BE.ICrud(Of BE.Familia).Delete
        Try
            If DAL.Familia.GetInstance().Delete(objDel) Then
                GenerarDV()
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListAll() As List(Of BE.Familia) Implements BE.ICrud(Of BE.Familia).ListAll
        Try
            Return DAL.Familia.GetInstance.ListAll
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListById(objId As BE.Familia) As BE.Familia Implements BE.ICrud(Of BE.Familia).ListById
        Try
            Return DAL.Familia.GetInstance().ListById(objId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Update(objUpd As BE.Familia) As Boolean Implements BE.ICrud(Of BE.Familia).Update
        Try
            If DAL.Familia.GetInstance().Update(objUpd) Then
                Dim id = objUpd.familiaId
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ValidarEliminarFamilia(ByVal FamiliaBE As BE.Familia) As Boolean
        Try
            Return DAL.Familia.GetInstance.ValidarEliminarFamilia(FamiliaBE)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ValidarEliminarFamiliaPatente(ByVal FamiliaBE As BE.Familia, ByVal PatenteBE As BE.Patente) As Boolean
        Try
            Return DAL.Familia.GetInstance.ValidarEliminarFamiliaPatente(FamiliaBE, PatenteBE)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ValidarEliminarFamiliaUsuario(ByVal FamiliaBE As BE.Familia, ByVal UsuarioBE As BE.Usuario) As Boolean
        Try
            Return DAL.Familia.GetInstance.ValidarEliminarFamiliaUsuario(FamiliaBE, UsuarioBE)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function VerificarExistencia(unaFamilia As BE.Familia) As Boolean
        Try
            Return DAL.Familia.GetInstance().VerificarExistencia(unaFamilia)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Sub GenerarDV(Optional ByVal Id As Integer = 0)
        Dim Familia As New BE.Familia
        Familia.familiaId = Id
        If Id > 0 Then
            Dim FamiliaBE = DAL.Familia.GetInstance.ListById(Familia)
            dvhBE = New BE.DVH("Familia")
            dvhBE.AgregarRestriccion("familia_id", FamiliaBE.familiaId)
            DigitoVerificadorHorizontalBLL.GenerarDVH(dvhBE)
        End If
        dvvBE = New BE.DVV("Familia")
        DigitoVerificadorVerticalBLL.GenerarDVV(dvvBE)
    End Sub
End Class ' Familia