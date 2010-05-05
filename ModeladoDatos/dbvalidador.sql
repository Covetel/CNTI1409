--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: validador; Type: COMMENT; Schema: -; Owner: admin
--

COMMENT ON DATABASE validador IS 'Base de datos del sistema de Validacion de portales del CNTI';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auditoria; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE auditoria (
    id bigint NOT NULL,
    idev bigint NOT NULL,
    idinstitucion bigint NOT NULL,
    portal character varying(100) NOT NULL,
    fechaini date NOT NULL,
    fechafin date,
    url text NOT NULL,
    fechacreacion date NOT NULL
);


ALTER TABLE public.auditoria OWNER TO admin;

--
-- Name: TABLE auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE auditoria IS 'Almacena los datos de las auditorias, aqui se registran los datos de los portales.';


--
-- Name: COLUMN auditoria.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.id IS 'Numero de identificacion unica de las auditorias';


--
-- Name: COLUMN auditoria.idev; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.idev IS 'Clave de relacion entre las entidades verificadoras y las auditorias';


--
-- Name: COLUMN auditoria.idinstitucion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.idinstitucion IS 'Clave que relaciona las instituciones con las auditorias';


--
-- Name: COLUMN auditoria.portal; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.portal IS 'Almacena el nombre del portal a auditar';


--
-- Name: COLUMN auditoria.fechaini; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fechaini IS 'Fecha de inicio de la auditoria';


--
-- Name: COLUMN auditoria.fechafin; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fechafin IS 'Fecha de finalizacion de la auditoria, si este campo contiene un dato se da la auditoria como cerrada';


--
-- Name: COLUMN auditoria.url; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.url IS 'Almacena el listado de las url a auditar en un portal';


--
-- Name: auditoria_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auditoria_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auditoria_id_seq OWNER TO admin;

--
-- Name: auditoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoria_id_seq OWNED BY auditoria.id;


--
-- Name: auditoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('auditoria_id_seq', 2, true);


--
-- Name: auditoriadetalle; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE auditoriadetalle (
    id bigint NOT NULL,
    idauditoria bigint NOT NULL,
    iddisposicion bigint NOT NULL,
    resultado boolean DEFAULT true NOT NULL,
    resdetalle text,
    comentario character varying(200),
    resolutoria character varying(200)
);


ALTER TABLE public.auditoriadetalle OWNER TO admin;

--
-- Name: TABLE auditoriadetalle; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE auditoriadetalle IS 'Almacena los detalles de una auditoria, sobre todo los resultados de las disposiciones por portal';


--
-- Name: COLUMN auditoriadetalle.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.id IS 'Numero de identificacion unica para los detalles de las auditorias';


--
-- Name: COLUMN auditoriadetalle.idauditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.idauditoria IS 'Clave que relaciona los detalles de la auditoria con sus datos maestros';


--
-- Name: COLUMN auditoriadetalle.iddisposicion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.iddisposicion IS 'Clave que relaciona los detalles de las auditorias con cada disposicion';


--
-- Name: COLUMN auditoriadetalle.resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.resultado IS 'Determina si una disposicion es valida o no';


--
-- Name: COLUMN auditoriadetalle.resdetalle; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.resdetalle IS 'Detalle del resultado de una disposicion si esta no es valida';


--
-- Name: COLUMN auditoriadetalle.comentario; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.comentario IS 'comentario del auditor por cada disposicion evaluada en algun portal';


--
-- Name: COLUMN auditoriadetalle.resolutoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.resolutoria IS 'resolutoria del auditor por cada disposicion evaluada a un portal';


--
-- Name: auditoriadetalle_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auditoriadetalle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auditoriadetalle_id_seq OWNER TO admin;

--
-- Name: auditoriadetalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoriadetalle_id_seq OWNED BY auditoriadetalle.id;


--
-- Name: auditoriadetalle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('auditoriadetalle_id_seq', 1, false);


--
-- Name: auditoriadetalle_iddisposicion_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auditoriadetalle_iddisposicion_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auditoriadetalle_iddisposicion_seq OWNER TO admin;

--
-- Name: auditoriadetalle_iddisposicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoriadetalle_iddisposicion_seq OWNED BY auditoriadetalle.iddisposicion;


--
-- Name: auditoriadetalle_iddisposicion_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('auditoriadetalle_iddisposicion_seq', 1, false);


--
-- Name: disposicion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE disposicion (
    id integer NOT NULL,
    nombre character varying(25) NOT NULL,
    descripcion character varying(100) NOT NULL,
    habilitado boolean DEFAULT true NOT NULL
);


