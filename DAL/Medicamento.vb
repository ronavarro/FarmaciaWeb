'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

 
Public Class Medicamento

    Implements BE.ICrud(Of BE.Medicamento)
    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}


    Private Shared _instancia As DAL.Medicamento

    Public Shared Function GetInstance() As DAL.Medicamento

        If _instancia Is Nothing Then

            _instancia = New DAL.Medicamento

        End If

        Return _instancia
    End Function

    Public Function Add(objAdd As BE.Medicamento) As Boolean Implements BE.ICrud(Of BE.Medicamento).Add
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim descripcion As New SqlClient.SqlParameter
        Dim laboratorioId As New SqlClient.SqlParameter
        Dim precio As New SqlClient.SqlParameter
        Dim cantidad As New SqlClient.SqlParameter
        Dim receta As New SqlClient.SqlParameter


        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "med_InsertarMedicamento"

        descripcion.DbType = DbType.String
        descripcion.ParameterName = "@descripcion"
        descripcion.Value = objAdd.descripcion

        laboratorioId.DbType = DbType.Int32
        laboratorioId.ParameterName = "@laboratorio_id"
        laboratorioId.Value = objAdd.laboratorio.laboratorioId
        
        precio.DbType = DbType.String
        precio.ParameterName = "@precio"
        precio.Value = objAdd.precio

        cantidad.DbType = DbType.String
        cantidad.ParameterName = "@cantidad"
        cantidad.Value = objAdd.cantidad

        receta.DbType = DbType.Boolean
        receta.ParameterName = "@receta"
        receta.Value = objAdd.Receta

        comm.Parameters.Add(descripcion)
        comm.Parameters.Add(laboratorioId)
        comm.Parameters.Add(precio)
        comm.Parameters.Add(cantidad)
        comm.Parameters.Add(receta)

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

    Public Function Delete(objDel As BE.Medicamento) As Boolean Implements BE.ICrud(Of BE.Medicamento).Delete

        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim medicamentoId As New SqlClient.SqlParameter
        Dim eliminado As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "med_EliminarMedicamento"

        medicamentoId.DbType = DbType.Int32
        medicamentoId.ParameterName = "@medicamento_Id"
        medicamentoId.Value = objDel.medicamentoId

        eliminado.DbType = DbType.Boolean
        eliminado.ParameterName = "@eliminado"
        eliminado.Value = objDel.eliminado

        comm.Parameters.Add(medicamentoId)
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

    Public Function ListAll() As List(Of BE.Medicamento) Implements BE.ICrud(Of BE.Medicamento).ListAll
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "med_ObtenerMedicamentos"
        Dim medicamentos As New List(Of BE.Medicamento)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim MedicamentoBE As New BE.Medicamento
                Dim LaboratorioBE As New BE.Laboratorio
                MedicamentoBE.medicamentoId = CInt(fila("medicamento_id"))
                MedicamentoBE.descripcion = CStr(fila("descripcion"))
                LaboratorioBE.razonSocial = CStr(fila("razon_social"))
                MedicamentoBE.laboratorio = LaboratorioBE
                MedicamentoBE.eliminado = CBool(fila("eliminado"))
                MedicamentoBE.precio = CStr(fila("precio"))
                MedicamentoBE.cantidad = CStr(fila("cantidad"))
                MedicamentoBE.Receta = CBool(fila("receta"))
                medicamentos.Add(MedicamentoBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return medicamentos
    End Function

    Public Function ListById(objId As BE.Medicamento) As BE.Medicamento Implements BE.ICrud(Of BE.Medicamento).ListById
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim medicamentoId As New SqlClient.SqlParameter
        Dim ds As New DataSet
        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure

        comm.CommandText = "med_ObtenerMedicamentosPorID"

        medicamentoId.DbType = DbType.Int32
        medicamentoId.ParameterName = "@medicamento_id"
        medicamentoId.Value = objId.medicamentoId

        comm.Parameters.Add(medicamentoId)
        Dim medicamentos As New BE.Medicamento

        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim MedicamentoBE As New BE.Medicamento
                Dim LaboratorioBE As New BE.Laboratorio
                MedicamentoBE.medicamentoId = CInt(fila("medicamento_id"))
                MedicamentoBE.descripcion = CStr(fila("descripcion"))
                LaboratorioBE.cuit = CStr(fila("cuit"))
                LaboratorioBE.laboratorioId = CInt(fila("laboratorio_id"))
                LaboratorioBE.razonSocial = CStr(fila("razon_social"))
                MedicamentoBE.laboratorio = LaboratorioBE
                MedicamentoBE.eliminado = CBool(fila("eliminado"))
                MedicamentoBE.precio = CStr(fila("precio"))
                MedicamentoBE.cantidad = CStr(fila("cantidad"))
                MedicamentoBE.Receta = CBool(fila("receta"))
                medicamentos = MedicamentoBE
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return medicamentos
    End Function

    Public Function Update(objUpd As BE.Medicamento) As Boolean Implements BE.ICrud(Of BE.Medicamento).Update
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim medicamentoId As New SqlClient.SqlParameter
        Dim descripcion As New SqlClient.SqlParameter
        Dim laboratorioId As New SqlClient.SqlParameter
        Dim precio As New SqlClient.SqlParameter
        Dim cantidad As New SqlClient.SqlParameter
        Dim receta As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "med_ModificarMedicamento"

        medicamentoId.DbType = DbType.Int32
        medicamentoId.ParameterName = "@medicamento_id"
        medicamentoId.Value = objUpd.medicamentoId

        descripcion.DbType = DbType.String
        descripcion.ParameterName = "@descripcion"
        descripcion.Value = objUpd.descripcion

        laboratorioId.DbType = DbType.Int32
        laboratorioId.ParameterName = "@laboratorio_id"
        laboratorioId.Value = objUpd.laboratorio.laboratorioId

        precio.DbType = DbType.String
        precio.ParameterName = "@precio"
        precio.Value = objUpd.precio

        cantidad.DbType = DbType.String
        cantidad.ParameterName = "@cantidad"
        cantidad.Value = objUpd.cantidad

        receta.DbType = DbType.Boolean
        receta.ParameterName = "@receta"
        receta.Value = objUpd.Receta

        comm.Parameters.Add(medicamentoId)
        comm.Parameters.Add(descripcion)
        comm.Parameters.Add(laboratorioId)
        comm.Parameters.Add(precio)
        comm.Parameters.Add(cantidad)
        comm.Parameters.Add(receta)

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

    Public Function VerificarExistencia(unMedicamento As BE.Medicamento) As Boolean
        Dim returnValue As Boolean = False
        Dim comm As New SqlClient.SqlCommand
        Dim descripcion As New SqlClient.SqlParameter
        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "med_VerificarMedicamento"

        descripcion.DbType = DbType.String
        descripcion.ParameterName = "@descripcion"
        descripcion.Value = unMedicamento.descripcion

        comm.Parameters.Add(descripcion)

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
        SqlComm.CommandText = String.Format("SELECT MAX(medicamento_id) as MaxId FROM Medicamento ")
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        sqlConn.Close()

        Return dt.Rows(0).Item(0)
    End Function

    Function ObtenerMedicamentoPorDescripcion(strDescripcion As String) As List(Of BE.Medicamento)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet
        Dim descripcion As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "med_ObtenerMedicamentosPorDescripcion"

        descripcion.DbType = DbType.String
        descripcion.ParameterName = "@descripcion"
        descripcion.Value = strDescripcion

        comm.Parameters.Add(descripcion)

        Dim medicamentos As New List(Of BE.Medicamento)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim MedicamentoBE As New BE.Medicamento
                Dim LaboratorioBE As New BE.Laboratorio
                MedicamentoBE.medicamentoId = CInt(fila("medicamento_id"))
                MedicamentoBE.descripcion = CStr(fila("descripcion"))
                LaboratorioBE.razonSocial = CStr(fila("razon_social"))
                MedicamentoBE.laboratorio = LaboratorioBE
                MedicamentoBE.eliminado = CBool(fila("eliminado"))
                MedicamentoBE.precio = CStr(fila("precio"))
                MedicamentoBE.cantidad = CStr(fila("cantidad"))
                MedicamentoBE.Receta = CBool(fila("receta"))
                medicamentos.Add(MedicamentoBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return medicamentos
    End Function

    Function ObtenerMedicamentoPorLaboratorio(laboratorio As BE.Laboratorio) As List(Of BE.Medicamento)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet
        Dim _laboratorioId As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "med_ObtenerMedicamentosPorLaboratorio"

        _laboratorioId.DbType = DbType.Int16
        _laboratorioId.ParameterName = "@laboratorio_id"
        _laboratorioId.Value = laboratorio.laboratorioId

        comm.Parameters.Add(_laboratorioId)

        Dim medicamentos As New List(Of BE.Medicamento)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim MedicamentoBE As New BE.Medicamento
                Dim LaboratorioBE As New BE.Laboratorio
                MedicamentoBE.medicamentoId = CInt(fila("medicamento_id"))
                MedicamentoBE.descripcion = CStr(fila("descripcion"))
                LaboratorioBE.razonSocial = CStr(fila("razon_social"))
                MedicamentoBE.laboratorio = LaboratorioBE
                MedicamentoBE.eliminado = CBool(fila("eliminado"))
                MedicamentoBE.precio = CStr(fila("precio"))
                MedicamentoBE.cantidad = CStr(fila("cantidad"))
                MedicamentoBE.Receta = CBool(fila("receta"))
                medicamentos.Add(MedicamentoBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return medicamentos
    End Function

    Function ObtenerMedicamentosDisponibles(cantidad As String) As List(Of BE.Medicamento)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet
        Dim _cantidad As New SqlClient.SqlParameter

        comm.Connection = SqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "med_ObtenerMedicamentosDisponibles"

        _cantidad.DbType = DbType.String
        _cantidad.ParameterName = "@cantidad"
        _cantidad.Value = cantidad

        comm.Parameters.Add(_cantidad)
        Dim medicamentos As New List(Of BE.Medicamento)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim MedicamentoBE As New BE.Medicamento
                Dim LaboratorioBE As New BE.Laboratorio
                MedicamentoBE.medicamentoId = CInt(fila("medicamento_id"))
                MedicamentoBE.descripcion = CStr(fila("descripcion"))
                LaboratorioBE.razonSocial = CStr(fila("razon_social"))
                MedicamentoBE.laboratorio = LaboratorioBE
                MedicamentoBE.eliminado = CBool(fila("eliminado"))
                MedicamentoBE.precio = CStr(fila("precio"))
                MedicamentoBE.cantidad = CStr(fila("cantidad"))
                MedicamentoBE.Receta = CBool(fila("receta"))
                medicamentos.Add(MedicamentoBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return medicamentos
    End Function

    Function ActualizarStock(unMedicamento As BE.Medicamento) As Boolean
        Dim SqlComm As New SqlClient.SqlCommand
        SqlConn.Open()
        SqlComm.CommandText = String.Format("UPDATE [dbo].[Medicamento]  SET [cantidad] = '" & unMedicamento.cantidad & "'  WHERE [medicamento_id] = " & unMedicamento.medicamentoId)
        SqlComm.Connection = SqlConn
        SqlComm.ExecuteNonQuery()
        SqlConn.Close()
        Return True
    End Function

    Function ObtenerMedicamentoPorParametros(descripcion As String, laboratorio As BE.Laboratorio, check As Boolean) As List(Of BE.Medicamento)
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet
        Dim receta As New SqlClient.SqlParameter
        Dim _descripcion As New SqlClient.SqlParameter
        Dim _laboratorioId As New SqlClient.SqlParameter

        comm.Connection = SqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "med_ObtenerMedicamentoPorParametros"

        _descripcion.DbType = DbType.String
        _descripcion.ParameterName = "@descripcion"
        _descripcion.Value = descripcion

        _laboratorioId.DbType = DbType.Int16
        _laboratorioId.ParameterName = "@laboratorio_id"
        _laboratorioId.Value = laboratorio.laboratorioId

        receta.DbType = DbType.Boolean
        receta.ParameterName = "@receta"
        receta.Value = check

        comm.Parameters.Add(_descripcion)
        comm.Parameters.Add(_laboratorioId)
        comm.Parameters.Add(receta)

        Dim medicamentos As New List(Of BE.Medicamento)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim MedicamentoBE As New BE.Medicamento
                Dim LaboratorioBE As New BE.Laboratorio
                MedicamentoBE.medicamentoId = CInt(fila("medicamento_id"))
                MedicamentoBE.descripcion = CStr(fila("descripcion"))
                LaboratorioBE.razonSocial = CStr(fila("razon_social"))
                MedicamentoBE.laboratorio = LaboratorioBE
                MedicamentoBE.eliminado = CBool(fila("eliminado"))
                MedicamentoBE.precio = CStr(fila("precio"))
                MedicamentoBE.cantidad = CStr(fila("cantidad"))
                MedicamentoBE.Receta = CBool(fila("receta"))
                medicamentos.Add(MedicamentoBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return medicamentos
    End Function


End Class ' Medicamento