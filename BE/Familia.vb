'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Explicit On
Option Strict On

Public Class Familia

    Private _familiaId As Integer
    Private _nombre As String
    Private _descripcion As String
    Private _patentes As List(Of Patente)

    Public Property familiaId() As Integer
        Get
            Return _familiaId
        End Get
        Set(ByVal value As Integer)
            _familiaId = value
        End Set
    End Property

    Public Property nombre() As String
        Get
            Return _nombre
        End Get
        Set(ByVal value As String)
            _nombre = value
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
 
    Public Property patentes() As List(Of Patente)
        Get
            Return _patentes
        End Get
        Set(ByVal value As List(Of Patente))
            _patentes = value
        End Set
    End Property

End Class ' Familia