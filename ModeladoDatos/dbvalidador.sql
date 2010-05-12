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
    job integer
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

SELECT pg_catalog.setval('auditoria_id_seq', 13, true);


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

SELECT pg_catalog.setval('auditoriadetalle_id_seq', 5, true);


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

SELECT pg_catalog.setval('disposicion_id_seq', 13, true);


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
    habilitado boolean DEFAULT true NOT NULL
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

SELECT pg_catalog.setval('entidadverificadora_id_seq', 7, true);


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

SELECT pg_catalog.setval('events_id_seq', 160, true);


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

SELECT pg_catalog.setval('institucion_id_seq', 17, true);


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

SELECT pg_catalog.setval('jobs_id_seq', 4, true);


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

SELECT pg_catalog.setval('results_id_seq', 216, true);


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

SELECT pg_catalog.setval('urls_id_seq', 27, true);


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

COPY auditoria (id, idev, idinstitucion, portal, fechaini, fechafin, fechacreacion, url, estado, job) FROM stdin;
4	2	2	Portal de Covetel	\N	\N	2010-05-08	{"www.cnti.gob.ve\n","www.suscerte.gob.ve\n","www.covetel.com.ve\n"}	p	\N
5	6	4	Movilnet	\N	\N	2010-05-09	{"www.cnti.gob.ve\n","www.suscerte.gob.ve\n","www.covetel.com.ve\n"}	p	\N
6	2	2	Algun portal de la institucion	\N	\N	2010-05-09	{"www.cnti.gob.ve\n","www.suscerte.gob.ve\n","www.covetel.com.ve\n"}	p	\N
7	6	4	El portal de las pruebas	\N	\N	2010-05-09	{"www.cnti.gob.ve\n","www.suscerte.gob.ve\n","www.covetel.com.ve\n"}	p	\N
8	2	11	Super Portal	\N	\N	2010-05-10	{"www.cnti.gob.ve\n","www.suscerte.gob.ve\n","www.covetel.com.ve\n"}	p	\N
9	4	3	Otro Super Mega Portal	\N	\N	2010-05-10	{"www.cnti.gob.ve\n","www.suscerte.gob.ve\n","www.covetel.com.ve\n"}	p	\N
11	2	2	Portal del Ministerio	2010-05-10	2010-05-12	2010-05-10	{"http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/27/04/2010-escuela-de-planificacin-lanza-sistema-de-formacin-a-distancia-para-comunidades\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/27/04/2010-transicin-a-modelo-socialista-requiere-de-poder-productivo-basado-en-el-trabajo\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/05/04/2010-min.-planificacin-y-finanzas-anuncia-cronograma-de-colocacin-de-deuda-pblica-nacional-para-2-trimestre-2010\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/05/04/2010-min.-planificacin-y-finanzas-anuncia-cronograma-de-colocacin-de-letras-del-tesoro-para-2-trimestre-2010\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/15/03/2010-min.-planificacin-y-finanzas-anuncia-reprogramacin-de-colocacin-de-deuda\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-gobierno-ha-invertido-330-mil-millones-en-materia-social-en-11-aos\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-cadivi-ha-autorizado--4-mil-800-millones-hasta-la-fecha\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-aumento-de-precios-del-crudo-permitir-mayor-margen-de-maniobra-al-gobierno\n"}	c	2
13	2	17	Luis Chacon	2010-05-11	\N	2010-05-11	{"http://www.luischacon.info/index.php?lang=es\n","http://www.luischacon.info/servicios.php\n","http://www.luischacon.info/contacto.php\n","http://www.luischacon.info/acerca-de-luis-chacon.php\n"}	a	4
10	4	11	Otro Super Mega Portal	2010-05-10	2010-05-12	2010-05-10	{"www.cnti.gob.ve\n","www.suscerte.gob.ve\n","www.covetel.com.ve\n"}	c	1
12	4	3	Validador de portales	2010-05-10	2010-05-12	2010-05-10	{"http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/27/04/2010-escuela-de-planificacin-lanza-sistema-de-formacin-a-distancia-para-comunidades\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/27/04/2010-transicin-a-modelo-socialista-requiere-de-poder-productivo-basado-en-el-trabajo\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/05/04/2010-min.-planificacin-y-finanzas-anuncia-cronograma-de-colocacin-de-deuda-pblica-nacional-para-2-trimestre-2010\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/05/04/2010-min.-planificacin-y-finanzas-anuncia-cronograma-de-colocacin-de-letras-del-tesoro-para-2-trimestre-2010\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/15/03/2010-min.-planificacin-y-finanzas-anuncia-reprogramacin-de-colocacin-de-deuda\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-gobierno-ha-invertido-330-mil-millones-en-materia-social-en-11-aos\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-cadivi-ha-autorizado--4-mil-800-millones-hasta-la-fecha\n","http://www.mppef.gob.ve/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-aumento-de-precios-del-crudo-permitir-mayor-margen-de-maniobra-al-gobierno\n"}	c	3
\.


