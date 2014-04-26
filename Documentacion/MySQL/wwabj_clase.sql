-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-04-2014 a las 07:01:23
-- Versión del servidor: 5.5.32
-- Versión de PHP: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `wwabj_clase`
--
CREATE DATABASE IF NOT EXISTS `wwabj_clase` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `wwabj_clase`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_crsBuscarCursoxId`(IN x_idCurso INT)
BEGIN
	/**
	*	@Name 	: SP_crsBuscarCursoxId
	*	@Params	: x_idCurso
	*/
	
	SELECT
		vcrs.idCurso,
		vcrs.CursoNombre,
		vcrs.CursoEstado,
		vcrs.CursoFechaCreacion,
		vcrs.CursoFechaEliminacion,
		vcrs.CursoNivelId,
		vcrs.CursoProfesorId,
		vcrs.CursoProfesorNombre,
		vcrs.CursoProfesorFotoUrl,
		vcrs.CursoProfesorFechaNacimiento,
		vcrs.CursoProfesorEstado
	FROM
	view_crscursos AS vcrs
	WHERE
	vcrs.idCurso = x_idCurso;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_crsBuscarCursoxNivel`(IN xNivelId INT)
BEGIN
	/**
	*	@Name 	: SP_crsBuscarCursoxNivel
	*	@Params	: x_idCurso
	*/

	SELECT
		vcrs.idCurso,
		vcrs.CursoNombre,
		vcrs.CursoEstado,
		vcrs.CursoFechaCreacion,
		vcrs.CursoFechaEliminacion,
		vcrs.CursoNivelId,
		vcrs.CursoProfesorId,
		vcrs.CursoProfesorNombre,
		vcrs.CursoProfesorFotoUrl,
		vcrs.CursoProfesorFechaNacimiento,
		vcrs.CursoProfesorEstado
	FROM
	view_crscursos AS vcrs
	WHERE
	vcrs.CursoNivelId = xNivelId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_crsBuscarCursoxNombre`(IN xNombreCurso VARCHAR(200))
BEGIN
	/**
	*	@Name 	: SP_crsBuscarCursoxNombre
	*	@Params	: x_idCurso
	*/
	SELECT
		vcrs.idCurso,
		vcrs.CursoNombre,
		vcrs.CursoEstado,
		vcrs.CursoFechaCreacion,
		vcrs.CursoFechaEliminacion,
		vcrs.CursoNivelId,
		vcrs.CursoProfesorId,
		vcrs.CursoProfesorNombre,
		vcrs.CursoProfesorFotoUrl,
		vcrs.CursoProfesorFechaNacimiento,
		vcrs.CursoProfesorEstado
	FROM
	view_crscursos AS vcrs
	WHERE
	vcrs.CursoNombre LIKE CONCAT('%',xNombreCurso,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_crsBuscarCursoxProfesorId`(IN xProfesorId INT)
BEGIN
	/**
	*	@Name 	: SP_crsBuscarCursoxProfesorId
	*	@Params	: x_idCurso
	*/

	SELECT
		vcrs.idCurso,
		vcrs.CursoNombre,
		vcrs.CursoEstado,
		vcrs.CursoFechaCreacion,
		vcrs.CursoFechaEliminacion,
		vcrs.CursoNivelId,
		vcrs.CursoProfesorId,
		vcrs.CursoProfesorNombre,
		vcrs.CursoProfesorFotoUrl,
		vcrs.CursoProfesorFechaNacimiento,
		vcrs.CursoProfesorEstado
	FROM
	view_crscursos AS vcrs
	WHERE
	vcrs.CursoProfesorId = xProfesorId;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_crsListarCursos`()
BEGIN
	/**
	*	@Name 	: SP_crsListarCursos
	*	@Params	: NULL
	*/
	
	SELECT
		vcrs.idCurso,
		vcrs.CursoNombre,
		vcrs.CursoEstado,
		vcrs.CursoFechaCreacion,
		vcrs.CursoFechaEliminacion,
		vcrs.CursoNivelId,
		vcrs.CursoProfesorId,
		vcrs.CursoProfesorNombre,
		vcrs.CursoProfesorFotoUrl,
		vcrs.CursoProfesorFechaNacimiento,
		vcrs.CursoProfesorEstado,
		vcrs.CursoNivelNombre,
		vcrs.CursoNivelNumero
	FROM
	view_crscursos AS vcrs
	WHERE vcrs.CursoEstado = 1
	;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_crspInsertarCursoPrevio`(IN xUsuarioId INT, IN xUsuarioToken VARCHAR(25),IN xCursoId INT)
BEGIN
	#SP_crspInsertarCursoPrevio
	DECLARE zToken BIT DEFAULT fn_ValidateTokenUser(xUsuarioId,xUsuarioToken);
	IF zToken THEN 
		INSERT INTO  cursoprevioxusuario(
				idcursoprevioxusuario,
				cursoprevioxusuario_estado,
				cursoprevioxusuario_nombre,
				cursoprevioxusuario_fechainsert,
				cursoprevioxusuario_fechadelete,
				idCurso,
				idUsuario
		) VALUES ( NULL , b'1', NULL ,  CURRENT_TIMESTAMP(), NULL , xCursoId ,  xUsuarioId);

		SELECT 'OK' AS 'OK', @@identity AS 'idInsert';
	ELSE
		# Perdida de session o token invalido.
		SELECT '00' AS ERROR, '05' AS ERRORCODE;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_dvDevocionalMostrarUltimo`()
BEGIN
	/**
	*	@Name 	: SP_dvDevocionalMostrarUltimo
	*	@Params	: --
	*/
	DECLARE xDia BIT DEFAULT (SELECT count(dv.idDevocional) FROM devocional AS dv WHERE dv.Devocional_estado = 1 AND DATE_FORMAT(dv.Devocional_fechaPresentacion,'%Y-%m-%d') = DATE_FORMAT(CURRENT_DATE,'%Y-%m-%d') LIMIT 1);
	DECLARE xDiaqSigue BIT DEFAULT (SELECT count(dv.idDevocional) FROM devocional AS dv WHERE dv.Devocional_estado = 1 AND DATE_FORMAT(dv.Devocional_fechaPresentacion,'%Y-%m-%d') > DATE_FORMAT(CURRENT_DATE,'%Y-%m-%d') ORDER BY dv.Devocional_fechaPresentacion ASC LIMIT 1);

	IF xDia = 1 THEN
		SELECT 
			dv.Devocional_Contenido, 
			dv.Devocional_DetalleBiblico, 
			dv.Devocional_estado, 
			dv.Devocional_fechaPresentacion 
		FROM devocional AS dv 
		WHERE dv.Devocional_estado = 1 
		AND DATE_FORMAT(dv.Devocional_fechaPresentacion,'%Y-%m-%d') = DATE_FORMAT(CURRENT_DATE,'%Y-%m-%d') LIMIT 1;
	ELSEIF xDiaqSigue = 1 THEN 
		SELECT 
			dv.Devocional_Contenido, 
			dv.Devocional_DetalleBiblico, 
			dv.Devocional_estado, 
			dv.Devocional_fechaPresentacion 
		FROM devocional AS dv 
		WHERE dv.Devocional_estado = 1 
		AND DATE_FORMAT(dv.Devocional_fechaPresentacion,'%Y-%m-%d') > DATE_FORMAT(CURRENT_DATE,'%Y-%m-%d') 
		ORDER BY dv.Devocional_fechaPresentacion ASC LIMIT 1;
	ELSE
		SELECT 
			dv.Devocional_Contenido, 
			dv.Devocional_DetalleBiblico, 
			dv.Devocional_estado, 
			dv.Devocional_fechaPresentacion 
		FROM devocional AS dv 
		WHERE dv.Devocional_estado = 1 
		ORDER BY dv.Devocional_fechaPresentacion DESC LIMIT 1;
	END IF;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_supListarSupervisor`()
