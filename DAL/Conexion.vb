Imports System.IO
Imports System.Configuration

Public Class Conexion
    Public Shared Function getConexionFarmacia() As String
        Return ConfigurationManager.ConnectionStrings("FarmaciaConnection").ConnectionString
    End Function

    Public Shared Function getConexionMaster() As String
        Return ConfigurationManager.ConnectionStrings("MasterConnection").ConnectionString
    End Function

End Class
