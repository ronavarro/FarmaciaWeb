'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Explicit On
Option Strict On

Public Class Provincia

    Private _provinciaId As Integer
    Private _descripcion As String

    Public Property provinciaId() As Integer
        Get
            Return _provinciaId
        End Get
        Set(ByVal value As Integer)
            _provinciaId = value
        End Set
    End Property

    Public Property descripcion() As String
        Get
            Return _descripcion
        End Get
        Set(ByVal value As String)
            _descripcion = value
        End Set
    End Property

End Class ' Provincia