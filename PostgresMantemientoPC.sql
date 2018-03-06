

CREATE TABLE "mantenimientoPC"."information_schema"."Calendario" (
                "idCalendario" INTEGER NOT NULL,
                "fecha_mantenimiento" DATE NOT NULL,
                "excepcion" BIT NOT NULL,
                CONSTRAINT "calendario_pk" PRIMARY KEY ("idCalendario")
);


CREATE TABLE "mantenimientoPC"."information_schema"."DIagnostico" (
                "pk_idDiagnostico" INTEGER NOT NULL,
                "fk_idOrdenTrabajo" INTEGER NOT NULL,
                CONSTRAINT "diagnostico_pk" PRIMARY KEY ("pk_idDiagnostico")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Dianostico_parte" (
                "pk_idDianostico_parte" INTEGER NOT NULL,
                "fk_idOrdenTrabajo" INTEGER NOT NULL,
                "fk_idDiagnostico" INTEGER NOT NULL,
                "fk_idNoSerie" VARCHAR(15) NOT NULL,
                "descripcionProblema" VARCHAR(45) NOT NULL,
                CONSTRAINT "dianostico_parte_pk" PRIMARY KEY ("pk_idDianostico_parte")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Equipo" (
                "pk_idNoSerie" VARCHAR(15) NOT NULL,
                "fk_PadreIdnoSerie" VARCHAR(15) NOT NULL,
                "fk_idFabricante" INTEGER NOT NULL,
                "noInventario" VARCHAR(30),
                "partNumber" VARCHAR(20),
                "modelo" VARCHAR(45),
                "hardware_software" BIT NOT NULL,
                "sofware" VARCHAR(45),
                "version" VARCHAR(20),
                "arquitectura3264" BIT,
                "licencia" BIT,
                "observaciones" TEXT NOT NULL,
                CONSTRAINT "equipo_pk" PRIMARY KEY ("pk_idNoSerie")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Estado" (
                "pk_idEstado" INTEGER NOT NULL,
                "EstadoNombre" VARCHAR(45) NOT NULL,
                "descripcion" TEXT,
                CONSTRAINT "estado_pk" PRIMARY KEY ("pk_idEstado")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Estado_detalle" (
                "pk_idEstado" INTEGER NOT NULL,
                "pk_idPersonal" INTEGER NOT NULL,
                "pk_idDianostico_parte" INTEGER NOT NULL,
                "pk_idPaso" INTEGER NOT NULL,
                "pk_idTipo_procedimiento" INTEGER NOT NULL,
                CONSTRAINT "estado_detalle_pk" PRIMARY KEY ("pk_idEstado", "pk_idPersonal", "pk_idDianostico_parte", "pk_idPaso", "pk_idTipo_procedimiento")
);


CREATE TABLE "mantenimientoPC"."information_schema"."fabricantes" (
                "pk_idFabricante" INTEGER NOT NULL,
                "nombre" VARCHAR(60) NOT NULL,
                "descripcion" VARCHAR(100),
                "correo" VARCHAR(45),
                "telefono" VARCHAR(45),
                "direccion" VARCHAR(100),
                CONSTRAINT "fabricantes_pk" PRIMARY KEY ("pk_idFabricante")
);


CREATE TABLE "mantenimientoPC"."information_schema"."HistorialTrabajo" (
                "pk_idHistorialTrabajo" INTEGER NOT NULL,
                "fk_idPersonal" INTEGER NOT NULL,
                "fk_idTrabajo" INTEGER NOT NULL,
                "fechaInicio" DATE NOT NULL,
                "fechaFin" DATE,
                CONSTRAINT "historialtrabajo_pk" PRIMARY KEY ("pk_idHistorialTrabajo")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Mantenimiento_detalle" (
                "pk_idMantenimiento_detallecol" INTEGER NOT NULL,
                "pk_idOrdenTrabajo" INTEGER NOT NULL,
                "fk_idNoSerie" VARCHAR(15) NOT NULL,
                "observaciones" TEXT,
                "fk_idEstado" INTEGER NOT NULL,
                "fk_idPersonal" INTEGER NOT NULL,
                "fk_idDianostico_parte" INTEGER NOT NULL,
                "fk_idPaso" INTEGER NOT NULL,
                "fk_idTipo_procedimiento" INTEGER NOT NULL,
                "fecha" DATE NOT NULL,
                CONSTRAINT "mantenimiento_detalle_pk" PRIMARY KEY ("pk_idMantenimiento_detallecol", "pk_idOrdenTrabajo")
);


