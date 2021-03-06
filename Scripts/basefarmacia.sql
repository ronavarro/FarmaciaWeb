USE [master]
GO
/****** Object:  Database [farmacia]    Script Date: 14/07/2016 19:53:21 ******/
CREATE DATABASE [farmacia]
GO
ALTER DATABASE [farmacia] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [farmacia] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [farmacia] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [farmacia] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [farmacia] SET ARITHABORT OFF 
GO
ALTER DATABASE [farmacia] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [farmacia] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [farmacia] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [farmacia] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [farmacia] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [farmacia] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [farmacia] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [farmacia] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [farmacia] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [farmacia] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [farmacia] SET  DISABLE_BROKER 
GO
ALTER DATABASE [farmacia] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [farmacia] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [farmacia] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [farmacia] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [farmacia] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [farmacia] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [farmacia] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [farmacia] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [farmacia] SET  MULTI_USER 
GO
ALTER DATABASE [farmacia] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [farmacia] SET DB_CHAINING OFF 
GO
ALTER DATABASE [farmacia] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [farmacia] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [farmacia]
GO
/****** Object:  StoredProcedure [dbo].[bit_InsertarBitacora]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[bit_InsertarBitacora]
	@usuario_fk as int,
    @descripcion as nvarchar(255),
	@fecha_hora as datetime,
	@criticidad  as nvarchar(50)
AS
BEGIN

INSERT INTO [dbo].[Bitacora]
(
  [usuario_fk]
 ,[descripcion]
 ,[fecha_hora]
 ,[criticidad]
 )
Values (
@usuario_fk,
@descripcion,
@fecha_hora,
@criticidad
)

END

GO
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorID]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bit_ListarBitacoraPorID]
@bitacora_id as int
AS
begin
SELECT 
	   [bitacora_id]
	  ,[usuario_fk]
      ,[descripcion]
      ,[fecha_hora]
      ,[criticidad]
FROM [farmacia].[dbo].[Bitacora] 
WHERE [bitacora_id] =  @bitacora_id  
end
GO
/****** Object:  StoredProcedure [dbo].[bit_ListarBitacoraPorParametros]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[bit_ListarBitacoraPorParametros]
@usuario_id as int,
@fecha_desde as datetime,
@fecha_hasta as datetime,
@criticidad as nvarchar(50)
AS
begin
SELECT 
 B.bitacora_id,
 B.usuario_fk,
 U.nombre_usuario,
 B.descripcion,
 B.fecha_hora,
 B.criticidad
FROM [farmacia].[dbo].[Bitacora] AS B
INNER JOIN Usuario AS U ON B.usuario_fk = U.usuario_id
WHERE (B.usuario_fk =  @usuario_id or  @usuario_id = 0)
and  (B.fecha_hora >= @fecha_desde and fecha_hora <= @fecha_hasta)
and (B.criticidad = @criticidad or @criticidad = 'Todos los niveles')
end
GO
/****** Object:  StoredProcedure [dbo].[cli_EliminarCliente]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cli_EliminarCliente]
	@cliente_id as int,
	@eliminado as bit
AS
begin
UPDATE [dbo].Cliente
   SET eliminado = @eliminado
 WHERE 
		cliente_id = @cliente_id

end 
GO
/****** Object:  StoredProcedure [dbo].[cli_InsertarCliente]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cli_InsertarCliente]
	@dni as integer,
	@apellido as nvarchar(80),
	@nombre as nvarchar(80),
	@nombreCompleto as nvarchar(160),
	@email as nvarchar(100),
	@telefono as nvarchar(50),
	@fecha_alta as datetime,
    @direccion as nvarchar(255),
    @localidad_fk as integer,
    @provincia_fk as integer
AS
begin

INSERT INTO [dbo].[Cliente]
           ([direccion]
           ,[nombre]
           ,[apellido]
		   ,[nombreCompleto]
           ,[telefono]
           ,[fecha_alta]
           ,eliminado
           ,[dni]
           ,[email]
           ,[dvh]
           ,[localidad_fk]
           ,[provincia_fk]
		   )
     VALUES
           (
		    @direccion
		   ,@nombre
		   ,@apellido
		   ,@nombreCompleto
		   ,@telefono
		   ,@fecha_alta
		   ,0
		   ,@dni
		   ,@email
		   ,0
		   ,@localidad_fk
		   ,@provincia_fk
		   )
		   

end
GO
/****** Object:  StoredProcedure [dbo].[cli_ModificarCliente]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ModificarCliente]
	@cliente_id as int,
	@apellido as nvarchar(80),
	@nombre as nvarchar(80),
	@nombreCompleto as nvarchar(160),
    @telefono as nvarchar(50),
	@dni as integer,
	@email as nvarchar(100),
    @direccion as nvarchar(255),
	@localidad_fk as int,
	@provincia_fk as int

AS

 
begin
UPDATE [dbo].Cliente
   SET apellido = ltrim(@apellido)
	  ,nombre = ltrim(@nombre)
	  ,nombreCompleto  = @nombreCompleto 
      ,telefono = @telefono
	  ,email = @email
	  ,dni = @dni
      ,direccion = @direccion
	  ,localidad_fk = @localidad_fk
	  ,provincia_fk = @provincia_fk
 WHERE 
		cliente_id = @cliente_id
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientes]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientes]
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente 
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesDisponibles]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[cli_ObtenerClientesDisponibles]
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente where eliminado = 0
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorApellido_Nombre]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientesPorApellido_Nombre]
@Apellido_Nombre as nvarchar(255)
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  
where nombreCompleto like '%' + @Apellido_Nombre + '%'  
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorDNI]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientesPorDNI]
@dni as nvarchar(255)
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  where cast(dni as nvarchar(50)) like '%' + @dni + '%' 
end
GO
/****** Object:  StoredProcedure [dbo].[cli_ObtenerClientesPorID]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[cli_ObtenerClientesPorID]
@cliente_id as int
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  where cliente_id = @cliente_id  
end
GO
/****** Object:  StoredProcedure [dbo].[cli_VerificarExistencia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[cli_VerificarExistencia]
@dni as integer
AS
begin
SELECT *  FROM [farmacia].[dbo].Cliente  where dni = @dni 
end 
GO
/****** Object:  StoredProcedure [dbo].[fam_EliminarFamilia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fam_EliminarFamilia]
	@familia_id as int
AS
begin
delete from [dbo].[Familia] WHERE [familia_id] = @familia_id

end
GO
/****** Object:  StoredProcedure [dbo].[fam_InsertarFamilia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fam_InsertarFamilia]
    @nombre_familia as nvarchar(50),
    @descripcion as nvarchar(50)
AS
begin

INSERT INTO [dbo].[Familia]
           (
           nombre
           ,descripcion,dvh)
     VALUES
           (
            @nombre_familia
           ,@descripcion,0)

		   end 
GO
/****** Object:  StoredProcedure [dbo].[fam_ModificarFamilia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[fam_ModificarFamilia]
	@familia_id as int,
	@nombre_familia as nvarchar(50),
    @descripcion as nvarchar(50) 
AS
begin
UPDATE [dbo].Familia
   SET nombre = @nombre_familia
      ,descripcion = @descripcion
 WHERE 
		familia_id = @familia_id
end

GO
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamilias]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[fam_ObtenerFamilias]
AS
begin
SELECT [familia_id]
      ,[nombre]
      ,[descripcion]
      ,[dvh]
  FROM [dbo].[Familia]

end
GO
/****** Object:  StoredProcedure [dbo].[fam_ObtenerFamiliasPorID]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[fam_ObtenerFamiliasPorID]
@familia_id as int
AS
begin
SELECT f.familia_id,pf.patente_id,f.descripcion,f.nombre 
FROM [farmacia].[dbo].Familia as f inner join farmacia.dbo.Patente_Familia as pf on f.familia_id = pf.familia_id  
 where f.familia_id = @familia_id
end
GO
/****** Object:  StoredProcedure [dbo].[fam_VerificarExistencia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[fam_VerificarExistencia]
	@nombre as nvarchar(50)
AS
BEGIN

	select * from Familia  where nombre = @nombre
END

GO
/****** Object:  StoredProcedure [dbo].[idi_ObtenerIdiomas]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[idi_ObtenerIdiomas]
AS
begin
SELECT *  FROM [farmacia].[dbo].Idioma order by idioma_id 
end
GO
/****** Object:  StoredProcedure [dbo].[idi_ObtenerTraduccion]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[idi_ObtenerTraduccion]
 @idioma_fk as int,
 @texto as nvarchar(256)
AS
begin
SELECT *  FROM [farmacia].[dbo].Traduccion where idioma_fk = @idioma_fk and texto = @texto
end
GO
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorioPorID]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[lab_ObtenerLaboratorioPorID]
@laboratorio_id as integer
AS
begin
SELECT *  FROM farmacia.dbo.Laboratorio
where laboratorio_id = @laboratorio_id 
end
GO
/****** Object:  StoredProcedure [dbo].[lab_ObtenerLaboratorios]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[lab_ObtenerLaboratorios]
AS
begin
SELECT *  FROM farmacia.dbo.Laboratorio order by razon_social
end
GO
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidades]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[loc_ObtenerLocalidades]
AS
begin
SELECT *  FROM [farmacia].[dbo].[Localidad] order by descripcion

end
GO
/****** Object:  StoredProcedure [dbo].[loc_ObtenerLocalidadPorID]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[loc_ObtenerLocalidadPorID]
@localidad_id as int
AS
begin
SELECT *
  FROM [farmacia].[dbo].[Localidad]
  where localidad_id = @localidad_id  
  order by descripcion
end
GO
/****** Object:  StoredProcedure [dbo].[med_EliminarMedicamento]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[med_EliminarMedicamento]
	@medicamento_id as int,
	@eliminado as bit
AS
begin
update Medicamento 
 SET  eliminado = @eliminado
 WHERE medicamento_id = @medicamento_id

end
GO
/****** Object:  StoredProcedure [dbo].[med_InsertarMedicamento]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[med_InsertarMedicamento]
    @descripcion as nvarchar(50),
    @laboratorio_id as integer,
    @precio as nvarchar(50),
	@cantidad as nvarchar(50),
	@receta as bit
AS
begin

INSERT INTO [dbo].Medicamento
           (
           descripcion
           ,laboratorio_fk
		   ,cantidad
		   ,precio
		   ,eliminado
		   ,receta
		   )
     VALUES
           (
            @descripcion
           ,@laboratorio_id
           ,@cantidad
		   ,@precio
		   ,0
		   ,@receta
		   )

end
GO
/****** Object:  StoredProcedure [dbo].[med_ModificarMedicamento]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ModificarMedicamento]
	@medicamento_id as int,
	@descripcion as nvarchar(50),
	@laboratorio_id as integer,
    @precio as nvarchar(50),
    @cantidad as nvarchar(50),
	@receta as bit
AS
begin
UPDATE [dbo].Medicamento
   SET descripcion = @descripcion
	  ,laboratorio_fk = @laboratorio_id
      ,cantidad = @cantidad
      ,precio = @precio
	  ,receta = @receta
 WHERE 
	  medicamento_id = @medicamento_id
end

GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentoPorParametros]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentoPorParametros]
@descripcion as nvarchar(255),
@laboratorio_id as int,
@receta as bit

AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where  receta = @receta and (descripcion  LIKE '%' + @descripcion + '%') and (laboratorio_id  = @laboratorio_id or @laboratorio_id = 0)
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentos]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentos]
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosDisponibles]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentosDisponibles]
@cantidad as nvarchar(50)
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m 
inner join 
farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
/*where cantidad > @cantidad and eliminado = 0*/
where eliminado = 0
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorDescripcion]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentosPorDescripcion]
@descripcion as nvarchar(255)
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where descripcion  LIKE '%' + @descripcion + '%'
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorID]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentosPorID]
@medicamento_id as int
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where medicamento_id = @medicamento_id 
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorLaboratorio]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[med_ObtenerMedicamentosPorLaboratorio]
@laboratorio_id as int
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where laboratorio_id  = @laboratorio_id or @laboratorio_id = 0
end
GO
/****** Object:  StoredProcedure [dbo].[med_ObtenerMedicamentosPorReceta]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[med_ObtenerMedicamentosPorReceta]
@receta as bit
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento as m inner join farmacia.dbo.Laboratorio as l on m.laboratorio_fk = l.laboratorio_id
  where  receta = @receta
end
GO
/****** Object:  StoredProcedure [dbo].[med_VerificarExistencia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[med_VerificarExistencia]
@descripcion as nvarchar(50)
AS
begin
SELECT *  FROM [farmacia].[dbo].Medicamento  where descripcion = @descripcion 
end
GO
/****** Object:  StoredProcedure [dbo].[pat_ObtenerPatentes]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[pat_ObtenerPatentes]
AS
begin
SELECT [patente_id]
      ,[nombre]
       
  FROM [farmacia].[dbo].[Patente]
end
GO
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvinciaPorID]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[prov_ObtenerProvinciaPorID]
@provincia_id as int
AS
begin
SELECT *
  FROM [farmacia].[dbo].[Provincia]
  where provincia_id = @provincia_id  
  order by descripcion
end
GO
/****** Object:  StoredProcedure [dbo].[prov_ObtenerProvincias]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[prov_ObtenerProvincias]
AS
begin
SELECT *
  FROM [farmacia].[dbo].[Provincia]

end
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamilia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ValidarEliminarFamilia] 
	@familia_id AS Int
AS

Declare @patente_id int
Declare @result bit
Declare cur cursor For SELECT Patente.patente_id FROM farmacia.dbo.Patente WHERE Patente.obligatoria = 1

SET @result = 1
OPEN cur 
	FETCH NEXT FROM cur Into @patente_id
		While @@Fetch_Status = 0 Begin
 			IF NOT EXISTS (
				select *
				from farmacia.dbo.Usuario_Patente up 
				inner join farmacia.dbo.Usuario u
				on u.usuario_id = up.usuario_id
				where up.patente_id = @patente_id
				AND up.negado = 0
				AND u.bloqueado = 0
				AND u.eliminado = 0
    		) AND NOT EXISTS (
				select *
				from farmacia.dbo.Patente_Familia pf 
				inner join farmacia.dbo.Familia_Usuario fu 
				on fu.familia_id = pf.familia_id 
				inner join Usuario u
				on u.usuario_id = fu.usuario_id
				where 
				      fu.familia_id != @familia_id
				  AND pf.patente_id = @patente_id
				  AND u.bloqueado = 0
				  AND u.eliminado = 0
				  AND pf.patente_id 
				not in (
				select up.patente_id 
				from  farmacia.dbo.Usuario_Patente up 
				where up.usuario_id = u.usuario_id
				AND up.negado = 1)
				) SET @result = 0
				   
		FETCH NEXT FROM cur Into @patente_id
	END
CLOSE cur
DEALLOCATE cur

SELECT @result AS Valido

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaPatente]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarFamiliaPatente] 
	@familia_id AS Int,
	@patente_id AS Int
AS

Declare @result bit

SET @result = 1

IF EXISTS (
	select p.patente_id
	from Patente p 
	where  p.obligatoria = 1 and p.patente_id = @patente_id
) AND NOT EXISTS (
	select up.patente_id, up.patente_id
	from Usuario_Patente up 
	inner join Usuario u
	on u.usuario_id = up.usuario_id
	where(up.patente_id = @patente_id)
	and up.negado = 0
	and u.bloqueado = 0
	and u.eliminado = 0
) AND NOT EXISTS (
	select fu.familia_id, pf.patente_id
	from Patente_Familia pf 
	inner join Familia_Usuario fu 
	on fu.familia_id = pf.familia_id 
	inner join Usuario u
	on u.usuario_id = fu.usuario_id
	where 
	    pf.patente_id = @patente_id
	and pf.familia_id != @familia_id
	and u.bloqueado = 0
	and u.eliminado = 0
	AND pf.patente_id
	 not in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = fu.usuario_id
		and up.negado = 1
	)
 
) SET @result = 0

SELECT @result AS Valido

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarFamiliaUsuario]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery10.sql|7|0|C:\Users\PC\AppData\Local\Temp\~vs62A1.sql
CREATE PROCEDURE [dbo].[sp_ValidarEliminarFamiliaUsuario] 
	@familia_id AS Int,
	@usuario_id AS Int
AS

Declare @patente_id int
Declare @result bit
Declare cur cursor For SELECT Patente.patente_id FROM Patente WHERE Patente.obligatoria = 1 

SET @result = 1
OPEN cur 
	FETCH NEXT FROM cur Into @patente_id
		While @@Fetch_Status = 0 Begin
			IF NOT EXISTS (
				select *
				from Usuario_Patente up 
				inner join Usuario u
				on u.usuario_id = up.usuario_id
				where up.patente_id = @patente_id
				and up.Negado = 0
				and u.bloqueado = 0
				and u.eliminado = 0
	/*	) AND NOT EXISTS (
				select *
				from Patente_Familia pf,
					 Familia_Usuario fu,
					 usuario u 
				where u.usuario_id = fu.usuario_id
				  AND fu.familia_id != pf.familia_id
				  AND pf.patente_id = @patente_id
				  AND ((u.usuario_id = @usuario_id
				   AND u.usuario_id = fu.usuario_id
				   AND fu.familia_id != @familia_id)
				  OR (u.usuario_id != @usuario_id))
				and u.bloqueado = 0
				and u.eliminado = 0
				AND pf.patente_id NOT in (
					select up.patente_id 
					from Usuario_Patente up 
					where up.usuario_id = @usuario_id
					and up.negado = 1)
			) SET @result = 0*/

						) AND NOT EXISTS (
				select *
				from Patente_Familia pf 
				inner join Familia_Usuario fu 
				on fu.familia_id = pf.familia_id 
				inner join Usuario u
				on u.usuario_id = fu.usuario_id
				AND pf.patente_id NOT in (
					select up.patente_id 
					from Usuario_Patente up 
					where up.usuario_id = @usuario_id
					and up.negado = 1)
				and pf.patente_id = @patente_id
				and (pf.familia_id != @familia_id or fu.usuario_id != @usuario_id)
				and u.bloqueado = 0
				and u.eliminado = 0
			) SET @result = 0

		FETCH NEXT FROM cur Into @patente_id
	END
CLOSE cur
DEALLOCATE cur

SELECT @result AS Valido







GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuario]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarUsuario] 
	@usuario_id AS Int
AS

Declare @patente_id int
Declare @result bit
Declare cur cursor For SELECT patente_id FROM Patente  WHERE Patente.obligatoria = 1


SET @result = 1
OPEN cur 
	FETCH NEXT FROM cur Into @patente_id
		While @@Fetch_Status = 0 Begin
			IF NOT EXISTS (
				select *
				from Usuario_Patente up,
				     usuario u
				WHERE u.usuario_id != @usuario_id
				  AND u.usuario_id = up.usuario_id
				  AND up.patente_id = @patente_id
				and up.negado = 0
				and u.bloqueado = 0
				and u.eliminado = 0
			) AND NOT EXISTS (
				select *
				from Patente_Familia pf,
				     Familia_Usuario fu,
					 usuario u
				WHERE u.usuario_id != @usuario_id
				  AND u.usuario_id = fu.usuario_id
				  AND fu.familia_id = pf.familia_id
				  AND pf.patente_id = @patente_id
				  AND pf.patente_id NOT in (
					select up.patente_id 
					from Usuario_Patente up 
					where up.usuario_id = u.usuario_id
					and up.negado = 1)
				  and u.bloqueado = 0
				  and u.eliminado = 0	
			) SET @result = 0
		FETCH NEXT FROM cur Into @patente_id
	END
CLOSE cur
DEALLOCATE cur

SELECT @result AS Valido




GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatente]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarUsuarioPatente] 
	@usuario_id AS Int,
	@patente_id AS Int
AS

Declare @result bit

SET @result = 1

IF EXISTS (
	select *
	from Patente p 
	where   p.obligatoria = 1 and p.patente_id = @patente_id
) AND NOT EXISTS (
	select *
	from dbo.Usuario_Patente up,
	     dbo.Usuario u
	WHERE  up.patente_id = @patente_id 
	   and up.usuario_id = u.usuario_id
	   and u.usuario_id != @usuario_id
	   and u.bloqueado = 0
	   and u.eliminado = 0
	   AND up.negado = 0
) AND NOT EXISTS (
	select * 
	  from dbo.Patente_Familia pf,
		   dbo.Familia_Usuario fu,	
		   dbo.Usuario u,
		   dbo.Usuario_Patente up
	 where pf.patente_id = @patente_id 
 	   and pf.familia_id = fu.familia_id
	   and fu.usuario_id = u.usuario_id
	   and u.usuario_id = @usuario_id
	   and u.bloqueado = 0
	   and u.eliminado = 0
) AND NOT EXISTS (
	select * 
	  from dbo.Patente_Familia pf,
		   dbo.Familia_Usuario fu,	
		   dbo.Usuario u,
		   dbo.Usuario_Patente up
	 where pf.patente_id = @patente_id 
 	   and pf.familia_id = fu.familia_id
	   and fu.usuario_id = u.usuario_id
	   and u.usuario_id != @usuario_id
	   and u.bloqueado = 0
	   and u.eliminado = 0
	   AND pf.patente_id NOT in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = u.usuario_id
		and up.negado = 1)
) SET @result = 0

SELECT @result AS Valido

