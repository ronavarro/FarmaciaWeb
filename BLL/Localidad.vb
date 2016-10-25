'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Localidad

    Private Sub New()

    End Sub

    Private Shared _instancia As BLL.Localidad

    Public Shared Function GetInstance() As BLL.Localidad

        If _instancia Is Nothing Then

            _instancia = New BLL.Localidad

        End If

        Return _instancia
    End Function

    Public Function ListAll() As List(Of BE.Localidad)
        Return DAL.Localidad.GetInstance.ListAll
    End Function

    Public Function ListById(objId As BE.Localidad) As BE.Localidad
        Return DAL.Localidad.GetInstance.ListById(objId)
    End Function

End Class ' Localidad