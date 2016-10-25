'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Imports System.Data.SqlClient
Imports System.Configuration
Public Class Usuario
    Implements BE.ICrud(Of BE.Usuario)

    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}

    Private Shared _instancia As DAL.Usuario

    Public Shared Function GetInstance() As DAL.Usuario

        If _instancia Is Nothing Then

            _instancia = New DAL.Usuario

        End If

        Return _instancia
    End Function

    Public Function Add(objAdd As BE.Usuario) As Boolean Implements BE.ICrud(Of BE.Usuario).Add
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim nombreUsuario As New SqlClient.SqlParameter
        Dim apellido As New SqlClient.SqlParameter
        Dim nombre As New SqlClient.SqlParameter
        Dim contraseña As New SqlClient.SqlParameter
        Dim dni As New SqlClient.SqlParameter
        Dim mail As New SqlClient.SqlParameter
        Dim bloqueado As New SqlClient.SqlParameter
        Dim eliminado As New SqlClient.SqlParameter
        Dim cci As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "usu_InsertarUsuario"

        nombreUsuario.DbType = DbType.String
        nombreUsuario.ParameterName = "@nombre_usuario"
        nombreUsuario.Value = objAdd.nombreUsuario

        apellido.DbType = DbType.String
        apellido.ParameterName = "@apellido"
        apellido.Value = objAdd.apellido

        nombre.DbType = DbType.String
        nombre.ParameterName = "@nombre"
        nombre.Value = objAdd.nombre

        contraseña.DbType = DbType.String
        contraseña.ParameterName = "@contraseña"
        contraseña.Value = objAdd.Contraseña

        dni.DbType = DbType.Int32
        dni.ParameterName = "@dni"
        dni.Value = objAdd.dni

        mail.DbType = DbType.String
        mail.ParameterName = "@email"
        mail.Value = objAdd.mail

        cci.DbType = DbType.Int32
        cci.ParameterName = "@cci"
        cci.Value = 0

        bloqueado.DbType = DbType.Boolean
        bloqueado.ParameterName = "@bloqueado"
        bloqueado.Value = objAdd.Bloqueado

        eliminado.DbType = DbType.Boolean
        eliminado.ParameterName = "@eliminado"
        eliminado.Value = objAdd.Eliminado

        comm.Parameters.Add(nombreUsuario)
        comm.Parameters.Add(apellido)
        comm.Parameters.Add(nombre)
        comm.Parameters.Add(contraseña)
        comm.Parameters.Add(mail)
        comm.Parameters.Add(dni)
        comm.Parameters.Add(cci)
        comm.Parameters.Add(bloqueado)
        comm.Parameters.Add(eliminado)

        Try
            sqlDA.InsertCommand = comm

            sqlDA.InsertCommand.Connection.Open()

            If sqlDA.InsertCommand.ExecuteNonQuery > 0 Then
                sqlDA.InsertCommand.Connection.Close()
                Dim maxId As Integer = ObtenerMaxId()

                For Each item As BE.Patente In objAdd.patentes
                    returnValue = AsignarPatenteUsuario(item, maxId)
                    If returnValue = False Then
                        Exit For
                    End If
                Next

                For Each item As BE.Familia In objAdd.familias
                    returnValue = AsignarFamiliaUsuario(item, maxId)
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

    Public Function Delete(objDel As BE.Usuario) As Boolean Implements BE.ICrud(Of BE.Usuario).Delete
        Dim returnValue As Boolean = False
        Dim comm As New SqlClient.SqlCommand
        Dim UsuarioId As New SqlClient.SqlParameter
        Dim eliminado As New SqlClient.SqlParameter
        Dim sqlDA As New SqlClient.SqlDataAdapter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "usu_EliminarUsuario"

        usuarioId.DbType = DbType.Int32
        usuarioId.ParameterName = "@usuario_id"
        usuarioId.Value = objDel.UsuarioId

        eliminado.DbType = DbType.Boolean
        eliminado.ParameterName = "@eliminado"
        eliminado.Value = objDel.Eliminado

        comm.Parameters.Add(UsuarioId)
        comm.Parameters.Add(eliminado)

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

    Public Function ListAll() As List(Of BE.Usuario) Implements BE.ICrud(Of BE.Usuario).ListAll
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "usu_ObtenerUsuarios"
        Dim usuarios As New List(Of BE.Usuario)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim UsuarioBE As New BE.Usuario
                UsuarioBE.UsuarioId = CInt(fila("usuario_id"))
                UsuarioBE.NombreUsuario = CStr(fila("nombre_usuario"))
                UsuarioBE.Apellido = CStr(fila("apellido"))
                UsuarioBE.Nombre = CStr(fila("nombre"))
                UsuarioBE.Dni = fila("dni")
                UsuarioBE.Mail = CStr(fila("email"))
                UsuarioBE.Eliminado = CBool(fila("eliminado"))
                UsuarioBE.Bloqueado = CBool(fila("bloqueado"))
                usuarios.Add(UsuarioBE)
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return usuarios
    End Function

    Public Function ListById(objId As BE.Usuario) As BE.Usuario Implements BE.ICrud(Of BE.Usuario).ListById
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim usuarioId As New SqlClient.SqlParameter
        Dim ds As New DataSet
        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
         
        comm.CommandText = "usu_ObtenerUsuariosPorID"

        usuarioId.DbType = DbType.Int32
        usuarioId.ParameterName = "@usuario_id"
        usuarioId.Value = objId.usuarioId

        comm.Parameters.Add(usuarioId)
        Dim usuarios As New BE.Usuario

        Try
            sqlDa.SelectCommand = comm

            sqlDa.SelectCommand.Connection.Open()

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim UsuarioBE As New BE.Usuario
                UsuarioBE.UsuarioId = CInt(fila("usuario_id"))
                UsuarioBE.NombreUsuario = CStr(fila("nombre_usuario"))
                UsuarioBE.Contraseña = CStr(fila("contraseña"))
                UsuarioBE.Apellido = CStr(fila("apellido"))
                UsuarioBE.Nombre = CStr(fila("nombre"))
                UsuarioBE.Mail = fila("email")
                UsuarioBE.Dni = fila("dni")
                UsuarioBE.Cci = fila("cci")
                UsuarioBE.Bloqueado = fila("bloqueado")
                UsuarioBE.Eliminado = fila("eliminado")
                Dim PatenteBE As New List(Of BE.Patente)
                For Each item In ObtenerPatentesPorUsuario(objId.UsuarioId).Rows
                    Dim Patente As New BE.Patente
                    Patente.PatenteId = item("patente_id")
                    Patente.negado = item("negado")
                    PatenteBE.Add(Patente)
                Next
                UsuarioBE.patentes = PatenteBE

                Dim FamiliaBE As New List(Of BE.Familia)
                For Each item In ObtenerFamiliasPorUsuario(objId.UsuarioId).Rows
                    Dim Familia As New BE.Familia
                    Familia.familiaId = item("familia_id")
                    FamiliaBE.Add(Familia)
                Next
                UsuarioBE.familias = FamiliaBE
                usuarios = UsuarioBE
            Next

        Catch ex As Exception
            Throw ex

        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return usuarios
    End Function

    Public Function Update(objUpd As BE.Usuario) As Boolean Implements BE.ICrud(Of BE.Usuario).Update
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDA As New SqlClient.SqlDataAdapter

        Dim returnValue As Boolean = False

        Dim usuarioId As New SqlClient.SqlParameter
        Dim nombreUsuario As New SqlClient.SqlParameter
        Dim apellido As New SqlClient.SqlParameter
        Dim nombre As New SqlClient.SqlParameter
        Dim contraseña As New SqlClient.SqlParameter
        Dim dni As New SqlClient.SqlParameter
        Dim mail As New SqlClient.SqlParameter
        Dim bloqueado As New SqlClient.SqlParameter
        Dim cci As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "usu_ModificarUsuario"

        usuarioId.DbType = DbType.Int32
        usuarioId.ParameterName = "@usuario_id"
        usuarioId.Value = objUpd.usuarioId

        nombreUsuario.DbType = DbType.String
        nombreUsuario.ParameterName = "@nombre_usuario"
        nombreUsuario.Value = objUpd.nombreUsuario

        apellido.DbType = DbType.String
        apellido.ParameterName = "@apellido"
        apellido.Value = objUpd.apellido

        nombre.DbType = DbType.String
        nombre.ParameterName = "@nombre"
        nombre.Value = objUpd.nombre

        contraseña.DbType = DbType.String
        contraseña.ParameterName = "@contraseña"
        contraseña.Value = objUpd.Contraseña

        dni.DbType = DbType.Int32
        dni.ParameterName = "@dni"
        dni.Value = objUpd.dni

        mail.DbType = DbType.String
        mail.ParameterName = "@email"
        mail.Value = objUpd.mail

        cci.DbType = DbType.Int32
        cci.ParameterName = "@cci"
        cci.Value = objUpd.Cci
        
        bloqueado.DbType = DbType.Boolean
        bloqueado.ParameterName = "@bloqueado"
        bloqueado.Value = objUpd.Bloqueado

        comm.Parameters.Add(usuarioId)
        comm.Parameters.Add(nombreUsuario)
        comm.Parameters.Add(apellido)
        comm.Parameters.Add(nombre)
        comm.Parameters.Add(contraseña)
        comm.Parameters.Add(mail)
        comm.Parameters.Add(dni)
        comm.Parameters.Add(cci)
        comm.Parameters.Add(bloqueado)

        Try
            sqlDA.UpdateCommand = comm

            sqlDA.UpdateCommand.Connection.Open()

            If sqlDA.UpdateCommand.ExecuteNonQuery > 0 Then
                sqlDA.UpdateCommand.Connection.Close()

                If QuitarFamiliasUsuario(objUpd) Then
                    For Each item As BE.Familia In objUpd.familias
                        returnValue = AsignarFamiliaUsuario(item, objUpd.UsuarioId)
                        If returnValue = False Then
                            Exit For
                        End If
                    Next
                End If

                If QuitarPatentesUsuario(objUpd) Then
                    For Each item As BE.Patente In objUpd.patentes
                        returnValue = AsignarPatenteUsuario(item, objUpd.UsuarioId)
                        If returnValue = False Then
                            Exit For
                        End If
                    Next
                End If
                returnValue = True

            End If

        Catch ex As Exception
            Throw ex
        Finally
            sqlDA.UpdateCommand.Connection.Close()
        End Try

        Return returnValue
    End Function

    Public Function BloquearDesbloquearUsuario(unapersona As BE.Usuario) As Boolean
        Dim returnValue As Boolean = False
        Dim comm As New SqlClient.SqlCommand
        Dim UsuarioId As New SqlClient.SqlParameter
        Dim bloqueado As New SqlClient.SqlParameter
        Dim sqlDA As New SqlClient.SqlDataAdapter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "usu_BloquearDesbloquerUsuario"

        UsuarioId.DbType = DbType.Int32
        UsuarioId.ParameterName = "@Usuario_Id"
        UsuarioId.Value = unapersona.UsuarioId

        bloqueado.DbType = DbType.Boolean
        bloqueado.ParameterName = "@bloqueado"
        bloqueado.Value = unapersona.Bloqueado

        comm.Parameters.Add(UsuarioId)
        comm.Parameters.Add(bloqueado)

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
    
    Public Function ValidarContraseña(unapersona As BE.Usuario) As BE.Usuario
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim returnValue As Boolean = False
        Dim ds As New DataSet
        Dim nombreUsuario As New SqlClient.SqlParameter

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "usu_ValidarContraseña"

        nombreUsuario.DbType = DbType.String
        nombreUsuario.ParameterName = "@nombre_usuario"
        nombreUsuario.Value = unapersona.NombreUsuario

        comm.Parameters.Add(nombreUsuario)

        Dim Usuarios As New BE.Usuario

        Try
            sqlDa.SelectCommand = comm
            sqlDa.SelectCommand.Connection.Open()
            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim UsuarioBE As New BE.Usuario
                UsuarioBE.UsuarioId = CInt(fila("usuario_id"))
                UsuarioBE.NombreUsuario = CStr(fila("nombre_usuario"))
                UsuarioBE.Contraseña = fila("Contraseña")
                UsuarioBE.Apellido = CStr(fila("apellido"))
                UsuarioBE.Nombre = CStr(fila("nombre"))
                UsuarioBE.Mail = fila("email")
                UsuarioBE.Dni = CInt(CStr(fila("dni")))
                UsuarioBE.Cci = fila("cci")
                UsuarioBE.Bloqueado = fila("bloqueado")
                UsuarioBE.Eliminado = fila("eliminado")
                Dim PatenteBE As New List(Of BE.Patente)
                For Each item In ObtenerPatentesPorUsuario(UsuarioBE.UsuarioId).Rows
                    Dim Patente As New BE.Patente
                    Patente.PatenteId = item("patente_id")
                    Patente.negado = item("negado")
                    PatenteBE.Add(Patente)
                Next
                UsuarioBE.patentes = PatenteBE

                Dim FamiliaBE As New List(Of BE.Familia)
                For Each item In ObtenerFamiliasPorUsuario(UsuarioBE.UsuarioId).Rows
                    Dim Familia As New BE.Familia
                    Familia.familiaId = item("familia_id")
                    FamiliaBE.Add(Familia)
                Next
                UsuarioBE.familias = FamiliaBE
                Usuarios = UsuarioBE
            Next

        Catch ex As Exception
            Throw ex
        Finally
            sqlDa.SelectCommand.Connection.Close()
        End Try

        Return Usuarios
    End Function
    Public Function VerificarExistencia(unapersona As BE.Usuario) As Boolean
        Dim returnValue As Boolean = False
        Dim comm As New SqlClient.SqlCommand
        Dim nombreUsuario As New SqlClient.SqlParameter
        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "usu_VerificarExistencia"

        nombreUsuario.DbType = DbType.String
        nombreUsuario.ParameterName = "@nombre_usuario"
        nombreUsuario.Value = unapersona.NombreUsuario

        comm.Parameters.Add(nombreUsuario)

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

    Public Function VerificarPatente(ByVal UsuarioBE As BE.Usuario, ByVal PatenteBE As BE.Patente) As Boolean
        Dim returnValue As Boolean = False
        Dim comm As New SqlClient.SqlCommand
        Dim usuarioId As New SqlClient.SqlParameter
        Dim patenteId As New SqlClient.SqlParameter

        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "sp_VerificarPatente"

        usuarioId.DbType = DbType.Int32
        usuarioId.ParameterName = "@usuario_id"
        usuarioId.Value = UsuarioBE.UsuarioId

        patenteId.DbType = DbType.Int32
        patenteId.ParameterName = "@patente_id"
        patenteId.Value = PatenteBE.PatenteId

        comm.Parameters.Add(usuarioId)
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

    Public Function ObtenerPatenteID(strPatente As String) As Integer
        Dim SqlComm As New SqlClient.SqlCommand
        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        sqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT Patente_id, Nombre FROM [farmacia].dbo.[Patente] where nombre = '" & strPatente & "'")
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        sqlConn.Close()

        Return dt.Rows(0).Item(0)
    End Function

    Public Function ObtenerFamiliasPorUsuario(_UsuarioId As Integer) As DataTable
        Dim SqlComm As New SqlClient.SqlCommand
        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        'sqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT * FROM [farmacia].dbo.[Familia_Usuario] where usuario_id = " & _UsuarioId)
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        'sqlConn.Close()

        Return dt
    End Function

    Public Function ObtenerPatentesPorUsuario(_UsuarioId As Integer) As DataTable
        Dim SqlComm As New SqlClient.SqlCommand
        Dim dr As SqlClient.SqlDataReader
        Dim dt As New DataTable

        'sqlConn.Open()
        SqlComm.CommandText = String.Format("SELECT * FROM  [farmacia].dbo.Usuario_Patente where usuario_id = " & _UsuarioId)
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        'sqlConn.Close()

        Return dt
    End Function

    Function AsignarPatenteUsuario(patente As BE.Patente, _UsuarioId As Integer) As Boolean
        Dim SqlComm As New SqlClient.SqlCommand
        sqlConn.Open()
        SqlComm.CommandText = String.Format("insert into [farmacia].dbo.[Usuario_Patente] (usuario_id,patente_id,negado) values (" & _UsuarioId & "," & patente.PatenteId & ",'" & CBool(patente.negado) & "')")
        SqlComm.Connection = sqlConn
        SqlComm.ExecuteNonQuery()
        sqlConn.Close()
        Return True
    End Function
    Function QuitarPatentesUsuario(unUsuario As BE.Usuario) As Boolean
        Dim SqlComm As New SqlClient.SqlCommand
        sqlConn.Open()
        SqlComm.CommandText = String.Format("delete from [farmacia].dbo.Usuario_Patente where usuario_id = " & unUsuario.UsuarioId)
        SqlComm.Connection = sqlConn
        SqlComm.ExecuteNonQuery()
        sqlConn.Close()
        Return True
    End Function

    Function AsignarFamiliaUsuario(familia As BE.Familia, _UsuarioId As Integer) As Boolean
        Dim SqlComm As New SqlClient.SqlCommand
        sqlConn.Open()
        SqlComm.CommandText = String.Format("insert into [farmacia].dbo.[Familia_Usuario] (familia_id,usuario_id) values (" & familia.familiaId & "," & _UsuarioId & ")")
        SqlComm.Connection = sqlConn
        SqlComm.ExecuteNonQuery()
        sqlConn.Close()
        Return True
    End Function
    Function QuitarFamiliasUsuario(unUsuario As BE.Usuario) As Boolean
        Dim SqlComm As New SqlClient.SqlCommand
        sqlConn.Open()
        SqlComm.CommandText = String.Format("delete from [farmacia].dbo.[Familia_Usuario] where usuario_id = " & unUsuario.UsuarioId)
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
        SqlComm.CommandText = String.Format("SELECT MAX(usuario_id) as MaxId FROM Usuario ")
        SqlComm.Connection = sqlConn
        dr = SqlComm.ExecuteReader()
        dt.Load(dr)
        sqlConn.Close()

        Return dt.Rows(0).Item(0)
    End Function

    Function ValidarEliminarUsuario(UsuarioBE As BE.Usuario) As Boolean
        Dim returnValue As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim usuarioId As New SqlClient.SqlParameter

        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "sp_ValidarEliminarUsuario"

        usuarioId.DbType = DbType.Int16
        usuarioId.ParameterName = "@usuario_id"
        usuarioId.Value = UsuarioBE.UsuarioId

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

    Function ValidarEliminarUsuarioPatente(UsuarioBE As BE.Usuario, PatenteBE As BE.Patente) As Boolean
        Dim returnValue As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim patenteId As New SqlClient.SqlParameter
        Dim usuarioId As New SqlClient.SqlParameter

        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "sp_ValidarEliminarUsuarioPatente"

        patenteId.DbType = DbType.Int16
        patenteId.ParameterName = "@patente_id"
        patenteId.Value = PatenteBE.PatenteId

        usuarioId.DbType = DbType.Int16
        usuarioId.ParameterName = "@usuario_id"
        usuarioId.Value = UsuarioBE.UsuarioId

        comm.Parameters.Add(patenteId)
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

    Function ValidarEliminarUsuarioPatenteNegacion(UsuarioBE As BE.Usuario, PatenteBE As BE.Patente) As Boolean
        Dim returnValue As Boolean
        Dim comm As New SqlClient.SqlCommand
        Dim patenteId As New SqlClient.SqlParameter
        Dim usuarioId As New SqlClient.SqlParameter

        Dim reader As SqlClient.SqlDataReader

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "sp_ValidarEliminarUsuarioPatenteNegacion"

        patenteId.DbType = DbType.Int16
        patenteId.ParameterName = "@patente_id"
        patenteId.Value = PatenteBE.PatenteId

        usuarioId.DbType = DbType.Int16
        usuarioId.ParameterName = "@usuario_id"
        usuarioId.Value = UsuarioBE.UsuarioId

        comm.Parameters.Add(patenteId)
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

End Class ' Usuario




