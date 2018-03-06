--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.6

-- Started on 2018-03-06 03:01:24 CST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE "mantenimientoPC";
--
-- TOC entry 2376 (class 1262 OID 17149)
-- Name: mantenimientoPC; Type: DATABASE; Schema: -; Owner: restful
--

CREATE DATABASE "mantenimientoPC" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'es_SV.UTF-8' LC_CTYPE = 'es_SV.UTF-8';


ALTER DATABASE "mantenimientoPC" OWNER TO restful;

\connect "mantenimientoPC"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12393)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 205 (class 1259 OID 18880)
-- Name: calendario; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE calendario (
    idcalendario integer NOT NULL,
    fecha_mantenimiento date NOT NULL,
    excepcion bit(1) NOT NULL
);


ALTER TABLE calendario OWNER TO restful;

--
-- TOC entry 200 (class 1259 OID 18835)
-- Name: diagnostico; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE diagnostico (
    pk_iddiagnostico integer NOT NULL,
    fk_idordentrabajo integer NOT NULL
);


ALTER TABLE diagnostico OWNER TO restful;

--
-- TOC entry 201 (class 1259 OID 18841)
-- Name: dianostico_parte; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE dianostico_parte (
    pk_iddianostico_parte integer NOT NULL,
    fk_idordentrabajo integer NOT NULL,
    fk_iddiagnostico integer NOT NULL,
    fk_idnoserie character varying(15) NOT NULL,
    descripcionproblema character varying(45) NOT NULL
);


ALTER TABLE dianostico_parte OWNER TO restful;

--
-- TOC entry 186 (class 1259 OID 18735)
-- Name: equipo; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE equipo (
    pk_idnoserie character varying(15) NOT NULL,
    fk_padreidnoserie character varying(15) NOT NULL,
    fk_idfabricante integer NOT NULL,
    noinventario character varying(30),
    partnumber character varying(20),
    modelo character varying(45),
    hardware_software bit(1) NOT NULL,
    sofware character varying(45),
    version character varying(20),
    arquitectura3264 bit(1),
    licencia bit(1),
    observaciones text NOT NULL
);


ALTER TABLE equipo OWNER TO restful;

--
-- TOC entry 189 (class 1259 OID 18761)
-- Name: estado; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE estado (
    pk_idestado integer NOT NULL,
    estadonombre character varying(45) NOT NULL,
    descripcion text
);


ALTER TABLE estado OWNER TO restful;

--
-- TOC entry 203 (class 1259 OID 18857)
-- Name: estado_detalle; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE estado_detalle (
    pk_idestado integer NOT NULL,
    pk_idpersonal integer NOT NULL,
    pk_iddianostico_parte integer NOT NULL,
    pk_idpaso integer NOT NULL,
    pk_idtipo_procedimiento integer NOT NULL
);


ALTER TABLE estado_detalle OWNER TO restful;

--
-- TOC entry 185 (class 1259 OID 18730)
-- Name: fabricantes; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE fabricantes (
    pk_idfabricante integer NOT NULL,
    nombre character varying(60) NOT NULL,
    descripcion character varying(100),
    correo character varying(45),
    telefono character varying(45),
    direccion character varying(100)
);


ALTER TABLE fabricantes OWNER TO restful;

--
-- TOC entry 193 (class 1259 OID 18786)
-- Name: historialtrabajo; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE historialtrabajo (
    pk_idhistorialtrabajo integer NOT NULL,
    fk_idpersonal integer NOT NULL,
    fk_idtrabajo integer NOT NULL,
    fechainicio date NOT NULL,
    fechafin date
);


ALTER TABLE historialtrabajo OWNER TO restful;

--
-- TOC entry 204 (class 1259 OID 18865)
-- Name: mantenimiento_detalle; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE mantenimiento_detalle (
    pk_idmantenimiento_detallecol integer NOT NULL,
    pk_idordentrabajo integer NOT NULL,
    fk_idnoserie character varying(15) NOT NULL,
    observaciones text,
    fk_idestado integer NOT NULL,
    fk_idpersonal integer NOT NULL,
    fk_iddianostico_parte integer NOT NULL,
    fk_idpaso integer NOT NULL,
    fk_idtipo_procedimiento integer NOT NULL,
    fecha date NOT NULL
);


