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
    fechaini date,
    fechafin date,
    fechacreacion date NOT NULL,
    url character varying(1000)[],
    estado character(1) DEFAULT 'p'::bpchar NOT NULL,
    job integer,
    resultado boolean,
    fallidas integer,
    validas integer
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
-- Name: COLUMN auditoria.fechacreacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fechacreacion IS 'Fecha de creacion de la audioria';


--
-- Name: COLUMN auditoria.url; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.url IS 'Almacena el listado de las url a auditar en un portal';


--
-- Name: COLUMN auditoria.estado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.estado IS 'Campo que determina el estado de una auditoria, los posibles valores son: p (pendiente), a (abierto), c (cerrado)';


--
-- Name: COLUMN auditoria.resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.resultado IS 'Resultado General de la Auditoria, de tipo boolean, TRUE para auditoria sin fallas, FALSE para auditoria fallidas';


--
-- Name: COLUMN auditoria.fallidas; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fallidas IS 'Numero de disposiciones fallidas';


--
-- Name: COLUMN auditoria.validas; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.validas IS 'Numero de disposiciones sin fallas';


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

SELECT pg_catalog.setval('auditoria_id_seq', 25, true);


--
-- Name: auditoriadetalle; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE auditoriadetalle (
    id bigint NOT NULL,
    idauditoria bigint NOT NULL,
    iddisposicion bigint NOT NULL,
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
-- Name: COLUMN auditoriadetalle.resolutoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.resolutoria IS 'resolutoria del auditor por cada disposicion evaluada a un portal';


--
-- Name: auditoriadetalle_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auditoriadetalle_id_seq
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

SELECT pg_catalog.setval('auditoriadetalle_id_seq', 19, true);


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
    habilitado boolean DEFAULT true NOT NULL,
    modulo character varying(10)
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
-- Name: COLUMN disposicion.modulo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.modulo IS 'Nombre del modulo que ejecuta el Job en el sistema';


--
-- Name: disposicion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE disposicion_id_seq
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

SELECT pg_catalog.setval('disposicion_id_seq', 22, true);


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
    direccion character varying(500) DEFAULT 'N/A'::character varying,
    web character varying(250) DEFAULT 'N/A'::character varying,
    habilitado boolean DEFAULT true NOT NULL,
    registro character varying(30)
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
-- Name: COLUMN entidadverificadora.registro; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.registro IS 'Numero de registro de la entidad verificadora';


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

SELECT pg_catalog.setval('entidadverificadora_id_seq', 8, true);


--
-- Name: events; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    pid integer,
    class text,
    message text,
    data text
);


ALTER TABLE public.events OWNER TO admin;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE events_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO admin;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('events_id_seq', 2295, true);


