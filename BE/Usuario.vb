'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Explicit On
Option Strict On

Public Class Usuario

    Private _UsuarioId As Integer
    Private _NombreUsuario As String
    Private _Contraseña As String
    Private _Apellido As String
    Private _Nombre As String
    Private _Dni As Integer
    Private _Mail As String
    Private _Cci As Integer
    Private _Bloqueado As Boolean
    Private _Eliminado As Boolean
 
    Private _familias As New List(Of Familia)
    Private _patentes As New List(Of Patente)

    Public Property familias() As List(Of Familia)
        Get
            Return _familias
        End Get
        Set(ByVal value As List(Of Familia))
            _familias = value
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

    Public Property UsuarioId() As Integer
        Get
            Return _UsuarioId
        End Get
        Set(ByVal value As Integer)
            _UsuarioId = value
        End Set
    End Property

    Public Property NombreUsuario() As String
        Get
            Return _NombreUsuario
        End Get
        Set(ByVal value As String)
            _NombreUsuario = value
        End Set
    End Property

    Public Property Contraseña() As String
        Get
            Return _Contraseña
        End Get
        Set(ByVal value As String)
            _Contraseña = value
        End Set
    End Property

    Public Property Apellido() As String
        Get
            Return _Apellido
        End Get
        Set(ByVal value As String)
            _Apellido = value
        End Set
    End Property

    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal value As String)
            _Nombre = value
        End Set
    End Property

    Public Property Dni() As Integer
        Get
            Return _Dni
        End Get
        Set(ByVal value As Integer)
            _Dni = value
        End Set
    End Property

    Public Property Mail() As String
        Get
            Return _Mail
        End Get
        Set(ByVal value As String)
            _Mail = value
        End Set
    End Property

    Public Property Cci() As Integer
        Get
            Return _Cci
        End Get
        Set(ByVal value As Integer)
            _Cci = value
        End Set
    End Property

    Public Property Bloqueado() As Boolean
        Get
            Return _Bloqueado
        End Get
        Set(ByVal value As Boolean)
            _Bloqueado = value
        End Set
    End Property

    Public Property Eliminado() As Boolean
        Get
            Return _Eliminado
        End Get
        Set(ByVal value As Boolean)
            _Eliminado = value
        End Set
    End Property
 
End Class ' Usuario