'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Patente
    Private _patenteId As Integer
    Private _nombre As String
    Private _negado As Boolean
    Private _obligatoria As Boolean

    Public Property negado() As Boolean
        Get
            Return _negado
        End Get
        Set(ByVal Value As Boolean)
            _negado = Value
        End Set
    End Property
    Public Property PatenteId() As Integer
        Get
            Return _patenteId
        End Get
        Set(ByVal value As Integer)
            _patenteId = value
        End Set
    End Property

    Public Property Nombre() As String
        Get
            Return _nombre
        End Get
        Set(ByVal value As String)
            _nombre = value
        End Set
    End Property
 
    Public Property obligatoria() As Boolean
        Get
            Return _obligatoria
        End Get
        Set(ByVal Value As Boolean)
            _obligatoria = Value
        End Set
    End Property
End Class ' Patente