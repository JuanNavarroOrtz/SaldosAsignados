
ALTER PROCEDURE uspDevuelveSaldosAsignados
AS 

	/*Tablas temporales */
	--Saldos 
	DECLARE @Saldos TABLE 
	(Id INT IDENTITY(1,1), 
	Saldo FLOAT)

	--Gestores 
	DECLARE @Gestores TABLE 
	(Id INT IDENTITY(1,1), 
	Gestor VARCHAR(100))

	--SaldosAsignados
	DECLARE @SaldosAsignados TABLE 
	(
		Id INT IDENTITY(1,1),
		IdGestor INT,
		IdSaldo INT
	)

	/*Insertar datos */
	--Insertando datos en tabla saldos 
	INSERT INTO @Saldos 
	VALUES(2277),( 3953),( 4726),( 1414),( 627),( 1784),( 1634),( 3958),( 2156),( 1347),( 2166),( 820),( 2325),( 3613),( 2389),(4130),( 2007),( 3027),( 2591),( 3940),( 3888),( 2975),( 4470),( 2291),( 3393),( 3588),( 3286),( 2293),( 4353),(3315),( 4900),( 794),( 4424),( 4505),( 2643),( 2217),( 4193),( 2893),( 4120),( 3352),( 2355),( 3219),( 3064),( 4893),(272),( 1299),( 4725),( 1900),( 4927),( 4011);

	--Insertando datos en tabla gestores 
	INSERT INTO @Gestores 
	VALUES ('Gestor #  1'),('Gestor #  2'),('Gestor #  3'),('Gestor #  4'),('Gestor #  5'),('Gestor #  6'),('Gestor #  7'),('Gestor #  8'),('Gestor #  9'),('Gestor #  10');

	--Variable cursor 
	DECLARE @Id INT,
			@NumeroMayor INT,
			@IdSaldo INT	

	--Empieza cursor
	DECLARE Gestores CURSOR FOR
	SELECT Id
	FROM @Gestores

	-- Abrir cursor
	OPEN Gestores
	FETCH NEXT FROM Gestores INTO @Id

	-- Recoremos la tabla Gestores
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Buscar el número mayor de la tabla saldos
		SET @NumeroMayor = dbo.ufnDevuelveNMayor(0)
		
		--Mientras número mayor es diferente de cero correr el loop
		WHILE @NumeroMayor <> 0
		BEGIN 
			--Buscar la pk de saldos
			SET @IdSaldo = (SELECT TOP 1 Id FROM @Saldos WHERE Saldo = @NumeroMayor)
			
			-- insertar datos a la tabla Saldos asignados
			INSERT INTO @SaldosAsignados(IdGestor, IdSaldo) VALUES(@Id, @IdSaldo)
			
			--Buscar el siguiente número mayor de la tabla saldos
			SET @NumeroMayor = dbo.ufnDevuelveNMayor(@NumeroMayor)
		END
    
		-- Siguiente linea 
		FETCH NEXT FROM Gestores INTO @Id
	END

	-- Cerrar cursor 
	CLOSE Gestores
	DEALLOCATE Gestores

	--Devolver saldos asignados y por orden descendente 
	SELECT 
	Gestor
	,Saldo
	,IdGestor
	,IdSaldo

	FROM @SaldosAsignados saldAsig

	INNER JOIN @Gestores gest
	ON gest.Id = saldAsig.IdGestor

	INNER JOIN @Saldos sald
	ON sald.Id = saldAsig.IdSaldo

