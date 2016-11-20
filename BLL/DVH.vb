'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Class DVH

    Dim DigitoVerificadorVerticalBLL As New BLL.DVV
    Dim SeguridadBLL As New BLL.Seguridad
    Dim DigitoVerificadorHorizontalDAL As New DAL.DVH

    Public Sub GenerarDVH(ByVal DigitoVerificadorHorizontal As BE.DVH, Optional ByVal GenerarDVV As Boolean = True)
        Dim dr = DigitoVerificadorHorizontalDAL.GetRegistro(DigitoVerificadorHorizontal)
        Dim DVH = ConcatenarRegistro(dr)
        DVH = GetAsciiPosicionValor(DVH)
        DigitoVerificadorHorizontalDAL.SetDigito(DigitoVerificadorHorizontal, DVH)
        If GenerarDVV Then
            DigitoVerificadorVerticalBLL.GenerarDVV(New BE.DVV(DigitoVerificadorHorizontal.ObtenerTabla))
        End If
    End Sub

    Public Function ConcatenarRegistro(ByVal dr As DataRow) As String
        Dim cadena = ""
        For Each ColumnName In dr.Table.Columns
            If (ColumnName.ToString <> "dvh") Then
                cadena = cadena + dr.Item(ColumnName).ToString
            End If
        Next
        Return cadena
    End Function

    Public Function GetAsciiPosicionValor(ByVal DVH As String) As Long
        Dim valor = 0
        Dim contador = 1
        For Each caracter In DVH
            valor = valor + (Asc(caracter) * contador)
            contador = contador + 1
        Next
        Return valor
    End Function

    Public Function RecalcularDVH() As Boolean
        Dim ds = DigitoVerificadorHorizontalDAL.GetTablas
        For Each dt In ds.Tables
            For Each dr In dt.Rows
                Dim DVHBE = New BE.DVH(dt.TableName)
                For Each primary_key In dt.PrimaryKey
                    DVHBE.AgregarRestriccion(primary_key.ColumnName, dr.item(primary_key).ToString)
                Next
                GenerarDVH(DVHBE, False)
            Next
            Dim dvvBE = New BE.DVV(dt.TableName)
            DigitoVerificadorVerticalBLL.GenerarDVV(dvvBE)
        Next
        Return True
    End Function

    Public Function VerificarDVH(UsuarioBE As BE.Usuario) As Boolean
        Dim ds = DigitoVerificadorHorizontalDAL.GetTablas
        Dim returnValue As Boolean = True
        Try

            For Each dt In ds.Tables
                For Each dr In dt.Rows
                    Dim DVH = ""
                    DVH = ConcatenarRegistro(dr)
                    DVH = GetAsciiPosicionValor(DVH)
                    Dim DVHBE = New BE.DVH(dt.TableName)
                    For Each primary_key In dt.PrimaryKey
                        DVHBE.AgregarRestriccion(primary_key.ColumnName, dr.item(primary_key).ToString)
                    Next
                    If (DVH <> DigitoVerificadorHorizontalDAL.GetDigito(DVHBE)) Then
                        Dim restricciones = DVHBE.Restricciones
                        Dim concatenar As String = ""
                        For Each item As BE.DVH.Restriccion In restricciones
                            concatenar = concatenar + CStr(item.identificador) + ", "
                        Next
                        MsgBox("Error Digito Verificador Horizontal, Tabla: " & dt.TableName & " Registro: " & concatenar)
                        RegistrarBitacora("Error DVH: " & dt.TableName, "Alta", UsuarioBE, False)
                        returnValue = False
                        Return returnValue
                    End If
                Next
                If (DigitoVerificadorVerticalBLL.VerificarDVV(dt) = False) Then
                    RegistrarBitacora("Error DVV: " & dt.TableName, "Alta", UsuarioBE, False)
                    returnValue = False
                    Return returnValue
                End If
            Next
        Catch ex As Exception
            Throw ex
        End Try
        If returnValue Then
            Return True
        Else
            Return False
        End If
    End Function


    Public Sub RegistrarBitacora(evento As String, nivel As String, UsuarioBE As BE.Usuario, Optional isGenerarDV As Boolean = True)
        Dim SeguridadBLL As New BLL.Seguridad
        Dim BitacoraBE As New BE.Bitacora
        BitacoraBE.Descripcion = SeguridadBLL.EncriptarRSA(evento)
        BitacoraBE.usuario = UsuarioBE
        BitacoraBE.criticidad = nivel
        BLL.Bitacora.GetInstance.RegistrarBitacora(BitacoraBE, isGenerarDV)
    End Sub

End Class