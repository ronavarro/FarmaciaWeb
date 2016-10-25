'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''DAL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Patente
    Implements BE.ICrud(Of BE.Patente)
    Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = Conexion.getConexionFarmacia}

    Private Shared _instancia As DAL.Patente

    Public Shared Function GetInstance() As DAL.Patente

        If _instancia Is Nothing Then

            _instancia = New DAL.Patente

        End If

        Return _instancia
    End Function

    Public Function Add(objAdd As BE.Patente) As Boolean Implements BE.ICrud(Of BE.Patente).Add
        Return True
    End Function

    Public Function Delete(objDel As BE.Patente) As Boolean Implements BE.ICrud(Of BE.Patente).Delete
        Return True
    End Function

    Public Function ListAll() As List(Of BE.Patente) Implements BE.ICrud(Of BE.Patente).ListAll
        Dim comm As New SqlClient.SqlCommand
        Dim sqlDa As New SqlClient.SqlDataAdapter
        Dim ds As New DataSet

        comm.Connection = sqlConn
        comm.CommandType = CommandType.StoredProcedure
        comm.CommandText = "pat_ObtenerPatentes"
        Dim patentes As New List(Of BE.Patente)
        Try
            sqlDa.SelectCommand = comm

            sqlDa.Fill(ds)

            For Each fila As DataRow In ds.Tables(0).Rows
                Dim patenteBE As New BE.Patente
                patenteBE.PatenteId = CInt(fila("patente_id"))
                patenteBE.Nombre = CStr(fila("nombre"))
                patentes.Add(patenteBE)
            Next
            Return patentes

        Catch ex As Exception
            Throw ex
        End Try

        Return patentes
    End Function

    Public Function ListById(objId As BE.Patente) As BE.Patente Implements BE.ICrud(Of BE.Patente).ListById
        Return New BE.Patente
    End Function

    Public Function Update(objUpd As BE.Patente) As Boolean Implements BE.ICrud(Of BE.Patente).Update
        Return True
    End Function
End Class ' Patente