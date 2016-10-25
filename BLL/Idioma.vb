'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Idioma

    Dim IdiomaDAL As New DAL.Idioma

    Public Function ObtenerIdiomas() As List(Of BE.Idioma)
        Return IdiomaDAL.ObtenerIdiomas()
    End Function

End Class ' Idioma