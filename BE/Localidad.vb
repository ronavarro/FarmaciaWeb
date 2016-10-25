'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BE
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Explicit On
Option Strict On

Public Class Localidad


    Private _localidadId As Integer
    Private _descripcion As String
    Private _provincia As Provincia


    Public Property LocalidadId() As Integer
        Get
            Return _localidadId
        End Get
        Set(ByVal value As Integer)
            _localidadId = value
        End Set
    End Property

    Public Property Descripcion() As String
        Get
            Return _descripcion
        End Get
        Set(ByVal value As String)
            _descripcion = value
        End Set
    End Property

    Public Property Provincia() As Provincia
        Get
            Return _provincia
        End Get
        Set(ByVal value As Provincia)
            _provincia = value
        End Set
    End Property




End Class ' Localidad