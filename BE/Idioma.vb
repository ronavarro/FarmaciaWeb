'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Idioma


    Private _idiomaid As Integer
    Private _nombre As String

    Public Property IdiomaId() As Integer
        Get
            Return _idiomaid
        End Get
        Set(ByVal value As Integer)
            _idiomaid = value
        End Set
    End Property

    Public Property Nombre() As String
        Get
            Return _nombre
        End Get
        Set(ByVal Value As String)
            _nombre = Value
        End Set
    End Property

End Class ' Idioma