ALTER TABLE mantenimiento_detalle OWNER TO restful;

--
-- TOC entry 199 (class 1259 OID 18822)
-- Name: ordentrabajo; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE ordentrabajo (
    pk_idordentrabajo integer NOT NULL,
    fk_idprioridad integer NOT NULL,
    fk_idtipomantenimiento integer NOT NULL,
    fk_idunidad integer NOT NULL,
    fk_idorigensolicitud integer NOT NULL,
    solicituddescripcion text,
    solicitudfecha date,
    clientenombre character varying(45),
    clienteemail character varying(45),
    clientetelefono character varying(15),
    clientedomicilio character varying(45),
    estado bit(1) NOT NULL,
    ordentrabajoaprobadafecha date,
    tecnicodiagnostico text,
    posiblefechaentrega date,
    fk_idnoserie character varying(15) NOT NULL
);


ALTER TABLE ordentrabajo OWNER TO restful;

--
-- TOC entry 188 (class 1259 OID 18753)
-- Name: pasos; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE pasos (
    pk_idpaso integer NOT NULL,
    descripcion character varying(45) NOT NULL,
    observacion text,
    duracion_paso character varying(45)
);


ALTER TABLE pasos OWNER TO restful;

--
-- TOC entry 190 (class 1259 OID 18769)
-- Name: personal; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE personal (
    pk_idpersonal integer NOT NULL,
    fk_padrepersonal integer NOT NULL,
    nombre character varying(45) NOT NULL,
    apellido character varying(45) NOT NULL,
    dui character varying(45) NOT NULL,
    nit character varying(45) NOT NULL,
    estado bit(1) NOT NULL,
    empleadoestudiante bit(1) NOT NULL,
    due character varying(45),
    domicilio character varying(45) NOT NULL
);


ALTER TABLE personal OWNER TO restful;

--
-- TOC entry 194 (class 1259 OID 18793)
-- Name: prioridad; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE prioridad (
    pk_idprioridad integer NOT NULL,
    prioridadnivel character varying(45) NOT NULL
);


ALTER TABLE prioridad OWNER TO restful;

--
-- TOC entry 202 (class 1259 OID 18849)
-- Name: procedimientos; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE procedimientos (
    pk_iddianostico_parte integer NOT NULL,
    pk_idpaso integer NOT NULL,
    pk_idtipo_procedimiento integer NOT NULL,
    nombre_procedimiento character varying(100)
);


ALTER TABLE procedimientos OWNER TO restful;

--
-- TOC entry 192 (class 1259 OID 18781)
-- Name: rol; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE rol (
    pk_idtrabajo integer NOT NULL,
    descripcion character varying(45) NOT NULL
);


ALTER TABLE rol OWNER TO restful;

--
-- TOC entry 196 (class 1259 OID 18803)
-- Name: solicitud; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE solicitud (
    pk_idsolicitud integer NOT NULL,
    solicitante character varying(45) NOT NULL,
    descripcion text,
    correo character varying(150)
);


ALTER TABLE solicitud OWNER TO restful;

--
-- TOC entry 197 (class 1259 OID 18811)
-- Name: sub_tipomantenimiento; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE sub_tipomantenimiento (
    pk_idsub_tipomantenimiento integer NOT NULL,
    descripcion character varying(70) NOT NULL
);


ALTER TABLE sub_tipomantenimiento OWNER TO restful;

--
-- TOC entry 191 (class 1259 OID 18775)
-- Name: telefono; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE telefono (
    pk_idtelefono integer NOT NULL,
    fk_idpersonal integer NOT NULL,
    telefono character varying(45) NOT NULL
);


ALTER TABLE telefono OWNER TO restful;

--
-- TOC entry 187 (class 1259 OID 18745)
-- Name: tipo_procedimiento; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE tipo_procedimiento (
    pk_idtipo_procedimiento integer NOT NULL,
    descripcion character varying(45) NOT NULL,
    observacion text
);


ALTER TABLE tipo_procedimiento OWNER TO restful;

--
-- TOC entry 198 (class 1259 OID 18816)
-- Name: tipomantenimiento; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE tipomantenimiento (
    pk_idtipomantenimiento integer NOT NULL,
    fk_idsub_tipomantenimiento integer NOT NULL,
    descripcion character varying(70) NOT NULL
);