BEGIN
	/**
	*	@Name 	: SP_supListarSupervisor
	*	@Params	: x_idCurso
	*/
	SELECT
		sp.idSupervisor,
		sp.Supervisor_Nombres,
		sp.Supervisor_codigo,
		sp.Supervisor_fotoURL,
		sp.Supervisor_Email,
		sp.Supervisor_fechaNacimiento,
		sp.Supervisor_estado,
		sp.Supervisor_fechaCreacion,
		sp.Supervisor_fechaEliminacion,
		sp.idColaboradores
	FROM supervisor AS sp
	WHERE sp.Supervisor_estado = 1
	;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usBuscarUsuario`(IN xSearchText VARCHAR(70))
BEGIN
	/**
	*	@Name 	: SP_usBuscarUsuario
	*	@Params	: xSearchText
	*/
	SELECT 
		uss.idUsuario 								AS idUsuario,
		uss.UsuarioFotoURL 						AS FotoUrl,
		uss.UsuarioNombres 						AS Nombres,
		uss.UsuarioEmail							AS Email,
		uss.UsuarioFechaNacimiento		AS FechaNacimiento,
		uss.UsuarioSupervisorNombres	AS Supervisor
	FROM view_usdatosdeusuario as uss
	WHERE uss.UsuarioNombres LIKE (concat('%',xSearchText,'%')) OR uss.UsuarioEmail = xSearchText OR uss.UsuarioEmail LIKE (concat(xSearchText,'@%'))
;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usBuscarUsuarioId`(IN xUsuarioId INT)
BEGIN
	/**
	*	@Name 	: SP_usBuscarUsuarioId
	*	@Params	: xUsuarioId
	*/
	SELECT 
		uss.idUsuario 								AS idUsuario,
		uss.UsuarioFotoURL 						AS FotoUrl,
		uss.UsuarioNombres 						AS Nombres,
		uss.UsuarioEmail							AS Email,
		uss.UsuarioFechaNacimiento		AS FechaNacimiento,
		uss.UsuarioSupervisorNombres	AS Supervisor,
		uss.UsuarioToken							AS Token,
		uss.UsuarioCodigoActivacion 	AS CodigoActivacion
	FROM view_usdatosdeusuario as uss
	WHERE uss.idUsuario = xUsuarioId
;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usConfirmarActivacionUsuario`(IN xUsuarioId INT,IN xUsuarioCodigo VARCHAR(25), IN xToken VARCHAR(25))
BEGIN
	/**
	*	@Name 	: SP_usConfirmarActivacionUsuario
	*	@Params	: UsuarioId, UsuarioPassword, Token
	*/
	
	DECLARE zISToken BIT DEFAULT fn_ValidateTokenUser(xUsuarioId ,xToken);
	DECLARE zUsuarioCodigoActivacion VARCHAR(25) DEFAULT (SELECT vuss.UsuarioCodigoActivacion FROM view_usdatosdeusuario AS vuss WHERE vuss.idUsuario = xUsuarioId LIMIT 1);
	DECLARE zUsuarioDatosId INT DEFAULT (SELECT vusd.UsuarioDatosId FROM view_usdatosdeusuario AS vusd WHERE vusd.idUsuario = xUsuarioId LIMIT 1);
	IF zISToken = 1 THEN
			IF zUsuarioCodigoActivacion IS NOT NULL AND zUsuarioCodigoActivacion = xUsuarioCodigo THEN 
				UPDATE usuariodatos SET usuariodatos_codigoActivacion = NULL WHERE idusuariodatos = zUsuarioDatosId;
				SELECT 'OK' AS OK;
			ELSEIF zUsuarioCodigoActivacion IS NULL THEN
				# Usuario ya Confirmo su cuenta de correo
				SELECT '00' AS ERROR, '01' AS ERRORCODE;
			ELSE 
				# Error codigo incorrecto
				SELECT '00' AS ERROR, '02' AS ERRORCODE;
			END IF;
		ELSE 
			# Error de validacion
			SELECT '00' AS ERROR, '06' AS ERRORCODE;
		END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usCrearUsuario`(IN xUsuarioNombre VARCHAR(500),IN xUsuarioDNI VARCHAR(8),IN xUsuarioFechaNacimiento DATETIME,IN xUsuarioFotoURL VARCHAR(300),IN xUsuarioUBIGEO VARCHAR(100),IN xUsuarioEmail VARCHAR(70), IN xUsuarioPassword VARCHAR(25), IN xSupervisorId INT)
