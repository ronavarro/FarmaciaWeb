'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Patente
    Implements BE.ICrud(Of BE.Patente)


    Private Sub New()

    End Sub

    Private Shared _instancia As BLL.Patente

    Public Shared Function GetInstance() As BLL.Patente

        If _instancia Is Nothing Then

            _instancia = New BLL.Patente

        End If

        Return _instancia
    End Function


    Public Function Add(objAdd As BE.Patente) As Boolean Implements BE.ICrud(Of BE.Patente).Add
        Return DAL.Patente.GetInstance().Add(objAdd)
    End Function

    Public Function Delete(objDel As BE.Patente) As Boolean Implements BE.ICrud(Of BE.Patente).Delete
        Return DAL.Patente.GetInstance().Delete(objDel)
    End Function

    Public Function ListAll() As List(Of BE.Patente) Implements BE.ICrud(Of BE.Patente).ListAll
        Return DAL.Patente.GetInstance().ListAll
    End Function

    Public Function ListById(objId As BE.Patente) As BE.Patente Implements BE.ICrud(Of BE.Patente).ListById
        Return DAL.Patente.GetInstance().ListById(objId)
    End Function

    Public Function Update(objUpd As BE.Patente) As Boolean Implements BE.ICrud(Of BE.Patente).Update
        Return DAL.Patente.GetInstance().Update(objUpd)
    End Function
End Class ' Patente