ALTER TABLE tipomantenimiento OWNER TO restful;

--
-- TOC entry 195 (class 1259 OID 18798)
-- Name: unidad; Type: TABLE; Schema: public; Owner: restful
--

CREATE TABLE unidad (
    pk_idunidad integer NOT NULL,
    unidadnombre character varying(45) NOT NULL,
    descripcion character varying(100)
);


ALTER TABLE unidad OWNER TO restful;

--
-- TOC entry 2230 (class 2606 OID 18884)
-- Name: calendario calendario_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY calendario
    ADD CONSTRAINT calendario_pk PRIMARY KEY (idcalendario);


--
-- TOC entry 2203 (class 2606 OID 18839)
-- Name: diagnostico diagnostico_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY diagnostico
    ADD CONSTRAINT diagnostico_pk PRIMARY KEY (pk_iddiagnostico);


--
-- TOC entry 2206 (class 2606 OID 18845)
-- Name: dianostico_parte dianostico_parte_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY dianostico_parte
    ADD CONSTRAINT dianostico_parte_pk PRIMARY KEY (pk_iddianostico_parte);


--
-- TOC entry 2163 (class 2606 OID 18742)
-- Name: equipo equipo_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY equipo
    ADD CONSTRAINT equipo_pk PRIMARY KEY (pk_idnoserie);


--
-- TOC entry 2216 (class 2606 OID 18861)
-- Name: estado_detalle estado_detalle_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY estado_detalle
    ADD CONSTRAINT estado_detalle_pk PRIMARY KEY (pk_idestado, pk_idpersonal, pk_iddianostico_parte, pk_idpaso, pk_idtipo_procedimiento);


--
-- TOC entry 2171 (class 2606 OID 18768)
-- Name: estado estado_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (pk_idestado);


--
-- TOC entry 2161 (class 2606 OID 18734)
-- Name: fabricantes fabricantes_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY fabricantes
    ADD CONSTRAINT fabricantes_pk PRIMARY KEY (pk_idfabricante);


--
-- TOC entry 2183 (class 2606 OID 18790)
-- Name: historialtrabajo historialtrabajo_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY historialtrabajo
    ADD CONSTRAINT historialtrabajo_pk PRIMARY KEY (pk_idhistorialtrabajo);


--
-- TOC entry 2228 (class 2606 OID 18872)
-- Name: mantenimiento_detalle mantenimiento_detalle_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY mantenimiento_detalle
    ADD CONSTRAINT mantenimiento_detalle_pk PRIMARY KEY (pk_idmantenimiento_detallecol, pk_idordentrabajo);


--
-- TOC entry 2201 (class 2606 OID 18829)
-- Name: ordentrabajo ordentrabajo_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY ordentrabajo
    ADD CONSTRAINT ordentrabajo_pk PRIMARY KEY (pk_idordentrabajo);


--
-- TOC entry 2169 (class 2606 OID 18760)
-- Name: pasos pasos_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY pasos
    ADD CONSTRAINT pasos_pk PRIMARY KEY (pk_idpaso);


--
-- TOC entry 2174 (class 2606 OID 18773)
-- Name: personal personal_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY personal
    ADD CONSTRAINT personal_pk PRIMARY KEY (pk_idpersonal);


--
-- TOC entry 2185 (class 2606 OID 18797)
-- Name: prioridad prioridad_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY prioridad
    ADD CONSTRAINT prioridad_pk PRIMARY KEY (pk_idprioridad);


--
-- TOC entry 2214 (class 2606 OID 18853)
-- Name: procedimientos procedimientos_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY procedimientos
    ADD CONSTRAINT procedimientos_pk PRIMARY KEY (pk_iddianostico_parte, pk_idpaso, pk_idtipo_procedimiento);


--
-- TOC entry 2179 (class 2606 OID 18785)
-- Name: rol rol_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT rol_pk PRIMARY KEY (pk_idtrabajo);


--
-- TOC entry 2189 (class 2606 OID 18810)
-- Name: solicitud solicitud_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY solicitud
    ADD CONSTRAINT solicitud_pk PRIMARY KEY (pk_idsolicitud);


