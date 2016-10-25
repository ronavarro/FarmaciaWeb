'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Explicit On
Option Strict On

Public Class DVH

    Private _tabla As String
    Private _restricciones As New List(Of Restriccion)

    Public Sub New(ByVal tabla As String)
        _tabla = tabla
    End Sub

    Structure Restriccion
        Public campo As String
        Public identificador As Integer
    End Structure

    Public Function ObtenerTabla() As String
        Return _tabla
    End Function

    Public Sub AgregarRestriccion(ByVal campo As String, ByVal identificador As Integer)
        _restricciones.Add(New Restriccion With {.campo = campo, .identificador = identificador})
    End Sub

    Public Function ObtenerRestricciones() As List(Of Restriccion)
        Return _restricciones
    End Function



End Class ' DVH