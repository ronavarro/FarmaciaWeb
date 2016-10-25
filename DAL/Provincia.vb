'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Provincia

    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}


    Private Sub New()

    End Sub

    Private Shared _instancia As DAL.Provincia

    Public Shared Function GetInstance() As DAL.Provincia

        If _instancia Is Nothing Then

            _instancia = New DAL.Provincia

        End If

        Return _instancia
    End Function

    Public Function ListAll() As List(Of BE.Provincia)

        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim provinciaId As New SqlClient.SqlParameter
        Dim ds As New DataSet
        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure

        comm.CommandText = "prov_ObtenerProvincias"
  
        sqlDa.SelectCommand = comm

        sqlDa.SelectCommand.Connection.Open()

        sqlDa.Fill(ds)
        Dim provincias As New List(Of BE.Provincia)

        For Each fila As DataRow In ds.Tables(0).Rows
            Dim provinciaBE As New BE.Provincia
            provinciaBE.provinciaId = CInt(fila("provincia_id"))
            provinciaBE.descripcion = CStr(fila("descripcion"))
            provincias.Add(provinciaBE)
        Next
        sqlDa.SelectCommand.Connection.Close()
        Return provincias
    End Function

    Public Function ListById(objId As BE.Provincia) As BE.Provincia
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim provinciaId As New SqlClient.SqlParameter
        Dim ds As New DataSet
        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure

        comm.CommandText = "prov_ObtenerProvinciaPorID"

        provinciaId.DbType = DbType.Int32
        provinciaId.ParameterName = "@provincia_id"
        provinciaId.Value = objId.provinciaId

        comm.Parameters.Add(provinciaId)
        Dim provincia As New BE.Provincia

        sqlDa.SelectCommand = comm

        sqlDa.SelectCommand.Connection.Open()

        sqlDa.Fill(ds)

        For Each fila As DataRow In ds.Tables(0).Rows
            Dim provinciaBE As New BE.Provincia
            provinciaBE.provinciaId = CInt(fila("provincia_id"))
            provinciaBE.descripcion = CStr(fila("descripcion"))
            provincia = provinciaBE
        Next
        sqlDa.SelectCommand.Connection.Close()
        Return provincia
    End Function

End Class ' Provincia