BEGIN
	/**
	*	@Name 	: SP_usCrearUsuario
	*	@Params	: todos los datos de usuario
	*/
	
	DECLARE zUltimoInsertID INT;
	DECLARE zUltimoUsuarioID INT;
	DECLARE zExisteUsuario INT DEFAULT (SELECT COUNT(*) from usuariodatos WHERE usuariodatos_email = xUsuarioEmail LIMIT 1);
	# verificar existencia de email
	IF zExisteUsuario >= 1 THEN
		SELECT '00' AS ERROR, 'USUARIO YA EXISTE' AS DESCRIPCION;
	ELSE
		# Insertar Datos de Usuario (usuariodatos)
		INSERT INTO usuariodatos(
			idusuariodatos, 
			usuariodatos_email, 
			usuariodatos_token, 
			usuariodatos_facebookKEY, 
			usuariodatos_password, 
			idSupervisor, 
			usuariodatos_codigoActivacion
		) VALUES (NULL, xUsuarioEmail , fn_newUserToken(), NULL, xUsuarioPassword, xSupervisorId, fn_newCodigoActivacion());

		# Conseguimos el Id del elemento insertado. 
		SET zUltimoInsertID = @@identity;
		
		# Insertamos la Parte Principal de usuario 
		INSERT INTO usuario(
			idUsuario, 
			Usuario_Nombres, 
			idusuariodatos, 
			Usuario_dni, 
			Usuario_direccionUBIGEO, 
			Usuario_fechaNacimiento, 
			Usuario_estado, 
			Usuario_fechaEliminacion, 
			Usuario_fotoURL, 
			Usuario_fechaCreacion
		) VALUES (NULL, xUsuarioNombre, zUltimoInsertID, xUsuarioDNI, xUsuarioUBIGEO, xUsuarioFechaNacimiento, b'1', NULL, xUsuarioFotoURL, CURRENT_TIMESTAMP());

		SET zUltimoUsuarioID = LAST_INSERT_ID();

		SELECT 
			usUsuario.idUsuario,
			usUsuario.Usuario_Nombres,
			usDatos.usuariodatos_email,
			usDatos.usuariodatos_token,
			usDatos.usuariodatos_codigoActivacion,
			usUsuario.Usuario_fechaCreacion,
			usUsuario.Usuario_estado,
			usDatos.idusuariodatos
		FROM usuario AS usUsuario ,usuariodatos AS usDatos
		WHERE usUsuario.idUsuario = zUltimoUsuarioID
		AND usDatos.idusuariodatos = zUltimoInsertID
		;


		# Retornamos los Datos del Usuario Creado
		/*	SELECT 
				idUsuario,
				UsuarioEmail,
				UsuarioPassword,
				UsuarioToken,
				UsuarioNombres,
				UsuarioFotoURL,
				UsuarioEstado,
				UsuarioDNI,
				UsuarioFechaNacimiento,
				UsuarioUBIGEO,
				UsuarioSupervisorId,
				UsuarioSupervisorNombres,
				UsuarioFacebookKEY,
				UsuarioFechaCreacion,
				UsuarioFechaEliminacion,
				UsuarioDatosId,
				UsuarioCodigoActivacion
			FROM view_usdatosdeusuario
			WHERE idUsuario = zUltimoUsuarioID; */
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usEliminarUsuario`(IN xUsuarioId INT, IN xUsuarioPassword VARCHAR(25), IN xToken VARCHAR(25))
BEGIN
	/**
	*	@Name 	: SP_usEliminarUsuario
	*	@Params	: UsuarioId, UsuarioPassword, Token
	*/
	
	DECLARE zISToken BIT DEFAULT fn_ValidateTokenUser(xUsuarioId ,xToken);
	DECLARE zISPassword BIT DEFAULT fn_UserIdValidatePassword(xUsuarioId,xUsuarioPassword);
	DECLARE zISActiveNO BIT DEFAULT (SELECT COUNT(idUsuario) FROM view_usdatosdeusuario WHERE idUsuario = xUsuarioId and UsuarioEstado = 0);
	IF zISToken = 1 THEN
		IF zISPassword = 1 THEN 
			IF zISActiveNO = 0 THEN 
				UPDATE usuario SET Usuario_estado = 0, Usuario_fechaEliminacion = CURRENT_TIMESTAMP() WHERE idUsuario = xUsuarioId;
				SELECT 'OK' AS OK, UsuarioFechaEliminacion AS FechaEliminacion FROM view_usdatosdeusuario WHERE idUsuario = xUsuarioId;
			ELSE
				# Accion ya realizada (usuario esta desactivado)
				SELECT '00' AS ERROR, '06' AS ERRORCODE;
			END IF;
		ELSE 
			# Error de validacion
			SELECT '00' AS ERROR, '01' AS ERRORCODE;
		END IF;
	ELSE 
		# Perdida de session o token invalido.
		SELECT '00' AS ERROR, '05' AS ERRORCODE;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usIniciarSession`(IN xUsuarioEmail VARCHAR(70), IN xUsuarioPassword VARCHAR(25))
BEGIN
	/**
	*	@Name 	: SP_usIniciarSession
	*	@Params	: UsuarioEmail, UsuarioPassword
	*/
	DECLARE iToken VARCHAR(25) DEFAULT fn_newUserToken();
	DECLARE isOK BIT DEFAULT 0;
	DECLARE idDatos INT DEFAULT 0;
	IF(xUsuarioEmail IS NOT NULL and xUsuarioPassword IS NOT NULL) THEN
		SET isOK = (SELECT COUNT(v_us.idUsuario) FROM view_usdatosdeusuario AS v_us WHERE v_us.UsuarioEmail = xUsuarioEmail and v_us.UsuarioPassword = BINARY xUsuarioPassword );
		IF isOK IS NOT NULL and isOK != 0 THEN
		SET idDatos = (SELECT v_us.UsuarioDatosId FROM view_usdatosdeusuario AS v_us WHERE v_us.UsuarioEmail = xUsuarioEmail and v_us.UsuarioPassword = BINARY xUsuarioPassword );
		
		# Actualizamos el Token en la session
		UPDATE usuariodatos SET usuariodatos_token = fn_newUserToken() WHERE idusuariodatos = idDatos;

				SELECT 
					idUsuario,
					UsuarioEmail,
					UsuarioPassword,
					UsuarioToken,
					UsuarioNombres,
					UsuarioFotoURL,
					UsuarioEstado,
					UsuarioDNI,
					UsuarioFechaNacimiento,
					UsuarioUBIGEO,
					UsuarioSupervisorId,
					UsuarioSupervisorNombres,
					UsuarioFacebookKEY,
					UsuarioFechaCreacion,
					UsuarioFechaEliminacion,
					UsuarioDatosId
				FROM view_usdatosdeusuario
				WHERE UsuarioEmail = xUsuarioEmail and UsuarioPassword = xUsuarioPassword;
		END IF;
	END IF;
	
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usNuevoCodigoActivacion`(IN xidUsuario INT, IN xUsuarioToken VARCHAR(25))
BEGIN
	/**
	*	@Name 	: SP_usNuevoCodigoActivacion
	*	@Params	: UsuarioEmail, UsuarioPassword
	*/
	DECLARE iNuevoCodigoActivacion VARCHAR(7) DEFAULT fn_newCodigoActivacion();
	DECLARE isTokenCorrect BIT DEFAULT 0;

	IF xidUsuario IS NOT NULL and xUsuarioToken IS NOT NULL THEN 
		SET isTokenCorrect = fn_ValidateTokenUser(xidUsuario,xUsuarioToken);
		IF isTokenCorrect IS NOT NULL and isTokenCorrect != 0 THEN
			SELECT 'CORRECT';
		END IF;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usUpdateUsuarioDatosBasicos`(IN xUsuarioId INT, IN xUsuarioToken VARCHAR(25), IN xUsuarioSexo BIT, IN xUsuarioFechaNacimiento DATE, IN xUsuarioSupervisorId INT , IN xUsuarioFotoUrl VARCHAR(200))
BEGIN
	# SP_usUpdateUsuarioDatosBasicos
	DECLARE zToken BIT DEFAULT fn_ValidateTokenUser(xUsuarioId,xUsuarioToken);
	DECLARE zUsuarioDatosID INT DEFAULT (SELECT idusuariodatos FROM usuario WHERE idUsuario = xUsuarioId LIMIT 1);
	IF zToken THEN 
		# Agregar los datos
		UPDATE  usuario SET  
				Usuario_fechaNacimiento =  xUsuarioFechaNacimiento,
				Usuario_fotoURL = xUsuarioFotoUrl,
				Usuario_sexo 		= xUsuarioSexo  	
		WHERE idUsuario = xUsuarioId;

		# Agregar el supervisor 
		UPDATE usuariodatos SET 
				idSupervisor = xUsuarioSupervisorId
			WHERE idusuariodatos = zUsuarioDatosID;

		SELECT 'OK' AS 'OK';
	ELSE
		# Perdida de session o token invalido.
		SELECT '00' AS ERROR, '05' AS ERRORCODE;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usUsuariosxSupervisorId`(IN xSupervisorId INT)
BEGIN
	/**
	*	@Name 	: SP_usUsuariosxSupervisorId
	*	@Params	: xSupervisorId
	*/

	SELECT
		uss.idUsuario								AS idUsuario,
		uss.UsuarioNombres					AS Nombres,
		uss.UsuarioEmail						AS Email,
		uss.UsuarioFotoURL					AS FotoUrl,
		uss.UsuarioFechaNacimiento	AS FechaNacimiento
	FROM view_usdatosdeusuario AS uss
	WHERE uss.UsuarioSupervisorId = xSupervisorId;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_newCodigoActivacion`() RETURNS varchar(7) CHARSET utf8
