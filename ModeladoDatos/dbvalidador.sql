--
-- PostgreSQL database dump
--

-- Started on 2010-05-03 13:06:00 VET

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1796 (class 1262 OID 16897)
-- Name: validador; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE validador WITH TEMPLATE = template0 ENCODING = 'UTF8';


ALTER DATABASE validador OWNER TO admin;

\connect validador

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1797 (class 1262 OID 16897)
-- Dependencies: 1796
-- Name: validador; Type: COMMENT; Schema: -; Owner: admin
--

COMMENT ON DATABASE validador IS 'Base de datos del sistema de Validacion de portales del CNTI';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1480 (class 1259 OID 16898)
-- Dependencies: 6
-- Name: auditoria; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE auditoria (
    id bigint NOT NULL,
    idev bigint NOT NULL,
    idinstitucion bigint NOT NULL,
    portal character(50) NOT NULL,
    fechaini date NOT NULL,
    fechafin date,
    url text NOT NULL,
    fechacreacion date NOT NULL
);


ALTER TABLE public.auditoria OWNER TO admin;

--
-- TOC entry 1800 (class 0 OID 0)
-- Dependencies: 1480
-- Name: TABLE auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE auditoria IS 'Almacena los datos de las auditorias, aqui se registran los datos de los portales.';


--
-- TOC entry 1801 (class 0 OID 0)
-- Dependencies: 1480
-- Name: COLUMN auditoria.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.id IS 'Numero de identificacion unica de las auditorias';


--
-- TOC entry 1802 (class 0 OID 0)
-- Dependencies: 1480
-- Name: COLUMN auditoria.idev; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.idev IS 'Clave de relacion entre las entidades verificadoras y las auditorias';


--
-- TOC entry 1803 (class 0 OID 0)
-- Dependencies: 1480
-- Name: COLUMN auditoria.idinstitucion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.idinstitucion IS 'Clave que relaciona las instituciones con las auditorias';


--
-- TOC entry 1804 (class 0 OID 0)
-- Dependencies: 1480
-- Name: COLUMN auditoria.portal; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.portal IS 'Almacena el nombre del portal a auditar';


--
-- TOC entry 1805 (class 0 OID 0)
-- Dependencies: 1480
-- Name: COLUMN auditoria.fechaini; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fechaini IS 'Fecha de inicio de la auditoria';


--
-- TOC entry 1806 (class 0 OID 0)
-- Dependencies: 1480
-- Name: COLUMN auditoria.fechafin; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.fechafin IS 'Fecha de finalizacion de la auditoria, si este campo contiene un dato se da la auditoria como cerrada';


--
-- TOC entry 1807 (class 0 OID 0)
-- Dependencies: 1480
-- Name: COLUMN auditoria.url; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoria.url IS 'Almacena el listado de las url a auditar en un portal';


--
-- TOC entry 1484 (class 1259 OID 16915)
-- Dependencies: 6 1480
-- Name: auditoria_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE auditoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auditoria_id_seq OWNER TO admin;

--
-- TOC entry 1808 (class 0 OID 0)
-- Dependencies: 1484
-- Name: auditoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoria_id_seq OWNED BY auditoria.id;


--
-- TOC entry 1809 (class 0 OID 0)
-- Dependencies: 1484
-- Name: auditoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('auditoria_id_seq', 1, false);


--
-- TOC entry 1481 (class 1259 OID 16904)
-- Dependencies: 1758 6
-- Name: auditoriadetalle; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE auditoriadetalle (
    id bigint NOT NULL,
    idauditoria bigint NOT NULL,
    iddisposicion bigint NOT NULL,
    resultado boolean DEFAULT true NOT NULL,
    resdetalle text,
    comentario character(200),
    resolutoria character(200),
    url character(300)
);


ALTER TABLE public.auditoriadetalle OWNER TO admin;

--
-- TOC entry 1810 (class 0 OID 0)
-- Dependencies: 1481
-- Name: TABLE auditoriadetalle; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE auditoriadetalle IS 'Almacena los detalles de una auditoria, sobre todo los resultados de las disposiciones por portal';


--
-- TOC entry 1811 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN auditoriadetalle.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.id IS 'Numero de identificacion unica para los detalles de las auditorias';


--
-- TOC entry 1812 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN auditoriadetalle.idauditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.idauditoria IS 'Clave que relaciona los detalles de la auditoria con sus datos maestros';


