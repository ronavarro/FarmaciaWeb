'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Class Cliente

    Implements BE.ICrud(Of BE.Cliente)

    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}


    Private Shared _instancia As DAL.Cliente

    Public Shared Function GetInstance() As DAL.Cliente

        If _instancia Is Nothing Then

            _instancia = New DAL.Cliente

        End If

        Return _instancia
    End Function

    Public Function Add(objAdd As BE.Cliente) As Boolean Implements BE.ICrud(Of BE.Cliente).Add
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim dni As New SqlClient.SqlParameter
        Dim apellido As New SqlClient.SqlParameter
        Dim nombre As New SqlClient.SqlParameter
        Dim nombreCompleto As New SqlClient.SqlParameter
        Dim email As New SqlClient.SqlParameter
        Dim telefono As New SqlClient.SqlParameter
        Dim fechaAlta As New SqlClient.SqlParameter
        Dim direccion As New SqlClient.SqlParameter
        Dim localidadId As New SqlClient.SqlParameter
        Dim provinciaId As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cli_InsertarCliente"

        dni.DbType = DbType.Int32
        dni.ParameterName = "@dni"
        dni.Value = objAdd.dni

        apellido.DbType = DbType.String
        apellido.ParameterName = "@apellido"
        apellido.Value = objAdd.apellido

        nombre.DbType = DbType.String
        nombre.ParameterName = "@nombre"
        nombre.Value = objAdd.nombre

        nombreCompleto.DbType = DbType.String
        nombreCompleto.ParameterName = "@nombreCompleto"
        nombreCompleto.Value = objAdd.apellido & ", " & objAdd.nombre

        email.DbType = DbType.String
        email.ParameterName = "@email"
        email.Value = objAdd.email

        telefono.DbType = DbType.String
        telefono.ParameterName = "@telefono"
        telefono.Value = objAdd.telefono

        fechaAlta.DbType = DbType.DateTime
        fechaAlta.ParameterName = "@fecha_alta"
        fechaAlta.Value = DateTime.Now

        direccion.DbType = DbType.String
        direccion.ParameterName = "@direccion"
        direccion.Value = objAdd.direccion

        localidadId.DbType = DbType.Int16
        localidadId.ParameterName = "@localidad_fk"
        localidadId.Value = objAdd.localidad.LocalidadId

        provinciaId.DbType = DbType.Int16
        provinciaId.ParameterName = "@provincia_fk"
        provinciaId.Value = objAdd.localidad.Provincia.provinciaId

        comm.Parameters.Add(dni)
        comm.Parameters.Add(apellido)
        comm.Parameters.Add(nombre)
        comm.Parameters.Add(nombreCompleto)
        comm.Parameters.Add(telefono)
        comm.Parameters.Add(fechaAlta)
        comm.Parameters.Add(email)
        comm.Parameters.Add(direccion)
        comm.Parameters.Add(localidadId)
        comm.Parameters.Add(provinciaId)
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

    Public Function Delete(objDel As BE.Cliente) As Boolean Implements BE.ICrud(Of BE.Cliente).Delete
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim clienteID As New SqlClient.SqlParameter
        Dim eliminado As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cli_EliminarCliente"

        clienteID.DbType = DbType.Int32
        clienteID.ParameterName = "@cliente_Id"
        clienteID.Value = objDel.clienteId

        eliminado.DbType = DbType.Boolean
        eliminado.ParameterName = "@eliminado"
        eliminado.Value = objDel.eliminado

        comm.Parameters.Add(clienteID)
        comm.Parameters.Add(eliminado)

        Try
            sqlDA.DeleteCommand = comm

            sqlDA.DeleteCommand.Connection.Open()

            If sqlDA.DeleteCommand.ExecuteNonQuery > 0 Then
                returnValue = True
            End If

        Catch ex As Exception
            Throw ex
        Finally
            sqlDA.DeleteCommand.Connection.Close()
        End Try

        Return returnValue
    End Function

    Public Function ListAll() As List(Of BE.Cliente) Implements BE.ICrud(Of BE.Cliente).ListAll
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cli_ObtenerClientes"
        Dim clientes As New List(Of BE.Cliente)

        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim ClienteBE As New BE.Cliente
                Dim LocalidadBE As New BE.Localidad
                Dim ProvinciaBE As New BE.Provincia

                ClienteBE.clienteId = CInt(fila("cliente_Id"))
                ClienteBE.dni = fila("dni")
                ClienteBE.apellido = CStr(fila("apellido"))
                ClienteBE.nombre = CStr(fila("nombre"))
                ClienteBE.NombreCompleto = fila("nombreCompleto")
                ClienteBE.telefono = CStr((fila("telefono")))
                ClienteBE.fecha_alta = fila("fecha_alta")
                ClienteBE.email = CStr((fila("email")))
                ClienteBE.direccion = CStr(fila("direccion"))
                ClienteBE.eliminado = CBool(fila("eliminado"))
                ProvinciaBE.provinciaId = CInt(fila("provincia_fk"))
                LocalidadBE.Provincia = ProvinciaBE
                LocalidadBE.LocalidadId = CInt(fila("localidad_fk"))
                ClienteBE.localidad = LocalidadBE
                clientes.Add(ClienteBE)

            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return clientes
    End Function

    Public Function ListById(objId As BE.Cliente) As BE.Cliente Implements BE.ICrud(Of BE.Cliente).ListById
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim clienteId As New SqlClient.SqlParameter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cli_ObtenerClientesPorID"

        clienteId.DbType = DbType.Int32
        clienteId.ParameterName = "@cliente_Id"
        clienteId.Value = objId.clienteId

        comm.Parameters.Add(clienteId)
        Dim clientes As New BE.Cliente

        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim ClienteBE As New BE.Cliente
                Dim LocalidadBE As New BE.Localidad
                Dim ProvinciaBE As New BE.Provincia

                ClienteBE.clienteId = CInt(fila("cliente_Id"))
                ClienteBE.dni = fila("dni")
                ClienteBE.apellido = CStr(fila("apellido"))
                ClienteBE.nombre = CStr(fila("nombre"))
                ClienteBE.NombreCompleto = fila("nombreCompleto")
                ClienteBE.telefono = CStr((fila("telefono")))
                ClienteBE.fecha_alta = fila("fecha_alta")
                ClienteBE.email = CStr((fila("email")))
                ClienteBE.direccion = CStr(fila("direccion"))
                ClienteBE.eliminado = CBool(fila("eliminado"))
                ProvinciaBE.provinciaId = CInt(fila("provincia_fk"))
                LocalidadBE.Provincia = ProvinciaBE
                LocalidadBE.LocalidadId = CInt(fila("localidad_fk"))
                ClienteBE.localidad = LocalidadBE
                clientes = ClienteBE
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return clientes
    End Function

    Public Function Update(objUpd As BE.Cliente) As Boolean Implements BE.ICrud(Of BE.Cliente).Update
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim clienteId As New SqlClient.SqlParameter
        Dim dni As New SqlClient.SqlParameter
        Dim apellido As New SqlClient.SqlParameter
        Dim nombre As New SqlClient.SqlParameter
        Dim nombreCompleto As New SqlClient.SqlParameter
        Dim telefono As New SqlClient.SqlParameter
        Dim email As New SqlClient.SqlParameter
        Dim direccion As New SqlClient.SqlParameter
        Dim localidadId As New SqlClient.SqlParameter
        Dim provinciaId As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cli_ModificarCliente"

        clienteId.DbType = DbType.Int16
        clienteId.ParameterName = "@cliente_Id"
        clienteId.Value = objUpd.clienteId

        dni.DbType = DbType.Int32
        dni.ParameterName = "@dni"
        dni.Value = objUpd.dni

        apellido.DbType = DbType.String
        apellido.ParameterName = "@apellido"
        apellido.Value = objUpd.apellido

        nombre.DbType = DbType.String
        nombre.ParameterName = "@nombre"
        nombre.Value = objUpd.nombre

        nombreCompleto.DbType = DbType.String
        nombreCompleto.ParameterName = "@nombreCompleto"
        nombreCompleto.Value = objUpd.apellido & ", " & objUpd.nombre

        telefono.DbType = DbType.String
        telefono.ParameterName = "@telefono"
        telefono.Value = objUpd.telefono

        email.DbType = DbType.String
        email.ParameterName = "@email"
        email.Value = objUpd.email

        direccion.DbType = DbType.String
        direccion.ParameterName = "@direccion"
        direccion.Value = objUpd.direccion

        localidadId.DbType = DbType.Int16
        localidadId.ParameterName = "@localidad_fk"
        localidadId.Value = objUpd.localidad.LocalidadId

        provinciaId.DbType = DbType.Int16
        provinciaId.ParameterName = "@provincia_fk"
        provinciaId.Value = objUpd.localidad.Provincia.provinciaId

        comm.Parameters.Add(clienteId)
        comm.Parameters.Add(dni)
        comm.Parameters.Add(apellido)
        comm.Parameters.Add(nombre)
        comm.Parameters.Add(nombreCompleto)
        comm.Parameters.Add(telefono)
        comm.Parameters.Add(email)
        comm.Parameters.Add(direccion)
        comm.Parameters.Add(localidadId)
        comm.Parameters.Add(provinciaId)
        Try
            sqlDA.UpdateCommand = comm

            sqlDA.UpdateCommand.Connection.Open()

            If sqlDA.UpdateCommand.ExecuteNonQuery > 0 Then
                returnValue = True
            End If

        Catch ex As Exception
            Throw ex
        Finally
            sqlDA.UpdateCommand.Connection.Close()
        End Try

        Return returnValue
    End Function

    Public Function VerificarExistencia(_dni As Integer) As Boolean
        Dim returnValue As Boolean = False
        Dim comm As New SqlClient.SqlCommand
        Dim dni As New SqlClient.SqlParameter
        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cli_VerificarExistencia"

        dni.DbType = DbType.Int32
        dni.ParameterName = "@dni"
        dni.Value = _dni

        comm.Parameters.Add(dni)

        Try
            sqlConn.Open()
            reader = comm.ExecuteReader()

            If reader.HasRows Then
                returnValue = True
            End If
        Catch ex As Exception
            Throw ex
        Finally
            reader = Nothing
            sqlConn.Close()
        End Try
        Return returnValue
    End Function

    Function ObtenerMaxId() As Integer
        Dim SqlComm As New SqlClient.SqlCommand

        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        sqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT MAX(Cliente_id) as MaxId FROM Cliente ")
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        sqlConn.Close()

        Return dt.Rows(0).Item(0)
    End Function

    Function ObtenerClientePorDNI(dni As String) As List(Of BE.Cliente)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim _dni As New SqlClient.SqlParameter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cli_ObtenerClientesPorDNI"

        _dni.DbType = DbType.String
        _dni.ParameterName = "@dni"
        _dni.Value = dni

        comm.Parameters.Add(_dni)
        Dim clientes As New List(Of BE.Cliente)

        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim ClienteBE As New BE.Cliente
                Dim LocalidadBE As New BE.Localidad
                Dim ProvinciaBE As New BE.Provincia

                ClienteBE.clienteId = CInt(fila("cliente_Id"))
                ClienteBE.dni = fila("dni")
                ClienteBE.apellido = CStr(fila("apellido"))
                ClienteBE.nombre = CStr(fila("nombre"))
                ClienteBE.NombreCompleto = fila("nombreCompleto")
                ClienteBE.telefono = CStr((fila("telefono")))
                ClienteBE.fecha_alta = fila("fecha_alta")
                ClienteBE.email = CStr((fila("email")))
                ClienteBE.direccion = CStr(fila("direccion"))
                ClienteBE.eliminado = CBool(fila("eliminado"))
                ProvinciaBE.provinciaId = CInt(fila("provincia_fk"))
                LocalidadBE.Provincia = ProvinciaBE
                LocalidadBE.LocalidadId = CInt(fila("localidad_fk"))
                ClienteBE.localidad = LocalidadBE
                clientes.Add(ClienteBE)

            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return clientes
    End Function

    Function ObtenerClientePorApellido_Nombre(apellido_nombre As String) As List(Of BE.Cliente)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim _Apellido_Nombre As New SqlClient.SqlParameter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cli_ObtenerClientesPorApellido_Nombre"

        _Apellido_Nombre.DbType = DbType.String
        _Apellido_Nombre.ParameterName = "@Apellido_Nombre"
        _Apellido_Nombre.Value = apellido_nombre

        comm.Parameters.Add(_Apellido_Nombre)
        Dim clientes As New List(Of BE.Cliente)

        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim ClienteBE As New BE.Cliente
                Dim LocalidadBE As New BE.Localidad
                Dim ProvinciaBE As New BE.Provincia

                ClienteBE.clienteId = CInt(fila("cliente_Id"))
                ClienteBE.dni = fila("dni")
                ClienteBE.apellido = CStr(fila("apellido"))
                ClienteBE.nombre = CStr(fila("nombre"))
                ClienteBE.NombreCompleto = fila("nombreCompleto")
                ClienteBE.telefono = CStr((fila("telefono")))
                ClienteBE.fecha_alta = fila("fecha_alta")
                ClienteBE.email = CStr((fila("email")))
                ClienteBE.direccion = CStr(fila("direccion"))
                ClienteBE.eliminado = CBool(fila("eliminado"))
                ProvinciaBE.provinciaId = CInt(fila("provincia_fk"))
                LocalidadBE.Provincia = ProvinciaBE
                LocalidadBE.LocalidadId = CInt(fila("localidad_fk"))
                ClienteBE.localidad = LocalidadBE
                clientes.Add(ClienteBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return clientes
    End Function

    Function ObtenerClientesDisponibles() As List(Of BE.Cliente)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = SqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "cli_ObtenerClientesDisponibles"
        Dim clientes As New List(Of BE.Cliente)

        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim ClienteBE As New BE.Cliente
                Dim LocalidadBE As New BE.Localidad
                Dim ProvinciaBE As New BE.Provincia

                ClienteBE.clienteId = CInt(fila("cliente_Id"))
                ClienteBE.dni = fila("dni")
                ClienteBE.apellido = CStr(fila("apellido"))
                ClienteBE.nombre = CStr(fila("nombre"))
                ClienteBE.NombreCompleto = fila("nombreCompleto")
                ClienteBE.telefono = CStr((fila("telefono")))
                ClienteBE.fecha_alta = fila("fecha_alta")
                ClienteBE.email = CStr((fila("email")))
                ClienteBE.direccion = CStr(fila("direccion"))
                ClienteBE.eliminado = CBool(fila("eliminado"))
                ProvinciaBE.provinciaId = CInt(fila("provincia_fk"))
                LocalidadBE.Provincia = ProvinciaBE
                LocalidadBE.LocalidadId = CInt(fila("localidad_fk"))
                ClienteBE.localidad = LocalidadBE
                clientes.Add(ClienteBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return clientes
    End Function

End Class ' Cliente