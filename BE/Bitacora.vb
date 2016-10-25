'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Bitacora
    Private _bicatora_id As Integer
    Private _usuario As Usuario
    Private _nombreUsuario As String
    Private _fecha As DateTime
    Private _descripcion As String
    Private _criticidad As String

    Public Property bitacora_id() As Integer
        Get
            Return _bicatora_id
        End Get
        Set(ByVal value As Integer)
            _bicatora_id = value
        End Set
    End Property

    Public Property NombreUsuario() As String
        Get
            Return _nombreUsuario
        End Get
        Set(ByVal Value As String)
            _nombreUsuario = Value
        End Set
    End Property
    Public Property fecha() As Date
        Get
            Return _fecha
        End Get
        Set(ByVal Value As Date)
            _fecha = Value
        End Set
    End Property

    Public Property Descripcion() As String
        Get
            Return _descripcion
        End Get
        Set(ByVal Value As String)
            _descripcion = Value
        End Set
    End Property

    Public Property usuario() As Usuario
        Get
            Return _usuario
        End Get
        Set(ByVal Value As Usuario)
            _usuario = Value
        End Set
    End Property

    Public Property criticidad() As String
        Get
            Return _criticidad
        End Get
        Set(ByVal value As String)
            _criticidad = value
        End Set
    End Property
 

End Class ' Bitacora