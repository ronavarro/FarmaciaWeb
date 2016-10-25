'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Idioma
    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}


    Public Function ObtenerIdiomas() As List(Of BE.Idioma)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "idi_ObtenerIdiomas"
        Dim Idiomas As New List(Of BE.Idioma)
        Try
            sqlDa.SelectCommand = comm
            sqlDa.SelectCommand.Connection.Open()
            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim IdiomaBE As New BE.Idioma
                IdiomaBE.IdiomaId = CInt(fila("idioma_id"))
                IdiomaBE.Nombre = CStr(fila("nombre"))
                Idiomas.Add(IdiomaBE)
            Next
        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return Idiomas
    End Function

End Class ' Idioma