/*
Navicat MySQL Data Transfer

Source Server         : kevinweb
Source Server Version : 50532
Source Host           : localhost:3306
Source Database       : wwabj_clase

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2014-04-29 00:07:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for actividades
-- ----------------------------
DROP TABLE IF EXISTS `actividades`;
CREATE TABLE `actividades` (
  `idActividades` int(11) NOT NULL AUTO_INCREMENT,
  `Actividades_estado` bit(1) DEFAULT b'1',
  `Actividades_ImagenURL` varchar(300) DEFAULT NULL,
  `Actividades_fechaCreacion` datetime DEFAULT NULL,
  `Actividades_fechadelEvento` datetime DEFAULT NULL,
  `Actividades_fechaEliminacion` datetime DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idActividades`),
  KEY `fkActividades_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkActividades_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of actividades
-- ----------------------------

-- ----------------------------
-- Table structure for administradores
-- ----------------------------
DROP TABLE IF EXISTS `administradores`;
CREATE TABLE `administradores` (
  `idAdministradores` int(11) NOT NULL AUTO_INCREMENT,
  `Administradores_Nombres` varchar(500) DEFAULT NULL,
  `Administradores_Descripcion` longtext,
  `Administradores_fotoURL` varchar(300) DEFAULT NULL,
  `Administradores_DNI` varchar(25) DEFAULT NULL,
  `Administradores_fechaNacimiento` datetime DEFAULT NULL,
  PRIMARY KEY (`idAdministradores`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of administradores
-- ----------------------------

-- ----------------------------
-- Table structure for asistencia
-- ----------------------------
DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE `asistencia` (
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
  KEY `fkAsistencia_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkAsistencia_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkAsistencia_cursosxusuario1` FOREIGN KEY (`idcursosxusuario`) REFERENCES `cursosxusuario` (`idcursosxusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkAsistencia_folder1` FOREIGN KEY (`idfolder`) REFERENCES `folder` (`idfolder`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkAsistencia_Supervisor1` FOREIGN KEY (`idSupervisor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asistencia
-- ----------------------------

-- ----------------------------
-- Table structure for asistenciasupervisada
-- ----------------------------
DROP TABLE IF EXISTS `asistenciasupervisada`;
CREATE TABLE `asistenciasupervisada` (
  `idAsistenciaSupervisada` int(11) NOT NULL AUTO_INCREMENT,
  `AsistenciaSupervisada_fechaAuditoria` datetime DEFAULT NULL,
  `AsistenciaSupervisada_Observacion` longtext,
  `idProfesor` int(11) NOT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAsistenciaSupervisada`),
  KEY `fkAsistenciaSupervisada_Profesor1_idx` (`idProfesor`),
  KEY `fkAsistenciaSupervisada_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkAsistenciaSupervisada_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkAsistenciaSupervisada_Profesor1` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asistenciasupervisada
-- ----------------------------

-- ----------------------------
-- Table structure for aula
-- ----------------------------
DROP TABLE IF EXISTS `aula`;
CREATE TABLE `aula` (
  `idAula` int(11) NOT NULL AUTO_INCREMENT,
  `Aula_Nombre` varchar(200) DEFAULT NULL,
  `Aula_Codigo` varchar(200) DEFAULT NULL,
  `Aula_Estado` bit(1) DEFAULT b'1',
  `Aula_Descripcion` varchar(500) DEFAULT NULL,
  `Aula_AforoMaximo` int(11) DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAula`),
  KEY `fkAula_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkAula_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aula
-- ----------------------------

-- ----------------------------
-- Table structure for colaboradores
-- ----------------------------
DROP TABLE IF EXISTS `colaboradores`;
CREATE TABLE `colaboradores` (
  `idColaboradores` int(11) NOT NULL AUTO_INCREMENT,
  `Colaboradores_Codigo` varchar(200) DEFAULT NULL,
  `idAdministradores` int(11) DEFAULT NULL,
  `Colaboradores_fotoURL` varchar(300) DEFAULT NULL,
  `idPerfilGrupoPermiso` int(11) NOT NULL,
  `idColaboradorCreador` int(11) DEFAULT NULL,
  PRIMARY KEY (`idColaboradores`,`idPerfilGrupoPermiso`),
  KEY `fkSupervisores_Administradores1_idx` (`idAdministradores`),
  KEY `fkColaboradores_PerfilGrupoPermiso1_idx` (`idPerfilGrupoPermiso`),
  KEY `fkColaboradores_Colaboradores1_idx` (`idColaboradorCreador`),
  CONSTRAINT `fkColaboradores_Colaboradores1` FOREIGN KEY (`idColaboradorCreador`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkColaboradores_PerfilGrupoPermiso1` FOREIGN KEY (`idPerfilGrupoPermiso`) REFERENCES `perfilgrupopermiso` (`idPerfilGrupoPermiso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkSupervisores_Administradores1` FOREIGN KEY (`idAdministradores`) REFERENCES `administradores` (`idAdministradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of colaboradores
-- ----------------------------

-- ----------------------------
-- Table structure for curso
-- ----------------------------
DROP TABLE IF EXISTS `curso`;
CREATE TABLE `curso` (
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
  KEY `fkCurso_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkCurso_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkCurso_nivel1` FOREIGN KEY (`idnivel`) REFERENCES `nivel` (`idnivel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkCurso_Profesor1` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of curso
-- ----------------------------
INSERT INTO `curso` VALUES ('3', 'Primeros Pasos de la biblia', '', '2014-04-18 08:38:46', null, '1', '1', null);

-- ----------------------------
-- Table structure for cursoprevioxusuario
-- ----------------------------
DROP TABLE IF EXISTS `cursoprevioxusuario`;
CREATE TABLE `cursoprevioxusuario` (
  `idcursoprevioxusuario` int(11) NOT NULL AUTO_INCREMENT,
  `cursoprevioxusuario_estado` bit(1) DEFAULT b'1',
  `cursoprevioxusuario_nombre` varchar(200) DEFAULT NULL,
  `cursoprevioxusuario_fechainsert` datetime DEFAULT NULL,
  `cursoprevioxusuario_fechadelete` datetime DEFAULT NULL,
  `idCurso` int(11) DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcursoprevioxusuario`),
  KEY `fkcursoprevioxusuario_Curso1_idx` (`idCurso`),
  KEY `fkcursoprevioxusuario_Usuario1_idx` (`idUsuario`),
  CONSTRAINT `fkcursoprevioxusuario_Curso1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkcursoprevioxusuario_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cursoprevioxusuario
-- ----------------------------
INSERT INTO `cursoprevioxusuario` VALUES ('1', '', null, '2014-04-20 00:00:00', null, '3', '204');
INSERT INTO `cursoprevioxusuario` VALUES ('2', '', null, '2014-04-20 11:27:49', null, '3', '203');
INSERT INTO `cursoprevioxusuario` VALUES ('3', '', null, '2014-04-20 11:28:41', null, '3', '203');
INSERT INTO `cursoprevioxusuario` VALUES ('4', '', null, '2014-04-20 11:28:45', null, '3', '203');
INSERT INTO `cursoprevioxusuario` VALUES ('5', '', null, '2014-04-20 11:29:22', null, '3', '203');
INSERT INTO `cursoprevioxusuario` VALUES ('6', '', null, '2014-04-20 11:29:22', null, '3', '204');
INSERT INTO `cursoprevioxusuario` VALUES ('7', '', null, '2014-04-20 13:36:05', null, '3', '205');
INSERT INTO `cursoprevioxusuario` VALUES ('8', '', null, '2014-04-20 13:36:23', null, '3', '205');
INSERT INTO `cursoprevioxusuario` VALUES ('9', '', null, '2014-04-26 01:25:50', null, '3', '207');
INSERT INTO `cursoprevioxusuario` VALUES ('10', '', null, '2014-04-26 01:26:29', null, '3', '207');

-- ----------------------------
-- Table structure for cursosxprofesor
-- ----------------------------
DROP TABLE IF EXISTS `cursosxprofesor`;
CREATE TABLE `cursosxprofesor` (
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
  KEY `fkCursosxProfesor_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkCursosxProfesor_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkCursosxProfesor_Curso1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkCursosxProfesor_Profesor1` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idProfesor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cursosxprofesor
-- ----------------------------

-- ----------------------------
-- Table structure for cursosxusuario
-- ----------------------------
DROP TABLE IF EXISTS `cursosxusuario`;
CREATE TABLE `cursosxusuario` (
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
  KEY `fkcursosxusuario_Usuario1_idx` (`idUsuario`),
  CONSTRAINT `fkcursosxusuario_folder1` FOREIGN KEY (`idfolder`) REFERENCES `folder` (`idfolder`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkcursosxusuario_Usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cursosxusuario
-- ----------------------------

-- ----------------------------
-- Table structure for devocional
-- ----------------------------
DROP TABLE IF EXISTS `devocional`;
CREATE TABLE `devocional` (
  `idDevocional` int(11) NOT NULL AUTO_INCREMENT,
  `Devocional_fechaCreacion` datetime DEFAULT NULL,
  `Devocional_fechaPresentacion` datetime DEFAULT NULL,
  `Devocional_Contenido` longtext,
  `Devocional_DetalleBiblico` varchar(200) DEFAULT NULL,
  `Devocional_estado` bit(1) DEFAULT b'1',
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idDevocional`),
  KEY `fkDevocional_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkDevocional_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of devocional
-- ----------------------------

-- ----------------------------
-- Table structure for folder
-- ----------------------------
DROP TABLE IF EXISTS `folder`;
CREATE TABLE `folder` (
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
  KEY `fkfolder_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkfolder_Aula1` FOREIGN KEY (`idAula`) REFERENCES `aula` (`idAula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkfolder_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkfolder_Curso1` FOREIGN KEY (`idCurso`) REFERENCES `curso` (`idCurso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkfolder_horarios1` FOREIGN KEY (`idhorarios`) REFERENCES `horarios` (`idhorarios`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of folder
-- ----------------------------

-- ----------------------------
-- Table structure for galeriadefotos
-- ----------------------------
DROP TABLE IF EXISTS `galeriadefotos`;
CREATE TABLE `galeriadefotos` (
  `idGaleriadeFotos` int(11) NOT NULL AUTO_INCREMENT,
  `GaleriadeFotos_URL` varchar(300) DEFAULT NULL,
  `GaleriadeFotos_estado` bit(1) DEFAULT b'1',
  `GaleriadeFotos_CarpetaName` varchar(200) DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idGaleriadeFotos`),
  KEY `fkGaleriadeFotos_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkGaleriadeFotos_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of galeriadefotos
-- ----------------------------

-- ----------------------------
-- Table structure for horarios
-- ----------------------------
DROP TABLE IF EXISTS `horarios`;
CREATE TABLE `horarios` (
  `idhorarios` int(11) NOT NULL AUTO_INCREMENT,
  `horarios_fechaCreacion` datetime DEFAULT NULL,
  `horarios_fechaInicio` datetime DEFAULT NULL,
  `horarios_fechaFinal` datetime DEFAULT NULL,
  `horarios_estado` bit(1) NOT NULL DEFAULT b'1',
  `horarios_diasdesemana` varchar(7) DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idhorarios`),
  KEY `fkhorarios_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkhorarios_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of horarios
-- ----------------------------

-- ----------------------------
-- Table structure for imagenesweb
-- ----------------------------
DROP TABLE IF EXISTS `imagenesweb`;
CREATE TABLE `imagenesweb` (
  `idimagenesweb` int(11) NOT NULL AUTO_INCREMENT,
  `imagenesweb_url` varchar(200) DEFAULT NULL,
  `imagenesweb_estado` bit(1) DEFAULT b'1',
  `size_height` int(11) DEFAULT NULL,
  `size_width` int(11) DEFAULT NULL,
  `idtipo_objeto` int(11) DEFAULT NULL,
  PRIMARY KEY (`idimagenesweb`),
  KEY `fkimagenesweb_tipo_objeto1_idx` (`idtipo_objeto`),
  CONSTRAINT `fkimagenesweb_tipo_objeto1` FOREIGN KEY (`idtipo_objeto`) REFERENCES `tipo_objeto` (`idtipo_objeto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of imagenesweb
-- ----------------------------

-- ----------------------------
-- Table structure for nivel
-- ----------------------------
DROP TABLE IF EXISTS `nivel`;
CREATE TABLE `nivel` (
  `idnivel` int(11) NOT NULL AUTO_INCREMENT,
  `nivel_estado` varchar(200) DEFAULT '1',
  `nivel_nombre` varchar(200) DEFAULT NULL,
  `nivel_numero` int(11) DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idnivel`),
  KEY `fknivel_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fknivel_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nivel
-- ----------------------------
INSERT INTO `nivel` VALUES ('1', '1', 'uno', '1', null);
INSERT INTO `nivel` VALUES ('2', '1', 'dos', '2', null);
INSERT INTO `nivel` VALUES ('3', '1', 'tres', '3', null);
INSERT INTO `nivel` VALUES ('4', '1', 'cuatro', '4', null);
INSERT INTO `nivel` VALUES ('5', '1', 'cinco', '5', null);

-- ----------------------------
-- Table structure for perfilgrupopermiso
-- ----------------------------
DROP TABLE IF EXISTS `perfilgrupopermiso`;
CREATE TABLE `perfilgrupopermiso` (
  `idPerfilGrupoPermiso` int(11) NOT NULL,
  `FechaCreacion` datetime DEFAULT NULL,
  `FechaEliminacion` datetime DEFAULT NULL,
  `Estado` bit(1) DEFAULT b'1',
  `idtipo_acceso` int(11) NOT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPerfilGrupoPermiso`,`idtipo_acceso`),
  KEY `fkPerfilGrupoPermiso_tipo_acceso1_idx` (`idtipo_acceso`),
  KEY `fkPerfilGrupoPermiso_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkPerfilGrupoPermiso_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fkPerfilGrupoPermiso_tipo_acceso1` FOREIGN KEY (`idtipo_acceso`) REFERENCES `tipo_acceso` (`idtipo_acceso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of perfilgrupopermiso
-- ----------------------------

-- ----------------------------
-- Table structure for profesor
-- ----------------------------
DROP TABLE IF EXISTS `profesor`;
CREATE TABLE `profesor` (
  `idProfesor` int(11) NOT NULL AUTO_INCREMENT,
  `Profesor_Nombres` varchar(500) DEFAULT NULL,
  `Profesor_estado` bit(1) NOT NULL DEFAULT b'1',
  `Profesor_DNI` varchar(25) DEFAULT NULL,
  `Profesor_fotoURL` varchar(300) DEFAULT NULL,
  `Profesor_Descripcion` longtext,
  `Profesor_fechaNacimiento` datetime DEFAULT NULL,
  `idColaboradores` int(11) DEFAULT NULL,
  PRIMARY KEY (`idProfesor`),
  KEY `fkProfesor_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkProfesor_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of profesor
-- ----------------------------
INSERT INTO `profesor` VALUES ('1', 'Albert Piu', '', '777777777', 'piu.png', 'Profe Piu', '1993-11-05 08:44:57', null);

-- ----------------------------
-- Table structure for slidertransicion
-- ----------------------------
DROP TABLE IF EXISTS `slidertransicion`;
CREATE TABLE `slidertransicion` (
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
  KEY `fkSliderTransicion_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkSliderTransicion_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of slidertransicion
-- ----------------------------

-- ----------------------------
-- Table structure for supervisor
-- ----------------------------
DROP TABLE IF EXISTS `supervisor`;
CREATE TABLE `supervisor` (
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
  KEY `fkSupervisor_Colaboradores1_idx` (`idColaboradores`),
  CONSTRAINT `fkSupervisor_Colaboradores1` FOREIGN KEY (`idColaboradores`) REFERENCES `colaboradores` (`idColaboradores`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of supervisor
-- ----------------------------
INSERT INTO `supervisor` VALUES ('1', 'Flor', '0968989', 'foto.jpg', 'flor@email.com', '2014-04-18 09:53:28', '', null, null, null);

-- ----------------------------
-- Table structure for tipo_acceso
-- ----------------------------
DROP TABLE IF EXISTS `tipo_acceso`;
CREATE TABLE `tipo_acceso` (
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

-- ----------------------------
-- Records of tipo_acceso
-- ----------------------------

-- ----------------------------
-- Table structure for tipo_objeto
-- ----------------------------
DROP TABLE IF EXISTS `tipo_objeto`;
CREATE TABLE `tipo_objeto` (
  `idtipo_objeto` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_objeto_codigo` varchar(11) NOT NULL,
  `tipo_objeto_descripcion` varchar(200) DEFAULT NULL,
  `tipo_objeto_estado` bit(1) DEFAULT b'1',
  `tipo_objeto_codigo_padre` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`idtipo_objeto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tipo_objeto
-- ----------------------------
INSERT INTO `tipo_objeto` VALUES ('1', 'COD00000001', 'Imagen de portada', '', null);
INSERT INTO `tipo_objeto` VALUES ('2', 'COD00000002', 'Portada del Home', '', 'COD00000001');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
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
  `Usuario_ApellidoPaterno` varchar(100) DEFAULT NULL,
  `Usuario_ApellidoMaterno` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`,`idusuariodatos`),
  KEY `fkUsuario_usuariodatos1_idx` (`idusuariodatos`),
  CONSTRAINT `fkUsuario_usuariodatos1` FOREIGN KEY (`idusuariodatos`) REFERENCES `usuariodatos` (`idusuariodatos`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES ('203', 'gianpiere Ramos', '205', null, null, null, '', null, null, '2014-04-12 08:49:44', null, null, null);
INSERT INTO `usuario` VALUES ('204', 'Thais', '206', null, null, null, '', null, null, '2014-04-19 16:22:33', null, null, null);
INSERT INTO `usuario` VALUES ('205', 'ggg', '207', null, null, '2014-04-16', '', null, '0', '2014-04-20 11:56:26', '', null, null);
INSERT INTO `usuario` VALUES ('207', 'Yt', '209', null, null, null, '', null, null, '2014-04-26 01:20:29', null, null, null);

-- ----------------------------
-- Table structure for usuariodatos
-- ----------------------------
DROP TABLE IF EXISTS `usuariodatos`;
CREATE TABLE `usuariodatos` (
  `idusuariodatos` int(11) NOT NULL AUTO_INCREMENT,
  `usuariodatos_email` varchar(70) DEFAULT NULL,
  `usuariodatos_token` varchar(25) DEFAULT NULL,
  `usuariodatos_facebookKEY` varchar(200) DEFAULT NULL,
  `usuariodatos_password` varchar(400) DEFAULT NULL,
  `idSupervisor` int(11) DEFAULT NULL,
  `usuariodatos_codigoActivacion` varchar(25) DEFAULT NULL,
  `usuariodatos_pasoActivacion` enum('1','2','3','0') DEFAULT '1',
  PRIMARY KEY (`idusuariodatos`),
  KEY `fkusuariodatos_Supervisor1_idx` (`idSupervisor`),
  CONSTRAINT `fkusuariodatos_Supervisor1` FOREIGN KEY (`idSupervisor`) REFERENCES `supervisor` (`idSupervisor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usuariodatos
-- ----------------------------
INSERT INTO `usuariodatos` VALUES ('205', 'gianpiere@live.com', '49bc3653d8779a7ce96f74561', null, '123', null, '3454638', '1');
INSERT INTO `usuariodatos` VALUES ('206', 'thais@hotmail.com', '47d7bbf22579ad072ae8382d8', null, '7777777', null, null, '1');
INSERT INTO `usuariodatos` VALUES ('207', 'kev@gmail.com', 'e28bafd2c15220ec1fe434be2', null, '777', '1', null, '1');
INSERT INTO `usuariodatos` VALUES ('209', 'kkhk', 'e403db7f1065f5244402c6cd2', null, '4444', null, null, '1');

-- ----------------------------
-- View structure for view_crscursos
-- ----------------------------
DROP VIEW IF EXISTS `view_crscursos`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `view_crscursos` AS SELECT
	crs.idCurso										AS idCurso,
	crs.Curso_Nombre							AS CursoNombre,
	crs.Curso_estado							AS CursoEstado,
	crs.Curso_fechaCreacion				AS CursoFechaCreacion,
	crs.Curso_fechaEliminacion		AS CursoFechaEliminacion,
	crs.idnivel										AS CursoNivelId,
	crs.idProfesor								AS CursoProfesorId,
	prf.Profesor_Nombres					AS CursoProfesorNombre,
	prf.Profesor_fotoURL					AS CursoProfesorFotoUrl,
	prf.Profesor_fechaNacimiento	AS CursoProfesorFechaNacimiento,
	prf.Profesor_estado						AS CursoProfesorEstado,
	nvl.nivel_nombre 							AS CursoNivelNombre,
	nvl.nivel_numero 							AS CursoNivelNumero
FROM curso AS crs
INNER JOIN profesor AS prf ON crs.idProfesor = prf.idProfesor 
INNER JOIN nivel AS nvl ON nvl.idnivel = crs.idnivel ;

-- ----------------------------
-- View structure for view_flfolder
-- ----------------------------
DROP VIEW IF EXISTS `view_flfolder`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost`  VIEW `view_flfolder` AS SELECT
	fl.idfolder										AS idFolder,
	fl.folder_estado							AS FolderEstado,
	fl.folder_descripcion					AS FolderDescripcion,
	fl.folder_Costo								AS FolderCosto,
	fl.idCurso										AS FolderCursoId,
	fl.idAula											AS FolderAulaId,
	fl.idhorarios									AS FolderHorarioId,
	hr.horarios_estado						AS FolderHorarioEstado,
	hr.horarios_fechaInicio				AS FolderHorarioFechaInicio,
	hr.horarios_fechaFinal				AS FolderHorarioFechaFinal,
	hr.horarios_diasdesemana			AS FolderHorarioDiasxSemana,
	au.Aula_Nombre								AS FolderAulaNombre,
	au.Aula_Codigo								AS FolderAulaCodigo,
	au.Aula_Estado								AS FolderAulaEstado,
	au.Aula_Descripcion						AS FolderAulaDescripcion,
	au.Aula_AforoMaximo						AS FolderAulaAforo,
	crs.Curso_Nombre							AS FolderCursoNombre,
	crs.Curso_estado							AS FolderCursoEstado,
	crs.idnivel										AS FolderNivelId,
	nv.nivel_nombre								AS FolderNivelNombre,
	nv.nivel_numero								AS FolderNivelNumero,
	prf.Profesor_Nombres					AS FolderProfesorNombres,
	prf.Profesor_estado						AS FolderProfesorEstado,
	prf.Profesor_DNI							AS FolderProfesorDNI,
	prf.Profesor_fotoURL					AS FolderProfesorFotoURL,
	prf.Profesor_Descripcion			AS FolderProfesorDescripcion,
	prf.Profesor_fechaNacimiento	AS FolderProfesorFechaNacimiento
FROM folder AS fl
INNER JOIN curso AS crs ON fl.idCurso = crs.idCurso
INNER JOIN aula AS au ON fl.idAula = au.idAula
INNER JOIN horarios AS hr ON fl.idhorarios = hr.idhorarios
INNER JOIN nivel AS nv ON crs.idnivel = nv.idnivel
INNER JOIN profesor AS prf ON crs.idProfesor = prf.idProfesor ;

-- ----------------------------
-- View structure for view_usdatosdeusuario
-- ----------------------------
DROP VIEW IF EXISTS `view_usdatosdeusuario`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `view_usdatosdeusuario` AS SELECT 
	us.idUsuario 											AS idUsuario,
	us.Usuario_Nombres 								AS UsuarioNombres,
	us.idusuariodatos 								AS UsuarioDatosId,
	us.Usuario_dni										AS UsuarioDNI,
	us.Usuario_direccionUBIGEO				AS UsuarioUBIGEO,
	us.Usuario_fechaNacimiento				AS UsuarioFechaNacimiento,
	us.Usuario_estado									AS UsuarioEstado,
	us.Usuario_fechaEliminacion				AS UsuarioFechaEliminacion,
	us.Usuario_fotoURL								AS UsuarioFotoURL,
	us.Usuario_fechaCreacion					AS UsuarioFechaCreacion,
	usd.usuariodatos_email						AS UsuarioEmail,
	usd.usuariodatos_token						AS UsuarioToken,
	usd.usuariodatos_facebookKEY			AS UsuarioFacebookKEY,
	usd.usuariodatos_password					AS UsuarioPassword,
	usd.usuariodatos_codigoActivacion AS UsuarioCodigoActivacion,
	usd.idSupervisor									AS UsuarioSupervisorId,
	sp.Supervisor_Nombres							AS UsuarioSupervisorNombres
FROM 
	usuario AS us
INNER JOIN usuariodatos usd ON usd.idusuariodatos = us.idusuariodatos
LEFT JOIN supervisor sp ON sp.idSupervisor = usd.idSupervisor ;

-- ----------------------------
-- Procedure structure for SP_crsBuscarCursoxId
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_crsBuscarCursoxId`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_crsBuscarCursoxNivel
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_crsBuscarCursoxNivel`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_crsBuscarCursoxNombre
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_crsBuscarCursoxNombre`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_crsBuscarCursoxProfesorId
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_crsBuscarCursoxProfesorId`;
DELIMITER ;;
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

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_crsListarCursos
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_crsListarCursos`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_crspInsertarCursoPrevio
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_crspInsertarCursoPrevio`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_dvDevocionalMostrarUltimo
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_dvDevocionalMostrarUltimo`;
DELIMITER ;;
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
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_supListarSupervisor
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_supListarSupervisor`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_usBuscarUsuario
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_usBuscarUsuario`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_usBuscarUsuarioId
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_usBuscarUsuarioId`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_usConfirmarActivacionUsuario
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_usConfirmarActivacionUsuario`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_usCrearUsuario
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_usCrearUsuario`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_usEliminarUsuario
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_usEliminarUsuario`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_usIniciarSession
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_usIniciarSession`;
DELIMITER ;;
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
	
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_usNuevoCodigoActivacion
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_usNuevoCodigoActivacion`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_usUpdateUsuarioDatosBasicos
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_usUpdateUsuarioDatosBasicos`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for SP_usUsuariosxSupervisorId
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_usUsuariosxSupervisorId`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for fn_newCodigoActivacion
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_newCodigoActivacion`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_newCodigoActivacion`() RETURNS varchar(7) CHARSET utf8
BEGIN
	/**
	*	@Name		: fn_newCodigoActivacion
	* @Params : no Params
	* @Date 	: 20/02/2014
	*/
	DECLARE iCodigo VARCHAR(7) DEFAULT FLOOR(1010101 + RAND( ) * 9876540);
	RETURN iCodigo;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for fn_newUserToken
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_newUserToken`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for fn_UserIdValidatePassword
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_UserIdValidatePassword`;
DELIMITER ;;
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
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for fn_ValidateTokenUser
-- ----------------------------
DROP FUNCTION IF EXISTS `fn_ValidateTokenUser`;
DELIMITER ;;
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
END
;;
DELIMITER ;
