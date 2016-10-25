'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class DVV

    Private _tabla As String

    Public Sub New(ByVal tabla As String)
        _tabla = tabla
    End Sub

    Public Function ObtenerTabla() As String
        Return _tabla
    End Function
End Class ' DVV


