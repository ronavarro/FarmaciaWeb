'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On

Imports System.Text
Public Class DVV
    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}

    Public Function GetDigito(ByVal DigitoVerificadorVertical As BE.DVV) As String
        Dim SqlComm As New SqlClient.SqlCommand

        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        sqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT dvv FROM DVV WHERE nombre = '" + DigitoVerificadorVertical.ObtenerTabla.ToString) + "'"
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        sqlConn.Close()

        Return dt.Rows(0).Item(0).ToString
    End Function

    Public Function GetRegistros(ByVal DigitoVerificadorVertical As BE.DVV) As DataTable
        Dim SqlComm As New SqlClient.SqlCommand

        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        SqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT dvh FROM " + DigitoVerificadorVertical.ObtenerTabla.ToString)
        SqlComm.Connection = SqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        SqlConn.Close()

        Return dt
    End Function

    Public Sub SetDigito(ByVal DigitoVerificadorVertical As BE.DVV, ByVal dvv As String)
        Dim SqlComm As New SqlClient.SqlCommand

        SqlConn.Open()
        SqlComm.CommandText = String.Format("UPDATE DVV SET dvv = '" + dvv.ToString + "' WHERE nombre = '" + DigitoVerificadorVertical.ObtenerTabla.ToString + "'")
        SqlComm.Connection = SqlConn
        SqlComm.ExecuteNonQuery()
        SqlConn.Close()
    End Sub


End Class ' DVV