--
-- TOC entry 1813 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN auditoriadetalle.iddisposicion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.iddisposicion IS 'Clave que relaciona los detalles de las auditorias con cada disposicion';


--
-- TOC entry 1814 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN auditoriadetalle.resultado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.resultado IS 'Determina si una disposicion es valida o no';


--
-- TOC entry 1815 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN auditoriadetalle.resdetalle; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.resdetalle IS 'Detalle del resultado de una disposicion si esta no es valida';


--
-- TOC entry 1816 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN auditoriadetalle.comentario; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.comentario IS 'comentario del auditor por cada disposicion evaluada en algun portal';


--
-- TOC entry 1817 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN auditoriadetalle.resolutoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN auditoriadetalle.resolutoria IS 'resolutoria del auditor por cada disposicion evaluada a un portal';


--
-- TOC entry 1483 (class 1259 OID 16913)
-- Dependencies: 6 1481
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
-- TOC entry 1818 (class 0 OID 0)
-- Dependencies: 1483
-- Name: auditoriadetalle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoriadetalle_id_seq OWNED BY auditoriadetalle.id;


--
-- TOC entry 1819 (class 0 OID 0)
-- Dependencies: 1483
-- Name: auditoriadetalle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('auditoriadetalle_id_seq', 1, false);


--
-- TOC entry 1482 (class 1259 OID 16911)
-- Dependencies: 1481 6
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
-- TOC entry 1820 (class 0 OID 0)
-- Dependencies: 1482
-- Name: auditoriadetalle_iddisposicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE auditoriadetalle_iddisposicion_seq OWNED BY auditoriadetalle.iddisposicion;


--
-- TOC entry 1821 (class 0 OID 0)
-- Dependencies: 1482
-- Name: auditoriadetalle_iddisposicion_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('auditoriadetalle_iddisposicion_seq', 1, false);


--
-- TOC entry 1485 (class 1259 OID 16917)
-- Dependencies: 1761 6
-- Name: disposicion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE disposicion (
    id integer NOT NULL,
    nombre character(25) NOT NULL,
    descripcion character(70) NOT NULL,
    habilitado boolean DEFAULT true NOT NULL
);


ALTER TABLE public.disposicion OWNER TO admin;

--
-- TOC entry 1822 (class 0 OID 0)
-- Dependencies: 1485
-- Name: TABLE disposicion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE disposicion IS 'Contiene los datos sobre las disposiciones';


--
-- TOC entry 1823 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN disposicion.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.id IS 'Numero de identificacion unica de la disposicion';


--
-- TOC entry 1824 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN disposicion.nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.nombre IS 'nombre de la disposicion';


--
-- TOC entry 1825 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN disposicion.descripcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.descripcion IS 'Descripcion de la disposicion';


--
-- TOC entry 1826 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN disposicion.habilitado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN disposicion.habilitado IS 'Campo booleano que representa si la disposicion esta habilitada o no, este campo es pensado en caracteristicas futuras de la aplicacion';


--
-- TOC entry 1486 (class 1259 OID 16921)
-- Dependencies: 6 1485
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
-- TOC entry 1827 (class 0 OID 0)
-- Dependencies: 1486
-- Name: disposicion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE disposicion_id_seq OWNED BY disposicion.id;


--
-- TOC entry 1828 (class 0 OID 0)
-- Dependencies: 1486
-- Name: disposicion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('disposicion_id_seq', 1, false);


--
-- TOC entry 1487 (class 1259 OID 16923)
-- Dependencies: 6
-- Name: entidadverificadora; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE entidadverificadora (
    id integer NOT NULL,
    nombre character(50) NOT NULL,
    rif character(15),
    correo character(30) NOT NULL,
    telefono character(15) NOT NULL,
    contacto character(30) NOT NULL,
    password character(20) NOT NULL,
    direccion character(500),
    web character(100)
);


ALTER TABLE public.entidadverificadora OWNER TO admin;

--
-- TOC entry 1829 (class 0 OID 0)
-- Dependencies: 1487
-- Name: TABLE entidadverificadora; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE entidadverificadora IS 'Datos maestros de las Entidades Verificadoras';


--
-- TOC entry 1830 (class 0 OID 0)
-- Dependencies: 1487
-- Name: COLUMN entidadverificadora.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.id IS 'Numero de identificacion unico para las Entidades Verificadoras';