--
-- TOC entry 2191 (class 2606 OID 18815)
-- Name: sub_tipomantenimiento sub_tipomantenimiento_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY sub_tipomantenimiento
    ADD CONSTRAINT sub_tipomantenimiento_pk PRIMARY KEY (pk_idsub_tipomantenimiento);


--
-- TOC entry 2177 (class 2606 OID 18779)
-- Name: telefono telefono_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY telefono
    ADD CONSTRAINT telefono_pk PRIMARY KEY (pk_idtelefono);


--
-- TOC entry 2167 (class 2606 OID 18752)
-- Name: tipo_procedimiento tipo_procedimiento_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY tipo_procedimiento
    ADD CONSTRAINT tipo_procedimiento_pk PRIMARY KEY (pk_idtipo_procedimiento);


--
-- TOC entry 2194 (class 2606 OID 18820)
-- Name: tipomantenimiento tipomantenimiento_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY tipomantenimiento
    ADD CONSTRAINT tipomantenimiento_pk PRIMARY KEY (pk_idtipomantenimiento);


--
-- TOC entry 2187 (class 2606 OID 18802)
-- Name: unidad unidad_pk; Type: CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY unidad
    ADD CONSTRAINT unidad_pk PRIMARY KEY (pk_idunidad);


--
-- TOC entry 2204 (class 1259 OID 18840)
-- Name: fk_diagnostico_idordentrabajo1x; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_diagnostico_idordentrabajo1x ON diagnostico USING btree (fk_idordentrabajo);


--
-- TOC entry 2207 (class 1259 OID 18846)
-- Name: fk_dianostico_parte_diagnostico1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_dianostico_parte_diagnostico1_idx ON dianostico_parte USING btree (fk_iddiagnostico);


--
-- TOC entry 2208 (class 1259 OID 18847)
-- Name: fk_dianostico_parte_equipo1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_dianostico_parte_equipo1_idx ON dianostico_parte USING btree (fk_idnoserie);


--
-- TOC entry 2209 (class 1259 OID 18848)
-- Name: fk_dianostico_parte_ordentrabajo1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_dianostico_parte_ordentrabajo1_idx ON dianostico_parte USING btree (fk_idordentrabajo);


--
-- TOC entry 2164 (class 1259 OID 18744)
-- Name: fk_equipo_detalle_equipo_detalle1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_equipo_detalle_equipo_detalle1_idx ON equipo USING btree (fk_padreidnoserie);


--
-- TOC entry 2165 (class 1259 OID 18743)
-- Name: fk_equipo_detalle_fabricantes1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_equipo_detalle_fabricantes1_idx ON equipo USING btree (fk_idfabricante);


--
-- TOC entry 2217 (class 1259 OID 18862)
-- Name: fk_estado_detalle_estado1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_estado_detalle_estado1_idx ON estado_detalle USING btree (pk_idestado);


--
-- TOC entry 2218 (class 1259 OID 18863)
-- Name: fk_estado_detalle_personal1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_estado_detalle_personal1_idx ON estado_detalle USING btree (pk_idpersonal);


--
-- TOC entry 2219 (class 1259 OID 18864)
-- Name: fk_estado_detalle_procedimientos1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_estado_detalle_procedimientos1_idx ON estado_detalle USING btree (pk_iddianostico_parte, pk_idpaso, pk_idtipo_procedimiento);


--
-- TOC entry 2180 (class 1259 OID 18792)
-- Name: fk_historialtrabajo_personal1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_historialtrabajo_personal1_idx ON historialtrabajo USING btree (fk_idpersonal);


--
-- TOC entry 2181 (class 1259 OID 18791)
-- Name: fk_historialtrabajo_rol1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_historialtrabajo_rol1_idx ON historialtrabajo USING btree (fk_idtrabajo);


--
-- TOC entry 2220 (class 1259 OID 18874)
-- Name: fk_mantenimiento_detalle_equipo1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_mantenimiento_detalle_equipo1_idx ON mantenimiento_detalle USING btree (fk_idnoserie);


--
-- TOC entry 2221 (class 1259 OID 18873)
-- Name: fk_mantenimiento_detalle_ordentrabajo1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_mantenimiento_detalle_ordentrabajo1_idx ON mantenimiento_detalle USING btree (pk_idordentrabajo);


