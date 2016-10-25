'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
Public Class Familia

    Implements BE.ICrud(Of BE.Familia)
    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}


    Private Shared _instancia As DAL.Familia

    Public Shared Function GetInstance() As DAL.Familia

        If _instancia Is Nothing Then

            _instancia = New DAL.Familia

        End If

        Return _instancia
    End Function

    Public Function Add(objAdd As BE.Familia) As Boolean Implements BE.ICrud(Of BE.Familia).Add
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim nombreFamilia As New SqlClient.SqlParameter
        Dim Descripcion As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "fam_InsertarFamilia"

        nombreFamilia.DbType = DbType.String
        nombreFamilia.ParameterName = "@nombre_Familia"
        nombreFamilia.Value = objAdd.nombre

        Descripcion.DbType = DbType.String
        Descripcion.ParameterName = "@Descripcion"
        Descripcion.Value = objAdd.descripcion

        comm.Parameters.Add(nombreFamilia)
        comm.Parameters.Add(Descripcion)
        Try
            sqlDA.InsertCommand = comm

            sqlDA.InsertCommand.Connection.Open()

            If sqlDA.InsertCommand.ExecuteNonQuery > 0 Then
                sqlDA.InsertCommand.Connection.Close()
                Dim maxId As Integer = ObtenerMaxId()
                For Each item As BE.Patente In objAdd.patentes
                    returnValue = AsignarPatenteFamilia(item, maxId)
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

    Public Function Delete(objDel As BE.Familia) As Boolean Implements BE.ICrud(Of BE.Familia).Delete
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim FamiliaId As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "fam_EliminarFamilia"

        FamiliaId.DbType = DbType.Int32
        FamiliaId.ParameterName = "@Familia_id"
        FamiliaId.Value = objDel.familiaId

        comm.Parameters.Add(FamiliaId)

        Try
            sqlDA.DeleteCommand = comm

            sqlDA.DeleteCommand.Connection.Open()

            If sqlDA.DeleteCommand.ExecuteNonQuery > 0 Then
                sqlDA.DeleteCommand.Connection.Close()
                If QuitarPatentes(objDel) Then
                    returnValue = True
                End If
            End If

        Catch ex As Exception
            Throw ex
        Finally
            sqlDA.DeleteCommand.Connection.Close()
        End Try

        Return returnValue
    End Function

    Public Function ListAll() As List(Of BE.Familia) Implements BE.ICrud(Of BE.Familia).ListAll
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "fam_ObtenerFamilias"
        Dim Familias As New List(Of BE.Familia)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim FamiliaBE As New BE.Familia
                FamiliaBE.familiaId = CInt(fila("familia_id"))
                FamiliaBE.nombre = CStr(fila("nombre"))
                FamiliaBE.descripcion = CStr(fila("descripcion"))
                Familias.Add(FamiliaBE)
            Next
            Return Familias

        Catch ex As Exception
            Throw ex
        End Try

        Return Familias
    End Function

    Public Function ListById(objId As BE.Familia) As BE.Familia Implements BE.ICrud(Of BE.Familia).ListById
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim FamiliaId As New SqlClient.SqlParameter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "fam_ObtenerFamiliasPorID"

        FamiliaId.DbType = DbType.Int32
        FamiliaId.ParameterName = "@familia_id"
        FamiliaId.Value = objId.familiaId

        comm.Parameters.Add(FamiliaId)
        Dim _Familia As New BE.Familia

        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim FamiliaBE As New BE.Familia
                FamiliaBE.familiaId = CInt(fila("familia_id"))
                FamiliaBE.nombre = CStr(fila("nombre"))
                FamiliaBE.descripcion = CStr(fila("descripcion"))
                Dim PatenteBE As New List(Of BE.Patente)
                For Each item In ds.Tables(0).Rows
                    Dim Patente As New BE.Patente
                    Patente.PatenteId = item("patente_id")
                    PatenteBE.Add(Patente)
                Next
                FamiliaBE.patentes = PatenteBE
                _Familia = FamiliaBE
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return _Familia
    End Function

    Public Function Update(objUpd As BE.Familia) As Boolean Implements BE.ICrud(Of BE.Familia).Update
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim FamiliaId As New SqlClient.SqlParameter
        Dim nombreFamilia As New SqlClient.SqlParameter
        Dim Descripcion As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "fam_ModificarFamilia"

        FamiliaId.DbType = DbType.Int32
        FamiliaId.ParameterName = "@Familia_id"
        FamiliaId.Value = objUpd.familiaId

        nombreFamilia.DbType = DbType.String
        nombreFamilia.ParameterName = "@nombre_Familia"
        nombreFamilia.Value = objUpd.nombre

        Descripcion.DbType = DbType.String
        Descripcion.ParameterName = "@descripcion"
        Descripcion.Value = objUpd.descripcion

        comm.Parameters.Add(FamiliaId)
        comm.Parameters.Add(nombreFamilia)
        comm.Parameters.Add(Descripcion)

        Try
            sqlDA.UpdateCommand = comm

            sqlDA.UpdateCommand.Connection.Open()

            If sqlDA.UpdateCommand.ExecuteNonQuery > 0 Then
                sqlDA.UpdateCommand.Connection.Close()
                If QuitarPatentes(objUpd) Then
                    For Each item As BE.Patente In objUpd.patentes
                        returnValue = AsignarPatenteFamilia(item, objUpd.familiaId)
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

    Public Function VerificarExistencia(unaFamilia As BE.Familia) As Boolean
        Dim returnValue As Boolean = False
        Dim comm As New SqlClient.SqlCommand
        Dim nombre As New SqlClient.SqlParameter
        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "fam_VerificarExistencia"

        nombre.DbType = DbType.String
        nombre.ParameterName = "@nombre"
        nombre.Value = unaFamilia.nombre

        comm.Parameters.Add(nombre)

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

    Function AsignarPatenteFamilia(patente As BE.Patente, _familiaId As Integer) As Boolean
        Dim SqlComm As New SqlClient.SqlCommand
        sqlConn.Open()
        SqlComm.CommandText = String.Format("insert into [farmacia].dbo.Patente_Familia (familia_id,patente_id) values (" & _familiaId & "," & patente.PatenteId & ")")
        SqlComm.Connection = sqlConn
        SqlComm.ExecuteNonQuery()
        sqlConn.Close()
        Return True
    End Function
    Function QuitarPatentes(unaFamilia As BE.Familia) As Boolean
        Dim SqlComm As New SqlClient.SqlCommand
        sqlConn.Open()
        SqlComm.CommandText = String.Format("delete from [farmacia].dbo.Patente_Familia  where familia_id = " & unaFamilia.familiaId)
        SqlComm.Connection = sqlConn
        SqlComm.ExecuteNonQuery()
        sqlConn.Close()
        Return True
    End Function
    Function ObtenerMaxId() As Integer
        Dim SqlComm As New SqlClient.SqlCommand

        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        sqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT MAX(familia_id) as MaxId FROM Familia ")
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        sqlConn.Close()

        Return dt.Rows(0).Item(0)
    End Function

    Public Function ValidarEliminarFamilia(FamiliaBE As BE.Familia) As Boolean
        Dim returnValue As Boolean = False
        Dim comm As New SqlClient.SqlCommand
        Dim familiaId As New SqlClient.SqlParameter
        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "sp_ValidarEliminarFamilia"

        familiaId.DbType = DbType.Int16
        familiaId.ParameterName = "@familia_id"
        familiaId.Value = FamiliaBE.familiaId

        comm.Parameters.Add(familiaId)

        Try
            sqlConn.Open()
            reader = comm.ExecuteReader()
            If reader.HasRows Then
                While reader.Read()
                    returnValue = reader.GetBoolean(0)
                End While
            End If
        Catch ex As Exception
            Throw ex
        Finally
            reader = Nothing
            sqlConn.Close()
        End Try
        Return returnValue
    End Function

    Function ValidarEliminarFamiliaPatente(FamiliaBE As BE.Familia, PatenteBE As BE.Patente) As Boolean
        Dim returnValue As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim familiaId As New SqlClient.SqlParameter
        Dim patenteId As New SqlClient.SqlParameter

        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "sp_ValidarEliminarFamiliaPatente"

        familiaId.DbType = DbType.Int16
        familiaId.ParameterName = "@familia_id"
        familiaId.Value = FamiliaBE.familiaId

        patenteId.DbType = DbType.Int16
        patenteId.ParameterName = "@patente_id"
        patenteId.Value = PatenteBE.PatenteId

        comm.Parameters.Add(familiaId)
        comm.Parameters.Add(patenteId)

        Try
            sqlConn.Open()
            reader = comm.ExecuteReader()
            If reader.HasRows Then
                While reader.Read()
                    returnValue = reader.GetBoolean(0)
                End While
            End If
        Catch ex As Exception
            Throw ex
        Finally
            reader = Nothing
            sqlConn.Close()
        End Try
        Return returnValue
    End Function

    Function ValidarEliminarFamiliaUsuario(FamiliaBE As BE.Familia, UsuarioBE As BE.Usuario) As Boolean
        Dim returnValue As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim familiaId As New SqlClient.SqlParameter
        Dim usuarioId As New SqlClient.SqlParameter

        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "sp_ValidarEliminarFamiliaUsuario"

        familiaId.DbType = DbType.Int16
        familiaId.ParameterName = "@familia_id"
        familiaId.Value = FamiliaBE.familiaId

        usuarioId.DbType = DbType.Int16
        usuarioId.ParameterName = "@usuario_id"
        usuarioId.Value = UsuarioBE.UsuarioId

        comm.Parameters.Add(familiaId)
        comm.Parameters.Add(usuarioId)

        Try
            sqlConn.Open()
            reader = comm.ExecuteReader()
            If reader.HasRows Then
                While reader.Read()
                    returnValue = reader.GetBoolean(0)
                End While
            End If
        Catch ex As Exception
            Throw ex
        Finally
            reader = Nothing
            sqlConn.Close()
        End Try
        Return returnValue
    End Function



End Class ' Familia