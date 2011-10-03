--
-- PostgreSQL database dump
--

-- Dumped from database version 8.3.9
-- Dumped by pg_dump version 9.0.3
-- Started on 2011-10-02 22:10:50 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1859 (class 1262 OID 33104)
-- Dependencies: 1858
-- Name: validador; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE validador IS 'Base de datos del sistema de Validacion de portales del CNTI';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1525 (class 1259 OID 66132)
-- Dependencies: 1814 6
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
-- TOC entry 1862 (class 0 OID 0)
-- Dependencies: 1525
-- Name: TABLE auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE auditoria IS 'Almacena los datos de las auditorias, aqui se registran los datos de los portales.';


--
-- TOC entry 1863 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.id IS 'Numero de identificacion unica de las auditorias';


--
-- TOC entry 1864 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.idev; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.idev IS 'Clave de relacion entre las entidades verificadoras y las auditorias';


--
-- TOC entry 1865 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.idinstitucion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.idinstitucion IS 'Clave que relaciona las instituciones con las auditorias';


--
-- TOC entry 1866 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.portal; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.portal IS 'Almacena el nombre del portal a auditar';


--
-- TOC entry 1867 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.fechaini; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fechaini IS 'Fecha de inicio de la auditoria';


--
-- TOC entry 1868 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.fechafin; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fechafin IS 'Fecha de finalizacion de la auditoria, si este campo contiene un dato se da la auditoria como cerrada';


--
-- TOC entry 1869 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.fechacreacion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fechacreacion IS 'Fecha de creacion de la audioria';


--
-- TOC entry 1870 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.url; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.url IS 'Almacena el listado de las url a auditar en un portal';


--
-- TOC entry 1871 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.estado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.estado IS 'Campo que determina el estado de una auditoria, los posibles valores son: p (pendiente), a (abierto), c (cerrado)';


--
-- TOC entry 1872 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.resultado IS 'Resultado General de la Auditoria, de tipo boolean, TRUE para auditoria sin fallas, FALSE para auditoria fallidas';


--
-- TOC entry 1873 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.fallidas; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fallidas IS 'Numero de disposiciones fallidas';


--
-- TOC entry 1874 (class 0 OID 0)
-- Dependencies: 1525
-- Name: COLUMN auditoria.validas; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.validas IS 'Numero de disposiciones sin fallas';


--
-- TOC entry 1526 (class 1259 OID 66139)
-- Dependencies: 1525 6
-- Name: auditoria_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auditoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditoria_id_seq OWNER TO admin;

--
-- TOC entry 1875 (class 0 OID 0)
-- Dependencies: 1526
-- Name: auditoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoria_id_seq OWNED BY auditoria.id;


--
-- TOC entry 1523 (class 1259 OID 33360)
-- Dependencies: 6
-- Name: auditoria_result; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE auditoria_result (
    id_auditoria integer,
    json text,
    id integer NOT NULL
);


ALTER TABLE public.auditoria_result OWNER TO admin;

--
-- TOC entry 1876 (class 0 OID 0)
-- Dependencies: 1523
-- Name: TABLE auditoria_result; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE auditoria_result IS 'Almacena los resultados de la auditoria serializados en JSON';


--
-- TOC entry 1524 (class 1259 OID 41855)
-- Dependencies: 1523 6
-- Name: auditoria_result_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auditoria_result_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditoria_result_id_seq OWNER TO admin;

--
-- TOC entry 1877 (class 0 OID 0)
-- Dependencies: 1524
-- Name: auditoria_result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoria_result_id_seq OWNED BY auditoria_result.id;


--
-- TOC entry 1504 (class 1259 OID 33114)
-- Dependencies: 6
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
-- TOC entry 1878 (class 0 OID 0)
-- Dependencies: 1504
-- Name: TABLE auditoriadetalle; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE auditoriadetalle IS 'Almacena los detalles de una auditoria, sobre todo los resultados de las disposiciones por portal';


--
-- TOC entry 1879 (class 0 OID 0)
-- Dependencies: 1504
-- Name: COLUMN auditoriadetalle.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.id IS 'Numero de identificacion unica para los detalles de las auditorias';


--
-- TOC entry 1880 (class 0 OID 0)
-- Dependencies: 1504
-- Name: COLUMN auditoriadetalle.idauditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.idauditoria IS 'Clave que relaciona los detalles de la auditoria con sus datos maestros';


--
-- TOC entry 1881 (class 0 OID 0)
-- Dependencies: 1504
-- Name: COLUMN auditoriadetalle.iddisposicion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.iddisposicion IS 'Clave que relaciona los detalles de las auditorias con cada disposicion';