CREATE TABLE "mantenimientoPC"."information_schema"."OrdenTrabajo" (
                "pk_idOrdenTrabajo" INTEGER NOT NULL,
                "fk_idPrioridad" INTEGER NOT NULL,
                "fk_idTipoMantenimiento" INTEGER NOT NULL,
                "fk_idUnidad" INTEGER NOT NULL,
                "fk_idOrigenSolicitud" INTEGER NOT NULL,
                "solicitudDescripcion" TEXT,
                "solicitudFecha" DATE,
                "clienteNombre" VARCHAR(45),
                "clienteEmail" VARCHAR(45),
                "clienteTelefono" VARCHAR(15),
                "clienteDomicilio" VARCHAR(45),
                "Estado" BIT NOT NULL,
                "ordenTrabajoAprobadaFecha" DATE,
                "tecnicoDiagnostico" TEXT,
                "posibleFechaEntrega" DATE,
                "fk_idNoSerie" VARCHAR(15) NOT NULL,
                CONSTRAINT "ordentrabajo_pk" PRIMARY KEY ("pk_idOrdenTrabajo")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Pasos" (
                "pk_idPaso" INTEGER NOT NULL,
                "descripcion" VARCHAR(45) NOT NULL,
                "observacion" TEXT,
                "duracion_Paso" VARCHAR(45),
                CONSTRAINT "pasos_pk" PRIMARY KEY ("pk_idPaso")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Personal" (
                "pk_idPersonal" INTEGER NOT NULL,
                "fk_padrePersonal" INTEGER NOT NULL,
                "nombre" VARCHAR(45) NOT NULL,
                "apellido" VARCHAR(45) NOT NULL,
                "dui" VARCHAR(45) NOT NULL,
                "nit" VARCHAR(45) NOT NULL,
                "estado" BIT NOT NULL,
                "empleadoEstudiante" BIT NOT NULL,
                "due" VARCHAR(45),
                "domicilio" VARCHAR(45) NOT NULL,
                CONSTRAINT "personal_pk" PRIMARY KEY ("pk_idPersonal")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Prioridad" (
                "pk_idPrioridad" INTEGER NOT NULL,
                "PrioridadNivel" VARCHAR(45) NOT NULL,
                CONSTRAINT "prioridad_pk" PRIMARY KEY ("pk_idPrioridad")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Procedimientos" (
                "pk_idDianostico_parte" INTEGER NOT NULL,
                "pk_idPaso" INTEGER NOT NULL,
                "pk_idTipo_procedimiento" INTEGER NOT NULL,
                "nombre_Procedimiento" VARCHAR(100),
                CONSTRAINT "procedimientos_pk" PRIMARY KEY ("pk_idDianostico_parte", "pk_idPaso", "pk_idTipo_procedimiento")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Rol" (
                "pk_idTrabajo" INTEGER NOT NULL,
                "descripcion" VARCHAR(45) NOT NULL,
                CONSTRAINT "rol_pk" PRIMARY KEY ("pk_idTrabajo")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Solicitud" (
                "pk_idSolicitud" INTEGER NOT NULL,
                "solicitante" VARCHAR(45) NOT NULL,
                "descripcion" TEXT,
                "correo" VARCHAR(150),
                CONSTRAINT "solicitud_pk" PRIMARY KEY ("pk_idSolicitud")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Sub_TipoMantenimiento" (
                "pk_idSub_TipoMantenimiento" INTEGER NOT NULL,
                "descripcion" VARCHAR(70) NOT NULL,
                CONSTRAINT "sub_tipomantenimiento_pk" PRIMARY KEY ("pk_idSub_TipoMantenimiento")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Telefono" (
                "pk_idTelefono" INTEGER NOT NULL,
                "fk_idPersonal" INTEGER NOT NULL,
                "Telefono" VARCHAR(45) NOT NULL,
                CONSTRAINT "telefono_pk" PRIMARY KEY ("pk_idTelefono")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Tipo_procedimiento" (
                "pk_idTipo_procedimiento" INTEGER NOT NULL,
                "descripcion" VARCHAR(45) NOT NULL,
                "observacion" TEXT,
                CONSTRAINT "tipo_procedimiento_pk" PRIMARY KEY ("pk_idTipo_procedimiento")
);


