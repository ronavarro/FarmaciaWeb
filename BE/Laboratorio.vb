'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Explicit On
Option Strict On

Public Class Laboratorio


    Private _laboratorioId As Integer
    Private _razonSocial As String
    Private _telefono As String
    Private _cuit As String

    Public Property laboratorioId() As Integer
        Get
            Return _laboratorioId
        End Get
        Set(ByVal value As Integer)
            _laboratorioId = value
        End Set
    End Property

    Public Property razonSocial() As String
        Get
            Return _razonSocial
        End Get
        Set(ByVal value As String)
            _razonSocial = value
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

    Public Property cuit() As String
        Get
            Return _cuit
        End Get
        Set(ByVal value As String)
            _cuit = value
        End Set
    End Property


End Class ' Laboratorio