--
-- TOC entry 1882 (class 0 OID 0)
-- Dependencies: 1504
-- Name: COLUMN auditoriadetalle.resolutoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.resolutoria IS 'resolutoria del auditor por cada disposicion evaluada a un portal';


--
-- TOC entry 1505 (class 1259 OID 33117)
-- Dependencies: 6 1504
-- Name: auditoriadetalle_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auditoriadetalle_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditoriadetalle_id_seq OWNER TO admin;

--
-- TOC entry 1883 (class 0 OID 0)
-- Dependencies: 1505
-- Name: auditoriadetalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoriadetalle_id_seq OWNED BY auditoriadetalle.id;


--
-- TOC entry 1506 (class 1259 OID 33119)
-- Dependencies: 1504 6
-- Name: auditoriadetalle_iddisposicion_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auditoriadetalle_iddisposicion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditoriadetalle_iddisposicion_seq OWNER TO admin;

--
-- TOC entry 1884 (class 0 OID 0)
-- Dependencies: 1506
-- Name: auditoriadetalle_iddisposicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoriadetalle_iddisposicion_seq OWNED BY auditoriadetalle.iddisposicion;


--
-- TOC entry 1507 (class 1259 OID 33121)
-- Dependencies: 1795 6
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
-- TOC entry 1885 (class 0 OID 0)
-- Dependencies: 1507
-- Name: TABLE disposicion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE disposicion IS 'Contiene los datos sobre las disposiciones';


--
-- TOC entry 1886 (class 0 OID 0)
-- Dependencies: 1507
-- Name: COLUMN disposicion.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.id IS 'Numero de identificacion unica de la disposicion';


--
-- TOC entry 1887 (class 0 OID 0)
-- Dependencies: 1507
-- Name: COLUMN disposicion.nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.nombre IS 'nombre de la disposicion';


--
-- TOC entry 1888 (class 0 OID 0)
-- Dependencies: 1507
-- Name: COLUMN disposicion.descripcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.descripcion IS 'Descripcion de la disposicion';


--
-- TOC entry 1889 (class 0 OID 0)
-- Dependencies: 1507
-- Name: COLUMN disposicion.habilitado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.habilitado IS 'Campo booleano que representa si la disposicion esta habilitada o no, este campo es pensado en caracteristicas futuras de la aplicacion';


--
-- TOC entry 1890 (class 0 OID 0)
-- Dependencies: 1507
-- Name: COLUMN disposicion.modulo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.modulo IS 'Nombre del modulo que ejecuta el Job en el sistema';


--
-- TOC entry 1508 (class 1259 OID 33128)
-- Dependencies: 6 1507
-- Name: disposicion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE disposicion_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disposicion_id_seq OWNER TO admin;

--
-- TOC entry 1891 (class 0 OID 0)
-- Dependencies: 1508
-- Name: disposicion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE disposicion_id_seq OWNED BY disposicion.id;


--
-- TOC entry 1509 (class 1259 OID 33130)
-- Dependencies: 1797 1798 1799 6
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
-- TOC entry 1892 (class 0 OID 0)
-- Dependencies: 1509
-- Name: TABLE entidadverificadora; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE entidadverificadora IS 'Datos maestros de las Entidades Verificadoras';


--
-- TOC entry 1893 (class 0 OID 0)
-- Dependencies: 1509
-- Name: COLUMN entidadverificadora.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.id IS 'Numero de identificacion unico para las Entidades Verificadoras';


--
-- TOC entry 1894 (class 0 OID 0)
-- Dependencies: 1509
-- Name: COLUMN entidadverificadora.nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.nombre IS 'nombre o Razon Social de la Entidad Verificadora';


--
-- TOC entry 1895 (class 0 OID 0)
-- Dependencies: 1509
-- Name: COLUMN entidadverificadora.rif; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.rif IS 'Numero fiscal de la Entidad Verificadora';


--
-- TOC entry 1896 (class 0 OID 0)
-- Dependencies: 1509
-- Name: COLUMN entidadverificadora.correo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.correo IS 'correo electronico de la entidad verificadora';


--
-- TOC entry 1897 (class 0 OID 0)
-- Dependencies: 1509
-- Name: COLUMN entidadverificadora.telefono; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.telefono IS 'Numero de telefono de la Entidad Verificadora';


--
-- TOC entry 1898 (class 0 OID 0)
-- Dependencies: 1509
-- Name: COLUMN entidadverificadora.contacto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.contacto IS 'nombre de la persona contacto de la Entidad Verificadora';