--
-- TOC entry 1831 (class 0 OID 0)
-- Dependencies: 1487
-- Name: COLUMN entidadverificadora.nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.nombre IS 'nombre o Razon Social de la Entidad Verificadora';


--
-- TOC entry 1832 (class 0 OID 0)
-- Dependencies: 1487
-- Name: COLUMN entidadverificadora.rif; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.rif IS 'Numero fiscal de la Entidad Verificadora';


--
-- TOC entry 1833 (class 0 OID 0)
-- Dependencies: 1487
-- Name: COLUMN entidadverificadora.correo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.correo IS 'correo electronico de la entidad verificadora';


--
-- TOC entry 1834 (class 0 OID 0)
-- Dependencies: 1487
-- Name: COLUMN entidadverificadora.telefono; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.telefono IS 'Numero de telefono de la Entidad Verificadora';


--
-- TOC entry 1835 (class 0 OID 0)
-- Dependencies: 1487
-- Name: COLUMN entidadverificadora.contacto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN entidadverificadora.contacto IS 'nombre de la persona contacto de la Entidad Verificadora';


--
-- TOC entry 1488 (class 1259 OID 16929)
-- Dependencies: 6 1487
-- Name: entidadverificadora_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE entidadverificadora_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.entidadverificadora_id_seq OWNER TO admin;

--
-- TOC entry 1836 (class 0 OID 0)
-- Dependencies: 1488
-- Name: entidadverificadora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE entidadverificadora_id_seq OWNED BY entidadverificadora.id;


--
-- TOC entry 1837 (class 0 OID 0)
-- Dependencies: 1488
-- Name: entidadverificadora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('entidadverificadora_id_seq', 2, true);


--
-- TOC entry 1489 (class 1259 OID 16931)
-- Dependencies: 6
-- Name: institucion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE institucion (
    id integer NOT NULL,
    nombre character(50) NOT NULL,
    rif character(15),
    correo character(30) NOT NULL,
    telefono character(15) NOT NULL,
    contacto character(50) NOT NULL,
    direccion character(500),
    web character(100)
);


ALTER TABLE public.institucion OWNER TO admin;

--
-- TOC entry 1838 (class 0 OID 0)
-- Dependencies: 1489
-- Name: TABLE institucion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE institucion IS 'Contiene los datos maestros de las instituciones';


--
-- TOC entry 1839 (class 0 OID 0)
-- Dependencies: 1489
-- Name: COLUMN institucion.id; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.id IS 'Numero de identificacion unica para las instituciones';


--
-- TOC entry 1840 (class 0 OID 0)
-- Dependencies: 1489
-- Name: COLUMN institucion.nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.nombre IS 'nombre o Razon Social de la Insitucion';


--
-- TOC entry 1841 (class 0 OID 0)
-- Dependencies: 1489
-- Name: COLUMN institucion.rif; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.rif IS 'Numero Fiscal de la institucion';


--
-- TOC entry 1842 (class 0 OID 0)
-- Dependencies: 1489
-- Name: COLUMN institucion.correo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.correo IS 'correo Electronico de la institucion';


--
-- TOC entry 1843 (class 0 OID 0)
-- Dependencies: 1489
-- Name: COLUMN institucion.telefono; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.telefono IS 'Numero de telefono de la institucion';


--
-- TOC entry 1844 (class 0 OID 0)
-- Dependencies: 1489
-- Name: COLUMN institucion.contacto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN institucion.contacto IS 'nombre de la persona contacto en la institucion';


--
-- TOC entry 1490 (class 1259 OID 16937)
-- Dependencies: 1489 6
-- Name: institucion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE institucion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.institucion_id_seq OWNER TO admin;

--
-- TOC entry 1845 (class 0 OID 0)
-- Dependencies: 1490
-- Name: institucion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE institucion_id_seq OWNED BY institucion.id;


--
-- TOC entry 1846 (class 0 OID 0)
-- Dependencies: 1490
-- Name: institucion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('institucion_id_seq', 1, false);


--
-- TOC entry 1757 (class 2604 OID 16939)
-- Dependencies: 1484 1480
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoria ALTER COLUMN id SET DEFAULT nextval('auditoria_id_seq'::regclass);


