'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Cliente

    Private _clienteId As Integer
    Private _direccion As String
    Private _nombre As String
    Private _apellido As String
    Private _telefono As String
    Private _fecha_alta As Date
    Private _eliminado As Boolean
    Private _dni As Integer
    Private _localidad As Localidad

    Private _nombreCompleto As String
    Public Property NombreCompleto() As String
        Get
            Return _nombreCompleto
        End Get
        Set(ByVal value As String)
            _nombreCompleto = value
        End Set
    End Property

    Public Property clienteId() As Integer
        Get
            Return _clienteId
        End Get
        Set(ByVal value As Integer)
            _clienteId = value
        End Set
    End Property

    Public Property direccion() As String
        Get
            Return _direccion
        End Get
        Set(ByVal value As String)
            _direccion = value
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

    Public Property apellido() As String
        Get
            Return _apellido
        End Get
        Set(ByVal value As String)
            _apellido = value
        End Set
    End Property

    Public Property telefono() As String
        Get
            Return _telefono
        End Get
        Set(ByVal value As String)
            _telefono = value
        End Set
    End Property

    Public Property fecha_alta() As Date
        Get
            Return _fecha_alta
        End Get
        Set(ByVal value As Date)
            _fecha_alta = value
        End Set
    End Property

    Public Property eliminado() As Boolean
        Get
            Return _eliminado
        End Get
        Set(ByVal value As Boolean)
            _eliminado = value
        End Set
    End Property

    Public Property dni() As Integer
        Get
            Return _dni
        End Get
        Set(ByVal value As Integer)
            _dni = value
        End Set
    End Property

    Private _email As String
    Public Property email() As String
        Get
            Return _email
        End Get
        Set(ByVal value As String)
            _email = value
        End Set
    End Property

    Private _dvh As Integer
    Public Property dvh() As Integer
        Get
            Return _dvh
        End Get
        Set(ByVal value As Integer)
            _dvh = value
        End Set
    End Property

    Public Property localidad() As Localidad
        Get
            Return _localidad
        End Get
        Set(ByVal value As Localidad)
            _localidad = value
        End Set
    End Property




End Class ' Cliente