ALTER TABLE public.disposicion OWNER TO admin;

--
-- Name: TABLE disposicion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE disposicion IS 'Contiene los datos sobre las disposiciones';


--
-- Name: COLUMN disposicion.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.id IS 'Numero de identificacion unica de la disposicion';


--
-- Name: COLUMN disposicion.nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.nombre IS 'nombre de la disposicion';


--
-- Name: COLUMN disposicion.descripcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.descripcion IS 'Descripcion de la disposicion';


--
-- Name: COLUMN disposicion.habilitado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.habilitado IS 'Campo booleano que representa si la disposicion esta habilitada o no, este campo es pensado en caracteristicas futuras de la aplicacion';


--
-- Name: disposicion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE disposicion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.disposicion_id_seq OWNER TO admin;

--
-- Name: disposicion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE disposicion_id_seq OWNED BY disposicion.id;


--
-- Name: disposicion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('disposicion_id_seq', 1, false);


--
-- Name: entidadverificadora; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE entidadverificadora (
    id integer NOT NULL,
    nombre character varying(250) NOT NULL,
    rif character varying(15),
    correo character varying(100) NOT NULL,
    telefono character varying(15) NOT NULL,
    contacto character varying(250) NOT NULL,
    direccion character varying(500),
    web character varying(250)
);


ALTER TABLE public.entidadverificadora OWNER TO admin;

--
-- Name: TABLE entidadverificadora; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE entidadverificadora IS 'Datos maestros de las Entidades Verificadoras';


--
-- Name: COLUMN entidadverificadora.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.id IS 'Numero de identificacion unico para las Entidades Verificadoras';


--
-- Name: COLUMN entidadverificadora.nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.nombre IS 'nombre o Razon Social de la Entidad Verificadora';


--
-- Name: COLUMN entidadverificadora.rif; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.rif IS 'Numero fiscal de la Entidad Verificadora';


--
-- Name: COLUMN entidadverificadora.correo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.correo IS 'correo electronico de la entidad verificadora';


--
-- Name: COLUMN entidadverificadora.telefono; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.telefono IS 'Numero de telefono de la Entidad Verificadora';


--
-- Name: COLUMN entidadverificadora.contacto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.contacto IS 'nombre de la persona contacto de la Entidad Verificadora';


--
-- Name: entidadverificadora_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE entidadverificadora_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.entidadverificadora_id_seq OWNER TO admin;

--
-- Name: entidadverificadora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE entidadverificadora_id_seq OWNED BY entidadverificadora.id;


--
-- Name: entidadverificadora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('entidadverificadora_id_seq', 5, true);


--
-- Name: institucion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE institucion (
    id integer NOT NULL,
    nombre character varying(250) NOT NULL,
    rif character varying(15),
    correo character varying(100),
    telefono character varying(15) NOT NULL,
    contacto character varying(250),
    direccion character varying(500),
    web character varying(250)
);


ALTER TABLE public.institucion OWNER TO admin;

--
-- Name: TABLE institucion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE institucion IS 'Contiene los datos maestros de las instituciones';


--
-- Name: COLUMN institucion.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.id IS 'Numero de identificacion unica para las instituciones';


--
-- Name: COLUMN institucion.nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.nombre IS 'nombre o Razon Social de la Insitucion';


--
-- Name: COLUMN institucion.rif; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.rif IS 'Numero Fiscal de la institucion';


--
-- Name: COLUMN institucion.correo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.correo IS 'correo Electronico de la institucion';


--
-- Name: COLUMN institucion.telefono; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.telefono IS 'Numero de telefono de la institucion';


--
-- Name: COLUMN institucion.contacto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.contacto IS 'nombre de la persona contacto en la institucion';


--
-- Name: institucion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE institucion_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.institucion_id_seq OWNER TO admin;

--
-- Name: institucion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE institucion_id_seq OWNED BY institucion.id;