--
-- TOC entry 1759 (class 2604 OID 16940)
-- Dependencies: 1483 1481
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoriadetalle ALTER COLUMN id SET DEFAULT nextval('auditoriadetalle_id_seq'::regclass);


--
-- TOC entry 1760 (class 2604 OID 16941)
-- Dependencies: 1482 1481
-- Name: iddisposicion; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE auditoriadetalle ALTER COLUMN iddisposicion SET DEFAULT nextval('auditoriadetalle_iddisposicion_seq'::regclass);


--
-- TOC entry 1762 (class 2604 OID 16942)
-- Dependencies: 1486 1485
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE disposicion ALTER COLUMN id SET DEFAULT nextval('disposicion_id_seq'::regclass);


--
-- TOC entry 1763 (class 2604 OID 16943)
-- Dependencies: 1488 1487
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE entidadverificadora ALTER COLUMN id SET DEFAULT nextval('entidadverificadora_id_seq'::regclass);


--
-- TOC entry 1764 (class 2604 OID 16944)
-- Dependencies: 1490 1489
-- Name: id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE institucion ALTER COLUMN id SET DEFAULT nextval('institucion_id_seq'::regclass);


--
-- TOC entry 1789 (class 0 OID 16898)
-- Dependencies: 1480
-- Data for Name: auditoria; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY auditoria (id, idev, idinstitucion, portal, fechaini, fechafin, url, fechacreacion) FROM stdin;
\.


--
-- TOC entry 1790 (class 0 OID 16904)
-- Dependencies: 1481
-- Data for Name: auditoriadetalle; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY auditoriadetalle (id, idauditoria, iddisposicion, resultado, resdetalle, comentario, resolutoria, url) FROM stdin;
\.


--
-- TOC entry 1791 (class 0 OID 16917)
-- Dependencies: 1485
-- Data for Name: disposicion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY disposicion (id, nombre, descripcion, habilitado) FROM stdin;
\.


--
-- TOC entry 1792 (class 0 OID 16923)
-- Dependencies: 1487
-- Data for Name: entidadverificadora; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY entidadverificadora (id, nombre, rif, correo, telefono, contacto, password, direccion, web) FROM stdin;
2	COVETEL                                           	J-992929       	info@covetel.com.ve           	0412-9889285   	Juan Mesa                     	123321              	Cordero                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             	www.covetel.com.ve                                                                                  
\.


--
-- TOC entry 1793 (class 0 OID 16931)
-- Dependencies: 1489
-- Data for Name: institucion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY institucion (id, nombre, rif, correo, telefono, contacto, direccion, web) FROM stdin;
\.


--
-- TOC entry 1775 (class 2606 OID 16946)
-- Dependencies: 1485 1485
-- Name: idxdisp; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY disposicion
    ADD CONSTRAINT idxdisp PRIMARY KEY (id);


--
-- TOC entry 1773 (class 2606 OID 16948)
-- Dependencies: 1481 1481
-- Name: pkAudDet; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY auditoriadetalle
    ADD CONSTRAINT "pkAudDet" PRIMARY KEY (id);


--
-- TOC entry 1770 (class 2606 OID 16950)
-- Dependencies: 1480 1480
-- Name: pkAudit; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT "pkAudit" PRIMARY KEY (id);


--
-- TOC entry 1847 (class 0 OID 0)
-- Dependencies: 1770
-- Name: CONSTRAINT "pkAudit" ON auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT "pkAudit" ON auditoria IS 'Clave Primaria de las auditorias';


--
-- TOC entry 1780 (class 2606 OID 16952)
-- Dependencies: 1487 1487
-- Name: pkev; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY entidadverificadora
    ADD CONSTRAINT pkev PRIMARY KEY (id);


--
-- TOC entry 1784 (class 2606 OID 16954)
-- Dependencies: 1489 1489
-- Name: pkidinst; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY institucion
    ADD CONSTRAINT pkidinst PRIMARY KEY (id);


--
-- TOC entry 1765 (class 1259 OID 16955)
-- Dependencies: 1480
-- Name: fki_fkev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_fkev ON auditoria USING btree (idev);


--
-- TOC entry 1766 (class 1259 OID 16956)
-- Dependencies: 1480
-- Name: fki_fkinst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX fki_fkinst ON auditoria USING btree (idinstitucion);


--
-- TOC entry 1767 (class 1259 OID 16958)
-- Dependencies: 1480
-- Name: idxauditfecha; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxauditfecha ON auditoria USING btree (fechafin);