--
-- TOC entry 2195 (class 1259 OID 18834)
-- Name: fk_ordentrabajo_equipo1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_ordentrabajo_equipo1_idx ON ordentrabajo USING btree (fk_idnoserie);


--
-- TOC entry 2196 (class 1259 OID 18833)
-- Name: fk_ordentrabajo_origensolicitud1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_ordentrabajo_origensolicitud1_idx ON ordentrabajo USING btree (fk_idorigensolicitud);


--
-- TOC entry 2197 (class 1259 OID 18830)
-- Name: fk_ordentrabajo_prioridad_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_ordentrabajo_prioridad_idx ON ordentrabajo USING btree (fk_idprioridad);


--
-- TOC entry 2198 (class 1259 OID 18831)
-- Name: fk_ordentrabajo_tipomantenimiento1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_ordentrabajo_tipomantenimiento1_idx ON ordentrabajo USING btree (fk_idtipomantenimiento);


--
-- TOC entry 2199 (class 1259 OID 18832)
-- Name: fk_ordentrabajo_unidad1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_ordentrabajo_unidad1_idx ON ordentrabajo USING btree (fk_idunidad);


--
-- TOC entry 2210 (class 1259 OID 18854)
-- Name: fk_procedimientos_dianostico_parte1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_procedimientos_dianostico_parte1_idx ON procedimientos USING btree (pk_iddianostico_parte);


--
-- TOC entry 2211 (class 1259 OID 18855)
-- Name: fk_procedimientos_pasos1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_procedimientos_pasos1_idx ON procedimientos USING btree (pk_idpaso);


--
-- TOC entry 2212 (class 1259 OID 18856)
-- Name: fk_procedimientos_tipo_procedimiento1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_procedimientos_tipo_procedimiento1_idx ON procedimientos USING btree (pk_idtipo_procedimiento);


--
-- TOC entry 2172 (class 1259 OID 18774)
-- Name: fk_tecnico_tecnico1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_tecnico_tecnico1_idx ON personal USING btree (fk_padrepersonal);


--
-- TOC entry 2175 (class 1259 OID 18780)
-- Name: fk_telefono_personal1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_telefono_personal1_idx ON telefono USING btree (fk_idpersonal);


--
-- TOC entry 2192 (class 1259 OID 18821)
-- Name: fk_tipomantenimiento_sub_tipomantenimiento1_idx; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX fk_tipomantenimiento_sub_tipomantenimiento1_idx ON tipomantenimiento USING btree (fk_idsub_tipomantenimiento);


--
-- TOC entry 2222 (class 1259 OID 18877)
-- Name: mantenimiento_detalle_iddiagnosticoparte1x; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX mantenimiento_detalle_iddiagnosticoparte1x ON mantenimiento_detalle USING btree (fk_iddianostico_parte);


--
-- TOC entry 2223 (class 1259 OID 18875)
-- Name: mantenimiento_detalle_idestado1x; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX mantenimiento_detalle_idestado1x ON mantenimiento_detalle USING btree (fk_idestado);


--
-- TOC entry 2224 (class 1259 OID 18878)
-- Name: mantenimiento_detalle_idpaso; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX mantenimiento_detalle_idpaso ON mantenimiento_detalle USING btree (fk_idpaso);


--
-- TOC entry 2225 (class 1259 OID 18876)
-- Name: mantenimiento_detalle_idpersonal1x; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX mantenimiento_detalle_idpersonal1x ON mantenimiento_detalle USING btree (fk_idpersonal);


--
-- TOC entry 2226 (class 1259 OID 18879)
-- Name: mantenimiento_detalle_idtipoprocedimiento1x; Type: INDEX; Schema: public; Owner: restful
--

CREATE INDEX mantenimiento_detalle_idtipoprocedimiento1x ON mantenimiento_detalle USING btree (fk_idtipo_procedimiento);


--
-- TOC entry 2252 (class 2606 OID 19000)
-- Name: mantenimiento_detalle estado_detalle_mantenimiento_detalle_fk; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY mantenimiento_detalle
    ADD CONSTRAINT estado_detalle_mantenimiento_detalle_fk FOREIGN KEY (fk_idestado, fk_idpersonal, fk_iddianostico_parte, fk_idpaso, fk_idtipo_procedimiento) REFERENCES estado_detalle(pk_idestado, pk_idpersonal, pk_iddianostico_parte, pk_idpaso, pk_idtipo_procedimiento);


