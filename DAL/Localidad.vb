'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Localidad

    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}


    Private Sub New()

    End Sub

    Private Shared _instancia As DAL.Localidad

    Public Shared Function GetInstance() As DAL.Localidad

        If _instancia Is Nothing Then

            _instancia = New DAL.Localidad

        End If

        Return _instancia
    End Function

    Public Function ListAll() As List(Of BE.Localidad)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "loc_ObtenerLocalidades"
        Dim localidades As New List(Of BE.Localidad)
        Try
            sqlDa.SelectCommand = comm
            sqlDa.SelectCommand.Connection.Open()
            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim localidadBE As New BE.Localidad
                localidadBE.LocalidadId = CInt(fila("localidad_id"))
                localidadBE.Descripcion = CStr(fila("descripcion"))
                Dim prov As New BE.Provincia
                prov.provinciaId = CInt(fila("provincia_fk"))
                localidadBE.Provincia = DAL.Provincia.GetInstance.ListById(prov)
                localidades.Add(localidadBE)
            Next
        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return localidades
    End Function

    Public Function ListById(objId As BE.Localidad) As BE.Localidad
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet
        Dim localidadId As New SqlClient.SqlParameter
        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "loc_ObtenerLocalidadPorID"
        localidadId.DbType = DbType.Int32
        localidadId.ParameterName = "@localidad_id"
        localidadId.Value = objId.LocalidadId

        comm.Parameters.Add(localidadId)
        Dim localidad As New BE.Localidad
        Try
            sqlDa.SelectCommand = comm
            sqlDa.SelectCommand.Connection.Open()
            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim localidadBE As New BE.Localidad
                localidadBE.LocalidadId = CInt(fila("localidad_id"))
                localidadBE.Descripcion = CStr(fila("descripcion"))
                Dim prov As New BE.Provincia
                prov.provinciaId = CInt(fila("provincia_fk"))
                localidadBE.Provincia = DAL.Provincia.GetInstance.ListById(prov)

                localidad = localidadBE
            Next
        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return localidad
    End Function


End Class ' Localidad