--
-- TOC entry 1848 (class 0 OID 0)
-- Dependencies: 1767
-- Name: INDEX idxauditfecha; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX idxauditfecha IS 'Indice por fecha de auditoria';


--
-- TOC entry 1771 (class 1259 OID 16957)
-- Dependencies: 1481
-- Name: idxaudres; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxaudres ON auditoriadetalle USING btree (resultado);


--
-- TOC entry 1776 (class 1259 OID 16961)
-- Dependencies: 1485
-- Name: idxnombredisp; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxnombredisp ON disposicion USING btree (nombre);


--
-- TOC entry 1849 (class 0 OID 0)
-- Dependencies: 1776
-- Name: INDEX idxnombredisp; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX idxnombredisp IS 'Indice del nombre de la disposicion';


--
-- TOC entry 1777 (class 1259 OID 16959)
-- Dependencies: 1487
-- Name: idxnomev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxnomev ON entidadverificadora USING btree (nombre);


--
-- TOC entry 1850 (class 0 OID 0)
-- Dependencies: 1777
-- Name: INDEX idxnomev; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX idxnomev IS 'Indice por nombre de entidad verificadora';


--
-- TOC entry 1781 (class 1259 OID 16960)
-- Dependencies: 1489
-- Name: idxnominst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxnominst ON institucion USING btree (nombre);


--
-- TOC entry 1851 (class 0 OID 0)
-- Dependencies: 1781
-- Name: INDEX idxnominst; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX idxnominst IS 'Indice nombre de la institucion';


--
-- TOC entry 1768 (class 1259 OID 16962)
-- Dependencies: 1480
-- Name: idxportal; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX idxportal ON auditoria USING btree (portal);


--
-- TOC entry 1852 (class 0 OID 0)
-- Dependencies: 1768
-- Name: INDEX idxportal; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX idxportal IS 'Indice por portal de la tabla auditoria';


--
-- TOC entry 1778 (class 1259 OID 16963)
-- Dependencies: 1487
-- Name: idxrifev; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxrifev ON entidadverificadora USING btree (rif);


--
-- TOC entry 1853 (class 0 OID 0)
-- Dependencies: 1778
-- Name: INDEX idxrifev; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX idxrifev IS 'Indice por rif de la Entidad Verificadora';


--
-- TOC entry 1782 (class 1259 OID 16964)
-- Dependencies: 1489
-- Name: idxrifinst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX idxrifinst ON institucion USING btree (rif);


--
-- TOC entry 1854 (class 0 OID 0)
-- Dependencies: 1782
-- Name: INDEX idxrifinst; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX idxrifinst IS 'Indice rif de la institucion';


--
-- TOC entry 1787 (class 2606 OID 16965)
-- Dependencies: 1480 1769 1481
-- Name: fkauditoria; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoriadetalle
    ADD CONSTRAINT fkauditoria FOREIGN KEY (idauditoria) REFERENCES auditoria(id);


--
-- TOC entry 1788 (class 2606 OID 16970)
-- Dependencies: 1485 1481 1774
-- Name: fkdisp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoriadetalle
    ADD CONSTRAINT fkdisp FOREIGN KEY (iddisposicion) REFERENCES disposicion(id);


--
-- TOC entry 1785 (class 2606 OID 16975)
-- Dependencies: 1487 1480 1779
-- Name: fkev; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT fkev FOREIGN KEY (idev) REFERENCES entidadverificadora(id);


--
-- TOC entry 1855 (class 0 OID 0)
-- Dependencies: 1785
-- Name: CONSTRAINT fkev ON auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT fkev ON auditoria IS 'Relaciona las auditorias con las entidades verificadoras';


--
-- TOC entry 1786 (class 2606 OID 16980)
-- Dependencies: 1489 1783 1480
-- Name: fkinst; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY auditoria
    ADD CONSTRAINT fkinst FOREIGN KEY (idinstitucion) REFERENCES institucion(id);


--
-- TOC entry 1856 (class 0 OID 0)
-- Dependencies: 1786
-- Name: CONSTRAINT fkinst ON auditoria; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT fkinst ON auditoria IS 'Relaciona las auditorias con las instituciones';


--
-- TOC entry 1799 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2010-05-03 13:06:00 VET

--
-- PostgreSQL database dump complete
--

