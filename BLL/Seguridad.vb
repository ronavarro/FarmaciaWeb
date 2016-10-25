'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Option Explicit On
Option Strict On

Imports System.Text
Imports System.Security.Cryptography
Imports System.Security
Imports System.IO
Imports System.Runtime.InteropServices
Imports System.Text.RegularExpressions

Public Class Seguridad

    ' RSA PARAMETERS
    Dim passPhrase As String = "FarmaciaPassPhrase"
    Dim saltValue As String = "FarmaciaSaltValue"
    Dim passwordIterations As Integer = 2
    Dim initVector As String = "@1B2c3D4e5F6g7H8"
    Dim keySize As Integer = 256


    Public Sub New()

    End Sub

    Private Shared _instancia As BLL.Seguridad

    Public Shared Function GetInstance() As BLL.Seguridad

        If _instancia Is Nothing Then

            _instancia = New BLL.Seguridad

        End If

        Return _instancia
    End Function


    Public Function ValidarServidor(ByVal dataSource As String) As Boolean
        Dim connString = "Data Source=" + dataSource + ";Initial Catalog=farmacia;Integrated Security=True"
        Dim SqlConn As New SqlClient.SqlConnection With {.ConnectionString = connString}
        Try
            If dataSource <> "" Then
                SqlConn.Open()
                SqlConn.Close()
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Function EncriptarRSA(ByVal Cadena As String) As String
        Dim cipherText = ""
        If Cadena <> "" Then
            Dim initVectorBytes As Byte() = Encoding.ASCII.GetBytes(initVector)
            Dim saltValueBytes As Byte() = Encoding.ASCII.GetBytes(saltValue)
            Dim plainTextBytes As Byte() = Encoding.UTF8.GetBytes(Cadena)
            Dim password As New Rfc2898DeriveBytes(passPhrase, saltValueBytes, passwordIterations)
            Dim keyBytes As Byte() = password.GetBytes(CInt(keySize / 8))
            Dim symmetricKey As New RijndaelManaged()
            symmetricKey.Mode = CipherMode.CBC
            Dim encryptor As ICryptoTransform = symmetricKey.CreateEncryptor(keyBytes, initVectorBytes)
            Dim memoryStream As New MemoryStream()
            Dim cryptoStream As New CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write)
            cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length)
            cryptoStream.FlushFinalBlock()
            Dim cipherTextBytes As Byte() = memoryStream.ToArray()
            memoryStream.Close()
            cryptoStream.Close()
            cipherText = Convert.ToBase64String(cipherTextBytes)
        End If
        Return cipherText
    End Function


    Public Function DesencriptarRSA(ByVal Cadena As String) As String
        Dim cipherText = ""
        If Cadena <> "" Then
            Dim initVectorBytes As Byte() = Encoding.ASCII.GetBytes(initVector)
            Dim saltValueBytes As Byte() = Encoding.ASCII.GetBytes(saltValue)
            Dim cipherTextBytes As Byte() = Convert.FromBase64String(Cadena)
            Dim password As New Rfc2898DeriveBytes(passPhrase, saltValueBytes, passwordIterations)
            Dim keyBytes As Byte() = password.GetBytes(CInt(keySize / 8))
            Dim symmetricKey As New RijndaelManaged()
            symmetricKey.Mode = CipherMode.CBC
            Dim decryptor As ICryptoTransform = symmetricKey.CreateDecryptor(keyBytes, initVectorBytes)
            Dim memoryStream As New MemoryStream(cipherTextBytes)
            Dim cryptoStream As New CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read)
            Dim plainTextBytes As Byte() = New Byte(cipherTextBytes.Length - 1) {}
            Dim decryptedByteCount As Integer = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length)
            memoryStream.Close()
            cryptoStream.Close()
            cipherText = Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount)
        End If
        Return cipherText
    End Function

    Public Function EncriptarMD5(ByVal Cadena As String) As String
        Dim md5 As MD5 = New MD5CryptoServiceProvider()
        Dim result As Byte()
        result = md5.ComputeHash(Encoding.ASCII.GetBytes(Cadena))
        Dim strBuilder As New StringBuilder()
        For i As Integer = 0 To result.Length - 1
            strBuilder.Append(result(i).ToString("x2"))
        Next
        Return strBuilder.ToString()
    End Function

    Public Function AutoGenerarContraseña(UsuarioBE As BE.Usuario, enviar As Boolean) As String
        Dim s As String = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
        Dim r As New Random
        Dim sb As New StringBuilder
        Dim contraseña As String
        For i As Integer = 1 To 8
            Dim idx As Integer = r.Next(0, s.Count() - 1)
            sb.Append(s.Substring(idx, 1))
        Next
        contraseña = sb.ToString
        If enviar Then
            Dim nombreUsuario As String = DesencriptarRSA(UsuarioBE.NombreUsuario)
            CrearTXT(nombreUsuario, contraseña)
        End If
        Return contraseña
    End Function


    Public Sub CrearTXT(ByVal usuario As String, ByVal contraseña As String)
        Dim ruta As String = My.Application.Info.DirectoryPath
        Dim archivo As System.IO.FileStream
        archivo = System.IO.File.Create(ruta & "/" & usuario & "_" & DateTime.Now.ToString("yyyymmdd_hhmmss") & ".txt")
        Dim Writer As New System.IO.StreamWriter(archivo)
        Writer.WriteLine("Nombre Usuario: " + usuario)
        Writer.WriteLine("Contraseña: " + contraseña)
        Writer.Close()
    End Sub


    Public Function ValidarEmail(ByVal email As String) As Boolean
        Dim emailRegex As New System.Text.RegularExpressions.Regex(
            "^(?<user>[^@]+)@(?<host>.+)$")
        Dim emailMatch As System.Text.RegularExpressions.Match =
           emailRegex.Match(email)
        Return emailMatch.Success
    End Function

    Public Function ValidarDNI(ByVal Pass As String,
    Optional ByVal numUpper As Integer = 0,
    Optional ByVal numLower As Integer = 0) As Boolean

        Dim upper As New System.Text.RegularExpressions.Regex("[A-Z]")
        Dim lower As New System.Text.RegularExpressions.Regex("[a-z]")

        If upper.Matches(Pass).Count > numUpper Then Return False
        If lower.Matches(Pass).Count > numLower Then Return False

        If Len(Pass) < 8 Then
            Return False
        End If

        Return True
    End Function

End Class ' Seguridad