--
-- Data for Name: auditoriadetalle; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY auditoriadetalle (id, idauditoria, iddisposicion, resolutoria) FROM stdin;
1	13	9	noaoasas
2	13	13	Debe agregar los widgets de twitter en un archivo .js y no usar el codigo empotrado
3	12	9	Cambiar todas las imagenes a PNG
4	12	11	Poner los atributos ALT como debe ser
5	12	13	Meter el codigo  javascript en archivos .js
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
\.


--
-- Data for Name: entidadverificadora; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY entidadverificadora (id, nombre, rif, correo, telefono, contacto, direccion, web, habilitado) FROM stdin;
2	COVETEL	J-992929	info@covetel.com.ve	0412-9889285	Juan Mesa	Cordero	www.covetel.com.ve	t
4	Cooperativa GNU	J-12312391	gnu@cooperativa.com	0414-9999999	Richard Stallman	Internet	http://www.gnu.org	t
5	Network IT	j-00000000	info@networkit.com.ve	0414-000.0000	Ninguno	Distrito Federal	http://networkit.com.ve	f
6	El Pollo Loco	J-432149595	pollo@enbrasa.com	0416-5555555	El Gallo Claudio	La granja	http://pollitodice.org	t
7	B-52	J-12319181	b52@algo.com	555-555.5555	Alguien por alli	En la lata	http://www.google.com	t
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY events (id, pid, class, message, data) FROM stdin;
1	2	error	No tiene TITLE	\N
2	3	warnings	No HTTP Charset	\N
3	7	error	No se usan archivos con extensión .js	\N
4	10	error	No tiene TITLE	\N
5	11	warnings	No HTTP Charset	\N
6	15	error	No se usan archivos con extensión .js	\N
7	18	error	No tiene TITLE	\N
8	19	warnings	No HTTP Charset	\N
9	23	error	No se usan archivos con extensión .js	\N
10	26	error	No tiene TITLE	\N
11	27	warnings	No HTTP Charset	\N
12	31	error	No se usan archivos con extensión .js	\N
13	36	error	Tipo de imagen ilegal image/gif	\N
14	36	error	Tipo de imagen ilegal image/gif	\N
15	36	error	Tipo de imagen ilegal image/jpeg	\N
16	36	error	Tipo de imagen ilegal image/jpeg	\N
17	36	error	Tipo de imagen ilegal image/gif	\N
18	36	error	Tipo de imagen ilegal image/gif	\N
19	37	error	Hay 1 imagenes sin atributo ALT	\N
20	39	error	Script en línea	\N
21	39	error	No se usan archivos con extensión .js	\N
22	40	error	El tipo de documento es: HTML-5	\N
23	44	error	Tipo de imagen ilegal image/gif	\N
24	44	error	Tipo de imagen ilegal image/gif	\N
25	44	error	Tipo de imagen ilegal image/jpeg	\N
26	44	error	Tipo de imagen ilegal image/gif	\N
27	45	error	Hay 1 imagenes sin atributo ALT	\N
28	47	error	Script en línea	\N
29	48	error	El tipo de documento es: HTML-5	\N
30	52	error	Tipo de imagen ilegal image/gif	\N
31	52	error	Tipo de imagen ilegal image/gif	\N
32	52	error	Tipo de imagen ilegal image/jpeg	\N
33	52	error	Tipo de imagen ilegal image/gif	\N
34	53	error	Hay 1 imagenes sin atributo ALT	\N
35	55	error	Script en línea	\N
36	56	error	El tipo de documento es: HTML-5	\N
37	60	error	Tipo de imagen ilegal image/gif	\N
38	60	error	Tipo de imagen ilegal image/gif	\N
39	60	error	Tipo de imagen ilegal image/jpeg	\N
40	61	error	Hay 1 imagenes sin atributo ALT	\N
41	63	error	Script en línea	\N
42	64	error	El tipo de documento es: HTML-5	\N
43	68	error	Tipo de imagen ilegal image/gif	\N
44	68	error	Tipo de imagen ilegal image/gif	\N
45	68	error	Tipo de imagen ilegal image/jpeg	\N
46	69	error	Hay 1 imagenes sin atributo ALT	\N
47	71	error	Script en línea	\N
48	72	error	El tipo de documento es: HTML-5	\N
49	76	error	Tipo de imagen ilegal image/gif	\N
50	76	error	Tipo de imagen ilegal image/gif	\N
51	76	error	Tipo de imagen ilegal image/jpeg	\N
52	77	error	Hay 1 imagenes sin atributo ALT	\N
53	79	error	Script en línea	\N
54	80	error	El tipo de documento es: HTML-5	\N
55	84	error	Tipo de imagen ilegal image/gif	\N
56	84	error	Tipo de imagen ilegal image/gif	\N
57	84	error	Tipo de imagen ilegal image/jpeg	\N
58	85	error	Hay 1 imagenes sin atributo ALT	\N
59	87	error	Script en línea	\N
60	88	error	El tipo de documento es: HTML-5	\N
61	92	error	Tipo de imagen ilegal image/gif	\N
62	92	error	Tipo de imagen ilegal image/gif	\N
63	92	error	Tipo de imagen ilegal image/jpeg	\N
64	93	error	Hay 1 imagenes sin atributo ALT	\N
65	95	error	Script en línea	\N
66	96	error	El tipo de documento es: HTML-5	\N
67	100	error	Tipo de imagen ilegal image/gif	\N
68	100	error	Tipo de imagen ilegal image/gif	\N
69	100	error	Tipo de imagen ilegal image/jpeg	\N
70	101	error	Hay 1 imagenes sin atributo ALT	\N
71	103	error	Script en línea	\N
72	104	error	El tipo de documento es: HTML-5	\N
73	108	error	Tipo de imagen ilegal image/gif	\N
74	108	error	Tipo de imagen ilegal image/gif	\N
75	108	error	Tipo de imagen ilegal image/jpeg	\N
76	108	error	Tipo de imagen ilegal image/jpeg	\N
77	108	error	Tipo de imagen ilegal image/gif	\N
78	108	error	Tipo de imagen ilegal image/gif	\N
79	109	error	Hay 1 imagenes sin atributo ALT	\N
80	111	error	Script en línea	\N
81	111	error	No se usan archivos con extensión .js	\N
82	112	error	El tipo de documento es: HTML-5	\N
83	116	error	Tipo de imagen ilegal image/gif	\N
84	116	error	Tipo de imagen ilegal image/gif	\N
85	116	error	Tipo de imagen ilegal image/jpeg	\N
86	116	error	Tipo de imagen ilegal image/gif	\N
87	117	error	Hay 1 imagenes sin atributo ALT	\N
88	119	error	Script en línea	\N
89	120	error	El tipo de documento es: HTML-5	\N
90	124	error	Tipo de imagen ilegal image/gif	\N
91	124	error	Tipo de imagen ilegal image/gif	\N
92	124	error	Tipo de imagen ilegal image/jpeg	\N
93	124	error	Tipo de imagen ilegal image/gif	\N
94	125	error	Hay 1 imagenes sin atributo ALT	\N
95	127	error	Script en línea	\N
96	128	error	El tipo de documento es: HTML-5	\N
97	132	error	Tipo de imagen ilegal image/gif	\N
98	132	error	Tipo de imagen ilegal image/gif	\N
99	132	error	Tipo de imagen ilegal image/jpeg	\N
100	133	error	Hay 1 imagenes sin atributo ALT	\N
101	135	error	Script en línea	\N
102	136	error	El tipo de documento es: HTML-5	\N
103	140	error	Tipo de imagen ilegal image/gif	\N
104	140	error	Tipo de imagen ilegal image/gif	\N
105	140	error	Tipo de imagen ilegal image/jpeg	\N
106	141	error	Hay 1 imagenes sin atributo ALT	\N
107	143	error	Script en línea	\N
108	144	error	El tipo de documento es: HTML-5	\N
109	148	error	Tipo de imagen ilegal image/gif	\N
110	148	error	Tipo de imagen ilegal image/gif	\N
111	148	error	Tipo de imagen ilegal image/jpeg	\N
112	149	error	Hay 1 imagenes sin atributo ALT	\N
113	151	error	Script en línea	\N
114	152	error	El tipo de documento es: HTML-5	\N
115	156	error	Tipo de imagen ilegal image/gif	\N
116	156	error	Tipo de imagen ilegal image/gif	\N
117	156	error	Tipo de imagen ilegal image/jpeg	\N
118	157	error	Hay 1 imagenes sin atributo ALT	\N
119	159	error	Script en línea	\N
120	160	error	El tipo de documento es: HTML-5	\N
121	164	error	Tipo de imagen ilegal image/gif	\N
122	164	error	Tipo de imagen ilegal image/gif	\N
123	164	error	Tipo de imagen ilegal image/jpeg	\N
124	165	error	Hay 1 imagenes sin atributo ALT	\N
125	167	error	Script en línea	\N
126	168	error	El tipo de documento es: HTML-5	\N
127	172	error	Tipo de imagen ilegal image/gif	\N
128	172	error	Tipo de imagen ilegal image/gif	\N
129	172	error	Tipo de imagen ilegal image/jpeg	\N
130	173	error	Hay 1 imagenes sin atributo ALT	\N
131	175	error	Script en línea	\N
132	176	error	El tipo de documento es: HTML-5	\N
133	179	warnings	No HTTP Charset	\N
134	179	error	HTTP charset '' does not match META charset 'UTF-8'	\N
135	180	error	Tipo de imagen ilegal image/jpeg	\N
136	183	error	Script en línea	\N
137	183	error	Script en línea	\N
138	183	error	Script en línea	\N
139	187	warnings	No HTTP Charset	\N
140	187	error	HTTP charset '' does not match META charset 'UTF-8'	\N
141	191	error	Script en línea	\N
142	191	error	Script en línea	\N
143	191	error	Script en línea	\N
144	195	warnings	No HTTP Charset	\N
145	195	error	HTTP charset '' does not match META charset 'UTF-8'	\N
146	199	error	Script en línea	\N
147	199	error	Script en línea	\N
148	199	error	Script en línea	\N
149	199	error	Script en línea	\N
150	203	warnings	No HTTP Charset	\N
151	203	error	HTTP charset '' does not match META charset 'UTF-8'	\N
152	204	error	Tipo de imagen ilegal image/jpeg	\N
153	207	error	Script en línea	\N
154	207	error	Script en línea	\N
155	207	error	Script en línea	\N
156	211	warnings	No HTTP Charset	\N
157	211	error	HTTP charset '' does not match META charset 'UTF-8'	\N
158	215	error	Script en línea	\N
159	215	error	Script en línea	\N
160	215	error	Script en línea	\N
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
14	Servicio Autonomo de Transporte y Tránsito Terrestre	G-11	info@setra.gob.ve	0212-333.3333	El pana del SETRA	En Caracas	http://www.setra.gob.ve	t
13	Casa de lili	J-333333333	lilibeth@covetel.com.ve	555-555.5555	skjhskfhsdfkhfdkhasdfkhasdfk	asdadadadasdadadada	http://www.portatillili.gov.ve	t
15	Ministerio de Finanzas 2	G-12345678902	otro@otro.com	(333) 333-3333	Alguien por alli	adasd a;sakjn ai asljdal	http://www.ambiente.gob.ve	t
16	COVETEL	J-321345111	info@covetel.com.ve	(222) 222-2222	Walter	paramillo	http://www.covetel.com.ve	t
17	Luis Chacon	j-2131231331111	info@luischacon.info	(041) 444-4444	Luis Chacon	San Cristobal	http://www.luischacon.info	t
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY jobs (id, site, callback, data, state, proc, ctime, mtime, pid) FROM stdin;
1	://	\N	\N	done	29422	2010-05-10 14:47:35	2010-05-10 14:47:36	\N
2	http://www.mppef.gob.ve	\N	\N	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:38	\N
3	http://www.mppef.gob.ve	\N	\N	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:13	\N
4	http://www.luischacon.info	\N	\N	done	14514	2010-05-11 22:13:46	2010-05-11 22:16:03	\N
\.


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY results (id, pid, pass, name) FROM stdin;
1	1	pass	Domain
2	1	fail	Title
3	1	pass	UTF8
4	1	pass	Img
5	1	pass	Alt
6	1	pass	JS
7	1	fail	JS_inc
8	1	fail	HTML4
9	2	pass	Domain
10	2	fail	Title
11	2	pass	UTF8
12	2	pass	Img
13	2	pass	Alt
14	2	pass	JS
15	2	fail	JS_inc
16	2	fail	HTML4
17	3	pass	Domain
18	3	fail	Title
19	3	pass	UTF8
20	3	pass	Img
21	3	pass	Alt
22	3	pass	JS
23	3	fail	JS_inc
24	3	fail	HTML4
25	4	pass	Domain
26	4	fail	Title
27	4	pass	UTF8
28	4	pass	Img
29	4	pass	Alt
30	4	pass	JS
31	4	fail	JS_inc
32	4	fail	HTML4
33	5	pass	Domain
34	5	pass	Title
35	5	pass	UTF8
36	5	fail	Img
37	5	fail	Alt
38	5	pass	JS
39	5	fail	JS_inc
40	5	fail	HTML4
41	6	pass	Domain
42	6	pass	Title
43	6	pass	UTF8
44	6	fail	Img
45	6	fail	Alt
46	6	pass	JS
47	6	fail	JS_inc
48	6	fail	HTML4
49	7	pass	Domain
50	7	pass	Title
51	7	pass	UTF8
52	7	fail	Img
53	7	fail	Alt
54	7	pass	JS
55	7	fail	JS_inc
56	7	fail	HTML4
57	8	pass	Domain
58	8	pass	Title
59	8	pass	UTF8
60	8	fail	Img
61	8	fail	Alt
62	8	pass	JS
63	8	fail	JS_inc
64	8	fail	HTML4
65	9	pass	Domain
66	9	pass	Title
67	9	pass	UTF8
68	9	fail	Img
69	9	fail	Alt
70	9	pass	JS
71	9	fail	JS_inc
72	9	fail	HTML4
73	10	pass	Domain
74	10	pass	Title
75	10	pass	UTF8
76	10	fail	Img
77	10	fail	Alt
78	10	pass	JS
79	10	fail	JS_inc
80	10	fail	HTML4
81	11	pass	Domain
82	11	pass	Title
83	11	pass	UTF8
84	11	fail	Img
85	11	fail	Alt
86	11	pass	JS
87	11	fail	JS_inc
88	11	fail	HTML4
89	12	pass	Domain
90	12	pass	Title
91	12	pass	UTF8
92	12	fail	Img
93	12	fail	Alt
94	12	pass	JS
95	12	fail	JS_inc
96	12	fail	HTML4
97	13	pass	Domain
98	13	pass	Title
99	13	pass	UTF8
100	13	fail	Img
101	13	fail	Alt
102	13	pass	JS
103	13	fail	JS_inc
104	13	fail	HTML4
105	14	pass	Domain
106	14	pass	Title
107	14	pass	UTF8
108	14	fail	Img
109	14	fail	Alt
110	14	pass	JS
111	14	fail	JS_inc
112	14	fail	HTML4
113	15	pass	Domain
114	15	pass	Title
115	15	pass	UTF8
116	15	fail	Img
117	15	fail	Alt
118	15	pass	JS
119	15	fail	JS_inc
120	15	fail	HTML4
121	16	pass	Domain
122	16	pass	Title
123	16	pass	UTF8
124	16	fail	Img
125	16	fail	Alt
126	16	pass	JS
127	16	fail	JS_inc
128	16	fail	HTML4
129	17	pass	Domain
130	17	pass	Title
131	17	pass	UTF8
132	17	fail	Img
133	17	fail	Alt
134	17	pass	JS
135	17	fail	JS_inc
136	17	fail	HTML4
137	18	pass	Domain
138	18	pass	Title
139	18	pass	UTF8
140	18	fail	Img
141	18	fail	Alt
142	18	pass	JS
143	18	fail	JS_inc
144	18	fail	HTML4
145	19	pass	Domain
146	19	pass	Title
147	19	pass	UTF8
148	19	fail	Img
149	19	fail	Alt
150	19	pass	JS
151	19	fail	JS_inc
152	19	fail	HTML4
153	20	pass	Domain
154	20	pass	Title
155	20	pass	UTF8
156	20	fail	Img
157	20	fail	Alt
158	20	pass	JS
159	20	fail	JS_inc
160	20	fail	HTML4
161	21	pass	Domain
162	21	pass	Title
163	21	pass	UTF8
164	21	fail	Img
165	21	fail	Alt
166	21	pass	JS
167	21	fail	JS_inc
168	21	fail	HTML4
169	22	pass	Domain
170	22	pass	Title
171	22	pass	UTF8
172	22	fail	Img
173	22	fail	Alt
174	22	pass	JS
175	22	fail	JS_inc
176	22	fail	HTML4
177	23	pass	Domain
178	23	pass	Title
179	23	fail	UTF8
180	23	fail	Img
181	23	pass	Alt
182	23	pass	JS
183	23	fail	JS_inc
184	23	pass	HTML4
185	24	pass	Domain
186	24	pass	Title
187	24	fail	UTF8
188	24	pass	Img
189	24	pass	Alt
190	24	pass	JS
191	24	fail	JS_inc
192	24	pass	HTML4
193	25	pass	Domain
194	25	pass	Title
195	25	fail	UTF8
196	25	pass	Img
197	25	pass	Alt
198	25	pass	JS
199	25	fail	JS_inc
200	25	pass	HTML4
201	26	pass	Domain
202	26	pass	Title
203	26	fail	UTF8
204	26	fail	Img
205	26	pass	Alt
206	26	pass	JS
207	26	fail	JS_inc
208	26	pass	HTML4
209	27	pass	Domain
210	27	pass	Title
211	27	fail	UTF8
212	27	pass	Img
213	27	pass	Alt
214	27	pass	JS
215	27	fail	JS_inc
216	27	pass	HTML4
\.


