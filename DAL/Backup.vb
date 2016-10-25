'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Backup
    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionMaster}
    Dim SqlComm As New SqlClient.SqlCommand

    Public Function CrearBackup(ByVal BackupBE As BE.Backup) As String
        Dim SqlComm As New SqlClient.SqlCommand

        If Not BackupBE.ubicacion.EndsWith("\") Then BackupBE.ubicacion = BackupBE.ubicacion & "\"
        Dim inputFile = String.Format("{0}farmacia_{1}", BackupBE.ubicacion, DateTime.Now.ToString("yyyyMMddhhmmss"))

        SqlComm.Connection = SqlConn
        SqlConn.Open()
        SqlComm.CommandType = CommandType.Text

        Try
            SqlComm.CommandText = "BACKUP DATABASE farmacia TO DISK = '" + inputFile + "'"
            SqlComm.ExecuteNonQuery()
            SqlConn.Close()
        Catch ex As Exception
            Return ""
        End Try

        Return inputFile
    End Function


    Public Sub CrearRestore(ByVal BackupBE As BE.Backup)
        Dim SqlComm As New SqlClient.SqlCommand

        SqlComm.Connection = SqlConn
        SqlConn.Open()
        SqlComm.CommandType = CommandType.Text

        Try
            SqlComm.CommandText = "ALTER DATABASE FARMACIA SET SINGLE_USER WITH ROLLBACK IMMEDIATE"
            SqlComm.ExecuteNonQuery()
            SqlComm.CommandText = "RESTORE DATABASE FARMACIA FROM DISK = '" + BackupBE.archivo.ToString + "' WITH REPLACE, NORECOVERY; RESTORE LOG FARMACIA FROM DISK = '" + BackupBE.archivo.ToString + "' WITH RECOVERY;"
            SqlComm.ExecuteNonQuery()
            SqlComm.CommandText = "ALTER DATABASE FARMACIA SET MULTI_USER WITH ROLLBACK IMMEDIATE"
            SqlComm.ExecuteNonQuery()
            SqlConn.Close()
        Catch ex As Exception
            SqlComm.CommandText = "ALTER DATABASE FARMACIA SET MULTI_USER WITH ROLLBACK IMMEDIATE"
            SqlComm.ExecuteNonQuery()
            SqlConn.Close()
        End Try
    End Sub

End Class ' Backup