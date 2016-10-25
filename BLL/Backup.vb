'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''BLL
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Option Strict On

Imports System.IO
Imports SevenZip


Public Class Backup

    Dim BackupDAL As New DAL.Backup
    Dim ConfigurationAppSettings As New System.Configuration.AppSettingsReader
    Dim CompressDLL As String = "7z.dll"

    Public Sub ComprimirDb(ByVal BackupBE As BE.Backup)
        Dim dirInputFile = Path.GetDirectoryName(BackupBE.ubicacion)
        Dim inputFileName = Path.GetFileName(BackupBE.ubicacion)
        Dim tempDir = System.IO.Path.GetTempPath() & "\" & inputFileName
        Directory.CreateDirectory(tempDir)
        File.Move(BackupBE.ubicacion, tempDir & "\" & inputFileName)
        Try
            SevenZipExtractor.SetLibraryPath(CompressDLL)
            Dim Compressor As SevenZipCompressor = New SevenZipCompressor()
            Compressor.ArchiveFormat = OutArchiveFormat.SevenZip
            Compressor.CompressionMode = CompressionMode.Create
            Compressor.CompressionMethod = CompressionMethod.Default
            Compressor.DirectoryStructure = False
            Compressor.CompressionLevel = CompressionLevel.Normal
            Compressor.VolumeSize = CInt(BackupBE.tamano)
            Compressor.CompressDirectory(tempDir, BackupBE.ubicacion + ".dbk", True)
        Catch ex As Exception
            File.Move(tempDir & "\" & inputFileName, BackupBE.ubicacion)
            Directory.Delete(tempDir, True)
            Throw New Exception(ex.Message)
        End Try
        Directory.Delete(tempDir, True)
    End Sub

    Public Sub DividirDb(ByVal BackupBE As BE.Backup)
        Dim fileInfo As New FileInfo(BackupBE.ubicacion)
        Dim sizeOfBackup = fileInfo.Length / 100
        BackupBE.cantidad = BackupBE.cantidad
        BackupBE.tamano = sizeOfBackup / BackupBE.cantidad
        ComprimirDb(BackupBE)
    End Sub

    Public Function GenerarRar(ByVal BackupBE As BE.Backup) As Boolean
        Dim inputFile = BackupDAL.CrearBackup(BackupBE)
        If inputFile = "" Then
            Return False
        Else
            BackupBE.ubicacion = inputFile
            '            DividirDb(BackupBE)
            Return True
        End If
    End Function

    Public Sub ImportarRar(ByVal BackupBE As BE.Backup)
        '  SevenZipExtractor.SetLibraryPath(CompressDLL)
        'Dim dirInputFile = Path.GetDirectoryName(BackupBE.archivo)
        '        Dim inputFileName = Path.GetFileName(BackupBE.archivo)
        '        Dim outputFileName = dirInputFile & "\" & inputFileName
        '        Dim compressedFileName = BackupBE.archivo & ".001"
        '        Dim extractor As New SevenZipExtractor(compressedFileName)
        '        Dim fileStream As FileStream = File.OpenWrite(Path.Combine(dirInputFile, outputFileName.Substring(0, outputFileName.Length - 4)))
        '        For Each File In extractor.ArchiveFileNames
        'extractor.ExtractFile(File, FileStream)
        'Next
        'FileStream.Close()
        'BackupBE.archivo = FileStream.Name
        BackupDAL.CrearRestore(BackupBE)
        'extractor.Dispose()
        'System.IO.File.Delete(FileStream.Name)
    End Sub


End Class ' Backup