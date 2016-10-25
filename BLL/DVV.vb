'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Class DVV

    Dim SeguridadBLL As New BLL.Seguridad
    Dim DigitoVerificadorVerticalDAL As New DAL.DVV

    Public Sub GenerarDVV(ByVal DigitoVerificadorVertical As BE.DVV)
        Dim dt = DigitoVerificadorVerticalDAL.GetRegistros(DigitoVerificadorVertical)
        Dim dvv = ConcatenarRegistros(dt)
        DigitoVerificadorVerticalDAL.SetDigito(DigitoVerificadorVertical, dvv)
    End Sub

    Public Function ConcatenarRegistros(ByVal dt As DataTable) As Long
        Dim cadena As Long
        Try
            For Each dr In dt.Rows
                cadena = cadena + dr.Item("dvh")
            Next
            Return cadena
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function VerificarDVV(ByVal dt As DataTable) As Boolean
        Dim dvv = ConcatenarRegistros(dt)
        Dim dvvBE = New BE.DVV(dt.TableName)
        If (dvv <> DigitoVerificadorVerticalDAL.GetDigito(dvvBE)) Then
            Return False
        End If
        Return True
    End Function

End Class