'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
Public Class Venta
    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}


    Private Shared _instancia As DAL.Venta

    Public Shared Function GetInstance() As DAL.Venta

        If _instancia Is Nothing Then

            _instancia = New DAL.Venta

        End If

        Return _instancia
    End Function

    Public Function RegistrarVenta(objAdd As BE.Venta) As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim fechaVenta As New SqlClient.SqlParameter
        Dim dvh As New SqlClient.SqlParameter
        Dim clienteId As New SqlClient.SqlParameter

        comm.Connection = SqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "vent_InsertarVenta"

        fechaVenta.DbType = DbType.DateTime
        fechaVenta.ParameterName = "@fecha_venta"
        fechaVenta.Value = objAdd.fechaVenta

        clienteId.DbType = DbType.Int32
        clienteId.ParameterName = "@cliente_fk"
        clienteId.Value = objAdd.cliente.clienteId

        dvh.DbType = DbType.Int16
        dvh.ParameterName = "@dvh"
        dvh.Value = 0

        comm.Parameters.Add(fechaVenta)
        comm.Parameters.Add(clienteId)
        comm.Parameters.Add(dvh)

        Try
            sqlDA.InsertCommand = comm

            sqlDA.InsertCommand.Connection.Open()

            If sqlDA.InsertCommand.ExecuteNonQuery > 0 Then
                sqlDA.InsertCommand.Connection.Close()
                Dim maxId As Integer = ObtenerMaxId()
                For Each item As BE.VentaMedicamento In objAdd.medicamentos
                    returnValue = RegistrarVentaMedicamentos(item, maxId)
                    If returnValue = False Then
                        Exit For
                    End If
                Next
                returnValue = True
            End If

        Catch ex As Exception
            Throw ex
        Finally
            sqlDA.InsertCommand.Connection.Close()
        End Try

        Return returnValue
    End Function


    Public Function ModificarVenta(objUpd As BE.Venta) As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim ventaId As New SqlClient.SqlParameter
        Dim clienteId As New SqlClient.SqlParameter
        Dim dvh As New SqlClient.SqlParameter

        comm.Connection = SqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "vent_ModificarVenta"

        ventaId.DbType = DbType.Int32
        ventaId.ParameterName = "@venta_id"
        ventaId.Value = objUpd.ventaId

        clienteId.DbType = DbType.Int32
        clienteId.ParameterName = "@cliente_id"
        clienteId.Value = objUpd.cliente.clienteId

        dvh.DbType = DbType.Int16
        dvh.ParameterName = "@dvh"
        dvh.Value = 0

        comm.Parameters.Add(ventaId)
        comm.Parameters.Add(clienteId)

        Try
            sqlDA.UpdateCommand = comm

            sqlDA.UpdateCommand.Connection.Open()

            If sqlDA.UpdateCommand.ExecuteNonQuery > 0 Then
                sqlDA.UpdateCommand.Connection.Close()
                If QuitarMedicamentoVenta(objUpd) Then
                    For Each item As BE.VentaMedicamento In objUpd.medicamentos
                        returnValue = RegistrarVentaMedicamentos(item, objUpd.ventaId)
                        If returnValue = False Then
                            Exit For
                        End If
                    Next
                End If
            End If
        Catch ex As Exception
            Throw ex
        Finally
            sqlDA.UpdateCommand.Connection.Close()
        End Try

        Return returnValue
    End Function

    Function QuitarMedicamentoVenta(unaVenta As BE.Venta) As Boolean
        Dim SqlComm As New SqlClient.SqlCommand
        SqlConn.Open()
        SqlComm.CommandText = String.Format("delete from [farmacia].dbo.Venta_Medicamento  where venta_id = " & unaVenta.ventaId)
        SqlComm.Connection = SqlConn
        SqlComm.ExecuteNonQuery()
        SqlConn.Close()
        Return True
    End Function



    Public Function ListarVentasPorParametros(fechaDesde As DateTime, fechaHasta As DateTime, cliente_fk As Integer) As List(Of BE.Venta)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim ds As New DataSet

        Dim fecha_desde As New SqlClient.SqlParameter
        Dim fecha_hasta As New SqlClient.SqlParameter
        Dim clienteFk As New SqlClient.SqlParameter
 
        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "vent_ListarVentasPorParametros"

        fecha_desde.DbType = DbType.DateTime
        fecha_desde.ParameterName = "@fecha_desde"
        fecha_desde.Value = fechaDesde

        fecha_hasta.DbType = DbType.DateTime
        fecha_hasta.ParameterName = "@fecha_hasta"
        fecha_hasta.Value = fechaHasta

        clienteFk.DbType = DbType.Int16
        clienteFk.ParameterName = "@cliente_fk"
        clienteFk.Value = cliente_fk

        comm.Parameters.Add(fecha_desde)
        comm.Parameters.Add(fecha_hasta)
        comm.Parameters.Add(clienteFk)
 
        Dim ventas As New List(Of BE.Venta)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim VentaBE As New BE.Venta
                Dim ClienteBE As New BE.Cliente

                VentaBE.ventaId = CInt(fila("venta_id"))
                VentaBE.fechaVenta = CDate(fila("fecha_venta"))
                ClienteBE.clienteId = CInt(fila("cliente_id"))
                ClienteBE.NombreCompleto = CStr(fila("nombreCompleto"))
                VentaBE.cliente = ClienteBE
                Dim MedicamentoBE As New List(Of BE.VentaMedicamento)
                For Each item In ObtenerMedicamentosPorVenta(VentaBE.ventaId).Rows
                    Dim Medicamento As New BE.VentaMedicamento
                    Dim ventaMed As New BE.Venta
                    ventaMed.ventaId = item("venta_id")
                    Medicamento.Venta = ventaMed
                    Medicamento.ventaMedicamentoId = item("venta_medicamento_id")
                    Medicamento.CantidadVenta = item("cantidad_venta")
                    Medicamento.PrecioVenta = item("precio_venta")
                    MedicamentoBE.Add(Medicamento)
                Next
                VentaBE.medicamentos = MedicamentoBE
                ventas.Add(VentaBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try
        Return ventas
    End Function


    Public Function RegistrarVentaMedicamentos(medicamento As BE.VentaMedicamento, ventaId As Integer) As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim _ventaId As New SqlClient.SqlParameter
        Dim medicamentoId As New SqlClient.SqlParameter
        Dim cantidadVenta As New SqlClient.SqlParameter
        Dim precioVenta As New SqlClient.SqlParameter


        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "vent_InsertarVentaMedicamento"

        _ventaId.DbType = DbType.Int32
        _ventaId.ParameterName = "@venta_id"
        _ventaId.Value = ventaId

        medicamentoId.DbType = DbType.Int16
        medicamentoId.ParameterName = "@medicamento_id"
        medicamentoId.Value = medicamento.Medicamento.medicamentoId

        cantidadVenta.DbType = DbType.String
        cantidadVenta.ParameterName = "@cantidad_venta"
        cantidadVenta.Value = medicamento.CantidadVenta

        precioVenta.DbType = DbType.String
        precioVenta.ParameterName = "@precio_venta"
        precioVenta.Value = medicamento.PrecioVenta


        comm.Parameters.Add(_ventaId)
        comm.Parameters.Add(medicamentoId)
        comm.Parameters.Add(cantidadVenta)
        comm.Parameters.Add(precioVenta)

        Try
            sqlDA.InsertCommand = comm

            If sqlDA.InsertCommand.Connection.State = ConnectionState.Closed Then
                sqlDA.InsertCommand.Connection.Open()
            End If

            If sqlDA.InsertCommand.ExecuteNonQuery > 0 Then
                sqlDA.InsertCommand.Connection.Close()
                returnValue = True
            End If

        Catch ex As Exception
            Throw ex
        End Try

        Return returnValue
    End Function


    Public Function ListarVentaById(unaVenta As BE.Venta) As BE.Venta

        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim ds As New DataSet

        Dim _ventaId As New SqlClient.SqlParameter


        comm.Connection = SqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "vent_ListarVentasById"

        _ventaId.DbType = DbType.Int32
        _ventaId.ParameterName = "@venta_id"
        _ventaId.Value = unaVenta.ventaId


        comm.Parameters.Add(_ventaId)

        Dim ventas As New List(Of BE.Venta)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()
            sqlDa.Fill(ds)
            sqlDa.SelectCommand.Connection.Close()

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim VentaBE As New BE.Venta
                Dim ClienteBE As New BE.Cliente

                VentaBE.ventaId = CInt(fila("venta_id"))
                VentaBE.fechaVenta = CDate(fila("fecha_venta"))
                ClienteBE.clienteId = CInt(fila("cliente_id"))
                ClienteBE.NombreCompleto = CStr(fila("nombreCompleto"))
                VentaBE.cliente = DAL.Cliente.GetInstance.ListById(ClienteBE)
                VentaBE.medicamentos = ListarVentasMedicamentosByVentaId(VentaBE)
                ventas.Add(VentaBE)
            Next

        Catch ex As Exception
            Throw ex
        End Try
        Return ventas(0)
    End Function


    '[vent_ListarVentasMedicamentosByVentaId]

    Public Function ListarVentasMedicamentosByVentaId(venta As BE.Venta) As List(Of BE.VentaMedicamento)

        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim ds As New DataSet

        Dim _ventaId As New SqlClient.SqlParameter


        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "vent_ListarVentasMedicamentosByVentaId"

        _ventaId.DbType = DbType.Int32
        _ventaId.ParameterName = "@venta_id"
        _ventaId.Value = venta.ventaId


        comm.Parameters.Add(_ventaId)

        Dim ventaMedicamentos As New List(Of BE.VentaMedicamento)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()
            sqlDa.Fill(ds)
            sqlDa.SelectCommand.Connection.Close()
            For Each fila As DataRow In ds.Tables(0).Rows
                Dim VentaMedicamentoBE As New BE.VentaMedicamento
                Dim MedicamentoBE As New BE.Medicamento

                VentaMedicamentoBE.Venta = venta
                VentaMedicamentoBE.ventaMedicamentoId = CInt(fila("venta_medicamento_id"))
                VentaMedicamentoBE.CantidadVenta = fila("cantidad_venta")
                VentaMedicamentoBE.PrecioVenta = fila("precio_venta")
                MedicamentoBE.medicamentoId = CInt(fila("medicamento_id"))
                VentaMedicamentoBE.Medicamento = DAL.Medicamento.GetInstance.ListById(MedicamentoBE)
                ventaMedicamentos.Add(VentaMedicamentoBE)
            Next

        Catch ex As Exception
            Throw ex
        End Try
        Return ventaMedicamentos
    End Function



    Public Function EliminarVentasMedicamentosByVentaId(ventaId As Integer) As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim _ventaId As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "vent_EliminarVentasMedicamentosByVentaId"

        _ventaId.DbType = DbType.Int16
        _ventaId.ParameterName = "@venta_id"
        _ventaId.Value = ventaId
        comm.Parameters.Add(_ventaId)
        Try
            sqlDA.DeleteCommand = comm
            sqlDA.DeleteCommand.Connection.Open()
            If sqlDA.DeleteCommand.ExecuteNonQuery > 0 Then
                sqlDA.DeleteCommand.Connection.Close()
                returnValue = True
            End If
        Catch ex As Exception
            Throw ex
        End Try

        Return returnValue
    End Function


    Function ObtenerMaxId() As Integer
        Dim SqlComm As New SqlClient.SqlCommand
        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        sqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT isnull(MAX(venta_id),0) as MaxId FROM Venta ")
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        sqlConn.Close()

        Return dt.Rows(0).Item(0)
    End Function

    Function ObtenerMaxIdVenta_Medicamento() As Integer
        Dim SqlComm As New SqlClient.SqlCommand
        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        SqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT isnull(MAX(venta_medicamento_id),0) as MaxId FROM Venta_Medicamento ")
        SqlComm.Connection = SqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        SqlConn.Close()

        Return dt.Rows(0).Item(0)
    End Function

    Private Function ObtenerMedicamentosPorVenta(_VentaId As Integer) As Object
        Dim SqlComm As New SqlClient.SqlCommand
        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable
        SqlComm.CommandText = String.Format("SELECT * FROM  [farmacia].dbo.[Venta_Medicamento] where venta_id = " & _VentaId)
        SqlComm.Connection = SqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        Return dt
    End Function

End Class ' Venta