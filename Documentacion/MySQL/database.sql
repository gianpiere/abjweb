-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-03-2014 a las 07:19:14
-- Versión del servidor: 5.5.32
-- Versión de PHP: 5.4.19

--
-- ; Developer :: jGianpiere
--
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
DROP PROCEDURE IF EXISTS `SP_crsBuscarCursoxId`$$
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

DROP PROCEDURE IF EXISTS `SP_crsBuscarCursoxNivel`$$
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

DROP PROCEDURE IF EXISTS `SP_crsBuscarCursoxNombre`$$
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

DROP PROCEDURE IF EXISTS `SP_crsBuscarCursoxProfesorId`$$
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

DROP PROCEDURE IF EXISTS `SP_dvDevocionalMostrarUltimo`$$
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

DROP PROCEDURE IF EXISTS `SP_usBuscarUsuario`$$
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

DROP PROCEDURE IF EXISTS `SP_usCrearUsuario`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_usCrearUsuario`(IN xUsuarioNombre VARCHAR(500),IN xUsuarioDNI VARCHAR(8),IN xUsuarioFechaNacimiento DATETIME,IN xUsuarioFotoURL VARCHAR(300),IN xUsuarioUBIGEO VARCHAR(100),IN xUsuarioEmail VARCHAR(70), IN xUsuarioPassword VARCHAR(25), IN xSupervisorId INT)
BEGIN
	/**
	*	@Name 	: SP_usCrearUsuario
	*	@Params	: todos los datos de usuario
	*/
	
	DECLARE zUltimoInsertID INT;
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
	SET zUltimoInsertID = LAST_INSERT_ID();
	
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

	# Retornamos los Datos del Usuario Creado
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
		UsuarioDatosId,
		UsuarioCodigoActivacion
	FROM view_usdatosdeusuario
	WHERE idUsuario = LAST_INSERT_ID();

END$$

DROP PROCEDURE IF EXISTS `SP_usEliminarUsuario`$$
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

DROP PROCEDURE IF EXISTS `SP_usIniciarSession`$$
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

DROP PROCEDURE IF EXISTS `SP_usNuevoCodigoActivacion`$$
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

DROP PROCEDURE IF EXISTS `SP_usUsuariosxSupervisorId`$$
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
DROP FUNCTION IF EXISTS `fn_newCodigoActivacion`$$
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

DROP FUNCTION IF EXISTS `fn_newUserToken`$$
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

DROP FUNCTION IF EXISTS `fn_UserIdValidatePassword`$$
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

DROP FUNCTION IF EXISTS `fn_ValidateTokenUser`$$
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

DROP TABLE IF EXISTS `actividades`;
CREATE TABLE IF NOT EXISTS `actividades` (
  `idActividades` int(11) NOT NULL AUTO_INCREMENT,
  `Actividades_estado` bit(1) DEFAULT b'1',
  `Actividades_ImagenURL` varchar(300) DEFAULT NULL,
  `Actividades_fechaCreacion` datetime DEFAULT NULL,
  `Actividades_fechadelEvento` datetime DEFAULT NULL,
  `Actividades_fechaEliminacion` datetime DEFAULT NULL,
  PRIMARY KEY (`idActividades`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradores`
--