--
-- Data for Name: urls; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY urls (id, pid, path, state, proc, ctime, mtime) FROM stdin;
1	1	/	done	29422	2010-05-10 14:47:35	2010-05-10 14:47:36
2	1	www.cnti.gob.ve\n	done	29422	2010-05-10 14:47:35	2010-05-10 14:47:36
3	1	www.covetel.com.ve\n	done	29422	2010-05-10 14:47:35	2010-05-10 14:47:36
4	1	www.suscerte.gob.ve\n	done	29422	2010-05-10 14:47:35	2010-05-10 14:47:36
5	2	/	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:10
6	2	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/05/04/2010-min.-planificacin-y-finanzas-anuncia-cronograma-de-colocacin-de-deuda-pblica-nacional-para-2-trimestre-2010\n	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:15
7	2	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/05/04/2010-min.-planificacin-y-finanzas-anuncia-cronograma-de-colocacin-de-letras-del-tesoro-para-2-trimestre-2010\n	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:18
8	2	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-aumento-de-precios-del-crudo-permitir-mayor-margen-de-maniobra-al-gobierno\n	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:22
9	2	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-cadivi-ha-autorizado--4-mil-800-millones-hasta-la-fecha\n	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:25
10	2	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-gobierno-ha-invertido-330-mil-millones-en-materia-social-en-11-aos\n	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:29
11	2	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/15/03/2010-min.-planificacin-y-finanzas-anuncia-reprogramacin-de-colocacin-de-deuda\n	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:32
12	2	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/27/04/2010-escuela-de-planificacin-lanza-sistema-de-formacin-a-distancia-para-comunidades\n	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:35
13	2	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/27/04/2010-transicin-a-modelo-socialista-requiere-de-poder-productivo-basado-en-el-trabajo\n	done	29914	2010-05-10 14:51:44	2010-05-10 14:52:38
14	3	/	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:10
15	3	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/05/04/2010-min.-planificacin-y-finanzas-anuncia-cronograma-de-colocacin-de-deuda-pblica-nacional-para-2-trimestre-2010\n	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:10
16	3	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/05/04/2010-min.-planificacin-y-finanzas-anuncia-cronograma-de-colocacin-de-letras-del-tesoro-para-2-trimestre-2010\n	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:11
17	3	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-aumento-de-precios-del-crudo-permitir-mayor-margen-de-maniobra-al-gobierno\n	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:11
18	3	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-cadivi-ha-autorizado--4-mil-800-millones-hasta-la-fecha\n	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:12
19	3	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/10/03/2010-gobierno-ha-invertido-330-mil-millones-en-materia-social-en-11-aos\n	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:12
20	3	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/15/03/2010-min.-planificacin-y-finanzas-anuncia-reprogramacin-de-colocacin-de-deuda\n	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:12
21	3	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/27/04/2010-escuela-de-planificacin-lanza-sistema-de-formacin-a-distancia-para-comunidades\n	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:13
22	3	/inicio/notas-de-prensa/2010/scnotas-prensa-2010/27/04/2010-transicin-a-modelo-socialista-requiere-de-poder-productivo-basado-en-el-trabajo\n	done	16195	2010-05-10 23:37:08	2010-05-10 23:37:13
23	4	/	done	14514	2010-05-11 22:13:46	2010-05-11 22:14:23
24	4	/acerca-de-luis-chacon.php\n	done	14514	2010-05-11 22:13:46	2010-05-11 22:14:48
25	4	/contacto.php\n	done	14514	2010-05-11 22:13:46	2010-05-11 22:15:01
26	4	/index.php?lang=es\n	done	14514	2010-05-11 22:13:46	2010-05-11 22:15:38
27	4	/servicios.php\n	done	14514	2010-05-11 22:13:46	2010-05-11 22:16:03
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

