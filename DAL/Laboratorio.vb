'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Laboratorio
    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}


    Public Function ObtenerLaboratorios() As List(Of BE.Laboratorio)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "lab_ObtenerLaboratorios"

        Dim Laboratorios As New List(Of BE.Laboratorio)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim LaboratorioBE As New BE.Laboratorio
                LaboratorioBE.laboratorioId = CInt(fila("laboratorio_id"))
                LaboratorioBE.razonSocial = CStr(fila("razon_social"))
                Laboratorios.Add(LaboratorioBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return Laboratorios
    End Function

    Public Function ObtenerLaboratorioPorId(laboratorioId As Integer) As BE.Laboratorio
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim laboratorio_Id As New SqlClient.SqlParameter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "lab_ObtenerLaboratorioPorID"

        laboratorio_Id.DbType = DbType.Int32
        laboratorio_Id.ParameterName = "@laboratorio_id"
        laboratorio_Id.Value = laboratorioId

        comm.Parameters.Add(laboratorio_Id)
        Dim _Laboratorio As New BE.Laboratorio

        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim LaboratorioBE As New BE.Laboratorio
                LaboratorioBE.laboratorioId = CInt(fila("laboratorio_id"))
                LaboratorioBE.razonSocial = CStr(fila("razon_social"))
                LaboratorioBE.cuit = CStr(fila("cuit"))
                _Laboratorio = LaboratorioBE
            Next

        Catch ex As Exception
            Throw ex

        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return _Laboratorio
    End Function
End Class ' Laboratorio