DROP TABLE IF EXISTS `administradores`;
CREATE TABLE IF NOT EXISTS `administradores` (
  `idAdministradores` int(11) NOT NULL AUTO_INCREMENT,
  `Administradores_Nombres` varchar(500) DEFAULT NULL,
  `Administradores_Descripcion` longtext,
  `Administradores_fotoURL` varchar(300) DEFAULT NULL,
  `Administradores_DNI` varchar(25) DEFAULT NULL,
  `Administradores_fechaNacimiento` datetime DEFAULT NULL,
  PRIMARY KEY (`idAdministradores`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `administradores`
--

INSERT INTO `administradores` (`idAdministradores`, `Administradores_Nombres`, `Administradores_Descripcion`, `Administradores_fotoURL`, `Administradores_DNI`, `Administradores_fechaNacimiento`) VALUES
(1, 'MIRADOR1', 'alto flaco y con experiencia ;)', 'foto.jpg', '235465756', '2014-03-01 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE IF NOT EXISTS `asistencia` (
  `idAsistencia` int(11) NOT NULL AUTO_INCREMENT,
  `Asistencia_fecha` datetime DEFAULT NULL,
  `idfolder` int(11) NOT NULL,
  `idSupervisor` int(11) NOT NULL,
  `Asistencia_asistio` bit(1) DEFAULT b'1',
  `idcursosxusuario` int(11) NOT NULL,
  PRIMARY KEY (`idAsistencia`),
  KEY `fkAsistencia_folder1_idx` (`idfolder`),
  KEY `fkAsistencia_Supervisor1_idx` (`idSupervisor`),
  KEY `fkAsistencia_cursosxusuario1_idx` (`idcursosxusuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `asistencia`
--

INSERT INTO `asistencia` (`idAsistencia`, `Asistencia_fecha`, `idfolder`, `idSupervisor`, `Asistencia_asistio`, `idcursosxusuario`) VALUES
(1, '2014-03-01 00:00:00', 1, 1, b'1', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistenciasupervisada`
--

DROP TABLE IF EXISTS `asistenciasupervisada`;
CREATE TABLE IF NOT EXISTS `asistenciasupervisada` (
  `idAsistenciaSupervisada` int(11) NOT NULL AUTO_INCREMENT,
  `AsistenciaSupervisada_fechaAuditoria` datetime DEFAULT NULL,
  `AsistenciaSupervisada_Observacion` longtext,
  `idProfesor` int(11) NOT NULL,
  `idColaboradores` int(11) NOT NULL,
  PRIMARY KEY (`idAsistenciaSupervisada`),
  KEY `fkAsistenciaSupervisada_Profesor1_idx` (`idProfesor`),
  KEY `fkAsistenciaSupervisada_Colaboradores1_idx` (`idColaboradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

DROP TABLE IF EXISTS `aula`;
CREATE TABLE IF NOT EXISTS `aula` (
  `idAula` int(11) NOT NULL AUTO_INCREMENT,
  `Aula_Nombre` varchar(200) DEFAULT NULL,
  `Aula_Codigo` varchar(200) DEFAULT NULL,
  `Aula_Estado` bit(1) DEFAULT b'1',
  `Aula_Descripcion` varchar(500) DEFAULT NULL,
  `Aula_AforoMaximo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAula`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `aula`
--

INSERT INTO `aula` (`idAula`, `Aula_Nombre`, `Aula_Codigo`, `Aula_Estado`, `Aula_Descripcion`, `Aula_AforoMaximo`) VALUES
(1, '121', 'A121', b'1', 'debajo de la escalera, color verde oscuro cerca de la entrada', 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colaboradores`
--

DROP TABLE IF EXISTS `colaboradores`;
CREATE TABLE IF NOT EXISTS `colaboradores` (
  `idColaboradores` int(11) NOT NULL AUTO_INCREMENT,
  `Colaboradores_Codigo` varchar(200) DEFAULT NULL,
  `idAdministradores` int(11) NOT NULL,
  `Colaboradores_fotoURL` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`idColaboradores`,`idAdministradores`),
  KEY `fkSupervisores_Administradores1_idx` (`idAdministradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

DROP TABLE IF EXISTS `curso`;
CREATE TABLE IF NOT EXISTS `curso` (
  `idCurso` int(11) NOT NULL AUTO_INCREMENT,
  `Curso_Nombre` varchar(300) DEFAULT NULL,
  `Curso_estado` bit(1) NOT NULL DEFAULT b'1',
  `Curso_fechaCreacion` datetime NOT NULL,
  `Curso_fechaEliminacion` datetime DEFAULT NULL,
  `idnivel` int(11) NOT NULL,
  `idProfesor` int(11) NOT NULL,
  PRIMARY KEY (`idCurso`),
  KEY `fkCurso_nivel1_idx` (`idnivel`),
  KEY `fkCurso_Profesor1_idx` (`idProfesor`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`idCurso`, `Curso_Nombre`, `Curso_estado`, `Curso_fechaCreacion`, `Curso_fechaEliminacion`, `idnivel`, `idProfesor`) VALUES
(2, 'Matematica cuantica', b'1', '2014-02-28 00:00:00', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursosxprofesor`
--

DROP TABLE IF EXISTS `cursosxprofesor`;
CREATE TABLE IF NOT EXISTS `cursosxprofesor` (
  `idCursosxProfesor` int(11) NOT NULL AUTO_INCREMENT,
  `CursosxProfesor_fechaActiva` datetime DEFAULT NULL,
  `CursosxProfesor_fechaEliminacion` datetime DEFAULT NULL,
  `CursosxProfesor_estado` bit(1) DEFAULT b'1',
  `idProfesor` int(11) NOT NULL,
  `idCurso` int(11) NOT NULL,
  PRIMARY KEY (`idCursosxProfesor`),
  KEY `fkCursosxProfesor_Profesor1_idx` (`idProfesor`),
  KEY `fkCursosxProfesor_Curso1_idx` (`idCurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursosxusuario`
--

DROP TABLE IF EXISTS `cursosxusuario`;
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `cursosxusuario`
--

INSERT INTO `cursosxusuario` (`idcursosxusuario`, `cursosxusuario_estado`, `cursosxusuario_fechaRegistro`, `idfolder`, `cursosxusuario_activeKEY`, `idUsuario`, `cursosxusuario_NotaFinal`, `cursosxusuario_AproboCurso`) VALUES
(1, b'1', '2014-03-01 00:00:00', 1, '7777777', 2, NULL, b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devocional`
--

DROP TABLE IF EXISTS `devocional`;
CREATE TABLE IF NOT EXISTS `devocional` (
  `idDevocional` int(11) NOT NULL AUTO_INCREMENT,
  `Devocional_fechaCreacion` datetime DEFAULT NULL,
  `Devocional_fechaPresentacion` datetime DEFAULT NULL,
  `Devocional_Contenido` longtext,
  `Devocional_DetalleBiblico` varchar(200) DEFAULT NULL,
  `Devocional_estado` bit(1) DEFAULT b'1',
  PRIMARY KEY (`idDevocional`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `devocional`
--

INSERT INTO `devocional` (`idDevocional`, `Devocional_fechaCreacion`, `Devocional_fechaPresentacion`, `Devocional_Contenido`, `Devocional_DetalleBiblico`, `Devocional_estado`) VALUES
(1, '2014-03-19 00:00:00', '2014-03-21 00:00:00', 'este es un ejemplo del contenido biblico que se debe mostrar en la web', '1 Juan 2:3,8', b'1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `folder`
--

DROP TABLE IF EXISTS `folder`;
CREATE TABLE IF NOT EXISTS `folder` (
  `idfolder` int(11) NOT NULL AUTO_INCREMENT,
  `folder_estado` bit(1) DEFAULT b'1',
  `folder_descripcion` varchar(700) DEFAULT NULL,
  `folder_Costo` float DEFAULT '0',
  `idCurso` int(11) NOT NULL,
  `idAula` int(11) NOT NULL,
  `idhorarios` int(11) NOT NULL,
  PRIMARY KEY (`idfolder`,`idCurso`),
  KEY `fkfolder_Aula1_idx` (`idAula`),
  KEY `fkfolder_horarios1_idx` (`idhorarios`),
  KEY `fkfolder_Curso1_idx` (`idCurso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `folder`
--

INSERT INTO `folder` (`idfolder`, `folder_estado`, `folder_descripcion`, `folder_Costo`, `idCurso`, `idAula`, `idhorarios`) VALUES
(1, b'1', 'mi primer curso de verano', 5, 2, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `galeriadefotos`
--

DROP TABLE IF EXISTS `galeriadefotos`;
CREATE TABLE IF NOT EXISTS `galeriadefotos` (
  `idGaleriadeFotos` int(11) NOT NULL AUTO_INCREMENT,
  `GaleriadeFotos_URL` varchar(300) DEFAULT NULL,
  `GaleriadeFotos_estado` bit(1) DEFAULT b'1',
  `GaleriadeFotos_CarpetaName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`idGaleriadeFotos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios`
--

DROP TABLE IF EXISTS `horarios`;
CREATE TABLE IF NOT EXISTS `horarios` (
  `idhorarios` int(11) NOT NULL AUTO_INCREMENT,
  `horarios_fechaCreacion` datetime DEFAULT NULL,
  `horarios_fechaInicio` datetime DEFAULT NULL,
  `horarios_fechaFinal` datetime DEFAULT NULL,
  `horarios_estado` bit(1) NOT NULL DEFAULT b'1',
  `horarios_diasdesemana` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`idhorarios`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `horarios`
--

INSERT INTO `horarios` (`idhorarios`, `horarios_fechaCreacion`, `horarios_fechaInicio`, `horarios_fechaFinal`, `horarios_estado`, `horarios_diasdesemana`) VALUES
(1, '2014-03-01 00:00:00', '2014-03-01 00:00:00', '2014-04-30 00:00:00', b'1', '7');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nivel`
--

DROP TABLE IF EXISTS `nivel`;
CREATE TABLE IF NOT EXISTS `nivel` (
  `idnivel` int(11) NOT NULL AUTO_INCREMENT,
  `nivel_estado` varchar(200) DEFAULT '1',
  `nivel_nombre` varchar(200) DEFAULT NULL,
  `nivel_numero` int(11) DEFAULT NULL,
  PRIMARY KEY (`idnivel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `nivel`
--

INSERT INTO `nivel` (`idnivel`, `nivel_estado`, `nivel_nombre`, `nivel_numero`) VALUES
(1, '1', 'uno', 1),
(2, '1', 'dos', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

DROP TABLE IF EXISTS `profesor`;
CREATE TABLE IF NOT EXISTS `profesor` (
  `idProfesor` int(11) NOT NULL AUTO_INCREMENT,
  `Profesor_Nombres` varchar(500) DEFAULT NULL,
  `Profesor_estado` bit(1) NOT NULL DEFAULT b'1',
  `Profesor_DNI` varchar(25) DEFAULT NULL,
  `Profesor_fotoURL` varchar(300) DEFAULT NULL,
  `Profesor_Descripcion` longtext,
  `Profesor_fechaNacimiento` datetime DEFAULT NULL,
  PRIMARY KEY (`idProfesor`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`idProfesor`, `Profesor_Nombres`, `Profesor_estado`, `Profesor_DNI`, `Profesor_fotoURL`, `Profesor_Descripcion`, `Profesor_fechaNacimiento`) VALUES
(1, 'Carlos Perez', b'1', '345646456', 'sdfsdfsdfsfdsdfsdf', 'sdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdf', '2012-08-21 02:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `slidertransicion`
--

DROP TABLE IF EXISTS `slidertransicion`;
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
  PRIMARY KEY (`idSliderTransicion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supervisor`
--

DROP TABLE IF EXISTS `supervisor`;
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
  PRIMARY KEY (`idSupervisor`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `supervisor`
--

INSERT INTO `supervisor` (`idSupervisor`, `Supervisor_Nombres`, `Supervisor_codigo`, `Supervisor_fotoURL`, `Supervisor_Email`, `Supervisor_fechaNacimiento`, `Supervisor_estado`, `Supervisor_fechaCreacion`, `Supervisor_fechaEliminacion`) VALUES
(1, 'Flor Atapaucar', '', NULL, NULL, NULL, b'1', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `timestamps`
--

DROP TABLE IF EXISTS `timestamps`;
CREATE TABLE IF NOT EXISTS `timestamps` (
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Usuario_Nombres` varchar(200) DEFAULT NULL,
  `idusuariodatos` int(11) NOT NULL,
  `Usuario_dni` varchar(25) DEFAULT NULL,
  `Usuario_direccionUBIGEO` varchar(200) DEFAULT NULL,
  `Usuario_fechaNacimiento` datetime DEFAULT NULL,
  `Usuario_estado` bit(1) DEFAULT b'1',
  `Usuario_fechaEliminacion` datetime DEFAULT NULL,
  `Usuario_fotoURL` varchar(300) DEFAULT NULL,
  `Usuario_fechaCreacion` datetime DEFAULT NULL,
  PRIMARY KEY (`idUsuario`,`idusuariodatos`),
  KEY `fkUsuario_usuariodatos1_idx` (`idusuariodatos`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `Usuario_Nombres`, `idusuariodatos`, `Usuario_dni`, `Usuario_direccionUBIGEO`, `Usuario_fechaNacimiento`, `Usuario_estado`, `Usuario_fechaEliminacion`, `Usuario_fotoURL`, `Usuario_fechaCreacion`) VALUES
(2, 'Gianpiere Julio Ramos Bernuy', 1, '46120621', '1111111111, 22222222222', '1989-08-16 00:00:00', b'1', NULL, NULL, '2014-02-20 00:00:00'),
(3, 'Mia Valentina', 2, '46120202', '111111111,22222222', '1998-02-27 00:00:00', b'1', NULL, 'mifoto.jpg', '2014-02-27 01:00:00'),
(4, 'Gerardo Leon', 6, NULL, NULL, NULL, b'0', '2014-02-27 13:52:32', NULL, '2014-02-27 01:24:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariodatos`
--

DROP TABLE IF EXISTS `usuariodatos`;
CREATE TABLE IF NOT EXISTS `usuariodatos` (
  `idusuariodatos` int(11) NOT NULL AUTO_INCREMENT,
  `usuariodatos_email` varchar(70) DEFAULT NULL,
  `usuariodatos_token` varchar(25) DEFAULT NULL,
  `usuariodatos_facebookKEY` varchar(200) DEFAULT NULL,
  `usuariodatos_password` varchar(400) DEFAULT NULL,
  `idSupervisor` int(11) NOT NULL,
  `usuariodatos_codigoActivacion` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idusuariodatos`),
  KEY `fkusuariodatos_Supervisor1_idx` (`idSupervisor`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `usuariodatos`
--

INSERT INTO `usuariodatos` (`idusuariodatos`, `usuariodatos_email`, `usuariodatos_token`, `usuariodatos_facebookKEY`, `usuariodatos_password`, `idSupervisor`, `usuariodatos_codigoActivacion`) VALUES
(1, 'gianpiere@live.com', 'c0358902336766e17d2e29066', NULL, '123', 1, NULL),
(2, 'thaís@hotmail.com', ' 7034', '740803', '123123', 1, NULL),
(6, 'gerardo@hotmail.com', '411b9eaff4afbeaa891bc1048', NULL, '123', 1, '9844154');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_crscursos`
--
DROP VIEW IF EXISTS `view_crscursos`;
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
);
-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `view_flfolder`
--
DROP VIEW IF EXISTS `view_flfolder`;
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
DROP VIEW IF EXISTS `view_usdatosdeusuario`;
CREATE TABLE IF NOT EXISTS `view_usdatosdeusuario` (
`idUsuario` int(11)
,`UsuarioNombres` varchar(200)
,`UsuarioDatosId` int(11)
,`UsuarioDNI` varchar(25)
,`UsuarioUBIGEO` varchar(200)
,`UsuarioFechaNacimiento` datetime
,`UsuarioEstado` bit(1)
,`UsuarioFechaEliminacion` datetime
,`UsuarioFotoURL` varchar(300)
,`UsuarioFechaCreacion` datetime
,`UsuarioEmail` varchar(70)
,`UsuarioToken` varchar(25)
,`UsuarioFacebookKEY` varchar(200)
,`UsuarioPassword` varchar(400)
,`UsuarioCodigoActivacion` varchar(250)
,`UsuarioSupervisorId` int(11)
,`UsuarioSupervisorNombres` varchar(250)
);
-- --------------------------------------------------------

--
-- Estructura para la vista `view_crscursos`
--
DROP TABLE IF EXISTS `view_crscursos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_crscursos` AS select `crs`.`idCurso` AS `idCurso`,`crs`.`Curso_Nombre` AS `CursoNombre`,`crs`.`Curso_estado` AS `CursoEstado`,`crs`.`Curso_fechaCreacion` AS `CursoFechaCreacion`,`crs`.`Curso_fechaEliminacion` AS `CursoFechaEliminacion`,`crs`.`idnivel` AS `CursoNivelId`,`crs`.`idProfesor` AS `CursoProfesorId`,`prf`.`Profesor_Nombres` AS `CursoProfesorNombre`,`prf`.`Profesor_fotoURL` AS `CursoProfesorFotoUrl`,`prf`.`Profesor_fechaNacimiento` AS `CursoProfesorFechaNacimiento`,`prf`.`Profesor_estado` AS `CursoProfesorEstado` from (`curso` `crs` join `profesor` `prf` on((`crs`.`idProfesor` = `prf`.`idProfesor`)));

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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_usdatosdeusuario` AS select `us`.`idUsuario` AS `idUsuario`,`us`.`Usuario_Nombres` AS `UsuarioNombres`,`us`.`idusuariodatos` AS `UsuarioDatosId`,`us`.`Usuario_dni` AS `UsuarioDNI`,`us`.`Usuario_direccionUBIGEO` AS `UsuarioUBIGEO`,`us`.`Usuario_fechaNacimiento` AS `UsuarioFechaNacimiento`,`us`.`Usuario_estado` AS `UsuarioEstado`,`us`.`Usuario_fechaEliminacion` AS `UsuarioFechaEliminacion`,`us`.`Usuario_fotoURL` AS `UsuarioFotoURL`,`us`.`Usuario_fechaCreacion` AS `UsuarioFechaCreacion`,`usd`.`usuariodatos_email` AS `UsuarioEmail`,`usd`.`usuariodatos_token` AS `UsuarioToken`,`usd`.`usuariodatos_facebookKEY` AS `UsuarioFacebookKEY`,`usd`.`usuariodatos_password` AS `UsuarioPassword`,`usd`.`usuariodatos_codigoActivacion` AS `UsuarioCodigoActivacion`,`usd`.`idSupervisor` AS `UsuarioSupervisorId`,`sp`.`Supervisor_Nombres` AS `UsuarioSupervisorNombres` from ((`usuario` `us` join `usuariodatos` `usd`) join `supervisor` `sp`) where ((`usd`.`idusuariodatos` = `us`.`idusuariodatos`) and (`sp`.`idSupervisor` = `usd`.`idSupervisor`));

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
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
-- Filtros para la tabla `colaboradores`
--
ALTER TABLE `colaboradores`
  ADD CONSTRAINT `fkSupervisores_Administradores1` FOREIGN KEY (`idAdministradores`) REFERENCES `administradores` (`idAdministradores`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `fkCurso_nivel1` FOREIGN KEY (`idnivel`) REFERENCES `nivel` (`idnivel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkCurso_Profesor1` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cursosxprofesor`
--
ALTER TABLE `cursosxprofesor`
  ADD CONSTRAINT `fkCursosxProfesor_Curso1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkCursosxProfesor_Profesor1` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cursosxusuario`
--
ALTER TABLE `cursosxusuario`
  ADD CONSTRAINT `fkcursosxusuario_folder1` FOREIGN KEY (`idfolder`) REFERENCES `folder` (`idfolder`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkcursosxusuario_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `folder`
--
ALTER TABLE `folder`
  ADD CONSTRAINT `fkfolder_Aula1` FOREIGN KEY (`idAula`) REFERENCES `aula` (`idAula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkfolder_Curso1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fkfolder_horarios1` FOREIGN KEY (`idhorarios`) REFERENCES `horarios` (`idhorarios`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
