'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On
Public Class Venta
    Private _ventaId As Integer
    Private _fechaVenta As Date
    Private _activo As Boolean
    Private _dvh As Integer
    Private _medicamentos As List(Of VentaMedicamento)
    Private _cliente As Cliente
    Private _eliminado As Boolean
    Private _totalImporte As Double
    Private _clienteRpt As String



    Public Property TotalImporte() As Double
        Get
            Return _totalImporte
        End Get
        Set(ByVal value As Double)
            _totalImporte = value
        End Set
    End Property

    Public Property ventaId() As Integer
        Get
            Return _ventaId
        End Get
        Set(ByVal value As Integer)
            _ventaId = value
        End Set
    End Property

    Public Property fechaVenta() As Date
        Get
            Return _fechaVenta
        End Get
        Set(ByVal value As Date)
            _fechaVenta = value
        End Set
    End Property

    Public Property activo() As Boolean
        Get
            Return _activo
        End Get
        Set(ByVal value As Boolean)
            _activo = value
        End Set
    End Property

    Public Property dvh() As Integer
        Get
            Return _dvh
        End Get
        Set(ByVal value As Integer)
            _dvh = value
        End Set
    End Property

    Public Property medicamentos() As List(Of VentaMedicamento)
        Get
            Return _medicamentos
        End Get
        Set(ByVal value As List(Of VentaMedicamento))
            _medicamentos = value
        End Set
    End Property

    Public Property cliente() As Cliente
        Get
            Return _cliente
        End Get
        Set(ByVal value As Cliente)
            _cliente = value
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

    Public Property ClienteRpt() As String
        Get
            Return _clienteRpt
        End Get
        Set(ByVal value As String)
            _clienteRpt = value
        End Set
    End Property

End Class ' Venta