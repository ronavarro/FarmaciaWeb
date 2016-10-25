'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Traduccion


    Private _traduccion_id As Integer
    Private _idioma As Idioma
    Private _texto As String
    Private _traduccion As String

    Public Property traduccion_id() As Integer
        Get
            Return _traduccion_id
        End Get
        Set(ByVal value As Integer)
            _traduccion_id = value
        End Set
    End Property

    Public Property idioma() As Idioma
        Get
            Return _idioma
        End Get
        Set(ByVal Value As Idioma)
            _idioma = Value
        End Set
    End Property

    Public Property texto() As String
        Get
            Return _texto
        End Get
        Set(ByVal value As String)
            _texto = value
        End Set
    End Property

    Public Property traduccion() As String
        Get
            Return _traduccion
        End Get
        Set(ByVal value As String)
            _traduccion = value
        End Set
    End Property


End Class ' Traduccion