--
-- TOC entry 1899 (class 0 OID 0)
-- Dependencies: 1509
-- Name: COLUMN entidadverificadora.registro; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.registro IS 'Numero de registro de la entidad verificadora';


--
-- TOC entry 1510 (class 1259 OID 33139)
-- Dependencies: 6 1509
-- Name: entidadverificadora_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE entidadverificadora_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entidadverificadora_id_seq OWNER TO admin;

--
-- TOC entry 1900 (class 0 OID 0)
-- Dependencies: 1510
-- Name: entidadverificadora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE entidadverificadora_id_seq OWNED BY entidadverificadora.id;


--
-- TOC entry 1511 (class 1259 OID 33141)
-- Dependencies: 6
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
-- TOC entry 1512 (class 1259 OID 33147)
-- Dependencies: 1511 6
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE events_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO admin;

--
-- TOC entry 1901 (class 0 OID 0)
-- Dependencies: 1512
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- TOC entry 1513 (class 1259 OID 33149)
-- Dependencies: 1802 1803 1804 1805 1806 1807 6
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
-- TOC entry 1902 (class 0 OID 0)
-- Dependencies: 1513
-- Name: TABLE institucion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE institucion IS 'Contiene los datos maestros de las instituciones';


--
-- TOC entry 1903 (class 0 OID 0)
-- Dependencies: 1513
-- Name: COLUMN institucion.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.id IS 'Numero de identificacion unica para las instituciones';


--
-- TOC entry 1904 (class 0 OID 0)
-- Dependencies: 1513
-- Name: COLUMN institucion.nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.nombre IS 'nombre o Razon Social de la Insitucion';


--
-- TOC entry 1905 (class 0 OID 0)
-- Dependencies: 1513
-- Name: COLUMN institucion.rif; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.rif IS 'Numero Fiscal de la institucion';


--
-- TOC entry 1906 (class 0 OID 0)
-- Dependencies: 1513
-- Name: COLUMN institucion.correo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.correo IS 'correo Electronico de la institucion';


--
-- TOC entry 1907 (class 0 OID 0)
-- Dependencies: 1513
-- Name: COLUMN institucion.telefono; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.telefono IS 'Numero de telefono de la institucion';


--
-- TOC entry 1908 (class 0 OID 0)
-- Dependencies: 1513
-- Name: COLUMN institucion.contacto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.contacto IS 'nombre de la persona contacto en la institucion';


--
-- TOC entry 1514 (class 1259 OID 33161)
-- Dependencies: 1513 6
-- Name: institucion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE institucion_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.institucion_id_seq OWNER TO admin;

--
-- TOC entry 1909 (class 0 OID 0)
-- Dependencies: 1514
-- Name: institucion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE institucion_id_seq OWNED BY institucion.id;


--
-- TOC entry 1515 (class 1259 OID 33163)
-- Dependencies: 6
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
-- TOC entry 1516 (class 1259 OID 33169)
-- Dependencies: 1515 6
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE jobs_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO admin;

--
-- TOC entry 1910 (class 0 OID 0)
-- Dependencies: 1516
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE jobs_id_seq OWNED BY jobs.id;


--
-- TOC entry 1517 (class 1259 OID 33171)
-- Dependencies: 6
-- Name: params_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE params_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.params_id_seq OWNER TO admin;

--
-- TOC entry 1518 (class 1259 OID 33173)
-- Dependencies: 1810 6
-- Name: params; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE params (
    id bigint DEFAULT nextval('params_id_seq'::regclass) NOT NULL,
    disposicion character varying NOT NULL,
    parametro character varying NOT NULL
);


ALTER TABLE public.params OWNER TO admin;

--
-- TOC entry 1911 (class 0 OID 0)
-- Dependencies: 1518
-- Name: TABLE params; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE params IS 'Parametros de las disposiciones';


--
-- TOC entry 1519 (class 1259 OID 33180)
-- Dependencies: 6
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
-- TOC entry 1520 (class 1259 OID 33186)
-- Dependencies: 6 1519
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE results_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.results_id_seq OWNER TO admin;

--
-- TOC entry 1912 (class 0 OID 0)
-- Dependencies: 1520
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE results_id_seq OWNED BY results.id;


--
-- TOC entry 1521 (class 1259 OID 33188)
-- Dependencies: 6
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
-- TOC entry 1522 (class 1259 OID 33194)
-- Dependencies: 1521 6
-- Name: urls_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE urls_id_seq
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.urls_id_seq OWNER TO admin;

--
-- TOC entry 1913 (class 0 OID 0)
-- Dependencies: 1522
-- Name: urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE urls_id_seq OWNED BY urls.id;