BEGIN
	/**
	*	@Name		: fn_newCodigoActivacion
	* @Params : no Params
	* @Date 	: 20/02/2014
	*/
	DECLARE iCodigo VARCHAR(7) DEFAULT FLOOR(1010101 + RAND( ) * 9876540);
	RETURN iCodigo;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_newUserToken`() RETURNS varchar(25) CHARSET utf8
BEGIN
	/**
	*	@Name		: fn_newUserToken
	* @Params : no Params
	* @Date 	: 20/02/2014
	*/
	DECLARE iTokenGenerado VARCHAR(25) DEFAULT MD5(CURRENT_TIMESTAMP());
	SET iTokenGenerado = MD5(SHA1(CONCAT(CURRENT_TIMESTAMP(), RAND())));
	RETURN iTokenGenerado;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_UserIdValidatePassword`(xUsuarioId INT,  xUsuarioPassword VARCHAR(25)) RETURNS bit(1)
BEGIN
	/**
	*	@Name		: fn_UserIdValidatePassword
	* @Params : xUsuarioId, xUsuarioPassword
	* @Date 	: 20/02/2014
	*/
	DECLARE zESValido BIT DEFAULT 0;
	SET zESValido = (SELECT count(idUsuario) FROM view_usdatosdeusuario WHERE idUsuario = xUsuarioId and UsuarioPassword = BINARY xUsuarioPassword);
	IF zESValido > 0 THEN 
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_ValidateTokenUser`(xidUsuario INT,xUsuarioToken VARCHAR(25)) RETURNS bit(1)
BEGIN
	/**
	*	@Name		: fn_ValidateTokenUser
	* @Params : xidUsuario, xUsuarioToken
	* @Date 	: 20/02/2014
	*/
	DECLARE zExiste INT DEFAULT 0;

	SET zExiste = (select count(idUsuario) from view_usdatosdeusuario where idUsuario = xidUsuario and UsuarioToken = xUsuarioToken);
	IF zExiste > 0 THEN 
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE IF NOT EXISTS `actividades` (
  `idActividades` int(11) NOT NULL AUTO_INCREMENT,
  `Actividades_estado` bit(1) DEFAULT b'1',
  `Actividades_ImagenURL` varchar(300) DEFAULT NULL,
  `Actividades_fechaCreacion` datetime DEFAULT NULL,
  `Actividades_fechadelEvento` datetime DEFAULT NULL,
  `Actividades_fechaEliminacion` datetime DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idActividades`),
  KEY `fkActividades_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

CREATE TABLE IF NOT EXISTS `administradores` (
  `idAdministradores` int(11) NOT NULL AUTO_INCREMENT,
  `Administradores_Nombres` varchar(500) DEFAULT NULL,
  `Administradores_Descripcion` longtext,
  `Administradores_fotoURL` varchar(300) DEFAULT NULL,
  `Administradores_DNI` varchar(25) DEFAULT NULL,
  `Administradores_fechaNacimiento` datetime DEFAULT NULL,
  PRIMARY KEY (`idAdministradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE IF NOT EXISTS `asistencia` (
  `idAsistencia` int(11) NOT NULL AUTO_INCREMENT,
  `Asistencia_fecha` datetime DEFAULT NULL,
  `idfolder` int(11) NOT NULL,
  `idSupervisor` int(11) NOT NULL,
  `Asistencia_asistio` bit(1) DEFAULT b'1',
  `idcursosxusuario` int(11) NOT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAsistencia`),
  KEY `fkAsistencia_folder1_idx` (`idfolder`),
  KEY `fkAsistencia_Supervisor1_idx` (`idSupervisor`),
  KEY `fkAsistencia_cursosxusuario1_idx` (`idcursosxusuario`),
  KEY `fkAsistencia_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistenciasupervisada`
--

CREATE TABLE IF NOT EXISTS `asistenciasupervisada` (
  `idAsistenciaSupervisada` int(11) NOT NULL AUTO_INCREMENT,
  `AsistenciaSupervisada_fechaAuditoria` datetime DEFAULT NULL,
  `AsistenciaSupervisada_Observacion` longtext,
  `idProfesor` int(11) NOT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAsistenciaSupervisada`),
  KEY `fkAsistenciaSupervisada_Profesor1_idx` (`idProfesor`),
  KEY `fkAsistenciaSupervisada_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

CREATE TABLE IF NOT EXISTS `aula` (
  `idAula` int(11) NOT NULL AUTO_INCREMENT,
  `Aula_Nombre` varchar(200) DEFAULT NULL,
  `Aula_Codigo` varchar(200) DEFAULT NULL,
  `Aula_Estado` bit(1) DEFAULT b'1',
  `Aula_Descripcion` varchar(500) DEFAULT NULL,
  `Aula_AforoMaximo` int(11) DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAula`),
  KEY `fkAula_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colaboradores`
--

