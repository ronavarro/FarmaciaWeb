'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Usuario

    Implements BE.ICrud(Of BE.Usuario)
    Dim DigitoVerificadorHorizontalBLL As New BLL.DVH
    Dim DigitoVerificadorVerticalBLL As New BLL.DVV
    Dim dvhBE As BE.DVH
    Dim dvvBE As BE.DVV
    Public Sub New()

    End Sub

    Private Shared _instancia As BLL.Usuario

    Public Shared Function GetInstance() As BLL.Usuario

        If _instancia Is Nothing Then

            _instancia = New BLL.Usuario

        End If

        Return _instancia
    End Function

    Public Function Add(objAdd As BE.Usuario) As Boolean Implements BE.ICrud(Of BE.Usuario).Add
        Try
            If DAL.Usuario.GetInstance().Add(objAdd) Then
                Dim id = DAL.Usuario.GetInstance.ObtenerMaxId()
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Delete(objDel As BE.Usuario) As Boolean Implements BE.ICrud(Of BE.Usuario).Delete
        Try
            If DAL.Usuario.GetInstance().Delete(objDel) Then
                Dim id = objDel.UsuarioId
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListAll() As List(Of BE.Usuario) Implements BE.ICrud(Of BE.Usuario).ListAll
        Try
            Return DAL.Usuario.GetInstance.ListAll
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ListById(objId As BE.Usuario) As BE.Usuario Implements BE.ICrud(Of BE.Usuario).ListById
        Try
            Return DAL.Usuario.GetInstance().ListById(objId)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Update(objUpd As BE.Usuario) As Boolean Implements BE.ICrud(Of BE.Usuario).Update
        Try
            If DAL.Usuario.GetInstance().Update(objUpd) Then
                Dim id = objUpd.UsuarioId
                GenerarDV(id)
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ValidarContraseña(unusuario As BE.Usuario) As BE.Usuario
        Try
            Return DAL.Usuario.GetInstance().ValidarContraseña(unusuario)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ValidarEliminarUsuario(ByVal UsuarioBE As BE.Usuario) As Boolean
        Try
            Return DAL.Usuario.GetInstance().ValidarEliminarUsuario(UsuarioBE)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ValidarEliminarUsuarioPatente(ByVal UsuarioBE As BE.Usuario, ByVal PatenteBE As BE.Patente) As Boolean
        Try
            Return DAL.Usuario.GetInstance().ValidarEliminarUsuarioPatente(UsuarioBE, PatenteBE)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ValidarEliminarUsuarioPatenteNegacion(ByVal UsuarioBE As BE.Usuario, ByVal PatenteBE As BE.Patente) As Boolean
        Try
            Return DAL.Usuario.GetInstance().ValidarEliminarUsuarioPatenteNegacion(UsuarioBE, PatenteBE)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function BloquearDesbloquearUsuario(unusuario As BE.Usuario) As Boolean
        Try
            Return DAL.Usuario.GetInstance().BloquearDesbloquearUsuario(unusuario)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function VerificarPatente(ByVal UsuarioBE As BE.Usuario, ByVal PatenteBE As BE.Patente) As Boolean
        Try
            Return DAL.Usuario.GetInstance.VerificarPatente(UsuarioBE, PatenteBE)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ObtenerPantenteID(strPatente As String) As Integer
        Try
            Return DAL.Usuario.GetInstance.ObtenerPatenteID(strPatente)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function VerificarExistencia(unusuario As BE.Usuario) As Boolean
        Try
            Return DAL.Usuario.GetInstance().VerificarExistencia(unusuario)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GenerarDV(Optional ByVal Id As Integer = 0)
        Dim Usuario As New BE.Usuario
        Usuario.UsuarioId = Id
        If Id > 0 Then
            Dim UsuarioBE = DAL.Usuario.GetInstance.ListById(Usuario)
            dvhBE = New BE.DVH("Usuario")
            dvhBE.AgregarRestriccion("usuario_id", UsuarioBE.UsuarioId)
            DigitoVerificadorHorizontalBLL.GenerarDVH(dvhBE)
        End If
        dvvBE = New BE.DVV("Usuario")
        DigitoVerificadorVerticalBLL.GenerarDVV(dvvBE)
    End Sub

End Class ' Usuario