--
-- TOC entry 1815 (class 2604 OID 66141)
-- Dependencies: 1526 1525
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoria ALTER COLUMN id SET DEFAULT nextval('auditoria_id_seq'::regclass);


--
-- TOC entry 1813 (class 2604 OID 66142)
-- Dependencies: 1524 1523
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoria_result ALTER COLUMN id SET DEFAULT nextval('auditoria_result_id_seq'::regclass);


--
-- TOC entry 1793 (class 2604 OID 66143)
-- Dependencies: 1505 1504
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoriadetalle ALTER COLUMN id SET DEFAULT nextval('auditoriadetalle_id_seq'::regclass);


--
-- TOC entry 1794 (class 2604 OID 66144)
-- Dependencies: 1506 1504
-- Name: iddisposicion; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoriadetalle ALTER COLUMN iddisposicion SET DEFAULT nextval('auditoriadetalle_iddisposicion_seq'::regclass);


--
-- TOC entry 1796 (class 2604 OID 66145)
-- Dependencies: 1508 1507
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE disposicion ALTER COLUMN id SET DEFAULT nextval('disposicion_id_seq'::regclass);


--
-- TOC entry 1800 (class 2604 OID 66146)
-- Dependencies: 1510 1509
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE entidadverificadora ALTER COLUMN id SET DEFAULT nextval('entidadverificadora_id_seq'::regclass);


--
-- TOC entry 1801 (class 2604 OID 66147)
-- Dependencies: 1512 1511
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- TOC entry 1808 (class 2604 OID 66148)
-- Dependencies: 1514 1513
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE institucion ALTER COLUMN id SET DEFAULT nextval('institucion_id_seq'::regclass);


--
-- TOC entry 1809 (class 2604 OID 66149)
-- Dependencies: 1516 1515
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE jobs ALTER COLUMN id SET DEFAULT nextval('jobs_id_seq'::regclass);


--
-- TOC entry 1811 (class 2604 OID 66150)
-- Dependencies: 1520 1519
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE results ALTER COLUMN id SET DEFAULT nextval('results_id_seq'::regclass);


--
-- TOC entry 1812 (class 2604 OID 66151)
-- Dependencies: 1522 1521
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE urls ALTER COLUMN id SET DEFAULT nextval('urls_id_seq'::regclass);


--
-- TOC entry 1828 (class 2606 OID 33207)
-- Dependencies: 1511 1511
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- TOC entry 1819 (class 2606 OID 33209)
-- Dependencies: 1507 1507
-- Name: idxdisp; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY disposicion
    ADD CONSTRAINT idxdisp PRIMARY KEY (id);


--
-- TOC entry 1834 (class 2606 OID 33211)
-- Dependencies: 1515 1515
-- Name: jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 1817 (class 2606 OID 33213)
-- Dependencies: 1504 1504
-- Name: pkAudDet; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY auditoriadetalle
    ADD CONSTRAINT "pkAudDet" PRIMARY KEY (id);


--
-- TOC entry 1849 (class 2606 OID 66153)
-- Dependencies: 1525 1525
-- Name: pkAudit; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT "pkAudit" PRIMARY KEY (id);


--
-- TOC entry 1914 (class 0 OID 0)
-- Dependencies: 1849
-- Name: CONSTRAINT "pkAudit" ON auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT "pkAudit" ON auditoria IS 'Clave Primaria de las auditorias';


--
-- TOC entry 1843 (class 2606 OID 41867)
-- Dependencies: 1523 1523
-- Name: pk_auditoria_results; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY auditoria_result
    ADD CONSTRAINT pk_auditoria_results PRIMARY KEY (id);


--
-- TOC entry 1826 (class 2606 OID 33217)
-- Dependencies: 1509 1509
-- Name: pkev; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY entidadverificadora
    ADD CONSTRAINT pkev PRIMARY KEY (id);


--
-- TOC entry 1832 (class 2606 OID 33219)
-- Dependencies: 1513 1513
-- Name: pkidinst; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY institucion
    ADD CONSTRAINT pkidinst PRIMARY KEY (id);


--
-- TOC entry 1836 (class 2606 OID 33221)
-- Dependencies: 1518 1518
-- Name: pkparams; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY params
    ADD CONSTRAINT pkparams PRIMARY KEY (id);


--
-- TOC entry 1838 (class 2606 OID 33223)
-- Dependencies: 1519 1519
-- Name: results_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- TOC entry 1841 (class 2606 OID 33225)
-- Dependencies: 1521 1521
-- Name: urls_pkey; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT urls_pkey PRIMARY KEY (id);