CREATE TABLE IF NOT EXISTS `colaboradores` (
  `idColaboradores` int(11) NOT NULL AUTO_INCREMENT,
  `Colaboradores_Codigo` varchar(200) DEFAULT NULL,
  `idAdministradores` int(11) DEFAULT NULL,
  `Colaboradores_fotoURL` varchar(300) DEFAULT NULL,
  `idPerfilGrupoPermiso` int(11) NOT NULL,
  `idColaboradorCreador` int(11) DEFAULT NULL,
  PRIMARY KEY (`idColaboradores`,`idPerfilGrupoPermiso`),
  KEY `fkSupervisores_Administradores1_idx` (`idAdministradores`),
  KEY `fkColaboradores_PerfilGrupoPermiso1_idx` (`idPerfilGrupoPermiso`),
  KEY `fkColaboradores_Colaboradores1_idx` (`idColaboradorCreador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE IF NOT EXISTS `curso` (
  `idCurso` int(11) NOT NULL AUTO_INCREMENT,
  `Curso_Nombre` varchar(300) DEFAULT NULL,
  `Curso_estado` bit(1) NOT NULL DEFAULT b'1',
  `Curso_fechaCreacion` datetime NOT NULL,
  `Curso_fechaEliminacion` datetime DEFAULT NULL,
  `idnivel` int(11) NOT NULL,
  `idProfesor` int(11) NOT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCurso`),
  KEY `fkCurso_nivel1_idx` (`idnivel`),
  KEY `fkCurso_Profesor1_idx` (`idProfesor`),
  KEY `fkCurso_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`idCurso`, `Curso_Nombre`, `Curso_estado`, `Curso_fechaCreacion`, `Curso_fechaEliminacion`, `idnivel`, `idProfesor`, `idColaboradores`) VALUES
(3, 'Primeros Pasos de la biblia', b'1', '2014-04-18 08:38:46', NULL, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursoprevioxusuario`
--

CREATE TABLE IF NOT EXISTS `cursoprevioxusuario` (
  `idcursoprevioxusuario` int(11) NOT NULL AUTO_INCREMENT,
  `cursoprevioxusuario_estado` bit(1) DEFAULT b'1',
  `cursoprevioxusuario_nombre` varchar(200) DEFAULT NULL,
  `cursoprevioxusuario_fechainsert` datetime DEFAULT NULL,
  `cursoprevioxusuario_fechadelete` datetime DEFAULT NULL,
  `idCurso` int(11) DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcursoprevioxusuario`),
  KEY `fkcursoprevioxusuario_Curso1_idx` (`idCurso`),
  KEY `fkcursoprevioxusuario_Usuario1_idx` (`idUsuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `cursoprevioxusuario`
--

INSERT INTO `cursoprevioxusuario` (`idcursoprevioxusuario`, `cursoprevioxusuario_estado`, `cursoprevioxusuario_nombre`, `cursoprevioxusuario_fechainsert`, `cursoprevioxusuario_fechadelete`, `idCurso`, `idUsuario`) VALUES
(1, b'1', NULL, '2014-04-20 00:00:00', NULL, 3, 204),
(2, b'1', NULL, '2014-04-20 11:27:49', NULL, 3, 203),
(3, b'1', NULL, '2014-04-20 11:28:41', NULL, 3, 203),
(4, b'1', NULL, '2014-04-20 11:28:45', NULL, 3, 203),
(5, b'1', NULL, '2014-04-20 11:29:22', NULL, 3, 203),
(6, b'1', NULL, '2014-04-20 11:29:22', NULL, 3, 204),
(7, b'1', NULL, '2014-04-20 13:36:05', NULL, 3, 205),
(8, b'1', NULL, '2014-04-20 13:36:23', NULL, 3, 205);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursosxprofesor`
--

CREATE TABLE IF NOT EXISTS `cursosxprofesor` (
  `idCursosxProfesor` int(11) NOT NULL AUTO_INCREMENT,
  `CursosxProfesor_fechaActiva` datetime DEFAULT NULL,
  `CursosxProfesor_fechaEliminacion` datetime DEFAULT NULL,
  `CursosxProfesor_estado` bit(1) DEFAULT b'1',
  `idProfesor` int(11) NOT NULL,
  `idCurso` int(11) NOT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idCursosxProfesor`),
  KEY `fkCursosxProfesor_Profesor1_idx` (`idProfesor`),
  KEY `fkCursosxProfesor_Curso1_idx` (`idCurso`),
  KEY `fkCursosxProfesor_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursosxusuario`
--

CREATE TABLE IF NOT EXISTS `cursosxusuario` (
  `idcursosxusuario` int(11) NOT NULL AUTO_INCREMENT,
  `cursosxusuario_estado` bit(1) DEFAULT b'1',
  `cursosxusuario_fechaRegistro` datetime DEFAULT NULL,
  `idfolder` int(11) NOT NULL,
  `cursosxusuario_activeKEY` varchar(25) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL,
  `cursosxusuario_NotaFinal` int(11) DEFAULT NULL,
  `cursosxusuario_AproboCurso` bit(1) DEFAULT b'1',
  PRIMARY KEY (`idcursosxusuario`),
  KEY `fkcursosxusuario_folder1_idx` (`idfolder`),
  KEY `fkcursosxusuario_Usuario1_idx` (`idUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devocional`
--

CREATE TABLE IF NOT EXISTS `devocional` (
  `idDevocional` int(11) NOT NULL AUTO_INCREMENT,
  `Devocional_fechaCreacion` datetime DEFAULT NULL,
  `Devocional_fechaPresentacion` datetime DEFAULT NULL,
  `Devocional_Contenido` longtext,
  `Devocional_DetalleBiblico` varchar(200) DEFAULT NULL,
  `Devocional_estado` bit(1) DEFAULT b'1',
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idDevocional`),
  KEY `fkDevocional_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `folder`
--

CREATE TABLE IF NOT EXISTS `folder` (
  `idfolder` int(11) NOT NULL AUTO_INCREMENT,
  `folder_estado` bit(1) DEFAULT b'1',
  `folder_descripcion` varchar(700) DEFAULT NULL,
  `folder_Costo` float DEFAULT '0',
  `idCurso` int(11) NOT NULL,
  `idAula` int(11) NOT NULL,
  `idhorarios` int(11) NOT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idfolder`,`idCurso`),
  KEY `fkfolder_Aula1_idx` (`idAula`),
  KEY `fkfolder_horarios1_idx` (`idhorarios`),
  KEY `fkfolder_Curso1_idx` (`idCurso`),
  KEY `fkfolder_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeriadefotos`
--

CREATE TABLE IF NOT EXISTS `galeriadefotos` (
  `idGaleriadeFotos` int(11) NOT NULL AUTO_INCREMENT,
  `GaleriadeFotos_URL` varchar(300) DEFAULT NULL,
  `GaleriadeFotos_estado` bit(1) DEFAULT b'1',
  `GaleriadeFotos_CarpetaName` varchar(200) DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idGaleriadeFotos`),
  KEY `fkGaleriadeFotos_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

CREATE TABLE IF NOT EXISTS `horarios` (
  `idhorarios` int(11) NOT NULL AUTO_INCREMENT,
  `horarios_fechaCreacion` datetime DEFAULT NULL,
  `horarios_fechaInicio` datetime DEFAULT NULL,
  `horarios_fechaFinal` datetime DEFAULT NULL,
  `horarios_estado` bit(1) NOT NULL DEFAULT b'1',
  `horarios_diasdesemana` varchar(7) DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idhorarios`),
  KEY `fkhorarios_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenesweb`
--

CREATE TABLE IF NOT EXISTS `imagenesweb` (
  `idimagenesweb` int(11) NOT NULL AUTO_INCREMENT,
  `imagenesweb_url` varchar(200) DEFAULT NULL,
  `imagenesweb_estado` bit(1) DEFAULT b'1',
  `size_height` int(11) DEFAULT NULL,
  `size_width` int(11) DEFAULT NULL,
  `idtipo_objeto` int(11) DEFAULT NULL,
  PRIMARY KEY (`idimagenesweb`),
  KEY `fkimagenesweb_tipo_objeto1_idx` (`idtipo_objeto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel`
--

CREATE TABLE IF NOT EXISTS `nivel` (
  `idnivel` int(11) NOT NULL AUTO_INCREMENT,
  `nivel_estado` varchar(200) DEFAULT '1',
  `nivel_nombre` varchar(200) DEFAULT NULL,
  `nivel_numero` int(11) DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idnivel`),
  KEY `fknivel_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `nivel`
--

INSERT INTO `nivel` (`idnivel`, `nivel_estado`, `nivel_nombre`, `nivel_numero`, `idColaboradores`) VALUES
(1, '1', 'uno', 1, NULL),
(2, '1', 'dos', 2, NULL),
(3, '1', 'tres', 3, NULL),
(4, '1', 'cuatro', 4, NULL),
(5, '1', 'cinco', 5, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfilgrupopermiso`
--

CREATE TABLE IF NOT EXISTS `perfilgrupopermiso` (
  `idPerfilGrupoPermiso` int(11) NOT NULL,
  `FechaCreacion` datetime DEFAULT NULL,
  `FechaEliminacion` datetime DEFAULT NULL,
  `Estado` bit(1) DEFAULT b'1',
  `idtipo_acceso` int(11) NOT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPerfilGrupoPermiso`,`idtipo_acceso`),
  KEY `fkPerfilGrupoPermiso_tipo_acceso1_idx` (`idtipo_acceso`),
  KEY `fkPerfilGrupoPermiso_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE IF NOT EXISTS `profesor` (
  `idProfesor` int(11) NOT NULL AUTO_INCREMENT,
  `Profesor_Nombres` varchar(500) DEFAULT NULL,
  `Profesor_estado` bit(1) NOT NULL DEFAULT b'1',
  `Profesor_DNI` varchar(25) DEFAULT NULL,
  `Profesor_fotoURL` varchar(300) DEFAULT NULL,
  `Profesor_Descripcion` longtext,
  `Profesor_fechaNacimiento` datetime DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idProfesor`),
  KEY `fkProfesor_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`idProfesor`, `Profesor_Nombres`, `Profesor_estado`, `Profesor_DNI`, `Profesor_fotoURL`, `Profesor_Descripcion`, `Profesor_fechaNacimiento`, `idColaboradores`) VALUES
(1, 'Albert Piu', b'1', '777777777', 'piu.png', 'Profe Piu', '1993-11-05 08:44:57', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `slidertransicion`
--

CREATE TABLE IF NOT EXISTS `slidertransicion` (
  `idSliderTransicion` int(11) NOT NULL AUTO_INCREMENT,
  `SliderTransicion_fechaCreacion` datetime DEFAULT NULL,
  `SliderTransicion_fechaAparicion` datetime DEFAULT NULL,
  `SliderTransicion_fechaDestruccion` datetime DEFAULT NULL,
  `SliderTransicion_ImagenURL` varchar(300) DEFAULT NULL,
  `SliderTransicion_TextoHTML` longtext,
  `SliderTransicion_enlaceButton` varchar(400) DEFAULT NULL,
  `SliderTransicion_TextodelBoton` varchar(200) DEFAULT NULL,
  `SliderTransicion_estado` bit(1) DEFAULT b'1',
  `SliderTransicion_fechaEliminacion` datetime DEFAULT NULL,
  `SliderTransicionTitle` varchar(200) DEFAULT NULL,
  `SliderTransicionTitleColor` varchar(100) DEFAULT NULL,
  `SliderTransicionTextColor` varchar(100) DEFAULT NULL,
  `SliderTransicionInfoDirection` varchar(100) DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  `SliderTransicionTime` int(11) DEFAULT NULL,
  `SliderButtonOnOff` bit(1) DEFAULT b'1',
  PRIMARY KEY (`idSliderTransicion`),
  KEY `fkSliderTransicion_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supervisor`
--

CREATE TABLE IF NOT EXISTS `supervisor` (
  `idSupervisor` int(11) NOT NULL AUTO_INCREMENT,
  `Supervisor_Nombres` varchar(250) DEFAULT NULL,
  `Supervisor_codigo` varchar(200) DEFAULT NULL,
  `Supervisor_fotoURL` varchar(350) DEFAULT NULL,
  `Supervisor_Email` varchar(200) DEFAULT NULL,
  `Supervisor_fechaNacimiento` datetime DEFAULT NULL,
  `Supervisor_estado` bit(1) NOT NULL DEFAULT b'1',
  `Supervisor_fechaCreacion` datetime DEFAULT NULL,
  `Supervisor_fechaEliminacion` datetime DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSupervisor`),
  KEY `fkSupervisor_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `supervisor`
--

INSERT INTO `supervisor` (`idSupervisor`, `Supervisor_Nombres`, `Supervisor_codigo`, `Supervisor_fotoURL`, `Supervisor_Email`, `Supervisor_fechaNacimiento`, `Supervisor_estado`, `Supervisor_fechaCreacion`, `Supervisor_fechaEliminacion`, `idColaboradores`) VALUES
(1, 'Flor', '0968989', 'foto.jpg', 'flor@email.com', '2014-04-18 09:53:28', b'1', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_acceso`
--

CREATE TABLE IF NOT EXISTS `tipo_acceso` (
  `idtipo_acceso` int(11) NOT NULL COMMENT '1 :: ver\n2 :: ver - crear\n3 :: ver - crear - editar\n4 :: ver - crear - editar - borrar ',
  `CreaciondeCursos` enum('1','2','3','4') DEFAULT NULL,
  `SupervisarAsistencia` enum('1','2','3','4') DEFAULT NULL,
  `PermisoAulas` enum('1','2','3','4') DEFAULT NULL,
  `PermisoHorarios` enum('1','2','3','4') DEFAULT NULL,
  `PermisoFolder` enum('1','2','3','4') DEFAULT NULL,
  `PermisoProfesores` enum('1','2','3','4') DEFAULT NULL,
  `PermisoActividades` enum('1','2','3','4') DEFAULT NULL,
  `PermisoNiveles` enum('1','2','3','4') DEFAULT NULL,
  `PermisoAdministradores` enum('1','2','3','4') DEFAULT NULL,
  `PermisoSliderTransicion` enum('1','2','3','4') DEFAULT NULL,
  `PermisosDevocional` enum('1','2','3','4') DEFAULT NULL,
  `PermisoGaleriaFotos` enum('1','2','3','4') DEFAULT NULL,
  `PermisoUsuarios` enum('1','2','3','4') DEFAULT NULL,
  `PermisoAsistencia` enum('1','2','3','4') DEFAULT NULL,
  `PermisoColaboradores` enum('1','2','3','4') DEFAULT NULL,
  `PermisoSupervisor` enum('1','2','3','4') DEFAULT NULL,
  `PermisoTomarAsistenciaOcacional` bit(1) NOT NULL,
  `PermisoAprobacionCursoxUsuario` bit(1) NOT NULL,
  PRIMARY KEY (`idtipo_acceso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_objeto`
--

CREATE TABLE IF NOT EXISTS `tipo_objeto` (
  `idtipo_objeto` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_objeto_codigo` varchar(11) NOT NULL,
  `tipo_objeto_descripcion` varchar(200) DEFAULT NULL,
  `tipo_objeto_estado` bit(1) DEFAULT b'1',
  `tipo_objeto_codigo_padre` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`idtipo_objeto`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `tipo_objeto`
--

INSERT INTO `tipo_objeto` (`idtipo_objeto`, `tipo_objeto_codigo`, `tipo_objeto_descripcion`, `tipo_objeto_estado`, `tipo_objeto_codigo_padre`) VALUES
(1, 'COD00000001', 'Imagen de portada', b'1', NULL),
(2, 'COD00000002', 'Portada del Home', b'1', 'COD00000001');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Usuario_Nombres` varchar(200) DEFAULT NULL,
  `idusuariodatos` int(11) NOT NULL,
  `Usuario_dni` varchar(25) DEFAULT NULL,
  `Usuario_direccionUBIGEO` varchar(200) DEFAULT NULL,
  `Usuario_fechaNacimiento` date DEFAULT NULL,
  `Usuario_estado` bit(1) DEFAULT b'1',
  `Usuario_fechaEliminacion` datetime DEFAULT NULL,
  `Usuario_fotoURL` varchar(300) DEFAULT NULL,
  `Usuario_fechaCreacion` datetime DEFAULT NULL,
  `Usuario_sexo` bit(1) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`,`idusuariodatos`),
  KEY `fkUsuario_usuariodatos1_idx` (`idusuariodatos`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=207 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `Usuario_Nombres`, `idusuariodatos`, `Usuario_dni`, `Usuario_direccionUBIGEO`, `Usuario_fechaNacimiento`, `Usuario_estado`, `Usuario_fechaEliminacion`, `Usuario_fotoURL`, `Usuario_fechaCreacion`, `Usuario_sexo`) VALUES
(203, 'gianpiere Ramos', 205, NULL, NULL, NULL, b'1', NULL, NULL, '2014-04-12 08:49:44', NULL),
(204, 'Thais', 206, NULL, NULL, NULL, b'1', NULL, NULL, '2014-04-19 16:22:33', NULL),
(205, 'Kevin Cordova', 207, NULL, NULL, '2014-04-16', b'1', NULL, '0', '2014-04-20 11:56:26', b'1'),
(206, 'Daylin Elizabeth', 208, NULL, NULL, NULL, b'1', NULL, NULL, '2014-04-20 13:41:48', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariodatos`
--

CREATE TABLE IF NOT EXISTS `usuariodatos` (
  `idusuariodatos` int(11) NOT NULL AUTO_INCREMENT,
  `usuariodatos_email` varchar(70) DEFAULT NULL,
  `usuariodatos_token` varchar(25) DEFAULT NULL,
  `usuariodatos_facebookKEY` varchar(200) DEFAULT NULL,
  `usuariodatos_password` varchar(400) DEFAULT NULL,
  `idSupervisor` int(11) DEFAULT NULL,
  `usuariodatos_codigoActivacion` varchar(25) DEFAULT NULL,
  `usuariodatos_pasoActivacion` enum('1','2','3','0') DEFAULT '1',
  PRIMARY KEY (`idusuariodatos`),
  KEY `fkusuariodatos_Supervisor1_idx` (`idSupervisor`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=209 ;

--
-- Volcado de datos para la tabla `usuariodatos`
--

INSERT INTO `usuariodatos` (`idusuariodatos`, `usuariodatos_email`, `usuariodatos_token`, `usuariodatos_facebookKEY`, `usuariodatos_password`, `idSupervisor`, `usuariodatos_codigoActivacion`, `usuariodatos_pasoActivacion`) VALUES
(205, 'gianpiere@live.com', '49bc3653d8779a7ce96f74561', NULL, '123', NULL, '3454638', '1'),
(206, 'thais@hotmail.com', '47d7bbf22579ad072ae8382d8', NULL, '7777777', NULL, NULL, '1'),
(207, 'kev@gmail.com', 'e28bafd2c15220ec1fe434be2', NULL, '777', 1, NULL, '1'),
(208, 'day@live.com', '0cadcd2c2314c3a71aaa19d67', NULL, '777', NULL, '5685531', '1');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_crscursos`
--
CREATE TABLE IF NOT EXISTS `view_crscursos` (
`idCurso` int(11)
,`CursoNombre` varchar(300)
,`CursoEstado` bit(1)
,`CursoFechaCreacion` datetime
,`CursoFechaEliminacion` datetime
,`CursoNivelId` int(11)
,`CursoProfesorId` int(11)
,`CursoProfesorNombre` varchar(500)
,`CursoProfesorFotoUrl` varchar(300)
,`CursoProfesorFechaNacimiento` datetime
,`CursoProfesorEstado` bit(1)
,`CursoNivelNombre` varchar(200)
,`CursoNivelNumero` int(11)
);
-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_flfolder`
--
CREATE TABLE IF NOT EXISTS `view_flfolder` (
`idFolder` int(11)
,`FolderEstado` bit(1)
,`FolderDescripcion` varchar(700)
,`FolderCosto` float
,`FolderCursoId` int(11)
,`FolderAulaId` int(11)
,`FolderHorarioId` int(11)
,`FolderHorarioEstado` bit(1)
,`FolderHorarioFechaInicio` datetime
,`FolderHorarioFechaFinal` datetime
,`FolderHorarioDiasxSemana` varchar(7)
,`FolderAulaNombre` varchar(200)
,`FolderAulaCodigo` varchar(200)
,`FolderAulaEstado` bit(1)
,`FolderAulaDescripcion` varchar(500)
,`FolderAulaAforo` int(11)
,`FolderCursoNombre` varchar(300)
,`FolderCursoEstado` bit(1)
,`FolderNivelId` int(11)
,`FolderNivelNombre` varchar(200)
,`FolderNivelNumero` int(11)
,`FolderProfesorNombres` varchar(500)
,`FolderProfesorEstado` bit(1)
,`FolderProfesorDNI` varchar(25)
,`FolderProfesorFotoURL` varchar(300)
,`FolderProfesorDescripcion` longtext
,`FolderProfesorFechaNacimiento` datetime
);
-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_usdatosdeusuario`
--
CREATE TABLE IF NOT EXISTS `view_usdatosdeusuario` (
`idUsuario` int(11)
,`UsuarioNombres` varchar(200)
,`UsuarioDatosId` int(11)
,`UsuarioDNI` varchar(25)
,`UsuarioUBIGEO` varchar(200)
,`UsuarioFechaNacimiento` date
,`UsuarioEstado` bit(1)
,`UsuarioFechaEliminacion` datetime
,`UsuarioFotoURL` varchar(300)
,`UsuarioFechaCreacion` datetime
,`UsuarioEmail` varchar(70)
,`UsuarioToken` varchar(25)
,`UsuarioFacebookKEY` varchar(200)
,`UsuarioPassword` varchar(400)
,`UsuarioCodigoActivacion` varchar(25)
,`UsuarioSupervisorId` int(11)
,`UsuarioSupervisorNombres` varchar(250)
);
-- --------------------------------------------------------

--
-- Estructura para la vista `view_crscursos`
--
DROP TABLE IF EXISTS `view_crscursos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_crscursos` AS select `crs`.`idCurso` AS `idCurso`,`crs`.`Curso_Nombre` AS `CursoNombre`,`crs`.`Curso_estado` AS `CursoEstado`,`crs`.`Curso_fechaCreacion` AS `CursoFechaCreacion`,`crs`.`Curso_fechaEliminacion` AS `CursoFechaEliminacion`,`crs`.`idnivel` AS `CursoNivelId`,`crs`.`idProfesor` AS `CursoProfesorId`,`prf`.`Profesor_Nombres` AS `CursoProfesorNombre`,`prf`.`Profesor_fotoURL` AS `CursoProfesorFotoUrl`,`prf`.`Profesor_fechaNacimiento` AS `CursoProfesorFechaNacimiento`,`prf`.`Profesor_estado` AS `CursoProfesorEstado`,`nvl`.`nivel_nombre` AS `CursoNivelNombre`,`nvl`.`nivel_numero` AS `CursoNivelNumero` from ((`curso` `crs` join `profesor` `prf` on((`crs`.`idProfesor` = `prf`.`idProfesor`))) join `nivel` `nvl` on((`nvl`.`idnivel` = `crs`.`idnivel`)));

-- --------------------------------------------------------

--
-- Estructura para la vista `view_flfolder`
--
DROP TABLE IF EXISTS `view_flfolder`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_flfolder` AS select `fl`.`idfolder` AS `idFolder`,`fl`.`folder_estado` AS `FolderEstado`,`fl`.`folder_descripcion` AS `FolderDescripcion`,`fl`.`folder_Costo` AS `FolderCosto`,`fl`.`idCurso` AS `FolderCursoId`,`fl`.`idAula` AS `FolderAulaId`,`fl`.`idhorarios` AS `FolderHorarioId`,`hr`.`horarios_estado` AS `FolderHorarioEstado`,`hr`.`horarios_fechaInicio` AS `FolderHorarioFechaInicio`,`hr`.`horarios_fechaFinal` AS `FolderHorarioFechaFinal`,`hr`.`horarios_diasdesemana` AS `FolderHorarioDiasxSemana`,`au`.`Aula_Nombre` AS `FolderAulaNombre`,`au`.`Aula_Codigo` AS `FolderAulaCodigo`,`au`.`Aula_Estado` AS `FolderAulaEstado`,`au`.`Aula_Descripcion` AS `FolderAulaDescripcion`,`au`.`Aula_AforoMaximo` AS `FolderAulaAforo`,`crs`.`Curso_Nombre` AS `FolderCursoNombre`,`crs`.`Curso_estado` AS `FolderCursoEstado`,`crs`.`idnivel` AS `FolderNivelId`,`nv`.`nivel_nombre` AS `FolderNivelNombre`,`nv`.`nivel_numero` AS `FolderNivelNumero`,`prf`.`Profesor_Nombres` AS `FolderProfesorNombres`,`prf`.`Profesor_estado` AS `FolderProfesorEstado`,`prf`.`Profesor_DNI` AS `FolderProfesorDNI`,`prf`.`Profesor_fotoURL` AS `FolderProfesorFotoURL`,`prf`.`Profesor_Descripcion` AS `FolderProfesorDescripcion`,`prf`.`Profesor_fechaNacimiento` AS `FolderProfesorFechaNacimiento` from (((((`folder` `fl` join `curso` `crs` on((`fl`.`idCurso` = `crs`.`idCurso`))) join `aula` `au` on((`fl`.`idAula` = `au`.`idAula`))) join `horarios` `hr` on((`fl`.`idhorarios` = `hr`.`idhorarios`))) join `nivel` `nv` on((`crs`.`idnivel` = `nv`.`idnivel`))) join `profesor` `prf` on((`crs`.`idProfesor` = `prf`.`idProfesor`)));

-- --------------------------------------------------------

--
-- Estructura para la vista `view_usdatosdeusuario`
--
DROP TABLE IF EXISTS `view_usdatosdeusuario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_usdatosdeusuario` AS select `us`.`idUsuario` AS `idUsuario`,`us`.`Usuario_Nombres` AS `UsuarioNombres`,`us`.`idusuariodatos` AS `UsuarioDatosId`,`us`.`Usuario_dni` AS `UsuarioDNI`,`us`.`Usuario_direccionUBIGEO` AS `UsuarioUBIGEO`,`us`.`Usuario_fechaNacimiento` AS `UsuarioFechaNacimiento`,`us`.`Usuario_estado` AS `UsuarioEstado`,`us`.`Usuario_fechaEliminacion` AS `UsuarioFechaEliminacion`,`us`.`Usuario_fotoURL` AS `UsuarioFotoURL`,`us`.`Usuario_fechaCreacion` AS `UsuarioFechaCreacion`,`usd`.`usuariodatos_email` AS `UsuarioEmail`,`usd`.`usuariodatos_token` AS `UsuarioToken`,`usd`.`usuariodatos_facebookKEY` AS `UsuarioFacebookKEY`,`usd`.`usuariodatos_password` AS `UsuarioPassword`,`usd`.`usuariodatos_codigoActivacion` AS `UsuarioCodigoActivacion`,`usd`.`idSupervisor` AS `UsuarioSupervisorId`,`sp`.`Supervisor_Nombres` AS `UsuarioSupervisorNombres` from ((`usuario` `us` join `usuariodatos` `usd` on((`usd`.`idusuariodatos` = `us`.`idusuariodatos`))) left join `supervisor` `sp` on((`sp`.`idSupervisor` = `usd`.`idSupervisor`)));

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actividades`
--
ALTER TABLE `actividades`
  ADD CONSTRAINT `fkActividades_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `fkAsistencia_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkAsistencia_cursosxusuario1` FOREIGN KEY (`idcursosxusuario`) REFERENCES `cursosxusuario` (`idcursosxusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkAsistencia_folder1` FOREIGN KEY (`idfolder`) REFERENCES `folder` (`idfolder`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkAsistencia_Supervisor1` FOREIGN KEY (`idSupervisor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `asistenciasupervisada`
--
ALTER TABLE `asistenciasupervisada`
  ADD CONSTRAINT `fkAsistenciaSupervisada_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkAsistenciaSupervisada_Profesor1` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `aula`
--
ALTER TABLE `aula`
  ADD CONSTRAINT `fkAula_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  ADD CONSTRAINT `fkColaboradores_Colaboradores1` FOREIGN KEY (`idColaboradorCreador`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkColaboradores_PerfilGrupoPermiso1` FOREIGN KEY (`idPerfilGrupoPermiso`) REFERENCES `perfilgrupopermiso` (`idPerfilGrupoPermiso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkSupervisores_Administradores1` FOREIGN KEY (`idAdministradores`) REFERENCES `administradores` (`idAdministradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `fkCurso_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkCurso_nivel1` FOREIGN KEY (`idnivel`) REFERENCES `nivel` (`idnivel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkCurso_Profesor1` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cursoprevioxusuario`
--
ALTER TABLE `cursoprevioxusuario`
  ADD CONSTRAINT `fkcursoprevioxusuario_Curso1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkcursoprevioxusuario_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cursosxprofesor`
--
ALTER TABLE `cursosxprofesor`
  ADD CONSTRAINT `fkCursosxProfesor_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkCursosxProfesor_Curso1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkCursosxProfesor_Profesor1` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cursosxusuario`
--
ALTER TABLE `cursosxusuario`
  ADD CONSTRAINT `fkcursosxusuario_folder1` FOREIGN KEY (`idfolder`) REFERENCES `folder` (`idfolder`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkcursosxusuario_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `devocional`
--
ALTER TABLE `devocional`
  ADD CONSTRAINT `fkDevocional_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `folder`
--
ALTER TABLE `folder`
  ADD CONSTRAINT `fkfolder_Aula1` FOREIGN KEY (`idAula`) REFERENCES `aula` (`idAula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkfolder_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkfolder_Curso1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkfolder_horarios1` FOREIGN KEY (`idhorarios`) REFERENCES `horarios` (`idhorarios`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `galeriadefotos`
--
ALTER TABLE `galeriadefotos`
  ADD CONSTRAINT `fkGaleriadeFotos_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `fkhorarios_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `imagenesweb`
--
ALTER TABLE `imagenesweb`
  ADD CONSTRAINT `fkimagenesweb_tipo_objeto1` FOREIGN KEY (`idtipo_objeto`) REFERENCES `tipo_objeto` (`idtipo_objeto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `nivel`
--
ALTER TABLE `nivel`
  ADD CONSTRAINT `fknivel_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `perfilgrupopermiso`
--
ALTER TABLE `perfilgrupopermiso`
  ADD CONSTRAINT `fkPerfilGrupoPermiso_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkPerfilGrupoPermiso_tipo_acceso1` FOREIGN KEY (`idtipo_acceso`) REFERENCES `tipo_acceso` (`idtipo_acceso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD CONSTRAINT `fkProfesor_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `slidertransicion`
--
ALTER TABLE `slidertransicion`
  ADD CONSTRAINT `fkSliderTransicion_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `supervisor`
--
ALTER TABLE `supervisor`
  ADD CONSTRAINT `fkSupervisor_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fkUsuario_usuariodatos1` FOREIGN KEY (`idusuariodatos`) REFERENCES `usuariodatos` (`idusuariodatos`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuariodatos`
--
ALTER TABLE `usuariodatos`
  ADD CONSTRAINT `fkusuariodatos_Supervisor1` FOREIGN KEY (`idSupervisor`) REFERENCES `supervisor` (`idSupervisor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
