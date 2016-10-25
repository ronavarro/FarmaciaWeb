'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Medicamento

    Private _medicamentoId As Integer
    Private _descripcion As String
    Private _laboratorio As Laboratorio
    Private _precio As String
    Private _cantidad As String
    Private _eliminado As Boolean
    Private _receta As Boolean
    Private _nombrelaboratorio As String

    Public Property Receta() As Boolean
        Get
            Return _receta
        End Get
        Set(ByVal value As Boolean)
            _receta = value
        End Set
    End Property

    Public Property medicamentoId() As Integer
        Get
            Return _medicamentoId
        End Get
        Set(ByVal value As Integer)
            _medicamentoId = value
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

    Public Property laboratorio() As Laboratorio
        Get
            Return _laboratorio
        End Get
        Set(ByVal value As Laboratorio)
            _laboratorio = value
        End Set
    End Property

    Public Property precio() As String
        Get
            Return _precio
        End Get
        Set(ByVal value As String)
            _precio = value
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


    Public Property cantidad() As String
        Get
            Return _cantidad
        End Get
        Set(ByVal value As String)
            _cantidad = value
        End Set
    End Property

    Public Property NombreLaboratorio() As String
        Get
            Return _nombrelaboratorio
        End Get
        Set(ByVal value As String)
            _nombrelaboratorio = value
        End Set
    End Property

End Class ' Medicamento