--
-- TOC entry 1844 (class 1259 OID 66154)
-- Dependencies: 1525
-- Name: fki_fkev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_fkev ON auditoria USING btree (idev);


--
-- TOC entry 1845 (class 1259 OID 66155)
-- Dependencies: 1525
-- Name: fki_fkinst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_fkinst ON auditoria USING btree (idinstitucion);


--
-- TOC entry 1846 (class 1259 OID 66156)
-- Dependencies: 1525
-- Name: idxauditfecha; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxauditfecha ON auditoria USING btree (fechafin);


--
-- TOC entry 1915 (class 0 OID 0)
-- Dependencies: 1846
-- Name: INDEX idxauditfecha; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX idxauditfecha IS 'Indice por fecha de auditoria';


--
-- TOC entry 1820 (class 1259 OID 33229)
-- Dependencies: 1507
-- Name: idxmodulo; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxmodulo ON disposicion USING btree (modulo);


--
-- TOC entry 1821 (class 1259 OID 33230)
-- Dependencies: 1507
-- Name: idxnombredisp; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxnombredisp ON disposicion USING btree (nombre);


--
-- TOC entry 1822 (class 1259 OID 33231)
-- Dependencies: 1509
-- Name: idxnomev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxnomev ON entidadverificadora USING btree (nombre);


--
-- TOC entry 1829 (class 1259 OID 33232)
-- Dependencies: 1513
-- Name: idxnominst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxnominst ON institucion USING btree (nombre);


--
-- TOC entry 1847 (class 1259 OID 66157)
-- Dependencies: 1525
-- Name: idxportal; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxportal ON auditoria USING btree (portal);


--
-- TOC entry 1823 (class 1259 OID 33234)
-- Dependencies: 1509
-- Name: idxregistro; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxregistro ON entidadverificadora USING btree (registro);


--
-- TOC entry 1824 (class 1259 OID 33235)
-- Dependencies: 1509
-- Name: idxrifev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxrifev ON entidadverificadora USING btree (rif);


--
-- TOC entry 1830 (class 1259 OID 33236)
-- Dependencies: 1513
-- Name: idxrifinst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxrifinst ON institucion USING btree (rif);


--
-- TOC entry 1839 (class 1259 OID 33237)
-- Dependencies: 1521 1521
-- Name: urls_pid_state; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX urls_pid_state ON urls USING btree (pid, state);


--
-- TOC entry 1851 (class 2606 OID 33238)
-- Dependencies: 1837 1511 1519
-- Name: events_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pid_fkey FOREIGN KEY (pid) REFERENCES results(id) ON DELETE CASCADE;


--
-- TOC entry 1850 (class 2606 OID 33248)
-- Dependencies: 1507 1818 1504
-- Name: fkdisp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoriadetalle
    ADD CONSTRAINT fkdisp FOREIGN KEY (iddisposicion) REFERENCES disposicion(id);


--
-- TOC entry 1854 (class 2606 OID 66168)
-- Dependencies: 1509 1525 1825
-- Name: fkev; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT fkev FOREIGN KEY (idev) REFERENCES entidadverificadora(id);


--
-- TOC entry 1916 (class 0 OID 0)
-- Dependencies: 1854
-- Name: CONSTRAINT fkev ON auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT fkev ON auditoria IS 'Relaciona las auditorias con las entidades verificadoras';


--
-- TOC entry 1855 (class 2606 OID 66173)
-- Dependencies: 1831 1513 1525
-- Name: fkinst; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT fkinst FOREIGN KEY (idinstitucion) REFERENCES institucion(id);


--
-- TOC entry 1917 (class 0 OID 0)
-- Dependencies: 1855
-- Name: CONSTRAINT fkinst ON auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT fkinst ON auditoria IS 'Relaciona las auditorias con las instituciones';


--
-- TOC entry 1852 (class 2606 OID 33263)
-- Dependencies: 1519 1521 1840
-- Name: results_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY results
    ADD CONSTRAINT results_pid_fkey FOREIGN KEY (pid) REFERENCES urls(id) ON DELETE CASCADE;


--
-- TOC entry 1853 (class 2606 OID 33268)
-- Dependencies: 1521 1833 1515
-- Name: urls_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY urls
    ADD CONSTRAINT urls_pid_fkey FOREIGN KEY (pid) REFERENCES jobs(id) ON DELETE CASCADE;


--
-- TOC entry 1861 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2011-10-02 22:10:50 VET

--
-- PostgreSQL database dump complete
--