CREATE TABLE "mantenimientoPC"."information_schema"."TipoMantenimiento" (
                "pk_idTipoMantenimiento" INTEGER NOT NULL,
                "fk_idSub_TipoMantenimiento" INTEGER NOT NULL,
                "descripcion" VARCHAR(70) NOT NULL,
                CONSTRAINT "tipomantenimiento_pk" PRIMARY KEY ("pk_idTipoMantenimiento")
);


CREATE TABLE "mantenimientoPC"."information_schema"."Unidad" (
                "pk_idUnidad" INTEGER NOT NULL,
                "UnidadNombre" VARCHAR(45) NOT NULL,
                "descripcion" VARCHAR(100),
                CONSTRAINT "unidad_pk" PRIMARY KEY ("pk_idUnidad")
);


ALTER TABLE "mantenimientoPC"."information_schema"."Dianostico_parte" ADD CONSTRAINT "fk_dianostico_parte_diagnostico1"
FOREIGN KEY ("fk_idDiagnostico")
REFERENCES "mantenimientoPC"."information_schema"."DIagnostico" ("pk_idDiagnostico")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Procedimientos" ADD CONSTRAINT "fk_procedimientos_dianostico_parte1"
FOREIGN KEY ("pk_idDianostico_parte")
REFERENCES "mantenimientoPC"."information_schema"."Dianostico_parte" ("pk_idDianostico_parte")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Dianostico_parte" ADD CONSTRAINT "fk_dianostico_parte_equipo1"
FOREIGN KEY ("fk_idNoSerie")
REFERENCES "mantenimientoPC"."information_schema"."Equipo" ("pk_idNoSerie")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Equipo" ADD CONSTRAINT "fk_equipo_detalle_equipo_detalle1"
FOREIGN KEY ("fk_PadreIdnoSerie")
REFERENCES "mantenimientoPC"."information_schema"."Equipo" ("pk_idNoSerie")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Mantenimiento_detalle" ADD CONSTRAINT "fk_mantenimiento_detalle_equipo1"
FOREIGN KEY ("fk_idNoSerie")
REFERENCES "mantenimientoPC"."information_schema"."Equipo" ("pk_idNoSerie")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."OrdenTrabajo" ADD CONSTRAINT "fk_ordentrabajo_equipo1"
FOREIGN KEY ("fk_idNoSerie")
REFERENCES "mantenimientoPC"."information_schema"."Equipo" ("pk_idNoSerie")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Estado_detalle" ADD CONSTRAINT "fk_estado_detalle_estado1"
FOREIGN KEY ("pk_idEstado")
REFERENCES "mantenimientoPC"."information_schema"."Estado" ("pk_idEstado")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Mantenimiento_detalle" ADD CONSTRAINT "estado_detalle_mantenimiento_detalle_fk"
FOREIGN KEY ("fk_idEstado", "fk_idPersonal", "fk_idDianostico_parte", "fk_idPaso", "fk_idTipo_procedimiento")
REFERENCES "mantenimientoPC"."information_schema"."Estado_detalle" ("pk_idEstado", "pk_idPersonal", "pk_idDianostico_parte", "pk_idPaso", "pk_idTipo_procedimiento")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Equipo" ADD CONSTRAINT "fk_equipo_detalle_fabricantes1"
FOREIGN KEY ("fk_idFabricante")
REFERENCES "mantenimientoPC"."information_schema"."fabricantes" ("pk_idFabricante")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."DIagnostico" ADD CONSTRAINT "ordentrabajo_diagnostico_fk"
FOREIGN KEY ("fk_idOrdenTrabajo")
REFERENCES "mantenimientoPC"."information_schema"."OrdenTrabajo" ("pk_idOrdenTrabajo")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Dianostico_parte" ADD CONSTRAINT "ordentrabajo_dianostico_parte_fk"
FOREIGN KEY ("fk_idOrdenTrabajo")
REFERENCES "mantenimientoPC"."information_schema"."OrdenTrabajo" ("pk_idOrdenTrabajo")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Mantenimiento_detalle" ADD CONSTRAINT "ordentrabajo_mantenimiento_detalle_fk"
FOREIGN KEY ("pk_idOrdenTrabajo")
REFERENCES "mantenimientoPC"."information_schema"."OrdenTrabajo" ("pk_idOrdenTrabajo")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Procedimientos" ADD CONSTRAINT "fk_procedimientos_pasos1"
FOREIGN KEY ("pk_idPaso")
REFERENCES "mantenimientoPC"."information_schema"."Pasos" ("pk_idPaso")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Estado_detalle" ADD CONSTRAINT "fk_estado_detalle_personal1"
FOREIGN KEY ("pk_idPersonal")
REFERENCES "mantenimientoPC"."information_schema"."Personal" ("pk_idPersonal")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."HistorialTrabajo" ADD CONSTRAINT "personal_historialtrabajo_fk"
FOREIGN KEY ("fk_idPersonal")
REFERENCES "mantenimientoPC"."information_schema"."Personal" ("pk_idPersonal")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Telefono" ADD CONSTRAINT "fk_telefono_personal1"
FOREIGN KEY ("fk_idPersonal")
REFERENCES "mantenimientoPC"."information_schema"."Personal" ("pk_idPersonal")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."OrdenTrabajo" ADD CONSTRAINT "fk_ordentrabajo_prioridad"
FOREIGN KEY ("fk_idPrioridad")
REFERENCES "mantenimientoPC"."information_schema"."Prioridad" ("pk_idPrioridad")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Estado_detalle" ADD CONSTRAINT "fk_estado_detalle_procedimientos1"
FOREIGN KEY ("pk_idDianostico_parte", "pk_idPaso", "pk_idTipo_procedimiento")
REFERENCES "mantenimientoPC"."information_schema"."Procedimientos" ("pk_idDianostico_parte", "pk_idPaso", "pk_idTipo_procedimiento")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."HistorialTrabajo" ADD CONSTRAINT "fk_historialtrabajo_rol1"
FOREIGN KEY ("fk_idTrabajo")
REFERENCES "mantenimientoPC"."information_schema"."Rol" ("pk_idTrabajo")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."OrdenTrabajo" ADD CONSTRAINT "fk_ordentrabajo_origensolicitud1"
FOREIGN KEY ("fk_idOrigenSolicitud")
REFERENCES "mantenimientoPC"."information_schema"."Solicitud" ("pk_idSolicitud")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."TipoMantenimiento" ADD CONSTRAINT "fk_tipomantenimiento_sub_tipomantenimiento1"
FOREIGN KEY ("fk_idSub_TipoMantenimiento")
REFERENCES "mantenimientoPC"."information_schema"."Sub_TipoMantenimiento" ("pk_idSub_TipoMantenimiento")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."Procedimientos" ADD CONSTRAINT "fk_procedimientos_tipo_procedimiento1"
FOREIGN KEY ("pk_idTipo_procedimiento")
REFERENCES "mantenimientoPC"."information_schema"."Tipo_procedimiento" ("pk_idTipo_procedimiento")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."OrdenTrabajo" ADD CONSTRAINT "fk_ordentrabajo_tipomantenimiento1"
FOREIGN KEY ("fk_idTipoMantenimiento")
REFERENCES "mantenimientoPC"."information_schema"."TipoMantenimiento" ("pk_idTipoMantenimiento")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "mantenimientoPC"."information_schema"."OrdenTrabajo" ADD CONSTRAINT "fk_ordentrabajo_unidad1"
FOREIGN KEY ("fk_idUnidad")
REFERENCES "mantenimientoPC"."information_schema"."Unidad" ("pk_idUnidad")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