--
-- Name: institucion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('institucion_id_seq', 7, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoria ALTER COLUMN id SET DEFAULT nextval('auditoria_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoriadetalle ALTER COLUMN id SET DEFAULT nextval('auditoriadetalle_id_seq'::regclass);


--
-- Name: iddisposicion; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoriadetalle ALTER COLUMN iddisposicion SET DEFAULT nextval('auditoriadetalle_iddisposicion_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE disposicion ALTER COLUMN id SET DEFAULT nextval('disposicion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE entidadverificadora ALTER COLUMN id SET DEFAULT nextval('entidadverificadora_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE institucion ALTER COLUMN id SET DEFAULT nextval('institucion_id_seq'::regclass);


--
-- Data for Name: auditoria; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY auditoria (id, idev, idinstitucion, portal, fechaini, fechafin, url, fechacreacion) FROM stdin;
\.


--
-- Data for Name: auditoriadetalle; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY auditoriadetalle (id, idauditoria, iddisposicion, resultado, resdetalle, comentario, resolutoria) FROM stdin;
\.


--
-- Data for Name: disposicion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY disposicion (id, nombre, descripcion, habilitado) FROM stdin;
\.


--
-- Data for Name: entidadverificadora; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY entidadverificadora (id, nombre, rif, correo, telefono, contacto, direccion, web) FROM stdin;
2	COVETEL	J-992929	info@covetel.com.ve	0412-9889285	Juan Mesa	Cordero	www.covetel.com.ve
4	Cooperativa GNU	J-12312391	gnu@cooperativa.com	0414-9999999	Richard Stallman	Internet	http://www.gnu.org
5	Network IT	j-00000000	info@networkit.com.ve	0414-000.0000	Ninguno	Caracas	http://networkit.com.ve
\.


--
-- Data for Name: institucion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY institucion (id, nombre, rif, correo, telefono, contacto, direccion, web) FROM stdin;
2	Ministerio de Finanzas	G-1234567890	info@finanzas.gob.ve	0212-222.2222	Joel Gonzales	Por allí	\N
3	Centro Nacional de Tecnologías de la Información	G-000000000	info@cnti.gob.ve	0212-222.2222	Fany Hernandez	Av. Urdaneta	http://www.cnti.gob.ve
4	CANTV	G-0987654321	info@cantv.com.ve	0212-333.3333	Juan Rodriguez	Colegio de Ingenieros	http://www.cantv.com.ve
5	Insitucion	22203	info@institucion.com	2292092	Walter	Por alli	www.notiene.com
\.


--
-- Name: idxdisp; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY disposicion
    ADD CONSTRAINT idxdisp PRIMARY KEY (id);


--
-- Name: pkAudDet; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY auditoriadetalle
    ADD CONSTRAINT "pkAudDet" PRIMARY KEY (id);


--
-- Name: pkAudit; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT "pkAudit" PRIMARY KEY (id);


--
-- Name: CONSTRAINT "pkAudit" ON auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT "pkAudit" ON auditoria IS 'Clave Primaria de las auditorias';


--
-- Name: pkev; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY entidadverificadora
    ADD CONSTRAINT pkev PRIMARY KEY (id);


--
-- Name: pkidinst; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY institucion
    ADD CONSTRAINT pkidinst PRIMARY KEY (id);


--
-- Name: fki_fkev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_fkev ON auditoria USING btree (idev);


--
-- Name: fki_fkinst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_fkinst ON auditoria USING btree (idinstitucion);


--
-- Name: idxauditfecha; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxauditfecha ON auditoria USING btree (fechafin);


--
-- Name: INDEX idxauditfecha; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX idxauditfecha IS 'Indice por fecha de auditoria';


--
-- Name: idxaudres; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxaudres ON auditoriadetalle USING btree (resultado);


--
-- Name: idxnombredisp; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxnombredisp ON disposicion USING btree (nombre);


--
-- Name: idxnomev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxnomev ON entidadverificadora USING btree (nombre);


--
-- Name: idxnominst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxnominst ON institucion USING btree (nombre);


--
-- Name: idxportal; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxportal ON auditoria USING btree (portal);


--
-- Name: idxrifev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxrifev ON entidadverificadora USING btree (rif);


--
-- Name: idxrifinst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxrifinst ON institucion USING btree (rif);


--
-- Name: fkauditoria; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoriadetalle
    ADD CONSTRAINT fkauditoria FOREIGN KEY (idauditoria) REFERENCES auditoria(id);


--
-- Name: fkdisp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoriadetalle
    ADD CONSTRAINT fkdisp FOREIGN KEY (iddisposicion) REFERENCES disposicion(id);


--
-- Name: fkev; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT fkev FOREIGN KEY (idev) REFERENCES entidadverificadora(id);


--
-- Name: CONSTRAINT fkev ON auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT fkev ON auditoria IS 'Relaciona las auditorias con las entidades verificadoras';


--
-- Name: fkinst; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT fkinst FOREIGN KEY (idinstitucion) REFERENCES institucion(id);


--
-- Name: CONSTRAINT fkinst ON auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT fkinst ON auditoria IS 'Relaciona las auditorias con las instituciones';


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

