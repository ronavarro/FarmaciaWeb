'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Public Class Laboratorio

    Dim LaboratorioDAL As New DAL.Laboratorio

    Public Function ObtenerLaboratorios() As List(Of BE.Laboratorio)
        Return LaboratorioDAL.ObtenerLaboratorios()
    End Function
 
    Public Function ObtenerLaboratorioPorId(laboratorioId As Integer) As BE.Laboratorio
        Return LaboratorioDAL.ObtenerLaboratorioPorId(laboratorioId)
    End Function

End Class ' Laboratorio