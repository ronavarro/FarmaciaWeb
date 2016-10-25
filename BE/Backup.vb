'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Backup

    Private _backup_id As Integer
    Private _cantidad As Integer
    Private _tamano As Double
    Private _ubicacion As String
    Private _archivo As String

    Public Property backup_id() As Integer
        Get
            Return _backup_id
        End Get
        Set(ByVal value As Integer)
            _backup_id = value
        End Set
    End Property

    Public Property cantidad() As Integer
        Get
            Return _cantidad
        End Get
        Set(ByVal Value As Integer)
            _cantidad = Value
        End Set
    End Property

    Public Property tamano() As Double
        Get
            Return _tamano
        End Get
        Set(ByVal Value As Double)
            _tamano = Value
        End Set
    End Property

    Public Property ubicacion() As String
        Get
            Return _ubicacion
        End Get
        Set(ByVal Value As String)
            _ubicacion = Value
        End Set
    End Property

    Public Property archivo() As String
        Get
            Return _archivo
        End Get
        Set(ByVal Value As String)
            _archivo = Value
        End Set
    End Property

End Class ' Backup