--
-- Name: institucion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE institucion (
    id integer NOT NULL,
    nombre character varying(250) NOT NULL,
    rif character varying(15) DEFAULT 'N/A'::character varying,
    correo character varying(100) DEFAULT 'N/A'::character varying,
    telefono character varying(15) NOT NULL,
    contacto character varying(250) DEFAULT 'N/A'::character varying,
    direccion character varying(500) DEFAULT 'N/A'::character varying,
    web character varying(250) DEFAULT 'N/A'::character varying,
    habilitado boolean DEFAULT true NOT NULL
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

SELECT pg_catalog.setval('institucion_id_seq', 23, true);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE jobs (
    id integer NOT NULL,
    site text,
    callback text,
    data text,
    state character varying(10),
    proc integer,
    ctime timestamp without time zone,
    mtime timestamp without time zone,
    pid integer
);


ALTER TABLE public.jobs OWNER TO admin;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE jobs_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO admin;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE jobs_id_seq OWNED BY jobs.id;


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('jobs_id_seq', 15, true);


--
-- Name: params_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE params_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.params_id_seq OWNER TO admin;

--
-- Name: params_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('params_id_seq', 5988, true);


--
-- Name: params; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE params (
    id bigint DEFAULT nextval('params_id_seq'::regclass) NOT NULL,
    disposicion character varying NOT NULL,
    parametro character varying NOT NULL
);


ALTER TABLE public.params OWNER TO admin;

--
-- Name: TABLE params; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE params IS 'Parametros de las disposiciones';


--
-- Name: results; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE results (
    id integer NOT NULL,
    pid integer,
    pass character varying(10),
    name text
);


ALTER TABLE public.results OWNER TO admin;

--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE results_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.results_id_seq OWNER TO admin;

--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE results_id_seq OWNED BY results.id;


--
-- Name: results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('results_id_seq', 1525, true);


--
-- Name: urls; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE urls (
    id integer NOT NULL,
    pid integer,
    path text,
    state character varying(10),
    proc integer,
    ctime timestamp without time zone,
    mtime timestamp without time zone
);


ALTER TABLE public.urls OWNER TO admin;

--
-- Name: urls_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE urls_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.urls_id_seq OWNER TO admin;

--
-- Name: urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE urls_id_seq OWNED BY urls.id;


--
-- Name: urls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('urls_id_seq', 257, true);


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

ALTER TABLE events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE institucion ALTER COLUMN id SET DEFAULT nextval('institucion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE jobs ALTER COLUMN id SET DEFAULT nextval('jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE results ALTER COLUMN id SET DEFAULT nextval('results_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE urls ALTER COLUMN id SET DEFAULT nextval('urls_id_seq'::regclass);


--
-- Data for Name: auditoria; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY auditoria (id, idev, idinstitucion, portal, fechaini, fechafin, fechacreacion, url, estado, job, resultado, fallidas, validas) FROM stdin;
24	2	22	VTV Portal	2010-08-23	\N	2010-08-23	{"http://www.vtv.gob.ve/contacto\n","http://www.vtv.gob.ve/contenido/19388\n","http://www.vtv.gob.ve/el-canal\n","http://www.vtv.gob.ve/\n","http://www.vtv.gob.ve/noticias-nacionales\n","http://www.vtv.gob.ve/noticias-internacionales\n","http://www.vtv.gob.ve/noticias-econ%C3%B3micas\n","http://www.vtv.gob.ve/noticias-culturales\n","http://www.vtv.gob.ve/noticias-deportivas\n","http://www.vtv.gob.ve/noticias-ciencia-y-salud\n","http://www.vtv.gob.ve/art%C3%ADculos/\n","http://www.vtv.gob.ve/videos-destacadas\n","http://www.vtv.gob.ve/files/converted_videos/42422_Resultado_del_Simulacro_Electoral_.flv\n","http://www.vtv.gob.ve/noticias-nacionales/42419\n","http://www.vtv.gob.ve/noticias-nacionales/42424\n","http://www.vtv.gob.ve/noticias-nacionales/42430\n","http://www.vtv.gob.ve/noticias-internacionales/42440\n","http://www.vtv.gob.ve/noticias-nacionales/42377\n","http://www.vtv.gob.ve/noticias-nacionales/42432\n","http://www.vtv.gob.ve/noticias-nacionales/42415\n","http://www.vtv.gob.ve/noticias-deportivas/42433\n","http://www.vtv.gob.ve/noticias-internacionales/42409\n","http://www.vtv.gob.ve/noticias-nacionales/42405\n","http://www.vtv.gob.ve/art%C3%ADculos/opini%C3%B3n/42385\n","http://www.vtv.gob.ve/art%C3%ADculos/opini%C3%B3n/42317\n","http://www.vtv.gob.ve/art%C3%ADculos\n","http://www.vtv.gob.ve/videos-especiales-vtv/42380\n","http://www.vtv.gob.ve/noticias-nacionales/42439\n","http://www.vtv.gob.ve/noticias-nacionales/42437\n","http://www.vtv.gob.ve/noticias-nacionales/42431\n","http://www.vtv.gob.ve/noticias-nacionales/42428\n","http://www.vtv.gob.ve/noticias-econ%C3%B3micas/42326\n","http://www.vtv.gob.ve/noticias-econ%C3%B3micas/42316\n","http://www.vtv.gob.ve/noticias-econ%C3%B3micas/42318\n","http://www.vtv.gob.ve/noticias-econ%C3%B3micas/42312\n","http://www.vtv.gob.ve/noticias-culturales/42362\n","http://www.vtv.gob.ve/noticias-culturales/42283\n","http://www.vtv.gob.ve/noticias-culturales/42272\n","http://www.vtv.gob.ve/noticias-culturales/42255\n","http://www.vtv.gob.ve/noticias-internacionales/42438\n","http://www.vtv.gob.ve/noticias-internacionales/42429\n","http://www.vtv.gob.ve/noticias-internacionales/42427\n","http://www.vtv.gob.ve/noticias-internacionales/42425\n","http://www.vtv.gob.ve/noticias-deportivas/42408\n","http://www.vtv.gob.ve/noticias-deportivas/42401\n","http://www.vtv.gob.ve/noticias-deportivas/42384\n","http://www.vtv.gob.ve/noticias-deportivas/42378\n","http://www.vtv.gob.ve/noticias-ciencia-y-salud/42387\n","http://www.vtv.gob.ve/noticias-ciencia-y-salud/42367\n","http://www.vtv.gob.ve/noticias-ciencia-y-salud/42345\n","http://www.vtv.gob.ve/noticias-ciencia-y-salud/42344\n","http://www.vtv.gob.ve/noticias-nacionales/41814\n","http://www.vtv.gob.ve/noticias-nacionales/40327\n","http://www.vtv.gob.ve/noticias-nacionales/41717\n","http://www.vtv.gob.ve/noticias-nacionales/40351\n","http://www.vtv.gob.ve/noticias-nacionales/41884\n","http://www.vtv.gob.ve/noticias-internacionales/41369\n","http://www.vtv.gob.ve/noticias-internacionales/41575\n","http://www.vtv.gob.ve/noticias-nacionales/41831\n","http://www.vtv.gob.ve/noticias-nacionales/40935\n","http://www.vtv.gob.ve/noticias-nacionales/41084\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/41834\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/40718\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/40725\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/41228\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/41215\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/40636\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/40475\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/40813\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/41595\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/41990\n","http://www.vtv.gob.ve/videos-destacadas-en-video/42434\n","http://www.vtv.gob.ve/actualidad/Manuelita-S%C3%A1enz-vuelve-con-Bol%C3%ADvar\n","http://www.vtv.gob.ve/actualidad/las-l%C3%ADneas-de-ch%C3%A1vez\n","http://www.vtv.gob.ve/actualidad/Mundial-de-Beisbol-Femenino-2010\n","http://www.vtv.gob.ve/actualidad/documentales\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/42436\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/42392\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/42349\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/42336\n","http://www.vtv.gob.ve/videos-emisiones-anteriores/42303\n","http://www.vtv.gob.ve/videos-emisiones\n","http://www.vtv.gob.ve/actualidad/dossier\n","http://www.vtv.gob.ve/programas-videos/dossier\n","http://www.vtv.gob.ve/actualidad/la-hojilla\n","http://www.vtv.gob.ve/actualidad/bicentenario\n","http://www.vtv.gob.ve/actualidad/sud%C3%A1frica-2010\n","http://www.vtv.gob.ve/programas-videos/la-hojilla\n","http://www.vtv.gob.ve/actualidad/enmienda-constitucional\n","http://www.vtv.gob.ve/actualidad/pacto-de-puerto-rico\n","http://www.vtv.gob.ve/actualidad/informe-semanal\n","http://www.vtv.gob.ve/contenido/116\n"}	a	14	\N	\N	\N
23	2	21	Portal de la Presidencia	2010-08-22	2010-08-22	2010-08-22	{"http://www.presidencia.gob.ve/\n","http://www.presidencia.gob.ve/action/noticia/filteror\n","http://www.presidencia.gob.ve/contacto.html\n","http://www.presidencia.gob.ve/index_enviar_caso.htm\n","http://www.presidencia.gob.ve/efemerides.html\n","http://www.presidencia.gob.ve/personaje_del_mes.html\n","http://www.presidencia.gob.ve/memoria_revolucionaria.html\n","http://www.presidencia.gob.ve/logros_g_b.html\n","http://www.presidencia.gob.ve/comision_contrataciones.html\n"}	c	13	f	7	5
25	2	23	Asamblea Web	2010-08-23	2010-08-23	2010-08-23	{"http://www.antv.gob.ve/m8/portal.asp\n","http://www.antv.gob.ve/m8/contenido.asp?id=1\n","http://www.antv.gob.ve/m8/programa.asp?id=2\n"}	c	15	f	6	7
\.


--
-- Data for Name: auditoriadetalle; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY auditoriadetalle (id, idauditoria, iddisposicion, resolutoria) FROM stdin;
11	23	18	Se deben quitar todos los archivos Flash del portal
12	23	15	Acomodar la declaración de HTML de esta página
13	23	13	Colocar todos los javascripts en archivos externos
14	23	12	actualizar los scripts
15	23	11	Todas las imagenes deben tener atributo ALT
16	23	9	Se deben cambiar el formato de las imagenes
17	23	4	Problema UTF8
18	25	4	pasar a utf8
19	24	18	aaa
\.


--
-- Data for Name: disposicion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY disposicion (id, nombre, descripcion, habilitado, modulo) FROM stdin;
1	Dominio	El dominio del portal debe terminar en .gob.ve	t	Domain
3	Etiqueta Title	Verificar el uso de la meta etiqueta title	t	Title
4	UTF8	La codificación del portal debe estar en UTF8	t	UTF8
9	Imagenes PNG	Las imagenes del portal deben estar en formato png	t	Img
11	Atributo alt	Se debe hacer uso del atributo alt para las imagenes	t	Alt
12	Uso de Javascript	Los portales deben usar el lenguaje de script Javascript	t	JS
13	Archivos js	Existencia de archivos .js	t	JS_inc
15	HTML 4.01/XHTML 1.0	Verificar el uso de HTML 4.01 o XHTML 1.0	t	HTML4
18	Controles Añadibles	Existencia de controles añadibles de tipo ActiveX	t	Plugins
22	Fuentes Libres	Verificar el uso de Fuentes Libres	t	Fonts
\.


--
-- Data for Name: entidadverificadora; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY entidadverificadora (id, nombre, rif, correo, telefono, contacto, direccion, web, habilitado, registro) FROM stdin;
2	COVETEL	J-992929	info@covetel.com.ve	0412-9889285	Juan Mesa	Cordero	www.covetel.com.ve	t	0001
4	Cooperativa GNU	J-12312391	gnu@cooperativa.com	0414-9999999	Richard Stallman	Internet	http://www.gnu.org	t	0002
5	Network IT	j-00000000	info@networkit.com.ve	0414-000.0000	Ninguno	Distrito Federal	http://networkit.com.ve	f	0003
6	El Pollo Loco	J-432149595	pollo@enbrasa.com	0416-5555555	El Gallo Claudio	La granja	http://pollitodice.org	t	0004
7	B-52	J-12319181	b52@algo.com	555-555.5555	Alguien por alli	En la lata	http://www.google.com	t	0005
8	Tucupita Technology	J-44921193	info@tucupita.net.ve	(0416) 888-8888	El pana de Tucupita	Tucupita, calle principal	http://www.tucupita.net.ve	t	0006
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY events (id, pid, class, message, data) FROM stdin;
1000	1212	warnings	No HTTP Charset	\N
1001	1212	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1002	1213	error	Tipo de imagen ilegal image/gif	\N
1003	1214	error	Hay 72 imagenes sin atributo ALT	\N
1004	1215	warning	Atributo obsoleto 'language'	\N
1005	1215	warning	Atributo obsoleto 'language'	\N
1006	1215	warning	Atributo obsoleto 'language'	\N
1007	1215	error	Lenguaje ilegal: JavaScript1.2	\N
1008	1215	warning	Atributo obsoleto 'language'	\N
1009	1216	error	Script en línea	\N
1010	1216	error	Script en línea	\N
1011	1218	error	Hay 2 controles ActiveX	\N
1012	1221	warnings	No HTTP Charset	\N
1013	1221	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1014	1222	error	Tipo de imagen ilegal image/gif	\N
1015	1223	error	Hay 72 imagenes sin atributo ALT	\N
1016	1224	warning	Atributo obsoleto 'language'	\N
1017	1224	warning	Atributo obsoleto 'language'	\N
1018	1224	warning	Atributo obsoleto 'language'	\N
1019	1224	error	Lenguaje ilegal: JavaScript1.2	\N
1020	1224	warning	Atributo obsoleto 'language'	\N
1021	1225	error	Script en línea	\N
1022	1225	error	Script en línea	\N
1023	1227	error	Hay 2 controles ActiveX	\N
1024	1230	warnings	No HTTP Charset	\N
1025	1230	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1026	1231	error	Tipo de imagen ilegal image/gif	\N
1027	1231	error	Tipo de imagen ilegal image/gif	\N
1028	1231	error	Tipo de imagen ilegal image/gif	\N
1029	1231	error	Tipo de imagen ilegal image/gif	\N
1030	1231	error	Tipo de imagen ilegal image/gif	\N
1031	1231	error	Tipo de imagen ilegal image/gif	\N
1032	1231	error	Tipo de imagen ilegal image/gif	\N
1033	1231	error	Tipo de imagen ilegal image/gif	\N
1034	1231	error	Tipo de imagen ilegal image/gif	\N
1035	1231	error	Tipo de imagen ilegal image/gif	\N
1036	1231	error	Tipo de imagen ilegal image/gif	\N
1037	1231	error	Tipo de imagen ilegal image/gif	\N
1038	1231	error	Tipo de imagen ilegal image/gif	\N
1039	1231	error	Tipo de imagen ilegal image/gif	\N
1040	1231	error	Tipo de imagen ilegal image/gif	\N
1041	1231	error	Tipo de imagen ilegal image/gif	\N
1042	1231	error	Tipo de imagen ilegal image/gif	\N
1043	1231	error	Tipo de imagen ilegal image/gif	\N
1044	1231	error	Tipo de imagen ilegal image/gif	\N
1045	1231	error	Tipo de imagen ilegal text/html	\N
1046	1231	error	Tipo de imagen ilegal image/jpeg	\N
1047	1231	error	Tipo de imagen ilegal image/gif	\N
1048	1231	error	Tipo de imagen ilegal image/gif	\N
1049	1231	error	Tipo de imagen ilegal image/gif	\N
1050	1231	error	Tipo de imagen ilegal image/gif	\N
1051	1231	error	Tipo de imagen ilegal image/gif	\N
1052	1231	error	Tipo de imagen ilegal text/html	\N
1053	1231	error	Tipo de imagen ilegal image/gif	\N
1054	1231	error	Tipo de imagen ilegal image/gif	\N
1055	1231	error	Tipo de imagen ilegal image/gif	\N
1056	1232	error	Hay 27 imagenes sin atributo ALT	\N
1057	1233	warning	Atributo obsoleto 'language'	\N
1058	1233	warning	Atributo obsoleto 'language'	\N
1059	1233	warning	Atributo obsoleto 'language'	\N
1060	1233	error	Lenguaje ilegal: JavaScript1.2	\N
1061	1234	error	El archivo externo no tiene extension .js	\N
1062	1234	error	Script en línea	\N
1063	1234	error	Script en línea	\N
1064	1236	error	Hay 1 controles ActiveX	\N
1065	1239	warnings	No HTTP Charset	\N
1066	1239	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1067	1240	error	Tipo de imagen ilegal image/gif	\N
1068	1240	error	Tipo de imagen ilegal image/gif	\N
1069	1240	error	Tipo de imagen ilegal image/gif	\N
1070	1240	error	Tipo de imagen ilegal image/gif	\N
1071	1240	error	Tipo de imagen ilegal image/jpeg	\N
1072	1240	error	Tipo de imagen ilegal image/gif	\N
1073	1240	error	Tipo de imagen ilegal image/gif	\N
1074	1240	error	Tipo de imagen ilegal image/gif	\N
1075	1240	error	Tipo de imagen ilegal image/gif	\N
1076	1240	error	Tipo de imagen ilegal image/gif	\N
1077	1240	error	Tipo de imagen ilegal image/gif	\N
1078	1240	error	Tipo de imagen ilegal image/gif	\N
1079	1241	error	Hay 24 imagenes sin atributo ALT	\N
1080	1242	warning	Atributo obsoleto 'language'	\N
1081	1242	warning	Atributo obsoleto 'language'	\N
1082	1242	warning	Atributo obsoleto 'language'	\N
1083	1242	error	Lenguaje ilegal: JavaScript1.2	\N
1084	1242	warning	Atributo obsoleto 'language'	\N
1085	1243	error	Script en línea	\N
1086	1243	error	Script en línea	\N
1087	1248	warnings	No HTTP Charset	\N
1088	1248	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1089	1249	error	Tipo de imagen ilegal image/gif	\N
1090	1249	error	Tipo de imagen ilegal image/gif	\N
1091	1249	error	Tipo de imagen ilegal image/gif	\N
1092	1249	error	Tipo de imagen ilegal image/gif	\N
1093	1249	error	Tipo de imagen ilegal image/jpeg	\N
1094	1249	error	Tipo de imagen ilegal image/gif	\N
1095	1249	error	Tipo de imagen ilegal image/gif	\N
1096	1249	error	Tipo de imagen ilegal image/gif	\N
1097	1249	error	Tipo de imagen ilegal image/gif	\N
1098	1249	error	Tipo de imagen ilegal image/gif	\N
1099	1249	error	Tipo de imagen ilegal image/gif	\N
1100	1249	error	Tipo de imagen ilegal image/gif	\N
1101	1250	error	Hay 24 imagenes sin atributo ALT	\N
1102	1251	warning	Atributo obsoleto 'language'	\N
1103	1251	warning	Atributo obsoleto 'language'	\N
1104	1251	warning	Atributo obsoleto 'language'	\N
1105	1251	error	Lenguaje ilegal: JavaScript1.2	\N
1106	1251	warning	Atributo obsoleto 'language'	\N
1107	1252	error	Script en línea	\N
1108	1252	error	Script en línea	\N
1109	1257	warnings	No HTTP Charset	\N
1110	1257	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1111	1258	error	Tipo de imagen ilegal image/gif	\N
1112	1258	error	Tipo de imagen ilegal image/gif	\N
1113	1258	error	Tipo de imagen ilegal image/gif	\N
1114	1258	error	Tipo de imagen ilegal image/gif	\N
1115	1258	error	Tipo de imagen ilegal image/jpeg	\N
1116	1258	error	Tipo de imagen ilegal image/gif	\N
1117	1258	error	Tipo de imagen ilegal image/gif	\N
1118	1258	error	Tipo de imagen ilegal image/gif	\N
1119	1258	error	Tipo de imagen ilegal image/gif	\N
1120	1258	error	Tipo de imagen ilegal image/gif	\N
1121	1258	error	Tipo de imagen ilegal image/gif	\N
1122	1258	error	Tipo de imagen ilegal image/gif	\N
1123	1258	error	Tipo de imagen ilegal image/gif	\N
1124	1258	error	Tipo de imagen ilegal image/gif	\N
1125	1258	error	Tipo de imagen ilegal image/gif	\N
1126	1258	error	Tipo de imagen ilegal image/gif	\N
1127	1258	error	Tipo de imagen ilegal image/gif	\N
1128	1258	error	Tipo de imagen ilegal image/gif	\N
1129	1258	error	Tipo de imagen ilegal image/gif	\N
1130	1258	error	Tipo de imagen ilegal image/gif	\N
1131	1258	error	Tipo de imagen ilegal image/gif	\N
1132	1258	error	Tipo de imagen ilegal image/gif	\N
1133	1258	error	Tipo de imagen ilegal image/gif	\N
1134	1258	error	Tipo de imagen ilegal image/gif	\N
1135	1258	error	Tipo de imagen ilegal image/gif	\N
1136	1258	error	Tipo de imagen ilegal image/gif	\N
1137	1258	error	Tipo de imagen ilegal image/gif	\N
1138	1258	error	Tipo de imagen ilegal image/gif	\N
1139	1258	error	Tipo de imagen ilegal image/gif	\N
1140	1258	error	Tipo de imagen ilegal image/gif	\N
1141	1258	error	Tipo de imagen ilegal image/gif	\N
1142	1258	error	Tipo de imagen ilegal image/gif	\N
1143	1258	error	Tipo de imagen ilegal image/gif	\N
1144	1258	error	Tipo de imagen ilegal image/gif	\N
1145	1258	error	Tipo de imagen ilegal image/gif	\N
1146	1258	error	Tipo de imagen ilegal image/gif	\N
1147	1258	error	Tipo de imagen ilegal image/gif	\N
1148	1258	error	Tipo de imagen ilegal image/gif	\N
1149	1258	error	Tipo de imagen ilegal image/gif	\N
1150	1258	error	Tipo de imagen ilegal image/jpeg	\N
1151	1258	error	Tipo de imagen ilegal image/gif	\N
1152	1258	error	Tipo de imagen ilegal image/gif	\N
1153	1258	error	Tipo de imagen ilegal image/gif	\N
1154	1258	error	Tipo de imagen ilegal image/gif	\N
1155	1258	error	Tipo de imagen ilegal image/gif	\N
1156	1258	error	Tipo de imagen ilegal image/gif	\N
1157	1258	error	Tipo de imagen ilegal image/gif	\N
1158	1258	error	Tipo de imagen ilegal image/gif	\N
1159	1258	error	Tipo de imagen ilegal image/gif	\N
1160	1258	error	Tipo de imagen ilegal image/gif	\N
1161	1258	error	Tipo de imagen ilegal image/gif	\N
1162	1258	error	Tipo de imagen ilegal image/gif	\N
1163	1258	error	Tipo de imagen ilegal image/gif	\N
1164	1258	error	Tipo de imagen ilegal image/gif	\N
1165	1258	error	Tipo de imagen ilegal image/gif	\N
1166	1258	error	Tipo de imagen ilegal image/gif	\N
1167	1258	error	Tipo de imagen ilegal image/gif	\N
1168	1258	error	Tipo de imagen ilegal image/gif	\N
1169	1258	error	Tipo de imagen ilegal image/gif	\N
1170	1258	error	Tipo de imagen ilegal image/gif	\N
1171	1258	error	Tipo de imagen ilegal image/gif	\N
1172	1258	error	Tipo de imagen ilegal image/gif	\N
1173	1258	error	Tipo de imagen ilegal image/gif	\N
1174	1258	error	Tipo de imagen ilegal image/gif	\N
1175	1258	error	Tipo de imagen ilegal image/gif	\N
1176	1258	error	Tipo de imagen ilegal image/gif	\N
1177	1258	error	Tipo de imagen ilegal image/gif	\N
1178	1258	error	Tipo de imagen ilegal image/gif	\N
1179	1258	error	Tipo de imagen ilegal image/gif	\N
1180	1258	error	Tipo de imagen ilegal image/gif	\N
1181	1259	error	Hay 82 imagenes sin atributo ALT	\N
1182	1260	warning	Atributo obsoleto 'language'	\N
1183	1260	warning	Atributo obsoleto 'language'	\N
1184	1260	warning	Atributo obsoleto 'language'	\N
1185	1260	error	Lenguaje ilegal: JavaScript1.2	\N
1186	1260	warning	Atributo obsoleto 'language'	\N
1187	1261	error	Script en línea	\N
1188	1261	error	Script en línea	\N
1189	1266	warnings	No HTTP Charset	\N
1190	1266	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1191	1268	error	Hay 12 imagenes sin atributo ALT	\N
1192	1269	warning	Atributo obsoleto 'language'	\N
1193	1269	warning	Atributo obsoleto 'language'	\N
1194	1269	warning	Atributo obsoleto 'language'	\N
1195	1269	error	Lenguaje ilegal: JavaScript1.2	\N
1196	1269	warning	Atributo obsoleto 'language'	\N
1197	1270	error	Script en línea	\N
1198	1270	error	Script en línea	\N
1199	1275	warnings	No HTTP Charset	\N
1200	1275	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1201	1276	error	Tipo de imagen ilegal image/gif	\N
1202	1276	error	Tipo de imagen ilegal image/gif	\N
1203	1276	error	Tipo de imagen ilegal image/gif	\N
1204	1276	error	Tipo de imagen ilegal image/gif	\N
1205	1276	error	Tipo de imagen ilegal image/jpeg	\N
1206	1276	error	Tipo de imagen ilegal image/gif	\N
1207	1276	error	Tipo de imagen ilegal image/gif	\N
1208	1276	error	Tipo de imagen ilegal image/jpeg	\N
1209	1276	error	Tipo de imagen ilegal image/jpeg	\N
1210	1276	error	Tipo de imagen ilegal image/jpeg	\N
1211	1276	error	Tipo de imagen ilegal image/jpeg	\N
1212	1276	error	Tipo de imagen ilegal image/gif	\N
1213	1276	error	Tipo de imagen ilegal image/gif	\N
1214	1276	error	Tipo de imagen ilegal image/gif	\N
1215	1276	error	Tipo de imagen ilegal image/gif	\N
1216	1276	error	Tipo de imagen ilegal image/gif	\N
1217	1276	error	Tipo de imagen ilegal image/jpeg	\N
1218	1276	error	Tipo de imagen ilegal image/jpeg	\N
1219	1276	error	Tipo de imagen ilegal image/jpeg	\N
1220	1276	error	Tipo de imagen ilegal image/jpeg	\N
1221	1276	error	Tipo de imagen ilegal image/gif	\N
1222	1276	error	Tipo de imagen ilegal image/gif	\N
1223	1276	error	Tipo de imagen ilegal image/gif	\N
1224	1276	error	Tipo de imagen ilegal image/gif	\N
1225	1276	error	Tipo de imagen ilegal image/gif	\N
1226	1276	error	Tipo de imagen ilegal image/jpeg	\N
1227	1276	error	Tipo de imagen ilegal image/jpeg	\N
1228	1276	error	Tipo de imagen ilegal image/jpeg	\N
1229	1276	error	Tipo de imagen ilegal image/jpeg	\N
1230	1276	error	Tipo de imagen ilegal image/gif	\N
1231	1276	error	Tipo de imagen ilegal image/gif	\N
1232	1276	error	Tipo de imagen ilegal image/gif	\N
1233	1276	error	Tipo de imagen ilegal image/gif	\N
1234	1276	error	Tipo de imagen ilegal image/gif	\N
1235	1276	error	Tipo de imagen ilegal image/gif	\N
1236	1276	error	Tipo de imagen ilegal image/gif	\N
1237	1276	error	Tipo de imagen ilegal image/gif	\N
1238	1276	error	Tipo de imagen ilegal image/gif	\N
1239	1276	error	Tipo de imagen ilegal image/gif	\N
1240	1277	error	Hay 51 imagenes sin atributo ALT	\N
1241	1278	warning	Atributo obsoleto 'language'	\N
1242	1278	warning	Atributo obsoleto 'language'	\N
1243	1278	warning	Atributo obsoleto 'language'	\N
1244	1278	error	Lenguaje ilegal: JavaScript1.2	\N
1245	1278	warning	Atributo obsoleto 'language'	\N
1246	1279	error	Script en línea	\N
1247	1279	error	Script en línea	\N
1248	1284	warnings	No HTTP Charset	\N
1249	1284	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1250	1285	error	Tipo de imagen ilegal image/gif	\N
1251	1285	error	Tipo de imagen ilegal image/gif	\N
1252	1285	error	Tipo de imagen ilegal image/gif	\N
1253	1285	error	Tipo de imagen ilegal image/gif	\N
1254	1285	error	Tipo de imagen ilegal image/jpeg	\N
1255	1285	error	Tipo de imagen ilegal image/gif	\N
1256	1285	error	Tipo de imagen ilegal image/gif	\N
1257	1285	error	Tipo de imagen ilegal image/gif	\N
1258	1285	error	Tipo de imagen ilegal image/gif	\N
1259	1285	error	Tipo de imagen ilegal image/gif	\N
1260	1285	error	Tipo de imagen ilegal image/gif	\N
1261	1285	error	Tipo de imagen ilegal image/gif	\N
1262	1285	error	Tipo de imagen ilegal image/gif	\N
1263	1285	error	Tipo de imagen ilegal image/gif	\N
1264	1285	error	Tipo de imagen ilegal image/gif	\N
1265	1285	error	Tipo de imagen ilegal image/gif	\N
1266	1285	error	Tipo de imagen ilegal image/gif	\N
1267	1285	error	Tipo de imagen ilegal image/gif	\N
1268	1285	error	Tipo de imagen ilegal image/gif	\N
1269	1285	error	Tipo de imagen ilegal image/gif	\N
1270	1285	error	Tipo de imagen ilegal image/gif	\N
1271	1285	error	Tipo de imagen ilegal image/gif	\N
1272	1285	error	Tipo de imagen ilegal image/gif	\N
1273	1285	error	Tipo de imagen ilegal image/gif	\N
1274	1285	error	Tipo de imagen ilegal image/gif	\N
1275	1285	error	Tipo de imagen ilegal image/gif	\N
1276	1285	error	Tipo de imagen ilegal image/gif	\N
1277	1285	error	Tipo de imagen ilegal image/gif	\N
1278	1285	error	Tipo de imagen ilegal image/gif	\N
1279	1285	error	Tipo de imagen ilegal image/gif	\N
1280	1285	error	Tipo de imagen ilegal image/gif	\N
1281	1285	error	Tipo de imagen ilegal image/gif	\N
1282	1285	error	Tipo de imagen ilegal image/gif	\N
1283	1285	error	Tipo de imagen ilegal image/gif	\N
1284	1285	error	Tipo de imagen ilegal image/gif	\N
1285	1285	error	Tipo de imagen ilegal image/gif	\N
1286	1285	error	Tipo de imagen ilegal image/gif	\N
1287	1285	error	Tipo de imagen ilegal image/gif	\N
1288	1285	error	Tipo de imagen ilegal image/gif	\N
1289	1285	error	Tipo de imagen ilegal image/gif	\N
1290	1285	error	Tipo de imagen ilegal image/gif	\N
1291	1285	error	Tipo de imagen ilegal image/gif	\N
1292	1285	error	Tipo de imagen ilegal image/gif	\N
1293	1285	error	Tipo de imagen ilegal image/gif	\N
1294	1285	error	Tipo de imagen ilegal image/gif	\N
1295	1285	error	Tipo de imagen ilegal image/gif	\N
1296	1285	error	Tipo de imagen ilegal image/gif	\N
1297	1285	error	Tipo de imagen ilegal image/gif	\N
1298	1286	error	Hay 60 imagenes sin atributo ALT	\N
1299	1287	warning	Atributo obsoleto 'language'	\N
1300	1287	warning	Atributo obsoleto 'language'	\N
1301	1287	warning	Atributo obsoleto 'language'	\N
1302	1287	error	Lenguaje ilegal: JavaScript1.2	\N
1303	1287	warning	Atributo obsoleto 'language'	\N
1304	1288	error	Script en línea	\N
1305	1288	error	Script en línea	\N
1306	1293	warnings	No HTTP Charset	\N
1307	1293	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
1308	1294	error	Tipo de imagen ilegal image/gif	\N
1309	1294	error	Tipo de imagen ilegal image/gif	\N
1310	1294	error	Tipo de imagen ilegal image/gif	\N
1311	1294	error	Tipo de imagen ilegal image/gif	\N
1312	1294	error	Tipo de imagen ilegal image/jpeg	\N
1313	1294	error	Tipo de imagen ilegal image/gif	\N
1314	1294	error	Tipo de imagen ilegal image/gif	\N
1315	1294	error	Tipo de imagen ilegal image/jpeg	\N
1316	1294	error	Tipo de imagen ilegal image/gif	\N
1317	1294	error	Tipo de imagen ilegal image/gif	\N
1318	1294	error	Tipo de imagen ilegal image/gif	\N
1319	1294	error	Tipo de imagen ilegal image/gif	\N
1320	1294	error	Tipo de imagen ilegal image/gif	\N
1321	1295	error	Hay 25 imagenes sin atributo ALT	\N
1322	1296	warning	Atributo obsoleto 'language'	\N
1323	1296	warning	Atributo obsoleto 'language'	\N
1324	1296	warning	Atributo obsoleto 'language'	\N
1325	1296	error	Lenguaje ilegal: JavaScript1.2	\N
1326	1296	warning	Atributo obsoleto 'language'	\N
1327	1297	error	Script en línea	\N
1328	1297	error	Script en línea	\N
1329	1302	error	utf8 "\\xF1" does not map to Unicode at /usr/lib/perl/5.10/Encode.pm line 162.\n	\N
1330	1303	error	Tipo de imagen ilegal image/jpeg	\N
1331	1303	error	Tipo de imagen ilegal image/gif	\N
1332	1303	error	Tipo de imagen ilegal image/jpeg	\N
1333	1303	error	Tipo de imagen ilegal image/gif	\N
1334	1303	error	Tipo de imagen ilegal image/gif	\N
1335	1303	error	Tipo de imagen ilegal image/gif	\N
1336	1303	error	Tipo de imagen ilegal image/jpeg	\N
1337	1303	error	Tipo de imagen ilegal image/gif	\N
1338	1303	error	Tipo de imagen ilegal image/jpeg	\N
1339	1303	error	Tipo de imagen ilegal image/gif	\N
1340	1303	error	Tipo de imagen ilegal image/gif	\N
1341	1303	error	Tipo de imagen ilegal image/jpeg	\N
1342	1303	error	Tipo de imagen ilegal image/gif	\N
1343	1303	error	Tipo de imagen ilegal image/gif	\N
1344	1303	error	Tipo de imagen ilegal image/jpeg	\N
1345	1303	error	Tipo de imagen ilegal image/gif	\N
1346	1303	error	Tipo de imagen ilegal image/gif	\N
1347	1303	error	Tipo de imagen ilegal image/gif	\N
1348	1303	error	Tipo de imagen ilegal image/gif	\N
1349	1303	error	Tipo de imagen ilegal image/gif	\N
1350	1303	error	Tipo de imagen ilegal image/gif	\N
1351	1303	error	Tipo de imagen ilegal image/gif	\N
1352	1303	error	Tipo de imagen ilegal image/jpeg	\N
1353	1303	error	Tipo de imagen ilegal image/jpeg	\N
1354	1303	error	Tipo de imagen ilegal image/gif	\N
1355	1303	error	Tipo de imagen ilegal image/gif	\N
1356	1303	error	Tipo de imagen ilegal image/gif	\N
1357	1303	error	Tipo de imagen ilegal image/gif	\N
1358	1303	error	Tipo de imagen ilegal image/gif	\N
1359	1303	error	Tipo de imagen ilegal image/gif	\N
1360	1303	error	Tipo de imagen ilegal image/gif	\N
1361	1303	error	Tipo de imagen ilegal image/gif	\N
1362	1303	error	Tipo de imagen ilegal image/gif	\N
1363	1303	error	Tipo de imagen ilegal image/gif	\N
1364	1303	error	Tipo de imagen ilegal image/gif	\N
1365	1303	error	Tipo de imagen ilegal image/gif	\N
1366	1303	error	Tipo de imagen ilegal image/gif	\N
1367	1303	error	Tipo de imagen ilegal image/gif	\N
1368	1303	error	Tipo de imagen ilegal image/gif	\N
1369	1303	error	Tipo de imagen ilegal image/gif	\N
1370	1303	error	Tipo de imagen ilegal image/gif	\N
1371	1303	error	Tipo de imagen ilegal image/gif	\N
1372	1303	error	Tipo de imagen ilegal image/gif	\N
1373	1303	error	Tipo de imagen ilegal image/jpeg	\N
1374	1303	error	Tipo de imagen ilegal image/jpeg	\N
1375	1303	error	Tipo de imagen ilegal image/jpeg	\N
1376	1303	error	Tipo de imagen ilegal image/jpeg	\N
1377	1303	error	Tipo de imagen ilegal image/jpeg	\N
1378	1303	error	Tipo de imagen ilegal image/jpeg	\N
1379	1303	error	Tipo de imagen ilegal image/jpeg	\N
1380	1303	error	Tipo de imagen ilegal image/jpeg	\N
1381	1303	error	Tipo de imagen ilegal image/jpeg	\N
1382	1303	error	Tipo de imagen ilegal image/jpeg	\N
1383	1303	error	Tipo de imagen ilegal image/gif	\N
1384	1303	error	Tipo de imagen ilegal image/gif	\N
1385	1303	error	Tipo de imagen ilegal image/gif	\N
1386	1303	error	Tipo de imagen ilegal image/gif	\N
1387	1303	error	Tipo de imagen ilegal image/gif	\N
1388	1303	error	Tipo de imagen ilegal image/jpeg	\N
1389	1304	error	Hay 41 imagenes sin atributo ALT	\N
1390	1304	warning	Hay 8 imagenes con atributo ALT vacío	\N
1391	1306	error	Script en línea	\N
1392	1306	error	Script en línea	\N
1393	1306	error	Script en línea	\N
1394	1306	error	Script en línea	\N
1395	1306	error	Script en línea	\N
1396	1306	error	Script en línea	\N
1397	1306	error	Script en línea	\N
1398	1306	error	Script en línea	\N
1399	1306	error	Script en línea	\N
1400	1306	error	Script en línea	\N
1401	1306	error	Script en línea	\N
1402	1306	error	Script en línea	\N
1403	1306	error	Script en línea	\N
1404	1306	error	Script en línea	\N
1405	1308	error	Hay 2 controles Flash declarados con HTML5	\N
1406	1311	error	utf8 "\\xF1" does not map to Unicode at /usr/lib/perl/5.10/Encode.pm line 162.\n	\N
1407	1312	error	Tipo de imagen ilegal image/jpeg	\N
1408	1312	error	Tipo de imagen ilegal image/gif	\N
1409	1312	error	Tipo de imagen ilegal image/jpeg	\N
1410	1312	error	Tipo de imagen ilegal image/gif	\N
1411	1312	error	Tipo de imagen ilegal image/gif	\N
1412	1312	error	Tipo de imagen ilegal image/gif	\N
1413	1312	error	Tipo de imagen ilegal image/jpeg	\N
1414	1312	error	Tipo de imagen ilegal image/gif	\N
1415	1312	error	Tipo de imagen ilegal image/jpeg	\N
1416	1312	error	Tipo de imagen ilegal image/gif	\N
1417	1312	error	Tipo de imagen ilegal image/gif	\N
1418	1312	error	Tipo de imagen ilegal image/jpeg	\N
1419	1312	error	Tipo de imagen ilegal image/gif	\N
1420	1312	error	Tipo de imagen ilegal image/gif	\N
1421	1312	error	Tipo de imagen ilegal image/jpeg	\N
1422	1312	error	Tipo de imagen ilegal image/gif	\N
1423	1312	error	Tipo de imagen ilegal image/gif	\N
1424	1312	error	Tipo de imagen ilegal image/gif	\N
1425	1312	error	Tipo de imagen ilegal image/gif	\N
1426	1312	error	Tipo de imagen ilegal image/gif	\N
1427	1312	error	Tipo de imagen ilegal image/gif	\N
1428	1312	error	Tipo de imagen ilegal image/gif	\N
1429	1312	error	Tipo de imagen ilegal image/jpeg	\N
1430	1312	error	Tipo de imagen ilegal image/jpeg	\N
1431	1312	error	Tipo de imagen ilegal image/gif	\N
1432	1312	error	Tipo de imagen ilegal image/gif	\N
1433	1312	error	Tipo de imagen ilegal image/gif	\N
1434	1312	error	Tipo de imagen ilegal image/gif	\N
1435	1312	error	Tipo de imagen ilegal image/gif	\N
1436	1312	error	Tipo de imagen ilegal image/gif	\N
1437	1312	error	Tipo de imagen ilegal image/gif	\N
1438	1312	error	Tipo de imagen ilegal image/gif	\N
1439	1312	error	Tipo de imagen ilegal image/gif	\N
1440	1312	error	Tipo de imagen ilegal image/gif	\N
1441	1312	error	Tipo de imagen ilegal image/gif	\N
1442	1312	error	Tipo de imagen ilegal image/gif	\N
1443	1312	error	Tipo de imagen ilegal image/gif	\N
1444	1312	error	Tipo de imagen ilegal image/gif	\N
1445	1312	error	Tipo de imagen ilegal image/gif	\N
1446	1312	error	Tipo de imagen ilegal image/gif	\N
1447	1312	error	Tipo de imagen ilegal image/gif	\N
1448	1312	error	Tipo de imagen ilegal image/gif	\N
1449	1312	error	Tipo de imagen ilegal image/gif	\N
1450	1312	error	Tipo de imagen ilegal image/jpeg	\N
1451	1312	error	Tipo de imagen ilegal image/jpeg	\N
1452	1312	error	Tipo de imagen ilegal image/jpeg	\N
1453	1312	error	Tipo de imagen ilegal image/jpeg	\N
1454	1312	error	Tipo de imagen ilegal image/jpeg	\N
1455	1312	error	Tipo de imagen ilegal image/jpeg	\N
1456	1312	error	Tipo de imagen ilegal image/jpeg	\N
1457	1312	error	Tipo de imagen ilegal image/jpeg	\N
1458	1312	error	Tipo de imagen ilegal image/jpeg	\N
1459	1312	error	Tipo de imagen ilegal image/jpeg	\N
1460	1312	error	Tipo de imagen ilegal image/gif	\N
1461	1312	error	Tipo de imagen ilegal image/gif	\N
1462	1312	error	Tipo de imagen ilegal image/gif	\N
1463	1312	error	Tipo de imagen ilegal image/gif	\N
1464	1312	error	Tipo de imagen ilegal image/gif	\N
1465	1312	error	Tipo de imagen ilegal image/jpeg	\N
1466	1313	error	Hay 41 imagenes sin atributo ALT	\N
1467	1313	warning	Hay 8 imagenes con atributo ALT vacío	\N
1468	1315	error	Script en línea	\N
1469	1315	error	Script en línea	\N
1470	1315	error	Script en línea	\N
1471	1315	error	Script en línea	\N
1472	1315	error	Script en línea	\N
1473	1315	error	Script en línea	\N
1474	1315	error	Script en línea	\N
1475	1315	error	Script en línea	\N
1476	1315	error	Script en línea	\N
1477	1315	error	Script en línea	\N
1478	1315	error	Script en línea	\N
1479	1315	error	Script en línea	\N
1480	1315	error	Script en línea	\N
1481	1315	error	Script en línea	\N
1482	1317	error	Hay 2 controles Flash declarados con HTML5	\N
1483	1320	error	utf8 "\\xF1" does not map to Unicode at /usr/lib/perl/5.10/Encode.pm line 162.\n	\N
1484	1321	error	Tipo de imagen ilegal image/jpeg	\N
1485	1321	error	Tipo de imagen ilegal image/gif	\N
1486	1321	error	Tipo de imagen ilegal image/jpeg	\N
1487	1321	error	Tipo de imagen ilegal image/gif	\N
1488	1321	error	Tipo de imagen ilegal image/gif	\N
1489	1321	error	Tipo de imagen ilegal image/jpeg	\N
1490	1321	error	Tipo de imagen ilegal image/gif	\N
1491	1321	error	Tipo de imagen ilegal image/gif	\N
1492	1321	error	Tipo de imagen ilegal image/jpeg	\N
1493	1321	error	Tipo de imagen ilegal image/gif	\N
1494	1321	error	Tipo de imagen ilegal image/gif	\N
1495	1321	error	Tipo de imagen ilegal image/jpeg	\N
1496	1321	error	Tipo de imagen ilegal image/gif	\N
1497	1321	error	Tipo de imagen ilegal image/gif	\N
1498	1321	error	Tipo de imagen ilegal image/jpeg	\N
1499	1321	error	Tipo de imagen ilegal image/gif	\N
1500	1321	error	Tipo de imagen ilegal image/gif	\N
1501	1321	error	Tipo de imagen ilegal image/jpeg	\N
1502	1321	error	Tipo de imagen ilegal image/gif	\N
1503	1321	error	Tipo de imagen ilegal image/jpeg	\N
1504	1321	error	Tipo de imagen ilegal image/gif	\N
1505	1321	error	Tipo de imagen ilegal image/jpeg	\N
1506	1321	error	Tipo de imagen ilegal image/gif	\N
1507	1321	error	Tipo de imagen ilegal image/jpeg	\N
1508	1321	error	Tipo de imagen ilegal image/gif	\N
1509	1321	error	Tipo de imagen ilegal image/jpeg	\N
1510	1321	error	Tipo de imagen ilegal image/gif	\N
1511	1321	error	Tipo de imagen ilegal image/jpeg	\N
1512	1321	error	Tipo de imagen ilegal image/gif	\N
1513	1321	error	Tipo de imagen ilegal image/gif	\N
1514	1321	error	Tipo de imagen ilegal image/gif	\N
1515	1321	error	Tipo de imagen ilegal image/gif	\N
1516	1321	error	Tipo de imagen ilegal image/gif	\N
1517	1321	error	Tipo de imagen ilegal image/gif	\N
1518	1321	error	Tipo de imagen ilegal image/gif	\N
1519	1321	error	Tipo de imagen ilegal image/gif	\N
1520	1321	error	Tipo de imagen ilegal image/gif	\N
1521	1322	error	Hay 24 imagenes sin atributo ALT	\N
1522	1322	warning	Hay 10 imagenes con atributo ALT vacío	\N
1523	1324	error	Script en línea	\N
1524	1324	error	Script en línea	\N
1525	1324	error	Script en línea	\N
1526	1324	error	Script en línea	\N
1527	1324	error	Script en línea	\N
1528	1324	error	Script en línea	\N
1529	1326	error	Hay 1 controles Flash declarados con HTML5	\N
1530	1329	error	utf8 "\\xF1" does not map to Unicode at /usr/lib/perl/5.10/Encode.pm line 162.\n	\N
1531	1330	error	Tipo de imagen ilegal image/jpeg	\N
1532	1330	error	Tipo de imagen ilegal image/gif	\N
1533	1330	error	Tipo de imagen ilegal image/jpeg	\N
1534	1330	error	Tipo de imagen ilegal image/gif	\N
1535	1330	error	Tipo de imagen ilegal image/gif	\N
1536	1330	error	Tipo de imagen ilegal image/jpeg	\N
1537	1330	error	Tipo de imagen ilegal image/gif	\N
1538	1330	error	Tipo de imagen ilegal image/jpeg	\N
1539	1330	error	Tipo de imagen ilegal image/gif	\N
1540	1330	error	Tipo de imagen ilegal image/gif	\N
1541	1330	error	Tipo de imagen ilegal image/jpeg	\N
1542	1330	error	Tipo de imagen ilegal image/gif	\N
1543	1330	error	Tipo de imagen ilegal image/jpeg	\N
1544	1330	error	Tipo de imagen ilegal image/gif	\N
1545	1330	error	Tipo de imagen ilegal image/gif	\N
1546	1330	error	Tipo de imagen ilegal image/jpeg	\N
1547	1330	error	Tipo de imagen ilegal image/gif	\N
1548	1330	error	Tipo de imagen ilegal image/jpeg	\N
1549	1330	error	Tipo de imagen ilegal image/gif	\N
1550	1330	error	Tipo de imagen ilegal image/jpeg	\N
1551	1330	error	Tipo de imagen ilegal image/gif	\N
1552	1330	error	Tipo de imagen ilegal image/gif	\N
1553	1330	error	Tipo de imagen ilegal image/gif	\N
1554	1330	error	Tipo de imagen ilegal image/gif	\N
1555	1330	error	Tipo de imagen ilegal image/jpeg	\N
1556	1330	error	Tipo de imagen ilegal image/gif	\N
1557	1330	error	Tipo de imagen ilegal image/gif	\N
1558	1330	error	Tipo de imagen ilegal image/jpeg	\N
1559	1330	error	Tipo de imagen ilegal image/gif	\N
1560	1330	error	Tipo de imagen ilegal image/gif	\N
1561	1330	error	Tipo de imagen ilegal image/gif	\N
1562	1330	error	Tipo de imagen ilegal image/gif	\N
1563	1330	error	Tipo de imagen ilegal image/gif	\N
1564	1330	error	Tipo de imagen ilegal image/gif	\N
1565	1330	error	Tipo de imagen ilegal image/gif	\N
1566	1330	error	Tipo de imagen ilegal image/gif	\N
1567	1330	error	Tipo de imagen ilegal image/gif	\N
1568	1331	error	Hay 26 imagenes sin atributo ALT	\N
1569	1331	warning	Hay 10 imagenes con atributo ALT vacío	\N
1570	1333	error	Script en línea	\N
1571	1333	error	Script en línea	\N
1572	1333	error	Script en línea	\N
1573	1333	error	Script en línea	\N
1574	1333	error	Script en línea	\N
1575	1333	error	Script en línea	\N
1576	1335	error	Hay 1 controles Flash declarados con HTML5	\N
1577	1338	error	utf8 "\\xF1" does not map to Unicode at /usr/lib/perl/5.10/Encode.pm line 162.\n	\N
1578	1339	error	Tipo de imagen ilegal image/jpeg	\N
1579	1339	error	Tipo de imagen ilegal image/gif	\N
1580	1339	error	Tipo de imagen ilegal image/gif	\N
1581	1339	error	Tipo de imagen ilegal image/gif	\N
1582	1339	error	Tipo de imagen ilegal image/jpeg	\N
1583	1339	error	Tipo de imagen ilegal image/gif	\N
1584	1339	error	Tipo de imagen ilegal image/jpeg	\N
1585	1339	error	Tipo de imagen ilegal image/gif	\N
1586	1339	error	Tipo de imagen ilegal image/jpeg	\N
1587	1339	error	Tipo de imagen ilegal image/gif	\N
1588	1339	error	Tipo de imagen ilegal image/gif	\N
1589	1339	error	Tipo de imagen ilegal image/jpeg	\N
1590	1339	error	Tipo de imagen ilegal image/gif	\N
1591	1339	error	Tipo de imagen ilegal image/gif	\N
1592	1339	error	Tipo de imagen ilegal image/jpeg	\N
1593	1339	error	Tipo de imagen ilegal image/gif	\N
1594	1339	error	Tipo de imagen ilegal image/gif	\N
1595	1339	error	Tipo de imagen ilegal image/jpeg	\N
1596	1339	error	Tipo de imagen ilegal image/gif	\N
1597	1339	error	Tipo de imagen ilegal image/jpeg	\N
1598	1339	error	Tipo de imagen ilegal image/gif	\N
1599	1339	error	Tipo de imagen ilegal image/jpeg	\N
1600	1339	error	Tipo de imagen ilegal image/gif	\N
1601	1339	error	Tipo de imagen ilegal image/gif	\N
1602	1339	error	Tipo de imagen ilegal image/jpeg	\N
1603	1339	error	Tipo de imagen ilegal image/gif	\N
1604	1339	error	Tipo de imagen ilegal image/gif	\N
1605	1339	error	Tipo de imagen ilegal image/gif	\N
1606	1339	error	Tipo de imagen ilegal image/gif	\N
1607	1339	error	Tipo de imagen ilegal image/gif	\N
1608	1339	error	Tipo de imagen ilegal image/gif	\N
1609	1339	error	Tipo de imagen ilegal image/gif	\N
1610	1339	error	Tipo de imagen ilegal image/gif	\N
1611	1339	error	Tipo de imagen ilegal image/gif	\N
1612	1340	error	Hay 23 imagenes sin atributo ALT	\N
1613	1340	warning	Hay 7 imagenes con atributo ALT vacío	\N
1614	1342	error	Script en línea	\N
1615	1342	error	Script en línea	\N
1616	1342	error	Script en línea	\N
1617	1342	error	Script en línea	\N
1618	1342	error	Script en línea	\N
1619	1342	error	Script en línea	\N
1620	1344	error	Hay 1 controles Flash declarados con HTML5	\N
1621	1348	error	Tipo de imagen ilegal image/jpeg	\N
1622	1348	error	Tipo de imagen ilegal image/gif	\N
1623	1348	error	Tipo de imagen ilegal image/jpeg	\N
1624	1348	error	Tipo de imagen ilegal image/gif	\N
1625	1348	error	Tipo de imagen ilegal image/gif	\N
1626	1348	error	Tipo de imagen ilegal image/jpeg	\N
1627	1348	error	Tipo de imagen ilegal image/gif	\N
1628	1348	error	Tipo de imagen ilegal image/gif	\N
1629	1348	error	Tipo de imagen ilegal image/jpeg	\N
1630	1348	error	Tipo de imagen ilegal image/gif	\N
1631	1348	error	Tipo de imagen ilegal image/gif	\N
1632	1348	error	Tipo de imagen ilegal image/jpeg	\N
1633	1348	error	Tipo de imagen ilegal image/gif	\N
1634	1348	error	Tipo de imagen ilegal image/gif	\N
1635	1348	error	Tipo de imagen ilegal image/jpeg	\N
1636	1348	error	Tipo de imagen ilegal image/gif	\N
1637	1348	error	Tipo de imagen ilegal image/gif	\N
1638	1348	error	Tipo de imagen ilegal image/jpeg	\N
1639	1348	error	Tipo de imagen ilegal image/gif	\N
1640	1348	error	Tipo de imagen ilegal image/gif	\N
1641	1348	error	Tipo de imagen ilegal image/jpeg	\N
1642	1348	error	Tipo de imagen ilegal image/gif	\N
1643	1348	error	Tipo de imagen ilegal image/gif	\N
1644	1348	error	Tipo de imagen ilegal image/jpeg	\N
1645	1348	error	Tipo de imagen ilegal image/gif	\N
1646	1348	error	Tipo de imagen ilegal image/gif	\N
1647	1348	error	Tipo de imagen ilegal image/jpeg	\N
1648	1348	error	Tipo de imagen ilegal image/gif	\N
1649	1348	error	Tipo de imagen ilegal image/gif	\N
1650	1348	error	Tipo de imagen ilegal image/jpeg	\N
1651	1348	error	Tipo de imagen ilegal image/gif	\N
1652	1348	error	Tipo de imagen ilegal image/gif	\N
1653	1348	error	Tipo de imagen ilegal image/jpeg	\N
1654	1348	error	Tipo de imagen ilegal image/gif	\N
1655	1348	error	Tipo de imagen ilegal image/gif	\N
1656	1348	error	Tipo de imagen ilegal image/gif	\N
1657	1348	error	Tipo de imagen ilegal image/gif	\N
1658	1348	error	Tipo de imagen ilegal image/gif	\N
1659	1348	error	Tipo de imagen ilegal image/gif	\N
1660	1348	error	Tipo de imagen ilegal image/gif	\N
1661	1348	error	Tipo de imagen ilegal image/gif	\N
1662	1348	error	Tipo de imagen ilegal image/gif	\N
1663	1349	error	Hay 21 imagenes sin atributo ALT	\N
1664	1349	warning	Hay 2 imagenes con atributo ALT vacío	\N
1665	1351	error	Script en línea	\N
1666	1351	error	Script en línea	\N
1667	1351	error	Script en línea	\N
1668	1351	error	Script en línea	\N
1669	1351	error	Script en línea	\N
1670	1351	error	Script en línea	\N
1671	1353	error	Hay 1 controles Flash declarados con HTML5	\N
1672	1357	error	Tipo de imagen ilegal image/jpeg	\N
1673	1357	error	Tipo de imagen ilegal image/gif	\N
1674	1357	error	Tipo de imagen ilegal image/jpeg	\N
1675	1357	error	Tipo de imagen ilegal image/gif	\N
1676	1357	error	Tipo de imagen ilegal image/gif	\N
1677	1357	error	Tipo de imagen ilegal image/jpeg	\N
1678	1357	error	Tipo de imagen ilegal image/gif	\N
1679	1357	error	Tipo de imagen ilegal image/gif	\N
1680	1357	error	Tipo de imagen ilegal image/jpeg	\N
1681	1357	error	Tipo de imagen ilegal image/gif	\N
1682	1357	error	Tipo de imagen ilegal image/gif	\N
1683	1357	error	Tipo de imagen ilegal image/jpeg	\N
1684	1357	error	Tipo de imagen ilegal image/gif	\N
1685	1357	error	Tipo de imagen ilegal image/gif	\N
1686	1357	error	Tipo de imagen ilegal image/jpeg	\N
1687	1357	error	Tipo de imagen ilegal image/gif	\N
1688	1357	error	Tipo de imagen ilegal image/gif	\N
1689	1357	error	Tipo de imagen ilegal image/jpeg	\N
1690	1357	error	Tipo de imagen ilegal image/gif	\N
1691	1357	error	Tipo de imagen ilegal image/gif	\N
1692	1357	error	Tipo de imagen ilegal image/jpeg	\N
1693	1357	error	Tipo de imagen ilegal image/gif	\N
1694	1357	error	Tipo de imagen ilegal image/gif	\N
1695	1357	error	Tipo de imagen ilegal image/jpeg	\N
1696	1357	error	Tipo de imagen ilegal image/gif	\N
1697	1357	error	Tipo de imagen ilegal image/gif	\N
1698	1357	error	Tipo de imagen ilegal image/jpeg	\N
1699	1357	error	Tipo de imagen ilegal image/gif	\N
1700	1357	error	Tipo de imagen ilegal image/gif	\N
1701	1357	error	Tipo de imagen ilegal image/jpeg	\N
1702	1357	error	Tipo de imagen ilegal image/gif	\N
1703	1357	error	Tipo de imagen ilegal image/gif	\N
1704	1357	error	Tipo de imagen ilegal image/jpeg	\N
1705	1357	error	Tipo de imagen ilegal image/gif	\N
1706	1357	error	Tipo de imagen ilegal image/gif	\N
1707	1357	error	Tipo de imagen ilegal image/gif	\N
1708	1357	error	Tipo de imagen ilegal image/gif	\N
1709	1357	error	Tipo de imagen ilegal image/gif	\N
1710	1357	error	Tipo de imagen ilegal image/gif	\N
1711	1357	error	Tipo de imagen ilegal image/gif	\N
1712	1357	error	Tipo de imagen ilegal image/gif	\N
1713	1357	error	Tipo de imagen ilegal image/gif	\N
1714	1358	error	Hay 21 imagenes sin atributo ALT	\N
1715	1358	warning	Hay 2 imagenes con atributo ALT vacío	\N
1716	1360	error	Script en línea	\N
1717	1360	error	Script en línea	\N
1718	1360	error	Script en línea	\N
1719	1360	error	Script en línea	\N
1720	1360	error	Script en línea	\N
1721	1360	error	Script en línea	\N
1722	1362	error	Hay 1 controles Flash declarados con HTML5	\N
1723	1365	error	utf8 "\\xF1" does not map to Unicode at /usr/lib/perl/5.10/Encode.pm line 162.\n	\N
1724	1366	error	Tipo de imagen ilegal image/jpeg	\N
1725	1366	error	Tipo de imagen ilegal image/gif	\N
1726	1366	error	Tipo de imagen ilegal image/jpeg	\N
1727	1366	error	Tipo de imagen ilegal image/gif	\N
1728	1366	error	Tipo de imagen ilegal image/gif	\N
1729	1366	error	Tipo de imagen ilegal image/gif	\N
1730	1366	error	Tipo de imagen ilegal image/jpeg	\N
1731	1366	error	Tipo de imagen ilegal image/gif	\N
1732	1366	error	Tipo de imagen ilegal image/gif	\N
1733	1366	error	Tipo de imagen ilegal image/jpeg	\N
1734	1366	error	Tipo de imagen ilegal image/gif	\N
1735	1366	error	Tipo de imagen ilegal image/gif	\N
1736	1366	error	Tipo de imagen ilegal image/jpeg	\N
1737	1366	error	Tipo de imagen ilegal image/gif	\N
1738	1366	error	Tipo de imagen ilegal image/jpeg	\N
1739	1366	error	Tipo de imagen ilegal image/gif	\N
1740	1366	error	Tipo de imagen ilegal image/gif	\N
1741	1366	error	Tipo de imagen ilegal image/jpeg	\N
1742	1366	error	Tipo de imagen ilegal image/gif	\N
1743	1366	error	Tipo de imagen ilegal image/jpeg	\N
1744	1366	error	Tipo de imagen ilegal image/gif	\N
1745	1366	error	Tipo de imagen ilegal image/jpeg	\N
1746	1366	error	Tipo de imagen ilegal image/gif	\N
1747	1366	error	Tipo de imagen ilegal image/gif	\N
1748	1366	error	Tipo de imagen ilegal image/jpeg	\N
1749	1366	error	Tipo de imagen ilegal image/gif	\N
1750	1366	error	Tipo de imagen ilegal image/jpeg	\N
1751	1366	error	Tipo de imagen ilegal image/gif	\N
1752	1366	error	Tipo de imagen ilegal image/gif	\N
1753	1366	error	Tipo de imagen ilegal image/gif	\N
1754	1366	error	Tipo de imagen ilegal image/gif	\N
1755	1366	error	Tipo de imagen ilegal image/gif	\N
1756	1366	error	Tipo de imagen ilegal image/gif	\N
1757	1366	error	Tipo de imagen ilegal image/gif	\N
1758	1366	error	Tipo de imagen ilegal image/gif	\N
1759	1366	error	Tipo de imagen ilegal image/gif	\N
1760	1367	error	Hay 26 imagenes sin atributo ALT	\N
1761	1367	warning	Hay 8 imagenes con atributo ALT vacío	\N
1762	1369	error	Script en línea	\N
1763	1369	error	Script en línea	\N
1764	1369	error	Script en línea	\N
1765	1369	error	Script en línea	\N
1766	1369	error	Script en línea	\N
1767	1369	error	Script en línea	\N
1768	1371	error	Hay 1 controles Flash declarados con HTML5	\N
1769	1375	error	Tipo de imagen ilegal image/jpeg	\N
1770	1375	error	Tipo de imagen ilegal image/gif	\N
1771	1375	error	Tipo de imagen ilegal image/jpeg	\N
1772	1375	error	Tipo de imagen ilegal image/gif	\N
1773	1375	error	Tipo de imagen ilegal image/gif	\N
1774	1375	error	Tipo de imagen ilegal image/jpeg	\N
1775	1375	error	Tipo de imagen ilegal image/gif	\N
1776	1375	error	Tipo de imagen ilegal image/gif	\N
1777	1375	error	Tipo de imagen ilegal image/jpeg	\N
1778	1375	error	Tipo de imagen ilegal image/gif	\N
1779	1375	error	Tipo de imagen ilegal image/gif	\N
1780	1375	error	Tipo de imagen ilegal image/jpeg	\N
1781	1375	error	Tipo de imagen ilegal image/gif	\N
1782	1375	error	Tipo de imagen ilegal image/gif	\N
1783	1375	error	Tipo de imagen ilegal image/jpeg	\N
1784	1375	error	Tipo de imagen ilegal image/gif	\N
1785	1375	error	Tipo de imagen ilegal image/gif	\N
1786	1375	error	Tipo de imagen ilegal image/jpeg	\N
1787	1375	error	Tipo de imagen ilegal image/gif	\N
1788	1375	error	Tipo de imagen ilegal image/gif	\N
1789	1375	error	Tipo de imagen ilegal image/jpeg	\N
1790	1375	error	Tipo de imagen ilegal image/gif	\N
1791	1375	error	Tipo de imagen ilegal image/gif	\N
1792	1375	error	Tipo de imagen ilegal image/jpeg	\N
1793	1375	error	Tipo de imagen ilegal image/gif	\N
1794	1375	error	Tipo de imagen ilegal image/gif	\N
1795	1375	error	Tipo de imagen ilegal image/jpeg	\N
1796	1375	error	Tipo de imagen ilegal image/gif	\N
1797	1375	error	Tipo de imagen ilegal image/gif	\N
1798	1375	error	Tipo de imagen ilegal image/jpeg	\N
1799	1375	error	Tipo de imagen ilegal image/gif	\N
1800	1375	error	Tipo de imagen ilegal image/gif	\N
1801	1375	error	Tipo de imagen ilegal image/jpeg	\N
1802	1375	error	Tipo de imagen ilegal image/gif	\N
1803	1375	error	Tipo de imagen ilegal image/gif	\N
1804	1375	error	Tipo de imagen ilegal image/gif	\N
1805	1375	error	Tipo de imagen ilegal image/gif	\N
1806	1375	error	Tipo de imagen ilegal image/gif	\N
1807	1375	error	Tipo de imagen ilegal image/gif	\N
1808	1375	error	Tipo de imagen ilegal image/gif	\N
1809	1375	error	Tipo de imagen ilegal image/gif	\N
1810	1375	error	Tipo de imagen ilegal image/gif	\N
1811	1376	error	Hay 21 imagenes sin atributo ALT	\N
1812	1376	warning	Hay 2 imagenes con atributo ALT vacío	\N
1813	1378	error	Script en línea	\N
1814	1378	error	Script en línea	\N
1815	1378	error	Script en línea	\N
1816	1378	error	Script en línea	\N
1817	1378	error	Script en línea	\N
1818	1378	error	Script en línea	\N
1819	1380	error	Hay 1 controles Flash declarados con HTML5	\N
1820	1384	error	Tipo de imagen ilegal image/jpeg	\N
1821	1384	error	Tipo de imagen ilegal image/gif	\N
1822	1384	error	Tipo de imagen ilegal image/jpeg	\N
1823	1384	error	Tipo de imagen ilegal image/gif	\N
1824	1384	error	Tipo de imagen ilegal image/gif	\N
1825	1384	error	Tipo de imagen ilegal image/jpeg	\N
1826	1384	error	Tipo de imagen ilegal image/gif	\N
1827	1384	error	Tipo de imagen ilegal image/gif	\N
1828	1384	error	Tipo de imagen ilegal image/jpeg	\N
1829	1384	error	Tipo de imagen ilegal image/gif	\N
1830	1384	error	Tipo de imagen ilegal image/gif	\N
1831	1384	error	Tipo de imagen ilegal image/jpeg	\N
1832	1384	error	Tipo de imagen ilegal image/gif	\N
1833	1384	error	Tipo de imagen ilegal image/gif	\N
1834	1384	error	Tipo de imagen ilegal image/jpeg	\N
1835	1384	error	Tipo de imagen ilegal image/gif	\N
1836	1384	error	Tipo de imagen ilegal image/gif	\N
1837	1384	error	Tipo de imagen ilegal image/jpeg	\N
1838	1384	error	Tipo de imagen ilegal image/gif	\N
1839	1384	error	Tipo de imagen ilegal image/gif	\N
1840	1384	error	Tipo de imagen ilegal image/jpeg	\N
1841	1384	error	Tipo de imagen ilegal image/gif	\N
1842	1384	error	Tipo de imagen ilegal image/gif	\N
1843	1384	error	Tipo de imagen ilegal image/jpeg	\N
1844	1384	error	Tipo de imagen ilegal image/gif	\N
1845	1384	error	Tipo de imagen ilegal image/gif	\N
1846	1384	error	Tipo de imagen ilegal image/jpeg	\N
1847	1384	error	Tipo de imagen ilegal image/gif	\N
1848	1384	error	Tipo de imagen ilegal image/gif	\N
1849	1384	error	Tipo de imagen ilegal image/jpeg	\N
1850	1384	error	Tipo de imagen ilegal image/gif	\N
1851	1384	error	Tipo de imagen ilegal image/gif	\N
1852	1384	error	Tipo de imagen ilegal image/jpeg	\N
1853	1384	error	Tipo de imagen ilegal image/gif	\N
1854	1384	error	Tipo de imagen ilegal image/gif	\N
1855	1384	error	Tipo de imagen ilegal image/gif	\N
1856	1384	error	Tipo de imagen ilegal image/gif	\N
1857	1384	error	Tipo de imagen ilegal image/gif	\N
1858	1384	error	Tipo de imagen ilegal image/gif	\N
1859	1384	error	Tipo de imagen ilegal image/gif	\N
1860	1384	error	Tipo de imagen ilegal image/gif	\N
1861	1384	error	Tipo de imagen ilegal image/gif	\N
1862	1385	error	Hay 21 imagenes sin atributo ALT	\N
1863	1385	warning	Hay 2 imagenes con atributo ALT vacío	\N
1864	1387	error	Script en línea	\N
1865	1387	error	Script en línea	\N
1866	1387	error	Script en línea	\N
1867	1387	error	Script en línea	\N
1868	1387	error	Script en línea	\N
1869	1387	error	Script en línea	\N
1870	1389	error	Hay 1 controles Flash declarados con HTML5	\N
1871	1393	error	Tipo de imagen ilegal image/jpeg	\N
1872	1393	error	Tipo de imagen ilegal image/gif	\N
1873	1393	error	Tipo de imagen ilegal image/jpeg	\N
1874	1393	error	Tipo de imagen ilegal image/gif	\N
1875	1393	error	Tipo de imagen ilegal image/jpeg	\N
1876	1393	error	Tipo de imagen ilegal image/gif	\N
1877	1393	error	Tipo de imagen ilegal image/jpeg	\N
1878	1393	error	Tipo de imagen ilegal image/gif	\N
1879	1393	error	Tipo de imagen ilegal image/jpeg	\N
1880	1393	error	Tipo de imagen ilegal image/gif	\N
1881	1393	error	Tipo de imagen ilegal image/jpeg	\N
1882	1393	error	Tipo de imagen ilegal image/gif	\N
1883	1393	error	Tipo de imagen ilegal image/jpeg	\N
1884	1393	error	Tipo de imagen ilegal image/gif	\N
1885	1393	error	Tipo de imagen ilegal image/gif	\N
1886	1393	error	Tipo de imagen ilegal image/jpeg	\N
1887	1393	error	Tipo de imagen ilegal image/gif	\N
1888	1393	error	Tipo de imagen ilegal image/jpeg	\N
1889	1393	error	Tipo de imagen ilegal image/gif	\N
1890	1393	error	Tipo de imagen ilegal image/jpeg	\N
1891	1393	error	Tipo de imagen ilegal image/gif	\N
1892	1393	error	Tipo de imagen ilegal image/jpeg	\N
1893	1393	error	Tipo de imagen ilegal image/gif	\N
1894	1393	error	Tipo de imagen ilegal image/jpeg	\N
1895	1393	error	Tipo de imagen ilegal image/gif	\N
1896	1393	error	Tipo de imagen ilegal image/gif	\N
1897	1393	error	Tipo de imagen ilegal image/gif	\N
1898	1393	error	Tipo de imagen ilegal image/gif	\N
1899	1393	error	Tipo de imagen ilegal image/gif	\N
1900	1393	error	Tipo de imagen ilegal image/gif	\N
1901	1393	error	Tipo de imagen ilegal image/gif	\N
1902	1393	error	Tipo de imagen ilegal image/gif	\N
1903	1393	error	Tipo de imagen ilegal image/gif	\N
1904	1394	error	Hay 22 imagenes sin atributo ALT	\N
1905	1394	warning	Hay 11 imagenes con atributo ALT vacío	\N
1906	1396	error	Script en línea	\N
1907	1396	error	Script en línea	\N
1908	1396	error	Script en línea	\N
1909	1396	error	Script en línea	\N
1910	1396	error	Script en línea	\N
1911	1396	error	Script en línea	\N
1912	1398	error	Hay 1 controles Flash declarados con HTML5	\N
1913	1401	error	utf8 "\\xF1" does not map to Unicode at /usr/lib/perl/5.10/Encode.pm line 162.\n	\N
1914	1402	error	Tipo de imagen ilegal image/jpeg	\N
1915	1402	error	Tipo de imagen ilegal image/gif	\N
1916	1402	error	Tipo de imagen ilegal image/jpeg	\N
1917	1402	error	Tipo de imagen ilegal image/gif	\N
1918	1402	error	Tipo de imagen ilegal image/gif	\N
1919	1402	error	Tipo de imagen ilegal image/jpeg	\N
1920	1402	error	Tipo de imagen ilegal image/gif	\N
1921	1402	error	Tipo de imagen ilegal image/gif	\N
1922	1402	error	Tipo de imagen ilegal image/jpeg	\N
1923	1402	error	Tipo de imagen ilegal image/gif	\N
1924	1402	error	Tipo de imagen ilegal image/gif	\N
1925	1402	error	Tipo de imagen ilegal image/jpeg	\N
1926	1402	error	Tipo de imagen ilegal image/gif	\N
1927	1402	error	Tipo de imagen ilegal image/gif	\N
1928	1402	error	Tipo de imagen ilegal image/jpeg	\N
1929	1402	error	Tipo de imagen ilegal image/gif	\N
1930	1402	error	Tipo de imagen ilegal image/gif	\N
1931	1402	error	Tipo de imagen ilegal image/jpeg	\N
1932	1402	error	Tipo de imagen ilegal image/gif	\N
1933	1402	error	Tipo de imagen ilegal image/gif	\N
1934	1402	error	Tipo de imagen ilegal image/jpeg	\N
1935	1402	error	Tipo de imagen ilegal image/gif	\N
1936	1402	error	Tipo de imagen ilegal image/gif	\N
1937	1402	error	Tipo de imagen ilegal image/jpeg	\N
1938	1402	error	Tipo de imagen ilegal image/gif	\N
1939	1402	error	Tipo de imagen ilegal image/gif	\N
1940	1402	error	Tipo de imagen ilegal image/gif	\N
1941	1402	error	Tipo de imagen ilegal image/jpeg	\N
1942	1402	error	Tipo de imagen ilegal image/gif	\N
1943	1402	error	Tipo de imagen ilegal image/gif	\N
1944	1402	error	Tipo de imagen ilegal image/jpeg	\N
1945	1402	error	Tipo de imagen ilegal image/gif	\N
1946	1402	error	Tipo de imagen ilegal image/gif	\N
1947	1402	error	Tipo de imagen ilegal image/gif	\N
1948	1402	error	Tipo de imagen ilegal image/gif	\N
1949	1402	error	Tipo de imagen ilegal image/gif	\N
1950	1402	error	Tipo de imagen ilegal image/gif	\N
1951	1402	error	Tipo de imagen ilegal image/gif	\N
1952	1402	error	Tipo de imagen ilegal image/gif	\N
1953	1402	error	Tipo de imagen ilegal image/gif	\N
1954	1403	error	Hay 25 imagenes sin atributo ALT	\N
1955	1403	warning	Hay 6 imagenes con atributo ALT vacío	\N
1956	1405	error	Script en línea	\N
1957	1405	error	Script en línea	\N
1958	1405	error	Script en línea	\N
1959	1405	error	Script en línea	\N
1960	1405	error	Script en línea	\N
1961	1405	error	Script en línea	\N
1962	1407	error	Hay 1 controles Flash declarados con HTML5	\N
1963	1410	error	utf8 "\\xF1" does not map to Unicode at /usr/lib/perl/5.10/Encode.pm line 162.\n	\N
1964	1411	error	Tipo de imagen ilegal image/jpeg	\N
1965	1411	error	Tipo de imagen ilegal image/gif	\N
1966	1411	error	Tipo de imagen ilegal image/jpeg	\N
1967	1411	error	Tipo de imagen ilegal image/gif	\N
1968	1411	error	Tipo de imagen ilegal image/jpeg	\N
1969	1411	error	Tipo de imagen ilegal image/gif	\N
1970	1411	error	Tipo de imagen ilegal image/jpeg	\N
1971	1411	error	Tipo de imagen ilegal image/gif	\N
1972	1411	error	Tipo de imagen ilegal image/gif	\N
1973	1411	error	Tipo de imagen ilegal image/jpeg	\N
1974	1411	error	Tipo de imagen ilegal image/gif	\N
1975	1411	error	Tipo de imagen ilegal image/jpeg	\N
1976	1411	error	Tipo de imagen ilegal image/gif	\N
1977	1411	error	Tipo de imagen ilegal image/jpeg	\N
1978	1411	error	Tipo de imagen ilegal image/gif	\N
1979	1411	error	Tipo de imagen ilegal image/gif	\N
1980	1411	error	Tipo de imagen ilegal image/jpeg	\N
1981	1411	error	Tipo de imagen ilegal image/gif	\N
1982	1411	error	Tipo de imagen ilegal image/jpeg	\N
1983	1411	error	Tipo de imagen ilegal image/gif	\N
1984	1411	error	Tipo de imagen ilegal image/gif	\N
1985	1411	error	Tipo de imagen ilegal image/jpeg	\N
1986	1411	error	Tipo de imagen ilegal image/gif	\N
1987	1411	error	Tipo de imagen ilegal image/gif	\N
1988	1411	error	Tipo de imagen ilegal image/jpeg	\N
1989	1411	error	Tipo de imagen ilegal image/gif	\N
1990	1411	error	Tipo de imagen ilegal image/gif	\N
1991	1411	error	Tipo de imagen ilegal image/jpeg	\N
1992	1411	error	Tipo de imagen ilegal image/gif	\N
1993	1411	error	Tipo de imagen ilegal image/gif	\N
1994	1411	error	Tipo de imagen ilegal image/gif	\N
1995	1411	error	Tipo de imagen ilegal image/gif	\N
1996	1411	error	Tipo de imagen ilegal image/gif	\N
1997	1411	error	Tipo de imagen ilegal image/gif	\N
1998	1411	error	Tipo de imagen ilegal image/gif	\N
1999	1411	error	Tipo de imagen ilegal image/gif	\N
2000	1411	error	Tipo de imagen ilegal image/gif	\N
2001	1412	error	Hay 25 imagenes sin atributo ALT	\N
2002	1412	warning	Hay 7 imagenes con atributo ALT vacío	\N
2003	1414	error	Script en línea	\N
2004	1414	error	Script en línea	\N
2005	1414	error	Script en línea	\N
2006	1414	error	Script en línea	\N
2007	1414	error	Script en línea	\N
2008	1414	error	Script en línea	\N
2009	1416	error	Hay 1 controles Flash declarados con HTML5	\N
2010	1420	error	Tipo de imagen ilegal image/jpeg	\N
2011	1420	error	Tipo de imagen ilegal image/gif	\N
2012	1420	error	Tipo de imagen ilegal image/jpeg	\N
2013	1420	error	Tipo de imagen ilegal image/gif	\N
2014	1420	error	Tipo de imagen ilegal image/jpeg	\N
2015	1420	error	Tipo de imagen ilegal image/gif	\N
2016	1420	error	Tipo de imagen ilegal image/jpeg	\N
2017	1420	error	Tipo de imagen ilegal image/gif	\N
2018	1420	error	Tipo de imagen ilegal image/jpeg	\N
2019	1420	error	Tipo de imagen ilegal image/gif	\N
2020	1420	error	Tipo de imagen ilegal image/jpeg	\N
2021	1420	error	Tipo de imagen ilegal image/gif	\N
2022	1420	error	Tipo de imagen ilegal image/jpeg	\N
2023	1420	error	Tipo de imagen ilegal image/gif	\N
2024	1420	error	Tipo de imagen ilegal image/jpeg	\N
2025	1420	error	Tipo de imagen ilegal image/gif	\N
2026	1420	error	Tipo de imagen ilegal image/jpeg	\N
2027	1420	error	Tipo de imagen ilegal image/gif	\N
2028	1420	error	Tipo de imagen ilegal image/jpeg	\N
2029	1420	error	Tipo de imagen ilegal image/gif	\N
2030	1420	error	Tipo de imagen ilegal image/jpeg	\N
2031	1420	error	Tipo de imagen ilegal image/gif	\N
2032	1420	error	Tipo de imagen ilegal image/jpeg	\N
2033	1420	error	Tipo de imagen ilegal image/gif	\N
2034	1420	error	Tipo de imagen ilegal image/jpeg	\N
2035	1420	error	Tipo de imagen ilegal image/gif	\N
2036	1420	error	Tipo de imagen ilegal image/jpeg	\N
2037	1420	error	Tipo de imagen ilegal image/gif	\N
2038	1420	error	Tipo de imagen ilegal image/jpeg	\N
2039	1420	error	Tipo de imagen ilegal image/gif	\N
2040	1420	error	Tipo de imagen ilegal image/jpeg	\N
2041	1420	error	Tipo de imagen ilegal image/gif	\N
2042	1420	error	Tipo de imagen ilegal image/jpeg	\N
2043	1420	error	Tipo de imagen ilegal image/gif	\N
2044	1420	error	Tipo de imagen ilegal image/gif	\N
2045	1420	error	Tipo de imagen ilegal image/gif	\N
2046	1420	error	Tipo de imagen ilegal image/gif	\N
2047	1420	error	Tipo de imagen ilegal image/gif	\N
2048	1420	error	Tipo de imagen ilegal image/gif	\N
2049	1420	error	Tipo de imagen ilegal image/gif	\N
2050	1420	error	Tipo de imagen ilegal image/gif	\N
2051	1420	error	Tipo de imagen ilegal image/gif	\N
2052	1421	error	Hay 26 imagenes sin atributo ALT	\N
2053	1421	warning	Hay 16 imagenes con atributo ALT vacío	\N
2054	1423	error	Script en línea	\N
2055	1423	error	Script en línea	\N
2056	1423	error	Script en línea	\N
2057	1423	error	Script en línea	\N
2058	1423	error	Script en línea	\N
2059	1423	error	Script en línea	\N
2060	1425	error	Hay 1 controles Flash declarados con HTML5	\N
2061	1429	error	Tipo de imagen ilegal image/jpeg	\N
2062	1429	error	Tipo de imagen ilegal image/gif	\N
2063	1429	error	Tipo de imagen ilegal image/jpeg	\N
2064	1429	error	Tipo de imagen ilegal image/gif	\N
2065	1429	error	Tipo de imagen ilegal image/jpeg	\N
2066	1429	error	Tipo de imagen ilegal image/gif	\N
2067	1429	error	Tipo de imagen ilegal image/jpeg	\N
2068	1429	error	Tipo de imagen ilegal image/gif	\N
2069	1429	error	Tipo de imagen ilegal image/jpeg	\N
2070	1429	error	Tipo de imagen ilegal image/gif	\N
2071	1429	error	Tipo de imagen ilegal image/jpeg	\N
2072	1429	error	Tipo de imagen ilegal image/gif	\N
2073	1429	error	Tipo de imagen ilegal image/jpeg	\N
2074	1429	error	Tipo de imagen ilegal image/gif	\N
2075	1429	error	Tipo de imagen ilegal image/jpeg	\N
2076	1429	error	Tipo de imagen ilegal image/gif	\N
2077	1429	error	Tipo de imagen ilegal image/jpeg	\N
2078	1429	error	Tipo de imagen ilegal image/gif	\N
2079	1429	error	Tipo de imagen ilegal image/jpeg	\N
2080	1429	error	Tipo de imagen ilegal image/gif	\N
2081	1429	error	Tipo de imagen ilegal image/jpeg	\N
2082	1429	error	Tipo de imagen ilegal image/gif	\N
2083	1429	error	Tipo de imagen ilegal image/jpeg	\N
2084	1429	error	Tipo de imagen ilegal image/gif	\N
2085	1429	error	Tipo de imagen ilegal image/jpeg	\N
2086	1429	error	Tipo de imagen ilegal image/gif	\N
2087	1429	error	Tipo de imagen ilegal image/jpeg	\N
2088	1429	error	Tipo de imagen ilegal image/gif	\N
2089	1429	error	Tipo de imagen ilegal image/jpeg	\N
2090	1429	error	Tipo de imagen ilegal image/gif	\N
2091	1429	error	Tipo de imagen ilegal image/jpeg	\N
2092	1429	error	Tipo de imagen ilegal image/gif	\N
2093	1429	error	Tipo de imagen ilegal image/jpeg	\N
2094	1429	error	Tipo de imagen ilegal image/gif	\N
2095	1429	error	Tipo de imagen ilegal image/gif	\N
2096	1429	error	Tipo de imagen ilegal image/gif	\N
2097	1429	error	Tipo de imagen ilegal image/gif	\N
2098	1429	error	Tipo de imagen ilegal image/gif	\N
2099	1429	error	Tipo de imagen ilegal image/gif	\N
2100	1429	error	Tipo de imagen ilegal image/gif	\N
2101	1429	error	Tipo de imagen ilegal image/gif	\N
2102	1429	error	Tipo de imagen ilegal image/gif	\N
2103	1430	error	Hay 26 imagenes sin atributo ALT	\N
2104	1430	warning	Hay 16 imagenes con atributo ALT vacío	\N
2105	1432	error	Script en línea	\N
2106	1432	error	Script en línea	\N
2107	1432	error	Script en línea	\N
2108	1432	error	Script en línea	\N
2109	1432	error	Script en línea	\N
2110	1432	error	Script en línea	\N
2111	1434	error	Hay 1 controles Flash declarados con HTML5	\N
2112	1438	error	Tipo de imagen ilegal image/jpeg	\N
2113	1438	error	Tipo de imagen ilegal image/gif	\N
2114	1438	error	Tipo de imagen ilegal image/jpeg	\N
2115	1438	error	Tipo de imagen ilegal image/jpeg	\N
2116	1438	error	Tipo de imagen ilegal image/jpeg	\N
2117	1438	error	Tipo de imagen ilegal image/gif	\N
2118	1438	error	Tipo de imagen ilegal image/gif	\N
2119	1438	error	Tipo de imagen ilegal image/gif	\N
2120	1438	error	Tipo de imagen ilegal image/gif	\N
2121	1438	error	Tipo de imagen ilegal image/gif	\N
2122	1438	error	Tipo de imagen ilegal image/gif	\N
2123	1438	error	Tipo de imagen ilegal image/gif	\N
2124	1438	error	Tipo de imagen ilegal image/gif	\N
2125	1438	error	Tipo de imagen ilegal image/gif	\N
2126	1439	error	Hay 11 imagenes sin atributo ALT	\N
2127	1439	warning	Hay 3 imagenes con atributo ALT vacío	\N
2128	1441	error	Script en línea	\N
2129	1441	error	Script en línea	\N
2130	1441	error	Script en línea	\N
2131	1441	error	Script en línea	\N
2132	1441	error	Script en línea	\N
2133	1441	error	Script en línea	\N
2134	1441	error	Script en línea	\N
2135	1443	error	Hay 1 controles Flash declarados con HTML5	\N
2136	1447	error	Tipo de imagen ilegal image/jpeg	\N
2137	1447	error	Tipo de imagen ilegal image/gif	\N
2138	1447	error	Tipo de imagen ilegal image/jpeg	\N
2139	1447	error	Tipo de imagen ilegal image/jpeg	\N
2140	1447	error	Tipo de imagen ilegal image/jpeg	\N
2141	1447	error	Tipo de imagen ilegal image/gif	\N
2142	1447	error	Tipo de imagen ilegal image/gif	\N
2143	1447	error	Tipo de imagen ilegal image/gif	\N
2144	1447	error	Tipo de imagen ilegal image/gif	\N
2145	1447	error	Tipo de imagen ilegal image/gif	\N
2146	1447	error	Tipo de imagen ilegal image/gif	\N
2147	1447	error	Tipo de imagen ilegal image/gif	\N
2148	1447	error	Tipo de imagen ilegal image/gif	\N
2149	1447	error	Tipo de imagen ilegal image/gif	\N
2150	1448	error	Hay 11 imagenes sin atributo ALT	\N
2151	1448	warning	Hay 3 imagenes con atributo ALT vacío	\N
2152	1450	error	Script en línea	\N
2153	1450	error	Script en línea	\N
2154	1450	error	Script en línea	\N
2155	1450	error	Script en línea	\N
2156	1450	error	Script en línea	\N
2157	1450	error	Script en línea	\N
2158	1450	error	Script en línea	\N
2159	1452	error	Hay 1 controles Flash declarados con HTML5	\N
2160	1456	error	Tipo de imagen ilegal image/jpeg	\N
2161	1456	error	Tipo de imagen ilegal image/gif	\N
2162	1456	error	Tipo de imagen ilegal image/jpeg	\N
2163	1456	error	Tipo de imagen ilegal image/gif	\N
2164	1456	error	Tipo de imagen ilegal image/gif	\N
2165	1456	error	Tipo de imagen ilegal image/gif	\N
2166	1456	error	Tipo de imagen ilegal image/gif	\N
2167	1456	error	Tipo de imagen ilegal image/gif	\N
2168	1456	error	Tipo de imagen ilegal image/gif	\N
2169	1456	error	Tipo de imagen ilegal image/gif	\N
2170	1456	error	Tipo de imagen ilegal image/gif	\N
2171	1456	error	Tipo de imagen ilegal image/gif	\N
2172	1457	error	Hay 11 imagenes sin atributo ALT	\N
2173	1457	warning	Hay 2 imagenes con atributo ALT vacío	\N
2174	1459	error	Script en línea	\N
2175	1459	error	Script en línea	\N
2176	1459	error	Script en línea	\N
2177	1459	error	Script en línea	\N
2178	1459	error	Script en línea	\N
2179	1459	error	Script en línea	\N
2180	1461	error	Hay 1 controles Flash declarados con HTML5	\N
2181	1465	error	Tipo de imagen ilegal image/jpeg	\N
2182	1465	error	Tipo de imagen ilegal image/gif	\N
2183	1465	error	Tipo de imagen ilegal text/html	\N
2184	1465	error	Tipo de imagen ilegal text/html	\N
2185	1465	error	Tipo de imagen ilegal text/html	\N
2186	1465	error	Tipo de imagen ilegal text/html	\N
2187	1465	error	Tipo de imagen ilegal text/html	\N
2188	1465	error	Tipo de imagen ilegal text/html	\N
2189	1465	error	Tipo de imagen ilegal text/html	\N
2190	1465	error	Tipo de imagen ilegal text/html	\N
2191	1465	error	Tipo de imagen ilegal image/jpeg	\N
2192	1465	error	Tipo de imagen ilegal image/gif	\N
2193	1465	error	Tipo de imagen ilegal image/gif	\N
2194	1465	error	Tipo de imagen ilegal image/gif	\N
2195	1465	error	Tipo de imagen ilegal image/gif	\N
2196	1465	error	Tipo de imagen ilegal image/gif	\N
2197	1465	error	Tipo de imagen ilegal image/gif	\N
2198	1465	error	Tipo de imagen ilegal image/gif	\N
2199	1465	error	Tipo de imagen ilegal image/gif	\N
2200	1465	error	Tipo de imagen ilegal image/gif	\N
2201	1466	error	Hay 19 imagenes sin atributo ALT	\N
2202	1466	warning	Hay 2 imagenes con atributo ALT vacío	\N
2203	1468	error	Script en línea	\N
2204	1468	error	Script en línea	\N
2205	1468	error	Script en línea	\N
2206	1468	error	Script en línea	\N
2207	1468	error	Script en línea	\N
2208	1468	error	Script en línea	\N
2209	1470	error	Hay 1 controles Flash declarados con HTML5	\N
2210	1474	error	Tipo de imagen ilegal image/jpeg	\N
2211	1474	error	Tipo de imagen ilegal image/gif	\N
2212	1474	error	Tipo de imagen ilegal image/jpeg	\N
2213	1474	error	Tipo de imagen ilegal image/gif	\N
2214	1474	error	Tipo de imagen ilegal image/gif	\N
2215	1474	error	Tipo de imagen ilegal image/gif	\N
2216	1474	error	Tipo de imagen ilegal image/gif	\N
2217	1474	error	Tipo de imagen ilegal image/gif	\N
2218	1474	error	Tipo de imagen ilegal image/gif	\N
2219	1474	error	Tipo de imagen ilegal image/gif	\N
2220	1474	error	Tipo de imagen ilegal image/gif	\N
2221	1474	error	Tipo de imagen ilegal image/gif	\N
2222	1475	error	Hay 11 imagenes sin atributo ALT	\N
2223	1475	warning	Hay 2 imagenes con atributo ALT vacío	\N
2224	1477	error	Script en línea	\N
2225	1477	error	Script en línea	\N
2226	1477	error	Script en línea	\N
2227	1477	error	Script en línea	\N
2228	1477	error	Script en línea	\N
2229	1477	error	Script en línea	\N
2230	1479	error	Hay 1 controles Flash declarados con HTML5	\N
2231	1483	error	Tipo de imagen ilegal image/jpeg	\N
2232	1483	error	Tipo de imagen ilegal image/gif	\N
2233	1483	error	Tipo de imagen ilegal image/jpeg	\N
2234	1483	error	Tipo de imagen ilegal image/gif	\N
2235	1483	error	Tipo de imagen ilegal image/gif	\N
2236	1483	error	Tipo de imagen ilegal image/gif	\N
2237	1483	error	Tipo de imagen ilegal image/gif	\N
2238	1483	error	Tipo de imagen ilegal image/gif	\N
2239	1483	error	Tipo de imagen ilegal image/gif	\N
2240	1483	error	Tipo de imagen ilegal image/gif	\N
2241	1483	error	Tipo de imagen ilegal image/gif	\N
2242	1483	error	Tipo de imagen ilegal image/gif	\N
2243	1484	error	Hay 11 imagenes sin atributo ALT	\N
2244	1484	warning	Hay 2 imagenes con atributo ALT vacío	\N
2245	1486	error	Script en línea	\N
2246	1486	error	Script en línea	\N
2247	1486	error	Script en línea	\N
2248	1486	error	Script en línea	\N
2249	1486	error	Script en línea	\N
2250	1486	error	Script en línea	\N
2251	1488	error	Hay 1 controles Flash declarados con HTML5	\N
2252	1492	warnings	No HTTP Charset	\N
2253	1492	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
2254	1492	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
2255	1495	warning	Atributo obsoleto 'language'	\N
2256	1496	error	Script en línea	\N
2257	1496	error	No se usan archivos con extensión .js	\N
2258	1501	warnings	No HTTP Charset	\N
2259	1501	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
2260	1504	warning	Atributo obsoleto 'language'	\N
2261	1505	error	Script en línea	\N
2262	1505	error	Script en línea	\N
2263	1505	error	Script en línea	\N
2264	1505	error	Script en línea	\N
2265	1505	error	Script en línea	\N
2266	1507	error	Hay 1 controles ActiveX	\N
2267	1507	error	Hay 1 controles Flash declarados con HTML5	\N
2268	1510	warnings	No HTTP Charset	\N
2269	1510	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
2270	1511	error	Tipo de imagen ilegal image/jpeg	\N
2271	1511	error	Tipo de imagen ilegal image/jpeg	\N
2272	1511	error	Tipo de imagen ilegal image/jpeg	\N
2273	1511	error	Tipo de imagen ilegal image/jpeg	\N
2274	1511	error	Tipo de imagen ilegal image/jpeg	\N
2275	1511	error	Tipo de imagen ilegal image/jpeg	\N
2276	1511	error	Tipo de imagen ilegal image/jpeg	\N
2277	1511	error	Tipo de imagen ilegal image/jpeg	\N
2278	1511	error	Tipo de imagen ilegal image/jpeg	\N
2279	1511	error	Tipo de imagen ilegal image/gif	\N
2280	1512	error	Hay 2 imagenes sin atributo ALT	\N
2281	1513	warning	Atributo obsoleto 'language'	\N
2282	1514	error	Script en línea	\N
2283	1514	error	Script en línea	\N
2284	1514	error	Script en línea	\N
2285	1514	error	Script en línea	\N
2286	1514	error	Script en línea	\N
2287	1514	error	Script en línea	\N
2288	1519	warnings	No HTTP Charset	\N
2289	1519	error	HTTP charset '' does not match META charset 'iso-8859-1'	\N
2290	1522	warning	Atributo obsoleto 'language'	\N
2291	1523	error	Script en línea	\N
2292	1523	error	Script en línea	\N
2293	1523	error	Script en línea	\N
2294	1523	error	Script en línea	\N
2295	1523	error	Script en línea	\N
\.


--
-- Data for Name: institucion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY institucion (id, nombre, rif, correo, telefono, contacto, direccion, web, habilitado) FROM stdin;
3	Centro Nacional de Tecnologías de la Información	G-000000000	info@cnti.gob.ve	0212-222.2222	Fany Hernandez	Av. Urdaneta	http://www.cnti.gob.ve	t
4	CANTV	G-0987654321	info@cantv.com.ve	0212-333.3333	Juan Rodriguez	Colegio de Ingenieros	http://www.cantv.com.ve	t
2	Ministerio de Finanzas	G-1234567890	info@finanzas.gob.ve	0212-222.2222	Joel Gonzales	Por aca	http://www.mppef.gob.ve	t
8	Juan Technology	v-14951432	juan@covetel.com.ve	0412-9889285	Juan Mesa	Cordero Edo. Tachira	http://blogs.covetel.com.ve/overdrive	f
9	Ministerio de Cosas	G-00000000	ministro@cosas.gob.ve	555-555.5555	El Ministro	Por estas calles	http://www.cosas.gob.ve	t
5	Insitucion	G-432123	info@institucion.com	2292092	Walter	Por alli	www.notiene.com	f
11	Ministerio del Ambiente	G-432455991	info@ambiente.gob.ve	0212-333.3333	Otro ministro	Caracas, Distrito Federal	http://www.ambiente.gob.ve	t
13	Casa de lili	J-333333333	lilibeth@covetel.com.ve	555-555.5555	skjhskfhsdfkhfdkhasdfkhasdfk	asdadadadasdadadada	http://www.portatillili.gov.ve	t
15	Ministerio de Finanzas 2	G-12345678902	otro@otro.com	(333) 333-3333	Alguien por alli	adasd a;sakjn ai asljdal	http://www.ambiente.gob.ve	t
16	COVETEL	J-321345111	info@covetel.com.ve	(222) 222-2222	Walter	paramillo	http://www.covetel.com.ve	t
17	Luis Chacon	j-2131231331111	info@luischacon.info	(041) 444-4444	Luis Chacon	San Cristobal	http://www.luischacon.info	t
18	Vencert	G-4493292	info@vencert.gob.ve	(0212) 222-2222	Omar Alvarado	\N	http://www.vencert.gob.ve	t
19	Seguro Social	G-4492221	info@ivss.gov.ve	(0212) 999-9999	Angel Vargas	Donde trabaja angel	http://www.ivss.gov.ve	t
20	Banco de Venezuela	j-231231	info@bancodevenezuela.com	(0212) 999-9999	Juan Fuentes	Por la hoyada	http://www.bancodevenezuela.com	t
14	Servicio Autonomo de Transporte y Tránsito Terrestre	G-11	info@setra.gob.ve	0212-333.3333	El pana del SETRA	En Caracas	http://www.setra.gob.ve	f
21	Presidencia de la República	G-0000011101	info@presidencia.gob.ve	(5555) 555-5555	Fulanito	Miraflores	http://www.presidencia.gob.ve/	t
22	Venezolana de TV	G-1233213333	info@vtv.gob.ve	(0000) 000-0000	Fulano	En la television	http://www.vtv.gob.ve	t
23	Asamblea TV	j-7777777777777	info@antv.gob.ve	(8888) 888-8888	Otro Fulano	En la TV tambien	http://www.antv.gob.ve	t
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY jobs (id, site, callback, data, state, proc, ctime, mtime, pid) FROM stdin;
13	http://www.presidencia.gob.ve	\N	\N	done	16939	2010-08-22 07:15:47	2010-08-22 07:19:59	\N
14	http://www.vtv.gob.ve	\N	\N	run	9755	2010-08-23 02:00:27	2010-08-23 02:00:29	\N
15	http://www.antv.gob.ve	\N	\N	done	9865	2010-08-23 02:10:03	2010-08-23 02:10:38	\N
\.


--
-- Data for Name: params; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY params (id, disposicion, parametro) FROM stdin;
4492	Fonts	1015sn
4493	Fonts	1015snr
4494	Fonts	18holes
4495	Fonts	36daysag
4496	Fonts	36daythk
4497	Fonts	3dlet
4498	Fonts	4shadow
4499	Fonts	4shadowo
4500	Fonts	8bitlim
4501	Fonts	8bitlimo
4502	Fonts	8bitlimr
4503	Fonts	8blimro
4504	Fonts	90stars
4505	Fonts	BLEX
4506	Fonts	BLSY
4507	Fonts	MarVoSym
4508	Fonts	RBLMI
4509	Fonts	abecedario
4510	Fonts	abecedarioguiada
4511	Fonts	abecedarionegrita
4512	Fonts	abecedariopautada
4513	Fonts	abecedariopuntguiada
4514	Fonts	abecedariopuntos
4515	Fonts	abecedariopuntpautada
4516	Fonts	abyssinica_sil
4517	Fonts	acidrefl
4518	Fonts	acknowtt
4519	Fonts	ae_alarabiya
4520	Fonts	ae_albattar
4521	Fonts	ae_alhor
4522	Fonts	ae_almanzomah
4523	Fonts	ae_almateen-bold
4524	Fonts	ae_almohanad
4525	Fonts	ae_almothnna-bold
4526	Fonts	ae_alyarmook
4527	Fonts	ae_arab
4528	Fonts	ae_cortoba
4529	Fonts	ae_dimnah
4530	Fonts	ae_electron
4531	Fonts	ae_furat
4532	Fonts	ae_granada
4533	Fonts	ae_graph
4534	Fonts	ae_hani
4535	Fonts	ae_haramain
4536	Fonts	ae_hor
4537	Fonts	ae_japan
4538	Fonts	ae_jet
4539	Fonts	ae_kayrawan
4540	Fonts	ae_khalid
4541	Fonts	ae_mashq-bold
4542	Fonts	ae_mashq
4543	Fonts	ae_metal
4544	Fonts	ae_nada
4545	Fonts	ae_nagham
4546	Fonts	ae_nice
4547	Fonts	ae_ostorah
4548	Fonts	ae_ouhod-bold
4549	Fonts	ae_petra
4550	Fonts	ae_rasheeq-bold
4551	Fonts	ae_rehan
4552	Fonts	ae_salem
4553	Fonts	ae_shado
4554	Fonts	ae_sharjah
4555	Fonts	ae_sindbad
4556	Fonts	ae_tarablus
4557	Fonts	ae_tholoth
4558	Fonts	aescrawl
4559	Fonts	aesymatt
4560	Fonts	aftermat
4561	Fonts	aharoniclm-bold
4562	Fonts	aharoniclm-boldoblique
4563	Fonts	aharoniclm-book
4564	Fonts	aharoniclm-bookoblique
4565	Fonts	alba____
4566	Fonts	albam___
4567	Fonts	albas___
4568	Fonts	alfa-beta
4569	Fonts	alphbeta
4570	Fonts	amalgama
4571	Fonts	amalgamo
4572	Fonts	amicilogo
4573	Fonts	amicilogobold
4574	Fonts	amicilogoboldoblique
4575	Fonts	amicilogoboldreverseoblique
4576	Fonts	amicilogooblique
4577	Fonts	amicilogoreverseoblique
4578	Fonts	amplitud
4579	Fonts	andbasr
4580	Fonts	antykwatorunska-bold
4581	Fonts	antykwatorunska-bolditalic
4582	Fonts	antykwatorunska-italic
4583	Fonts	antykwatorunska-regular
4584	Fonts	antykwatorunskacond-bold
4585	Fonts	antykwatorunskacond-bolditalic
4586	Fonts	antykwatorunskacond-italic
4587	Fonts	antykwatorunskacond-regular
4588	Fonts	antykwatorunskacondlight-italic
4589	Fonts	antykwatorunskacondlight-regular
4590	Fonts	antykwatorunskacondmed-italic
4591	Fonts	antykwatorunskacondmed-regular
4592	Fonts	antykwatorunskalight-italic
4593	Fonts	antykwatorunskalight-regular
4594	Fonts	antykwatorunskamed-italic
4595	Fonts	antykwatorunskamed-regular
4596	Fonts	apibold
4597	Fonts	apibolit
4598	Fonts	apiitali
4599	Fonts	apiregul
4600	Fonts	archaic-aramaic
4601	Fonts	archaic-cypriot
4602	Fonts	archaic-etruscan
4603	Fonts	archaic-futharc
4604	Fonts	archaic-greek-4th-century-bc
4605	Fonts	archaic-greek-6th-century-bc
4606	Fonts	archaic-linear-b
4607	Fonts	archaic-nabatean
4608	Fonts	archaic-oands-italic
4609	Fonts	archaic-oands
4610	Fonts	archaic-old-persian
4611	Fonts	archaic-phoenician
4612	Fonts	archaic-poor-mans-hieroglyphs
4613	Fonts	archaic-protosemitic
4614	Fonts	archaic-south-arabian
4615	Fonts	archaic-ugaritic-cuneiform
4616	Fonts	arevsans-bold
4617	Fonts	arevsans-boldoblique
4618	Fonts	arevsans-oblique
4619	Fonts	arevsans-roman
4620	Fonts	arthriti
4621	Fonts	ascii
4622	Fonts	aspartam
4623	Fonts	atarismall
4624	Fonts	atarismallbold
4625	Fonts	atarismallcondensed
4626	Fonts	atarismallitalic
4627	Fonts	atarismalllight
4628	Fonts	ataxia
4629	Fonts	ataxiao
4630	Fonts	augie
4631	Fonts	aurelisadf-bold
4632	Fonts	aurelisadf-bolditalic
4633	Fonts	aurelisadf-italic
4634	Fonts	aurelisadf-regular
4635	Fonts	aurelisadfcd-bold
4636	Fonts	aurelisadfcd-bolditalic
4637	Fonts	aurelisadfcd-italic
4638	Fonts	aurelisadfcd-regular
4639	Fonts	aurelisadfdemi-bold
4640	Fonts	aurelisadfdemi-bolditalic
4641	Fonts	aurelisadfex-bold
4642	Fonts	aurelisadfex-bolditalic
4643	Fonts	aurelisadfex-italic
4644	Fonts	aurelisadfex-regular
4645	Fonts	aurelisadfexdemi-bold
4646	Fonts	aurelisadfexdemi-bolditalic
4647	Fonts	aurelisadflt-bold
4648	Fonts	aurelisadflt-bolditalic
4649	Fonts	aurelisadflt-italic
4650	Fonts	aurelisadflt-regular
4651	Fonts	aurelisadfscript-italic
4652	Fonts	aurelisadfscriptno2-italic
4653	Fonts	auriocuskalligraphicus
4654	Fonts	auriocuskalligraphicusbold
4655	Fonts	auriocuskalligraphicusboldoblique
4656	Fonts	auriocuskalligraphicusboldreverseoblique
4657	Fonts	auriocuskalligraphicusoblique
4658	Fonts	auriocuskalligraphicusreverseoblique
4659	Fonts	automati
4660	Fonts	b2sq
4661	Fonts	b2sqol1
4662	Fonts	b2sqol2
4663	Fonts	babeboit
4664	Fonts	babebold
4665	Fonts	babelita
4666	Fonts	babelreg
4667	Fonts	backlash
4668	Fonts	bandless
4669	Fonts	bandmess
4670	Fonts	bandwdth
4671	Fonts	bbm10
4672	Fonts	bbm7
4673	Fonts	bbmbx10
4674	Fonts	bbmbx7
4675	Fonts	bbmbxsl10
4676	Fonts	bbmsl10
4677	Fonts	bbmss10
4678	Fonts	bbold10
4679	Fonts	bbold7
4680	Fonts	bendable
4681	Fonts	berasans-bold
4682	Fonts	berasans-boldoblique
4683	Fonts	berasans-oblique
4684	Fonts	berasans-roman
4685	Fonts	berasansmono-bold
4686	Fonts	berasansmono-boldob
4687	Fonts	berasansmono-oblique
4688	Fonts	berasansmono-roman
4689	Fonts	beraserif-bold
4690	Fonts	beraserif-roman
4691	Fonts	betecknalowercase
4692	Fonts	betecknalowercasebold
4693	Fonts	betecknalowercaseboldcondensed
4694	Fonts	betecknalowercaseitalic
4695	Fonts	betecknalowercaseitaliccondensed
4696	Fonts	bewilder
4697	Fonts	bewildet
4698	Fonts	bin01st
4699	Fonts	binaryt
4700	Fonts	binaryx
4701	Fonts	binchrt
4702	Fonts	binx01s
4703	Fonts	binxchr
4704	Fonts	biolinum_bd-0.4.1ro
4705	Fonts	biolinum_re-0.4.1ro
4706	Fonts	bitbttf
4707	Fonts	bknuckss
4708	Fonts	bknuckst
4709	Fonts	blackoni
4710	Fonts	bleakseg
4711	Fonts	blex
4712	Fonts	bloktilt
4713	Fonts	blonibld
4714	Fonts	blonirex
4715	Fonts	blox2
4716	Fonts	blsy
4717	Fonts	bobcayge
4718	Fonts	bobcaygr
4719	Fonts	bocuma
4720	Fonts	bocumaad
4721	Fonts	bocumaba
4722	Fonts	bocumade
4723	Fonts	bocumang
4724	Fonts	brassknu
4725	Fonts	breipfont
4726	Fonts	brigadom
4727	Fonts	brigadow
4728	Fonts	brushscriptx-italic
4729	Fonts	bumped
4730	Fonts	caladingsclm
4731	Fonts	candystr
4732	Fonts	ccaps
4733	Fonts	ccapshad
4734	Fonts	centuryschl-bold
4735	Fonts	centuryschl-boldital
4736	Fonts	centuryschl-ital
4737	Fonts	centuryschl-roma
4738	Fonts	charissilb
4739	Fonts	charissilbi
4740	Fonts	charissili
4741	Fonts	charissilr
4742	Fonts	charterbt-bold
4743	Fonts	charterbt-bolditalic
4744	Fonts	charterbt-italic
4745	Fonts	charterbt-roman
4746	Fonts	chemrea
4747	Fonts	chemreb
4748	Fonts	cherokee-bold
4749	Fonts	cherokee
4750	Fonts	chintzy
4751	Fonts	chintzys
4752	Fonts	chumbly
4753	Fonts	circulat
4754	Fonts	clasict1
4755	Fonts	clasict2
4756	Fonts	claw1
4757	Fonts	claw2
4758	Fonts	cleavttr
4759	Fonts	cmroman-bold
4760	Fonts	cmroman-bolditalic
4761	Fonts	cmroman-bolditalicosf
4762	Fonts	cmroman-boldsc
4763	Fonts	cmroman-italic
4764	Fonts	cmroman-italicosf
4765	Fonts	cmroman-regular
4766	Fonts	cmroman-regularsc
4767	Fonts	cmromanasian-bold
4768	Fonts	cmromanasian-bolditalic
4769	Fonts	cmromanasian-bolditalicosf
4770	Fonts	cmromanasian-boldsc
4771	Fonts	cmromanasian-italic
4772	Fonts	cmromanasian-italicosf
4773	Fonts	cmromanasian-regular
4774	Fonts	cmromanasian-regularsc
4775	Fonts	cmromancyrillic-bold
4776	Fonts	cmromancyrillic-bolditalic
4777	Fonts	cmromancyrillic-bolditalicosf
4778	Fonts	cmromancyrillic-boldsc
4779	Fonts	cmromancyrillic-italic
4780	Fonts	cmromancyrillic-italicosf
4781	Fonts	cmromancyrillic-regular
4782	Fonts	cmromancyrillic-regularsc
4783	Fonts	cmromangreek-bold
4784	Fonts	cmromangreek-bolditalic
4785	Fonts	cmromangreek-bolditalicosf
4786	Fonts	cmromangreek-boldsc
4787	Fonts	cmromangreek-italic
4788	Fonts	cmromangreek-italicosf
4789	Fonts	cmromangreek-regular
4790	Fonts	cmromangreek-regularsc
4791	Fonts	cmsans-bold
4792	Fonts	cmsans-boldslanted
4793	Fonts	cmsans-regular
4794	Fonts	cmsans-slanted
4795	Fonts	cmsansasian-bold
4796	Fonts	cmsansasian-boldslanted
4797	Fonts	cmsansasian-regular
4798	Fonts	cmsansasian-slanted
4799	Fonts	cmsanscyrillic-bold
4800	Fonts	cmsanscyrillic-boldslanted
4801	Fonts	cmsanscyrillic-regular
4802	Fonts	cmsanscyrillic-slanted
4803	Fonts	cmsansgreek-bold
4804	Fonts	cmsansgreek-boldslanted
4805	Fonts	cmsansgreek-regular
4806	Fonts	cmsansgreek-slanted
4807	Fonts	cmtypewriter-italic
4808	Fonts	cmtypewriter-italicosf
4809	Fonts	cmtypewriter-regular
4810	Fonts	cmtypewriter-regularsc
4811	Fonts	cmtypewriterasian-italic
4812	Fonts	cmtypewriterasian-italicosf
4813	Fonts	cmtypewriterasian-regular
4814	Fonts	cmtypewriterasian-regularsc
4815	Fonts	cmtypewritercyrillic-italic
4816	Fonts	cmtypewritercyrillic-italicosf
4817	Fonts	cmtypewritercyrillic-regular
4818	Fonts	cmtypewritercyrillic-regularsc
4819	Fonts	cmtypewritergreek-italic
4820	Fonts	cmtypewritergreek-italicosf
4821	Fonts	cmtypewritergreek-regular
4822	Fonts	cmtypewritergreek-regularsc
4823	Fonts	codelife
4824	Fonts	collecro
4825	Fonts	collecrs
4826	Fonts	collecto
4827	Fonts	collects
4828	Fonts	combusii
4829	Fonts	combuspl
4830	Fonts	combusti
4831	Fonts	combustt
4832	Fonts	combustw
4833	Fonts	compc1o
4834	Fonts	compc1s
4835	Fonts	compc2o
4836	Fonts	compc2s
4837	Fonts	compc3o
4838	Fonts	compc3s
4839	Fonts	computermodern-sans-bold-oblique
4840	Fonts	condui2i
4841	Fonts	conduit
4842	Fonts	conduit2
4843	Fonts	courier-bold
4844	Fonts	courier-bolditalic
4845	Fonts	courier-italic
4846	Fonts	courier
4847	Fonts	crackdr2
4848	Fonts	crkdownr
4849	Fonts	crkdwno1
4850	Fonts	crkdwno2
4851	Fonts	darkside
4852	Fonts	dashdot
4853	Fonts	dastardl
4854	Fonts	davidclm-bold
4855	Fonts	davidclm-medium
4856	Fonts	davidclm-mediumitalic
4857	Fonts	dblayer1
4858	Fonts	dblayer2
4859	Fonts	dblayer3
4860	Fonts	dblayer4
4861	Fonts	dblbogey
4862	Fonts	dbsilbb
4863	Fonts	dbsilbc
4864	Fonts	dbsilbo
4865	Fonts	dbsilbr
4866	Fonts	dbsillb
4867	Fonts	dbsillc
4868	Fonts	dbsillo
4869	Fonts	dbsillr
4870	Fonts	decrepit
4871	Fonts	dejavusans-bold
4872	Fonts	dejavusans-boldoblique
4873	Fonts	dejavusans-extralight
4874	Fonts	dejavusans-oblique
4875	Fonts	dejavusans
4876	Fonts	dejavusanscondensed-bold
4877	Fonts	dejavusanscondensed-boldoblique
4878	Fonts	dejavusanscondensed-oblique
4879	Fonts	dejavusanscondensed
4880	Fonts	dejavusansmono-bold
4881	Fonts	dejavusansmono-boldoblique
4882	Fonts	dejavusansmono-oblique
4883	Fonts	dejavusansmono
4884	Fonts	dejavuserif-bold
4885	Fonts	dejavuserif-bolditalic
4886	Fonts	dejavuserif-italic
4887	Fonts	dejavuserif
4888	Fonts	dejavuserifcondensed-bold
4889	Fonts	dejavuserifcondensed-bolditalic
4890	Fonts	dejavuserifcondensed-italic
4891	Fonts	dejavuserifcondensed
4892	Fonts	delphine
4893	Fonts	dented
4894	Fonts	dephun2
4895	Fonts	detonate
4896	Fonts	dictsym
4897	Fonts	dingbats
4898	Fonts	discorda
4899	Fonts	dkg
4900	Fonts	dkgbd
4901	Fonts	dkgbi
4902	Fonts	dkgit
4903	Fonts	doulossilr
4904	Fonts	draggle
4905	Fonts	draggleo
4906	Fonts	drugulinclm-bold
4907	Fonts	drugulinclm-bolditalic
4908	Fonts	dsrom10
4909	Fonts	dsrom12
4910	Fonts	dsrom8
4911	Fonts	dsss10
4912	Fonts	dsss12
4913	Fonts	dsss8
4914	Fonts	dynamic
4915	Fonts	dyphusio
4916	Fonts	dystorqu
4917	Fonts	ecliptic
4918	Fonts	editundo
4919	Fonts	edundot
4920	Fonts	edunline
4921	Fonts	elegbold
4922	Fonts	elegital
4923	Fonts	elleboli
4924	Fonts	ellenbold
4925	Fonts	ellenike
4926	Fonts	ellenita
4927	Fonts	elliniaclm-bold
4928	Fonts	elliniaclm-bolditalic
4929	Fonts	elliniaclm-light
4930	Fonts	elliniaclm-lightitalic
4931	Fonts	elsewhe2
4932	Fonts	elsewher
4933	Fonts	embosst1
4934	Fonts	embosst2
4935	Fonts	embosst3
4936	Fonts	emerita_latina
4937	Fonts	encappln
4938	Fonts	encapsul
4939	Fonts	engadget
4940	Fonts	entangle
4941	Fonts	enthuse
4942	Fonts	enthuses
4943	Fonts	entlayra
4944	Fonts	entlayrb
4945	Fonts	entplain
4946	Fonts	eocc10
4947	Fonts	eorm10
4948	Fonts	eosl10
4949	Fonts	eoti10
4950	Fonts	essays1743-bold
4951	Fonts	essays1743-bolditalic
4952	Fonts	essays1743-italic
4953	Fonts	essays1743
4954	Fonts	euphor3d
4955	Fonts	euphoric
4956	Fonts	europeancomputermodern-bold10pt
4957	Fonts	europeancomputermodern-boldextended10pt
4958	Fonts	europeancomputermodern-boldextended12pt
4959	Fonts	europeancomputermodern-boldextended17pt
4960	Fonts	europeancomputermodern-boldextended7pt
4961	Fonts	europeancomputermodern-demibold10pt
4962	Fonts	europeancomputermodern-italicbold10pt
4963	Fonts	europeancomputermodern-italicregular10pt
4964	Fonts	europeancomputermodern-italicregular12pt
4965	Fonts	europeancomputermodern-italicregular7pt
4966	Fonts	europeancomputermodern-obliqueregular10pt
4967	Fonts	europeancomputermodern-obliqueregular12pt
4968	Fonts	europeancomputermodern-obliqueregular7pt
4969	Fonts	europeancomputermodern-regular10pt
4970	Fonts	europeancomputermodern-regularcondensed10pt
4971	Fonts	europeancomputermodern-regularextended10pt
4972	Fonts	europeancomputermodern-regularextended12pt
4973	Fonts	europeancomputermodern-regularextended17pt
4974	Fonts	europeancomputermodern-romanbold10pt
4975	Fonts	europeancomputermodern-romanregular10pt
4976	Fonts	europeancomputermodern-romanregular12pt
4977	Fonts	europeancomputermodern-romanregular17pt
4978	Fonts	europeancomputermodern-romanregular5pt
4979	Fonts	europeancomputermodern-romanregular7pt
4980	Fonts	europeancomputermodern-smallcapsregular10pt
4981	Fonts	europeancomputermodern-smallcapsregular12pt
4982	Fonts	europeancomputermodern-smallcapsregular7pt
4983	Fonts	europeancomputermodernsans-demiboldcondensed10pt
4984	Fonts	europeancomputermodernsans-regular10pt
4985	Fonts	europeancomputermodernsans-regular12pt
4986	Fonts	europeancomputermodernsans-regular7pt
4987	Fonts	europeancomputermoderntypewriter-regular10pt
4988	Fonts	europeancomputermoderntypewriter-regular12pt
4989	Fonts	europeancomputermoderntypewriter-regular7pt
4990	Fonts	euxm10
4991	Fonts	euxm7
4992	Fonts	exagger8
4993	Fonts	extracti
4994	Fonts	f500
4995	Fonts	falsepos
4996	Fonts	falsposr
4997	Fonts	fascii
4998	Fonts	fasciicr
4999	Fonts	fasciisc
5000	Fonts	fasciism
5001	Fonts	fasciitw
5002	Fonts	fauxsnow
5003	Fonts	fbsbltc
5004	Fonts	fbsbltc2
5005	Fonts	feta-alphabet11
5006	Fonts	feta-alphabet13
5007	Fonts	feta-alphabet14
5008	Fonts	feta-alphabet16
5009	Fonts	feta-alphabet18
5010	Fonts	feta-alphabet20
5011	Fonts	feta-alphabet23
5012	Fonts	feta-alphabet26
5013	Fonts	feta-braces-a
5014	Fonts	feta-braces-b
5015	Fonts	feta-braces-c
5016	Fonts	feta-braces-d
5017	Fonts	feta-braces-e
5018	Fonts	feta-braces-f
5019	Fonts	feta-braces-g
5020	Fonts	feta-braces-h
5021	Fonts	feta-braces-i
5022	Fonts	feta11
5023	Fonts	feta13
5024	Fonts	feta14
5025	Fonts	feta16
5026	Fonts	feta18
5027	Fonts	feta20
5028	Fonts	feta23
5029	Fonts	feta26
5030	Fonts	fidgety
5031	Fonts	flipside
5032	Fonts	foekfont
5033	Fonts	font
5034	Fonts	forcible
5035	Fonts	fourier-math-blackboard
5036	Fonts	fourier-math-cal
5037	Fonts	fourier-math-extension
5038	Fonts	fourier-math-letters-bold-italic
5039	Fonts	fourier-math-letters-bold
5040	Fonts	fourier-math-letters-italic
5041	Fonts	fourier-math-letters
5042	Fonts	fourier-math-symbols
5043	Fonts	fourier-orns
5044	Fonts	frankruehlclm-bold
5045	Fonts	frankruehlclm-boldoblique
5046	Fonts	frankruehlclm-medium
5047	Fonts	frankruehlclm-mediumoblique
5048	Fonts	freaktur
5049	Fonts	freeeuro
5050	Fonts	freemono
5051	Fonts	freemonobold
5052	Fonts	freemonoboldoblique
5053	Fonts	freemonooblique
5054	Fonts	freesans
5055	Fonts	freesansbold
5056	Fonts	freesansboldoblique
5057	Fonts	freesansoblique
5058	Fonts	freeserif
5059	Fonts	freeserifbold
5060	Fonts	freeserifbolditalic
5061	Fonts	freeserifitalic
5062	Fonts	frizzed
5063	Fonts	fullcomp
5064	Fonts	galapogo
5065	Fonts	galsilb
5066	Fonts	galsilr
5067	Fonts	galvaniz
5068	Fonts	gaposiso
5069	Fonts	gaposiss
5070	Fonts	gasping
5071	Fonts	gather
5072	Fonts	gathrgap
5073	Fonts	genai102
5074	Fonts	genar102
5075	Fonts	genbasb
5076	Fonts	genbasbi
5077	Fonts	genbasi
5078	Fonts	genbasr
5079	Fonts	genbkbasb
5080	Fonts	genbkbasbi
5081	Fonts	genbkbasi
5082	Fonts	genbkbasr
5083	Fonts	geni102
5084	Fonts	genotyph
5085	Fonts	genotyps
5086	Fonts	genotyrh
5087	Fonts	genotyrs
5088	Fonts	genr102
5089	Fonts	gesture
5090	Fonts	gestures
5091	Fonts	gesturet
5092	Fonts	gesturts
5093	Fonts	gilliusadf-bold
5094	Fonts	gilliusadf-bolditalic
5095	Fonts	gilliusadf-italic
5096	Fonts	gilliusadf-regular
5097	Fonts	gilliusadfcd-bold
5098	Fonts	gilliusadfcd-bolditalic
5099	Fonts	gilliusadfcd-italic
5100	Fonts	gilliusadfcd-regular
5101	Fonts	gilliusadfno2-bold
5102	Fonts	gilliusadfno2-bolditalic
5103	Fonts	gilliusadfno2-italic
5104	Fonts	gilliusadfno2-regular
5105	Fonts	gilliusadfno2cd-bold
5106	Fonts	gilliusadfno2cd-bolditalic
5107	Fonts	gilliusadfno2cd-italic
5108	Fonts	gilliusadfno2cd-regular
5109	Fonts	gosebmp2
5110	Fonts	gosebmps
5111	Fonts	goudybookletter1911
5112	Fonts	goudybookletter1911bold
5113	Fonts	goudybookletter1911boldcondensed
5114	Fonts	goudybookletter1911condensed
5115	Fonts	goudybookletter1911italic
5116	Fonts	goudybookletter1911italiccondensed
5117	Fonts	goudybookletter1911light
5118	Fonts	goudybookletter1911lightcondensed
5119	Fonts	gr8higts
5120	Fonts	granular
5121	Fonts	grapple
5122	Fonts	graveyrd
5123	Fonts	graviseg
5124	Fonts	gravitat
5125	Fonts	graze
5126	Fonts	grmn10
5127	Fonts	grotesq
5128	Fonts	grudge
5129	Fonts	grudge2
5130	Fonts	grxn10
5131	Fonts	gyneric
5132	Fonts	gyneric3
5133	Fonts	gyroresh
5134	Fonts	gyrose
5135	Fonts	gyrosesq
5136	Fonts	hackslsh
5137	Fonts	hairball
5138	Fonts	handmedo
5139	Fonts	handmeds
5140	Fonts	hassle
5141	Fonts	hbevel
5142	Fonts	hdmaker
5143	Fonts	hearts
5144	Fonts	hfbr10
5145	Fonts	hfbr17
5146	Fonts	hfbr8
5147	Fonts	hfbr9
5148	Fonts	hfbras10
5149	Fonts	hfbras8
5150	Fonts	hfbras9
5151	Fonts	hfbrbs10
5152	Fonts	hfbrbs8
5153	Fonts	hfbrbs9
5154	Fonts	hfbrbx10
5155	Fonts	hfbrmb10
5156	Fonts	hfbrmi10
5157	Fonts	hfbrmi8
5158	Fonts	hfbrmi9
5159	Fonts	hfbrsl10
5160	Fonts	hfbrsl17
5161	Fonts	hfbrsl8
5162	Fonts	hfbrsl9
5163	Fonts	hfbrsy10
5164	Fonts	hfbrsy8
5165	Fonts	hfbrsy9
5166	Fonts	hfsltl10
5167	Fonts	hftl10
5168	Fonts	hillock
5169	Fonts	homespun
5170	Fonts	hyde
5171	Fonts	hyperion
5172	Fonts	ikariusadf-bold
5173	Fonts	ikariusadf-bolditalic
5174	Fonts	ikariusadf-italic
5175	Fonts	ikariusadf-regular
5176	Fonts	ikariusadfno2-bold
5177	Fonts	ikariusadfno2-bolditalic
5178	Fonts	ikariusadfno2-italic
5179	Fonts	ikariusadfno2-regular
5180	Fonts	ilits
5181	Fonts	imposs
5182	Fonts	inertia
5183	Fonts	inevitab
5184	Fonts	inkswipe
5185	Fonts	inktank
5186	Fonts	intersc
5187	Fonts	intersec
5188	Fonts	interso
5189	Fonts	inuit-bold-oblique
5190	Fonts	inuit-bold
5191	Fonts	inuit-oblique
5192	Fonts	inuit
5193	Fonts	ipabold
5194	Fonts	ipabolit
5195	Fonts	ipaitali
5196	Fonts	iparegul
5197	Fonts	irritate
5198	Fonts	isabella
5199	Fonts	iwona-bold
5200	Fonts	iwona-bolditalic
5201	Fonts	iwona-italic
5202	Fonts	iwona-regular
5203	Fonts	iwonacond-bold
5204	Fonts	iwonacond-bolditalic
5205	Fonts	iwonacond-italic
5206	Fonts	iwonacond-regular
5207	Fonts	iwonacondheavy-italic
5208	Fonts	iwonacondheavy-regular
5209	Fonts	iwonacondlight-italic
5210	Fonts	iwonacondlight-regular
5211	Fonts	iwonacondmedium-italic
5212	Fonts	iwonacondmedium-regular
5213	Fonts	iwonaheavy-italic
5214	Fonts	iwonaheavy-regular
5215	Fonts	iwonalight-italic
5216	Fonts	iwonalight-regular
5217	Fonts	iwonamedium-italic
5218	Fonts	iwonamedium-regular
5219	Fonts	jagged
5220	Fonts	janaskrivana
5221	Fonts	janaskrivanabold
5222	Fonts	janaskrivanaboldoblique
5223	Fonts	janaskrivanaboldreverseoblique
5224	Fonts	janaskrivanaoblique
5225	Fonts	janaskrivanareverseoblique
5226	Fonts	janken
5227	Fonts	jara
5228	Fonts	jara_bold-it
5229	Fonts	jara_bold
5230	Fonts	jara_it
5231	Fonts	jargon
5232	Fonts	jasper
5233	Fonts	jaspers
5234	Fonts	jawbhard
5235	Fonts	jawbreak
5236	Fonts	jawbrko1
5237	Fonts	jawbrko2
5238	Fonts	jekyll
5239	Fonts	jeopardi
5240	Fonts	jeopardt
5241	Fonts	jmacscrl
5242	Fonts	joltcaff
5243	Fonts	junicode-bold
5244	Fonts	junicode-boldcondensed
5245	Fonts	junicode-bolditalic
5246	Fonts	junicode-bolditaliccondensed
5247	Fonts	junicode-italic
5248	Fonts	junicode-italiccondensed
5249	Fonts	junicode-regular
5250	Fonts	junicode-regularcondensed
5251	Fonts	jupiterc
5252	Fonts	jurabook
5253	Fonts	jurademibold
5254	Fonts	juralight
5255	Fonts	juramedium
5256	Fonts	kacstart
5257	Fonts	kacstbook
5258	Fonts	kacstdecorative
5259	Fonts	kacstdigital
5260	Fonts	kacstfarsi
5261	Fonts	kacstletter
5262	Fonts	kacstnaskh
5263	Fonts	kacstoffice
5264	Fonts	kacstone
5265	Fonts	kacstpen
5266	Fonts	kacstposter
5267	Fonts	kacstqurn
5268	Fonts	kacstscreen
5269	Fonts	kacsttitle
5270	Fonts	kacsttitlel
5271	Fonts	kaliberr
5272	Fonts	kalibers
5273	Fonts	kaliberx
5274	Fonts	kataacti
5275	Fonts	katainac
5276	Fonts	keyrialt
5277	Fonts	keyridge
5278	Fonts	kickflip
5279	Fonts	kinkaid
5280	Fonts	kirbyss
5281	Fonts	knot
5282	Fonts	konatu
5283	Fonts	konatutohaba
5284	Fonts	konecto1
5285	Fonts	konecto2
5286	Fonts	konector
5287	Fonts	koneerie
5288	Fonts	kurvatur
5289	Fonts	labi1000
5290	Fonts	labl1000
5291	Fonts	labx1000
5292	Fonts	labx1700
5293	Fonts	lacc1000
5294	Fonts	ladh1000
5295	Fonts	lakeshor
5296	Fonts	lamebrai
5297	Fonts	larkspur
5298	Fonts	larm1000
5299	Fonts	larm700
5300	Fonts	lasi1000
5301	Fonts	lasl1000
5302	Fonts	laso1000
5303	Fonts	lass1000
5304	Fonts	last1000
5305	Fonts	lasx1000
5306	Fonts	lati1000
5307	Fonts	latt1000
5308	Fonts	laxc1000
5309	Fonts	lethargi
5310	Fonts	liberationmono-bold
5311	Fonts	liberationmono-bolditalic
5312	Fonts	liberationmono-italic
5313	Fonts	liberationmono-regular
5314	Fonts	liberationsans-bold
5315	Fonts	liberationsans-bolditalic
5316	Fonts	liberationsans-italic
5317	Fonts	liberationsans-regular
5318	Fonts	liberationserif-bold
5319	Fonts	liberationserif-bolditalic
5320	Fonts	liberationserif-italic
5321	Fonts	liberationserif-regular
5322	Fonts	licostrg
5323	Fonts	lightout
5324	Fonts	lineara
5325	Fonts	linearacmplxsigns
5326	Fonts	lineding
5327	Fonts	linlibertine_bd
5328	Fonts	linlibertine_bi
5329	Fonts	linlibertine_it
5330	Fonts	linlibertine_re
5331	Fonts	linlibertinec_re
5332	Fonts	lmmathextension10-regular
5333	Fonts	lmmathitalic10-bolditalic
5334	Fonts	lmmathitalic10-italic
5335	Fonts	lmmathitalic12-italic
5336	Fonts	lmmathitalic5-bolditalic
5337	Fonts	lmmathitalic5-italic
5338	Fonts	lmmathitalic6-italic
5339	Fonts	lmmathitalic7-bolditalic
5340	Fonts	lmmathitalic7-italic
5341	Fonts	lmmathitalic8-italic
5342	Fonts	lmmathitalic9-italic
5343	Fonts	lmmathsymbols10-bolditalic
5344	Fonts	lmmathsymbols10-italic
5345	Fonts	lmmathsymbols5-bolditalic
5346	Fonts	lmmathsymbols5-italic
5347	Fonts	lmmathsymbols6-italic
5348	Fonts	lmmathsymbols7-bolditalic
5349	Fonts	lmmathsymbols7-italic
5350	Fonts	lmmathsymbols8-italic
5351	Fonts	lmmathsymbols9-italic
5352	Fonts	lmroman10-bold
5353	Fonts	lmroman10-bolditalic
5354	Fonts	lmroman10-boldoblique
5355	Fonts	lmroman10-capsoblique
5356	Fonts	lmroman10-capsregular
5357	Fonts	lmroman10-demi
5358	Fonts	lmroman10-demioblique
5359	Fonts	lmroman10-dunhill
5360	Fonts	lmroman10-dunhilloblique
5361	Fonts	lmroman10-italic
5362	Fonts	lmroman10-oblique
5363	Fonts	lmroman10-regular
5364	Fonts	lmroman10-unslanted
5365	Fonts	lmroman12-bold
5366	Fonts	lmroman12-italic
5367	Fonts	lmroman12-oblique
5368	Fonts	lmroman12-regular
5369	Fonts	lmroman17-oblique
5370	Fonts	lmroman17-regular
5371	Fonts	lmroman5-bold
5372	Fonts	lmroman5-regular
5373	Fonts	lmroman6-bold
5374	Fonts	lmroman6-regular
5375	Fonts	lmroman7-bold
5376	Fonts	lmroman7-italic
5377	Fonts	lmroman7-regular
5378	Fonts	lmroman8-bold
5379	Fonts	lmroman8-italic
5380	Fonts	lmroman8-oblique
5381	Fonts	lmroman8-regular
5382	Fonts	lmroman9-bold
5383	Fonts	lmroman9-italic
5384	Fonts	lmroman9-oblique
5385	Fonts	lmroman9-regular
5386	Fonts	lmsans10-bold
5387	Fonts	lmsans10-boldoblique
5388	Fonts	lmsans10-demicondensed
5389	Fonts	lmsans10-demicondensedoblique
5390	Fonts	lmsans10-oblique
5391	Fonts	lmsans10-regular
5392	Fonts	lmsans12-oblique
5393	Fonts	lmsans12-regular
5394	Fonts	lmsans17-oblique
5395	Fonts	lmsans17-regular
5396	Fonts	lmsans8-oblique
5397	Fonts	lmsans8-regular
5398	Fonts	lmsans9-oblique
5399	Fonts	lmsans9-regular
5400	Fonts	lmsansquotation8-bold
5401	Fonts	lmsansquotation8-boldoblique
5402	Fonts	lmsansquotation8-oblique
5403	Fonts	lmsansquotation8-regular
5404	Fonts	lmtypewriter10-capsoblique
5405	Fonts	lmtypewriter10-capsregular
5406	Fonts	lmtypewriter10-dark
5407	Fonts	lmtypewriter10-darkoblique
5408	Fonts	lmtypewriter10-italic
5409	Fonts	lmtypewriter10-light
5410	Fonts	lmtypewriter10-lightcondensed
5411	Fonts	lmtypewriter10-lightcondensedoblique
5412	Fonts	lmtypewriter10-lightoblique
5413	Fonts	lmtypewriter10-oblique
5414	Fonts	lmtypewriter10-regular
5415	Fonts	lmtypewriter12-regular
5416	Fonts	lmtypewriter8-regular
5417	Fonts	lmtypewriter9-regular
5418	Fonts	lmtypewritervarwd10-dark
5419	Fonts	lmtypewritervarwd10-darkoblique
5420	Fonts	lmtypewritervarwd10-light
5421	Fonts	lmtypewritervarwd10-lightoblique
5422	Fonts	lmtypewritervarwd10-oblique
5423	Fonts	lmtypewritervarwd10-regular
5424	Fonts	loopy
5425	Fonts	lowdown
5426	Fonts	lucid
5427	Fonts	lucid2
5428	Fonts	lucid2o
5429	Fonts	lucido
5430	Fonts	lukassvatba
5431	Fonts	lukassvatbabold
5432	Fonts	lukassvatbaboldoblique
5433	Fonts	lukassvatbaboldreverseoblique
5434	Fonts	lukassvatbaoblique
5435	Fonts	lukassvatbareverseoblique
5436	Fonts	lyneous
5437	Fonts	lyneousl
5438	Fonts	lynx
5439	Fonts	macropsi
5440	Fonts	madscrwl
5441	Fonts	marvosym
5442	Fonts	mgopencanonicabold
5443	Fonts	mgopencanonicabolditalic
5444	Fonts	mgopencanonicaitalic
5445	Fonts	mgopencanonicaregular
5446	Fonts	mgopencosmeticabold
5447	Fonts	mgopencosmeticaboldoblique
5448	Fonts	mgopencosmeticaoblique
5449	Fonts	mgopencosmeticaregular
5450	Fonts	mgopenmodatabold
5451	Fonts	mgopenmodataboldoblique
5452	Fonts	mgopenmodataoblique
5453	Fonts	mgopenmodataregular
5454	Fonts	mgopenmodernabold
5455	Fonts	mgopenmodernaboldoblique
5456	Fonts	mgopenmodernaoblique
5457	Fonts	mgopenmodernaregular
5458	Fonts	mima4x4i
5459	Fonts	mima4x4o
5460	Fonts	mimaalt1
5461	Fonts	mimaalt2
5462	Fonts	mimafuse
5463	Fonts	mincer
5464	Fonts	minikott
5465	Fonts	minikstt
5466	Fonts	miriamclm-bold
5467	Fonts	miriamclm-book
5468	Fonts	miriammonoclm-bold
5469	Fonts	miriammonoclm-boldoblique
5470	Fonts	miriammonoclm-book
5471	Fonts	miriammonoclm-bookoblique
5472	Fonts	mishmash
5473	Fonts	mobilize
5474	Fonts	monkphon
5475	Fonts	moronmis
5476	Fonts	mplus-1c-black
5477	Fonts	mplus-1c-bold
5478	Fonts	mplus-1c-heavy
5479	Fonts	mplus-1c-light
5480	Fonts	mplus-1c-medium
5481	Fonts	mplus-1c-regular
5482	Fonts	mplus-1c-thin
5483	Fonts	mplus-1m-bold
5484	Fonts	mplus-1m-light
5485	Fonts	mplus-1m-medium
5486	Fonts	mplus-1m-regular
5487	Fonts	mplus-1m-thin
5488	Fonts	mplus-1mn-bold
5489	Fonts	mplus-1mn-light
5490	Fonts	mplus-1mn-medium
5491	Fonts	mplus-1mn-regular
5492	Fonts	mplus-1mn-thin
5493	Fonts	mplus-1p-black
5494	Fonts	mplus-1p-bold
5495	Fonts	mplus-1p-heavy
5496	Fonts	mplus-1p-light
5497	Fonts	mplus-1p-medium
5498	Fonts	mplus-1p-regular
5499	Fonts	mplus-1p-thin
5500	Fonts	mplus-2c-black
5501	Fonts	mplus-2c-bold
5502	Fonts	mplus-2c-heavy
5503	Fonts	mplus-2c-light
5504	Fonts	mplus-2c-medium
5505	Fonts	mplus-2c-regular
5506	Fonts	mplus-2c-thin
5507	Fonts	mplus-2m-bold
5508	Fonts	mplus-2m-light
5509	Fonts	mplus-2m-medium
5510	Fonts	mplus-2m-regular
5511	Fonts	mplus-2m-thin
5512	Fonts	mplus-2p-black
5513	Fonts	mplus-2p-bold
5514	Fonts	mplus-2p-heavy
5515	Fonts	mplus-2p-light
5516	Fonts	mplus-2p-medium
5517	Fonts	mplus-2p-regular
5518	Fonts	mplus-2p-thin
5519	Fonts	mry_kacstqurn
5520	Fonts	mysteron
5521	Fonts	nachlieliclm-bold
5522	Fonts	nachlieliclm-boldoblique
5523	Fonts	nachlieliclm-light
5524	Fonts	nachlieliclm-lightoblique
5525	Fonts	nanosecw
5526	Fonts	naughts
5527	Fonts	neural
5528	Fonts	neuralol
5529	Fonts	nimbusmonl-bold
5530	Fonts	nimbusmonl-boldobli
5531	Fonts	nimbusmonl-regu
5532	Fonts	nimbusmonl-reguobli
5533	Fonts	nimbusromno9l-medi
5534	Fonts	nimbusromno9l-mediital
5535	Fonts	nimbusromno9l-regu
5536	Fonts	nimbusromno9l-reguital
5537	Fonts	nimbussanl-bold
5538	Fonts	nimbussanl-boldcond
5539	Fonts	nimbussanl-boldcondital
5540	Fonts	nimbussanl-boldital
5541	Fonts	nimbussanl-regu
5542	Fonts	nimbussanl-regucond
5543	Fonts	nimbussanl-regucondital
5544	Fonts	nimbussanl-reguital
5545	Fonts	nominal
5546	Fonts	nostalgi
5547	Fonts	notqr
5548	Fonts	nsecthck
5549	Fonts	nsecthin
5550	Fonts	nucleus
5551	Fonts	numskull
5552	Fonts	nymonak
5553	Fonts	obloquyo
5554	Fonts	obloquys
5555	Fonts	obstacle
5556	Fonts	obstacll
5557	Fonts	ocra
5558	Fonts	ocrabold
5559	Fonts	ocracondensed
5560	Fonts	ocraitalic
5561	Fonts	ocralight
5562	Fonts	offkiltl
5563	Fonts	offkiltr
5564	Fonts	okolaks
5565	Fonts	okolaksbold
5566	Fonts	okolaksboldcondensed
5567	Fonts	okolaksboldcondensedcondensed
5568	Fonts	okolakscondensed
5569	Fonts	okolakscondensedcondensed
5570	Fonts	okolaksitalic
5571	Fonts	okolaksitaliccondensed
5572	Fonts	okolaksitaliccondensedcondensed
5573	Fonts	omegadingbats
5574	Fonts	omegasanstifinagh
5575	Fonts	omegaserifarabicone-bold
5576	Fonts	omegaserifarabicone
5577	Fonts	omegaserifarabicthree-bold
5578	Fonts	omegaserifarabicthree
5579	Fonts	omegaserifarabictwo-bold
5580	Fonts	omegaserifarabictwo
5581	Fonts	omegaserifarmenian
5582	Fonts	omegaserifcommon-bold
5583	Fonts	omegaserifcommon-bolditalic
5584	Fonts	omegaserifcommon-italic
5585	Fonts	omegaserifcommon
5586	Fonts	omegaserifcyrillic-bold
5587	Fonts	omegaserifcyrillic-italic
5588	Fonts	omegaserifcyrillic
5589	Fonts	omegaserifcyrillicextended
5590	Fonts	omegaserifgreek-bold
5591	Fonts	omegaserifgreek-bolditalic
5592	Fonts	omegaserifgreek-italic
5593	Fonts	omegaserifgreek
5594	Fonts	omegaserifhebrew
5595	Fonts	omegaserifipa
5596	Fonts	omegaseriflatin-bold
5597	Fonts	omegaseriflatin-bolditalic
5598	Fonts	omegaseriflatin-italic
5599	Fonts	omegaseriflatin
5600	Fonts	omegaseriftifinagh
5601	Fonts	opendinschriftenengshrift
5602	Fonts	opens___
5603	Fonts	opiated
5604	Fonts	orbicula
5605	Fonts	outersid
5606	Fonts	overhead
5607	Fonts	padauk-bold
5608	Fonts	padauk
5609	Fonts	parmesan11
5610	Fonts	parmesan13
5611	Fonts	parmesan14
5612	Fonts	parmesan16
5613	Fonts	parmesan18
5614	Fonts	parmesan20
5615	Fonts	parmesan23
5616	Fonts	parmesan26
5617	Fonts	pazomath-bold
5618	Fonts	pazomath-bolditalic
5619	Fonts	pazomath-italic
5620	Fonts	pazomath
5621	Fonts	pazomathblackboardbold
5622	Fonts	pdark
5623	Fonts	persuasi
5624	Fonts	phaistos
5625	Fonts	phorfeir
5626	Fonts	phorfeis
5627	Fonts	pincers
5628	Fonts	pindown
5629	Fonts	pindownp
5630	Fonts	pindwnx
5631	Fonts	pindwnxp
5632	Fonts	pixlkrud
5633	Fonts	plasdrip
5634	Fonts	plasdrpe
5635	Fonts	pneumati
5636	Fonts	pneutall
5637	Fonts	pneuwide
5638	Fonts	powdwrk5
5639	Fonts	pseudo
5640	Fonts	pxbex
5641	Fonts	pxbexa
5642	Fonts	pxbmia
5643	Fonts	pxbsy
5644	Fonts	pxbsya
5645	Fonts	pxbsyb
5646	Fonts	pxbsyc
5647	Fonts	pxex
5648	Fonts	pxexa
5649	Fonts	pxmia
5650	Fonts	pxsy
5651	Fonts	pxsya
5652	Fonts	pxsyb
5653	Fonts	pxsyc
5654	Fonts	qbicle1
5655	Fonts	qbicle2
5656	Fonts	qbicle3
5657	Fonts	qbicle4
5658	Fonts	qlumpy
5659	Fonts	qlumpysh
5660	Fonts	quacksal
5661	Fonts	quadrcal
5662	Fonts	quadrtic
5663	Fonts	quandary
5664	Fonts	quantfh
5665	Fonts	quantflt
5666	Fonts	quantrh
5667	Fonts	quantrnd
5668	Fonts	quanttap
5669	Fonts	quaranti
5670	Fonts	quarthck
5671	Fonts	quarthin
5672	Fonts	queasy
5673	Fonts	queasyol
5674	Fonts	quercus
5675	Fonts	quercus_bold
5676	Fonts	quercus_bold_it
5677	Fonts	quercus_it
5678	Fonts	quillexo
5679	Fonts	quillexs
5680	Fonts	radissans-medium
5681	Fonts	rambling
5682	Fonts	ravaged2
5683	Fonts	ravcater
5684	Fonts	raydiat2
5685	Fonts	rblmi
5686	Fonts	reason
5687	Fonts	reasonsh
5688	Fonts	redundan
5689	Fonts	regenera
5690	Fonts	registry
5691	Fonts	rehearsc
5692	Fonts	rehearso
5693	Fonts	rehearsp
5694	Fonts	relapse
5695	Fonts	revert
5696	Fonts	revertro
5697	Fonts	rotund
5698	Fonts	rotundo
5699	Fonts	roughday
5700	Fonts	rpcxb
5701	Fonts	rpcxbi
5702	Fonts	rpcxi
5703	Fonts	rpcxr
5704	Fonts	rpxb
5705	Fonts	rpxbi
5706	Fonts	rpxbmi
5707	Fonts	rpxbsc
5708	Fonts	rpxi
5709	Fonts	rpxmi
5710	Fonts	rpxr
5711	Fonts	rpxsc
5712	Fonts	rsfs10
5713	Fonts	rsfs5
5714	Fonts	rsfs7
5715	Fonts	rtcxb
5716	Fonts	rtcxbi
5717	Fonts	rtcxbss
5718	Fonts	rtcxi
5719	Fonts	rtcxr
5720	Fonts	rtcxss
5721	Fonts	rtxb
5722	Fonts	rtxbi
5723	Fonts	rtxbmi
5724	Fonts	rtxbsc
5725	Fonts	rtxbss
5726	Fonts	rtxbsssc
5727	Fonts	rtxi
5728	Fonts	rtxmi
5729	Fonts	rtxr
5730	Fonts	rtxsc
5731	Fonts	rtxss
5732	Fonts	rtxsssc
5733	Fonts	rufscript010
5734	Fonts	ryuker
5735	Fonts	sarcasti
5736	Fonts	saunder
5737	Fonts	scalines
5738	Fonts	scheherazaderegot
5739	Fonts	sclnmaze
5740	Fonts	sequence
5741	Fonts	setbackt
5742	Fonts	sideways
5743	Fonts	sileot
5744	Fonts	sileotsr
5745	Fonts	silyi
5746	Fonts	simplto2
5747	Fonts	skullcap
5748	Fonts	slender
5749	Fonts	slenderw
5750	Fonts	slenmini
5751	Fonts	slenstub
5752	Fonts	snailets
5753	Fonts	snb
5754	Fonts	snbi
5755	Fonts	sni
5756	Fonts	snr
5757	Fonts	spaciouo
5758	Fonts	spacious
5759	Fonts	spastic2
5760	Fonts	spheroid
5761	Fonts	spheroix
5762	Fonts	splatz2
5763	Fonts	sqroute
5764	Fonts	stagnati
5765	Fonts	standardsyml
5766	Fonts	stevehand
5767	Fonts	strande2
5768	Fonts	subgamefont
5769	Fonts	supragc
5770	Fonts	supragl
5771	Fonts	swirled2
5772	Fonts	switzeraadf-demibold
5773	Fonts	switzeraadf-demibolditalic
5774	Fonts	switzeraadf-italic
5775	Fonts	switzeraadf-regular
5776	Fonts	switzeraadfbold-italic
5777	Fonts	switzeraadfbold
5778	Fonts	switzeraadfcd-bold
5779	Fonts	switzeraadfcd-bolditalic
5780	Fonts	switzeraadfcd-italic
5781	Fonts	switzeraadfcd-regular
5782	Fonts	switzeraadfex-bold
5783	Fonts	switzeraadfex-bolditalic
5784	Fonts	switzeraadfex-italic
5785	Fonts	switzeraadfex-regular
5786	Fonts	switzeraadfextrabold-italic
5787	Fonts	switzeraadfextrabold
5788	Fonts	switzeraadflight-bold
5789	Fonts	switzeraadflight-bolditalic
5790	Fonts	switzeraadflight-italic
5791	Fonts	switzeraadflight-regular
5792	Fonts	switzeraadflightcd-bold
5793	Fonts	switzeraadflightcd-bolditalic
5794	Fonts	switzeraadflightcd-italic
5795	Fonts	switzeraadflightcd-regular
5796	Fonts	switzeraadfreverted-bold
5797	Fonts	switzeraadfreverted-regular
5798	Fonts	symmetry
5799	Fonts	syndrome
5800	Fonts	syntheti
5801	Fonts	syracuse
5802	Fonts	t1xbtt
5803	Fonts	t1xbttsc
5804	Fonts	t1xtt
5805	Fonts	t1xttsc
5806	Fonts	tapir
5807	Fonts	tcbi10
5808	Fonts	tcbx10
5809	Fonts	tcrm10
5810	Fonts	tcsl10
5811	Fonts	tcss10
5812	Fonts	tcsx10
5813	Fonts	tctt10
5814	Fonts	tcxbtt
5815	Fonts	tcxtt
5816	Fonts	tearful
5817	Fonts	techniqo
5818	Fonts	techniqu
5819	Fonts	techover
5820	Fonts	telephas
5821	Fonts	tetri
5822	Fonts	tex-feybl10
5823	Fonts	tex-feybo10
5824	Fonts	tex-feybr10
5825	Fonts	tex-feyml10
5826	Fonts	tex-feymo10
5827	Fonts	tex-feymr10
5828	Fonts	texpalladiol-bolditalicosf
5829	Fonts	texpalladiol-boldosf
5830	Fonts	texpalladiol-italicosf
5831	Fonts	texpalladiol-sc
5832	Fonts	thwart
5833	Fonts	tirekv__
5834	Fonts	tiresias_infofont
5835	Fonts	tiresias_infofont_bold
5836	Fonts	tiresias_infofont_italic
5837	Fonts	tiresias_infofontz
5838	Fonts	tiresias_infofontz_bold
5839	Fonts	tiresias_infofontz_italic
5840	Fonts	tiresias_lpfont
5841	Fonts	tiresias_lpfont_bold
5842	Fonts	tiresias_lpfont_italic
5843	Fonts	tiresias_pcfont
5844	Fonts	tiresias_pcfont_bold
5845	Fonts	tiresias_pcfont_italic
5846	Fonts	tiresias_pcfontz
5847	Fonts	tiresias_pcfontz_bold
5848	Fonts	tiresias_pcfontz_italic
5849	Fonts	tiresias_signfont
5850	Fonts	tiresias_signfont_bold
5851	Fonts	tiresias_signfont_italic
5852	Fonts	tiresias_signfontz
5853	Fonts	tiresias_signfontz_bold
5854	Fonts	tiresias_signfontz_italic
5855	Fonts	tonik
5856	Fonts	tragic2
5857	Fonts	trajan-roman
5858	Fonts	trajan-slanted
5859	Fonts	tsextolo
5860	Fonts	tsextols
5861	Fonts	tuffy_bold
5862	Fonts	tuffy_bold_italic
5863	Fonts	tuffy_italic
5864	Fonts	tuffy_regular
5865	Fonts	turmoil
5866	Fonts	txbex
5867	Fonts	txbexa
5868	Fonts	txbmia
5869	Fonts	txbsy
5870	Fonts	txbsya
5871	Fonts	txbsyb
5872	Fonts	txbsyc
5873	Fonts	txbtt
5874	Fonts	txbttsc
5875	Fonts	txex
5876	Fonts	txexa
5877	Fonts	txmia
5878	Fonts	txsy
5879	Fonts	txsya
5880	Fonts	txsyb
5881	Fonts	txsyc
5882	Fonts	txtt
5883	Fonts	txttsc
5884	Fonts	ubiquity
5885	Fonts	unanimo
5886	Fonts	unanimoi
5887	Fonts	underscr
5888	Fonts	underwhe
5889	Fonts	underwho
5890	Fonts	undrscr2
5891	Fonts	united
5892	Fonts	unlearn2
5893	Fonts	unlearne
5894	Fonts	unrespon
5895	Fonts	unxgala
5896	Fonts	unxgalaw
5897	Fonts	unxgalo
5898	Fonts	unxgalwo
5899	Fonts	upheavtt
5900	Fonts	upraise
5901	Fonts	urcompi
5902	Fonts	urcompo
5903	Fonts	urwantiquat-regularcondensed
5904	Fonts	urwbookmanl-demibold
5905	Fonts	urwbookmanl-demiboldital
5906	Fonts	urwbookmanl-ligh
5907	Fonts	urwbookmanl-lighital
5908	Fonts	urwchanceryl-mediital
5909	Fonts	urwgothicl-book
5910	Fonts	urwgothicl-bookobli
5911	Fonts	urwgothicl-demi
5912	Fonts	urwgothicl-demiobli
5913	Fonts	urwgroteskt-bold
5914	Fonts	urwpalladiol-bold
5915	Fonts	urwpalladiol-boldital
5916	Fonts	urwpalladiol-ital
5917	Fonts	urwpalladiol-roma
5918	Fonts	utopia-bold
5919	Fonts	utopia-bolditalic
5920	Fonts	utopia-italic
5921	Fonts	utopia-regular
5922	Fonts	vacantz
5923	Fonts	vanished
5924	Fonts	vantage
5925	Fonts	variance
5926	Fonts	vertigo
5927	Fonts	vertigo2
5928	Fonts	vertigup
5929	Fonts	vertiup2
5930	Fonts	vigilanc
5931	Fonts	vindicti
5932	Fonts	visitor1
5933	Fonts	visitor2
5934	Fonts	vl-gothic-regular
5935	Fonts	vl-pgothic-regular
5936	Fonts	volatil1
5937	Fonts	volatil2
5938	Fonts	wager
5939	Fonts	wagerlos
5940	Fonts	wagerwon
5941	Fonts	wasy10
5942	Fonts	wasy5
5943	Fonts	wasy6
5944	Fonts	wasy7
5945	Fonts	wasy8
5946	Fonts	wasy9
5947	Fonts	wasyb10
5948	Fonts	waver
5949	Fonts	wayward
5950	Fonts	waywards
5951	Fonts	weatherd
5952	Fonts	weathers
5953	Fonts	weaver
5954	Fonts	whatever
5955	Fonts	whipsnap
5956	Fonts	wigsquig
5957	Fonts	wincing
5958	Fonts	withstan
5959	Fonts	wobbly
5960	Fonts	wyvernwi
5961	Fonts	wyvernww
5962	Fonts	xeroxmal
5963	Fonts	xhume
5964	Fonts	xipital
5965	Fonts	xmaslght
5966	Fonts	xtrusion
5967	Fonts	yearend
5968	Fonts	yehudaclm-bold
5969	Fonts	yehudaclm-light
5970	Fonts	yesterda
5971	Fonts	yfrak-regular
5972	Fonts	ygoth-regular
5973	Fonts	yielding
5974	Fonts	yonder
5975	Fonts	yoshisst
5976	Fonts	yourcomp
5977	Fonts	yswab-regular
5978	Fonts	zeldadxt
5979	Fonts	zenith
5980	Fonts	zephyrea
5981	Fonts	zephyreg
5982	Fonts	zerovelo
5983	Fonts	zirccube
5984	Fonts	zirconia
5985	Fonts	zoetrope
5986	Fonts	zoidal
5987	Fonts	zurklezo
5988	Fonts	zurklezs
\.


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY results (id, pid, pass, name) FROM stdin;
1210	151	pass	Domain
1211	151	pass	Title
1212	151	fail	UTF8
1213	151	fail	Img
1214	151	fail	Alt
1215	151	fail	JS
1216	151	fail	JS_inc
1217	151	pass	HTML4
1218	151	fail	Plugins
1219	152	pass	Domain
1220	152	pass	Title
1221	152	fail	UTF8
1222	152	fail	Img
1223	152	fail	Alt
1224	152	fail	JS
1225	152	fail	JS_inc
1226	152	pass	HTML4
1227	152	fail	Plugins
1228	153	pass	Domain
1229	153	pass	Title
1230	153	fail	UTF8
1231	153	fail	Img
1232	153	fail	Alt
1233	153	fail	JS
1234	153	fail	JS_inc
1235	153	fail	HTML4
1236	153	fail	Plugins
1237	154	pass	Domain
1238	154	pass	Title
1239	154	fail	UTF8
1240	154	fail	Img
1241	154	fail	Alt
1242	154	fail	JS
1243	154	fail	JS_inc
1244	154	pass	HTML4
1245	154	pass	Plugins
1246	155	pass	Domain
1247	155	pass	Title
1248	155	fail	UTF8
1249	155	fail	Img
1250	155	fail	Alt
1251	155	fail	JS
1252	155	fail	JS_inc
1253	155	pass	HTML4
1254	155	pass	Plugins
1255	156	pass	Domain
1256	156	pass	Title
1257	156	fail	UTF8
1258	156	fail	Img
1259	156	fail	Alt
1260	156	fail	JS
1261	156	fail	JS_inc
1262	156	pass	HTML4
1263	156	pass	Plugins
1264	157	pass	Domain
1265	157	pass	Title
1266	157	fail	UTF8
1267	157	pass	Img
1268	157	fail	Alt
1269	157	fail	JS
1270	157	fail	JS_inc
1271	157	pass	HTML4
1272	157	pass	Plugins
1273	158	pass	Domain
1274	158	pass	Title
1275	158	fail	UTF8
1276	158	fail	Img
1277	158	fail	Alt
1278	158	fail	JS
1279	158	fail	JS_inc
1280	158	pass	HTML4
1281	158	pass	Plugins
1282	159	pass	Domain
1283	159	pass	Title
1284	159	fail	UTF8
1285	159	fail	Img
1286	159	fail	Alt
1287	159	fail	JS
1288	159	fail	JS_inc
1289	159	pass	HTML4
1290	159	pass	Plugins
1291	160	pass	Domain
1292	160	pass	Title
1293	160	fail	UTF8
1294	160	fail	Img
1295	160	fail	Alt
1296	160	fail	JS
1297	160	fail	JS_inc
1298	160	pass	HTML4
1299	160	pass	Plugins
1300	161	pass	Domain
1301	161	pass	Title
1302	161	fail	UTF8
1303	161	fail	Img
1304	161	fail	Alt
1305	161	pass	JS
1306	161	fail	JS_inc
1307	161	pass	HTML4
1308	161	fail	Plugins
1309	162	pass	Domain
1310	162	pass	Title
1311	162	fail	UTF8
1312	162	fail	Img
1313	162	fail	Alt
1314	162	pass	JS
1315	162	fail	JS_inc
1316	162	pass	HTML4
1317	162	fail	Plugins
1318	163	pass	Domain
1319	163	pass	Title
1320	163	fail	UTF8
1321	163	fail	Img
1322	163	fail	Alt
1323	163	pass	JS
1324	163	fail	JS_inc
1325	163	pass	HTML4
1326	163	fail	Plugins
1327	164	pass	Domain
1328	164	pass	Title
1329	164	fail	UTF8
1330	164	fail	Img
1331	164	fail	Alt
1332	164	pass	JS
1333	164	fail	JS_inc
1334	164	pass	HTML4
1335	164	fail	Plugins
1336	165	pass	Domain
1337	165	pass	Title
1338	165	fail	UTF8
1339	165	fail	Img
1340	165	fail	Alt
1341	165	pass	JS
1342	165	fail	JS_inc
1343	165	pass	HTML4
1344	165	fail	Plugins
1345	166	pass	Domain
1346	166	pass	Title
1347	166	pass	UTF8
1348	166	fail	Img
1349	166	fail	Alt
1350	166	pass	JS
1351	166	fail	JS_inc
1352	166	pass	HTML4
1353	166	fail	Plugins
1354	167	pass	Domain
1355	167	pass	Title
1356	167	pass	UTF8
1357	167	fail	Img
1358	167	fail	Alt
1359	167	pass	JS
1360	167	fail	JS_inc
1361	167	pass	HTML4
1362	167	fail	Plugins
1363	168	pass	Domain
1364	168	pass	Title
1365	168	fail	UTF8
1366	168	fail	Img
1367	168	fail	Alt
1368	168	pass	JS
1369	168	fail	JS_inc
1370	168	pass	HTML4
1371	168	fail	Plugins
1372	169	pass	Domain
1373	169	pass	Title
1374	169	pass	UTF8
1375	169	fail	Img
1376	169	fail	Alt
1377	169	pass	JS
1378	169	fail	JS_inc
1379	169	pass	HTML4
1380	169	fail	Plugins
1381	170	pass	Domain
1382	170	pass	Title
1383	170	pass	UTF8
1384	170	fail	Img
1385	170	fail	Alt
1386	170	pass	JS
1387	170	fail	JS_inc
1388	170	pass	HTML4
1389	170	fail	Plugins
1390	171	pass	Domain
1391	171	pass	Title
1392	171	pass	UTF8
1393	171	fail	Img
1394	171	fail	Alt
1395	171	pass	JS
1396	171	fail	JS_inc
1397	171	pass	HTML4
1398	171	fail	Plugins
1399	172	pass	Domain
1400	172	pass	Title
1401	172	fail	UTF8
1402	172	fail	Img
1403	172	fail	Alt
1404	172	pass	JS
1405	172	fail	JS_inc
1406	172	pass	HTML4
1407	172	fail	Plugins
1408	173	pass	Domain
1409	173	pass	Title
1410	173	fail	UTF8
1411	173	fail	Img
1412	173	fail	Alt
1413	173	pass	JS
1414	173	fail	JS_inc
1415	173	pass	HTML4
1416	173	fail	Plugins
1417	174	pass	Domain
1418	174	pass	Title
1419	174	pass	UTF8
1420	174	fail	Img
1421	174	fail	Alt
1422	174	pass	JS
1423	174	fail	JS_inc
1424	174	pass	HTML4
1425	174	fail	Plugins
1426	175	pass	Domain
1427	175	pass	Title
1428	175	pass	UTF8
1429	175	fail	Img
1430	175	fail	Alt
1431	175	pass	JS
1432	175	fail	JS_inc
1433	175	pass	HTML4
1434	175	fail	Plugins
1435	176	pass	Domain
1436	176	pass	Title
1437	176	pass	UTF8
1438	176	fail	Img
1439	176	fail	Alt
1440	176	pass	JS
1441	176	fail	JS_inc
1442	176	pass	HTML4
1443	176	fail	Plugins
1444	177	pass	Domain
1445	177	pass	Title
1446	177	pass	UTF8
1447	177	fail	Img
1448	177	fail	Alt
1449	177	pass	JS
1450	177	fail	JS_inc
1451	177	pass	HTML4
1452	177	fail	Plugins
1453	178	pass	Domain
1454	178	pass	Title
1455	178	pass	UTF8
1456	178	fail	Img
1457	178	fail	Alt
1458	178	pass	JS
1459	178	fail	JS_inc
1460	178	pass	HTML4
1461	178	fail	Plugins
1462	179	pass	Domain
1463	179	pass	Title
1464	179	pass	UTF8
1465	179	fail	Img
1466	179	fail	Alt
1467	179	pass	JS
1468	179	fail	JS_inc
1469	179	pass	HTML4
1470	179	fail	Plugins
1471	180	pass	Domain
1472	180	pass	Title
1473	180	pass	UTF8
1474	180	fail	Img
1475	180	fail	Alt
1476	180	pass	JS
1477	180	fail	JS_inc
1478	180	pass	HTML4
1479	180	fail	Plugins
1480	181	pass	Domain
1481	181	pass	Title
1482	181	pass	UTF8
1483	181	fail	Img
1484	181	fail	Alt
1485	181	pass	JS
1486	181	fail	JS_inc
1487	181	pass	HTML4
1488	181	fail	Plugins
1489	182	pass	Domain
1490	254	pass	Domain
1491	254	pass	Title
1492	254	fail	UTF8
1493	254	pass	Img
1494	254	pass	Alt
1495	254	pass	JS
1496	254	fail	JS_inc
1497	254	fail	HTML4
1498	254	pass	Plugins
1499	255	pass	Domain
1500	255	pass	Title
1501	255	fail	UTF8
1502	255	pass	Img
1503	255	pass	Alt
1504	255	pass	JS
1505	255	fail	JS_inc
1506	255	pass	HTML4
1507	255	fail	Plugins
1508	256	pass	Domain
1509	256	pass	Title
1510	256	fail	UTF8
1511	256	fail	Img
1512	256	fail	Alt
1513	256	pass	JS
1514	256	fail	JS_inc
1515	256	pass	HTML4
1516	256	pass	Plugins
1517	257	pass	Domain
1518	257	pass	Title
1519	257	fail	UTF8
1520	257	pass	Img
1521	257	pass	Alt
1522	257	pass	JS
1523	257	fail	JS_inc
1524	257	pass	HTML4
1525	257	pass	Plugins
\.


--
-- Data for Name: urls; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY urls (id, pid, path, state, proc, ctime, mtime) FROM stdin;
165	14	/actualidad/bicentenario\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:01:23
166	14	/actualidad/documentales\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:01:34
167	14	/actualidad/dossier\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:01:43
168	14	/actualidad/enmienda-constitucional\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:01:53
169	14	/actualidad/informe-semanal\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:02:01
170	14	/actualidad/la-hojilla\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:02:09
171	14	/actualidad/las-l%C3%ADneas-de-ch%C3%A1vez\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:02:16
172	14	/actualidad/pacto-de-puerto-rico\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:02:29
173	14	/actualidad/sud%C3%A1frica-2010\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:02:40
174	14	/art%C3%ADculos\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:02:49
175	14	/art%C3%ADculos/\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:02:53
176	14	/art%C3%ADculos/opini%C3%B3n/42317\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:02:59
177	14	/art%C3%ADculos/opini%C3%B3n/42385\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:03:05
178	14	/contacto\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:03:08
179	14	/contenido/116\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:03:11
180	14	/contenido/19388\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:03:16
181	14	/el-canal\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:03:19
182	14	/files/converted_videos/42422_Resultado_del_Simulacro_Electoral_.flv\n	run	9755	2010-08-23 02:00:27	2010-08-23 02:03:19
254	15	/	done	9865	2010-08-23 02:10:03	2010-08-23 02:10:10
151	13	/	done	16939	2010-08-22 07:15:47	2010-08-22 07:15:52
255	15	/m8/contenido.asp?id=1\n	done	9865	2010-08-23 02:10:03	2010-08-23 02:10:12
152	13	/\n	done	16939	2010-08-22 07:15:47	2010-08-22 07:15:53
153	13	/action/noticia/filteror\n	done	16939	2010-08-22 07:15:47	2010-08-22 07:19:13
256	15	/m8/portal.asp\n	done	9865	2010-08-23 02:10:03	2010-08-23 02:10:34
154	13	/comision_contrataciones.html\n	done	16939	2010-08-22 07:15:47	2010-08-22 07:19:18
155	13	/contacto.html\n	done	16939	2010-08-22 07:15:47	2010-08-22 07:19:22
257	15	/m8/programa.asp?id=2\n	done	9865	2010-08-23 02:10:03	2010-08-23 02:10:38
156	13	/efemerides.html\n	done	16939	2010-08-22 07:15:47	2010-08-22 07:19:37
157	13	/index_enviar_caso.htm\n	done	16939	2010-08-22 07:15:47	2010-08-22 07:19:40
158	13	/logros_g_b.html\n	done	16939	2010-08-22 07:15:47	2010-08-22 07:19:48
159	13	/memoria_revolucionaria.html\n	done	16939	2010-08-22 07:15:47	2010-08-22 07:19:54
160	13	/personaje_del_mes.html\n	done	16939	2010-08-22 07:15:47	2010-08-22 07:19:59
183	14	/noticias-ciencia-y-salud\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
184	14	/noticias-ciencia-y-salud/42344\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
185	14	/noticias-ciencia-y-salud/42345\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
186	14	/noticias-ciencia-y-salud/42367\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
187	14	/noticias-ciencia-y-salud/42387\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
188	14	/noticias-culturales\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
189	14	/noticias-culturales/42255\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
190	14	/noticias-culturales/42272\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
191	14	/noticias-culturales/42283\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
192	14	/noticias-culturales/42362\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
193	14	/noticias-deportivas\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
194	14	/noticias-deportivas/42378\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
195	14	/noticias-deportivas/42384\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
196	14	/noticias-deportivas/42401\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
197	14	/noticias-deportivas/42408\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
198	14	/noticias-deportivas/42433\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
161	14	/	done	9755	2010-08-23 02:00:27	2010-08-23 02:00:50
162	14	/\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:00:54
163	14	/actualidad/Manuelita-S%C3%A1enz-vuelve-con-Bol%C3%ADvar\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:01:01
164	14	/actualidad/Mundial-de-Beisbol-Femenino-2010\n	done	9755	2010-08-23 02:00:27	2010-08-23 02:01:12
199	14	/noticias-econ%C3%B3micas\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
200	14	/noticias-econ%C3%B3micas/42312\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
201	14	/noticias-econ%C3%B3micas/42316\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
202	14	/noticias-econ%C3%B3micas/42318\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
203	14	/noticias-econ%C3%B3micas/42326\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
204	14	/noticias-internacionales\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
205	14	/noticias-internacionales/41369\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
206	14	/noticias-internacionales/41575\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
207	14	/noticias-internacionales/42409\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
208	14	/noticias-internacionales/42425\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
209	14	/noticias-internacionales/42427\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
210	14	/noticias-internacionales/42429\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
211	14	/noticias-internacionales/42438\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
212	14	/noticias-internacionales/42440\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
213	14	/noticias-nacionales\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
214	14	/noticias-nacionales/40327\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
215	14	/noticias-nacionales/40351\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
216	14	/noticias-nacionales/40935\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
217	14	/noticias-nacionales/41084\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
218	14	/noticias-nacionales/41717\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
219	14	/noticias-nacionales/41814\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
220	14	/noticias-nacionales/41831\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
221	14	/noticias-nacionales/41884\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
222	14	/noticias-nacionales/42377\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
223	14	/noticias-nacionales/42405\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
224	14	/noticias-nacionales/42415\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
225	14	/noticias-nacionales/42419\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
226	14	/noticias-nacionales/42424\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
227	14	/noticias-nacionales/42428\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
228	14	/noticias-nacionales/42430\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
229	14	/noticias-nacionales/42431\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
230	14	/noticias-nacionales/42432\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
231	14	/noticias-nacionales/42437\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
232	14	/noticias-nacionales/42439\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
233	14	/programas-videos/dossier\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
234	14	/programas-videos/la-hojilla\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
235	14	/videos-destacadas\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
236	14	/videos-destacadas-en-video/42434\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
237	14	/videos-emisiones\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
238	14	/videos-emisiones-anteriores/40475\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
239	14	/videos-emisiones-anteriores/40636\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
240	14	/videos-emisiones-anteriores/40718\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
241	14	/videos-emisiones-anteriores/40725\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
242	14	/videos-emisiones-anteriores/40813\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
243	14	/videos-emisiones-anteriores/41215\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
244	14	/videos-emisiones-anteriores/41228\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
245	14	/videos-emisiones-anteriores/41595\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
246	14	/videos-emisiones-anteriores/41834\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
247	14	/videos-emisiones-anteriores/41990\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
248	14	/videos-emisiones-anteriores/42303\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
249	14	/videos-emisiones-anteriores/42336\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
250	14	/videos-emisiones-anteriores/42349\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
251	14	/videos-emisiones-anteriores/42392\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
252	14	/videos-emisiones-anteriores/42436\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
253	14	/videos-especiales-vtv/42380\n	new	\N	2010-08-23 02:00:27	2010-08-23 02:00:27
\.


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: idxdisp; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY disposicion
    ADD CONSTRAINT idxdisp PRIMARY KEY (id);


--
-- Name: jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


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
-- Name: pkparams; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY params
    ADD CONSTRAINT pkparams PRIMARY KEY (id);


--
-- Name: results_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: urls_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT urls_pkey PRIMARY KEY (id);


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
-- Name: idxmodulo; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxmodulo ON disposicion USING btree (modulo);


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
-- Name: idxregistro; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxregistro ON entidadverificadora USING btree (registro);


--
-- Name: idxrifev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxrifev ON entidadverificadora USING btree (rif);


--
-- Name: idxrifinst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxrifinst ON institucion USING btree (rif);


--
-- Name: urls_pid_state; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX urls_pid_state ON urls USING btree (pid, state);


--
-- Name: events_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pid_fkey FOREIGN KEY (pid) REFERENCES results(id) ON DELETE CASCADE;


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
-- Name: results_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pid_fkey FOREIGN KEY (pid) REFERENCES urls(id) ON DELETE CASCADE;


--
-- Name: urls_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT urls_pid_fkey FOREIGN KEY (pid) REFERENCES jobs(id) ON DELETE CASCADE;


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