--
-- TOC entry 2245 (class 2606 OID 18985)
-- Name: dianostico_parte fk_dianostico_parte_diagnostico1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY dianostico_parte
    ADD CONSTRAINT fk_dianostico_parte_diagnostico1 FOREIGN KEY (fk_iddiagnostico) REFERENCES diagnostico(pk_iddiagnostico);


--
-- TOC entry 2243 (class 2606 OID 18895)
-- Name: dianostico_parte fk_dianostico_parte_equipo1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY dianostico_parte
    ADD CONSTRAINT fk_dianostico_parte_equipo1 FOREIGN KEY (fk_idnoserie) REFERENCES equipo(pk_idnoserie);


--
-- TOC entry 2232 (class 2606 OID 18890)
-- Name: equipo fk_equipo_detalle_equipo_detalle1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY equipo
    ADD CONSTRAINT fk_equipo_detalle_equipo_detalle1 FOREIGN KEY (fk_padreidnoserie) REFERENCES equipo(pk_idnoserie);


--
-- TOC entry 2231 (class 2606 OID 18885)
-- Name: equipo fk_equipo_detalle_fabricantes1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY equipo
    ADD CONSTRAINT fk_equipo_detalle_fabricantes1 FOREIGN KEY (fk_idfabricante) REFERENCES fabricantes(pk_idfabricante);


--
-- TOC entry 2250 (class 2606 OID 18920)
-- Name: estado_detalle fk_estado_detalle_estado1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY estado_detalle
    ADD CONSTRAINT fk_estado_detalle_estado1 FOREIGN KEY (pk_idestado) REFERENCES estado(pk_idestado);


--
-- TOC entry 2251 (class 2606 OID 18935)
-- Name: estado_detalle fk_estado_detalle_personal1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY estado_detalle
    ADD CONSTRAINT fk_estado_detalle_personal1 FOREIGN KEY (pk_idpersonal) REFERENCES personal(pk_idpersonal);


--
-- TOC entry 2249 (class 2606 OID 18995)
-- Name: estado_detalle fk_estado_detalle_procedimientos1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY estado_detalle
    ADD CONSTRAINT fk_estado_detalle_procedimientos1 FOREIGN KEY (pk_iddianostico_parte, pk_idpaso, pk_idtipo_procedimiento) REFERENCES procedimientos(pk_iddianostico_parte, pk_idpaso, pk_idtipo_procedimiento);


--
-- TOC entry 2235 (class 2606 OID 18940)
-- Name: historialtrabajo fk_historialtrabajo_rol1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY historialtrabajo
    ADD CONSTRAINT fk_historialtrabajo_rol1 FOREIGN KEY (fk_idtrabajo) REFERENCES rol(pk_idtrabajo);


--
-- TOC entry 2253 (class 2606 OID 18900)
-- Name: mantenimiento_detalle fk_mantenimiento_detalle_equipo1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY mantenimiento_detalle
    ADD CONSTRAINT fk_mantenimiento_detalle_equipo1 FOREIGN KEY (fk_idnoserie) REFERENCES equipo(pk_idnoserie);


--
-- TOC entry 2237 (class 2606 OID 18905)
-- Name: ordentrabajo fk_ordentrabajo_equipo1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY ordentrabajo
    ADD CONSTRAINT fk_ordentrabajo_equipo1 FOREIGN KEY (fk_idnoserie) REFERENCES equipo(pk_idnoserie);


--
-- TOC entry 2240 (class 2606 OID 18955)
-- Name: ordentrabajo fk_ordentrabajo_origensolicitud1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY ordentrabajo
    ADD CONSTRAINT fk_ordentrabajo_origensolicitud1 FOREIGN KEY (fk_idorigensolicitud) REFERENCES solicitud(pk_idsolicitud);


--
-- TOC entry 2238 (class 2606 OID 18945)
-- Name: ordentrabajo fk_ordentrabajo_prioridad; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY ordentrabajo
    ADD CONSTRAINT fk_ordentrabajo_prioridad FOREIGN KEY (fk_idprioridad) REFERENCES prioridad(pk_idprioridad);


