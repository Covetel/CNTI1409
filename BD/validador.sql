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

SELECT pg_catalog.setval('auditoria_id_seq', 111, true);


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

SELECT pg_catalog.setval('auditoriadetalle_id_seq', 24, true);


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
    descripcion text NOT NULL,
    habilitado boolean DEFAULT true NOT NULL,
    modulo character varying(10),
    descripcion_prueba text
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

SELECT pg_catalog.setval('disposicion_id_seq', 29, true);


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

SELECT pg_catalog.setval('entidadverificadora_id_seq', 11, true);


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

SELECT pg_catalog.setval('events_id_seq', 33599, true);


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

SELECT pg_catalog.setval('institucion_id_seq', 24, true);


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

SELECT pg_catalog.setval('jobs_id_seq', 100, true);


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

SELECT pg_catalog.setval('params_id_seq', 5990, true);


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

SELECT pg_catalog.setval('results_id_seq', 6076, true);


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

SELECT pg_catalog.setval('urls_id_seq', 639, true);


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



--
-- Data for Name: auditoriadetalle; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: disposicion; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO disposicion VALUES (1, 'Dominio', 'Todo Portal de Internet de los órganos y entes de la Administración Pública Nacional deberá ser accesible a través de un nombre de dominio compuesto por el dominio de segundo nivel que represente el nombre del órgano o ente encargado del Portal de Internet, dominio genérico de segundo nivel (.gob), seguido del dominio de primer nivel de país (.ve).', true, 'Domain', 'Verifica y valida si cumple o no con las especificaciones del nombre de Dominio dispuestas en la Norma');
INSERT INTO disposicion VALUES (3, 'Etiqueta Title', 'Todo Portal de Internet de los órganos y entes de la Administración Pública Nacional deberá poseer la meta etiqueta Title por cada una de sus páginas internas, y esta etiqueta debe contener el titulo de la página. 
', true, 'Title', 'Cumple con las especificaciones de la etiqueta TITLE dispuestas en la norma');
INSERT INTO disposicion VALUES (4, 'UTF8', 'Todo Portal de Internet de los órganos y entes de la Administración Pública Nacional deberá utilizar la especificación Unicode 8 bit (UTF-8) para codificar el Juego de Caracteres de sus documentos de hipertexto.
', true, 'UTF8', 'Verificar y validar la codificación del juego de caracteres de sus Archivos de Hipertexto, utiliza las especificaciones Unicode 8 bit (UTF-8)');
INSERT INTO disposicion VALUES (9, 'Imagenes PNG', 'Los archivos de imágenes y gráficos a ser usados en los Portales de Internet, deberán utilizar como formato la especificación PNG, según se describe en la Norma ISO/IEC 15948:2003, dictada por la Organización Internacional para la Estandarización.', true, 'Img', 'Analizar la metadata de los gráficos e imágenes que se encuentren en el árbol HTML del documento, verificar que el formato no es diferente de PNG.');
INSERT INTO disposicion VALUES (11, 'Atributo alt', 'Se debe utilizar el atributo ALT, del elemento IMG descrito en la especificación HTML 4.01, para definir un texto alterno a las imágenes a ser usadas en los Portales de Internet, con el fin de mejorar el acceso y la usabilidad de los Portales de Internet para aquellos usuarios que tengan deshabilitados el despliegue de imágenes o que por cualquier razón no puedan apreciar esas imágenes.', true, 'Alt', 'Validar y verificar el uso del atributo ALT, en la etiqueta IMG el elemento IMG descrito en la especificación HTML 4.01 para definir un texto alterno a las imágenes usadas en el portal');
INSERT INTO disposicion VALUES (12, 'Uso de Javascript', 'El Lenguaje Script a ser usado en los Portales de Internet debe ser JavaScript en su versión 1.7 ECMA-262, como mínimo, debiendo colocar el código JavaScript de manera separada en un archivo de extensión ".js".', true, 'JS', 'Verificar y validar la utilización del lenguaje Javascript');
INSERT INTO disposicion VALUES (13, 'Archivos js', 'El código del Lenguaje Script JavaScript usado en los Portales de Internet debe ser colocado de manera separada en un archivo de extensión ".js".', true, 'JS_inc', 'Verificar y validar la inclusión de archivos ".js" del Lenguaje Script JavaScript. Validar que no se encuentran embebido en el árbol de la estructura HTML del Portal de Internet.');
INSERT INTO disposicion VALUES (15, 'HTML 4.01/XHTML 1.0', 'Los documentos de hipertexto a ser usados en los Portales de Internet deberán utilizar como formato las especificaciones HTML 4.01, según se expresa en las recomendaciones XHTML 4.01 del 24 de diciembre de 1999, o XHTML 1.0 de fecha 1 de agosto de 2002, de la W3C. Los Documentos de hipertexto de los Portales de Internet sujetos a esta Resolución deben ser validados utilizando las herramientas que la W3C dispone en línea, procurándose la inclusión gráfica en los Portales de los sellos de conformidad dispuestos por la W3C.', true, 'HTML4', 'Verificar y validar el uso de HTML 4.01 o XHTML 1.0 para la estructura organizativa de portales.');
INSERT INTO disposicion VALUES (18, 'Controles Añadibles', 'A los efectos de esta Resolución y de la diagramación gráfica de los Portales de Internet en los órganos y entes, se debe utilizar tipografía abierta que no requiera de pago de regalias.', true, 'Plugins', 'Verificar y validar el uso de tipografía abierta, es decir, queno requiere de pago de regalías');
INSERT INTO disposicion VALUES (22, 'Fuentes Libres', 'Verificar el uso de Fuentes Libres', true, 'Fonts', 'Verificar el uso de fuentes libres');
INSERT INTO disposicion VALUES (27, 'Uso de SSL', 'Verificar el uso de SSL para el envío de indatos sensibles', true, 'SSL', 'Verificar el uso de SSL para el envío de indatos sensibles');
INSERT INTO disposicion VALUES (28, 'Validar CSS contra W3C', 'Hacer uso del validador oficial de la W3C para la validación de CSS', true, 'W3C_CSS', 'Hacer uso del validador oficial de la W3C para la validación de CSS');
INSERT INTO disposicion VALUES (29, 'Validar HTML contra W3C', 'Hacer uso del validador oficial de la W3C para la validación del HTML', true, 'W3C_HTML', 'Hacer uso del validador oficial de la W3C para la validación del HTML');
INSERT INTO disposicion VALUES (24, 'Uso de meta etiquetas', 'Verificar el uso de meta etiquetas en el portal', true, 'Meta', 'Verificar el uso de meta etiquetas en el portal');
INSERT INTO disposicion VALUES (25, 'Uso de formatos libres', 'Verificar que no existan formatos no libres disponibles para la descarga', true, 'Formatos', 'Verificar que no existan formatos no libres disponibles para la descarga');
INSERT INTO disposicion VALUES (26, 'Maquetado del sitio', 'Verificar que el maquetado del portal no sea por medio de tablas', true, 'Layout', 'Verificar que el maquetado del portal no sea por medio de tablas');


--
-- Data for Name: entidadverificadora; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: institucion; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: params; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO params VALUES (4492, 'Fonts', '1015sn');
INSERT INTO params VALUES (4493, 'Fonts', '1015snr');
INSERT INTO params VALUES (4494, 'Fonts', '18holes');
INSERT INTO params VALUES (4495, 'Fonts', '36daysag');
INSERT INTO params VALUES (4496, 'Fonts', '36daythk');
INSERT INTO params VALUES (4497, 'Fonts', '3dlet');
INSERT INTO params VALUES (4498, 'Fonts', '4shadow');
INSERT INTO params VALUES (4499, 'Fonts', '4shadowo');
INSERT INTO params VALUES (4500, 'Fonts', '8bitlim');
INSERT INTO params VALUES (4501, 'Fonts', '8bitlimo');
INSERT INTO params VALUES (4502, 'Fonts', '8bitlimr');
INSERT INTO params VALUES (4503, 'Fonts', '8blimro');
INSERT INTO params VALUES (4504, 'Fonts', '90stars');
INSERT INTO params VALUES (4505, 'Fonts', 'BLEX');
INSERT INTO params VALUES (4506, 'Fonts', 'BLSY');
INSERT INTO params VALUES (4507, 'Fonts', 'MarVoSym');
INSERT INTO params VALUES (4508, 'Fonts', 'RBLMI');
INSERT INTO params VALUES (4509, 'Fonts', 'abecedario');
INSERT INTO params VALUES (4510, 'Fonts', 'abecedarioguiada');
INSERT INTO params VALUES (4511, 'Fonts', 'abecedarionegrita');
INSERT INTO params VALUES (4512, 'Fonts', 'abecedariopautada');
INSERT INTO params VALUES (4513, 'Fonts', 'abecedariopuntguiada');
INSERT INTO params VALUES (4514, 'Fonts', 'abecedariopuntos');
INSERT INTO params VALUES (4515, 'Fonts', 'abecedariopuntpautada');
INSERT INTO params VALUES (4516, 'Fonts', 'abyssinica_sil');
INSERT INTO params VALUES (4517, 'Fonts', 'acidrefl');
INSERT INTO params VALUES (4518, 'Fonts', 'acknowtt');
INSERT INTO params VALUES (4519, 'Fonts', 'ae_alarabiya');
INSERT INTO params VALUES (4520, 'Fonts', 'ae_albattar');
INSERT INTO params VALUES (4521, 'Fonts', 'ae_alhor');
INSERT INTO params VALUES (4522, 'Fonts', 'ae_almanzomah');
INSERT INTO params VALUES (4523, 'Fonts', 'ae_almateen-bold');
INSERT INTO params VALUES (4524, 'Fonts', 'ae_almohanad');
INSERT INTO params VALUES (4525, 'Fonts', 'ae_almothnna-bold');
INSERT INTO params VALUES (4526, 'Fonts', 'ae_alyarmook');
INSERT INTO params VALUES (4527, 'Fonts', 'ae_arab');
INSERT INTO params VALUES (4528, 'Fonts', 'ae_cortoba');
INSERT INTO params VALUES (4529, 'Fonts', 'ae_dimnah');
INSERT INTO params VALUES (4530, 'Fonts', 'ae_electron');
INSERT INTO params VALUES (4531, 'Fonts', 'ae_furat');
INSERT INTO params VALUES (4532, 'Fonts', 'ae_granada');
INSERT INTO params VALUES (4533, 'Fonts', 'ae_graph');
INSERT INTO params VALUES (4534, 'Fonts', 'ae_hani');
INSERT INTO params VALUES (4535, 'Fonts', 'ae_haramain');
INSERT INTO params VALUES (4536, 'Fonts', 'ae_hor');
INSERT INTO params VALUES (4537, 'Fonts', 'ae_japan');
INSERT INTO params VALUES (4538, 'Fonts', 'ae_jet');
INSERT INTO params VALUES (4539, 'Fonts', 'ae_kayrawan');
INSERT INTO params VALUES (4540, 'Fonts', 'ae_khalid');
INSERT INTO params VALUES (4541, 'Fonts', 'ae_mashq-bold');
INSERT INTO params VALUES (4542, 'Fonts', 'ae_mashq');
INSERT INTO params VALUES (4543, 'Fonts', 'ae_metal');
INSERT INTO params VALUES (4544, 'Fonts', 'ae_nada');
INSERT INTO params VALUES (4545, 'Fonts', 'ae_nagham');
INSERT INTO params VALUES (4546, 'Fonts', 'ae_nice');
INSERT INTO params VALUES (4547, 'Fonts', 'ae_ostorah');
INSERT INTO params VALUES (4548, 'Fonts', 'ae_ouhod-bold');
INSERT INTO params VALUES (4549, 'Fonts', 'ae_petra');
INSERT INTO params VALUES (4550, 'Fonts', 'ae_rasheeq-bold');
INSERT INTO params VALUES (4551, 'Fonts', 'ae_rehan');
INSERT INTO params VALUES (4552, 'Fonts', 'ae_salem');
INSERT INTO params VALUES (4553, 'Fonts', 'ae_shado');
INSERT INTO params VALUES (4554, 'Fonts', 'ae_sharjah');
INSERT INTO params VALUES (4555, 'Fonts', 'ae_sindbad');
INSERT INTO params VALUES (4556, 'Fonts', 'ae_tarablus');
INSERT INTO params VALUES (4557, 'Fonts', 'ae_tholoth');
INSERT INTO params VALUES (4558, 'Fonts', 'aescrawl');
INSERT INTO params VALUES (4559, 'Fonts', 'aesymatt');
INSERT INTO params VALUES (4560, 'Fonts', 'aftermat');
INSERT INTO params VALUES (4561, 'Fonts', 'aharoniclm-bold');
INSERT INTO params VALUES (4562, 'Fonts', 'aharoniclm-boldoblique');
INSERT INTO params VALUES (4563, 'Fonts', 'aharoniclm-book');
INSERT INTO params VALUES (4564, 'Fonts', 'aharoniclm-bookoblique');
INSERT INTO params VALUES (4565, 'Fonts', 'alba____');
INSERT INTO params VALUES (4566, 'Fonts', 'albam___');
INSERT INTO params VALUES (4567, 'Fonts', 'albas___');
INSERT INTO params VALUES (4568, 'Fonts', 'alfa-beta');
INSERT INTO params VALUES (4569, 'Fonts', 'alphbeta');
INSERT INTO params VALUES (4570, 'Fonts', 'amalgama');
INSERT INTO params VALUES (4571, 'Fonts', 'amalgamo');
INSERT INTO params VALUES (4572, 'Fonts', 'amicilogo');
INSERT INTO params VALUES (4573, 'Fonts', 'amicilogobold');
INSERT INTO params VALUES (4574, 'Fonts', 'amicilogoboldoblique');
INSERT INTO params VALUES (4575, 'Fonts', 'amicilogoboldreverseoblique');
INSERT INTO params VALUES (4576, 'Fonts', 'amicilogooblique');
INSERT INTO params VALUES (4577, 'Fonts', 'amicilogoreverseoblique');
INSERT INTO params VALUES (4578, 'Fonts', 'amplitud');
INSERT INTO params VALUES (4579, 'Fonts', 'andbasr');
INSERT INTO params VALUES (4580, 'Fonts', 'antykwatorunska-bold');
INSERT INTO params VALUES (4581, 'Fonts', 'antykwatorunska-bolditalic');
INSERT INTO params VALUES (4582, 'Fonts', 'antykwatorunska-italic');
INSERT INTO params VALUES (4583, 'Fonts', 'antykwatorunska-regular');
INSERT INTO params VALUES (4584, 'Fonts', 'antykwatorunskacond-bold');
INSERT INTO params VALUES (4585, 'Fonts', 'antykwatorunskacond-bolditalic');
INSERT INTO params VALUES (4586, 'Fonts', 'antykwatorunskacond-italic');
INSERT INTO params VALUES (4587, 'Fonts', 'antykwatorunskacond-regular');
INSERT INTO params VALUES (4588, 'Fonts', 'antykwatorunskacondlight-italic');
INSERT INTO params VALUES (4589, 'Fonts', 'antykwatorunskacondlight-regular');
INSERT INTO params VALUES (4590, 'Fonts', 'antykwatorunskacondmed-italic');
INSERT INTO params VALUES (4591, 'Fonts', 'antykwatorunskacondmed-regular');
INSERT INTO params VALUES (4592, 'Fonts', 'antykwatorunskalight-italic');
INSERT INTO params VALUES (4593, 'Fonts', 'antykwatorunskalight-regular');
INSERT INTO params VALUES (4594, 'Fonts', 'antykwatorunskamed-italic');
INSERT INTO params VALUES (4595, 'Fonts', 'antykwatorunskamed-regular');
INSERT INTO params VALUES (4596, 'Fonts', 'apibold');
INSERT INTO params VALUES (4597, 'Fonts', 'apibolit');
INSERT INTO params VALUES (4598, 'Fonts', 'apiitali');
INSERT INTO params VALUES (4599, 'Fonts', 'apiregul');
INSERT INTO params VALUES (4600, 'Fonts', 'archaic-aramaic');
INSERT INTO params VALUES (4601, 'Fonts', 'archaic-cypriot');
INSERT INTO params VALUES (4602, 'Fonts', 'archaic-etruscan');
INSERT INTO params VALUES (4603, 'Fonts', 'archaic-futharc');
INSERT INTO params VALUES (4604, 'Fonts', 'archaic-greek-4th-century-bc');
INSERT INTO params VALUES (4605, 'Fonts', 'archaic-greek-6th-century-bc');
INSERT INTO params VALUES (4606, 'Fonts', 'archaic-linear-b');
INSERT INTO params VALUES (4607, 'Fonts', 'archaic-nabatean');
INSERT INTO params VALUES (4608, 'Fonts', 'archaic-oands-italic');
INSERT INTO params VALUES (4609, 'Fonts', 'archaic-oands');
INSERT INTO params VALUES (4610, 'Fonts', 'archaic-old-persian');
INSERT INTO params VALUES (4611, 'Fonts', 'archaic-phoenician');
INSERT INTO params VALUES (4612, 'Fonts', 'archaic-poor-mans-hieroglyphs');
INSERT INTO params VALUES (4613, 'Fonts', 'archaic-protosemitic');
INSERT INTO params VALUES (4614, 'Fonts', 'archaic-south-arabian');
INSERT INTO params VALUES (4615, 'Fonts', 'archaic-ugaritic-cuneiform');
INSERT INTO params VALUES (4616, 'Fonts', 'arevsans-bold');
INSERT INTO params VALUES (4617, 'Fonts', 'arevsans-boldoblique');
INSERT INTO params VALUES (4618, 'Fonts', 'arevsans-oblique');
INSERT INTO params VALUES (4619, 'Fonts', 'arevsans-roman');
INSERT INTO params VALUES (4620, 'Fonts', 'arthriti');
INSERT INTO params VALUES (4621, 'Fonts', 'ascii');
INSERT INTO params VALUES (4622, 'Fonts', 'aspartam');
INSERT INTO params VALUES (4623, 'Fonts', 'atarismall');
INSERT INTO params VALUES (4624, 'Fonts', 'atarismallbold');
INSERT INTO params VALUES (4625, 'Fonts', 'atarismallcondensed');
INSERT INTO params VALUES (4626, 'Fonts', 'atarismallitalic');
INSERT INTO params VALUES (4627, 'Fonts', 'atarismalllight');
INSERT INTO params VALUES (4628, 'Fonts', 'ataxia');
INSERT INTO params VALUES (4629, 'Fonts', 'ataxiao');
INSERT INTO params VALUES (4630, 'Fonts', 'augie');
INSERT INTO params VALUES (4631, 'Fonts', 'aurelisadf-bold');
INSERT INTO params VALUES (5891, 'Fonts', 'united');
INSERT INTO params VALUES (4632, 'Fonts', 'aurelisadf-bolditalic');
INSERT INTO params VALUES (4633, 'Fonts', 'aurelisadf-italic');
INSERT INTO params VALUES (4634, 'Fonts', 'aurelisadf-regular');
INSERT INTO params VALUES (4635, 'Fonts', 'aurelisadfcd-bold');
INSERT INTO params VALUES (4636, 'Fonts', 'aurelisadfcd-bolditalic');
INSERT INTO params VALUES (4637, 'Fonts', 'aurelisadfcd-italic');
INSERT INTO params VALUES (4638, 'Fonts', 'aurelisadfcd-regular');
INSERT INTO params VALUES (4639, 'Fonts', 'aurelisadfdemi-bold');
INSERT INTO params VALUES (4640, 'Fonts', 'aurelisadfdemi-bolditalic');
INSERT INTO params VALUES (4641, 'Fonts', 'aurelisadfex-bold');
INSERT INTO params VALUES (4642, 'Fonts', 'aurelisadfex-bolditalic');
INSERT INTO params VALUES (4643, 'Fonts', 'aurelisadfex-italic');
INSERT INTO params VALUES (4644, 'Fonts', 'aurelisadfex-regular');
INSERT INTO params VALUES (4645, 'Fonts', 'aurelisadfexdemi-bold');
INSERT INTO params VALUES (4646, 'Fonts', 'aurelisadfexdemi-bolditalic');
INSERT INTO params VALUES (4647, 'Fonts', 'aurelisadflt-bold');
INSERT INTO params VALUES (4648, 'Fonts', 'aurelisadflt-bolditalic');
INSERT INTO params VALUES (4649, 'Fonts', 'aurelisadflt-italic');
INSERT INTO params VALUES (4650, 'Fonts', 'aurelisadflt-regular');
INSERT INTO params VALUES (4651, 'Fonts', 'aurelisadfscript-italic');
INSERT INTO params VALUES (4652, 'Fonts', 'aurelisadfscriptno2-italic');
INSERT INTO params VALUES (4653, 'Fonts', 'auriocuskalligraphicus');
INSERT INTO params VALUES (4654, 'Fonts', 'auriocuskalligraphicusbold');
INSERT INTO params VALUES (4655, 'Fonts', 'auriocuskalligraphicusboldoblique');
INSERT INTO params VALUES (4656, 'Fonts', 'auriocuskalligraphicusboldreverseoblique');
INSERT INTO params VALUES (4657, 'Fonts', 'auriocuskalligraphicusoblique');
INSERT INTO params VALUES (4658, 'Fonts', 'auriocuskalligraphicusreverseoblique');
INSERT INTO params VALUES (4659, 'Fonts', 'automati');
INSERT INTO params VALUES (4660, 'Fonts', 'b2sq');
INSERT INTO params VALUES (4661, 'Fonts', 'b2sqol1');
INSERT INTO params VALUES (4662, 'Fonts', 'b2sqol2');
INSERT INTO params VALUES (4663, 'Fonts', 'babeboit');
INSERT INTO params VALUES (4664, 'Fonts', 'babebold');
INSERT INTO params VALUES (4665, 'Fonts', 'babelita');
INSERT INTO params VALUES (4666, 'Fonts', 'babelreg');
INSERT INTO params VALUES (4667, 'Fonts', 'backlash');
INSERT INTO params VALUES (4668, 'Fonts', 'bandless');
INSERT INTO params VALUES (4669, 'Fonts', 'bandmess');
INSERT INTO params VALUES (4670, 'Fonts', 'bandwdth');
INSERT INTO params VALUES (4671, 'Fonts', 'bbm10');
INSERT INTO params VALUES (4672, 'Fonts', 'bbm7');
INSERT INTO params VALUES (4673, 'Fonts', 'bbmbx10');
INSERT INTO params VALUES (4674, 'Fonts', 'bbmbx7');
INSERT INTO params VALUES (4675, 'Fonts', 'bbmbxsl10');
INSERT INTO params VALUES (4676, 'Fonts', 'bbmsl10');
INSERT INTO params VALUES (4677, 'Fonts', 'bbmss10');
INSERT INTO params VALUES (4678, 'Fonts', 'bbold10');
INSERT INTO params VALUES (4679, 'Fonts', 'bbold7');
INSERT INTO params VALUES (4680, 'Fonts', 'bendable');
INSERT INTO params VALUES (4681, 'Fonts', 'berasans-bold');
INSERT INTO params VALUES (4682, 'Fonts', 'berasans-boldoblique');
INSERT INTO params VALUES (4683, 'Fonts', 'berasans-oblique');
INSERT INTO params VALUES (4684, 'Fonts', 'berasans-roman');
INSERT INTO params VALUES (4685, 'Fonts', 'berasansmono-bold');
INSERT INTO params VALUES (4686, 'Fonts', 'berasansmono-boldob');
INSERT INTO params VALUES (4687, 'Fonts', 'berasansmono-oblique');
INSERT INTO params VALUES (4688, 'Fonts', 'berasansmono-roman');
INSERT INTO params VALUES (4689, 'Fonts', 'beraserif-bold');
INSERT INTO params VALUES (4690, 'Fonts', 'beraserif-roman');
INSERT INTO params VALUES (4691, 'Fonts', 'betecknalowercase');
INSERT INTO params VALUES (4692, 'Fonts', 'betecknalowercasebold');
INSERT INTO params VALUES (4693, 'Fonts', 'betecknalowercaseboldcondensed');
INSERT INTO params VALUES (4694, 'Fonts', 'betecknalowercaseitalic');
INSERT INTO params VALUES (4695, 'Fonts', 'betecknalowercaseitaliccondensed');
INSERT INTO params VALUES (4696, 'Fonts', 'bewilder');
INSERT INTO params VALUES (4697, 'Fonts', 'bewildet');
INSERT INTO params VALUES (4698, 'Fonts', 'bin01st');
INSERT INTO params VALUES (4699, 'Fonts', 'binaryt');
INSERT INTO params VALUES (4700, 'Fonts', 'binaryx');
INSERT INTO params VALUES (4701, 'Fonts', 'binchrt');
INSERT INTO params VALUES (4702, 'Fonts', 'binx01s');
INSERT INTO params VALUES (4703, 'Fonts', 'binxchr');
INSERT INTO params VALUES (4704, 'Fonts', 'biolinum_bd-0.4.1ro');
INSERT INTO params VALUES (4705, 'Fonts', 'biolinum_re-0.4.1ro');
INSERT INTO params VALUES (4706, 'Fonts', 'bitbttf');
INSERT INTO params VALUES (4707, 'Fonts', 'bknuckss');
INSERT INTO params VALUES (4708, 'Fonts', 'bknuckst');
INSERT INTO params VALUES (4709, 'Fonts', 'blackoni');
INSERT INTO params VALUES (4710, 'Fonts', 'bleakseg');
INSERT INTO params VALUES (4711, 'Fonts', 'blex');
INSERT INTO params VALUES (4712, 'Fonts', 'bloktilt');
INSERT INTO params VALUES (4713, 'Fonts', 'blonibld');
INSERT INTO params VALUES (4714, 'Fonts', 'blonirex');
INSERT INTO params VALUES (4715, 'Fonts', 'blox2');
INSERT INTO params VALUES (4716, 'Fonts', 'blsy');
INSERT INTO params VALUES (4717, 'Fonts', 'bobcayge');
INSERT INTO params VALUES (4718, 'Fonts', 'bobcaygr');
INSERT INTO params VALUES (4719, 'Fonts', 'bocuma');
INSERT INTO params VALUES (4720, 'Fonts', 'bocumaad');
INSERT INTO params VALUES (4721, 'Fonts', 'bocumaba');
INSERT INTO params VALUES (4722, 'Fonts', 'bocumade');
INSERT INTO params VALUES (4723, 'Fonts', 'bocumang');
INSERT INTO params VALUES (4724, 'Fonts', 'brassknu');
INSERT INTO params VALUES (4725, 'Fonts', 'breipfont');
INSERT INTO params VALUES (4726, 'Fonts', 'brigadom');
INSERT INTO params VALUES (4727, 'Fonts', 'brigadow');
INSERT INTO params VALUES (4728, 'Fonts', 'brushscriptx-italic');
INSERT INTO params VALUES (4729, 'Fonts', 'bumped');
INSERT INTO params VALUES (4730, 'Fonts', 'caladingsclm');
INSERT INTO params VALUES (4731, 'Fonts', 'candystr');
INSERT INTO params VALUES (4732, 'Fonts', 'ccaps');
INSERT INTO params VALUES (4733, 'Fonts', 'ccapshad');
INSERT INTO params VALUES (4734, 'Fonts', 'centuryschl-bold');
INSERT INTO params VALUES (4735, 'Fonts', 'centuryschl-boldital');
INSERT INTO params VALUES (4736, 'Fonts', 'centuryschl-ital');
INSERT INTO params VALUES (4737, 'Fonts', 'centuryschl-roma');
INSERT INTO params VALUES (4738, 'Fonts', 'charissilb');
INSERT INTO params VALUES (4739, 'Fonts', 'charissilbi');
INSERT INTO params VALUES (4740, 'Fonts', 'charissili');
INSERT INTO params VALUES (4741, 'Fonts', 'charissilr');
INSERT INTO params VALUES (4742, 'Fonts', 'charterbt-bold');
INSERT INTO params VALUES (4743, 'Fonts', 'charterbt-bolditalic');
INSERT INTO params VALUES (4744, 'Fonts', 'charterbt-italic');
INSERT INTO params VALUES (4745, 'Fonts', 'charterbt-roman');
INSERT INTO params VALUES (4746, 'Fonts', 'chemrea');
INSERT INTO params VALUES (4747, 'Fonts', 'chemreb');
INSERT INTO params VALUES (4748, 'Fonts', 'cherokee-bold');
INSERT INTO params VALUES (4749, 'Fonts', 'cherokee');
INSERT INTO params VALUES (4750, 'Fonts', 'chintzy');
INSERT INTO params VALUES (4751, 'Fonts', 'chintzys');
INSERT INTO params VALUES (4752, 'Fonts', 'chumbly');
INSERT INTO params VALUES (4753, 'Fonts', 'circulat');
INSERT INTO params VALUES (4754, 'Fonts', 'clasict1');
INSERT INTO params VALUES (4755, 'Fonts', 'clasict2');
INSERT INTO params VALUES (4756, 'Fonts', 'claw1');
INSERT INTO params VALUES (4757, 'Fonts', 'claw2');
INSERT INTO params VALUES (4758, 'Fonts', 'cleavttr');
INSERT INTO params VALUES (4759, 'Fonts', 'cmroman-bold');
INSERT INTO params VALUES (4760, 'Fonts', 'cmroman-bolditalic');
INSERT INTO params VALUES (4761, 'Fonts', 'cmroman-bolditalicosf');
INSERT INTO params VALUES (4762, 'Fonts', 'cmroman-boldsc');
INSERT INTO params VALUES (4763, 'Fonts', 'cmroman-italic');
INSERT INTO params VALUES (4764, 'Fonts', 'cmroman-italicosf');
INSERT INTO params VALUES (4765, 'Fonts', 'cmroman-regular');
INSERT INTO params VALUES (4766, 'Fonts', 'cmroman-regularsc');
INSERT INTO params VALUES (4767, 'Fonts', 'cmromanasian-bold');
INSERT INTO params VALUES (4768, 'Fonts', 'cmromanasian-bolditalic');
INSERT INTO params VALUES (4769, 'Fonts', 'cmromanasian-bolditalicosf');
INSERT INTO params VALUES (4770, 'Fonts', 'cmromanasian-boldsc');
INSERT INTO params VALUES (4771, 'Fonts', 'cmromanasian-italic');
INSERT INTO params VALUES (4772, 'Fonts', 'cmromanasian-italicosf');
INSERT INTO params VALUES (4773, 'Fonts', 'cmromanasian-regular');
INSERT INTO params VALUES (4774, 'Fonts', 'cmromanasian-regularsc');
INSERT INTO params VALUES (4775, 'Fonts', 'cmromancyrillic-bold');
INSERT INTO params VALUES (4776, 'Fonts', 'cmromancyrillic-bolditalic');
INSERT INTO params VALUES (4777, 'Fonts', 'cmromancyrillic-bolditalicosf');
INSERT INTO params VALUES (4778, 'Fonts', 'cmromancyrillic-boldsc');
INSERT INTO params VALUES (4779, 'Fonts', 'cmromancyrillic-italic');
INSERT INTO params VALUES (4780, 'Fonts', 'cmromancyrillic-italicosf');
INSERT INTO params VALUES (4781, 'Fonts', 'cmromancyrillic-regular');
INSERT INTO params VALUES (4782, 'Fonts', 'cmromancyrillic-regularsc');
INSERT INTO params VALUES (4783, 'Fonts', 'cmromangreek-bold');
INSERT INTO params VALUES (4784, 'Fonts', 'cmromangreek-bolditalic');
INSERT INTO params VALUES (4785, 'Fonts', 'cmromangreek-bolditalicosf');
INSERT INTO params VALUES (4786, 'Fonts', 'cmromangreek-boldsc');
INSERT INTO params VALUES (4787, 'Fonts', 'cmromangreek-italic');
INSERT INTO params VALUES (4788, 'Fonts', 'cmromangreek-italicosf');
INSERT INTO params VALUES (4789, 'Fonts', 'cmromangreek-regular');
INSERT INTO params VALUES (4790, 'Fonts', 'cmromangreek-regularsc');
INSERT INTO params VALUES (4791, 'Fonts', 'cmsans-bold');
INSERT INTO params VALUES (4792, 'Fonts', 'cmsans-boldslanted');
INSERT INTO params VALUES (4793, 'Fonts', 'cmsans-regular');
INSERT INTO params VALUES (4794, 'Fonts', 'cmsans-slanted');
INSERT INTO params VALUES (4795, 'Fonts', 'cmsansasian-bold');
INSERT INTO params VALUES (4796, 'Fonts', 'cmsansasian-boldslanted');
INSERT INTO params VALUES (4797, 'Fonts', 'cmsansasian-regular');
INSERT INTO params VALUES (4798, 'Fonts', 'cmsansasian-slanted');
INSERT INTO params VALUES (4799, 'Fonts', 'cmsanscyrillic-bold');
INSERT INTO params VALUES (4800, 'Fonts', 'cmsanscyrillic-boldslanted');
INSERT INTO params VALUES (4801, 'Fonts', 'cmsanscyrillic-regular');
INSERT INTO params VALUES (4802, 'Fonts', 'cmsanscyrillic-slanted');
INSERT INTO params VALUES (4803, 'Fonts', 'cmsansgreek-bold');
INSERT INTO params VALUES (4804, 'Fonts', 'cmsansgreek-boldslanted');
INSERT INTO params VALUES (4805, 'Fonts', 'cmsansgreek-regular');
INSERT INTO params VALUES (4806, 'Fonts', 'cmsansgreek-slanted');
INSERT INTO params VALUES (4807, 'Fonts', 'cmtypewriter-italic');
INSERT INTO params VALUES (4808, 'Fonts', 'cmtypewriter-italicosf');
INSERT INTO params VALUES (4809, 'Fonts', 'cmtypewriter-regular');
INSERT INTO params VALUES (4810, 'Fonts', 'cmtypewriter-regularsc');
INSERT INTO params VALUES (4811, 'Fonts', 'cmtypewriterasian-italic');
INSERT INTO params VALUES (4812, 'Fonts', 'cmtypewriterasian-italicosf');
INSERT INTO params VALUES (4813, 'Fonts', 'cmtypewriterasian-regular');
INSERT INTO params VALUES (4814, 'Fonts', 'cmtypewriterasian-regularsc');
INSERT INTO params VALUES (4815, 'Fonts', 'cmtypewritercyrillic-italic');
INSERT INTO params VALUES (4816, 'Fonts', 'cmtypewritercyrillic-italicosf');
INSERT INTO params VALUES (4817, 'Fonts', 'cmtypewritercyrillic-regular');
INSERT INTO params VALUES (4818, 'Fonts', 'cmtypewritercyrillic-regularsc');
INSERT INTO params VALUES (4819, 'Fonts', 'cmtypewritergreek-italic');
INSERT INTO params VALUES (4820, 'Fonts', 'cmtypewritergreek-italicosf');
INSERT INTO params VALUES (4821, 'Fonts', 'cmtypewritergreek-regular');
INSERT INTO params VALUES (4822, 'Fonts', 'cmtypewritergreek-regularsc');
INSERT INTO params VALUES (4823, 'Fonts', 'codelife');
INSERT INTO params VALUES (4824, 'Fonts', 'collecro');
INSERT INTO params VALUES (4825, 'Fonts', 'collecrs');
INSERT INTO params VALUES (4826, 'Fonts', 'collecto');
INSERT INTO params VALUES (4827, 'Fonts', 'collects');
INSERT INTO params VALUES (4828, 'Fonts', 'combusii');
INSERT INTO params VALUES (4829, 'Fonts', 'combuspl');
INSERT INTO params VALUES (4830, 'Fonts', 'combusti');
INSERT INTO params VALUES (4831, 'Fonts', 'combustt');
INSERT INTO params VALUES (4832, 'Fonts', 'combustw');
INSERT INTO params VALUES (4833, 'Fonts', 'compc1o');
INSERT INTO params VALUES (4834, 'Fonts', 'compc1s');
INSERT INTO params VALUES (4835, 'Fonts', 'compc2o');
INSERT INTO params VALUES (4836, 'Fonts', 'compc2s');
INSERT INTO params VALUES (4837, 'Fonts', 'compc3o');
INSERT INTO params VALUES (4838, 'Fonts', 'compc3s');
INSERT INTO params VALUES (4839, 'Fonts', 'computermodern-sans-bold-oblique');
INSERT INTO params VALUES (4840, 'Fonts', 'condui2i');
INSERT INTO params VALUES (4841, 'Fonts', 'conduit');
INSERT INTO params VALUES (4842, 'Fonts', 'conduit2');
INSERT INTO params VALUES (4843, 'Fonts', 'courier-bold');
INSERT INTO params VALUES (4844, 'Fonts', 'courier-bolditalic');
INSERT INTO params VALUES (4845, 'Fonts', 'courier-italic');
INSERT INTO params VALUES (4846, 'Fonts', 'courier');
INSERT INTO params VALUES (4847, 'Fonts', 'crackdr2');
INSERT INTO params VALUES (4848, 'Fonts', 'crkdownr');
INSERT INTO params VALUES (4849, 'Fonts', 'crkdwno1');
INSERT INTO params VALUES (4850, 'Fonts', 'crkdwno2');
INSERT INTO params VALUES (4851, 'Fonts', 'darkside');
INSERT INTO params VALUES (4852, 'Fonts', 'dashdot');
INSERT INTO params VALUES (4853, 'Fonts', 'dastardl');
INSERT INTO params VALUES (4854, 'Fonts', 'davidclm-bold');
INSERT INTO params VALUES (4855, 'Fonts', 'davidclm-medium');
INSERT INTO params VALUES (4856, 'Fonts', 'davidclm-mediumitalic');
INSERT INTO params VALUES (4857, 'Fonts', 'dblayer1');
INSERT INTO params VALUES (4858, 'Fonts', 'dblayer2');
INSERT INTO params VALUES (4859, 'Fonts', 'dblayer3');
INSERT INTO params VALUES (4860, 'Fonts', 'dblayer4');
INSERT INTO params VALUES (4861, 'Fonts', 'dblbogey');
INSERT INTO params VALUES (4862, 'Fonts', 'dbsilbb');
INSERT INTO params VALUES (4863, 'Fonts', 'dbsilbc');
INSERT INTO params VALUES (4864, 'Fonts', 'dbsilbo');
INSERT INTO params VALUES (4865, 'Fonts', 'dbsilbr');
INSERT INTO params VALUES (4866, 'Fonts', 'dbsillb');
INSERT INTO params VALUES (4867, 'Fonts', 'dbsillc');
INSERT INTO params VALUES (4868, 'Fonts', 'dbsillo');
INSERT INTO params VALUES (4869, 'Fonts', 'dbsillr');
INSERT INTO params VALUES (4870, 'Fonts', 'decrepit');
INSERT INTO params VALUES (4871, 'Fonts', 'dejavusans-bold');
INSERT INTO params VALUES (4872, 'Fonts', 'dejavusans-boldoblique');
INSERT INTO params VALUES (4873, 'Fonts', 'dejavusans-extralight');
INSERT INTO params VALUES (4874, 'Fonts', 'dejavusans-oblique');
INSERT INTO params VALUES (4875, 'Fonts', 'dejavusans');
INSERT INTO params VALUES (4876, 'Fonts', 'dejavusanscondensed-bold');
INSERT INTO params VALUES (4877, 'Fonts', 'dejavusanscondensed-boldoblique');
INSERT INTO params VALUES (4878, 'Fonts', 'dejavusanscondensed-oblique');
INSERT INTO params VALUES (4879, 'Fonts', 'dejavusanscondensed');
INSERT INTO params VALUES (4880, 'Fonts', 'dejavusansmono-bold');
INSERT INTO params VALUES (4881, 'Fonts', 'dejavusansmono-boldoblique');
INSERT INTO params VALUES (4882, 'Fonts', 'dejavusansmono-oblique');
INSERT INTO params VALUES (4883, 'Fonts', 'dejavusansmono');
INSERT INTO params VALUES (4884, 'Fonts', 'dejavuserif-bold');
INSERT INTO params VALUES (4885, 'Fonts', 'dejavuserif-bolditalic');
INSERT INTO params VALUES (4886, 'Fonts', 'dejavuserif-italic');
INSERT INTO params VALUES (4887, 'Fonts', 'dejavuserif');
INSERT INTO params VALUES (4888, 'Fonts', 'dejavuserifcondensed-bold');
INSERT INTO params VALUES (4889, 'Fonts', 'dejavuserifcondensed-bolditalic');
INSERT INTO params VALUES (4890, 'Fonts', 'dejavuserifcondensed-italic');
INSERT INTO params VALUES (4891, 'Fonts', 'dejavuserifcondensed');
INSERT INTO params VALUES (4892, 'Fonts', 'delphine');
INSERT INTO params VALUES (4893, 'Fonts', 'dented');
INSERT INTO params VALUES (4894, 'Fonts', 'dephun2');
INSERT INTO params VALUES (4895, 'Fonts', 'detonate');
INSERT INTO params VALUES (4896, 'Fonts', 'dictsym');
INSERT INTO params VALUES (4897, 'Fonts', 'dingbats');
INSERT INTO params VALUES (4898, 'Fonts', 'discorda');
INSERT INTO params VALUES (4899, 'Fonts', 'dkg');
INSERT INTO params VALUES (4900, 'Fonts', 'dkgbd');
INSERT INTO params VALUES (4901, 'Fonts', 'dkgbi');
INSERT INTO params VALUES (4902, 'Fonts', 'dkgit');
INSERT INTO params VALUES (4903, 'Fonts', 'doulossilr');
INSERT INTO params VALUES (4904, 'Fonts', 'draggle');
INSERT INTO params VALUES (4905, 'Fonts', 'draggleo');
INSERT INTO params VALUES (4906, 'Fonts', 'drugulinclm-bold');
INSERT INTO params VALUES (4907, 'Fonts', 'drugulinclm-bolditalic');
INSERT INTO params VALUES (4908, 'Fonts', 'dsrom10');
INSERT INTO params VALUES (4909, 'Fonts', 'dsrom12');
INSERT INTO params VALUES (4910, 'Fonts', 'dsrom8');
INSERT INTO params VALUES (4911, 'Fonts', 'dsss10');
INSERT INTO params VALUES (4912, 'Fonts', 'dsss12');
INSERT INTO params VALUES (4913, 'Fonts', 'dsss8');
INSERT INTO params VALUES (4914, 'Fonts', 'dynamic');
INSERT INTO params VALUES (4915, 'Fonts', 'dyphusio');
INSERT INTO params VALUES (4916, 'Fonts', 'dystorqu');
INSERT INTO params VALUES (4917, 'Fonts', 'ecliptic');
INSERT INTO params VALUES (4918, 'Fonts', 'editundo');
INSERT INTO params VALUES (4919, 'Fonts', 'edundot');
INSERT INTO params VALUES (4920, 'Fonts', 'edunline');
INSERT INTO params VALUES (4921, 'Fonts', 'elegbold');
INSERT INTO params VALUES (4922, 'Fonts', 'elegital');
INSERT INTO params VALUES (4923, 'Fonts', 'elleboli');
INSERT INTO params VALUES (4924, 'Fonts', 'ellenbold');
INSERT INTO params VALUES (4925, 'Fonts', 'ellenike');
INSERT INTO params VALUES (4926, 'Fonts', 'ellenita');
INSERT INTO params VALUES (4927, 'Fonts', 'elliniaclm-bold');
INSERT INTO params VALUES (4928, 'Fonts', 'elliniaclm-bolditalic');
INSERT INTO params VALUES (4929, 'Fonts', 'elliniaclm-light');
INSERT INTO params VALUES (4930, 'Fonts', 'elliniaclm-lightitalic');
INSERT INTO params VALUES (4931, 'Fonts', 'elsewhe2');
INSERT INTO params VALUES (4932, 'Fonts', 'elsewher');
INSERT INTO params VALUES (4933, 'Fonts', 'embosst1');
INSERT INTO params VALUES (4934, 'Fonts', 'embosst2');
INSERT INTO params VALUES (4935, 'Fonts', 'embosst3');
INSERT INTO params VALUES (4936, 'Fonts', 'emerita_latina');
INSERT INTO params VALUES (4937, 'Fonts', 'encappln');
INSERT INTO params VALUES (4938, 'Fonts', 'encapsul');
INSERT INTO params VALUES (4939, 'Fonts', 'engadget');
INSERT INTO params VALUES (4940, 'Fonts', 'entangle');
INSERT INTO params VALUES (4941, 'Fonts', 'enthuse');
INSERT INTO params VALUES (4942, 'Fonts', 'enthuses');
INSERT INTO params VALUES (4943, 'Fonts', 'entlayra');
INSERT INTO params VALUES (4944, 'Fonts', 'entlayrb');
INSERT INTO params VALUES (4945, 'Fonts', 'entplain');
INSERT INTO params VALUES (4946, 'Fonts', 'eocc10');
INSERT INTO params VALUES (4947, 'Fonts', 'eorm10');
INSERT INTO params VALUES (4948, 'Fonts', 'eosl10');
INSERT INTO params VALUES (4949, 'Fonts', 'eoti10');
INSERT INTO params VALUES (4950, 'Fonts', 'essays1743-bold');
INSERT INTO params VALUES (4951, 'Fonts', 'essays1743-bolditalic');
INSERT INTO params VALUES (4952, 'Fonts', 'essays1743-italic');
INSERT INTO params VALUES (4953, 'Fonts', 'essays1743');
INSERT INTO params VALUES (4954, 'Fonts', 'euphor3d');
INSERT INTO params VALUES (4955, 'Fonts', 'euphoric');
INSERT INTO params VALUES (4956, 'Fonts', 'europeancomputermodern-bold10pt');
INSERT INTO params VALUES (4957, 'Fonts', 'europeancomputermodern-boldextended10pt');
INSERT INTO params VALUES (4958, 'Fonts', 'europeancomputermodern-boldextended12pt');
INSERT INTO params VALUES (4959, 'Fonts', 'europeancomputermodern-boldextended17pt');
INSERT INTO params VALUES (4960, 'Fonts', 'europeancomputermodern-boldextended7pt');
INSERT INTO params VALUES (4961, 'Fonts', 'europeancomputermodern-demibold10pt');
INSERT INTO params VALUES (4962, 'Fonts', 'europeancomputermodern-italicbold10pt');
INSERT INTO params VALUES (4963, 'Fonts', 'europeancomputermodern-italicregular10pt');
INSERT INTO params VALUES (4964, 'Fonts', 'europeancomputermodern-italicregular12pt');
INSERT INTO params VALUES (4965, 'Fonts', 'europeancomputermodern-italicregular7pt');
INSERT INTO params VALUES (4966, 'Fonts', 'europeancomputermodern-obliqueregular10pt');
INSERT INTO params VALUES (4967, 'Fonts', 'europeancomputermodern-obliqueregular12pt');
INSERT INTO params VALUES (4968, 'Fonts', 'europeancomputermodern-obliqueregular7pt');
INSERT INTO params VALUES (4969, 'Fonts', 'europeancomputermodern-regular10pt');
INSERT INTO params VALUES (4970, 'Fonts', 'europeancomputermodern-regularcondensed10pt');
INSERT INTO params VALUES (4971, 'Fonts', 'europeancomputermodern-regularextended10pt');
INSERT INTO params VALUES (4972, 'Fonts', 'europeancomputermodern-regularextended12pt');
INSERT INTO params VALUES (4973, 'Fonts', 'europeancomputermodern-regularextended17pt');
INSERT INTO params VALUES (4974, 'Fonts', 'europeancomputermodern-romanbold10pt');
INSERT INTO params VALUES (4975, 'Fonts', 'europeancomputermodern-romanregular10pt');
INSERT INTO params VALUES (4976, 'Fonts', 'europeancomputermodern-romanregular12pt');
INSERT INTO params VALUES (4977, 'Fonts', 'europeancomputermodern-romanregular17pt');
INSERT INTO params VALUES (4978, 'Fonts', 'europeancomputermodern-romanregular5pt');
INSERT INTO params VALUES (4979, 'Fonts', 'europeancomputermodern-romanregular7pt');
INSERT INTO params VALUES (4980, 'Fonts', 'europeancomputermodern-smallcapsregular10pt');
INSERT INTO params VALUES (4981, 'Fonts', 'europeancomputermodern-smallcapsregular12pt');
INSERT INTO params VALUES (4982, 'Fonts', 'europeancomputermodern-smallcapsregular7pt');
INSERT INTO params VALUES (4983, 'Fonts', 'europeancomputermodernsans-demiboldcondensed10pt');
INSERT INTO params VALUES (4984, 'Fonts', 'europeancomputermodernsans-regular10pt');
INSERT INTO params VALUES (4985, 'Fonts', 'europeancomputermodernsans-regular12pt');
INSERT INTO params VALUES (4986, 'Fonts', 'europeancomputermodernsans-regular7pt');
INSERT INTO params VALUES (4987, 'Fonts', 'europeancomputermoderntypewriter-regular10pt');
INSERT INTO params VALUES (4988, 'Fonts', 'europeancomputermoderntypewriter-regular12pt');
INSERT INTO params VALUES (4989, 'Fonts', 'europeancomputermoderntypewriter-regular7pt');
INSERT INTO params VALUES (4990, 'Fonts', 'euxm10');
INSERT INTO params VALUES (4991, 'Fonts', 'euxm7');
INSERT INTO params VALUES (4992, 'Fonts', 'exagger8');
INSERT INTO params VALUES (4993, 'Fonts', 'extracti');
INSERT INTO params VALUES (4994, 'Fonts', 'f500');
INSERT INTO params VALUES (4995, 'Fonts', 'falsepos');
INSERT INTO params VALUES (4996, 'Fonts', 'falsposr');
INSERT INTO params VALUES (4997, 'Fonts', 'fascii');
INSERT INTO params VALUES (4998, 'Fonts', 'fasciicr');
INSERT INTO params VALUES (4999, 'Fonts', 'fasciisc');
INSERT INTO params VALUES (5000, 'Fonts', 'fasciism');
INSERT INTO params VALUES (5001, 'Fonts', 'fasciitw');
INSERT INTO params VALUES (5002, 'Fonts', 'fauxsnow');
INSERT INTO params VALUES (5003, 'Fonts', 'fbsbltc');
INSERT INTO params VALUES (5004, 'Fonts', 'fbsbltc2');
INSERT INTO params VALUES (5005, 'Fonts', 'feta-alphabet11');
INSERT INTO params VALUES (5006, 'Fonts', 'feta-alphabet13');
INSERT INTO params VALUES (5007, 'Fonts', 'feta-alphabet14');
INSERT INTO params VALUES (5008, 'Fonts', 'feta-alphabet16');
INSERT INTO params VALUES (5009, 'Fonts', 'feta-alphabet18');
INSERT INTO params VALUES (5010, 'Fonts', 'feta-alphabet20');
INSERT INTO params VALUES (5011, 'Fonts', 'feta-alphabet23');
INSERT INTO params VALUES (5012, 'Fonts', 'feta-alphabet26');
INSERT INTO params VALUES (5013, 'Fonts', 'feta-braces-a');
INSERT INTO params VALUES (5014, 'Fonts', 'feta-braces-b');
INSERT INTO params VALUES (5015, 'Fonts', 'feta-braces-c');
INSERT INTO params VALUES (5016, 'Fonts', 'feta-braces-d');
INSERT INTO params VALUES (5017, 'Fonts', 'feta-braces-e');
INSERT INTO params VALUES (5018, 'Fonts', 'feta-braces-f');
INSERT INTO params VALUES (5019, 'Fonts', 'feta-braces-g');
INSERT INTO params VALUES (5020, 'Fonts', 'feta-braces-h');
INSERT INTO params VALUES (5021, 'Fonts', 'feta-braces-i');
INSERT INTO params VALUES (5022, 'Fonts', 'feta11');
INSERT INTO params VALUES (5023, 'Fonts', 'feta13');
INSERT INTO params VALUES (5024, 'Fonts', 'feta14');
INSERT INTO params VALUES (5025, 'Fonts', 'feta16');
INSERT INTO params VALUES (5026, 'Fonts', 'feta18');
INSERT INTO params VALUES (5027, 'Fonts', 'feta20');
INSERT INTO params VALUES (5028, 'Fonts', 'feta23');
INSERT INTO params VALUES (5029, 'Fonts', 'feta26');
INSERT INTO params VALUES (5030, 'Fonts', 'fidgety');
INSERT INTO params VALUES (5031, 'Fonts', 'flipside');
INSERT INTO params VALUES (5032, 'Fonts', 'foekfont');
INSERT INTO params VALUES (5033, 'Fonts', 'font');
INSERT INTO params VALUES (5034, 'Fonts', 'forcible');
INSERT INTO params VALUES (5035, 'Fonts', 'fourier-math-blackboard');
INSERT INTO params VALUES (5036, 'Fonts', 'fourier-math-cal');
INSERT INTO params VALUES (5037, 'Fonts', 'fourier-math-extension');
INSERT INTO params VALUES (5038, 'Fonts', 'fourier-math-letters-bold-italic');
INSERT INTO params VALUES (5039, 'Fonts', 'fourier-math-letters-bold');
INSERT INTO params VALUES (5040, 'Fonts', 'fourier-math-letters-italic');
INSERT INTO params VALUES (5041, 'Fonts', 'fourier-math-letters');
INSERT INTO params VALUES (5042, 'Fonts', 'fourier-math-symbols');
INSERT INTO params VALUES (5043, 'Fonts', 'fourier-orns');
INSERT INTO params VALUES (5044, 'Fonts', 'frankruehlclm-bold');
INSERT INTO params VALUES (5045, 'Fonts', 'frankruehlclm-boldoblique');
INSERT INTO params VALUES (5046, 'Fonts', 'frankruehlclm-medium');
INSERT INTO params VALUES (5047, 'Fonts', 'frankruehlclm-mediumoblique');
INSERT INTO params VALUES (5048, 'Fonts', 'freaktur');
INSERT INTO params VALUES (5049, 'Fonts', 'freeeuro');
INSERT INTO params VALUES (5050, 'Fonts', 'freemono');
INSERT INTO params VALUES (5051, 'Fonts', 'freemonobold');
INSERT INTO params VALUES (5052, 'Fonts', 'freemonoboldoblique');
INSERT INTO params VALUES (5053, 'Fonts', 'freemonooblique');
INSERT INTO params VALUES (5054, 'Fonts', 'freesans');
INSERT INTO params VALUES (5055, 'Fonts', 'freesansbold');
INSERT INTO params VALUES (5056, 'Fonts', 'freesansboldoblique');
INSERT INTO params VALUES (5057, 'Fonts', 'freesansoblique');
INSERT INTO params VALUES (5058, 'Fonts', 'freeserif');
INSERT INTO params VALUES (5059, 'Fonts', 'freeserifbold');
INSERT INTO params VALUES (5060, 'Fonts', 'freeserifbolditalic');
INSERT INTO params VALUES (5061, 'Fonts', 'freeserifitalic');
INSERT INTO params VALUES (5062, 'Fonts', 'frizzed');
INSERT INTO params VALUES (5063, 'Fonts', 'fullcomp');
INSERT INTO params VALUES (5064, 'Fonts', 'galapogo');
INSERT INTO params VALUES (5065, 'Fonts', 'galsilb');
INSERT INTO params VALUES (5066, 'Fonts', 'galsilr');
INSERT INTO params VALUES (5067, 'Fonts', 'galvaniz');
INSERT INTO params VALUES (5068, 'Fonts', 'gaposiso');
INSERT INTO params VALUES (5069, 'Fonts', 'gaposiss');
INSERT INTO params VALUES (5070, 'Fonts', 'gasping');
INSERT INTO params VALUES (5071, 'Fonts', 'gather');
INSERT INTO params VALUES (5072, 'Fonts', 'gathrgap');
INSERT INTO params VALUES (5073, 'Fonts', 'genai102');
INSERT INTO params VALUES (5074, 'Fonts', 'genar102');
INSERT INTO params VALUES (5075, 'Fonts', 'genbasb');
INSERT INTO params VALUES (5076, 'Fonts', 'genbasbi');
INSERT INTO params VALUES (5077, 'Fonts', 'genbasi');
INSERT INTO params VALUES (5078, 'Fonts', 'genbasr');
INSERT INTO params VALUES (5079, 'Fonts', 'genbkbasb');
INSERT INTO params VALUES (5080, 'Fonts', 'genbkbasbi');
INSERT INTO params VALUES (5081, 'Fonts', 'genbkbasi');
INSERT INTO params VALUES (5082, 'Fonts', 'genbkbasr');
INSERT INTO params VALUES (5083, 'Fonts', 'geni102');
INSERT INTO params VALUES (5084, 'Fonts', 'genotyph');
INSERT INTO params VALUES (5085, 'Fonts', 'genotyps');
INSERT INTO params VALUES (5086, 'Fonts', 'genotyrh');
INSERT INTO params VALUES (5087, 'Fonts', 'genotyrs');
INSERT INTO params VALUES (5088, 'Fonts', 'genr102');
INSERT INTO params VALUES (5089, 'Fonts', 'gesture');
INSERT INTO params VALUES (5090, 'Fonts', 'gestures');
INSERT INTO params VALUES (5091, 'Fonts', 'gesturet');
INSERT INTO params VALUES (5092, 'Fonts', 'gesturts');
INSERT INTO params VALUES (5093, 'Fonts', 'gilliusadf-bold');
INSERT INTO params VALUES (5094, 'Fonts', 'gilliusadf-bolditalic');
INSERT INTO params VALUES (5095, 'Fonts', 'gilliusadf-italic');
INSERT INTO params VALUES (5096, 'Fonts', 'gilliusadf-regular');
INSERT INTO params VALUES (5097, 'Fonts', 'gilliusadfcd-bold');
INSERT INTO params VALUES (5098, 'Fonts', 'gilliusadfcd-bolditalic');
INSERT INTO params VALUES (5099, 'Fonts', 'gilliusadfcd-italic');
INSERT INTO params VALUES (5100, 'Fonts', 'gilliusadfcd-regular');
INSERT INTO params VALUES (5101, 'Fonts', 'gilliusadfno2-bold');
INSERT INTO params VALUES (5102, 'Fonts', 'gilliusadfno2-bolditalic');
INSERT INTO params VALUES (5103, 'Fonts', 'gilliusadfno2-italic');
INSERT INTO params VALUES (5104, 'Fonts', 'gilliusadfno2-regular');
INSERT INTO params VALUES (5105, 'Fonts', 'gilliusadfno2cd-bold');
INSERT INTO params VALUES (5106, 'Fonts', 'gilliusadfno2cd-bolditalic');
INSERT INTO params VALUES (5107, 'Fonts', 'gilliusadfno2cd-italic');
INSERT INTO params VALUES (5108, 'Fonts', 'gilliusadfno2cd-regular');
INSERT INTO params VALUES (5109, 'Fonts', 'gosebmp2');
INSERT INTO params VALUES (5110, 'Fonts', 'gosebmps');
INSERT INTO params VALUES (5111, 'Fonts', 'goudybookletter1911');
INSERT INTO params VALUES (5112, 'Fonts', 'goudybookletter1911bold');
INSERT INTO params VALUES (5113, 'Fonts', 'goudybookletter1911boldcondensed');
INSERT INTO params VALUES (5114, 'Fonts', 'goudybookletter1911condensed');
INSERT INTO params VALUES (5115, 'Fonts', 'goudybookletter1911italic');
INSERT INTO params VALUES (5116, 'Fonts', 'goudybookletter1911italiccondensed');
INSERT INTO params VALUES (5117, 'Fonts', 'goudybookletter1911light');
INSERT INTO params VALUES (5118, 'Fonts', 'goudybookletter1911lightcondensed');
INSERT INTO params VALUES (5119, 'Fonts', 'gr8higts');
INSERT INTO params VALUES (5120, 'Fonts', 'granular');
INSERT INTO params VALUES (5121, 'Fonts', 'grapple');
INSERT INTO params VALUES (5122, 'Fonts', 'graveyrd');
INSERT INTO params VALUES (5123, 'Fonts', 'graviseg');
INSERT INTO params VALUES (5124, 'Fonts', 'gravitat');
INSERT INTO params VALUES (5125, 'Fonts', 'graze');
INSERT INTO params VALUES (5126, 'Fonts', 'grmn10');
INSERT INTO params VALUES (5127, 'Fonts', 'grotesq');
INSERT INTO params VALUES (5128, 'Fonts', 'grudge');
INSERT INTO params VALUES (5129, 'Fonts', 'grudge2');
INSERT INTO params VALUES (5130, 'Fonts', 'grxn10');
INSERT INTO params VALUES (5131, 'Fonts', 'gyneric');
INSERT INTO params VALUES (5132, 'Fonts', 'gyneric3');
INSERT INTO params VALUES (5133, 'Fonts', 'gyroresh');
INSERT INTO params VALUES (5134, 'Fonts', 'gyrose');
INSERT INTO params VALUES (5135, 'Fonts', 'gyrosesq');
INSERT INTO params VALUES (5136, 'Fonts', 'hackslsh');
INSERT INTO params VALUES (5137, 'Fonts', 'hairball');
INSERT INTO params VALUES (5138, 'Fonts', 'handmedo');
INSERT INTO params VALUES (5139, 'Fonts', 'handmeds');
INSERT INTO params VALUES (5140, 'Fonts', 'hassle');
INSERT INTO params VALUES (5141, 'Fonts', 'hbevel');
INSERT INTO params VALUES (5142, 'Fonts', 'hdmaker');
INSERT INTO params VALUES (5143, 'Fonts', 'hearts');
INSERT INTO params VALUES (5144, 'Fonts', 'hfbr10');
INSERT INTO params VALUES (5145, 'Fonts', 'hfbr17');
INSERT INTO params VALUES (5146, 'Fonts', 'hfbr8');
INSERT INTO params VALUES (5147, 'Fonts', 'hfbr9');
INSERT INTO params VALUES (5148, 'Fonts', 'hfbras10');
INSERT INTO params VALUES (5149, 'Fonts', 'hfbras8');
INSERT INTO params VALUES (5150, 'Fonts', 'hfbras9');
INSERT INTO params VALUES (5151, 'Fonts', 'hfbrbs10');
INSERT INTO params VALUES (5152, 'Fonts', 'hfbrbs8');
INSERT INTO params VALUES (5153, 'Fonts', 'hfbrbs9');
INSERT INTO params VALUES (5154, 'Fonts', 'hfbrbx10');
INSERT INTO params VALUES (5155, 'Fonts', 'hfbrmb10');
INSERT INTO params VALUES (5156, 'Fonts', 'hfbrmi10');
INSERT INTO params VALUES (5157, 'Fonts', 'hfbrmi8');
INSERT INTO params VALUES (5158, 'Fonts', 'hfbrmi9');
INSERT INTO params VALUES (5159, 'Fonts', 'hfbrsl10');
INSERT INTO params VALUES (5160, 'Fonts', 'hfbrsl17');
INSERT INTO params VALUES (5161, 'Fonts', 'hfbrsl8');
INSERT INTO params VALUES (5162, 'Fonts', 'hfbrsl9');
INSERT INTO params VALUES (5163, 'Fonts', 'hfbrsy10');
INSERT INTO params VALUES (5164, 'Fonts', 'hfbrsy8');
INSERT INTO params VALUES (5165, 'Fonts', 'hfbrsy9');
INSERT INTO params VALUES (5166, 'Fonts', 'hfsltl10');
INSERT INTO params VALUES (5167, 'Fonts', 'hftl10');
INSERT INTO params VALUES (5168, 'Fonts', 'hillock');
INSERT INTO params VALUES (5169, 'Fonts', 'homespun');
INSERT INTO params VALUES (5170, 'Fonts', 'hyde');
INSERT INTO params VALUES (5171, 'Fonts', 'hyperion');
INSERT INTO params VALUES (5172, 'Fonts', 'ikariusadf-bold');
INSERT INTO params VALUES (5173, 'Fonts', 'ikariusadf-bolditalic');
INSERT INTO params VALUES (5174, 'Fonts', 'ikariusadf-italic');
INSERT INTO params VALUES (5175, 'Fonts', 'ikariusadf-regular');
INSERT INTO params VALUES (5176, 'Fonts', 'ikariusadfno2-bold');
INSERT INTO params VALUES (5177, 'Fonts', 'ikariusadfno2-bolditalic');
INSERT INTO params VALUES (5178, 'Fonts', 'ikariusadfno2-italic');
INSERT INTO params VALUES (5179, 'Fonts', 'ikariusadfno2-regular');
INSERT INTO params VALUES (5180, 'Fonts', 'ilits');
INSERT INTO params VALUES (5181, 'Fonts', 'imposs');
INSERT INTO params VALUES (5182, 'Fonts', 'inertia');
INSERT INTO params VALUES (5183, 'Fonts', 'inevitab');
INSERT INTO params VALUES (5184, 'Fonts', 'inkswipe');
INSERT INTO params VALUES (5185, 'Fonts', 'inktank');
INSERT INTO params VALUES (5186, 'Fonts', 'intersc');
INSERT INTO params VALUES (5187, 'Fonts', 'intersec');
INSERT INTO params VALUES (5188, 'Fonts', 'interso');
INSERT INTO params VALUES (5189, 'Fonts', 'inuit-bold-oblique');
INSERT INTO params VALUES (5190, 'Fonts', 'inuit-bold');
INSERT INTO params VALUES (5191, 'Fonts', 'inuit-oblique');
INSERT INTO params VALUES (5192, 'Fonts', 'inuit');
INSERT INTO params VALUES (5193, 'Fonts', 'ipabold');
INSERT INTO params VALUES (5194, 'Fonts', 'ipabolit');
INSERT INTO params VALUES (5195, 'Fonts', 'ipaitali');
INSERT INTO params VALUES (5196, 'Fonts', 'iparegul');
INSERT INTO params VALUES (5197, 'Fonts', 'irritate');
INSERT INTO params VALUES (5198, 'Fonts', 'isabella');
INSERT INTO params VALUES (5199, 'Fonts', 'iwona-bold');
INSERT INTO params VALUES (5200, 'Fonts', 'iwona-bolditalic');
INSERT INTO params VALUES (5201, 'Fonts', 'iwona-italic');
INSERT INTO params VALUES (5202, 'Fonts', 'iwona-regular');
INSERT INTO params VALUES (5203, 'Fonts', 'iwonacond-bold');
INSERT INTO params VALUES (5204, 'Fonts', 'iwonacond-bolditalic');
INSERT INTO params VALUES (5205, 'Fonts', 'iwonacond-italic');
INSERT INTO params VALUES (5206, 'Fonts', 'iwonacond-regular');
INSERT INTO params VALUES (5207, 'Fonts', 'iwonacondheavy-italic');
INSERT INTO params VALUES (5208, 'Fonts', 'iwonacondheavy-regular');
INSERT INTO params VALUES (5209, 'Fonts', 'iwonacondlight-italic');
INSERT INTO params VALUES (5210, 'Fonts', 'iwonacondlight-regular');
INSERT INTO params VALUES (5211, 'Fonts', 'iwonacondmedium-italic');
INSERT INTO params VALUES (5212, 'Fonts', 'iwonacondmedium-regular');
INSERT INTO params VALUES (5213, 'Fonts', 'iwonaheavy-italic');
INSERT INTO params VALUES (5214, 'Fonts', 'iwonaheavy-regular');
INSERT INTO params VALUES (5215, 'Fonts', 'iwonalight-italic');
INSERT INTO params VALUES (5216, 'Fonts', 'iwonalight-regular');
INSERT INTO params VALUES (5217, 'Fonts', 'iwonamedium-italic');
INSERT INTO params VALUES (5218, 'Fonts', 'iwonamedium-regular');
INSERT INTO params VALUES (5219, 'Fonts', 'jagged');
INSERT INTO params VALUES (5220, 'Fonts', 'janaskrivana');
INSERT INTO params VALUES (5221, 'Fonts', 'janaskrivanabold');
INSERT INTO params VALUES (5222, 'Fonts', 'janaskrivanaboldoblique');
INSERT INTO params VALUES (5223, 'Fonts', 'janaskrivanaboldreverseoblique');
INSERT INTO params VALUES (5224, 'Fonts', 'janaskrivanaoblique');
INSERT INTO params VALUES (5225, 'Fonts', 'janaskrivanareverseoblique');
INSERT INTO params VALUES (5226, 'Fonts', 'janken');
INSERT INTO params VALUES (5227, 'Fonts', 'jara');
INSERT INTO params VALUES (5228, 'Fonts', 'jara_bold-it');
INSERT INTO params VALUES (5229, 'Fonts', 'jara_bold');
INSERT INTO params VALUES (5230, 'Fonts', 'jara_it');
INSERT INTO params VALUES (5231, 'Fonts', 'jargon');
INSERT INTO params VALUES (5232, 'Fonts', 'jasper');
INSERT INTO params VALUES (5233, 'Fonts', 'jaspers');
INSERT INTO params VALUES (5234, 'Fonts', 'jawbhard');
INSERT INTO params VALUES (5235, 'Fonts', 'jawbreak');
INSERT INTO params VALUES (5236, 'Fonts', 'jawbrko1');
INSERT INTO params VALUES (5237, 'Fonts', 'jawbrko2');
INSERT INTO params VALUES (5238, 'Fonts', 'jekyll');
INSERT INTO params VALUES (5239, 'Fonts', 'jeopardi');
INSERT INTO params VALUES (5240, 'Fonts', 'jeopardt');
INSERT INTO params VALUES (5241, 'Fonts', 'jmacscrl');
INSERT INTO params VALUES (5242, 'Fonts', 'joltcaff');
INSERT INTO params VALUES (5243, 'Fonts', 'junicode-bold');
INSERT INTO params VALUES (5244, 'Fonts', 'junicode-boldcondensed');
INSERT INTO params VALUES (5245, 'Fonts', 'junicode-bolditalic');
INSERT INTO params VALUES (5246, 'Fonts', 'junicode-bolditaliccondensed');
INSERT INTO params VALUES (5247, 'Fonts', 'junicode-italic');
INSERT INTO params VALUES (5248, 'Fonts', 'junicode-italiccondensed');
INSERT INTO params VALUES (5249, 'Fonts', 'junicode-regular');
INSERT INTO params VALUES (5250, 'Fonts', 'junicode-regularcondensed');
INSERT INTO params VALUES (5251, 'Fonts', 'jupiterc');
INSERT INTO params VALUES (5252, 'Fonts', 'jurabook');
INSERT INTO params VALUES (5253, 'Fonts', 'jurademibold');
INSERT INTO params VALUES (5254, 'Fonts', 'juralight');
INSERT INTO params VALUES (5255, 'Fonts', 'juramedium');
INSERT INTO params VALUES (5256, 'Fonts', 'kacstart');
INSERT INTO params VALUES (5257, 'Fonts', 'kacstbook');
INSERT INTO params VALUES (5258, 'Fonts', 'kacstdecorative');
INSERT INTO params VALUES (5259, 'Fonts', 'kacstdigital');
INSERT INTO params VALUES (5260, 'Fonts', 'kacstfarsi');
INSERT INTO params VALUES (5261, 'Fonts', 'kacstletter');
INSERT INTO params VALUES (5262, 'Fonts', 'kacstnaskh');
INSERT INTO params VALUES (5263, 'Fonts', 'kacstoffice');
INSERT INTO params VALUES (5264, 'Fonts', 'kacstone');
INSERT INTO params VALUES (5265, 'Fonts', 'kacstpen');
INSERT INTO params VALUES (5266, 'Fonts', 'kacstposter');
INSERT INTO params VALUES (5267, 'Fonts', 'kacstqurn');
INSERT INTO params VALUES (5268, 'Fonts', 'kacstscreen');
INSERT INTO params VALUES (5269, 'Fonts', 'kacsttitle');
INSERT INTO params VALUES (5270, 'Fonts', 'kacsttitlel');
INSERT INTO params VALUES (5271, 'Fonts', 'kaliberr');
INSERT INTO params VALUES (5272, 'Fonts', 'kalibers');
INSERT INTO params VALUES (5273, 'Fonts', 'kaliberx');
INSERT INTO params VALUES (5274, 'Fonts', 'kataacti');
INSERT INTO params VALUES (5275, 'Fonts', 'katainac');
INSERT INTO params VALUES (5276, 'Fonts', 'keyrialt');
INSERT INTO params VALUES (5277, 'Fonts', 'keyridge');
INSERT INTO params VALUES (5278, 'Fonts', 'kickflip');
INSERT INTO params VALUES (5279, 'Fonts', 'kinkaid');
INSERT INTO params VALUES (5280, 'Fonts', 'kirbyss');
INSERT INTO params VALUES (5281, 'Fonts', 'knot');
INSERT INTO params VALUES (5282, 'Fonts', 'konatu');
INSERT INTO params VALUES (5283, 'Fonts', 'konatutohaba');
INSERT INTO params VALUES (5284, 'Fonts', 'konecto1');
INSERT INTO params VALUES (5285, 'Fonts', 'konecto2');
INSERT INTO params VALUES (5286, 'Fonts', 'konector');
INSERT INTO params VALUES (5287, 'Fonts', 'koneerie');
INSERT INTO params VALUES (5288, 'Fonts', 'kurvatur');
INSERT INTO params VALUES (5289, 'Fonts', 'labi1000');
INSERT INTO params VALUES (5290, 'Fonts', 'labl1000');
INSERT INTO params VALUES (5291, 'Fonts', 'labx1000');
INSERT INTO params VALUES (5292, 'Fonts', 'labx1700');
INSERT INTO params VALUES (5293, 'Fonts', 'lacc1000');
INSERT INTO params VALUES (5294, 'Fonts', 'ladh1000');
INSERT INTO params VALUES (5295, 'Fonts', 'lakeshor');
INSERT INTO params VALUES (5296, 'Fonts', 'lamebrai');
INSERT INTO params VALUES (5297, 'Fonts', 'larkspur');
INSERT INTO params VALUES (5298, 'Fonts', 'larm1000');
INSERT INTO params VALUES (5299, 'Fonts', 'larm700');
INSERT INTO params VALUES (5300, 'Fonts', 'lasi1000');
INSERT INTO params VALUES (5301, 'Fonts', 'lasl1000');
INSERT INTO params VALUES (5302, 'Fonts', 'laso1000');
INSERT INTO params VALUES (5303, 'Fonts', 'lass1000');
INSERT INTO params VALUES (5304, 'Fonts', 'last1000');
INSERT INTO params VALUES (5305, 'Fonts', 'lasx1000');
INSERT INTO params VALUES (5306, 'Fonts', 'lati1000');
INSERT INTO params VALUES (5307, 'Fonts', 'latt1000');
INSERT INTO params VALUES (5308, 'Fonts', 'laxc1000');
INSERT INTO params VALUES (5309, 'Fonts', 'lethargi');
INSERT INTO params VALUES (5310, 'Fonts', 'liberationmono-bold');
INSERT INTO params VALUES (5311, 'Fonts', 'liberationmono-bolditalic');
INSERT INTO params VALUES (5312, 'Fonts', 'liberationmono-italic');
INSERT INTO params VALUES (5313, 'Fonts', 'liberationmono-regular');
INSERT INTO params VALUES (5314, 'Fonts', 'liberationsans-bold');
INSERT INTO params VALUES (5315, 'Fonts', 'liberationsans-bolditalic');
INSERT INTO params VALUES (5316, 'Fonts', 'liberationsans-italic');
INSERT INTO params VALUES (5317, 'Fonts', 'liberationsans-regular');
INSERT INTO params VALUES (5318, 'Fonts', 'liberationserif-bold');
INSERT INTO params VALUES (5319, 'Fonts', 'liberationserif-bolditalic');
INSERT INTO params VALUES (5320, 'Fonts', 'liberationserif-italic');
INSERT INTO params VALUES (5321, 'Fonts', 'liberationserif-regular');
INSERT INTO params VALUES (5322, 'Fonts', 'licostrg');
INSERT INTO params VALUES (5323, 'Fonts', 'lightout');
INSERT INTO params VALUES (5324, 'Fonts', 'lineara');
INSERT INTO params VALUES (5325, 'Fonts', 'linearacmplxsigns');
INSERT INTO params VALUES (5326, 'Fonts', 'lineding');
INSERT INTO params VALUES (5327, 'Fonts', 'linlibertine_bd');
INSERT INTO params VALUES (5328, 'Fonts', 'linlibertine_bi');
INSERT INTO params VALUES (5329, 'Fonts', 'linlibertine_it');
INSERT INTO params VALUES (5330, 'Fonts', 'linlibertine_re');
INSERT INTO params VALUES (5331, 'Fonts', 'linlibertinec_re');
INSERT INTO params VALUES (5332, 'Fonts', 'lmmathextension10-regular');
INSERT INTO params VALUES (5333, 'Fonts', 'lmmathitalic10-bolditalic');
INSERT INTO params VALUES (5334, 'Fonts', 'lmmathitalic10-italic');
INSERT INTO params VALUES (5335, 'Fonts', 'lmmathitalic12-italic');
INSERT INTO params VALUES (5336, 'Fonts', 'lmmathitalic5-bolditalic');
INSERT INTO params VALUES (5337, 'Fonts', 'lmmathitalic5-italic');
INSERT INTO params VALUES (5338, 'Fonts', 'lmmathitalic6-italic');
INSERT INTO params VALUES (5339, 'Fonts', 'lmmathitalic7-bolditalic');
INSERT INTO params VALUES (5340, 'Fonts', 'lmmathitalic7-italic');
INSERT INTO params VALUES (5341, 'Fonts', 'lmmathitalic8-italic');
INSERT INTO params VALUES (5342, 'Fonts', 'lmmathitalic9-italic');
INSERT INTO params VALUES (5343, 'Fonts', 'lmmathsymbols10-bolditalic');
INSERT INTO params VALUES (5344, 'Fonts', 'lmmathsymbols10-italic');
INSERT INTO params VALUES (5345, 'Fonts', 'lmmathsymbols5-bolditalic');
INSERT INTO params VALUES (5346, 'Fonts', 'lmmathsymbols5-italic');
INSERT INTO params VALUES (5347, 'Fonts', 'lmmathsymbols6-italic');
INSERT INTO params VALUES (5348, 'Fonts', 'lmmathsymbols7-bolditalic');
INSERT INTO params VALUES (5349, 'Fonts', 'lmmathsymbols7-italic');
INSERT INTO params VALUES (5350, 'Fonts', 'lmmathsymbols8-italic');
INSERT INTO params VALUES (5351, 'Fonts', 'lmmathsymbols9-italic');
INSERT INTO params VALUES (5352, 'Fonts', 'lmroman10-bold');
INSERT INTO params VALUES (5353, 'Fonts', 'lmroman10-bolditalic');
INSERT INTO params VALUES (5354, 'Fonts', 'lmroman10-boldoblique');
INSERT INTO params VALUES (5355, 'Fonts', 'lmroman10-capsoblique');
INSERT INTO params VALUES (5356, 'Fonts', 'lmroman10-capsregular');
INSERT INTO params VALUES (5357, 'Fonts', 'lmroman10-demi');
INSERT INTO params VALUES (5358, 'Fonts', 'lmroman10-demioblique');
INSERT INTO params VALUES (5359, 'Fonts', 'lmroman10-dunhill');
INSERT INTO params VALUES (5360, 'Fonts', 'lmroman10-dunhilloblique');
INSERT INTO params VALUES (5361, 'Fonts', 'lmroman10-italic');
INSERT INTO params VALUES (5362, 'Fonts', 'lmroman10-oblique');
INSERT INTO params VALUES (5363, 'Fonts', 'lmroman10-regular');
INSERT INTO params VALUES (5364, 'Fonts', 'lmroman10-unslanted');
INSERT INTO params VALUES (5365, 'Fonts', 'lmroman12-bold');
INSERT INTO params VALUES (5366, 'Fonts', 'lmroman12-italic');
INSERT INTO params VALUES (5367, 'Fonts', 'lmroman12-oblique');
INSERT INTO params VALUES (5368, 'Fonts', 'lmroman12-regular');
INSERT INTO params VALUES (5369, 'Fonts', 'lmroman17-oblique');
INSERT INTO params VALUES (5370, 'Fonts', 'lmroman17-regular');
INSERT INTO params VALUES (5371, 'Fonts', 'lmroman5-bold');
INSERT INTO params VALUES (5372, 'Fonts', 'lmroman5-regular');
INSERT INTO params VALUES (5373, 'Fonts', 'lmroman6-bold');
INSERT INTO params VALUES (5374, 'Fonts', 'lmroman6-regular');
INSERT INTO params VALUES (5375, 'Fonts', 'lmroman7-bold');
INSERT INTO params VALUES (5376, 'Fonts', 'lmroman7-italic');
INSERT INTO params VALUES (5377, 'Fonts', 'lmroman7-regular');
INSERT INTO params VALUES (5378, 'Fonts', 'lmroman8-bold');
INSERT INTO params VALUES (5379, 'Fonts', 'lmroman8-italic');
INSERT INTO params VALUES (5380, 'Fonts', 'lmroman8-oblique');
INSERT INTO params VALUES (5381, 'Fonts', 'lmroman8-regular');
INSERT INTO params VALUES (5382, 'Fonts', 'lmroman9-bold');
INSERT INTO params VALUES (5383, 'Fonts', 'lmroman9-italic');
INSERT INTO params VALUES (5384, 'Fonts', 'lmroman9-oblique');
INSERT INTO params VALUES (5385, 'Fonts', 'lmroman9-regular');
INSERT INTO params VALUES (5386, 'Fonts', 'lmsans10-bold');
INSERT INTO params VALUES (5387, 'Fonts', 'lmsans10-boldoblique');
INSERT INTO params VALUES (5388, 'Fonts', 'lmsans10-demicondensed');
INSERT INTO params VALUES (5389, 'Fonts', 'lmsans10-demicondensedoblique');
INSERT INTO params VALUES (5390, 'Fonts', 'lmsans10-oblique');
INSERT INTO params VALUES (5391, 'Fonts', 'lmsans10-regular');
INSERT INTO params VALUES (5392, 'Fonts', 'lmsans12-oblique');
INSERT INTO params VALUES (5393, 'Fonts', 'lmsans12-regular');
INSERT INTO params VALUES (5394, 'Fonts', 'lmsans17-oblique');
INSERT INTO params VALUES (5395, 'Fonts', 'lmsans17-regular');
INSERT INTO params VALUES (5396, 'Fonts', 'lmsans8-oblique');
INSERT INTO params VALUES (5397, 'Fonts', 'lmsans8-regular');
INSERT INTO params VALUES (5398, 'Fonts', 'lmsans9-oblique');
INSERT INTO params VALUES (5399, 'Fonts', 'lmsans9-regular');
INSERT INTO params VALUES (5400, 'Fonts', 'lmsansquotation8-bold');
INSERT INTO params VALUES (5401, 'Fonts', 'lmsansquotation8-boldoblique');
INSERT INTO params VALUES (5402, 'Fonts', 'lmsansquotation8-oblique');
INSERT INTO params VALUES (5403, 'Fonts', 'lmsansquotation8-regular');
INSERT INTO params VALUES (5404, 'Fonts', 'lmtypewriter10-capsoblique');
INSERT INTO params VALUES (5405, 'Fonts', 'lmtypewriter10-capsregular');
INSERT INTO params VALUES (5406, 'Fonts', 'lmtypewriter10-dark');
INSERT INTO params VALUES (5407, 'Fonts', 'lmtypewriter10-darkoblique');
INSERT INTO params VALUES (5408, 'Fonts', 'lmtypewriter10-italic');
INSERT INTO params VALUES (5409, 'Fonts', 'lmtypewriter10-light');
INSERT INTO params VALUES (5410, 'Fonts', 'lmtypewriter10-lightcondensed');
INSERT INTO params VALUES (5411, 'Fonts', 'lmtypewriter10-lightcondensedoblique');
INSERT INTO params VALUES (5412, 'Fonts', 'lmtypewriter10-lightoblique');
INSERT INTO params VALUES (5413, 'Fonts', 'lmtypewriter10-oblique');
INSERT INTO params VALUES (5414, 'Fonts', 'lmtypewriter10-regular');
INSERT INTO params VALUES (5415, 'Fonts', 'lmtypewriter12-regular');
INSERT INTO params VALUES (5416, 'Fonts', 'lmtypewriter8-regular');
INSERT INTO params VALUES (5417, 'Fonts', 'lmtypewriter9-regular');
INSERT INTO params VALUES (5418, 'Fonts', 'lmtypewritervarwd10-dark');
INSERT INTO params VALUES (5419, 'Fonts', 'lmtypewritervarwd10-darkoblique');
INSERT INTO params VALUES (5420, 'Fonts', 'lmtypewritervarwd10-light');
INSERT INTO params VALUES (5421, 'Fonts', 'lmtypewritervarwd10-lightoblique');
INSERT INTO params VALUES (5422, 'Fonts', 'lmtypewritervarwd10-oblique');
INSERT INTO params VALUES (5423, 'Fonts', 'lmtypewritervarwd10-regular');
INSERT INTO params VALUES (5424, 'Fonts', 'loopy');
INSERT INTO params VALUES (5425, 'Fonts', 'lowdown');
INSERT INTO params VALUES (5426, 'Fonts', 'lucid');
INSERT INTO params VALUES (5427, 'Fonts', 'lucid2');
INSERT INTO params VALUES (5428, 'Fonts', 'lucid2o');
INSERT INTO params VALUES (5429, 'Fonts', 'lucido');
INSERT INTO params VALUES (5430, 'Fonts', 'lukassvatba');
INSERT INTO params VALUES (5431, 'Fonts', 'lukassvatbabold');
INSERT INTO params VALUES (5432, 'Fonts', 'lukassvatbaboldoblique');
INSERT INTO params VALUES (5433, 'Fonts', 'lukassvatbaboldreverseoblique');
INSERT INTO params VALUES (5434, 'Fonts', 'lukassvatbaoblique');
INSERT INTO params VALUES (5435, 'Fonts', 'lukassvatbareverseoblique');
INSERT INTO params VALUES (5436, 'Fonts', 'lyneous');
INSERT INTO params VALUES (5437, 'Fonts', 'lyneousl');
INSERT INTO params VALUES (5438, 'Fonts', 'lynx');
INSERT INTO params VALUES (5439, 'Fonts', 'macropsi');
INSERT INTO params VALUES (5440, 'Fonts', 'madscrwl');
INSERT INTO params VALUES (5441, 'Fonts', 'marvosym');
INSERT INTO params VALUES (5442, 'Fonts', 'mgopencanonicabold');
INSERT INTO params VALUES (5443, 'Fonts', 'mgopencanonicabolditalic');
INSERT INTO params VALUES (5444, 'Fonts', 'mgopencanonicaitalic');
INSERT INTO params VALUES (5445, 'Fonts', 'mgopencanonicaregular');
INSERT INTO params VALUES (5446, 'Fonts', 'mgopencosmeticabold');
INSERT INTO params VALUES (5447, 'Fonts', 'mgopencosmeticaboldoblique');
INSERT INTO params VALUES (5448, 'Fonts', 'mgopencosmeticaoblique');
INSERT INTO params VALUES (5449, 'Fonts', 'mgopencosmeticaregular');
INSERT INTO params VALUES (5450, 'Fonts', 'mgopenmodatabold');
INSERT INTO params VALUES (5451, 'Fonts', 'mgopenmodataboldoblique');
INSERT INTO params VALUES (5452, 'Fonts', 'mgopenmodataoblique');
INSERT INTO params VALUES (5453, 'Fonts', 'mgopenmodataregular');
INSERT INTO params VALUES (5454, 'Fonts', 'mgopenmodernabold');
INSERT INTO params VALUES (5455, 'Fonts', 'mgopenmodernaboldoblique');
INSERT INTO params VALUES (5892, 'Fonts', 'unlearn2');
INSERT INTO params VALUES (5456, 'Fonts', 'mgopenmodernaoblique');
INSERT INTO params VALUES (5457, 'Fonts', 'mgopenmodernaregular');
INSERT INTO params VALUES (5458, 'Fonts', 'mima4x4i');
INSERT INTO params VALUES (5459, 'Fonts', 'mima4x4o');
INSERT INTO params VALUES (5460, 'Fonts', 'mimaalt1');
INSERT INTO params VALUES (5461, 'Fonts', 'mimaalt2');
INSERT INTO params VALUES (5462, 'Fonts', 'mimafuse');
INSERT INTO params VALUES (5463, 'Fonts', 'mincer');
INSERT INTO params VALUES (5464, 'Fonts', 'minikott');
INSERT INTO params VALUES (5465, 'Fonts', 'minikstt');
INSERT INTO params VALUES (5466, 'Fonts', 'miriamclm-bold');
INSERT INTO params VALUES (5467, 'Fonts', 'miriamclm-book');
INSERT INTO params VALUES (5468, 'Fonts', 'miriammonoclm-bold');
INSERT INTO params VALUES (5469, 'Fonts', 'miriammonoclm-boldoblique');
INSERT INTO params VALUES (5470, 'Fonts', 'miriammonoclm-book');
INSERT INTO params VALUES (5471, 'Fonts', 'miriammonoclm-bookoblique');
INSERT INTO params VALUES (5472, 'Fonts', 'mishmash');
INSERT INTO params VALUES (5473, 'Fonts', 'mobilize');
INSERT INTO params VALUES (5474, 'Fonts', 'monkphon');
INSERT INTO params VALUES (5475, 'Fonts', 'moronmis');
INSERT INTO params VALUES (5476, 'Fonts', 'mplus-1c-black');
INSERT INTO params VALUES (5477, 'Fonts', 'mplus-1c-bold');
INSERT INTO params VALUES (5478, 'Fonts', 'mplus-1c-heavy');
INSERT INTO params VALUES (5479, 'Fonts', 'mplus-1c-light');
INSERT INTO params VALUES (5480, 'Fonts', 'mplus-1c-medium');
INSERT INTO params VALUES (5481, 'Fonts', 'mplus-1c-regular');
INSERT INTO params VALUES (5482, 'Fonts', 'mplus-1c-thin');
INSERT INTO params VALUES (5483, 'Fonts', 'mplus-1m-bold');
INSERT INTO params VALUES (5484, 'Fonts', 'mplus-1m-light');
INSERT INTO params VALUES (5485, 'Fonts', 'mplus-1m-medium');
INSERT INTO params VALUES (5486, 'Fonts', 'mplus-1m-regular');
INSERT INTO params VALUES (5487, 'Fonts', 'mplus-1m-thin');
INSERT INTO params VALUES (5488, 'Fonts', 'mplus-1mn-bold');
INSERT INTO params VALUES (5489, 'Fonts', 'mplus-1mn-light');
INSERT INTO params VALUES (5490, 'Fonts', 'mplus-1mn-medium');
INSERT INTO params VALUES (5491, 'Fonts', 'mplus-1mn-regular');
INSERT INTO params VALUES (5492, 'Fonts', 'mplus-1mn-thin');
INSERT INTO params VALUES (5493, 'Fonts', 'mplus-1p-black');
INSERT INTO params VALUES (5494, 'Fonts', 'mplus-1p-bold');
INSERT INTO params VALUES (5495, 'Fonts', 'mplus-1p-heavy');
INSERT INTO params VALUES (5496, 'Fonts', 'mplus-1p-light');
INSERT INTO params VALUES (5497, 'Fonts', 'mplus-1p-medium');
INSERT INTO params VALUES (5498, 'Fonts', 'mplus-1p-regular');
INSERT INTO params VALUES (5499, 'Fonts', 'mplus-1p-thin');
INSERT INTO params VALUES (5500, 'Fonts', 'mplus-2c-black');
INSERT INTO params VALUES (5501, 'Fonts', 'mplus-2c-bold');
INSERT INTO params VALUES (5502, 'Fonts', 'mplus-2c-heavy');
INSERT INTO params VALUES (5503, 'Fonts', 'mplus-2c-light');
INSERT INTO params VALUES (5504, 'Fonts', 'mplus-2c-medium');
INSERT INTO params VALUES (5505, 'Fonts', 'mplus-2c-regular');
INSERT INTO params VALUES (5506, 'Fonts', 'mplus-2c-thin');
INSERT INTO params VALUES (5507, 'Fonts', 'mplus-2m-bold');
INSERT INTO params VALUES (5508, 'Fonts', 'mplus-2m-light');
INSERT INTO params VALUES (5509, 'Fonts', 'mplus-2m-medium');
INSERT INTO params VALUES (5510, 'Fonts', 'mplus-2m-regular');
INSERT INTO params VALUES (5511, 'Fonts', 'mplus-2m-thin');
INSERT INTO params VALUES (5512, 'Fonts', 'mplus-2p-black');
INSERT INTO params VALUES (5513, 'Fonts', 'mplus-2p-bold');
INSERT INTO params VALUES (5514, 'Fonts', 'mplus-2p-heavy');
INSERT INTO params VALUES (5515, 'Fonts', 'mplus-2p-light');
INSERT INTO params VALUES (5516, 'Fonts', 'mplus-2p-medium');
INSERT INTO params VALUES (5517, 'Fonts', 'mplus-2p-regular');
INSERT INTO params VALUES (5518, 'Fonts', 'mplus-2p-thin');
INSERT INTO params VALUES (5519, 'Fonts', 'mry_kacstqurn');
INSERT INTO params VALUES (5520, 'Fonts', 'mysteron');
INSERT INTO params VALUES (5521, 'Fonts', 'nachlieliclm-bold');
INSERT INTO params VALUES (5522, 'Fonts', 'nachlieliclm-boldoblique');
INSERT INTO params VALUES (5523, 'Fonts', 'nachlieliclm-light');
INSERT INTO params VALUES (5524, 'Fonts', 'nachlieliclm-lightoblique');
INSERT INTO params VALUES (5525, 'Fonts', 'nanosecw');
INSERT INTO params VALUES (5526, 'Fonts', 'naughts');
INSERT INTO params VALUES (5527, 'Fonts', 'neural');
INSERT INTO params VALUES (5528, 'Fonts', 'neuralol');
INSERT INTO params VALUES (5529, 'Fonts', 'nimbusmonl-bold');
INSERT INTO params VALUES (5530, 'Fonts', 'nimbusmonl-boldobli');
INSERT INTO params VALUES (5531, 'Fonts', 'nimbusmonl-regu');
INSERT INTO params VALUES (5532, 'Fonts', 'nimbusmonl-reguobli');
INSERT INTO params VALUES (5533, 'Fonts', 'nimbusromno9l-medi');
INSERT INTO params VALUES (5534, 'Fonts', 'nimbusromno9l-mediital');
INSERT INTO params VALUES (5535, 'Fonts', 'nimbusromno9l-regu');
INSERT INTO params VALUES (5536, 'Fonts', 'nimbusromno9l-reguital');
INSERT INTO params VALUES (5537, 'Fonts', 'nimbussanl-bold');
INSERT INTO params VALUES (5538, 'Fonts', 'nimbussanl-boldcond');
INSERT INTO params VALUES (5539, 'Fonts', 'nimbussanl-boldcondital');
INSERT INTO params VALUES (5540, 'Fonts', 'nimbussanl-boldital');
INSERT INTO params VALUES (5541, 'Fonts', 'nimbussanl-regu');
INSERT INTO params VALUES (5542, 'Fonts', 'nimbussanl-regucond');
INSERT INTO params VALUES (5543, 'Fonts', 'nimbussanl-regucondital');
INSERT INTO params VALUES (5544, 'Fonts', 'nimbussanl-reguital');
INSERT INTO params VALUES (5545, 'Fonts', 'nominal');
INSERT INTO params VALUES (5546, 'Fonts', 'nostalgi');
INSERT INTO params VALUES (5547, 'Fonts', 'notqr');
INSERT INTO params VALUES (5548, 'Fonts', 'nsecthck');
INSERT INTO params VALUES (5549, 'Fonts', 'nsecthin');
INSERT INTO params VALUES (5550, 'Fonts', 'nucleus');
INSERT INTO params VALUES (5551, 'Fonts', 'numskull');
INSERT INTO params VALUES (5552, 'Fonts', 'nymonak');
INSERT INTO params VALUES (5553, 'Fonts', 'obloquyo');
INSERT INTO params VALUES (5554, 'Fonts', 'obloquys');
INSERT INTO params VALUES (5555, 'Fonts', 'obstacle');
INSERT INTO params VALUES (5556, 'Fonts', 'obstacll');
INSERT INTO params VALUES (5557, 'Fonts', 'ocra');
INSERT INTO params VALUES (5558, 'Fonts', 'ocrabold');
INSERT INTO params VALUES (5559, 'Fonts', 'ocracondensed');
INSERT INTO params VALUES (5560, 'Fonts', 'ocraitalic');
INSERT INTO params VALUES (5561, 'Fonts', 'ocralight');
INSERT INTO params VALUES (5562, 'Fonts', 'offkiltl');
INSERT INTO params VALUES (5563, 'Fonts', 'offkiltr');
INSERT INTO params VALUES (5564, 'Fonts', 'okolaks');
INSERT INTO params VALUES (5565, 'Fonts', 'okolaksbold');
INSERT INTO params VALUES (5566, 'Fonts', 'okolaksboldcondensed');
INSERT INTO params VALUES (5567, 'Fonts', 'okolaksboldcondensedcondensed');
INSERT INTO params VALUES (5568, 'Fonts', 'okolakscondensed');
INSERT INTO params VALUES (5569, 'Fonts', 'okolakscondensedcondensed');
INSERT INTO params VALUES (5570, 'Fonts', 'okolaksitalic');
INSERT INTO params VALUES (5571, 'Fonts', 'okolaksitaliccondensed');
INSERT INTO params VALUES (5572, 'Fonts', 'okolaksitaliccondensedcondensed');
INSERT INTO params VALUES (5573, 'Fonts', 'omegadingbats');
INSERT INTO params VALUES (5574, 'Fonts', 'omegasanstifinagh');
INSERT INTO params VALUES (5575, 'Fonts', 'omegaserifarabicone-bold');
INSERT INTO params VALUES (5576, 'Fonts', 'omegaserifarabicone');
INSERT INTO params VALUES (5577, 'Fonts', 'omegaserifarabicthree-bold');
INSERT INTO params VALUES (5578, 'Fonts', 'omegaserifarabicthree');
INSERT INTO params VALUES (5579, 'Fonts', 'omegaserifarabictwo-bold');
INSERT INTO params VALUES (5580, 'Fonts', 'omegaserifarabictwo');
INSERT INTO params VALUES (5581, 'Fonts', 'omegaserifarmenian');
INSERT INTO params VALUES (5582, 'Fonts', 'omegaserifcommon-bold');
INSERT INTO params VALUES (5583, 'Fonts', 'omegaserifcommon-bolditalic');
INSERT INTO params VALUES (5584, 'Fonts', 'omegaserifcommon-italic');
INSERT INTO params VALUES (5585, 'Fonts', 'omegaserifcommon');
INSERT INTO params VALUES (5586, 'Fonts', 'omegaserifcyrillic-bold');
INSERT INTO params VALUES (5587, 'Fonts', 'omegaserifcyrillic-italic');
INSERT INTO params VALUES (5588, 'Fonts', 'omegaserifcyrillic');
INSERT INTO params VALUES (5589, 'Fonts', 'omegaserifcyrillicextended');
INSERT INTO params VALUES (5590, 'Fonts', 'omegaserifgreek-bold');
INSERT INTO params VALUES (5591, 'Fonts', 'omegaserifgreek-bolditalic');
INSERT INTO params VALUES (5592, 'Fonts', 'omegaserifgreek-italic');
INSERT INTO params VALUES (5593, 'Fonts', 'omegaserifgreek');
INSERT INTO params VALUES (5594, 'Fonts', 'omegaserifhebrew');
INSERT INTO params VALUES (5595, 'Fonts', 'omegaserifipa');
INSERT INTO params VALUES (5596, 'Fonts', 'omegaseriflatin-bold');
INSERT INTO params VALUES (5597, 'Fonts', 'omegaseriflatin-bolditalic');
INSERT INTO params VALUES (5598, 'Fonts', 'omegaseriflatin-italic');
INSERT INTO params VALUES (5599, 'Fonts', 'omegaseriflatin');
INSERT INTO params VALUES (5600, 'Fonts', 'omegaseriftifinagh');
INSERT INTO params VALUES (5601, 'Fonts', 'opendinschriftenengshrift');
INSERT INTO params VALUES (5602, 'Fonts', 'opens___');
INSERT INTO params VALUES (5603, 'Fonts', 'opiated');
INSERT INTO params VALUES (5604, 'Fonts', 'orbicula');
INSERT INTO params VALUES (5605, 'Fonts', 'outersid');
INSERT INTO params VALUES (5606, 'Fonts', 'overhead');
INSERT INTO params VALUES (5607, 'Fonts', 'padauk-bold');
INSERT INTO params VALUES (5608, 'Fonts', 'padauk');
INSERT INTO params VALUES (5609, 'Fonts', 'parmesan11');
INSERT INTO params VALUES (5610, 'Fonts', 'parmesan13');
INSERT INTO params VALUES (5611, 'Fonts', 'parmesan14');
INSERT INTO params VALUES (5612, 'Fonts', 'parmesan16');
INSERT INTO params VALUES (5613, 'Fonts', 'parmesan18');
INSERT INTO params VALUES (5614, 'Fonts', 'parmesan20');
INSERT INTO params VALUES (5615, 'Fonts', 'parmesan23');
INSERT INTO params VALUES (5616, 'Fonts', 'parmesan26');
INSERT INTO params VALUES (5617, 'Fonts', 'pazomath-bold');
INSERT INTO params VALUES (5618, 'Fonts', 'pazomath-bolditalic');
INSERT INTO params VALUES (5619, 'Fonts', 'pazomath-italic');
INSERT INTO params VALUES (5620, 'Fonts', 'pazomath');
INSERT INTO params VALUES (5621, 'Fonts', 'pazomathblackboardbold');
INSERT INTO params VALUES (5622, 'Fonts', 'pdark');
INSERT INTO params VALUES (5623, 'Fonts', 'persuasi');
INSERT INTO params VALUES (5624, 'Fonts', 'phaistos');
INSERT INTO params VALUES (5625, 'Fonts', 'phorfeir');
INSERT INTO params VALUES (5626, 'Fonts', 'phorfeis');
INSERT INTO params VALUES (5627, 'Fonts', 'pincers');
INSERT INTO params VALUES (5628, 'Fonts', 'pindown');
INSERT INTO params VALUES (5629, 'Fonts', 'pindownp');
INSERT INTO params VALUES (5630, 'Fonts', 'pindwnx');
INSERT INTO params VALUES (5631, 'Fonts', 'pindwnxp');
INSERT INTO params VALUES (5632, 'Fonts', 'pixlkrud');
INSERT INTO params VALUES (5633, 'Fonts', 'plasdrip');
INSERT INTO params VALUES (5634, 'Fonts', 'plasdrpe');
INSERT INTO params VALUES (5635, 'Fonts', 'pneumati');
INSERT INTO params VALUES (5636, 'Fonts', 'pneutall');
INSERT INTO params VALUES (5637, 'Fonts', 'pneuwide');
INSERT INTO params VALUES (5638, 'Fonts', 'powdwrk5');
INSERT INTO params VALUES (5639, 'Fonts', 'pseudo');
INSERT INTO params VALUES (5640, 'Fonts', 'pxbex');
INSERT INTO params VALUES (5641, 'Fonts', 'pxbexa');
INSERT INTO params VALUES (5642, 'Fonts', 'pxbmia');
INSERT INTO params VALUES (5643, 'Fonts', 'pxbsy');
INSERT INTO params VALUES (5644, 'Fonts', 'pxbsya');
INSERT INTO params VALUES (5645, 'Fonts', 'pxbsyb');
INSERT INTO params VALUES (5646, 'Fonts', 'pxbsyc');
INSERT INTO params VALUES (5647, 'Fonts', 'pxex');
INSERT INTO params VALUES (5648, 'Fonts', 'pxexa');
INSERT INTO params VALUES (5649, 'Fonts', 'pxmia');
INSERT INTO params VALUES (5650, 'Fonts', 'pxsy');
INSERT INTO params VALUES (5651, 'Fonts', 'pxsya');
INSERT INTO params VALUES (5652, 'Fonts', 'pxsyb');
INSERT INTO params VALUES (5653, 'Fonts', 'pxsyc');
INSERT INTO params VALUES (5654, 'Fonts', 'qbicle1');
INSERT INTO params VALUES (5655, 'Fonts', 'qbicle2');
INSERT INTO params VALUES (5656, 'Fonts', 'qbicle3');
INSERT INTO params VALUES (5657, 'Fonts', 'qbicle4');
INSERT INTO params VALUES (5658, 'Fonts', 'qlumpy');
INSERT INTO params VALUES (5659, 'Fonts', 'qlumpysh');
INSERT INTO params VALUES (5660, 'Fonts', 'quacksal');
INSERT INTO params VALUES (5661, 'Fonts', 'quadrcal');
INSERT INTO params VALUES (5662, 'Fonts', 'quadrtic');
INSERT INTO params VALUES (5663, 'Fonts', 'quandary');
INSERT INTO params VALUES (5664, 'Fonts', 'quantfh');
INSERT INTO params VALUES (5665, 'Fonts', 'quantflt');
INSERT INTO params VALUES (5666, 'Fonts', 'quantrh');
INSERT INTO params VALUES (5667, 'Fonts', 'quantrnd');
INSERT INTO params VALUES (5668, 'Fonts', 'quanttap');
INSERT INTO params VALUES (5669, 'Fonts', 'quaranti');
INSERT INTO params VALUES (5670, 'Fonts', 'quarthck');
INSERT INTO params VALUES (5671, 'Fonts', 'quarthin');
INSERT INTO params VALUES (5672, 'Fonts', 'queasy');
INSERT INTO params VALUES (5673, 'Fonts', 'queasyol');
INSERT INTO params VALUES (5674, 'Fonts', 'quercus');
INSERT INTO params VALUES (5675, 'Fonts', 'quercus_bold');
INSERT INTO params VALUES (5676, 'Fonts', 'quercus_bold_it');
INSERT INTO params VALUES (5677, 'Fonts', 'quercus_it');
INSERT INTO params VALUES (5678, 'Fonts', 'quillexo');
INSERT INTO params VALUES (5679, 'Fonts', 'quillexs');
INSERT INTO params VALUES (5680, 'Fonts', 'radissans-medium');
INSERT INTO params VALUES (5681, 'Fonts', 'rambling');
INSERT INTO params VALUES (5682, 'Fonts', 'ravaged2');
INSERT INTO params VALUES (5683, 'Fonts', 'ravcater');
INSERT INTO params VALUES (5684, 'Fonts', 'raydiat2');
INSERT INTO params VALUES (5685, 'Fonts', 'rblmi');
INSERT INTO params VALUES (5686, 'Fonts', 'reason');
INSERT INTO params VALUES (5687, 'Fonts', 'reasonsh');
INSERT INTO params VALUES (5688, 'Fonts', 'redundan');
INSERT INTO params VALUES (5689, 'Fonts', 'regenera');
INSERT INTO params VALUES (5690, 'Fonts', 'registry');
INSERT INTO params VALUES (5691, 'Fonts', 'rehearsc');
INSERT INTO params VALUES (5692, 'Fonts', 'rehearso');
INSERT INTO params VALUES (5693, 'Fonts', 'rehearsp');
INSERT INTO params VALUES (5694, 'Fonts', 'relapse');
INSERT INTO params VALUES (5695, 'Fonts', 'revert');
INSERT INTO params VALUES (5696, 'Fonts', 'revertro');
INSERT INTO params VALUES (5697, 'Fonts', 'rotund');
INSERT INTO params VALUES (5698, 'Fonts', 'rotundo');
INSERT INTO params VALUES (5699, 'Fonts', 'roughday');
INSERT INTO params VALUES (5700, 'Fonts', 'rpcxb');
INSERT INTO params VALUES (5701, 'Fonts', 'rpcxbi');
INSERT INTO params VALUES (5702, 'Fonts', 'rpcxi');
INSERT INTO params VALUES (5703, 'Fonts', 'rpcxr');
INSERT INTO params VALUES (5704, 'Fonts', 'rpxb');
INSERT INTO params VALUES (5705, 'Fonts', 'rpxbi');
INSERT INTO params VALUES (5706, 'Fonts', 'rpxbmi');
INSERT INTO params VALUES (5707, 'Fonts', 'rpxbsc');
INSERT INTO params VALUES (5708, 'Fonts', 'rpxi');
INSERT INTO params VALUES (5709, 'Fonts', 'rpxmi');
INSERT INTO params VALUES (5710, 'Fonts', 'rpxr');
INSERT INTO params VALUES (5711, 'Fonts', 'rpxsc');
INSERT INTO params VALUES (5712, 'Fonts', 'rsfs10');
INSERT INTO params VALUES (5713, 'Fonts', 'rsfs5');
INSERT INTO params VALUES (5714, 'Fonts', 'rsfs7');
INSERT INTO params VALUES (5715, 'Fonts', 'rtcxb');
INSERT INTO params VALUES (5716, 'Fonts', 'rtcxbi');
INSERT INTO params VALUES (5717, 'Fonts', 'rtcxbss');
INSERT INTO params VALUES (5718, 'Fonts', 'rtcxi');
INSERT INTO params VALUES (5719, 'Fonts', 'rtcxr');
INSERT INTO params VALUES (5720, 'Fonts', 'rtcxss');
INSERT INTO params VALUES (5721, 'Fonts', 'rtxb');
INSERT INTO params VALUES (5722, 'Fonts', 'rtxbi');
INSERT INTO params VALUES (5723, 'Fonts', 'rtxbmi');
INSERT INTO params VALUES (5724, 'Fonts', 'rtxbsc');
INSERT INTO params VALUES (5725, 'Fonts', 'rtxbss');
INSERT INTO params VALUES (5726, 'Fonts', 'rtxbsssc');
INSERT INTO params VALUES (5727, 'Fonts', 'rtxi');
INSERT INTO params VALUES (5728, 'Fonts', 'rtxmi');
INSERT INTO params VALUES (5729, 'Fonts', 'rtxr');
INSERT INTO params VALUES (5730, 'Fonts', 'rtxsc');
INSERT INTO params VALUES (5731, 'Fonts', 'rtxss');
INSERT INTO params VALUES (5732, 'Fonts', 'rtxsssc');
INSERT INTO params VALUES (5733, 'Fonts', 'rufscript010');
INSERT INTO params VALUES (5734, 'Fonts', 'ryuker');
INSERT INTO params VALUES (5735, 'Fonts', 'sarcasti');
INSERT INTO params VALUES (5736, 'Fonts', 'saunder');
INSERT INTO params VALUES (5737, 'Fonts', 'scalines');
INSERT INTO params VALUES (5738, 'Fonts', 'scheherazaderegot');
INSERT INTO params VALUES (5739, 'Fonts', 'sclnmaze');
INSERT INTO params VALUES (5740, 'Fonts', 'sequence');
INSERT INTO params VALUES (5741, 'Fonts', 'setbackt');
INSERT INTO params VALUES (5742, 'Fonts', 'sideways');
INSERT INTO params VALUES (5743, 'Fonts', 'sileot');
INSERT INTO params VALUES (5744, 'Fonts', 'sileotsr');
INSERT INTO params VALUES (5745, 'Fonts', 'silyi');
INSERT INTO params VALUES (5746, 'Fonts', 'simplto2');
INSERT INTO params VALUES (5747, 'Fonts', 'skullcap');
INSERT INTO params VALUES (5748, 'Fonts', 'slender');
INSERT INTO params VALUES (5749, 'Fonts', 'slenderw');
INSERT INTO params VALUES (5750, 'Fonts', 'slenmini');
INSERT INTO params VALUES (5751, 'Fonts', 'slenstub');
INSERT INTO params VALUES (5752, 'Fonts', 'snailets');
INSERT INTO params VALUES (5753, 'Fonts', 'snb');
INSERT INTO params VALUES (5754, 'Fonts', 'snbi');
INSERT INTO params VALUES (5755, 'Fonts', 'sni');
INSERT INTO params VALUES (5756, 'Fonts', 'snr');
INSERT INTO params VALUES (5757, 'Fonts', 'spaciouo');
INSERT INTO params VALUES (5758, 'Fonts', 'spacious');
INSERT INTO params VALUES (5759, 'Fonts', 'spastic2');
INSERT INTO params VALUES (5760, 'Fonts', 'spheroid');
INSERT INTO params VALUES (5761, 'Fonts', 'spheroix');
INSERT INTO params VALUES (5762, 'Fonts', 'splatz2');
INSERT INTO params VALUES (5763, 'Fonts', 'sqroute');
INSERT INTO params VALUES (5764, 'Fonts', 'stagnati');
INSERT INTO params VALUES (5765, 'Fonts', 'standardsyml');
INSERT INTO params VALUES (5766, 'Fonts', 'stevehand');
INSERT INTO params VALUES (5767, 'Fonts', 'strande2');
INSERT INTO params VALUES (5768, 'Fonts', 'subgamefont');
INSERT INTO params VALUES (5769, 'Fonts', 'supragc');
INSERT INTO params VALUES (5770, 'Fonts', 'supragl');
INSERT INTO params VALUES (5771, 'Fonts', 'swirled2');
INSERT INTO params VALUES (5772, 'Fonts', 'switzeraadf-demibold');
INSERT INTO params VALUES (5773, 'Fonts', 'switzeraadf-demibolditalic');
INSERT INTO params VALUES (5774, 'Fonts', 'switzeraadf-italic');
INSERT INTO params VALUES (5775, 'Fonts', 'switzeraadf-regular');
INSERT INTO params VALUES (5776, 'Fonts', 'switzeraadfbold-italic');
INSERT INTO params VALUES (5777, 'Fonts', 'switzeraadfbold');
INSERT INTO params VALUES (5778, 'Fonts', 'switzeraadfcd-bold');
INSERT INTO params VALUES (5779, 'Fonts', 'switzeraadfcd-bolditalic');
INSERT INTO params VALUES (5780, 'Fonts', 'switzeraadfcd-italic');
INSERT INTO params VALUES (5781, 'Fonts', 'switzeraadfcd-regular');
INSERT INTO params VALUES (5782, 'Fonts', 'switzeraadfex-bold');
INSERT INTO params VALUES (5783, 'Fonts', 'switzeraadfex-bolditalic');
INSERT INTO params VALUES (5784, 'Fonts', 'switzeraadfex-italic');
INSERT INTO params VALUES (5785, 'Fonts', 'switzeraadfex-regular');
INSERT INTO params VALUES (5786, 'Fonts', 'switzeraadfextrabold-italic');
INSERT INTO params VALUES (5787, 'Fonts', 'switzeraadfextrabold');
INSERT INTO params VALUES (5788, 'Fonts', 'switzeraadflight-bold');
INSERT INTO params VALUES (5789, 'Fonts', 'switzeraadflight-bolditalic');
INSERT INTO params VALUES (5790, 'Fonts', 'switzeraadflight-italic');
INSERT INTO params VALUES (5791, 'Fonts', 'switzeraadflight-regular');
INSERT INTO params VALUES (5792, 'Fonts', 'switzeraadflightcd-bold');
INSERT INTO params VALUES (5793, 'Fonts', 'switzeraadflightcd-bolditalic');
INSERT INTO params VALUES (5794, 'Fonts', 'switzeraadflightcd-italic');
INSERT INTO params VALUES (5795, 'Fonts', 'switzeraadflightcd-regular');
INSERT INTO params VALUES (5796, 'Fonts', 'switzeraadfreverted-bold');
INSERT INTO params VALUES (5797, 'Fonts', 'switzeraadfreverted-regular');
INSERT INTO params VALUES (5798, 'Fonts', 'symmetry');
INSERT INTO params VALUES (5799, 'Fonts', 'syndrome');
INSERT INTO params VALUES (5800, 'Fonts', 'syntheti');
INSERT INTO params VALUES (5801, 'Fonts', 'syracuse');
INSERT INTO params VALUES (5802, 'Fonts', 't1xbtt');
INSERT INTO params VALUES (5803, 'Fonts', 't1xbttsc');
INSERT INTO params VALUES (5804, 'Fonts', 't1xtt');
INSERT INTO params VALUES (5805, 'Fonts', 't1xttsc');
INSERT INTO params VALUES (5806, 'Fonts', 'tapir');
INSERT INTO params VALUES (5807, 'Fonts', 'tcbi10');
INSERT INTO params VALUES (5808, 'Fonts', 'tcbx10');
INSERT INTO params VALUES (5809, 'Fonts', 'tcrm10');
INSERT INTO params VALUES (5810, 'Fonts', 'tcsl10');
INSERT INTO params VALUES (5811, 'Fonts', 'tcss10');
INSERT INTO params VALUES (5812, 'Fonts', 'tcsx10');
INSERT INTO params VALUES (5813, 'Fonts', 'tctt10');
INSERT INTO params VALUES (5814, 'Fonts', 'tcxbtt');
INSERT INTO params VALUES (5815, 'Fonts', 'tcxtt');
INSERT INTO params VALUES (5816, 'Fonts', 'tearful');
INSERT INTO params VALUES (5817, 'Fonts', 'techniqo');
INSERT INTO params VALUES (5818, 'Fonts', 'techniqu');
INSERT INTO params VALUES (5819, 'Fonts', 'techover');
INSERT INTO params VALUES (5820, 'Fonts', 'telephas');
INSERT INTO params VALUES (5821, 'Fonts', 'tetri');
INSERT INTO params VALUES (5822, 'Fonts', 'tex-feybl10');
INSERT INTO params VALUES (5823, 'Fonts', 'tex-feybo10');
INSERT INTO params VALUES (5824, 'Fonts', 'tex-feybr10');
INSERT INTO params VALUES (5825, 'Fonts', 'tex-feyml10');
INSERT INTO params VALUES (5826, 'Fonts', 'tex-feymo10');
INSERT INTO params VALUES (5827, 'Fonts', 'tex-feymr10');
INSERT INTO params VALUES (5828, 'Fonts', 'texpalladiol-bolditalicosf');
INSERT INTO params VALUES (5829, 'Fonts', 'texpalladiol-boldosf');
INSERT INTO params VALUES (5830, 'Fonts', 'texpalladiol-italicosf');
INSERT INTO params VALUES (5831, 'Fonts', 'texpalladiol-sc');
INSERT INTO params VALUES (5832, 'Fonts', 'thwart');
INSERT INTO params VALUES (5833, 'Fonts', 'tirekv__');
INSERT INTO params VALUES (5834, 'Fonts', 'tiresias_infofont');
INSERT INTO params VALUES (5835, 'Fonts', 'tiresias_infofont_bold');
INSERT INTO params VALUES (5836, 'Fonts', 'tiresias_infofont_italic');
INSERT INTO params VALUES (5837, 'Fonts', 'tiresias_infofontz');
INSERT INTO params VALUES (5838, 'Fonts', 'tiresias_infofontz_bold');
INSERT INTO params VALUES (5839, 'Fonts', 'tiresias_infofontz_italic');
INSERT INTO params VALUES (5840, 'Fonts', 'tiresias_lpfont');
INSERT INTO params VALUES (5841, 'Fonts', 'tiresias_lpfont_bold');
INSERT INTO params VALUES (5842, 'Fonts', 'tiresias_lpfont_italic');
INSERT INTO params VALUES (5843, 'Fonts', 'tiresias_pcfont');
INSERT INTO params VALUES (5844, 'Fonts', 'tiresias_pcfont_bold');
INSERT INTO params VALUES (5845, 'Fonts', 'tiresias_pcfont_italic');
INSERT INTO params VALUES (5846, 'Fonts', 'tiresias_pcfontz');
INSERT INTO params VALUES (5847, 'Fonts', 'tiresias_pcfontz_bold');
INSERT INTO params VALUES (5848, 'Fonts', 'tiresias_pcfontz_italic');
INSERT INTO params VALUES (5849, 'Fonts', 'tiresias_signfont');
INSERT INTO params VALUES (5850, 'Fonts', 'tiresias_signfont_bold');
INSERT INTO params VALUES (5851, 'Fonts', 'tiresias_signfont_italic');
INSERT INTO params VALUES (5852, 'Fonts', 'tiresias_signfontz');
INSERT INTO params VALUES (5853, 'Fonts', 'tiresias_signfontz_bold');
INSERT INTO params VALUES (5854, 'Fonts', 'tiresias_signfontz_italic');
INSERT INTO params VALUES (5855, 'Fonts', 'tonik');
INSERT INTO params VALUES (5856, 'Fonts', 'tragic2');
INSERT INTO params VALUES (5857, 'Fonts', 'trajan-roman');
INSERT INTO params VALUES (5858, 'Fonts', 'trajan-slanted');
INSERT INTO params VALUES (5859, 'Fonts', 'tsextolo');
INSERT INTO params VALUES (5860, 'Fonts', 'tsextols');
INSERT INTO params VALUES (5861, 'Fonts', 'tuffy_bold');
INSERT INTO params VALUES (5862, 'Fonts', 'tuffy_bold_italic');
INSERT INTO params VALUES (5863, 'Fonts', 'tuffy_italic');
INSERT INTO params VALUES (5864, 'Fonts', 'tuffy_regular');
INSERT INTO params VALUES (5865, 'Fonts', 'turmoil');
INSERT INTO params VALUES (5866, 'Fonts', 'txbex');
INSERT INTO params VALUES (5867, 'Fonts', 'txbexa');
INSERT INTO params VALUES (5868, 'Fonts', 'txbmia');
INSERT INTO params VALUES (5869, 'Fonts', 'txbsy');
INSERT INTO params VALUES (5870, 'Fonts', 'txbsya');
INSERT INTO params VALUES (5871, 'Fonts', 'txbsyb');
INSERT INTO params VALUES (5872, 'Fonts', 'txbsyc');
INSERT INTO params VALUES (5873, 'Fonts', 'txbtt');
INSERT INTO params VALUES (5874, 'Fonts', 'txbttsc');
INSERT INTO params VALUES (5875, 'Fonts', 'txex');
INSERT INTO params VALUES (5876, 'Fonts', 'txexa');
INSERT INTO params VALUES (5877, 'Fonts', 'txmia');
INSERT INTO params VALUES (5878, 'Fonts', 'txsy');
INSERT INTO params VALUES (5879, 'Fonts', 'txsya');
INSERT INTO params VALUES (5880, 'Fonts', 'txsyb');
INSERT INTO params VALUES (5881, 'Fonts', 'txsyc');
INSERT INTO params VALUES (5882, 'Fonts', 'txtt');
INSERT INTO params VALUES (5883, 'Fonts', 'txttsc');
INSERT INTO params VALUES (5884, 'Fonts', 'ubiquity');
INSERT INTO params VALUES (5885, 'Fonts', 'unanimo');
INSERT INTO params VALUES (5886, 'Fonts', 'unanimoi');
INSERT INTO params VALUES (5887, 'Fonts', 'underscr');
INSERT INTO params VALUES (5888, 'Fonts', 'underwhe');
INSERT INTO params VALUES (5889, 'Fonts', 'underwho');
INSERT INTO params VALUES (5890, 'Fonts', 'undrscr2');
INSERT INTO params VALUES (5893, 'Fonts', 'unlearne');
INSERT INTO params VALUES (5894, 'Fonts', 'unrespon');
INSERT INTO params VALUES (5895, 'Fonts', 'unxgala');
INSERT INTO params VALUES (5896, 'Fonts', 'unxgalaw');
INSERT INTO params VALUES (5897, 'Fonts', 'unxgalo');
INSERT INTO params VALUES (5898, 'Fonts', 'unxgalwo');
INSERT INTO params VALUES (5899, 'Fonts', 'upheavtt');
INSERT INTO params VALUES (5900, 'Fonts', 'upraise');
INSERT INTO params VALUES (5901, 'Fonts', 'urcompi');
INSERT INTO params VALUES (5902, 'Fonts', 'urcompo');
INSERT INTO params VALUES (5903, 'Fonts', 'urwantiquat-regularcondensed');
INSERT INTO params VALUES (5904, 'Fonts', 'urwbookmanl-demibold');
INSERT INTO params VALUES (5905, 'Fonts', 'urwbookmanl-demiboldital');
INSERT INTO params VALUES (5906, 'Fonts', 'urwbookmanl-ligh');
INSERT INTO params VALUES (5907, 'Fonts', 'urwbookmanl-lighital');
INSERT INTO params VALUES (5908, 'Fonts', 'urwchanceryl-mediital');
INSERT INTO params VALUES (5909, 'Fonts', 'urwgothicl-book');
INSERT INTO params VALUES (5910, 'Fonts', 'urwgothicl-bookobli');
INSERT INTO params VALUES (5911, 'Fonts', 'urwgothicl-demi');
INSERT INTO params VALUES (5912, 'Fonts', 'urwgothicl-demiobli');
INSERT INTO params VALUES (5913, 'Fonts', 'urwgroteskt-bold');
INSERT INTO params VALUES (5914, 'Fonts', 'urwpalladiol-bold');
INSERT INTO params VALUES (5915, 'Fonts', 'urwpalladiol-boldital');
INSERT INTO params VALUES (5916, 'Fonts', 'urwpalladiol-ital');
INSERT INTO params VALUES (5917, 'Fonts', 'urwpalladiol-roma');
INSERT INTO params VALUES (5918, 'Fonts', 'utopia-bold');
INSERT INTO params VALUES (5919, 'Fonts', 'utopia-bolditalic');
INSERT INTO params VALUES (5920, 'Fonts', 'utopia-italic');
INSERT INTO params VALUES (5921, 'Fonts', 'utopia-regular');
INSERT INTO params VALUES (5922, 'Fonts', 'vacantz');
INSERT INTO params VALUES (5923, 'Fonts', 'vanished');
INSERT INTO params VALUES (5924, 'Fonts', 'vantage');
INSERT INTO params VALUES (5925, 'Fonts', 'variance');
INSERT INTO params VALUES (5926, 'Fonts', 'vertigo');
INSERT INTO params VALUES (5927, 'Fonts', 'vertigo2');
INSERT INTO params VALUES (5928, 'Fonts', 'vertigup');
INSERT INTO params VALUES (5929, 'Fonts', 'vertiup2');
INSERT INTO params VALUES (5930, 'Fonts', 'vigilanc');
INSERT INTO params VALUES (5931, 'Fonts', 'vindicti');
INSERT INTO params VALUES (5932, 'Fonts', 'visitor1');
INSERT INTO params VALUES (5933, 'Fonts', 'visitor2');
INSERT INTO params VALUES (5934, 'Fonts', 'vl-gothic-regular');
INSERT INTO params VALUES (5935, 'Fonts', 'vl-pgothic-regular');
INSERT INTO params VALUES (5936, 'Fonts', 'volatil1');
INSERT INTO params VALUES (5937, 'Fonts', 'volatil2');
INSERT INTO params VALUES (5938, 'Fonts', 'wager');
INSERT INTO params VALUES (5939, 'Fonts', 'wagerlos');
INSERT INTO params VALUES (5940, 'Fonts', 'wagerwon');
INSERT INTO params VALUES (5941, 'Fonts', 'wasy10');
INSERT INTO params VALUES (5942, 'Fonts', 'wasy5');
INSERT INTO params VALUES (5943, 'Fonts', 'wasy6');
INSERT INTO params VALUES (5944, 'Fonts', 'wasy7');
INSERT INTO params VALUES (5945, 'Fonts', 'wasy8');
INSERT INTO params VALUES (5946, 'Fonts', 'wasy9');
INSERT INTO params VALUES (5947, 'Fonts', 'wasyb10');
INSERT INTO params VALUES (5948, 'Fonts', 'waver');
INSERT INTO params VALUES (5949, 'Fonts', 'wayward');
INSERT INTO params VALUES (5950, 'Fonts', 'waywards');
INSERT INTO params VALUES (5951, 'Fonts', 'weatherd');
INSERT INTO params VALUES (5952, 'Fonts', 'weathers');
INSERT INTO params VALUES (5953, 'Fonts', 'weaver');
INSERT INTO params VALUES (5954, 'Fonts', 'whatever');
INSERT INTO params VALUES (5955, 'Fonts', 'whipsnap');
INSERT INTO params VALUES (5956, 'Fonts', 'wigsquig');
INSERT INTO params VALUES (5957, 'Fonts', 'wincing');
INSERT INTO params VALUES (5958, 'Fonts', 'withstan');
INSERT INTO params VALUES (5959, 'Fonts', 'wobbly');
INSERT INTO params VALUES (5960, 'Fonts', 'wyvernwi');
INSERT INTO params VALUES (5961, 'Fonts', 'wyvernww');
INSERT INTO params VALUES (5962, 'Fonts', 'xeroxmal');
INSERT INTO params VALUES (5963, 'Fonts', 'xhume');
INSERT INTO params VALUES (5964, 'Fonts', 'xipital');
INSERT INTO params VALUES (5965, 'Fonts', 'xmaslght');
INSERT INTO params VALUES (5966, 'Fonts', 'xtrusion');
INSERT INTO params VALUES (5967, 'Fonts', 'yearend');
INSERT INTO params VALUES (5968, 'Fonts', 'yehudaclm-bold');
INSERT INTO params VALUES (5969, 'Fonts', 'yehudaclm-light');
INSERT INTO params VALUES (5970, 'Fonts', 'yesterda');
INSERT INTO params VALUES (5971, 'Fonts', 'yfrak-regular');
INSERT INTO params VALUES (5972, 'Fonts', 'ygoth-regular');
INSERT INTO params VALUES (5973, 'Fonts', 'yielding');
INSERT INTO params VALUES (5974, 'Fonts', 'yonder');
INSERT INTO params VALUES (5975, 'Fonts', 'yoshisst');
INSERT INTO params VALUES (5976, 'Fonts', 'yourcomp');
INSERT INTO params VALUES (5977, 'Fonts', 'yswab-regular');
INSERT INTO params VALUES (5978, 'Fonts', 'zeldadxt');
INSERT INTO params VALUES (5979, 'Fonts', 'zenith');
INSERT INTO params VALUES (5980, 'Fonts', 'zephyrea');
INSERT INTO params VALUES (5981, 'Fonts', 'zephyreg');
INSERT INTO params VALUES (5982, 'Fonts', 'zerovelo');
INSERT INTO params VALUES (5983, 'Fonts', 'zirccube');
INSERT INTO params VALUES (5984, 'Fonts', 'zirconia');
INSERT INTO params VALUES (5985, 'Fonts', 'zoetrope');
INSERT INTO params VALUES (5986, 'Fonts', 'zoidal');
INSERT INTO params VALUES (5987, 'Fonts', 'zurklezo');
INSERT INTO params VALUES (5988, 'Fonts', 'zurklezs');
INSERT INTO params VALUES (5989, 'Meta', 'keywords');


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: urls; Type: TABLE DATA; Schema: public; Owner: admin
--



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

