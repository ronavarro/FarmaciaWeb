'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Class Bitacora
    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}

    Private Shared _instancia As DAL.Bitacora

    Public Shared Function GetInstance() As DAL.Bitacora

        If _instancia Is Nothing Then

            _instancia = New DAL.Bitacora

        End If

        Return _instancia
    End Function

    Public Function RegistrarBitacora(objAdd As BE.Bitacora) As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim usuarioId As New SqlClient.SqlParameter
        Dim descripcion As New SqlClient.SqlParameter
        Dim fecha_hora As New SqlClient.SqlParameter
        Dim criticidad As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "bit_InsertarBitacora"

        usuarioId.DbType = DbType.Int16
        usuarioId.ParameterName = "@usuario_fk"
        usuarioId.Value = objAdd.usuario.UsuarioId

        descripcion.DbType = DbType.String
        descripcion.ParameterName = "@descripcion"
        descripcion.Value = objAdd.descripcion

        fecha_hora.DbType = DbType.DateTime
        fecha_hora.ParameterName = "@fecha_hora"
        fecha_hora.Value = DateTime.Now

        criticidad.DbType = DbType.String
        criticidad.ParameterName = "@criticidad"
        criticidad.Value = objAdd.criticidad

        comm.Parameters.Add(usuarioId)
        comm.Parameters.Add(descripcion)
        comm.Parameters.Add(fecha_hora)
        comm.Parameters.Add(criticidad)
        Try
            sqlDA.InsertCommand = comm

            sqlDA.InsertCommand.Connection.Open()

            If sqlDA.InsertCommand.ExecuteNonQuery > 0 Then
                returnValue = True
            End If

        Catch ex As Exception
            Throw ex
        Finally
            sqlDA.InsertCommand.Connection.Close()
        End Try

        Return returnValue
    End Function


    Public Function ListarBitacoraPorId(objId As BE.Bitacora) As BE.Bitacora
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim bitacoraId As New SqlClient.SqlParameter
        Dim ds As New DataSet
        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure

        comm.CommandText = "bit_ListarBitacoraPorID"

        bitacoraId.DbType = DbType.Int32
        bitacoraId.ParameterName = "@bitacora_id"
        bitacoraId.Value = objId.bitacora_id

        comm.Parameters.Add(bitacoraId)
        Dim bitacora As New BE.Bitacora

        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim BitacoraBE As New BE.Bitacora
                Dim UsuarioBE As New BE.Usuario
                BitacoraBE.bitacora_id = CInt(fila("bitacora_id"))
                UsuarioBE.UsuarioId = CInt(fila("usuario_fk"))
                BitacoraBE.usuario = UsuarioBE
                BitacoraBE.Descripcion = CStr(fila("descripcion"))
                BitacoraBE.fecha = CDate(fila("fecha_hora"))
                BitacoraBE.criticidad = CStr(fila("criticidad"))
                bitacora = BitacoraBE
            Next

        Catch ex As Exception
            Throw ex

        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return bitacora
    End Function


    Public Function ListarBitacoraPorParametros(usuario_id As Integer, fechaDesde As DateTime, fechaHasta As DateTime, criticidad As String) As List(Of BE.Bitacora)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim ds As New DataSet
        Dim usuarioId As New SqlClient.SqlParameter
        Dim fecha_desde As New SqlClient.SqlParameter
        Dim fecha_hasta As New SqlClient.SqlParameter
        Dim criticidad_desc As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "bit_ListarBitacoraPorParametros"

        usuarioId.DbType = DbType.Int32
        usuarioId.ParameterName = "@usuario_id"
        usuarioId.Value = usuario_id

        fecha_desde.DbType = DbType.DateTime
        fecha_desde.ParameterName = "@fecha_desde"
        fecha_desde.Value = fechaDesde

        fecha_hasta.DbType = DbType.DateTime
        fecha_hasta.ParameterName = "@fecha_hasta"
        fecha_hasta.Value = fechaHasta

        criticidad_desc.DbType = DbType.String
        criticidad_desc.ParameterName = "@criticidad"
        criticidad_desc.Value = criticidad

        comm.Parameters.Add(usuarioId)
        comm.Parameters.Add(fecha_desde)
        comm.Parameters.Add(fecha_hasta)
        comm.Parameters.Add(criticidad_desc)

        Dim bitacoras As New List(Of BE.Bitacora)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim BitacoraBE As New BE.Bitacora
                Dim UsuarioBE As New BE.Usuario
                BitacoraBE.bitacora_id = CInt(fila("bitacora_id"))
                UsuarioBE.UsuarioId = CInt(fila("usuario_fk"))
                UsuarioBE.NombreUsuario = CStr(fila("nombre_usuario"))
                BitacoraBE.usuario = UsuarioBE
                BitacoraBE.Descripcion = CStr(fila("descripcion"))
                BitacoraBE.fecha = CDate(fila("fecha_hora"))
                BitacoraBE.criticidad = CStr(fila("criticidad"))
                bitacoras.Add(BitacoraBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return bitacoras
    End Function

    Function ObtenerMaxId() As Integer
        Dim SqlComm As New SqlClient.SqlCommand

        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        sqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT MAX(bitacora_id) as MaxId FROM Bitacora ")
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        sqlConn.Close()

        Return dt.Rows(0).Item(0)
    End Function


End Class ' Bitacora