--
-- TOC entry 2241 (class 2606 OID 18965)
-- Name: ordentrabajo fk_ordentrabajo_tipomantenimiento1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY ordentrabajo
    ADD CONSTRAINT fk_ordentrabajo_tipomantenimiento1 FOREIGN KEY (fk_idtipomantenimiento) REFERENCES tipomantenimiento(pk_idtipomantenimiento);


--
-- TOC entry 2239 (class 2606 OID 18950)
-- Name: ordentrabajo fk_ordentrabajo_unidad1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY ordentrabajo
    ADD CONSTRAINT fk_ordentrabajo_unidad1 FOREIGN KEY (fk_idunidad) REFERENCES unidad(pk_idunidad);


--
-- TOC entry 2246 (class 2606 OID 18990)
-- Name: procedimientos fk_procedimientos_dianostico_parte1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY procedimientos
    ADD CONSTRAINT fk_procedimientos_dianostico_parte1 FOREIGN KEY (pk_iddianostico_parte) REFERENCES dianostico_parte(pk_iddianostico_parte);


--
-- TOC entry 2248 (class 2606 OID 18915)
-- Name: procedimientos fk_procedimientos_pasos1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY procedimientos
    ADD CONSTRAINT fk_procedimientos_pasos1 FOREIGN KEY (pk_idpaso) REFERENCES pasos(pk_idpaso);


--
-- TOC entry 2247 (class 2606 OID 18910)
-- Name: procedimientos fk_procedimientos_tipo_procedimiento1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY procedimientos
    ADD CONSTRAINT fk_procedimientos_tipo_procedimiento1 FOREIGN KEY (pk_idtipo_procedimiento) REFERENCES tipo_procedimiento(pk_idtipo_procedimiento);


--
-- TOC entry 2233 (class 2606 OID 18925)
-- Name: telefono fk_telefono_personal1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY telefono
    ADD CONSTRAINT fk_telefono_personal1 FOREIGN KEY (fk_idpersonal) REFERENCES personal(pk_idpersonal);


--
-- TOC entry 2236 (class 2606 OID 18960)
-- Name: tipomantenimiento fk_tipomantenimiento_sub_tipomantenimiento1; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY tipomantenimiento
    ADD CONSTRAINT fk_tipomantenimiento_sub_tipomantenimiento1 FOREIGN KEY (fk_idsub_tipomantenimiento) REFERENCES sub_tipomantenimiento(pk_idsub_tipomantenimiento);


--
-- TOC entry 2242 (class 2606 OID 18980)
-- Name: diagnostico ordentrabajo_diagnostico_fk; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY diagnostico
    ADD CONSTRAINT ordentrabajo_diagnostico_fk FOREIGN KEY (fk_idordentrabajo) REFERENCES ordentrabajo(pk_idordentrabajo);


--
-- TOC entry 2244 (class 2606 OID 18975)
-- Name: dianostico_parte ordentrabajo_dianostico_parte_fk; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY dianostico_parte
    ADD CONSTRAINT ordentrabajo_dianostico_parte_fk FOREIGN KEY (fk_idordentrabajo) REFERENCES ordentrabajo(pk_idordentrabajo);


--
-- TOC entry 2254 (class 2606 OID 18970)
-- Name: mantenimiento_detalle ordentrabajo_mantenimiento_detalle_fk; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY mantenimiento_detalle
    ADD CONSTRAINT ordentrabajo_mantenimiento_detalle_fk FOREIGN KEY (pk_idordentrabajo) REFERENCES ordentrabajo(pk_idordentrabajo);


--
-- TOC entry 2234 (class 2606 OID 18930)
-- Name: historialtrabajo personal_historialtrabajo_fk; Type: FK CONSTRAINT; Schema: public; Owner: restful
--

ALTER TABLE ONLY historialtrabajo
    ADD CONSTRAINT personal_historialtrabajo_fk FOREIGN KEY (fk_idpersonal) REFERENCES personal(pk_idpersonal);


--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-03-06 03:01:24 CST

--
-- PostgreSQL database dump complete
--

