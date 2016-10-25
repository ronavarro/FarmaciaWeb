'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Provincia

    Private Sub New()

    End Sub

    Private Shared _instancia As BLL.Provincia

    Public Shared Function GetInstance() As BLL.Provincia

        If _instancia Is Nothing Then

            _instancia = New BLL.Provincia

        End If

        Return _instancia
    End Function

    Public Function ListAll() As List(Of BE.Provincia)
        Return DAL.Provincia.GetInstance.ListAll
    End Function

    Public Function ListById(objId As BE.Provincia) As BE.Provincia
        Return DAL.Provincia.GetInstance.ListById(objId)
    End Function


End Class ' Provincia