ALTER FUNCTION ufnDevuelveNMayor
(@NumeroAnterio INT)
RETURNS INT
AS
/*Funci�n orden desendente*/
BEGIN
	DECLARE @NumeroMayor INT
	/*Tablas temporales */
	--Saldos 
	DECLARE @Saldos TABLE 
	(Id INT IDENTITY(1,1), 
	Saldo FLOAT)

	/*Insertar datos */
	--Insertando datos en tabla saldos 
	INSERT INTO @Saldos 
	VALUES(2277),( 3953),( 4726),( 1414),( 627),( 1784),( 1634),( 3958),( 2156),( 1347),( 2166),( 820),( 2325),( 3613),( 2389),(4130),( 2007),( 3027),( 2591),( 3940),( 3888),( 2975),( 4470),( 2291),( 3393),( 3588),( 3286),( 2293),( 4353),(3315),( 4900),( 794),( 4424),( 4505),( 2643),( 2217),( 4193),( 2893),( 4120),( 3352),( 2355),( 3219),( 3064),( 4893),(272),( 1299),( 4725),( 1900),( 4927),( 4011);

	IF (@NumeroAnterio = 0)
		BEGIN
			--Buscamos n�mero mayor 
			SET @NumeroMayor = (SELECT TOP 1 ISNULL(MAX(Saldo), 0)
			FROM @Saldos)
		END 
	ELSE 
		BEGIN	
			--Buscamos n�mero mayor y que sea menor al par�metro establecido en n�mero anterior
			SET @NumeroMayor = (SELECT TOP 1 ISNULL(MAX(Saldo), 0)
			FROM @Saldos
			WHERE saldo < @NumeroAnterio)
		END
	
	--Retornamos n�mero mayor 
	RETURN @NumeroMayor
END