GO
/****** Object:  StoredProcedure [dbo].[sp_ValidarEliminarUsuarioPatenteNegacion]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ValidarEliminarUsuarioPatenteNegacion] 
	@usuario_id AS Int,
	@patente_id AS Int
AS

Declare @result bit

SET @result = 1

IF EXISTS (
	select *
	from Patente p 
	where  p.obligatoria = 1 and p.patente_id = @patente_id
) AND NOT EXISTS (
	select *
	from Usuario_Patente up,
	     Usuario u
	where u.usuario_id != @usuario_id
	  and u.usuario_id = up.usuario_id
	  and up.Negado = 0
	  and up.patente_id = @patente_id
	  and u.bloqueado = 0
	  and u.eliminado = 0
) AND NOT EXISTS (
	select *
	from Patente_Familia pf,
	     Familia_Usuario fu,
		 usuario u
	WHERE u.usuario_id != @usuario_id
	  and u.usuario_id = fu.usuario_id
	  AND fu.familia_id = pf.familia_id
	  AND pf.patente_id = @patente_id
	  AND pf.patente_id NOT in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = u.usuario_id
		and up.negado = 1)
	and u.bloqueado = 0
	and u.eliminado = 0
) SET @result = 0

SELECT @result AS Valido


GO
/****** Object:  StoredProcedure [dbo].[sp_VerificarPatente]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[sp_VerificarPatente] 
	@usuario_id AS Int,
	@patente_id AS Int
AS

Declare @result bit
SET @result = 0

IF EXISTS (
	select *
	from Usuario_Patente up,
	     usuario u
    WHERE u.usuario_id = @usuario_id
	  AND u.usuario_id = up.usuario_id
	  AND up.patente_id = @patente_id
	  AND up.negado = 0
) OR EXISTS (
	select *
	from Patente_Familia pf,
	     Familia_Usuario fu,
		 usuario u
	WHERE u.usuario_id = @usuario_id
	  AND u.usuario_id = fu.usuario_id
	  AND fu.familia_id = pf.familia_id
	  AND pf.patente_id = @patente_id
	  AND pf.patente_id NOT in (
		select up.patente_id 
		from Usuario_Patente up 
		where up.usuario_id = @usuario_id
		and up.negado = 1)
) SET @result = 1

SELECT @result AS Valido



GO
/****** Object:  StoredProcedure [dbo].[usu_BloquearDesbloquerUsuario]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usu_BloquearDesbloquerUsuario]
	@usuario_id as int,
	@bloqueado as bit
AS
begin
UPDATE [dbo].[Usuario]
   SET  bloqueado = @bloqueado
 WHERE 
		[usuario_id] = @usuario_id
end
GO
/****** Object:  StoredProcedure [dbo].[usu_EliminarUsuario]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usu_EliminarUsuario]
	@usuario_id as int,
	@eliminado as bit
AS
begin
UPDATE [dbo].[Usuario]
   SET  eliminado = @eliminado
 WHERE 
		[usuario_id] = @usuario_id
end
GO
/****** Object:  StoredProcedure [dbo].[usu_InsertarUsuario]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usu_InsertarUsuario]
	@nombre_usuario as nvarchar(50),
    @contraseña as nvarchar(50),
    @apellido as nvarchar(80),
    @nombre as nvarchar(80),
    @dni as int,
	@email as nvarchar(100),
    @bloqueado as bit,
	@eliminado as bit,
    @cci as int
AS
BEGIN
INSERT INTO [dbo].[Usuario]
           (		
            [nombre_usuario]
           ,[contraseña]
           ,[nombre]
           ,[apellido]
           ,[email]
           ,[dni]
           ,bloqueado
		   ,eliminado
           ,[cci]
		   ,dvh)
     VALUES
           (
		    @nombre_usuario
           ,@contraseña
           ,@nombre
           ,@apellido
           ,@email
           ,@dni
           ,@bloqueado
		   ,@eliminado
           ,@cci
           ,0 )
END

GO
/****** Object:  StoredProcedure [dbo].[usu_ModificarUsuario]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usu_ModificarUsuario]
	@usuario_id as int,
	@nombre_usuario as nvarchar(50),
    @contraseña as nvarchar(50),
    @nombre as nvarchar(80),
    @apellido as nvarchar(80),
    @email as nvarchar(100),
    @dni as int,
    @bloqueado as bit,
    @cci as int
AS
begin
UPDATE [dbo].[Usuario]
   SET [nombre_usuario] = @nombre_usuario
      ,[contraseña] = @contraseña
      ,[nombre] = @nombre
      ,[apellido] = @apellido
      ,[email] = @email
      ,[dni] = @dni
      ,bloqueado = @bloqueado
      ,[cci] = @cci
 WHERE 
	   [usuario_id] = @usuario_id

end
GO
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuarios]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usu_ObtenerUsuarios]
AS
begin
SELECT [usuario_id]
      ,[nombre_usuario]
      ,[contraseña]
      ,[nombre]
      ,[apellido]
      ,[email]
      ,[dni]
	  ,eliminado
      ,bloqueado
      ,[cci]
  FROM [farmacia].[dbo].[Usuario]
  order by eliminado


end
GO
/****** Object:  StoredProcedure [dbo].[usu_ObtenerUsuariosPorID]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usu_ObtenerUsuariosPorID]
@usuario_id as int
AS
begin
SELECT [usuario_id]
      ,[nombre_usuario]
      ,[contraseña]
      ,[nombre]
      ,[apellido]
      ,[email]
      ,[dni]
      ,bloqueado,eliminado
      ,[cci]
  FROM [farmacia].[dbo].[Usuario]
  where usuario_id = @usuario_id 
end
GO
/****** Object:  StoredProcedure [dbo].[usu_ValidarContraseña]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usu_ValidarContraseña]
	@nombre_usuario as nvarchar(50) 
AS
BEGIN

	select  [usuario_id]
      ,[nombre_usuario]
      ,[contraseña]
      ,[nombre]
      ,[apellido]
      ,[email]
      ,[dni]
      ,[bloqueado]
      ,[eliminado]
      ,[cci]
	   from Usuario u
	where u.nombre_usuario = @nombre_usuario 
END

GO
/****** Object:  StoredProcedure [dbo].[usu_VerificarExistencia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usu_VerificarExistencia]
	@nombre_usuario as nvarchar(50)
AS
BEGIN

	select * from Usuario u where u.nombre_usuario = @nombre_usuario
END

GO
/****** Object:  StoredProcedure [dbo].[vent_EliminarVentasMedicamentosByVentaId]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[vent_EliminarVentasMedicamentosByVentaId]
@venta_id as int

AS
begin
delete from [dbo].[Venta_Medicamento] where Venta_Medicamento.venta_id = @venta_id;

end



GO
/****** Object:  StoredProcedure [dbo].[vent_InsertarVenta]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_InsertarVenta]
@fecha_venta as datetime,
@cliente_fk as int,
@dvh as int

AS
begin


insert into	 
Venta (fecha_venta,cliente_fk,eliminado,dvh)
values (@fecha_venta,@cliente_fk,0,@dvh);
select SCOPE_IDENTITY();

end



GO
/****** Object:  StoredProcedure [dbo].[vent_InsertarVentaMedicamento]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_InsertarVentaMedicamento]
@venta_id as int,
@medicamento_id as int,
@cantidad_venta as nvarchar(255),
@precio_venta as nvarchar(255)

AS
begin


insert into	 
Venta_Medicamento (venta_id,medicamento_id,cantidad_venta,precio_venta,dvh)
values (@venta_id,@medicamento_id,@cantidad_venta,@precio_venta,	0)

end



GO
/****** Object:  StoredProcedure [dbo].[vent_ListarVentasById]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[vent_ListarVentasById]
@venta_id as int
AS
begin
SELECT 
V.venta_id,V.fecha_venta,C.cliente_id,C.nombreCompleto
FROM [farmacia].[dbo].[Venta] AS V
INNER JOIN Cliente AS C ON C.cliente_id = V.cliente_fk
WHERE 
V.venta_id = @venta_id
end



GO
/****** Object:  StoredProcedure [dbo].[vent_ListarVentasMedicamentosByVentaId]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_ListarVentasMedicamentosByVentaId]
@venta_id as int
AS
begin
SELECT 
*
FROM [farmacia].[dbo].[Venta_Medicamento] AS VM
INNER JOIN Medicamento AS M ON VM.medicamento_id = M.medicamento_id
WHERE 
VM.venta_id = @venta_id
end



GO
/****** Object:  StoredProcedure [dbo].[vent_ListarVentasPorParametros]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[vent_ListarVentasPorParametros]
@fecha_desde as datetime,
@fecha_hasta as datetime,
@cliente_fk as int 
AS
begin
SELECT 
V.venta_id,V.fecha_venta,C.cliente_id,C.nombreCompleto 
FROM [farmacia].[dbo].[Venta] AS V
INNER JOIN Cliente AS C ON C.cliente_id = V.cliente_fk
INNER JOIN Venta_Medicamento AS VM ON VM.venta_id = V.venta_id
INNER JOIN Medicamento AS M ON M.medicamento_id = VM.medicamento_id
WHERE 
  (V.fecha_venta >= @fecha_desde and V.fecha_venta <= @fecha_hasta)
and  (V.cliente_fk = @cliente_fk or @cliente_fk = 0)
 
group by V.venta_id, V.fecha_venta,C.cliente_id,C.nombreCompleto 
end



GO
/****** Object:  StoredProcedure [dbo].[vent_ModificarVenta]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[vent_ModificarVenta]
@venta_id as int,
@cliente_id as int
AS
begin
UPDATE [dbo].Venta
   SET cliente_fk = @cliente_id
 WHERE 
	  venta_id = @venta_id

end



GO
/****** Object:  Table [dbo].[Bitacora]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Bitacora](
	[bitacora_id] [int] IDENTITY(1,1) NOT NULL,
	[usuario_fk] [int] NULL,
	[descripcion] [nvarchar](255) NULL,
	[fecha_hora] [datetime] NULL,
	[criticidad] [nvarchar](50) NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Bitacora] PRIMARY KEY CLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[dni] [nvarchar](50) NULL,
	[apellido] [nvarchar](80) NULL,
	[nombre] [nvarchar](80) NULL,
	[nombreCompleto] [nvarchar](160) NULL,
	[telefono] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
	[direccion] [nvarchar](255) NULL,
	[localidad_fk] [int] NULL,
	[provincia_fk] [int] NULL,
	[fecha_alta] [date] NULL,
	[eliminado] [bit] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DVV]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DVV](
	[tabla_id] [int] NOT NULL,
	[nombre] [nchar](20) NULL,
	[dvv] [varchar](256) NULL,
 CONSTRAINT [PK_DVV] PRIMARY KEY CLUSTERED 
(
	[tabla_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Familia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Familia](
	[familia_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[descripcion] [nvarchar](50) NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Familia] PRIMARY KEY CLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Familia_Usuario]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Familia_Usuario](
	[familia_id] [int] NOT NULL,
	[usuario_id] [int] NOT NULL,
 CONSTRAINT [PK_Familia_Usuario] PRIMARY KEY CLUSTERED 
(
	[familia_id] ASC,
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Idioma]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Idioma](
	[idioma_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
 CONSTRAINT [PK_Idioma] PRIMARY KEY CLUSTERED 
(
	[idioma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Laboratorio]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Laboratorio](
	[laboratorio_id] [int] IDENTITY(1,1) NOT NULL,
	[telefono] [nvarchar](50) NULL,
	[razon_social] [nvarchar](50) NULL,
	[cuit] [nvarchar](50) NULL,
 CONSTRAINT [PK_Laboratorio] PRIMARY KEY CLUSTERED 
(
	[laboratorio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Localidad]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Localidad](
	[localidad_id] [int] NOT NULL,
	[descripcion] [nvarchar](100) NULL,
	[provincia_fk] [int] NOT NULL,
 CONSTRAINT [PK_Localidad] PRIMARY KEY CLUSTERED 
(
	[localidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Medicamento]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Medicamento](
	[medicamento_id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](50) NOT NULL,
	[laboratorio_fk] [int] NULL,
	[cantidad] [nvarchar](50) NULL,
	[precio] [nvarchar](50) NULL,
	[eliminado] [bit] NULL,
	[receta] [bit] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Medicamento] PRIMARY KEY CLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Patente]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente](
	[patente_id] [int] NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[obligatoria] [bit] NULL,
 CONSTRAINT [PK_Patente] PRIMARY KEY CLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patente_Familia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patente_Familia](
	[familia_id] [int] NOT NULL,
	[patente_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincia](
	[provincia_id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](100) NULL,
 CONSTRAINT [PK_Provincia] PRIMARY KEY CLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Traduccion]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Traduccion](
	[traduccion_id] [int] IDENTITY(1,1) NOT NULL,
	[idioma_fk] [int] NULL,
	[texto] [nvarchar](256) NULL,
	[traduccion] [nvarchar](256) NULL,
 CONSTRAINT [PK_Traduccion] PRIMARY KEY CLUSTERED 
(
	[traduccion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[usuario_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre_usuario] [nvarchar](50) NOT NULL,
	[contraseña] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](80) NULL,
	[apellido] [nvarchar](80) NULL,
	[email] [nvarchar](100) NULL,
	[dni] [nvarchar](50) NULL,
	[bloqueado] [bit] NULL,
	[eliminado] [bit] NULL,
	[cci] [int] NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Usuario_Patente]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario_Patente](
	[patente_id] [int] NOT NULL,
	[usuario_id] [int] NOT NULL,
	[negado] [bit] NULL,
 CONSTRAINT [PK_Usuario_Patente] PRIMARY KEY CLUSTERED 
(
	[patente_id] ASC,
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Venta]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[venta_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_fk] [int] NOT NULL,
	[eliminado] [bit] NULL,
	[fecha_venta] [datetime] NULL,
	[dvh] [int] NULL,
 CONSTRAINT [PK_Venta] PRIMARY KEY CLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Venta_Medicamento]    Script Date: 14/07/2016 19:53:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Venta_Medicamento](
	[venta_medicamento_id] [int] IDENTITY(1,1) NOT NULL,
	[venta_id] [int] NULL,
	[medicamento_id] [int] NULL,
	[cantidad_venta] [varchar](256) NULL,
	[precio_venta] [varchar](256) NULL,
	[dvh] [varchar](256) NULL,
 CONSTRAINT [PK_Venta_Medicamento] PRIMARY KEY CLUSTERED 
(
	[venta_medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Bitacora] ON 

INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1490, 29, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A551017F5CC7 AS DateTime), N'Baja', N'90468')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1491, 29, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A551017FA469 AS DateTime), N'Alta', N'197762')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1492, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A551018073D0 AS DateTime), N'Baja', N'93441')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1493, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55101819687 AS DateTime), N'Baja', N'89553')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1494, 9, N'eAuF+/yWqQ5r1KZIWIxfg2nu6CJWyeGTZontVRqNjPY=', CAST(0x0000A5510181A4C6 AS DateTime), N'Alta', N'191601')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1495, 9, N'uDkgXNw+7CHUFvWnn33LNaFiVsmXrwZoO31hdD8HGos=', CAST(0x0000A5510181A75A AS DateTime), N'Alta', N'188105')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1496, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A5510184A193 AS DateTime), N'Media', N'332247')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1497, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5510184A6C3 AS DateTime), N'Baja', N'89468')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1498, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55101855D88 AS DateTime), N'Baja', N'93611')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1499, 29, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A551018565E1 AS DateTime), N'Baja', N'90637')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1500, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A551018576AE AS DateTime), N'Baja', N'90076')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1501, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5510185B52D AS DateTime), N'Baja', N'89789')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1502, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55101865836 AS DateTime), N'Baja', N'92941')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1503, 29, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5510186638F AS DateTime), N'Baja', N'90065')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1504, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55101867E2B AS DateTime), N'Baja', N'89579')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1505, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5510186DAB6 AS DateTime), N'Baja', N'89437')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1506, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5510189EA98 AS DateTime), N'Baja', N'89529')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1507, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520000AD7C AS DateTime), N'Baja', N'86679')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1508, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5520000C54E AS DateTime), N'Baja', N'84075')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1509, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520001B6B8 AS DateTime), N'Baja', N'86629')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1510, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5520001DF4D AS DateTime), N'Baja', N'84269')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1511, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520003023F AS DateTime), N'Baja', N'86704')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1512, 9, N'92xR8E9lVFvZ+l193m52qLcRpEHJ/KDzbnv6Q+vsx8Q=', CAST(0x0000A55200032164 AS DateTime), N'Media', N'186354')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1513, 9, N'1rvroHdeQqHsdhwiHirv7g==', CAST(0x0000A55200033114 AS DateTime), N'Alta', N'93666')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1514, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A552000333B1 AS DateTime), N'Alta', N'86425')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1515, 9, N'AguINniBEFNkqkZBzpMOOBkdekUhsXsev8lMyac2/ps=', CAST(0x0000A5520003419D AS DateTime), N'Alta', N'191145')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1516, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A55200037945 AS DateTime), N'Alta', N'181240')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1517, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5520003E625 AS DateTime), N'Baja', N'83738')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1518, 9, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A5520004DA7B AS DateTime), N'Alta', N'178114')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1519, 9, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A5520004DBE4 AS DateTime), N'Alta', N'187931')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1520, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520004E8A3 AS DateTime), N'Baja', N'86776')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1521, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A5520004FE29 AS DateTime), N'Alta', N'180939')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1522, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200068B86 AS DateTime), N'Baja', N'86934')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1523, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A5520006A831 AS DateTime), N'Alta', N'181022')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1524, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520006E656 AS DateTime), N'Baja', N'86752')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1525, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A5520006F8B1 AS DateTime), N'Alta', N'181026')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1526, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200081953 AS DateTime), N'Baja', N'84422')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1527, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A552000A8182 AS DateTime), N'Baja', N'86891')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1528, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A552000AC3D0 AS DateTime), N'Alta', N'181224')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1529, 9, N'ei8eB9akhdtYhJmiABriX/+yTXq+uDzs/hpP3M71ago=', CAST(0x0000A552000BE142 AS DateTime), N'Alta', N'183912')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1530, 9, N'92xR8E9lVFvZ+l193m52qLcRpEHJ/KDzbnv6Q+vsx8Q=', CAST(0x0000A552000C0845 AS DateTime), N'Media', N'187136')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1531, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A552000D320F AS DateTime), N'Alta', N'181199')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1532, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200A00725 AS DateTime), N'Baja', N'87255')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1533, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BB5257 AS DateTime), N'Baja', N'89115')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1534, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BB6038 AS DateTime), N'Baja', N'86514')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1535, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BD256D AS DateTime), N'Baja', N'89918')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1536, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BD296D AS DateTime), N'Baja', N'86981')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1537, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BD8016 AS DateTime), N'Baja', N'89921')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1538, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BD86F3 AS DateTime), N'Baja', N'86437')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1539, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BE9EA0 AS DateTime), N'Baja', N'89273')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1540, 9, N'VPKIonfX6HMAjouizTOhQwBtYykvP9kSP1c63L6c29MW9GIfjM3EtlM/8ZXeFKin', CAST(0x0000A55200BF01F9 AS DateTime), N'Alta', N'310696')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1541, 9, N'eAuF+/yWqQ5r1KZIWIxfg2nu6CJWyeGTZontVRqNjPY=', CAST(0x0000A55200BF0613 AS DateTime), N'Alta', N'191977')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1542, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BF12A8 AS DateTime), N'Baja', N'86733')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1543, 9, N'YcTo6gq4CNndMjb+QZLBiHJdbUD9e0xENHabbR8ex2Y=', CAST(0x0000A55200BF656E AS DateTime), N'Alta', N'184609')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1544, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200BF78A5 AS DateTime), N'Baja', N'89679')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1545, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200BF99FD AS DateTime), N'Baja', N'87028')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1546, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C06D0C AS DateTime), N'Baja', N'89509')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1547, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A55200C08981 AS DateTime), N'Alta', N'182134')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1548, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A55200C08E0F AS DateTime), N'Alta', N'182410')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1549, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C39624 AS DateTime), N'Baja', N'89514')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1550, 9, N'MVdb5psLDtHAIrEJkSjDWK6J1KYjPtVkkKY5er52Spo=', CAST(0x0000A55200C3B258 AS DateTime), N'Alta', N'186305')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1551, 9, N'MVdb5psLDtHAIrEJkSjDWK6J1KYjPtVkkKY5er52Spo=', CAST(0x0000A55200C3B5C8 AS DateTime), N'Alta', N'186513')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1552, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C40D29 AS DateTime), N'Baja', N'89818')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1553, 9, N'MVdb5psLDtHAIrEJkSjDWK6J1KYjPtVkkKY5er52Spo=', CAST(0x0000A55200C41A1B AS DateTime), N'Alta', N'187128')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1554, 9, N'MVdb5psLDtHAIrEJkSjDWK6J1KYjPtVkkKY5er52Spo=', CAST(0x0000A55200C41C2C AS DateTime), N'Alta', N'186250')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1555, 9, N'ei8eB9akhdtYhJmiABriX1U1mpTO80fmJUkDejOcA50=', CAST(0x0000A55200C433A5 AS DateTime), N'Alta', N'184147')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1556, 9, N'UYahIg+g0WKndK4p/20+pg==', CAST(0x0000A55200C4DFB6 AS DateTime), N'Alta', N'89604')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1557, 9, N'bCs5TEGHWUHqr3uw0/J+Pg==', CAST(0x0000A55200C4E763 AS DateTime), N'Alta', N'90296')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1558, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200C53A15 AS DateTime), N'Baja', N'86987')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1559, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C741ED AS DateTime), N'Baja', N'89664')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1560, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C839A5 AS DateTime), N'Baja', N'89955')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1561, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200C8EC45 AS DateTime), N'Baja', N'89258')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1562, 0, N'uFAIrnFQ4ZJ5jF/k6mSuBzkWjXTmNsiS8NJj7m4UI/k=', CAST(0x0000A55200C93BC6 AS DateTime), N'Media', N'191827')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1563, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200CC56F3 AS DateTime), N'Baja', N'89782')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1564, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200CEC31B AS DateTime), N'Baja', N'89690')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1565, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200CFB022 AS DateTime), N'Baja', N'86697')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1566, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200D00577 AS DateTime), N'Baja', N'89589')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1567, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200D18645 AS DateTime), N'Baja', N'89505')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1568, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200D20663 AS DateTime), N'Baja', N'86804')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1569, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200D38981 AS DateTime), N'Baja', N'89231')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1570, 9, N'J6OXvfoWimq/nVaXFZ+s3MRr2+3tZ8VjYZEkm7xjLOs=', CAST(0x0000A55200D3A669 AS DateTime), N'Media', N'194656')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1571, 9, N'J6OXvfoWimq/nVaXFZ+s3MRr2+3tZ8VjYZEkm7xjLOs=', CAST(0x0000A55200D4F440 AS DateTime), N'Media', N'194578')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1572, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200EAE1F1 AS DateTime), N'Baja', N'89339')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1573, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200EBBBA5 AS DateTime), N'Baja', N'89766')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1574, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A55200EBF14F AS DateTime), N'Alta', N'182781')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1575, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A55200EBF42E AS DateTime), N'Alta', N'182921')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1576, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A55200EBF727 AS DateTime), N'Alta', N'183129')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1577, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200EC01CA AS DateTime), N'Baja', N'87127')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1578, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200EC1945 AS DateTime), N'Baja', N'89925')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1579, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A55200EC4B30 AS DateTime), N'Alta', N'330044')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1580, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200EE5C75 AS DateTime), N'Baja', N'89656')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1581, 9, N'JAiBDCk3mNu1HLX1zLrqQlJUJWpJO2qoytowIqN1qzc=', CAST(0x0000A55200EF4476 AS DateTime), N'Media', N'201406')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1582, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200F4F0C4 AS DateTime), N'Baja', N'89863')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1583, 9, N'dJdNAQ9yg0JG6W70stf7JGVAmbMGt0MI4biQa2JCAO0=', CAST(0x0000A55200F54815 AS DateTime), N'Alta', N'176877')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1584, 9, N'LntEkJTXoA+LvkNo39N1BrxZ276iSIJjtEA9GbcdxRQ=', CAST(0x0000A55200F54FF3 AS DateTime), N'Alta', N'184838')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1585, 9, N'LntEkJTXoA+LvkNo39N1BrxZ276iSIJjtEA9GbcdxRQ=', CAST(0x0000A55200F55382 AS DateTime), N'Alta', N'184433')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1586, 9, N'LntEkJTXoA+LvkNo39N1BrxZ276iSIJjtEA9GbcdxRQ=', CAST(0x0000A55200F55698 AS DateTime), N'Alta', N'184573')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1587, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A55200F7D6EF AS DateTime), N'Alta', N'329506')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1588, 9, N'cgoGwnWuzttKXvag9Z5UzzJ//wjcTv+Oqzb45ts3lJgJ56MmOXzzGj2XmwUbBqrP', CAST(0x0000A55200F7EA19 AS DateTime), N'Alta', N'327856')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1589, 9, N'F4JiVkdNDsixHwk7QMPR1mFCtW6ftjCoNRvkBoUgP93t1pudbu4MaU/6lqVA8orH', CAST(0x0000A55200F7F4BD AS DateTime), N'Alta', N'320251')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1590, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200FB5BAE AS DateTime), N'Baja', N'89379')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1591, 9, N'PNM6/fGO4jai0qC/OnkP7Khy80qiPlg7MpbWnUjGV83tKQ3gtRyXPDBZ1p8JsDdzJZgrh/voXk+/oNGcXYHaIA==', CAST(0x0000A55200FBF805 AS DateTime), N'Media', N'522594')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1592, 9, N'PNM6/fGO4jai0qC/OnkP7Khy80qiPlg7MpbWnUjGV83tKQ3gtRyXPDBZ1p8JsDdzJZgrh/voXk+/oNGcXYHaIA==', CAST(0x0000A55200FC25E1 AS DateTime), N'Media', N'522373')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1593, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A55200FC3C63 AS DateTime), N'Alta', N'511648')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1594, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A55200FC40EF AS DateTime), N'Media', N'332130')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1595, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200FC9D5E AS DateTime), N'Baja', N'89912')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1596, 9, N'PNM6/fGO4jai0qC/OnkP7Khy80qiPlg7MpbWnUjGV83tKQ3gtRyXPDBZ1p8JsDdzJZgrh/voXk+/oNGcXYHaIA==', CAST(0x0000A55200FD2E15 AS DateTime), N'Media', N'522850')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1597, 9, N'PNM6/fGO4jai0qC/OnkP7Khy80qiPlg7MpbWnUjGV83tKQ3gtRyXPDBZ1p8JsDdzJZgrh/voXk+/oNGcXYHaIA==', CAST(0x0000A55200FD38B1 AS DateTime), N'Media', N'522853')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1598, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A55200FD4045 AS DateTime), N'Alta', N'511124')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1599, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A55200FD5029 AS DateTime), N'Media', N'331813')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1600, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A55200FE7280 AS DateTime), N'Media', N'331915')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1601, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200FE8740 AS DateTime), N'Baja', N'89684')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1602, 9, N'i5se1CE0t28zXe54qgf7IfUZPGSzu+P7R+U6tbKtY1Uu8i1TePhcsrtepMghbkeE', CAST(0x0000A55200FEA68C AS DateTime), N'Alta', N'325534')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1603, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55200FEAD36 AS DateTime), N'Baja', N'86992')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1604, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55200FEC690 AS DateTime), N'Baja', N'89886')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1605, 9, N'Cmo9YO7/eY/bZXLNNGaXDryiJ3qBlR5BxsHiBv3+mcU=', CAST(0x0000A55200FFD039 AS DateTime), N'Alta', N'185835')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1606, 9, N'gxQsG58SSu/UxdVieObSCKrYy3ARzG7LT5tbppYMQQ0=', CAST(0x0000A55200FFDE98 AS DateTime), N'Alta', N'186551')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1607, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55201011320 AS DateTime), N'Baja', N'87342')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1608, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A55201014842 AS DateTime), N'Alta', N'185519')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1609, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A55201014891 AS DateTime), N'Alta', N'185002')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1610, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A552010157B8 AS DateTime), N'Baja', N'90014')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1611, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520104B81C AS DateTime), N'Baja', N'89865')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1612, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A5520104D67A AS DateTime), N'Media', N'203357')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1613, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520106CFE8 AS DateTime), N'Baja', N'89874')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1614, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A552010774F6 AS DateTime), N'Baja', N'89873')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1615, 9, N'JAiBDCk3mNu1HLX1zLrqQpxLzyo5+HjoexULfZfcJCg=', CAST(0x0000A552010889A5 AS DateTime), N'Media', N'199672')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1616, 9, N'JAiBDCk3mNu1HLX1zLrqQpxLzyo5+HjoexULfZfcJCg=', CAST(0x0000A55201089F05 AS DateTime), N'Media', N'199674')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1617, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55201122288 AS DateTime), N'Baja', N'89843')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1618, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5520112381C AS DateTime), N'Baja', N'87193')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1619, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55201124E36 AS DateTime), N'Baja', N'89895')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1620, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55201135E2F AS DateTime), N'Baja', N'87033')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1621, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5520115FA52 AS DateTime), N'Baja', N'89640')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1622, 9, N'AguINniBEFNkqkZBzpMOOBkdekUhsXsev8lMyac2/ps=', CAST(0x0000A55201164E0E AS DateTime), N'Alta', N'195707')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1623, 9, N'VPKIonfX6HMAjouizTOhQwBtYykvP9kSP1c63L6c29MW9GIfjM3EtlM/8ZXeFKin', CAST(0x0000A55201166A71 AS DateTime), N'Alta', N'310758')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1624, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A552011B24A0 AS DateTime), N'Baja', N'89567')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1625, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A552011B583A AS DateTime), N'Alta', N'511869')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1626, 9, N'i5se1CE0t28zXe54qgf7IfUZPGSzu+P7R+U6tbKtY1Uu8i1TePhcsrtepMghbkeE', CAST(0x0000A552011B9705 AS DateTime), N'Alta', N'324768')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1627, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A552011B9DA5 AS DateTime), N'Baja', N'87019')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1628, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55700C4F108 AS DateTime), N'Baja', N'89414')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1629, 9, N'JAiBDCk3mNu1HLX1zLrqQuxy2bXX43vi0X8AftfIuNw=', CAST(0x0000A55700C51374 AS DateTime), N'Media', N'196518')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1630, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55700C52697 AS DateTime), N'Baja', N'87161')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1631, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55700CC2E99 AS DateTime), N'Baja', N'89309')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1632, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55700CCD750 AS DateTime), N'Baja', N'86989')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1633, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55700CEBBF0 AS DateTime), N'Baja', N'89266')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1634, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55700D0AADA AS DateTime), N'Baja', N'87029')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1635, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55700DA5F8C AS DateTime), N'Baja', N'89319')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1636, 9, N'MksSqEmD0o2z6Eobk1rVAMuEGJEa7idGLy6Q5NiKxGo=', CAST(0x0000A55700DA7C1D AS DateTime), N'Alta', N'185730')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1637, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55700DAF6BD AS DateTime), N'Baja', N'89416')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1638, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55700DB7E6C AS DateTime), N'Baja', N'87051')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1639, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55700E021DF AS DateTime), N'Baja', N'89372')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1640, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55700E0F1BA AS DateTime), N'Baja', N'87300')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1641, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55701478AD4 AS DateTime), N'Baja', N'89644')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1642, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5570147B946 AS DateTime), N'Baja', N'86899')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1643, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55701492836 AS DateTime), N'Baja', N'90019')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1644, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55701499E27 AS DateTime), N'Baja', N'89060')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1645, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A557014A2236 AS DateTime), N'Baja', N'86740')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1646, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A557014AC6BF AS DateTime), N'Baja', N'89439')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1647, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55701520F13 AS DateTime), N'Baja', N'89151')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1648, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55701532A42 AS DateTime), N'Baja', N'86683')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1649, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55701537F55 AS DateTime), N'Baja', N'89386')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1650, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55701541215 AS DateTime), N'Baja', N'86983')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1651, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5570154E818 AS DateTime), N'Baja', N'89127')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1652, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5570155BA7C AS DateTime), N'Baja', N'86518')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1653, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5570160201F AS DateTime), N'Baja', N'89087')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1654, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A557016477D9 AS DateTime), N'Baja', N'89547')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1655, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5570165AEF9 AS DateTime), N'Baja', N'89470')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1656, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5570166827E AS DateTime), N'Baja', N'89609')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1657, 9, N'Sg+S+pEybO2ZvfIjA0GX/f++sw1f11f/IGKH9xImuSQ=', CAST(0x0000A55701676118 AS DateTime), N'Alta', N'180474')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1658, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55701676194 AS DateTime), N'Alta', N'180444')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1659, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5570167C781 AS DateTime), N'Baja', N'89845')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1660, 9, N'JAiBDCk3mNu1HLX1zLrqQgOEaUyeIco56y4smedkTM0=', CAST(0x0000A5570169A31A AS DateTime), N'Baja', N'187418')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1661, 9, N'JAiBDCk3mNu1HLX1zLrqQgOEaUyeIco56y4smedkTM0=', CAST(0x0000A5570169E6C9 AS DateTime), N'Baja', N'187964')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1662, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A557016B455A AS DateTime), N'Alta', N'184868')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1663, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A557016B45A9 AS DateTime), N'Alta', N'184419')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1664, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A557016B5784 AS DateTime), N'Baja', N'89331')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (1665, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A557016B77B8 AS DateTime), N'Baja', N'194004')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2664, 9, N'Sg+S+pEybO2ZvfIjA0GX/f++sw1f11f/IGKH9xImuSQ=', CAST(0x0000A55800C5A6F7 AS DateTime), N'Alta', N'180652')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2665, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800C5BD94 AS DateTime), N'Baja', N'90011')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2666, 9, N'JAiBDCk3mNu1HLX1zLrqQmEpsncfdX1hmrGhe6EL7+8=', CAST(0x0000A55800C65AC2 AS DateTime), N'Baja', N'183205')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2667, 9, N'JAiBDCk3mNu1HLX1zLrqQmEpsncfdX1hmrGhe6EL7+8=', CAST(0x0000A55800C6887D AS DateTime), N'Baja', N'183409')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2668, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55800C6AF71 AS DateTime), N'Baja', N'86542')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2669, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A55800C8165A AS DateTime), N'Alta', N'185346')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2670, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A55800C816A5 AS DateTime), N'Alta', N'184792')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2671, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800C87AC2 AS DateTime), N'Baja', N'89724')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2672, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A55800C92CA8 AS DateTime), N'Baja', N'194461')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2673, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A55800C934A8 AS DateTime), N'Baja', N'194328')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2674, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A55800C9445F AS DateTime), N'Baja', N'194603')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2675, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A55800C9E37A AS DateTime), N'Alta', N'184660')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2676, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A55800C9E3AE AS DateTime), N'Alta', N'184143')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2677, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800C9F21C AS DateTime), N'Baja', N'89424')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2678, 9, N'Sg+S+pEybO2ZvfIjA0GX/f++sw1f11f/IGKH9xImuSQ=', CAST(0x0000A55800D062EB AS DateTime), N'Alta', N'180267')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2679, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800D06BAC AS DateTime), N'Baja', N'89603')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2680, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800D098D0 AS DateTime), N'Baja', N'89858')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2681, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800D66017 AS DateTime), N'Baja', N'89078')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2682, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800D711B6 AS DateTime), N'Baja', N'89124')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2683, 9, N'JAiBDCk3mNu1HLX1zLrqQlS92VYc484SIP6Yrn2P4tI=', CAST(0x0000A55800D79349 AS DateTime), N'Baja', N'178449')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2684, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800D81506 AS DateTime), N'Baja', N'89503')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2685, 9, N'ei8eB9akhdtYhJmiABriX36wLXN+XbWYaPD3LBetxaQ=', CAST(0x0000A55800D85031 AS DateTime), N'Alta', N'187570')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2686, 9, N'dJdNAQ9yg0JG6W70stf7JKF8k2Fc5s9cTd7EH7EGYyg=', CAST(0x0000A55800D8846B AS DateTime), N'Alta', N'179797')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2687, 9, N'LntEkJTXoA+LvkNo39N1BjTWynZG0hXYCmW80mDz5bE=', CAST(0x0000A55800D88DB7 AS DateTime), N'Alta', N'183660')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2688, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800D8D3DC AS DateTime), N'Baja', N'89704')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2689, 9, N'JAiBDCk3mNu1HLX1zLrqQq3Ww4ZXuKrdK01O76HBD6c=', CAST(0x0000A55800E3899F AS DateTime), N'Baja', N'178262')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2690, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800E4CF20 AS DateTime), N'Baja', N'89435')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2691, 9, N'JAiBDCk3mNu1HLX1zLrqQiCjJ0Qc8EEjSdiAD1r9m6Y=', CAST(0x0000A55800E4E7C0 AS DateTime), N'Baja', N'180784')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2692, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800E52B24 AS DateTime), N'Baja', N'89486')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2693, 9, N'JAiBDCk3mNu1HLX1zLrqQu62Bf2xGER3l3RLPGHqevQ=', CAST(0x0000A55800E53C9C AS DateTime), N'Baja', N'182422')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2694, 9, N'prTPKpz6vwvGWyBMK1yi/furhaxQ3MyshuLpEJTtu+0=', CAST(0x0000A55800E54EFB AS DateTime), N'Baja', N'191574')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2695, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A55800E591FE AS DateTime), N'Baja', N'194717')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2696, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800E97566 AS DateTime), N'Baja', N'90026')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2697, 9, N'JAiBDCk3mNu1HLX1zLrqQuTi5XXYsvHWdzL7k9sCgg4=', CAST(0x0000A55800E9865C AS DateTime), N'Baja', N'187346')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2698, 9, N'JAiBDCk3mNu1HLX1zLrqQuTi5XXYsvHWdzL7k9sCgg4=', CAST(0x0000A55800E98FE8 AS DateTime), N'Baja', N'187281')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2699, 9, N'JAiBDCk3mNu1HLX1zLrqQuTi5XXYsvHWdzL7k9sCgg4=', CAST(0x0000A55800E99E87 AS DateTime), N'Baja', N'187488')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2700, 9, N'prTPKpz6vwvGWyBMK1yi/cOgLlbk71AHXppGMiGtHU0=', CAST(0x0000A55800E9AB54 AS DateTime), N'Baja', N'184845')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2701, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A55800E9E6BE AS DateTime), N'Baja', N'194496')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2702, 9, N'prTPKpz6vwvGWyBMK1yi/egnkDCFSEjfHqhk/cWhiSE=', CAST(0x0000A55800EAB37F AS DateTime), N'Baja', N'189083')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2703, 9, N'prTPKpz6vwvGWyBMK1yi/egnkDCFSEjfHqhk/cWhiSE=', CAST(0x0000A55800EAF9F2 AS DateTime), N'Baja', N'189152')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2704, 9, N'JAiBDCk3mNu1HLX1zLrqQse4eItaaq6+J5RXwAvn4dc=', CAST(0x0000A55800EB6972 AS DateTime), N'Baja', N'186388')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2705, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800EC022C AS DateTime), N'Baja', N'89709')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2706, 9, N'JAiBDCk3mNu1HLX1zLrqQhzyg6ZETZ2o0wh3xcuyaJo=', CAST(0x0000A55800EC1550 AS DateTime), N'Baja', N'191983')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2707, 9, N'prTPKpz6vwvGWyBMK1yi/Xc7q8wK3FQ9fXrjTfUpGeE=', CAST(0x0000A55800EC1CC0 AS DateTime), N'Baja', N'187694')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2708, 9, N'prTPKpz6vwvGWyBMK1yi/Xc7q8wK3FQ9fXrjTfUpGeE=', CAST(0x0000A55800EC242E AS DateTime), N'Baja', N'187493')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2709, 9, N'prTPKpz6vwvGWyBMK1yi/Xc7q8wK3FQ9fXrjTfUpGeE=', CAST(0x0000A55800EC2A72 AS DateTime), N'Baja', N'187292')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2710, 9, N'JAiBDCk3mNu1HLX1zLrqQmIC4FrNt/2Xm4utx0ZCLnY=', CAST(0x0000A55800EC5712 AS DateTime), N'Baja', N'184491')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2711, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800ECDD7A AS DateTime), N'Baja', N'89328')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2712, 9, N'JAiBDCk3mNu1HLX1zLrqQn/1SyXNVtgIPZTVkoaA7Mw=', CAST(0x0000A55800ECF2EE AS DateTime), N'Baja', N'186625')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2713, 9, N'prTPKpz6vwvGWyBMK1yi/VJ4RHILxi+R/UMVH9gznHY=', CAST(0x0000A55800ECF9A9 AS DateTime), N'Baja', N'183390')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2714, 9, N'prTPKpz6vwvGWyBMK1yi/VJ4RHILxi+R/UMVH9gznHY=', CAST(0x0000A55800ED1425 AS DateTime), N'Baja', N'182714')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2715, 9, N'prTPKpz6vwvGWyBMK1yi/VJ4RHILxi+R/UMVH9gznHY=', CAST(0x0000A55800ED1CA8 AS DateTime), N'Baja', N'183194')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2716, 9, N'prTPKpz6vwvGWyBMK1yi/VJ4RHILxi+R/UMVH9gznHY=', CAST(0x0000A55800ED25ED AS DateTime), N'Baja', N'183129')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2717, 9, N'prTPKpz6vwvGWyBMK1yi/VJ4RHILxi+R/UMVH9gznHY=', CAST(0x0000A55800ED4512 AS DateTime), N'Baja', N'183130')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2718, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800EE137A AS DateTime), N'Baja', N'89870')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2719, 9, N'prTPKpz6vwvGWyBMK1yi/egnkDCFSEjfHqhk/cWhiSE=', CAST(0x0000A55800EE2F84 AS DateTime), N'Baja', N'189307')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2720, 9, N'prTPKpz6vwvGWyBMK1yi/egnkDCFSEjfHqhk/cWhiSE=', CAST(0x0000A55800EE3700 AS DateTime), N'Baja', N'189682')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2721, 9, N'prTPKpz6vwvGWyBMK1yi/egnkDCFSEjfHqhk/cWhiSE=', CAST(0x0000A55800EE4279 AS DateTime), N'Baja', N'189753')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2722, 9, N'prTPKpz6vwvGWyBMK1yi/egnkDCFSEjfHqhk/cWhiSE=', CAST(0x0000A55800EE45A9 AS DateTime), N'Baja', N'189348')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2723, 9, N'prTPKpz6vwvGWyBMK1yi/egnkDCFSEjfHqhk/cWhiSE=', CAST(0x0000A55800EE4C3C AS DateTime), N'Baja', N'189692')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2724, 9, N'prTPKpz6vwvGWyBMK1yi/egnkDCFSEjfHqhk/cWhiSE=', CAST(0x0000A55800EE5252 AS DateTime), N'Baja', N'189491')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2725, 9, N'prTPKpz6vwvGWyBMK1yi/aw9koWuYgJFHCBTBebxJx8=', CAST(0x0000A55800EE62E2 AS DateTime), N'Baja', N'188739')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2726, 9, N'prTPKpz6vwvGWyBMK1yi/aw9koWuYgJFHCBTBebxJx8=', CAST(0x0000A55800EE69DF AS DateTime), N'Baja', N'188201')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2727, 9, N'prTPKpz6vwvGWyBMK1yi/aw9koWuYgJFHCBTBebxJx8=', CAST(0x0000A55800EE73E4 AS DateTime), N'Baja', N'188136')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2728, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A55800EF1C57 AS DateTime), N'Alta', N'184855')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2729, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A55800EF1C73 AS DateTime), N'Alta', N'184338')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2730, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800EF2665 AS DateTime), N'Baja', N'89378')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2731, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A55800EF3B58 AS DateTime), N'Baja', N'194024')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2732, 9, N'prTPKpz6vwvGWyBMK1yi/d07STQoB7UOIeb+BOypozk=', CAST(0x0000A55800EF3E63 AS DateTime), N'Baja', N'187133')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2733, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800EFC235 AS DateTime), N'Baja', N'89671')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2734, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800F1E055 AS DateTime), N'Baja', N'89631')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2735, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800F2AA2A AS DateTime), N'Baja', N'89386')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2736, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800F55C46 AS DateTime), N'Baja', N'89772')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2737, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800F65971 AS DateTime), N'Baja', N'89907')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2738, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800F6F172 AS DateTime), N'Baja', N'89811')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2739, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A55800F75197 AS DateTime), N'Media', N'331335')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2740, 9, N'Sg+S+pEybO2ZvfIjA0GX/f++sw1f11f/IGKH9xImuSQ=', CAST(0x0000A55800F75753 AS DateTime), N'Alta', N'179635')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2741, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55800F7576F AS DateTime), N'Alta', N'179537')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2742, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A55800F7578B AS DateTime), N'Alta', N'184050')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2743, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800F760D4 AS DateTime), N'Baja', N'89159')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2744, 9, N'Sg+S+pEybO2ZvfIjA0GX/f++sw1f11f/IGKH9xImuSQ=', CAST(0x0000A55800F852CB AS DateTime), N'Alta', N'180050')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2745, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800F85D3A AS DateTime), N'Baja', N'89446')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2746, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800F99460 AS DateTime), N'Baja', N'89579')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2747, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800F9D571 AS DateTime), N'Baja', N'188180')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2748, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800F9E2E3 AS DateTime), N'Baja', N'188319')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2749, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800F9ECD2 AS DateTime), N'Baja', N'188254')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2750, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800F9F3DF AS DateTime), N'Baja', N'187093')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2751, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800F9F95E AS DateTime), N'Baja', N'187437')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2752, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800F9FBC2 AS DateTime), N'Baja', N'187577')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2753, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800FA0004 AS DateTime), N'Baja', N'187240')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2754, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800FA0BB8 AS DateTime), N'Baja', N'187311')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2755, 9, N'JAiBDCk3mNu1HLX1zLrqQrELOLGmzXVlrs8DBdeMs4U=', CAST(0x0000A55800FA260A AS DateTime), N'Baja', N'187002')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2756, 9, N'prTPKpz6vwvGWyBMK1yi/WN7wybD7pUr1FA0q07hTLc=', CAST(0x0000A55800FA2C94 AS DateTime), N'Baja', N'182333')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2757, 9, N'prTPKpz6vwvGWyBMK1yi/WN7wybD7pUr1FA0q07hTLc=', CAST(0x0000A55800FA31BE AS DateTime), N'Baja', N'182609')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2758, 9, N'prTPKpz6vwvGWyBMK1yi/WN7wybD7pUr1FA0q07hTLc=', CAST(0x0000A55800FA33F1 AS DateTime), N'Baja', N'182749')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2759, 9, N'prTPKpz6vwvGWyBMK1yi/WN7wybD7pUr1FA0q07hTLc=', CAST(0x0000A55800FA4504 AS DateTime), N'Baja', N'182210')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2760, 9, N'prTPKpz6vwvGWyBMK1yi/WN7wybD7pUr1FA0q07hTLc=', CAST(0x0000A55800FA4781 AS DateTime), N'Baja', N'182313')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2761, 9, N'JAiBDCk3mNu1HLX1zLrqQg7kndefR4LBqw92UyuZqHI=', CAST(0x0000A55800FA54EF AS DateTime), N'Baja', N'187681')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2762, 9, N'prTPKpz6vwvGWyBMK1yi/RpY28YHufq3aAHo9l9dQmE=', CAST(0x0000A55800FA5C63 AS DateTime), N'Baja', N'184917')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2763, 9, N'prTPKpz6vwvGWyBMK1yi/RpY28YHufq3aAHo9l9dQmE=', CAST(0x0000A55800FA609A AS DateTime), N'Baja', N'185125')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2764, 9, N'prTPKpz6vwvGWyBMK1yi/RpY28YHufq3aAHo9l9dQmE=', CAST(0x0000A55800FA944F AS DateTime), N'Baja', N'185332')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2765, 9, N'prTPKpz6vwvGWyBMK1yi/RpY28YHufq3aAHo9l9dQmE=', CAST(0x0000A55800FAA3A0 AS DateTime), N'Baja', N'184994')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2766, 9, N'JAiBDCk3mNu1HLX1zLrqQhVidJub4OMg3BO+pJAwuBo=', CAST(0x0000A55800FAB6A9 AS DateTime), N'Baja', N'185639')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2767, 9, N'prTPKpz6vwvGWyBMK1yi/V5VrS6JDyJ1GSYBxLADdVo=', CAST(0x0000A55800FAC575 AS DateTime), N'Baja', N'182931')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2768, 9, N'prTPKpz6vwvGWyBMK1yi/V5VrS6JDyJ1GSYBxLADdVo=', CAST(0x0000A55800FACEA5 AS DateTime), N'Baja', N'183479')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2769, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800FD2BA8 AS DateTime), N'Baja', N'89562')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2770, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800FD34EF AS DateTime), N'Baja', N'187631')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2771, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800FD3777 AS DateTime), N'Baja', N'187839')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2772, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800FD429C AS DateTime), N'Baja', N'187505')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2773, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55800FDB4F1 AS DateTime), N'Alta', N'180012')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2774, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800FDBF20 AS DateTime), N'Baja', N'89490')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2775, 9, N'prTPKpz6vwvGWyBMK1yi/eVI3G1dLIUEESzYkjmtkGQ=', CAST(0x0000A55800FDCB63 AS DateTime), N'Baja', N'187443')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2776, 9, N'prTPKpz6vwvGWyBMK1yi/WN7wybD7pUr1FA0q07hTLc=', CAST(0x0000A55800FDD0BC AS DateTime), N'Baja', N'182668')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2777, 9, N'prTPKpz6vwvGWyBMK1yi/WN7wybD7pUr1FA0q07hTLc=', CAST(0x0000A55800FDD350 AS DateTime), N'Baja', N'182876')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2778, 9, N'JAiBDCk3mNu1HLX1zLrqQtZ62q4hDzIYP219qful+q0=', CAST(0x0000A55800FE0265 AS DateTime), N'Baja', N'182687')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2779, 9, N'prTPKpz6vwvGWyBMK1yi/X8bHvcHR4+yeGw7kXbWmQw=', CAST(0x0000A55800FE096C AS DateTime), N'Baja', N'189233')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2780, 9, N'prTPKpz6vwvGWyBMK1yi/X8bHvcHR4+yeGw7kXbWmQw=', CAST(0x0000A55800FE14CF AS DateTime), N'Baja', N'188862')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2781, 9, N'prTPKpz6vwvGWyBMK1yi/X8bHvcHR4+yeGw7kXbWmQw=', CAST(0x0000A55800FE176A AS DateTime), N'Baja', N'189070')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2782, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55800FE35F3 AS DateTime), N'Baja', N'86877')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2783, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55800FF3CB0 AS DateTime), N'Alta', N'180476')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2784, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55800FF3CCC AS DateTime), N'Alta', N'180480')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2785, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55800FF4AA3 AS DateTime), N'Baja', N'90010')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2786, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A5580102E3A1 AS DateTime), N'Alta', N'185189')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2787, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A5580102E3CB AS DateTime), N'Alta', N'184672')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2788, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580102EE08 AS DateTime), N'Baja', N'89649')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2789, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A5580102FD60 AS DateTime), N'Baja', N'195073')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2790, 9, N'prTPKpz6vwvGWyBMK1yi/d07STQoB7UOIeb+BOypozk=', CAST(0x0000A558010301C9 AS DateTime), N'Baja', N'187195')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2791, 9, N'prTPKpz6vwvGWyBMK1yi/d07STQoB7UOIeb+BOypozk=', CAST(0x0000A558010303FF AS DateTime), N'Baja', N'187335')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2792, 9, N'prTPKpz6vwvGWyBMK1yi/d07STQoB7UOIeb+BOypozk=', CAST(0x0000A558010305F9 AS DateTime), N'Baja', N'187475')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2793, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A558010400A3 AS DateTime), N'Baja', N'87257')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2794, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580104C2CF AS DateTime), N'Baja', N'89857')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2795, 9, N'prTPKpz6vwvGWyBMK1yi/aA15WWve1zdQvVzoInl0Ck=', CAST(0x0000A5580104CFE5 AS DateTime), N'Baja', N'190283')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2796, 9, N'prTPKpz6vwvGWyBMK1yi/aA15WWve1zdQvVzoInl0Ck=', CAST(0x0000A5580104E08A AS DateTime), N'Baja', N'190626')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2797, 9, N'prTPKpz6vwvGWyBMK1yi/aA15WWve1zdQvVzoInl0Ck=', CAST(0x0000A5580104E39C AS DateTime), N'Baja', N'190221')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2798, 9, N'prTPKpz6vwvGWyBMK1yi/aA15WWve1zdQvVzoInl0Ck=', CAST(0x0000A5580104EF89 AS DateTime), N'Baja', N'189369')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2799, 9, N'prTPKpz6vwvGWyBMK1yi/aA15WWve1zdQvVzoInl0Ck=', CAST(0x0000A5580104F321 AS DateTime), N'Baja', N'189577')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2800, 9, N'prTPKpz6vwvGWyBMK1yi/aA15WWve1zdQvVzoInl0Ck=', CAST(0x0000A5580104F995 AS DateTime), N'Baja', N'189243')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2801, 9, N'prTPKpz6vwvGWyBMK1yi/aA15WWve1zdQvVzoInl0Ck=', CAST(0x0000A5580104FC15 AS DateTime), N'Baja', N'189383')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2802, 9, N'JAiBDCk3mNu1HLX1zLrqQnYTBGkRSy3PCMBEYFATUps=', CAST(0x0000A55801050D1D AS DateTime), N'Baja', N'183628')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2803, 9, N'prTPKpz6vwvGWyBMK1yi/V3tHOo6/f6TrHtaK3VGVIo=', CAST(0x0000A55801051063 AS DateTime), N'Baja', N'183278')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2804, 9, N'prTPKpz6vwvGWyBMK1yi/V3tHOo6/f6TrHtaK3VGVIo=', CAST(0x0000A558010539B7 AS DateTime), N'Baja', N'183486')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2805, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55801058031 AS DateTime), N'Baja', N'86819')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2806, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580108439E AS DateTime), N'Baja', N'89537')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2807, 9, N'JAiBDCk3mNu1HLX1zLrqQv9M/1s3REprbDjQMTINJls=', CAST(0x0000A5580109E4AE AS DateTime), N'Baja', N'184743')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2808, 9, N'Sg+S+pEybO2ZvfIjA0GX/f++sw1f11f/IGKH9xImuSQ=', CAST(0x0000A558010AAA59 AS DateTime), N'Alta', N'179985')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2809, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558010AB622 AS DateTime), N'Baja', N'89308')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2810, 9, N'Sg+S+pEybO2ZvfIjA0GX/f++sw1f11f/IGKH9xImuSQ=', CAST(0x0000A558010DBEDE AS DateTime), N'Alta', N'180019')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2811, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A558010DBF0F AS DateTime), N'Alta', N'179921')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2812, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558010DCB57 AS DateTime), N'Baja', N'89563')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2813, 9, N'JAiBDCk3mNu1HLX1zLrqQhJbxCpwDvwfuf2P6Cok25w=', CAST(0x0000A558010F695E AS DateTime), N'Baja', N'188785')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2814, 9, N'prTPKpz6vwvGWyBMK1yi/awQZKhAPkwzHx2GXPSIAKU=', CAST(0x0000A558010FA78C AS DateTime), N'Baja', N'186728')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2815, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801166232 AS DateTime), N'Baja', N'89654')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2816, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580116D4DD AS DateTime), N'Baja', N'89558')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2817, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801177717 AS DateTime), N'Baja', N'89698')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2818, 9, N'JAiBDCk3mNu1HLX1zLrqQmj3NyZD6MFP1KJVY0uYhcU=', CAST(0x0000A5580117DBF9 AS DateTime), N'Baja', N'183569')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2819, 9, N'prTPKpz6vwvGWyBMK1yi/Wz1g65/LXv6z8FqPBQpMus=', CAST(0x0000A5580117E8F4 AS DateTime), N'Baja', N'186879')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2820, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A558011818E4 AS DateTime), N'Alta', N'331140')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2821, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558011947EA AS DateTime), N'Baja', N'89511')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2822, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580119717D AS DateTime), N'Baja', N'89511')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2823, 9, N'JAiBDCk3mNu1HLX1zLrqQqIHevG+H6hlUjMf9/iJ2YY=', CAST(0x0000A558011A95CD AS DateTime), N'Baja', N'181979')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2824, 9, N'prTPKpz6vwvGWyBMK1yi/dJfxzb7D752lf9fxoIydbE=', CAST(0x0000A558011B17C6 AS DateTime), N'Baja', N'188878')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2825, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A558011B69F2 AS DateTime), N'Alta', N'329785')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2826, 9, N'F4JiVkdNDsixHwk7QMPR1mFCtW6ftjCoNRvkBoUgP93t1pudbu4MaU/6lqVA8orH', CAST(0x0000A558011B6D57 AS DateTime), N'Alta', N'320176')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2827, 9, N'F4JiVkdNDsixHwk7QMPR1lkZrDLuHJz3Vhz7MmttPfhpYs+5rEpHwP2aX0WPoc9z', CAST(0x0000A558011B70CE AS DateTime), N'Alta', N'324793')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2828, 9, N'FE2HCjTfVzdKVO8ngxErfRP0ccM3LX1SOT+ya6w7ab0=', CAST(0x0000A558011B8B65 AS DateTime), N'Alta', N'182433')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2829, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A558011B905D AS DateTime), N'Alta', N'329889')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2830, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A558011BAC89 AS DateTime), N'Baja', N'195025')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2831, 9, N'prTPKpz6vwvGWyBMK1yi/d07STQoB7UOIeb+BOypozk=', CAST(0x0000A558011BDF65 AS DateTime), N'Baja', N'187452')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2832, 9, N'prTPKpz6vwvGWyBMK1yi/d07STQoB7UOIeb+BOypozk=', CAST(0x0000A558011BEEC7 AS DateTime), N'Baja', N'187795')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2833, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558011E03B7 AS DateTime), N'Baja', N'89281')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2834, 9, N'JAiBDCk3mNu1HLX1zLrqQn/nBBiz8zdysX735CCZRm8=', CAST(0x0000A558011E93FA AS DateTime), N'Baja', N'183258')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2835, 9, N'prTPKpz6vwvGWyBMK1yi/cn2HmyMRHlOMXTvXUxJ4H4=', CAST(0x0000A558011F986C AS DateTime), N'Baja', N'185881')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2836, 9, N'prTPKpz6vwvGWyBMK1yi/cn2HmyMRHlOMXTvXUxJ4H4=', CAST(0x0000A558011FD8A0 AS DateTime), N'Baja', N'185542')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2837, 9, N'prTPKpz6vwvGWyBMK1yi/cn2HmyMRHlOMXTvXUxJ4H4=', CAST(0x0000A5580120099E AS DateTime), N'Baja', N'185950')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2838, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A55801202227 AS DateTime), N'Alta', N'330217')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2839, 9, N'FE2HCjTfVzdKVO8ngxErfRP0ccM3LX1SOT+ya6w7ab0=', CAST(0x0000A55801202683 AS DateTime), N'Alta', N'183233')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2840, 9, N'FE2HCjTfVzdKVO8ngxErffOd8oNEFnZ/ll7DDUTAMN8pCTz3t/U3dYnJdC5AVgDz', CAST(0x0000A55801202B4A AS DateTime), N'Alta', N'311409')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2841, 9, N'JAiBDCk3mNu1HLX1zLrqQkaLNzgZ4psVlnZB/9cfGkY=', CAST(0x0000A558012048C1 AS DateTime), N'Baja', N'188835')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2842, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580122336D AS DateTime), N'Baja', N'89836')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2843, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5580122B057 AS DateTime), N'Baja', N'86991')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2844, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801230B82 AS DateTime), N'Baja', N'90171')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2845, 9, N'prTPKpz6vwvGWyBMK1yi/c6ppx0cUrxOee80EiQBo0M=', CAST(0x0000A5580123261B AS DateTime), N'Baja', N'185651')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2846, 9, N'prTPKpz6vwvGWyBMK1yi/c6ppx0cUrxOee80EiQBo0M=', CAST(0x0000A558012331C8 AS DateTime), N'Baja', N'185722')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2847, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55801236712 AS DateTime), N'Baja', N'87120')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2848, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801249861 AS DateTime), N'Baja', N'89909')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2849, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801250960 AS DateTime), N'Baja', N'89954')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2850, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558012564A0 AS DateTime), N'Baja', N'89727')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2851, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A55801271F2B AS DateTime), N'Alta', N'185140')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2852, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A55801271F4A AS DateTime), N'Alta', N'184623')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2853, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558012823FB AS DateTime), N'Baja', N'89783')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2854, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A5580128439A AS DateTime), N'Baja', N'195626')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2855, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A55801287F44 AS DateTime), N'Baja', N'180554')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2856, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A55801288DB1 AS DateTime), N'Baja', N'180829')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2857, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A5580128A749 AS DateTime), N'Baja', N'179790')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2858, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A5580128B34E AS DateTime), N'Baja', N'179929')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2859, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A5580128BA3B AS DateTime), N'Baja', N'179728')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2860, 9, N'FE2HCjTfVzdKVO8ngxErfRP0ccM3LX1SOT+ya6w7ab0=', CAST(0x0000A558012905B4 AS DateTime), N'Alta', N'182618')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2861, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A5580129D2A1 AS DateTime), N'Baja', N'179891')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2862, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A5580129E183 AS DateTime), N'Baja', N'180166')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2863, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A5580129EB5E AS DateTime), N'Baja', N'180101')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2864, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012A01F1 AS DateTime), N'Baja', N'179834')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2865, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012A07E2 AS DateTime), N'Baja', N'180178')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2866, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012A1060 AS DateTime), N'Baja', N'180113')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2867, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A558012A35A5 AS DateTime), N'Alta', N'330232')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2868, 9, N'FE2HCjTfVzdKVO8ngxErfRP0ccM3LX1SOT+ya6w7ab0=', CAST(0x0000A558012A3B3C AS DateTime), N'Alta', N'183316')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2869, 9, N'FE2HCjTfVzdKVO8ngxErfQp6GoI3v7POprAr72Sw1P4=', CAST(0x0000A558012A413E AS DateTime), N'Alta', N'184250')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2870, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012A5168 AS DateTime), N'Baja', N'180430')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2871, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012A5A71 AS DateTime), N'Baja', N'180365')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2872, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012A8EDD AS DateTime), N'Baja', N'180027')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2873, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012AA979 AS DateTime), N'Baja', N'180301')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2874, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012AB3B1 AS DateTime), N'Baja', N'180304')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2875, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012AB9BA AS DateTime), N'Baja', N'180648')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2876, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012AC410 AS DateTime), N'Baja', N'180651')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2877, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012AC963 AS DateTime), N'Baja', N'180314')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2878, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012AD00A AS DateTime), N'Baja', N'180726')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2879, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012ADACE AS DateTime), N'Baja', N'180392')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2880, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012B008D AS DateTime), N'Baja', N'180764')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2881, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012B35AF AS DateTime), N'Baja', N'180426')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2882, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012B4C2F AS DateTime), N'Baja', N'180496')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2883, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012B546A AS DateTime), N'Baja', N'180976')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2884, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012BA89B AS DateTime), N'Baja', N'179712')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2885, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558012BC23E AS DateTime), N'Baja', N'179986')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2886, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558012DDC61 AS DateTime), N'Baja', N'89668')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2887, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A55801309DBD AS DateTime), N'Baja', N'180512')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2888, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A5580130A996 AS DateTime), N'Baja', N'180583')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2889, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A5580130BF8C AS DateTime), N'Baja', N'180653')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2890, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A5580130F125 AS DateTime), N'Baja', N'180101')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2891, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A55801310EEC AS DateTime), N'Baja', N'180034')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2892, 9, N'prTPKpz6vwvGWyBMK1yi/VEPaMnRZ+vzMEU+B50c+qI=', CAST(0x0000A558013123EC AS DateTime), N'Baja', N'180581')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2893, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55801312B03 AS DateTime), N'Baja', N'86783')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2894, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801314C2C AS DateTime), N'Baja', N'89580')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2895, 9, N'JAiBDCk3mNu1HLX1zLrqQtb0VK3TKqWW90hGyx/dPbI=', CAST(0x0000A55801315CDE AS DateTime), N'Baja', N'183904')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2896, 9, N'prTPKpz6vwvGWyBMK1yi/cGs5Bw4IVLpBHDj4ZbWuLc=', CAST(0x0000A558013165A8 AS DateTime), N'Baja', N'185740')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2897, 9, N'prTPKpz6vwvGWyBMK1yi/cGs5Bw4IVLpBHDj4ZbWuLc=', CAST(0x0000A558013169EF AS DateTime), N'Baja', N'185948')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2898, 9, N'prTPKpz6vwvGWyBMK1yi/cGs5Bw4IVLpBHDj4ZbWuLc=', CAST(0x0000A55801317540 AS DateTime), N'Baja', N'185682')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2899, 9, N'prTPKpz6vwvGWyBMK1yi/cGs5Bw4IVLpBHDj4ZbWuLc=', CAST(0x0000A55801317F68 AS DateTime), N'Baja', N'185617')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2900, 9, N'prTPKpz6vwvGWyBMK1yi/cGs5Bw4IVLpBHDj4ZbWuLc=', CAST(0x0000A558013190DB AS DateTime), N'Baja', N'185350')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2901, 9, N'JAiBDCk3mNu1HLX1zLrqQiUwZ/MEx1kQVFUohTybVIk=', CAST(0x0000A5580131E59F AS DateTime), N'Baja', N'189041')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2902, 9, N'prTPKpz6vwvGWyBMK1yi/VACvjwcOntP6tLMum2JvKc=', CAST(0x0000A55801320B82 AS DateTime), N'Baja', N'191064')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2903, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55801323EA8 AS DateTime), N'Baja', N'86746')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2904, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580134D8AA AS DateTime), N'Baja', N'89927')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2905, 9, N'JAiBDCk3mNu1HLX1zLrqQoqVrIIEMRUdE0nsdPv70cc=', CAST(0x0000A5580134F0EF AS DateTime), N'Baja', N'186860')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2906, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580135645F AS DateTime), N'Baja', N'89977')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2907, 9, N'JAiBDCk3mNu1HLX1zLrqQpc3FyuMjq2JBCJ6qneYI0I=', CAST(0x0000A5580135AAD2 AS DateTime), N'Baja', N'183911')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2908, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801379C29 AS DateTime), N'Baja', N'89746')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2909, 9, N'prTPKpz6vwvGWyBMK1yi/WQB3OZMfZIMfKMR9HnA2LQ=', CAST(0x0000A55801389D52 AS DateTime), N'Baja', N'180157')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2910, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A558013992C8 AS DateTime), N'Alta', N'184870')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2911, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A558013992E8 AS DateTime), N'Alta', N'184353')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2912, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580139EE50 AS DateTime), N'Baja', N'89887')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2913, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A558013A233B AS DateTime), N'Baja', N'194818')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2914, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A5580147A804 AS DateTime), N'Alta', N'185225')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2915, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580147B846 AS DateTime), N'Baja', N'89592')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2916, 9, N'JAiBDCk3mNu1HLX1zLrqQiHJ18RzOlzPQWUfmY0AI9Y=', CAST(0x0000A55801483961 AS DateTime), N'Baja', N'182993')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2917, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580149C38F AS DateTime), N'Baja', N'89338')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2918, 9, N'prTPKpz6vwvGWyBMK1yi/RIBOIcI8EGuIvpLe2Z2/rQ=', CAST(0x0000A558014BA30F AS DateTime), N'Baja', N'182095')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2919, 9, N'prTPKpz6vwvGWyBMK1yi/RIBOIcI8EGuIvpLe2Z2/rQ=', CAST(0x0000A558014BDC59 AS DateTime), N'Baja', N'182029')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2920, 9, N'prTPKpz6vwvGWyBMK1yi/RIBOIcI8EGuIvpLe2Z2/rQ=', CAST(0x0000A558014BE852 AS DateTime), N'Baja', N'182063')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2921, 9, N'prTPKpz6vwvGWyBMK1yi/RIBOIcI8EGuIvpLe2Z2/rQ=', CAST(0x0000A558014C03BB AS DateTime), N'Baja', N'182405')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2922, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A558014DBB1C AS DateTime), N'Alta', N'184644')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2923, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A558014DBB3D AS DateTime), N'Alta', N'184127')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2924, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558014DCADE AS DateTime), N'Baja', N'89504')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2925, 9, N'FE2HCjTfVzdKVO8ngxErfQp6GoI3v7POprAr72Sw1P4=', CAST(0x0000A558014DEB4E AS DateTime), N'Alta', N'183854')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2926, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558014E6B7D AS DateTime), N'Baja', N'89552')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2927, 9, N'Sg+S+pEybO2ZvfIjA0GX/f++sw1f11f/IGKH9xImuSQ=', CAST(0x0000A558014EA1F7 AS DateTime), N'Alta', N'179861')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2928, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558014EB01D AS DateTime), N'Baja', N'89509')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2929, 9, N'JAiBDCk3mNu1HLX1zLrqQocsiyTuOuPHqgfEVVYp+Tg=', CAST(0x0000A558014F3DBC AS DateTime), N'Baja', N'191159')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2930, 9, N'prTPKpz6vwvGWyBMK1yi/WP+YMZos4dcXZRDJdNsQrs=', CAST(0x0000A558014F4833 AS DateTime), N'Baja', N'189006')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2931, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801501CD0 AS DateTime), N'Baja', N'89398')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2932, 9, N'prTPKpz6vwvGWyBMK1yi/WP+YMZos4dcXZRDJdNsQrs=', CAST(0x0000A55801503B0A AS DateTime), N'Baja', N'188869')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2933, 9, N'prTPKpz6vwvGWyBMK1yi/WP+YMZos4dcXZRDJdNsQrs=', CAST(0x0000A55801508F8C AS DateTime), N'Baja', N'189141')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2934, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5580150C33D AS DateTime), N'Baja', N'86753')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2935, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A55801510141 AS DateTime), N'Alta', N'184942')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2936, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558015110AC AS DateTime), N'Baja', N'89409')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2937, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A55801518035 AS DateTime), N'Alta', N'330425')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2938, 9, N'FE2HCjTfVzdKVO8ngxErfRP0ccM3LX1SOT+ya6w7ab0=', CAST(0x0000A5580151867B AS DateTime), N'Alta', N'182856')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2939, 9, N'JAiBDCk3mNu1HLX1zLrqQmObCai6P7yvnvlLHDKFhR8=', CAST(0x0000A5580151A56D AS DateTime), N'Baja', N'186183')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2940, 9, N'prTPKpz6vwvGWyBMK1yi/aG1F+c9c/eG75vDcdFDxvI=', CAST(0x0000A5580151B0B6 AS DateTime), N'Baja', N'182515')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2941, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801553679 AS DateTime), N'Baja', N'89543')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2942, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580156DD0E AS DateTime), N'Baja', N'89817')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2943, 9, N'prTPKpz6vwvGWyBMK1yi/aG1F+c9c/eG75vDcdFDxvI=', CAST(0x0000A5580156F22F AS DateTime), N'Baja', N'182521')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2944, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801571BF9 AS DateTime), N'Baja', N'89582')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2945, 9, N'prTPKpz6vwvGWyBMK1yi/aG1F+c9c/eG75vDcdFDxvI=', CAST(0x0000A55801572D04 AS DateTime), N'Baja', N'182527')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2946, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801574740 AS DateTime), N'Baja', N'89634')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2947, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A5580157A80D AS DateTime), N'Alta', N'184597')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2948, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A5580157A82D AS DateTime), N'Alta', N'184148')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2949, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580157B6C9 AS DateTime), N'Baja', N'89429')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2950, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A5580157CB70 AS DateTime), N'Baja', N'194443')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2951, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580157F1D1 AS DateTime), N'Baja', N'89398')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2952, 9, N'prTPKpz6vwvGWyBMK1yi/WlRjy3LVxfY0lY7GSTrkr8=', CAST(0x0000A5580157FD94 AS DateTime), N'Baja', N'188481')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2953, 9, N'prTPKpz6vwvGWyBMK1yi/WlRjy3LVxfY0lY7GSTrkr8=', CAST(0x0000A55801581189 AS DateTime), N'Baja', N'188415')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2954, 9, N'prTPKpz6vwvGWyBMK1yi/WlRjy3LVxfY0lY7GSTrkr8=', CAST(0x0000A55801581DAA AS DateTime), N'Baja', N'188554')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2955, 9, N'prTPKpz6vwvGWyBMK1yi/WlRjy3LVxfY0lY7GSTrkr8=', CAST(0x0000A55801582F1B AS DateTime), N'Baja', N'188628')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2956, 9, N'prTPKpz6vwvGWyBMK1yi/WlRjy3LVxfY0lY7GSTrkr8=', CAST(0x0000A5580158468E AS DateTime), N'Baja', N'188766')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2957, 9, N'prTPKpz6vwvGWyBMK1yi/WlRjy3LVxfY0lY7GSTrkr8=', CAST(0x0000A55801586625 AS DateTime), N'Baja', N'188767')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2958, 9, N'prTPKpz6vwvGWyBMK1yi/WlRjy3LVxfY0lY7GSTrkr8=', CAST(0x0000A558015873E7 AS DateTime), N'Baja', N'188569')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2959, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A5580158BEC3 AS DateTime), N'Alta', N'184211')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2960, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580158CE1D AS DateTime), N'Baja', N'89483')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2961, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A5580158F526 AS DateTime), N'Baja', N'195049')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2962, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A558015936C5 AS DateTime), N'Alta', N'185244')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2963, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A558015936E4 AS DateTime), N'Alta', N'184727')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2964, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580159465B AS DateTime), N'Baja', N'89639')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2965, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558015A6EF0 AS DateTime), N'Baja', N'89386')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2966, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A558015AB405 AS DateTime), N'Alta', N'329573')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2967, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A558015BA73D AS DateTime), N'Baja', N'194680')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2968, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A558015C3AC9 AS DateTime), N'Alta', N'184939')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2969, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A558015C3AEB AS DateTime), N'Alta', N'184490')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2970, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558015C4B21 AS DateTime), N'Baja', N'89445')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2971, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A558015C6B88 AS DateTime), N'Baja', N'194583')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2972, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558015CBC4F AS DateTime), N'Baja', N'89542')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2973, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A558015CE633 AS DateTime), N'Baja', N'194341')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2974, 9, N'prTPKpz6vwvGWyBMK1yi/d07STQoB7UOIeb+BOypozk=', CAST(0x0000A558015D233F AS DateTime), N'Baja', N'186767')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2975, 9, N'JAiBDCk3mNu1HLX1zLrqQiSUH1ZMvvPfi+mWff/A0Zk=', CAST(0x0000A558015DF325 AS DateTime), N'Baja', N'184535')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2976, 9, N'prTPKpz6vwvGWyBMK1yi/QdfZCaSoclvEA18bQqNepk=', CAST(0x0000A558015DFDF6 AS DateTime), N'Baja', N'189931')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2977, 9, N'prTPKpz6vwvGWyBMK1yi/QdfZCaSoclvEA18bQqNepk=', CAST(0x0000A558015E079C AS DateTime), N'Baja', N'189934')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2978, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558015E9D4B AS DateTime), N'Baja', N'89428')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2979, 9, N'JAiBDCk3mNu1HLX1zLrqQl1s9IuOouumKJoj+3ilIpc=', CAST(0x0000A558015EC091 AS DateTime), N'Baja', N'189491')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2980, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558015F1FF8 AS DateTime), N'Baja', N'89538')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2981, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A558015F441F AS DateTime), N'Baja', N'87031')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2982, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580161E501 AS DateTime), N'Baja', N'89830')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2983, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A55801621DD0 AS DateTime), N'Baja', N'189492')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2984, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A55801625148 AS DateTime), N'Baja', N'188500')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2985, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A5580162FBFF AS DateTime), N'Baja', N'189176')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2986, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A558016349BE AS DateTime), N'Baja', N'189040')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2987, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55801634D7A AS DateTime), N'Baja', N'86920')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2988, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A5580164A0CC AS DateTime), N'Alta', N'180311')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2989, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A5580164A0EC AS DateTime), N'Alta', N'180315')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2990, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580164B444 AS DateTime), N'Baja', N'89675')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2991, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A55801656638 AS DateTime), N'Baja', N'188959')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2992, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55801683069 AS DateTime), N'Alta', N'179827')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2993, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A5580168308A AS DateTime), N'Alta', N'179831')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2994, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A558016830A7 AS DateTime), N'Alta', N'179835')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2995, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801684189 AS DateTime), N'Baja', N'89709')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2996, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A55801687DDF AS DateTime), N'Baja', N'188902')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2997, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A55801698687 AS DateTime), N'Baja', N'189440')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2998, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A5580169C4B2 AS DateTime), N'Baja', N'189646')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (2999, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5580169C953 AS DateTime), N'Baja', N'86913')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3000, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A558016A6579 AS DateTime), N'Alta', N'180431')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3001, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A558016A659A AS DateTime), N'Alta', N'180435')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3002, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A558016A65B7 AS DateTime), N'Alta', N'180439')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3003, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558016A75C8 AS DateTime), N'Baja', N'89632')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3004, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A558016AD056 AS DateTime), N'Baja', N'189072')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3005, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A558016B60B1 AS DateTime), N'Baja', N'188528')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3006, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A558016BDF9B AS DateTime), N'Baja', N'189409')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3007, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A558016C66A1 AS DateTime), N'Baja', N'86827')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3008, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A558016D2036 AS DateTime), N'Alta', N'179933')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3009, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A558016D205C AS DateTime), N'Alta', N'180005')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3010, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A558016D207C AS DateTime), N'Alta', N'179972')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3011, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558016D33FF AS DateTime), N'Baja', N'89834')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3012, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A558016D7E8F AS DateTime), N'Baja', N'188792')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3013, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A558016D9E5C AS DateTime), N'Baja', N'188456')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3014, 9, N'prTPKpz6vwvGWyBMK1yi/cZjiWr8w50eh1JDMuariiM=', CAST(0x0000A558016DAB6D AS DateTime), N'Baja', N'188595')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3015, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558016EC22F AS DateTime), N'Baja', N'89620')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3016, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A558016EEFA4 AS DateTime), N'Baja', N'194973')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3017, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A558016F65C9 AS DateTime), N'Alta', N'185439')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3018, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558016F84A9 AS DateTime), N'Baja', N'89528')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3019, 9, N'JAiBDCk3mNu1HLX1zLrqQm/YeTjuxdTpzTMbCuUrcpY=', CAST(0x0000A558016FA6C3 AS DateTime), N'Baja', N'194774')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3020, 9, N'prTPKpz6vwvGWyBMK1yi/b0pHy3ws4ahwOp346CbLJE=', CAST(0x0000A558016FD780 AS DateTime), N'Baja', N'183766')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3021, 9, N'prTPKpz6vwvGWyBMK1yi/b0pHy3ws4ahwOp346CbLJE=', CAST(0x0000A558016FE2EA AS DateTime), N'Baja', N'183837')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3022, 9, N'prTPKpz6vwvGWyBMK1yi/b0pHy3ws4ahwOp346CbLJE=', CAST(0x0000A558016FFE47 AS DateTime), N'Baja', N'184179')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3023, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A558017061D6 AS DateTime), N'Alta', N'184105')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3024, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558017080FF AS DateTime), N'Baja', N'89192')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3025, 9, N'JAiBDCk3mNu1HLX1zLrqQsMVV/QMBfCQqcMmUL9j944=', CAST(0x0000A55801709A73 AS DateTime), N'Baja', N'179338')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3026, 9, N'prTPKpz6vwvGWyBMK1yi/fsocUfp8MMWpaN6hTLJR+c=', CAST(0x0000A5580170A3AB AS DateTime), N'Baja', N'185809')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3027, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4i5EPUAYJBEiMLhyJaktcEp', CAST(0x0000A5580170C623 AS DateTime), N'Alta', N'320499')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3028, 9, N'JAiBDCk3mNu1HLX1zLrqQnTdjR1lW4JGtKVNS27hKlk=', CAST(0x0000A5580170F3EC AS DateTime), N'Baja', N'183874')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3029, 9, N'prTPKpz6vwvGWyBMK1yi/fRFC9Oi8lsy8hMcw+AeoMA=', CAST(0x0000A5580170FCBB AS DateTime), N'Baja', N'186012')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3030, 9, N'prTPKpz6vwvGWyBMK1yi/fRFC9Oi8lsy8hMcw+AeoMA=', CAST(0x0000A558017108B6 AS DateTime), N'Baja', N'186046')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3031, 9, N'prTPKpz6vwvGWyBMK1yi/fRFC9Oi8lsy8hMcw+AeoMA=', CAST(0x0000A5580171D37F AS DateTime), N'Baja', N'186382')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3032, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A5580172656A AS DateTime), N'Alta', N'184693')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3033, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801728A02 AS DateTime), N'Baja', N'89603')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3034, 9, N'FE2HCjTfVzdKVO8ngxErfZGZwVglMfbF/yiHlB7XM4gDUVgaSwXUTxvJluAcSqpQ', CAST(0x0000A5580172D73E AS DateTime), N'Alta', N'329087')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3035, 9, N'JAiBDCk3mNu1HLX1zLrqQl9Ok2gxc9q29yOEfNHUB1M=', CAST(0x0000A55801733BD7 AS DateTime), N'Baja', N'180989')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3036, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A55801734A38 AS DateTime), N'Baja', N'191825')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3037, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580173A216 AS DateTime), N'Baja', N'191351')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3038, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580173AE22 AS DateTime), N'Baja', N'191422')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3039, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580173C02C AS DateTime), N'Baja', N'191288')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3040, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580173CC00 AS DateTime), N'Baja', N'191322')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3041, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580173E281 AS DateTime), N'Baja', N'192005')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3042, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580173EBB5 AS DateTime), N'Baja', N'191603')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3043, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580173F354 AS DateTime), N'Baja', N'191402')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3044, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A55801740299 AS DateTime), N'Baja', N'191677')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3045, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A55801740B70 AS DateTime), N'Baja', N'191612')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3046, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A558017410B7 AS DateTime), N'Baja', N'191888')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3047, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580176157D AS DateTime), N'Baja', N'191963')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3048, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580176BEA0 AS DateTime), N'Baja', N'89535')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3049, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801778AE8 AS DateTime), N'Baja', N'89819')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3050, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A558017796EE AS DateTime), N'Baja', N'192059')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3051, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580177A32A AS DateTime), N'Baja', N'192198')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3052, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580177B09C AS DateTime), N'Baja', N'191724')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3053, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580177C19A AS DateTime), N'Baja', N'191798')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3054, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580177C8B4 AS DateTime), N'Baja', N'191597')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3055, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580177D280 AS DateTime), N'Baja', N'192145')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3056, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580177DDFF AS DateTime), N'Baja', N'192216')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3057, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580177E4BD AS DateTime), N'Baja', N'192015')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3058, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580177EB97 AS DateTime), N'Baja', N'191814')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3059, 9, N'prTPKpz6vwvGWyBMK1yi/asU01TaNxTRrWlzUeHatJc=', CAST(0x0000A5580177F71A AS DateTime), N'Baja', N'191817')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3060, 9, N'ZvG1HFcshV6lZ7CXUNlY1Gw+nziYtCxDYnN7qh2D21c=', CAST(0x0000A5580178B1D4 AS DateTime), N'Alta', N'184159')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3061, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580178D9F2 AS DateTime), N'Baja', N'89373')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3062, 9, N'JAiBDCk3mNu1HLX1zLrqQrY8itdtuzsChl5gxRqEKpc=', CAST(0x0000A5580179127E AS DateTime), N'Baja', N'194786')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3063, 9, N'prTPKpz6vwvGWyBMK1yi/cS5quy/9G8+MA5jhyPqkI4=', CAST(0x0000A558017918E9 AS DateTime), N'Baja', N'183849')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3064, 9, N'prTPKpz6vwvGWyBMK1yi/cS5quy/9G8+MA5jhyPqkI4=', CAST(0x0000A55801792DA5 AS DateTime), N'Baja', N'183446')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3065, 9, N'prTPKpz6vwvGWyBMK1yi/cS5quy/9G8+MA5jhyPqkI4=', CAST(0x0000A55801793866 AS DateTime), N'Baja', N'183517')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3066, 9, N'prTPKpz6vwvGWyBMK1yi/cS5quy/9G8+MA5jhyPqkI4=', CAST(0x0000A55801794753 AS DateTime), N'Baja', N'183724')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3067, 9, N'prTPKpz6vwvGWyBMK1yi/cS5quy/9G8+MA5jhyPqkI4=', CAST(0x0000A55801794BB4 AS DateTime), N'Baja', N'183387')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3068, 9, N'prTPKpz6vwvGWyBMK1yi/cS5quy/9G8+MA5jhyPqkI4=', CAST(0x0000A558017956FD AS DateTime), N'Baja', N'183458')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3069, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55801796A46 AS DateTime), N'Baja', N'86939')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3070, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580180E5D4 AS DateTime), N'Baja', N'89235')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3071, 9, N'JAiBDCk3mNu1HLX1zLrqQqQ/XRYq1t5zAw7HgDzMq/I=', CAST(0x0000A558018169D8 AS DateTime), N'Baja', N'183983')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3072, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55801816D62 AS DateTime), N'Baja', N'186088')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3073, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55801817B77 AS DateTime), N'Baja', N'186295')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3074, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A5580181835A AS DateTime), N'Baja', N'186162')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3075, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55801818713 AS DateTime), N'Baja', N'186370')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3076, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801823822 AS DateTime), N'Baja', N'89341')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3077, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB2OEBx26zUfq/6CCGeZx/PGc6oGwN4V1AWEIskma95hf', CAST(0x0000A5580183E177 AS DateTime), N'Media', N'315488')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3078, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580183F134 AS DateTime), N'Baja', N'89596')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3079, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55801857803 AS DateTime), N'Baja', N'89440')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3080, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580186ADCD AS DateTime), N'Baja', N'89515')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3081, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55801870D4E AS DateTime), N'Baja', N'87006')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3082, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5580189C5DD AS DateTime), N'Baja', N'89514')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3083, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5580189CD3D AS DateTime), N'Baja', N'87106')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3084, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A558018A3E30 AS DateTime), N'Baja', N'89614')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3085, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A558018A622F AS DateTime), N'Baja', N'87107')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3086, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A559000056EF AS DateTime), N'Baja', N'86350')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3087, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55900008A5B AS DateTime), N'Baja', N'84026')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3088, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A559007AC163 AS DateTime), N'Baja', N'87229')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3089, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A559007AEC58 AS DateTime), N'Baja', N'84297')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3090, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A559007AFF51 AS DateTime), N'Baja', N'87339')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3091, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A559007BBAD4 AS DateTime), N'Baja', N'86986')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3092, 9, N'ZvG1HFcshV6lZ7CXUNlY1FW0A1jQfUh0aSksU7uhKiA=', CAST(0x0000A559009B0FD8 AS DateTime), N'Alta', N'181576')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3093, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A559009C89A6 AS DateTime), N'Baja', N'87426')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3094, 9, N'uDkgXNw+7CHUFvWnn33LNaFiVsmXrwZoO31hdD8HGos=', CAST(0x0000A559009D7178 AS DateTime), N'Alta', N'184465')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3095, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK4ULsr9ezpT8YoDSdghw2NqIy9mya+/zC3k01c0n8TkQQ==', CAST(0x0000A559009D7917 AS DateTime), N'Alta', N'505559')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3096, 9, N'92xR8E9lVFvZ+l193m52qLcRpEHJ/KDzbnv6Q+vsx8Q=', CAST(0x0000A559009DC060 AS DateTime), N'Media', N'187016')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3097, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A559009E13EA AS DateTime), N'Baja', N'84329')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3098, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55900A0E02C AS DateTime), N'Baja', N'87169')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3099, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55900A1764E AS DateTime), N'Baja', N'84513')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3100, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55900A73475 AS DateTime), N'Baja', N'89593')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3101, 9, N'AguINniBEFNkqkZBzpMOOMTBAvk8pDwcMF/H+isAYyE=', CAST(0x0000A55900A7E641 AS DateTime), N'Alta', N'186217')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3102, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55900A8860D AS DateTime), N'Baja', N'86577')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3103, 9, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A55900B96686 AS DateTime), N'Alta', N'181457')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3104, 9, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A55900B96F2E AS DateTime), N'Alta', N'191683')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3105, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55900B98403 AS DateTime), N'Baja', N'89470')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3106, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55900B9D8D1 AS DateTime), N'Baja', N'86962')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3107, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55900BEC63B AS DateTime), N'Baja', N'89520')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3108, 9, N'JAiBDCk3mNu1HLX1zLrqQr9sBd9HzbNaf68zsuaYa5k=', CAST(0x0000A55900BF89C6 AS DateTime), N'Baja', N'188978')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3109, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55900C07289 AS DateTime), N'Baja', N'86499')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3110, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55900F255DE AS DateTime), N'Baja', N'89625')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3111, 9, N'Cmo9YO7/eY/bZXLNNGaXDpoN0+PZ2gyas9LdSuzN06Q=', CAST(0x0000A55900F46AFE AS DateTime), N'Alta', N'184143')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3112, 9, N'Cmo9YO7/eY/bZXLNNGaXDqC7tHC3T8pwV+MgPh+0nAg=', CAST(0x0000A55900F49161 AS DateTime), N'Alta', N'180423')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3113, 9, N'Y8egU4o66/wzYk4FPETZ+4dQRDi46rG7ZVPpLKicNBo=', CAST(0x0000A55900F498CD AS DateTime), N'Alta', N'182051')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3114, 9, N'Y8egU4o66/wzYk4FPETZ+3ot0yC1btBh+URopSttGKk=', CAST(0x0000A55900F4BB57 AS DateTime), N'Alta', N'186882')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3115, 9, N'Cmo9YO7/eY/bZXLNNGaXDjaEht79bGCFycsq07nSDYE=', CAST(0x0000A55900F5C5D0 AS DateTime), N'Alta', N'184556')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3116, 9, N'Y8egU4o66/wzYk4FPETZ+4dQRDi46rG7ZVPpLKicNBo=', CAST(0x0000A55900F6CFBF AS DateTime), N'Alta', N'182787')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3117, 9, N'Cmo9YO7/eY/bZXLNNGaXDurTvz7Wds2biLB6iuJZbTE=', CAST(0x0000A55900F9C281 AS DateTime), N'Alta', N'187773')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3118, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55900FEFCC6 AS DateTime), N'Baja', N'86940')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3119, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5590116FF62 AS DateTime), N'Baja', N'90017')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3120, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A559011A4FF0 AS DateTime), N'Alta', N'182968')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3121, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A559011A5C73 AS DateTime), N'Alta', N'182702')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3122, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A559011A5DF6 AS DateTime), N'Alta', N'182842')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3123, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A559011A6429 AS DateTime), N'Alta', N'183186')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3124, 9, N'VPKIonfX6HMAjouizTOhQ7eQ3SeiqrfsCkoW2VQKiNE=', CAST(0x0000A559011A674D AS DateTime), N'Alta', N'190518')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3125, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A559011C4B09 AS DateTime), N'Baja', N'86838')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3126, 9, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A559011F521D AS DateTime), N'Alta', N'182316')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3127, 9, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A559011F5B5B AS DateTime), N'Alta', N'191997')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3128, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A559011F718A AS DateTime), N'Baja', N'89684')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3129, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5590120286D AS DateTime), N'Baja', N'90018')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3130, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55901204276 AS DateTime), N'Baja', N'87042')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3131, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55901224BBE AS DateTime), N'Baja', N'89989')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3132, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55901225E1F AS DateTime), N'Baja', N'86910')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3133, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55901229233 AS DateTime), N'Baja', N'90042')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3134, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5590122A01C AS DateTime), N'Baja', N'87252')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3135, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5590122C407 AS DateTime), N'Baja', N'90097')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3136, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A559012324B7 AS DateTime), N'Baja', N'86608')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3137, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55901248277 AS DateTime), N'Baja', N'90111')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3138, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A559012497DC AS DateTime), N'Baja', N'87176')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3139, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5590124BB59 AS DateTime), N'Baja', N'90069')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3140, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5590124DCE4 AS DateTime), N'Baja', N'87144')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3141, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A559012532E3 AS DateTime), N'Baja', N'89699')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3142, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55901256127 AS DateTime), N'Baja', N'87339')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3143, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55901260BBE AS DateTime), N'Baja', N'89676')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3144, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55901262770 AS DateTime), N'Baja', N'87218')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3145, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55901266161 AS DateTime), N'Baja', N'89920')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3146, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5590126C5C1 AS DateTime), N'Baja', N'86981')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3147, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5590126EF70 AS DateTime), N'Baja', N'90066')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3148, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5590127056B AS DateTime), N'Baja', N'87179')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3149, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A5590127A3AE AS DateTime), N'Baja', N'89827')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3150, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A5590127B275 AS DateTime), N'Baja', N'87285')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3151, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A559012A1EDF AS DateTime), N'Baja', N'89671')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3152, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A559012A45BD AS DateTime), N'Baja', N'87260')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3153, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0137C2A3 AS DateTime), N'Baja', N'89929')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3154, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D013BC87F AS DateTime), N'Baja', N'90027')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3155, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55D013BE2BB AS DateTime), N'Baja', N'186268')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3156, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55D013BED1C AS DateTime), N'Baja', N'186271')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3157, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55D013BF333 AS DateTime), N'Baja', N'186002')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3158, 9, N'prTPKpz6vwvGWyBMK1yi/c6//MzQuTSnaql0FL+fsJ8=', CAST(0x0000A55D013BFAE1 AS DateTime), N'Baja', N'184242')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3159, 9, N'prTPKpz6vwvGWyBMK1yi/c6//MzQuTSnaql0FL+fsJ8=', CAST(0x0000A55D013C01A5 AS DateTime), N'Baja', N'184041')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3160, 9, N'prTPKpz6vwvGWyBMK1yi/c6//MzQuTSnaql0FL+fsJ8=', CAST(0x0000A55D013C0544 AS DateTime), N'Baja', N'184212')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3161, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D013C4CD6 AS DateTime), N'Baja', N'87099')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3162, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55D013F1C98 AS DateTime), N'Alta', N'180298')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3163, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D013F386F AS DateTime), N'Baja', N'89706')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3164, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D013F43E1 AS DateTime), N'Baja', N'87057')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3165, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D013FE9BE AS DateTime), N'Baja', N'90041')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3166, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0141028B AS DateTime), N'Baja', N'90177')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3167, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB6WYW8wcUbzMloWoI4z6USE=', CAST(0x0000A55D0141B018 AS DateTime), N'Media', N'193763')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3168, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0141C004 AS DateTime), N'Baja', N'89916')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3169, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01423BBF AS DateTime), N'Baja', N'89723')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3170, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D014247F1 AS DateTime), N'Baja', N'87085')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3171, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01425FC8 AS DateTime), N'Baja', N'89883')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3172, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB8bVtR7EhiV/hm1cWhlFoSjZlX4KRVmlA/5xKFt2xkdE', CAST(0x0000A55D014539B5 AS DateTime), N'Media', N'326771')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3173, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01454A45 AS DateTime), N'Baja', N'89742')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3174, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D01456384 AS DateTime), N'Baja', N'87236')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3175, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB8bVtR7EhiV/hm1cWhlFoSjZlX4KRVmlA/5xKFt2xkdE', CAST(0x0000A55D01466598 AS DateTime), N'Media', N'326945')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3176, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D014674AD AS DateTime), N'Baja', N'90221')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3177, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D0146BC8F AS DateTime), N'Baja', N'87618')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3178, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01487180 AS DateTime), N'Baja', N'90377')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3179, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D0148A7F1 AS DateTime), N'Baja', N'87535')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3180, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D014F8FE5 AS DateTime), N'Baja', N'89459')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3181, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D014FC969 AS DateTime), N'Baja', N'86713')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3182, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01509926 AS DateTime), N'Baja', N'89456')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3183, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D0150C40E AS DateTime), N'Baja', N'86952')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3184, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01514ADD AS DateTime), N'Baja', N'89506')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3185, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D01515EF0 AS DateTime), N'Baja', N'87193')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3186, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0151D8C0 AS DateTime), N'Baja', N'89246')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3187, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D01536764 AS DateTime), N'Baja', N'86963')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3188, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D015385BD AS DateTime), N'Baja', N'89812')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3189, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D015398E5 AS DateTime), N'Baja', N'87066')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3190, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01547FD8 AS DateTime), N'Baja', N'89818')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3191, 9, N'cgoGwnWuzttKXvag9Z5UzxWIFUuc0vS1jAO7r9ETj8WWw0HsdW9UOT8/l5wtMp5T', CAST(0x0000A55D0154A4AC AS DateTime), N'Alta', N'314134')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3192, 9, N'cgoGwnWuzttKXvag9Z5UzxWIFUuc0vS1jAO7r9ETj8V1plSMliaRTSKlkGRNmAt+', CAST(0x0000A55D0154B684 AS DateTime), N'Alta', N'319258')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3193, 9, N'cgoGwnWuzttKXvag9Z5UzxWIFUuc0vS1jAO7r9ETj8WM/d1IjQHLZxrxUN7F1C5V', CAST(0x0000A55D0154CA04 AS DateTime), N'Alta', N'309073')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3194, 9, N'cgoGwnWuzttKXvag9Z5UzxWIFUuc0vS1jAO7r9ETj8VntLQudM87piTATdsjWzjp', CAST(0x0000A55D0154DAEE AS DateTime), N'Alta', N'327771')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3195, 9, N'cgoGwnWuzttKXvag9Z5UzxWIFUuc0vS1jAO7r9ETj8VpgCNdYL6tEATqmQIKJPKd', CAST(0x0000A55D0154F1BE AS DateTime), N'Alta', N'315713')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3196, 9, N'cgoGwnWuzttKXvag9Z5UzxWIFUuc0vS1jAO7r9ETj8UypljJzhsCgHdNwnaoeOC2', CAST(0x0000A55D0154FB9D AS DateTime), N'Alta', N'328632')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3197, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D01550ED0 AS DateTime), N'Baja', N'86926')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3198, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0155C052 AS DateTime), N'Baja', N'89672')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3199, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55D015608BE AS DateTime), N'Baja', N'186519')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3200, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55D0156124C AS DateTime), N'Baja', N'186389')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3201, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55D01561D6E AS DateTime), N'Baja', N'186460')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3202, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55D01563679 AS DateTime), N'Baja', N'186666')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3203, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D0156747D AS DateTime), N'Baja', N'86917')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3204, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55D015EDF9A AS DateTime), N'Alta', N'180524')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3205, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55D015EDFBB AS DateTime), N'Alta', N'180528')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3206, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55D015EDFDB AS DateTime), N'Alta', N'180532')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3207, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55D015EDFFC AS DateTime), N'Alta', N'180536')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3208, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D015EF9DA AS DateTime), N'Baja', N'89640')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3209, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D015F3D7A AS DateTime), N'Baja', N'87326')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3210, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D015F870D AS DateTime), N'Baja', N'89749')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3211, 9, N'JAiBDCk3mNu1HLX1zLrqQlNVDMiElxdi8nSozMqqFHg=', CAST(0x0000A55D015FA182 AS DateTime), N'Baja', N'191403')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3212, 9, N'prTPKpz6vwvGWyBMK1yi/aFCPyxWSsRJkI7Dbqs1tgw=', CAST(0x0000A55D015FAADD AS DateTime), N'Baja', N'191091')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3213, 9, N'prTPKpz6vwvGWyBMK1yi/aFCPyxWSsRJkI7Dbqs1tgw=', CAST(0x0000A55D015FADCD AS DateTime), N'Baja', N'191299')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3214, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0163509A AS DateTime), N'Baja', N'89825')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3215, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01639618 AS DateTime), N'Baja', N'89874')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3216, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A55D01653BDC AS DateTime), N'Media', N'331927')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3217, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D016547D1 AS DateTime), N'Baja', N'89793')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3218, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0165BEA5 AS DateTime), N'Baja', N'89408')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3219, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01685E3A AS DateTime), N'Baja', N'89459')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3220, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D01707755 AS DateTime), N'Baja', N'86684')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3221, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D01711872 AS DateTime), N'Baja', N'89476')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3222, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0175B134 AS DateTime), N'Baja', N'89531')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3223, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D0175D0FE AS DateTime), N'Baja', N'86595')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3224, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0176C33D AS DateTime), N'Baja', N'89864')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3225, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D0176D18D AS DateTime), N'Baja', N'86878')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3226, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0178481E AS DateTime), N'Baja', N'90286')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3227, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D0178554C AS DateTime), N'Baja', N'86657')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3228, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0179C63B AS DateTime), N'Baja', N'89873')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3229, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D0179D0A4 AS DateTime), N'Baja', N'87128')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3230, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D0179EABE AS DateTime), N'Baja', N'90033')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3231, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D0179F84D AS DateTime), N'Baja', N'87195')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3232, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D017A45A3 AS DateTime), N'Baja', N'89799')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3233, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D017A5DD6 AS DateTime), N'Baja', N'87245')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3234, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D017A94A7 AS DateTime), N'Baja', N'89803')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3235, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D017AA215 AS DateTime), N'Baja', N'87202')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3236, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55D017C525D AS DateTime), N'Baja', N'89547')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3237, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55D017C7405 AS DateTime), N'Baja', N'86707')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3238, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00B58DAF AS DateTime), N'Baja', N'89042')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3239, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55E00B61769 AS DateTime), N'Baja', N'87010')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3240, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00B8E251 AS DateTime), N'Baja', N'89531')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3241, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00B9C5D6 AS DateTime), N'Baja', N'89476')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3242, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00BB7D76 AS DateTime), N'Baja', N'89631')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3243, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00BC08BC AS DateTime), N'Baja', N'89677')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3244, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55E00BC2895 AS DateTime), N'Baja', N'86741')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3245, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00BDACFB AS DateTime), N'Baja', N'89501')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3246, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00BE45E4 AS DateTime), N'Baja', N'89642')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3247, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00C00355 AS DateTime), N'Baja', N'89773')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3248, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55E00C06C0A AS DateTime), N'Baja', N'186159')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3249, 9, N'prTPKpz6vwvGWyBMK1yi/TP54eEmCLynf/r4h9/wLgw=', CAST(0x0000A55E00C07078 AS DateTime), N'Baja', N'186435')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3250, 9, N'prTPKpz6vwvGWyBMK1yi/aFCPyxWSsRJkI7Dbqs1tgw=', CAST(0x0000A55E00C086CB AS DateTime), N'Baja', N'191822')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3251, 9, N'prTPKpz6vwvGWyBMK1yi/aFCPyxWSsRJkI7Dbqs1tgw=', CAST(0x0000A55E00C09052 AS DateTime), N'Baja', N'191420')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3252, 9, N'prTPKpz6vwvGWyBMK1yi/aFCPyxWSsRJkI7Dbqs1tgw=', CAST(0x0000A55E00C0B32B AS DateTime), N'Baja', N'191557')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3253, 9, N'prTPKpz6vwvGWyBMK1yi/aFCPyxWSsRJkI7Dbqs1tgw=', CAST(0x0000A55E00C0BB2E AS DateTime), N'Baja', N'191424')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3254, 9, N'prTPKpz6vwvGWyBMK1yi/aFCPyxWSsRJkI7Dbqs1tgw=', CAST(0x0000A55E00C0BEA0 AS DateTime), N'Baja', N'191632')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3255, 9, N'prTPKpz6vwvGWyBMK1yi/aFCPyxWSsRJkI7Dbqs1tgw=', CAST(0x0000A55E00C0C510 AS DateTime), N'Baja', N'191431')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3256, 9, N'prTPKpz6vwvGWyBMK1yi/c6//MzQuTSnaql0FL+fsJ8=', CAST(0x0000A55E00C0D4BD AS DateTime), N'Baja', N'183843')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3257, 9, N'prTPKpz6vwvGWyBMK1yi/c6//MzQuTSnaql0FL+fsJ8=', CAST(0x0000A55E00C0DD00 AS DateTime), N'Baja', N'183710')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3258, 9, N'prTPKpz6vwvGWyBMK1yi/c6//MzQuTSnaql0FL+fsJ8=', CAST(0x0000A55E00C0E2DA AS DateTime), N'Baja', N'184054')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3259, 9, N'JAiBDCk3mNu1HLX1zLrqQuL2wkeTS+xlDh61yRuNisE=', CAST(0x0000A55E00C0FAC5 AS DateTime), N'Baja', N'188582')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3260, 9, N'prTPKpz6vwvGWyBMK1yi/TVPjIOuYZ5ZVIK/iiaOnp8=', CAST(0x0000A55E00C126CF AS DateTime), N'Baja', N'186573')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3261, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55E00C15765 AS DateTime), N'Baja', N'87112')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3262, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55E00C2F1FD AS DateTime), N'Alta', N'180776')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3263, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55E00C2F22C AS DateTime), N'Alta', N'180780')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3264, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55E00C2F25F AS DateTime), N'Alta', N'180784')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3265, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55E00C2F289 AS DateTime), N'Alta', N'180788')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3266, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55E00C2F2CB AS DateTime), N'Alta', N'180860')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3267, 9, N'Sg+S+pEybO2ZvfIjA0GX/XV7OBmo76WH0EHyjAFyaK8=', CAST(0x0000A55E00C2F2F0 AS DateTime), N'Alta', N'180864')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3268, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00C31ACB AS DateTime), N'Baja', N'89368')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3269, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55E00C36DD0 AS DateTime), N'Baja', N'86812')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3270, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00C66A6F AS DateTime), N'Baja', N'89395')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3271, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55E00C68667 AS DateTime), N'Baja', N'86985')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3272, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00C751EE AS DateTime), N'Baja', N'89536')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3273, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55E00C77100 AS DateTime), N'Baja', N'86985')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3274, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00C92035 AS DateTime), N'Baja', N'89504')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3275, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55E00C9616A AS DateTime), N'Baja', N'86661')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3276, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00CBE524 AS DateTime), N'Baja', N'89363')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3277, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55E00CBFB4C AS DateTime), N'Baja', N'86713')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3278, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55E00CC34B7 AS DateTime), N'Baja', N'89800')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3279, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55E00CC50B9 AS DateTime), N'Baja', N'86957')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3280, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F00F82140 AS DateTime), N'Baja', N'89600')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3281, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F00FE1785 AS DateTime), N'Baja', N'89832')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3282, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55F00FE42BF AS DateTime), N'Baja', N'87180')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3283, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F0100B4D6 AS DateTime), N'Baja', N'90028')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3284, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55F0100D727 AS DateTime), N'Baja', N'87188')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3285, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F01052914 AS DateTime), N'Baja', N'89702')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3286, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55F01053D54 AS DateTime), N'Baja', N'87152')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3287, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F01060600 AS DateTime), N'Baja', N'90229')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3288, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB8bVtR7EhiV/hm1cWhlFoSjZlX4KRVmlA/5xKFt2xkdE', CAST(0x0000A55F0107DF8C AS DateTime), N'Media', N'326104')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3289, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F0107E95A AS DateTime), N'Baja', N'89588')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3290, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A55F0108B6CB AS DateTime), N'Alta', N'185556')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3291, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55F0108C73F AS DateTime), N'Baja', N'86756')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3292, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F010A795B AS DateTime), N'Baja', N'89419')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3293, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F010AE335 AS DateTime), N'Baja', N'89609')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3294, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55F010AF4C1 AS DateTime), N'Baja', N'87200')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3295, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F011554D9 AS DateTime), N'Baja', N'90157')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3296, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F01158C40 AS DateTime), N'Baja', N'89657')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3297, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A55F0115E954 AS DateTime), N'Alta', N'185365')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3298, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F01184D6D AS DateTime), N'Baja', N'89583')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3299, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55F011878AE AS DateTime), N'Baja', N'87079')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3300, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A55F0119C73A AS DateTime), N'Baja', N'89941')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3301, 9, N'mGqAmOwBQ2Sm4XzpbMgE7f+N9KV6nkgm1pRkGdXa54c=', CAST(0x0000A55F011A2BFC AS DateTime), N'Alta', N'185315')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3302, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A55F011A3124 AS DateTime), N'Baja', N'87198')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3303, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A61C013FD186 AS DateTime), N'Baja', N'89931')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3304, 9, N'LntEkJTXoA+LvkNo39N1Bt+qU8uKs1sWWZLx0L4HLPw=', CAST(0x0000A61C013FFB31 AS DateTime), N'Alta', N'183522')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3305, 9, N'LntEkJTXoA+LvkNo39N1Bt+qU8uKs1sWWZLx0L4HLPw=', CAST(0x0000A61C013FFCFE AS DateTime), N'Alta', N'183662')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3306, 9, N'LntEkJTXoA+LvkNo39N1Bt+qU8uKs1sWWZLx0L4HLPw=', CAST(0x0000A61C013FFFF6 AS DateTime), N'Alta', N'183870')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3307, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A61C014039C9 AS DateTime), N'Baja', N'87385')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3308, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A624015AD898 AS DateTime), N'Baja', N'89732')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3309, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A624015ADD6E AS DateTime), N'Baja', N'86795')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3310, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A624015B146B AS DateTime), N'Baja', N'89316')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3311, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A624015B1864 AS DateTime), N'Baja', N'86812')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3312, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A629013E3E7E AS DateTime), N'Baja', N'90091')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3313, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A629013F3B7C AS DateTime), N'Baja', N'87316')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3314, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB/l1PWNL1aVU8UzIuuq7kHGRicTdDmlhDCmc/AQNnwqj', CAST(0x0000A62901773ABB AS DateTime), N'Media', N'330493')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3315, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB/l1PWNL1aVU8UzIuuq7kHGRicTdDmlhDCmc/AQNnwqj', CAST(0x0000A62901774AB7 AS DateTime), N'Media', N'330848')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3316, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6290177AFB4 AS DateTime), N'Baja', N'90325')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3317, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB/nGKq0E5OXqA6v6tUM9l6I=', CAST(0x0000A62A011B76A2 AS DateTime), N'Media', N'186572')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3318, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62A016568DD AS DateTime), N'Baja', N'89815')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3319, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62A01658C2E AS DateTime), N'Media', N'332473')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3320, 0, N'uFAIrnFQ4ZJ5jF/k6mSuBy5dmYDLEXjpc50XBREcOpk=', CAST(0x0000A62A016B4A78 AS DateTime), N'Media', N'192474')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3321, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB5LvtkaEEKVBxoMpGIF26OU=', CAST(0x0000A62A016D3043 AS DateTime), N'Media', N'190165')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3322, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB3kMEkMVviTo3hRgUXjuv2PHUZ1VXWO6mk/QFsULkZwe', CAST(0x0000A62B01236A16 AS DateTime), N'Media', N'328208')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3323, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB4VNnsqO9YG0m4gnFEs3d8c=', CAST(0x0000A62B012ADBE1 AS DateTime), N'Media', N'190445')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3324, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB4VNnsqO9YG0m4gnFEs3d8c=', CAST(0x0000A62B012AF066 AS DateTime), N'Media', N'190447')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3325, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB0zta6TF+VJG6tveyN7BxE4=', CAST(0x0000A62B012B1A31 AS DateTime), N'Media', N'190342')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3326, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB7ZgiWFJBVQjRxgD/W+L9Nc=', CAST(0x0000A62B012E1041 AS DateTime), N'Media', N'188645')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3327, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB0zta6TF+VJG6tveyN7BxE4=', CAST(0x0000A62B012FBCA0 AS DateTime), N'Media', N'189807')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3328, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB6qdgiAm5et7rCkJ8DCvs4s=', CAST(0x0000A62B0130DBC8 AS DateTime), N'Media', N'194607')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3329, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB4H0ZKdBXqLJPmQHc11mnZ0=', CAST(0x0000A62B0132B0B3 AS DateTime), N'Media', N'188246')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3330, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B0133B940 AS DateTime), N'Baja', N'89603')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3331, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B0133F546 AS DateTime), N'Media', N'331846')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3332, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B013403ED AS DateTime), N'Baja', N'89800')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3333, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B013542C1 AS DateTime), N'Baja', N'90269')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3334, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B01364A44 AS DateTime), N'Baja', N'90118')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3335, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B01368C22 AS DateTime), N'Baja', N'89617')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3336, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B0136A8AC AS DateTime), N'Baja', N'89670')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3337, 9, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A62B0136AF9A AS DateTime), N'Alta', N'191784')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3338, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B0136CB23 AS DateTime), N'Baja', N'89771')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3339, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B013763BA AS DateTime), N'Baja', N'89960')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3340, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B0137BC0C AS DateTime), N'Baja', N'90259')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3341, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B013BF184 AS DateTime), N'Baja', N'89713')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3342, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB4VNnsqO9YG0m4gnFEs3d8c=', CAST(0x0000A62B0162A044 AS DateTime), N'Media', N'190015')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3343, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB4VNnsqO9YG0m4gnFEs3d8c=', CAST(0x0000A62B0162A4D7 AS DateTime), N'Media', N'189678')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3344, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B0162AB70 AS DateTime), N'Media', N'331636')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3345, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B0162B063 AS DateTime), N'Media', N'331199')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3346, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A62B0162B399 AS DateTime), N'Alta', N'511245')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3347, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B0162B3E1 AS DateTime), N'Media', N'331471')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3348, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B0162BDF8 AS DateTime), N'Media', N'331474')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3349, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B0162C2C5 AS DateTime), N'Media', N'331830')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3350, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A62B0162C844 AS DateTime), N'Alta', N'511222')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3351, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B0162C859 AS DateTime), N'Media', N'331448')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3352, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B016321FF AS DateTime), N'Media', N'332152')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3353, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B016325C4 AS DateTime), N'Media', N'331278')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3354, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A62B016355AB AS DateTime), N'Alta', N'511568')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3355, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B016355D3 AS DateTime), N'Media', N'331722')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3356, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A62B01636BB1 AS DateTime), N'Baja', N'89374')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3357, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B0164D9E6 AS DateTime), N'Media', N'332067')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3358, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB4788X4dx1qiEfozkd/EGUw=', CAST(0x0000A62B0164E12F AS DateTime), N'Media', N'192229')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3359, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB4VNnsqO9YG0m4gnFEs3d8c=', CAST(0x0000A62B0164E95C AS DateTime), N'Media', N'190632')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3360, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A62B0164F038 AS DateTime), N'Media', N'332128')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3361, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A630010922E9 AS DateTime), N'Alta', N'512580')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3362, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6300109233D AS DateTime), N'Media', N'331789')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3363, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6300109D0AE AS DateTime), N'Media', N'332841')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3364, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6300109D6FF AS DateTime), N'Media', N'332492')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3365, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A6300109E2BC AS DateTime), N'Alta', N'512140')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3366, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6300109E2E6 AS DateTime), N'Media', N'332150')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3367, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6300109E6D8 AS DateTime), N'Media', N'332506')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3368, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6300109EAEF AS DateTime), N'Media', N'331981')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3369, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A630010A43D3 AS DateTime), N'Alta', N'512823')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3370, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A630010A43FE AS DateTime), N'Media', N'332652')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3371, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630010A623C AS DateTime), N'Baja', N'90012')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3372, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A630010E3E54 AS DateTime), N'Media', N'332491')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3373, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A630010E417D AS DateTime), N'Media', N'332759')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3374, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A630010EADA0 AS DateTime), N'Alta', N'512025')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3375, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A630010EADCD AS DateTime), N'Media', N'332059')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3376, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630010F3592 AS DateTime), N'Baja', N'90081')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3377, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A63001116E32 AS DateTime), N'Media', N'332239')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3378, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A63001117354 AS DateTime), N'Media', N'332683')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3379, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6300111910C AS DateTime), N'Baja', N'89758')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3380, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A6300111A03C AS DateTime), N'Alta', N'512455')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3381, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A63001126BA7 AS DateTime), N'Baja', N'87500')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3382, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A630011279B8 AS DateTime), N'Media', N'332387')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3383, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A63001127B9A AS DateTime), N'Media', N'332479')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3384, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6300112F061 AS DateTime), N'Baja', N'89560')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3385, 9, N'i5se1CE0t28zXe54qgf7IfUZPGSzu+P7R+U6tbKtY1Uu8i1TePhcsrtepMghbkeE', CAST(0x0000A630011301AD AS DateTime), N'Alta', N'325504')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3386, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A630011304BC AS DateTime), N'Baja', N'87251')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3387, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6300116C1E3 AS DateTime), N'Media', N'332851')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3388, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6300116DF70 AS DateTime), N'Baja', N'89846')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3389, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630011774F9 AS DateTime), N'Baja', N'90324')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3390, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63001185530 AS DateTime), N'Baja', N'89893')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3391, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630011F236D AS DateTime), N'Baja', N'90019')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3392, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630012C42E8 AS DateTime), N'Baja', N'89740')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3393, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630012D776F AS DateTime), N'Baja', N'90162')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3394, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63001322BC4 AS DateTime), N'Baja', N'90070')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3395, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6300133E8C0 AS DateTime), N'Baja', N'89747')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3396, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6300138C22C AS DateTime), N'Baja', N'90298')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3397, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630015A7C6A AS DateTime), N'Baja', N'89371')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3398, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630015AC5CF AS DateTime), N'Baja', N'89516')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3399, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630015D0F61 AS DateTime), N'Baja', N'89568')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3400, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A630015DED6D AS DateTime), N'Baja', N'89404')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3401, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63001603E87 AS DateTime), N'Baja', N'89744')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3402, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6300160B830 AS DateTime), N'Baja', N'89503')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3403, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631013A4B28 AS DateTime), N'Baja', N'90033')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3404, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101407B9C AS DateTime), N'Baja', N'90019')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3405, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310143C256 AS DateTime), N'Baja', N'90398')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3406, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631014480C2 AS DateTime), N'Baja', N'90133')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3407, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310144CC1F AS DateTime), N'Baja', N'89989')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3408, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101458B2C AS DateTime), N'Baja', N'90178')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3409, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310149FD57 AS DateTime), N'Baja', N'89584')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3410, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631014C67E3 AS DateTime), N'Baja', N'89407')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3411, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631014DC444 AS DateTime), N'Baja', N'89492')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3412, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631014E4B8A AS DateTime), N'Baja', N'89779')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3413, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631014EA0C6 AS DateTime), N'Baja', N'89586')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3414, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631014F089F AS DateTime), N'Baja', N'90161')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3415, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310152A1B2 AS DateTime), N'Baja', N'89793')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3416, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631015385AB AS DateTime), N'Baja', N'89934')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3417, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310153EB29 AS DateTime), N'Baja', N'89980')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3418, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101561FAA AS DateTime), N'Baja', N'90034')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3419, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310156B061 AS DateTime), N'Baja', N'89839')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3420, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631016C1DA5 AS DateTime), N'Baja', N'89672')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3421, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631016C5545 AS DateTime), N'Baja', N'89963')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3422, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631016CBEDA AS DateTime), N'Baja', N'90153')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3423, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631016D547A AS DateTime), N'Baja', N'89555')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3424, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631016D7EDA AS DateTime), N'Baja', N'89555')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3425, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631016E63FF AS DateTime), N'Baja', N'90029')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3426, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631016FCDB1 AS DateTime), N'Baja', N'89972')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3427, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101704791 AS DateTime), N'Baja', N'89562')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3428, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310170780D AS DateTime), N'Baja', N'89613')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3429, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310170D59F AS DateTime), N'Baja', N'89756')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3430, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101718722 AS DateTime), N'Baja', N'89765')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3431, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101726CC6 AS DateTime), N'Baja', N'89806')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3432, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101743304 AS DateTime), N'Baja', N'89915')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3433, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101755A47 AS DateTime), N'Baja', N'89809')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3434, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310175BE95 AS DateTime), N'Baja', N'89786')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3435, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6310175F395 AS DateTime), N'Baja', N'89548')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3436, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101796C27 AS DateTime), N'Baja', N'90022')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3437, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631017B7047 AS DateTime), N'Baja', N'89807')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3438, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631017BA660 AS DateTime), N'Baja', N'89617')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3439, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A631017BFCAE AS DateTime), N'Baja', N'89905')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3440, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101855A0D AS DateTime), N'Baja', N'90039')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3441, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101876100 AS DateTime), N'Baja', N'90190')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3442, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63101879BC3 AS DateTime), N'Baja', N'90192')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3443, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63500EF2E43 AS DateTime), N'Baja', N'89820')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3444, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63500F010AB AS DateTime), N'Baja', N'89528')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3445, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63500F1055A AS DateTime), N'Baja', N'89712')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3446, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63500F148B1 AS DateTime), N'Baja', N'90098')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3447, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63500F25CD8 AS DateTime), N'Baja', N'89636')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3448, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63500F29CD7 AS DateTime), N'Baja', N'89878')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3449, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63500F39967 AS DateTime), N'Baja', N'90013')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3450, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63500F47C0B AS DateTime), N'Baja', N'89663')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3451, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63500F529DD AS DateTime), N'Baja', N'89802')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3452, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A637013636C9 AS DateTime), N'Baja', N'90252')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3453, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63701372EBC AS DateTime), N'Baja', N'90174')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3454, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6370137A2B5 AS DateTime), N'Baja', N'90126')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3455, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6370138A422 AS DateTime), N'Baja', N'90216')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3456, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6370138ED80 AS DateTime), N'Baja', N'89976')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3457, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A637013A5E4F AS DateTime), N'Baja', N'89816')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3458, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013A95F5 AS DateTime), N'Alta', N'182987')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3459, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013A992B AS DateTime), N'Alta', N'183195')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3460, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013AA56E AS DateTime), N'Alta', N'183229')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3461, 9, N'eAuF+/yWqQ5r1KZIWIxfgxKjC9N+E+Qg1rIOmR8GT5A=', CAST(0x0000A637013AEAB6 AS DateTime), N'Alta', N'179039')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3462, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013AF7B2 AS DateTime), N'Alta', N'183369')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3463, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013AFB25 AS DateTime), N'Alta', N'183577')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3464, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013BB026 AS DateTime), N'Alta', N'183302')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3465, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013BB2CF AS DateTime), N'Alta', N'183442')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3466, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013BB645 AS DateTime), N'Alta', N'183650')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3467, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013BB8B0 AS DateTime), N'Alta', N'183177')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3468, 9, N'LntEkJTXoA+LvkNo39N1BtFJQMKO0O7xUHI/sl/kUpc=', CAST(0x0000A637013BBAA8 AS DateTime), N'Alta', N'183317')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3469, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A637013BBE02 AS DateTime), N'Baja', N'87352')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3470, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A637013BD85F AS DateTime), N'Baja', N'90257')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3471, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A637013BDDE8 AS DateTime), N'Baja', N'86725')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3472, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A637013EEC23 AS DateTime), N'Baja', N'89854')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3473, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A637014079F2 AS DateTime), N'Baja', N'90271')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3474, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A637014F39CC AS DateTime), N'Baja', N'89237')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3475, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A637015399F9 AS DateTime), N'Baja', N'89796')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3476, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6370159616E AS DateTime), N'Baja', N'90029')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3477, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A637015965BA AS DateTime), N'Baja', N'87092')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3478, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63701597566 AS DateTime), N'Baja', N'89987')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3479, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A637015FEC76 AS DateTime), N'Baja', N'89586')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3480, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6370161BBD2 AS DateTime), N'Baja', N'89819')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3481, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63701623CE2 AS DateTime), N'Baja', N'89866')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3482, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63701632CE9 AS DateTime), N'Baja', N'89696')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3483, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6370166E4F0 AS DateTime), N'Baja', N'89683')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3484, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A637016A7A78 AS DateTime), N'Baja', N'90010')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3485, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A6370173F6FF AS DateTime), N'Baja', N'89698')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3486, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63701776B38 AS DateTime), N'Baja', N'89784')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3487, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D0134EB6C AS DateTime), N'Baja', N'90192')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3488, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D013ADD25 AS DateTime), N'Baja', N'90010')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3489, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D013F2539 AS DateTime), N'Baja', N'90258')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3490, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D01434B27 AS DateTime), N'Baja', N'90112')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3491, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D014944B3 AS DateTime), N'Baja', N'90677')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3492, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D015A3704 AS DateTime), N'Baja', N'89375')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3493, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D015ABA7F AS DateTime), N'Baja', N'89518')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3494, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D015DFA58 AS DateTime), N'Baja', N'89609')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3495, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D0162CE53 AS DateTime), N'Baja', N'89947')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3496, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D0164F201 AS DateTime), N'Baja', N'90120')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3497, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D016FE25A AS DateTime), N'Baja', N'90031')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3498, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63D01710073 AS DateTime), N'Baja', N'90001')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3499, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E013F1501 AS DateTime), N'Baja', N'90053')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3500, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E013F6E9F AS DateTime), N'Baja', N'89750')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3501, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E0140BE05 AS DateTime), N'Baja', N'90410')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3502, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E0143008A AS DateTime), N'Baja', N'89889')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3503, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E01446DC9 AS DateTime), N'Baja', N'89855')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3504, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E0144BED8 AS DateTime), N'Baja', N'89903')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3505, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E0147AACA AS DateTime), N'Baja', N'90476')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3506, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E0149F3CD AS DateTime), N'Baja', N'89690')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3507, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E014E4A2C AS DateTime), N'Baja', N'89817')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3508, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E014FA1DC AS DateTime), N'Baja', N'89974')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3509, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E0150704C AS DateTime), N'Baja', N'89969')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3510, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63E0153A666 AS DateTime), N'Baja', N'90024')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3511, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F0008B73C AS DateTime), N'Baja', N'86626')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3512, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F00095833 AS DateTime), N'Baja', N'86484')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3513, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01596C32 AS DateTime), N'Baja', N'89968')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3514, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F015BA4D5 AS DateTime), N'Baja', N'89511')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3515, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F015CDE9A AS DateTime), N'Baja', N'89097')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3516, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F015D3AA9 AS DateTime), N'Baja', N'89192')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3517, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01610D34 AS DateTime), N'Baja', N'89613')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3518, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F0162FDCE AS DateTime), N'Baja', N'89718')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3519, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A63F01630BF7 AS DateTime), N'Baja', N'86732')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3520, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01640930 AS DateTime), N'Baja', N'89726')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3521, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01655867 AS DateTime), N'Baja', N'89310')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3522, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F0166B29B AS DateTime), N'Baja', N'89969')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3523, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01679BEB AS DateTime), N'Baja', N'89917')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3524, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01682C49 AS DateTime), N'Baja', N'89316')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3525, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F016966C0 AS DateTime), N'Baja', N'90026')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3526, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F016B23EC AS DateTime), N'Baja', N'89529')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3527, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F016B9B67 AS DateTime), N'Baja', N'89429')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3528, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01711A8F AS DateTime), N'Baja', N'89521')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3529, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01736D00 AS DateTime), N'Baja', N'89720')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3530, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F017451C7 AS DateTime), N'Baja', N'89676')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3531, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01750AA5 AS DateTime), N'Baja', N'89625')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3532, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F01775DC4 AS DateTime), N'Baja', N'89628')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3533, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A63F0177EDC7 AS DateTime), N'Baja', N'89818')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3534, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A64300E82977 AS DateTime), N'Baja', N'89729')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3535, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A64300E95984 AS DateTime), N'Baja', N'90007')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3536, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A64300E9C41E AS DateTime), N'Baja', N'89554')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3537, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A64300EA25B3 AS DateTime), N'Baja', N'89456')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3538, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A64300F5ED03 AS DateTime), N'Baja', N'89868')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3539, 9, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A64300F6FBE4 AS DateTime), N'Alta', N'182802')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3540, 9, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A64300F7054E AS DateTime), N'Alta', N'192446')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3541, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A64300F723FE AS DateTime), N'Baja', N'90357')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3542, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A64301273C69 AS DateTime), N'Baja', N'90165')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3543, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A64301279999 AS DateTime), N'Baja', N'87323')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3544, 0, N'uFAIrnFQ4ZJ5jF/k6mSuB5TypwvuPEZ4Lx7VkGbg4Eg=', CAST(0x0000A6430127D8BA AS DateTime), N'Media', N'195047')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3545, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6430127E508 AS DateTime), N'Media', N'333109')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3546, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6430127E9DA AS DateTime), N'Media', N'332672')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3547, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A6430127EEBF AS DateTime), N'Alta', N'513262')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3548, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6430127EED4 AS DateTime), N'Media', N'333032')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3549, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A643013890B9 AS DateTime), N'Media', N'332413')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3550, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A64301389D7E AS DateTime), N'Media', N'332555')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3551, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A6430138A32A AS DateTime), N'Alta', N'513233')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3552, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6430138A353 AS DateTime), N'Media', N'333003')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3553, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6430139A124 AS DateTime), N'Media', N'332158')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3554, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A6430139A498 AS DateTime), N'Media', N'332426')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3555, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Ko1JLhjDvzmJDOXlXbDfkmA2ioEUEBN/s/l+o3jNBsg==', CAST(0x0000A643013A1801 AS DateTime), N'Alta', N'512268')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3556, 9, N'PNM6/fGO4jai0qC/OnkP7NLxKJuxPHsCQSehquwOiyYQq+Cq+3cQCwMBPFRrNavo', CAST(0x0000A643013A1834 AS DateTime), N'Media', N'332342')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3557, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A643013A41F1 AS DateTime), N'Baja', N'89624')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3558, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A643013A832F AS DateTime), N'Baja', N'87214')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3559, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A643013AB248 AS DateTime), N'Baja', N'90106')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3560, 9, N'i5se1CE0t28zXe54qgf7IfUZPGSzu+P7R+U6tbKtY1Uu8i1TePhcsrtepMghbkeE', CAST(0x0000A643013AC7A3 AS DateTime), N'Alta', N'325487')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3561, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1jIPniI0x+Km4dH4xBDIMAQ==', CAST(0x0000A643013AEF73 AS DateTime), N'Alta', N'495681')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3562, 9, N'LntEkJTXoA+LvkNo39N1Bt+qU8uKs1sWWZLx0L4HLPw=', CAST(0x0000A643013AF26E AS DateTime), N'Alta', N'183862')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3563, 9, N'LntEkJTXoA+LvkNo39N1BlreOcisj38wYmgmaU9gDK5Xgggdr853CFT/IuGYBiF1jIPniI0x+Km4dH4xBDIMAQ==', CAST(0x0000A643013B7642 AS DateTime), N'Alta', N'495347')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3564, 9, N'LntEkJTXoA+LvkNo39N1Bt+qU8uKs1sWWZLx0L4HLPw=', CAST(0x0000A643013B7942 AS DateTime), N'Alta', N'184273')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3565, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A643013BAA9F AS DateTime), N'Baja', N'93855')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3566, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A643013C1459 AS DateTime), N'Baja', N'93634')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3567, 29, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A643013C1DCD AS DateTime), N'Baja', N'90709')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3568, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A643013DB7DD AS DateTime), N'Baja', N'87494')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3569, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A643013DF2F5 AS DateTime), N'Baja', N'93871')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3570, 29, N'i5se1CE0t28zXe54qgf7IfRLdzbf4lAoNAdzWp78+jNMYzc6LSf6IU08QqwGwnG1', CAST(0x0000A643013E02B2 AS DateTime), N'Alta', N'320113')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3571, 29, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A643013E081D AS DateTime), N'Baja', N'90961')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3572, 9, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A643013E53BF AS DateTime), N'Baja', N'90454')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3573, 9, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A643013ECB6A AS DateTime), N'Baja', N'87011')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3574, 29, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A643013EDFF4 AS DateTime), N'Alta', N'188337')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3575, 29, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A643013EEC43 AS DateTime), N'Alta', N'197977')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3576, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A643013EED0B AS DateTime), N'Baja', N'93192')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3577, 29, N'L7ScQuxyJ+7lS623+/XEFg==', CAST(0x0000A643013F242A AS DateTime), N'Baja', N'90852')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3578, 29, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A643013F4962 AS DateTime), N'Alta', N'188281')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3579, 29, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A643013F55E1 AS DateTime), N'Alta', N'198263')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3580, 29, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A643013F743E AS DateTime), N'Alta', N'187906')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3581, 29, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A643013F7572 AS DateTime), N'Alta', N'197889')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3582, 29, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A643013F8948 AS DateTime), N'Alta', N'187912')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3583, 29, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A643013F8EB4 AS DateTime), N'Alta', N'198171')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3584, 29, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A64301409F9B AS DateTime), N'Alta', N'188046')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3585, 29, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A6430140AB3F AS DateTime), N'Alta', N'198028')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3586, 29, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A64301420DBA AS DateTime), N'Alta', N'187995')
GO
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3587, 29, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A64301421964 AS DateTime), N'Alta', N'197977')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3588, 29, N'ztSl8oUMBj6spS3/7QYRiA==', CAST(0x0000A64301421A24 AS DateTime), N'Baja', N'93634')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3589, 29, N'wpBfWofrcXUGdvLEsEj50CiFHOuOjoX3qsJD96E3AYM=', CAST(0x0000A6430142422C AS DateTime), N'Alta', N'188282')
INSERT [dbo].[Bitacora] ([bitacora_id], [usuario_fk], [descripcion], [fecha_hora], [criticidad], [dvh]) VALUES (3590, 29, N'7SEbSfqwAYy3awy9MA4zxLH4bhfLtJ4uzyaXpWr0IIc=', CAST(0x0000A64301424D9F AS DateTime), N'Alta', N'198227')
SET IDENTITY_INSERT [dbo].[Bitacora] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [nombreCompleto], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (3, N'33333332', N'settino', N'german', N'settino, german', N'46351267', N'german@gramn.com', N'asdasd', 6, 24, CAST(0xAB3A0B00 AS Date), 0, N'337461')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [nombreCompleto], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (5, N'33333333', N'hernan', N'settino', N'hernan, settino', N'123123122123432', N'asdasd@adasdsa.com', N'asdasdasd', 6, 24, CAST(0xAD3A0B00 AS Date), 1, N'418887')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [nombreCompleto], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (6, N'33363326', N'settino', N'german', N'settino, german', N'46351267', N'german.settino@gmail.com', N'manuel artigas 5391', 9, 24, CAST(0xB43A0B00 AS Date), 0, N'511939')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [nombreCompleto], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (7, N'33633265', N'settino', N'german', N'settino, german', N'46351267', N'german.settino@gmail.com', N'manuel artigas 5391', 6, 24, CAST(0xB43A0B00 AS Date), 0, N'511686')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [nombreCompleto], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (8, N'11111111', N'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', N'aaaaaaaaaaa', N'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa, aaaaaaaaaaa', N'1111111111111111111111', N'asdasdasdasda@asdddddddddddddddddd', N'asdasdasd', 3, 24, CAST(0xB43A0B00 AS Date), 0, N'2386720')
INSERT [dbo].[Cliente] ([cliente_id], [dni], [apellido], [nombre], [nombreCompleto], [telefono], [email], [direccion], [localidad_fk], [provincia_fk], [fecha_alta], [eliminado], [dvh]) VALUES (9, N'33333676', N'settino', N'german', N'settino, german', N'234234234232342342342423423', N'german.settino@gmail.com', N'manuel artigas 5391', 2, 24, CAST(0xB43A0B00 AS Date), 0, N'670391')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (1, N'Bitacora            ', N'171036291')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (2, N'Usuario             ', N'2166175')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (3, N'Familia             ', N'39181')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (4, N'Venta               ', N'190193')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (5, N'Venta_Medicamento   ', N'1658425')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (6, N'Medicamento         ', N'2445960')
INSERT [dbo].[DVV] ([tabla_id], [nombre], [dvv]) VALUES (7, N'Cliente             ', N'4837084')
SET IDENTITY_INSERT [dbo].[Familia] ON 

INSERT [dbo].[Familia] ([familia_id], [nombre], [descripcion], [dvh]) VALUES (68, N'E8nFnPVIfZRy2Shr11b3DQ==', N'pepe', N'39181')
SET IDENTITY_INSERT [dbo].[Familia] OFF
SET IDENTITY_INSERT [dbo].[Idioma] ON 

INSERT [dbo].[Idioma] ([idioma_id], [nombre]) VALUES (1, N'Español')
INSERT [dbo].[Idioma] ([idioma_id], [nombre]) VALUES (2, N'Ingles')
SET IDENTITY_INSERT [dbo].[Idioma] OFF
SET IDENTITY_INSERT [dbo].[Laboratorio] ON 

INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (1, N'954-196-125', N'BAXTER ARG.', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (2, N'945-638-712', N'BAUSCH & LOMB', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (3, N'932-330-230', N'LOMB', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (4, N'928-346-635', N'BACON', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (5, N'977-624-082', N'B-Life S.A.', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (6, N'960-541-777', N'BA', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (7, N'953-731-612', N'BAYER', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (8, N'967-751-963', N'BAYER (BSP)', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (9, N'932-472-344', N'RAFFO', N'30-51684266-7')
INSERT [dbo].[Laboratorio] ([laboratorio_id], [telefono], [razon_social], [cuit]) VALUES (10, N'950-689-140', N'IVAX', N'30-51684266-7')
SET IDENTITY_INSERT [dbo].[Laboratorio] OFF
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (1, N'Villa delina', 24)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (2, N'Boulogne', 24)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (3, N'Munro', 24)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (4, N'Villa Maria', 42)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (5, N'Castilla y León', 42)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (6, N'Andalucía', 42)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (7, N'Merlo', 30)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (8, N'Carpinteria', 30)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (9, N'Potrero de los funes', 30)
INSERT [dbo].[Localidad] ([localidad_id], [descripcion], [provincia_fk]) VALUES (10, N'Cordoba capital', 42)
SET IDENTITY_INSERT [dbo].[Medicamento] ON 

INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (10, N'ibuprofeno', 10, N'aperDG1Msf+Q+qUpela+WA==', N'SZrFcO3dbNwLssEDVscEqQ==', 0, 1, N'228672')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (11, N'armonil', 10, N'aperDG1Msf+Q+qUpela+WA==', N'l+7GAbE2aEWExP3+uHcD9Q==', 0, 0, N'200248')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (12, N'adasdasd', 2, N'aperDG1Msf+Q+qUpela+WA==', N'JZNPADvBBdzwzN55xhQHUA==', 0, 1, N'204944')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (13, N'medicamento1', 7, N'aperDG1Msf+Q+qUpela+WA==', N'foC1PgHNtIUQbPnpiNnbzw==', 0, 1, N'239299')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (14, N'ibuprofeno2', 2, N'aperDG1Msf+Q+qUpela+WA==', N'qhJoB+fJ1mApJzdugnsG2A==', 0, 1, N'226536')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (15, N'medicamento2', 6, N'Qn4fUqj67CmEy+N2Qp2cxQ==', N'l+7GAbE2aEWExP3+uHcD9Q==', 0, 1, N'218384')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (16, N'medicamento3', 8, N'O9UaIIdNmdD0x7r6irQx7Q==', N'S3LK3DhFcBaGNZGmhPUCwg==', 0, 0, N'233709')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (17, N'medicamento4', 10, N'aperDG1Msf+Q+qUpela+WA==', N'l+7GAbE2aEWExP3+uHcD9Q==', 0, 1, N'224533')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (18, N'medicamento5', 1, N'+xvtVhnD3ZpIQxi2DYTavg==', N'S3LK3DhFcBaGNZGmhPUCwg==', 0, 1, N'231347')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (19, N'medicamento6', 8, N'aperDG1Msf+Q+qUpela+WA==', N'l+7GAbE2aEWExP3+uHcD9Q==', 0, 1, N'219198')
INSERT [dbo].[Medicamento] ([medicamento_id], [descripcion], [laboratorio_fk], [cantidad], [precio], [eliminado], [receta], [dvh]) VALUES (20, N'medicamento7', 1, N'aperDG1Msf+Q+qUpela+WA==', N'l+7GAbE2aEWExP3+uHcD9Q==', 0, 1, N'219090')
SET IDENTITY_INSERT [dbo].[Medicamento] OFF
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (1, N'Usuario', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (2, N'Familia', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (3, N'Backup', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (4, N'Restore', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (5, N'Bitacora', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (6, N'RecalcularDV', 1)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (7, N'Venta', 0)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (8, N'Cliente', 0)
INSERT [dbo].[Patente] ([patente_id], [nombre], [obligatoria]) VALUES (9, N'Medicamento', 0)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (68, 1)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (68, 2)
INSERT [dbo].[Patente_Familia] ([familia_id], [patente_id]) VALUES (68, 3)
SET IDENTITY_INSERT [dbo].[Provincia] ON 

INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (24, N'Buenos Aires')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (25, N'Formosa')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (26, N'Chaco')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (27, N'Santa Cruz')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (28, N'Mendoza')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (29, N'Tierra del Fuego')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (30, N'San Luis')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (31, N'San Juan')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (32, N'Misiones')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (33, N'Jujuy')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (34, N'Salta')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (35, N'Chubut')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (36, N'Capital Federal')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (37, N'La Rioja')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (38, N'Tucuman')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (39, N'Corrientes')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (40, N'Entre Rios')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (41, N'Santa Fe')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (42, N'Cordoba')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (43, N'La Pampa')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (44, N'Rio Negro')
INSERT [dbo].[Provincia] ([provincia_id], [descripcion]) VALUES (45, N'Santiago del Estero')
SET IDENTITY_INSERT [dbo].[Provincia] OFF
SET IDENTITY_INSERT [dbo].[Traduccion] ON 

INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (1, 2, N'&Aceptar', N'&Accept')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (2, 2, N'&Activar', N'&Active')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (3, 2, N'&Buscar', N'&Search')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (4, 2, N'&Cancelar', N'&Cancel')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (5, 2, N'&Contraseña', N'&Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (6, 2, N'&Exportar', N'&Export')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (7, 2, N'&Limpiar', N'C&lean')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (8, 2, N'&Registrar', N'&New')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (9, 2, N'&Restablecer Contraseña', N'&Reset Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (10, 2, N'&Salir', N'&Exit')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (11, 2, N'Acerca de Sistema de Gestion Farmacia', N'About Sistema de Gestion Farmacia')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (12, 2, N'Apellido', N'Lastname')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (13, 2, N'Apellido y Nombre', N'Lastname and Name')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (14, 2, N'Archivo', N'File')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (15, 2, N'Asignada', N'Assigned')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (16, 2, N'Ayuda', N'Help')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (17, 2, N'Backup', N'Backup')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (18, 2, N'Bitacora', N'Log')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (19, 2, N'Bitacora', N'Logs')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (20, 2, N'Bloquear', N'Block')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (21, 2, N'Campo Requerido', N'Required field')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (22, 2, N'Cantidad', N'Amount')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (23, 2, N'Clientes', N'Customers')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (24, 2, N'Criticidad', N'Criticality')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (25, 2, N'Desbloquear', N'Unlock')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (26, 2, N'Descripcion', N'Description')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (27, 2, N'Direccion', N'Address')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (28, 2, N'DNI', N'DNI')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (29, 2, N'Eliminar', N'Delete')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (30, 2, N'E-Mail', N'E-Mail')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (31, 2, N'Error', N'Error')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (32, 2, N'Español', N'Spanish')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (33, 2, N'Exportar informe', N'Export inform')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (34, 2, N'Familia', N'Family')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (35, 2, N'Familias', N'Families')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (36, 2, N'Fecha', N'Date')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (37, 2, N'Fecha desde', N'Date from')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (38, 2, N'Fecha hasta', N'Date to')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (39, 2, N'Generar informe', N'Generate inform')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (40, 2, N'Generar nuevo', N'Generate new')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (41, 2, N'Id', N'Id')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (42, 2, N'Idioma', N'Language')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (43, 2, N'Informes', N'Reports')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (44, 2, N'Laboratorio', N'Laboratory')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (45, 2, N'Limpiar', N'Clean')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (46, 2, N'Localidad', N'Location')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (47, 2, N'Medicamentos', N'Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (48, 2, N'Mensaje', N'Message')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (49, 2, N'Modificar', N'Modify')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (50, 2, N'Negada', N'Denied')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (51, 2, N'Nombre', N'Name')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (52, 2, N'Patente', N'Role')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (53, 2, N'Patentes', N'Roles')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (54, 2, N'Patentes negacion', N'Denied roles')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (55, 2, N'Permisos', N'Permissions')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (56, 2, N'Precio', N'Price')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (57, 2, N'Provincia', N'Province')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (58, 2, N'Receta', N'Prescription')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (59, 2, N'Reporte Clientes Por Compra', N'Customers For Purchase Report')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (60, 2, N'Reporte Stock de Medicamentos', N'Stock Medicines Report')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (61, 2, N'Reporte Ventas Por Medicamentos', N'Sales Report On Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (62, 2, N'Restaurar', N'Restore')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (63, 2, N'Ruta', N'Path')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (64, 2, N'Salir', N'Exit')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (65, 2, N'Seguridad', N'Security')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (66, 2, N'Sistema de Gestion Farmacia', N'Pharmacy Management System')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (67, 2, N'Telefono', N'Phone')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (68, 2, N'Todos', N'All')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (69, 2, N'Usuario', N'User')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (70, 2, N'Usuarios', N'Users')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (71, 2, N'Ventas', N'Sales')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (72, 2, N'Ver la Ayuda', N'View Help')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (73, 2, N'Activar', N'Activate')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (74, 2, N'No se puede eliminar el usuario porque quedarian patentes esenciales sin asignar', N'You can not delete the user because it would be essential patents unassigned')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (75, 2, N'¿Esta seguro que desea Activar el usuario', N'Are you sure you want to enable user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (76, 2, N'No se puede bloquear el usuario porque quedarian patentes esenciales sin asignar', N'You can not block the user because essential patents would unassigned')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (77, 2, N'¿Esta seguro que desea Bloquear el usuario', N'
Are you sure you want to block user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (78, 2, N'¿Esta seguro que desea Desbloquear el usuario', N'Are you sure you want to unlock the user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (79, 2, N'¿Esta seguro que desea Eliminar el usuario', N'
Are you sure you want to delete the user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (80, 2, N'Cambiar Contraseña', N'Change Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (81, 2, N'Email', N'Email')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (82, 2, N'Fecha y Hora', N'Date and Time')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (83, 2, N'lblcontraseña', N'lblcontraseña')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (84, 2, N'Se Modifico el Usuario', N'User changed')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (85, 2, N'Modificar Usuario', N'
Change User')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (86, 2, N'No se puede eliminar el mismo usuario', N'
You can not remove the same user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (87, 2, N'No se puede bloquear el mismo usuario', N'You can not lock the same user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (88, 2, N'Se Registro el Usuario', N'
The User Registration')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (89, 2, N'Registrar Usuario', N'
User Registration')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (90, 2, N'Eliminar Usuario', N'
Remove User')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (92, 2, N'Activar Usuario', N'
Enable User')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (93, 2, N'Bloquear Usuario', N'
Block user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (94, 2, N'Desbloquear Usuario', N'Unblock user')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (95, 2, N'Se restablecio la contraseña Usuario', N'User password reset')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (96, 2, N'No se puede quitar la patente al usuario porque la patente quedaria sin asignacion', N'You can not remove the patent to the user because the patent would be unallocated')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (97, 2, N'¿Esta seguro que desea Activar el Cliente', N'Are you sure you want to activate the client')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (98, 2, N'Activar Cliente', N'
Enable Customer')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (100, 2, N'¿Esta seguro que desea Eliminar el Cliente', N'Are you sure you want to remove client')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (101, 2, N'Eliminar Cliente', N'Delete Customer')
GO
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (102, 2, N'Se Modifico el Cliente', N'It changes the Customer')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (103, 2, N'Modificar Cliente', N'
Modify Client')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (104, 2, N'Se Registro el Cliente', N'He Customer Registration')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (105, 2, N'Registrar Cliente', N'
Customer register')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (106, 2, N'¿Esta seguro que desea Activar el Medicamento', N'Are you sure you want to activate the medication')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (107, 2, N'Activar Medicamento', N'Active Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (109, 2, N'¿Esta seguro que desea Eliminar el Medicamento', N'Are you sure you want to delete Medication')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (110, 2, N'Eliminar Medicamento', N'Remove Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (112, 2, N'Se Modifico el Medicamento', N'Medication modified')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (113, 2, N'Modificar Medicamento', N'Modify Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (114, 2, N'Se Registro el Medicamento', N'Medication recorded')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (115, 2, N'Registrar Medicamento', N'Register Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (116, 2, N'Todos los Usuarios', N'All Users')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (117, 2, N'...', N'...')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (118, 2, N'¿Esta seguro que desea salir?', N'
Are you sure you want to quit?')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (119, 2, N'Sus permisos han sido modificados, por favor inicie sesion nuevamente', N'Permissions have been changed, please log in again')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (120, 2, N'Reporte Clientes Por Venta', N'Report Customers For Sale')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (122, 2, N'Contraseña Anterior', N'
Old Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (123, 2, N'Confirmar Contraseña', N'Confirm Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (124, 2, N'Nueva Contraseña', N'New Password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (125, 2, N'Se Cambio la Contraseña', N'He changed the password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (126, 2, N'Todos los niveles', N'All levels')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (128, 2, N'Reportes', N'Reports')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (129, 2, N'Stock Medicamentos', N'
Stock Medications')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (130, 2, N'Agregar Medicamento', N'Add Medication')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (131, 2, N'Medicamento', N'Medicine')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (132, 2, N'Cliente', N'
Customer')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (133, 2, N'Nro Venta', N'No. Sale')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (134, 2, N'NroVenta', N'NoSale')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (135, 2, N'Total', N'Total')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (136, 2, N'Ver Detalle', N'See detail')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (138, 2, N'Precio Total', N'
Total Price')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (139, 2, N'Nro', N'No.')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (140, 2, N'Quitar Medicamento', N'Remove Medicines')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (141, 2, N'Todos los Laboratorios', N'All Laboratories')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (143, 2, N'Ingrese la Contraseña Anterior', N'
Enter Password Previous')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (144, 2, N'Ingrese la Contraseña Nueva', N'
Enter the new password')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (145, 2, N'La Contraseña Anterior es invalida!', N'Previous Password is invalid!')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (147, 2, N'Importe Total', N'Total Cost')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (148, 2, N'Precio de Lista', N'
List price')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (149, 2, N'Disponible', N'
Available')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (150, 2, N'Precio de Venta', N'Sale price')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (151, 2, N'Clientes activos', N'
Active customers')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (152, 2, N'Seleccione el cliente', N'Select the client')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (153, 2, N'Seleccione el medicamento', N'Select the medicine')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (154, 2, N'Debe ingresar por lo menos un medicamento a la venta.', N'You must enter at least one drug for sale.')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (155, 2, N'El Precio es menor al medicamento que se requiere vender.', N'The price is less than the required medication sell.')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (156, 2, N'Por unidad', N'Per unit')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (157, 2, N'Medicamentos Reporte', N'Medications Report')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (158, 2, N'Activo', N'Active')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (159, 2, N'Precio Venta (por unidad)', N'Sale Price (per unit)')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (160, 2, N'Se Modifico la venta', N'Changed sale')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (161, 2, N'Modificar Venta', N'Modify Sale')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (162, 2, N'El restore fue hecho con exito', N'El restore fue hecho con exito')
INSERT [dbo].[Traduccion] ([traduccion_id], [idioma_fk], [texto], [traduccion]) VALUES (163, 2, N'Restore', N'Restore')
SET IDENTITY_INSERT [dbo].[Traduccion] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (9, N'UYahIg+g0WKndK4p/20+pg==', N'81dc9bdb52d04dc20036dbd8313ed055', N'administrador', N'administrador', N'administrador@administrador.com', N'12345678', 0, 0, 0, N'813425')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (29, N'ffJMRvWqtW+IBm25OTHrsA==', N'81dc9bdb52d04dc20036dbd8313ed055', N'german', N'settino', N'german@german.com', N'33333333', 0, 0, 0, N'493323')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (30, N'E8nFnPVIfZRy2Shr11b3DQ==', N'608e279ecca334a66478fb937cf8dd54', N'asdada', N'adasdasd', N'asdasd@asdas.com', N'12321123', 0, 1, 0, N'478133')
INSERT [dbo].[Usuario] ([usuario_id], [nombre_usuario], [contraseña], [nombre], [apellido], [email], [dni], [bloqueado], [eliminado], [cci], [dvh]) VALUES (31, N'GdXtpOHyWgc4yaxzI3zn6w==', N'9b7e044752f72414e41d0108bec1aea1', N'pepe', N'pepe', N'.com', N'11111111', 0, 0, 0, N'381294')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (1, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (1, 30, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (2, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (2, 30, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (3, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (3, 29, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (3, 30, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (4, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (4, 29, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (4, 30, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (5, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (5, 30, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (6, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (6, 30, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (7, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (7, 29, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (7, 30, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (8, 9, 0)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (8, 30, 1)
INSERT [dbo].[Usuario_Patente] ([patente_id], [usuario_id], [negado]) VALUES (9, 9, 0)
SET IDENTITY_INSERT [dbo].[Venta] ON 

INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (1074, 3, 0, CAST(0x0000A558016F89D8 AS DateTime), 23745)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (1075, 3, 0, CAST(0x0000A55801708950 AS DateTime), 23908)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (1076, 3, 0, CAST(0x0000A5580170E710 AS DateTime), 23852)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (1077, 3, 0, CAST(0x0000A5580172DCA0 AS DateTime), 23773)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (1079, 3, 0, CAST(0x0000A55801815F78 AS DateTime), 23829)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (1080, 3, 0, CAST(0x0000A55900BF7DE0 AS DateTime), 23781)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (1081, 3, 0, CAST(0x0000A55D015F9000 AS DateTime), 23562)
INSERT [dbo].[Venta] ([venta_id], [cliente_fk], [eliminado], [fecha_venta], [dvh]) VALUES (1082, 3, 0, CAST(0x0000A55E00C0E7FC AS DateTime), 23743)
SET IDENTITY_INSERT [dbo].[Venta] OFF
SET IDENTITY_INSERT [dbo].[Venta_Medicamento] ON 

INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1334, 1073, 12, N'bFIRVjVHeXEFcmkmtKMdpg==', N'l+7GAbE2aEWExP3+uHcD9Q==', N'134114')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1379, 1078, 10, N'+xvtVhnD3ZpIQxi2DYTavg==', N'l+7GAbE2aEWExP3+uHcD9Q==', N'133246')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1380, 1078, 10, N'+xvtVhnD3ZpIQxi2DYTavg==', N'l+7GAbE2aEWExP3+uHcD9Q==', N'133213')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1411, 1079, 10, N'+xvtVhnD3ZpIQxi2DYTavg==', N'SZrFcO3dbNwLssEDVscEqQ==', N'147663')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1412, 1079, 17, N'+xvtVhnD3ZpIQxi2DYTavg==', N'l+7GAbE2aEWExP3+uHcD9Q==', N'133280')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1413, 1079, 17, N'+xvtVhnD3ZpIQxi2DYTavg==', N'l+7GAbE2aEWExP3+uHcD9Q==', N'133284')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1420, 1081, 17, N'C3XVUwTFqf2cweYPLbyxAg==', N'S3LK3DhFcBaGNZGmhPUCwg==', N'141489')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1421, 1081, 20, N'F3jBn+UpiALhIjJW0qzY4Q==', N'S3LK3DhFcBaGNZGmhPUCwg==', N'137640')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1427, 1080, 10, N'+xvtVhnD3ZpIQxi2DYTavg==', N'l+7GAbE2aEWExP3+uHcD9Q==', N'133168')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1428, 1080, 19, N'bFIRVjVHeXEFcmkmtKMdpg==', N'QuGL3rsb/xBcvj+t4UUrng==', N'148870')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1429, 1080, 19, N'bFIRVjVHeXEFcmkmtKMdpg==', N'QuGL3rsb/xBcvj+t4UUrng==', N'148874')
INSERT [dbo].[Venta_Medicamento] ([venta_medicamento_id], [venta_id], [medicamento_id], [cantidad_venta], [precio_venta], [dvh]) VALUES (1431, 1082, 18, N'F3jBn+UpiALhIjJW0qzY4Q==', N'f1xTA+21CKYs+f/WeRdGsQ==', N'133584')
SET IDENTITY_INSERT [dbo].[Venta_Medicamento] OFF
/****** Object:  Index [UQ_Bitacora_bitacora_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Bitacora] ADD  CONSTRAINT [UQ_Bitacora_bitacora_id] UNIQUE NONCLUSTERED 
(
	[bitacora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Cliente_cliente_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Cliente] ADD  CONSTRAINT [UQ_Cliente_cliente_id] UNIQUE NONCLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_DVV_tabla_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[DVV] ADD  CONSTRAINT [UQ_DVV_tabla_id] UNIQUE NONCLUSTERED 
(
	[tabla_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Familia_familia_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Familia] ADD  CONSTRAINT [UQ_Familia_familia_id] UNIQUE NONCLUSTERED 
(
	[familia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Idioma_idioma_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Idioma] ADD  CONSTRAINT [UQ_Idioma_idioma_id] UNIQUE NONCLUSTERED 
(
	[idioma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Laboratorio_laboratorio_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Laboratorio] ADD  CONSTRAINT [UQ_Laboratorio_laboratorio_id] UNIQUE NONCLUSTERED 
(
	[laboratorio_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Localidad_localidad_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Localidad] ADD  CONSTRAINT [UQ_Localidad_localidad_id] UNIQUE NONCLUSTERED 
(
	[localidad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Medicamento_medicamento_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Medicamento] ADD  CONSTRAINT [UQ_Medicamento_medicamento_id] UNIQUE NONCLUSTERED 
(
	[medicamento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Patente_patente_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Patente] ADD  CONSTRAINT [UQ_Patente_patente_id] UNIQUE NONCLUSTERED 
(
	[patente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Provincia_provincia_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Provincia] ADD  CONSTRAINT [UQ_Provincia_provincia_id] UNIQUE NONCLUSTERED 
(
	[provincia_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Usuario_usuario_id]    Script Date: 14/07/2016 19:53:21 ******/
ALTER TABLE [dbo].[Usuario] ADD  CONSTRAINT [UQ_Usuario_usuario_id] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [farmacia] SET  READ_WRITE 
GO
