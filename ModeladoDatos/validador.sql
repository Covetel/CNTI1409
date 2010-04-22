--
-- PostgreSQL database dump
--

-- Started on 2010-04-22 12:43:43 VET

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1795 (class 1262 OID 16525)
-- Dependencies: 1794
-- Name: validador; Type: COMMENT; Schema: -; Owner: admin
--

COMMENT ON DATABASE validador IS 'Base de datos del sistema de Validacion de Portales del CNTI';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1485 (class 1259 OID 16584)
-- Dependencies: 3
-- Name: Auditoria; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE "Auditoria" (
    "ID" bigint NOT NULL,
    "IDEV" bigint NOT NULL,
    "IDInstitucion" bigint NOT NULL,
    portal character(50) NOT NULL,
    "fechaIni" date NOT NULL,
    "fechaFin" date,
    "URL" text NOT NULL,
    "fechaCreacion" date NOT NULL
);


ALTER TABLE public."Auditoria" OWNER TO admin;

--
-- TOC entry 1798 (class 0 OID 0)
-- Dependencies: 1485
-- Name: TABLE "Auditoria"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE "Auditoria" IS 'Almacena los datos de las auditorias, aqui se registran los datos de los portales.';


--
-- TOC entry 1799 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN "Auditoria"."ID"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Auditoria"."ID" IS 'Numero de identificacion unica de las auditorias';


--
-- TOC entry 1800 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN "Auditoria"."IDEV"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Auditoria"."IDEV" IS 'Clave de relacion entre las entidades verificadoras y las auditorias';


--
-- TOC entry 1801 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN "Auditoria"."IDInstitucion"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Auditoria"."IDInstitucion" IS 'Clave que relaciona las instituciones con las auditorias';


--
-- TOC entry 1802 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN "Auditoria".portal; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Auditoria".portal IS 'Almacena el nombre del portal a auditar';


--
-- TOC entry 1803 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN "Auditoria"."fechaIni"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Auditoria"."fechaIni" IS 'Fecha de inicio de la auditoria';


--
-- TOC entry 1804 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN "Auditoria"."fechaFin"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Auditoria"."fechaFin" IS 'Fecha de finalizacion de la auditoria, si este campo contiene un dato se da la auditoria como cerrada';


--
-- TOC entry 1805 (class 0 OID 0)
-- Dependencies: 1485
-- Name: COLUMN "Auditoria"."URL"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Auditoria"."URL" IS 'Almacena el listado de las URL a auditar en un portal';


--
-- TOC entry 1488 (class 1259 OID 16611)
-- Dependencies: 1762 3
-- Name: AuditoriaDetalle; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE "AuditoriaDetalle" (
    "ID" bigint NOT NULL,
    "IDAuditoria" bigint NOT NULL,
    "IDDisposicion" bigint NOT NULL,
    "Resultado" boolean DEFAULT true NOT NULL,
    "ResDetalle" text,
    "Comentario" character(200),
    "Resolutoria" character(200),
    "URL" character(300)
);


ALTER TABLE public."AuditoriaDetalle" OWNER TO admin;

--
-- TOC entry 1806 (class 0 OID 0)
-- Dependencies: 1488
-- Name: TABLE "AuditoriaDetalle"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE "AuditoriaDetalle" IS 'Almacena los detalles de una auditoria, sobre todo los resultados de las disposiciones por portal';


--
-- TOC entry 1807 (class 0 OID 0)
-- Dependencies: 1488
-- Name: COLUMN "AuditoriaDetalle"."ID"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "AuditoriaDetalle"."ID" IS 'Numero de identificacion unica para los detalles de las auditorias';


--
-- TOC entry 1808 (class 0 OID 0)
-- Dependencies: 1488
-- Name: COLUMN "AuditoriaDetalle"."IDAuditoria"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "AuditoriaDetalle"."IDAuditoria" IS 'Clave que relaciona los detalles de la auditoria con sus datos maestros';


--
-- TOC entry 1809 (class 0 OID 0)
-- Dependencies: 1488
-- Name: COLUMN "AuditoriaDetalle"."IDDisposicion"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "AuditoriaDetalle"."IDDisposicion" IS 'Clave que relaciona los detalles de las auditorias con cada disposicion';


--
-- TOC entry 1810 (class 0 OID 0)
-- Dependencies: 1488
-- Name: COLUMN "AuditoriaDetalle"."Resultado"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "AuditoriaDetalle"."Resultado" IS 'Determina si una disposicion es valida o no';


--
-- TOC entry 1811 (class 0 OID 0)
-- Dependencies: 1488
-- Name: COLUMN "AuditoriaDetalle"."ResDetalle"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "AuditoriaDetalle"."ResDetalle" IS 'Detalle del resultado de una disposicion si esta no es valida';


--
-- TOC entry 1812 (class 0 OID 0)
-- Dependencies: 1488
-- Name: COLUMN "AuditoriaDetalle"."Comentario"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "AuditoriaDetalle"."Comentario" IS 'Comentario del auditor por cada disposicion evaluada en algun portal';


--
-- TOC entry 1813 (class 0 OID 0)
-- Dependencies: 1488
-- Name: COLUMN "AuditoriaDetalle"."Resolutoria"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "AuditoriaDetalle"."Resolutoria" IS 'Resolutoria del auditor por cada disposicion evaluada a un portal';


--
-- TOC entry 1487 (class 1259 OID 16609)
-- Dependencies: 1488 3
-- Name: AuditoriaDetalle_IDDisposicion_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE "AuditoriaDetalle_IDDisposicion_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."AuditoriaDetalle_IDDisposicion_seq" OWNER TO admin;

--
-- TOC entry 1814 (class 0 OID 0)
-- Dependencies: 1487
-- Name: AuditoriaDetalle_IDDisposicion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE "AuditoriaDetalle_IDDisposicion_seq" OWNED BY "AuditoriaDetalle"."IDDisposicion";


--
-- TOC entry 1815 (class 0 OID 0)
-- Dependencies: 1487
-- Name: AuditoriaDetalle_IDDisposicion_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('"AuditoriaDetalle_IDDisposicion_seq"', 1, false);


--
-- TOC entry 1486 (class 1259 OID 16607)
-- Dependencies: 1488 3
-- Name: AuditoriaDetalle_ID_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE "AuditoriaDetalle_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."AuditoriaDetalle_ID_seq" OWNER TO admin;

--
-- TOC entry 1816 (class 0 OID 0)
-- Dependencies: 1486
-- Name: AuditoriaDetalle_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE "AuditoriaDetalle_ID_seq" OWNED BY "AuditoriaDetalle"."ID";


--
-- TOC entry 1817 (class 0 OID 0)
-- Dependencies: 1486
-- Name: AuditoriaDetalle_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('"AuditoriaDetalle_ID_seq"', 1, false);


--
-- TOC entry 1484 (class 1259 OID 16582)
-- Dependencies: 1485 3
-- Name: Auditoria_ID_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE "Auditoria_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."Auditoria_ID_seq" OWNER TO admin;

--
-- TOC entry 1818 (class 0 OID 0)
-- Dependencies: 1484
-- Name: Auditoria_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE "Auditoria_ID_seq" OWNED BY "Auditoria"."ID";


--
-- TOC entry 1819 (class 0 OID 0)
-- Dependencies: 1484
-- Name: Auditoria_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('"Auditoria_ID_seq"', 1, false);


--
-- TOC entry 1483 (class 1259 OID 16574)
-- Dependencies: 1758 3
-- Name: Disposicion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE "Disposicion" (
    "ID" integer NOT NULL,
    nombre character(25) NOT NULL,
    descripcion character(70) NOT NULL,
    habilitado boolean DEFAULT true NOT NULL
);


ALTER TABLE public."Disposicion" OWNER TO admin;

--
-- TOC entry 1820 (class 0 OID 0)
-- Dependencies: 1483
-- Name: TABLE "Disposicion"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE "Disposicion" IS 'Contiene los datos sobre las disposiciones';


--
-- TOC entry 1821 (class 0 OID 0)
-- Dependencies: 1483
-- Name: COLUMN "Disposicion"."ID"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Disposicion"."ID" IS 'Numero de identificacion unica de la disposicion';


--
-- TOC entry 1822 (class 0 OID 0)
-- Dependencies: 1483
-- Name: COLUMN "Disposicion".nombre; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Disposicion".nombre IS 'Nombre de la disposicion';


--
-- TOC entry 1823 (class 0 OID 0)
-- Dependencies: 1483
-- Name: COLUMN "Disposicion".descripcion; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Disposicion".descripcion IS 'Descripcion de la disposicion';


--
-- TOC entry 1824 (class 0 OID 0)
-- Dependencies: 1483
-- Name: COLUMN "Disposicion".habilitado; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Disposicion".habilitado IS 'Campo booleano que representa si la disposicion esta habilitada o no, este campo es pensado en caracteristicas futuras de la aplicacion';


--
-- TOC entry 1482 (class 1259 OID 16572)
-- Dependencies: 3 1483
-- Name: Disposicion_ID_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE "Disposicion_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."Disposicion_ID_seq" OWNER TO admin;

--
-- TOC entry 1825 (class 0 OID 0)
-- Dependencies: 1482
-- Name: Disposicion_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE "Disposicion_ID_seq" OWNED BY "Disposicion"."ID";


--
-- TOC entry 1826 (class 0 OID 0)
-- Dependencies: 1482
-- Name: Disposicion_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('"Disposicion_ID_seq"', 1, false);


--
-- TOC entry 1479 (class 1259 OID 16548)
-- Dependencies: 3
-- Name: EntidadVerificadora; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE "EntidadVerificadora" (
    "ID" integer NOT NULL,
    "Nombre" character(50) NOT NULL,
    "RIF" character(15),
    "Correo" character(30) NOT NULL,
    "Telefono" character(15) NOT NULL,
    "Contacto" character(30) NOT NULL
);


ALTER TABLE public."EntidadVerificadora" OWNER TO admin;

--
-- TOC entry 1827 (class 0 OID 0)
-- Dependencies: 1479
-- Name: TABLE "EntidadVerificadora"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE "EntidadVerificadora" IS 'Datos maestros de las Entidades Verificadoras';


--
-- TOC entry 1828 (class 0 OID 0)
-- Dependencies: 1479
-- Name: COLUMN "EntidadVerificadora"."ID"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "EntidadVerificadora"."ID" IS 'Numero de identificacion unico para las Entidades Verificadoras';


--
-- TOC entry 1829 (class 0 OID 0)
-- Dependencies: 1479
-- Name: COLUMN "EntidadVerificadora"."Nombre"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "EntidadVerificadora"."Nombre" IS 'Nombre o Razon Social de la Entidad Verificadora';


--
-- TOC entry 1830 (class 0 OID 0)
-- Dependencies: 1479
-- Name: COLUMN "EntidadVerificadora"."RIF"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "EntidadVerificadora"."RIF" IS 'Numero fiscal de la Entidad Verificadora';


--
-- TOC entry 1831 (class 0 OID 0)
-- Dependencies: 1479
-- Name: COLUMN "EntidadVerificadora"."Correo"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "EntidadVerificadora"."Correo" IS 'correo electronico de la entidad verificadora';


--
-- TOC entry 1832 (class 0 OID 0)
-- Dependencies: 1479
-- Name: COLUMN "EntidadVerificadora"."Telefono"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "EntidadVerificadora"."Telefono" IS 'Numero de telefono de la Entidad Verificadora';


--
-- TOC entry 1833 (class 0 OID 0)
-- Dependencies: 1479
-- Name: COLUMN "EntidadVerificadora"."Contacto"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "EntidadVerificadora"."Contacto" IS 'Nombre de la persona contacto de la Entidad Verificadora';


--
-- TOC entry 1478 (class 1259 OID 16546)
-- Dependencies: 3 1479
-- Name: EntidadVerificadora_ID_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE "EntidadVerificadora_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."EntidadVerificadora_ID_seq" OWNER TO admin;

--
-- TOC entry 1834 (class 0 OID 0)
-- Dependencies: 1478
-- Name: EntidadVerificadora_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE "EntidadVerificadora_ID_seq" OWNED BY "EntidadVerificadora"."ID";


--
-- TOC entry 1835 (class 0 OID 0)
-- Dependencies: 1478
-- Name: EntidadVerificadora_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('"EntidadVerificadora_ID_seq"', 1, false);


--
-- TOC entry 1481 (class 1259 OID 16558)
-- Dependencies: 3
-- Name: Insititucion; Type: TABLE; Schema: public; Owner: admin; Tablespace: 
--

CREATE TABLE "Insititucion" (
    "ID" integer NOT NULL,
    "Nombre" character(50) NOT NULL,
    "RIF" character(15),
    correo character(30) NOT NULL,
    telefono character(15) NOT NULL,
    contacto character(50) NOT NULL
);


ALTER TABLE public."Insititucion" OWNER TO admin;

--
-- TOC entry 1836 (class 0 OID 0)
-- Dependencies: 1481
-- Name: TABLE "Insititucion"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON TABLE "Insititucion" IS 'Contiene los datos maestros de las instituciones';


--
-- TOC entry 1837 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN "Insititucion"."ID"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Insititucion"."ID" IS 'Numero de identificacion unica para las instituciones';


--
-- TOC entry 1838 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN "Insititucion"."Nombre"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Insititucion"."Nombre" IS 'Nombre o Razon Social de la Insitucion';


--
-- TOC entry 1839 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN "Insititucion"."RIF"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Insititucion"."RIF" IS 'Numero Fiscal de la Institucion';


--
-- TOC entry 1840 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN "Insititucion".correo; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Insititucion".correo IS 'Correo Electronico de la institucion';


--
-- TOC entry 1841 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN "Insititucion".telefono; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Insititucion".telefono IS 'Numero de telefono de la institucion';


--
-- TOC entry 1842 (class 0 OID 0)
-- Dependencies: 1481
-- Name: COLUMN "Insititucion".contacto; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON COLUMN "Insititucion".contacto IS 'Nombre de la persona contacto en la institucion';


--
-- TOC entry 1480 (class 1259 OID 16556)
-- Dependencies: 3 1481
-- Name: Insititucion_ID_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE "Insititucion_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."Insititucion_ID_seq" OWNER TO admin;

--
-- TOC entry 1843 (class 0 OID 0)
-- Dependencies: 1480
-- Name: Insititucion_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE "Insititucion_ID_seq" OWNED BY "Insititucion"."ID";


--
-- TOC entry 1844 (class 0 OID 0)
-- Dependencies: 1480
-- Name: Insititucion_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('"Insititucion_ID_seq"', 1, false);


--
-- TOC entry 1759 (class 2604 OID 16587)
-- Dependencies: 1485 1484 1485
-- Name: ID; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE "Auditoria" ALTER COLUMN "ID" SET DEFAULT nextval('"Auditoria_ID_seq"'::regclass);


--
-- TOC entry 1760 (class 2604 OID 16614)
-- Dependencies: 1486 1488 1488
-- Name: ID; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE "AuditoriaDetalle" ALTER COLUMN "ID" SET DEFAULT nextval('"AuditoriaDetalle_ID_seq"'::regclass);


--
-- TOC entry 1761 (class 2604 OID 16615)
-- Dependencies: 1487 1488 1488
-- Name: IDDisposicion; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE "AuditoriaDetalle" ALTER COLUMN "IDDisposicion" SET DEFAULT nextval('"AuditoriaDetalle_IDDisposicion_seq"'::regclass);


--
-- TOC entry 1757 (class 2604 OID 16577)
-- Dependencies: 1483 1482 1483
-- Name: ID; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE "Disposicion" ALTER COLUMN "ID" SET DEFAULT nextval('"Disposicion_ID_seq"'::regclass);


--
-- TOC entry 1755 (class 2604 OID 16551)
-- Dependencies: 1479 1478 1479
-- Name: ID; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE "EntidadVerificadora" ALTER COLUMN "ID" SET DEFAULT nextval('"EntidadVerificadora_ID_seq"'::regclass);


--
-- TOC entry 1756 (class 2604 OID 16561)
-- Dependencies: 1481 1480 1481
-- Name: ID; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE "Insititucion" ALTER COLUMN "ID" SET DEFAULT nextval('"Insititucion_ID_seq"'::regclass);


--
-- TOC entry 1790 (class 0 OID 16584)
-- Dependencies: 1485
-- Data for Name: Auditoria; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY "Auditoria" ("ID", "IDEV", "IDInstitucion", portal, "fechaIni", "fechaFin", "URL", "fechaCreacion") FROM stdin;
\.


--
-- TOC entry 1791 (class 0 OID 16611)
-- Dependencies: 1488
-- Data for Name: AuditoriaDetalle; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY "AuditoriaDetalle" ("ID", "IDAuditoria", "IDDisposicion", "Resultado", "ResDetalle", "Comentario", "Resolutoria", "URL") FROM stdin;
\.


--
-- TOC entry 1789 (class 0 OID 16574)
-- Dependencies: 1483
-- Data for Name: Disposicion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY "Disposicion" ("ID", nombre, descripcion, habilitado) FROM stdin;
\.


--
-- TOC entry 1787 (class 0 OID 16548)
-- Dependencies: 1479
-- Data for Name: EntidadVerificadora; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY "EntidadVerificadora" ("ID", "Nombre", "RIF", "Correo", "Telefono", "Contacto") FROM stdin;
\.


--
-- TOC entry 1788 (class 0 OID 16558)
-- Dependencies: 1481
-- Data for Name: Insititucion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY "Insititucion" ("ID", "Nombre", "RIF", correo, telefono, contacto) FROM stdin;
\.


--
-- TOC entry 1772 (class 2606 OID 16580)
-- Dependencies: 1483 1483
-- Name: idxDisp; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY "Disposicion"
    ADD CONSTRAINT "idxDisp" PRIMARY KEY ("ID");


--
-- TOC entry 1782 (class 2606 OID 16621)
-- Dependencies: 1488 1488
-- Name: pkAudDet; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY "AuditoriaDetalle"
    ADD CONSTRAINT "pkAudDet" PRIMARY KEY ("ID");


--
-- TOC entry 1779 (class 2606 OID 16592)
-- Dependencies: 1485 1485
-- Name: pkAudit; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY "Auditoria"
    ADD CONSTRAINT "pkAudit" PRIMARY KEY ("ID");


--
-- TOC entry 1845 (class 0 OID 0)
-- Dependencies: 1779
-- Name: CONSTRAINT "pkAudit" ON "Auditoria"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT "pkAudit" ON "Auditoria" IS 'Clave Primaria de las auditorias';


--
-- TOC entry 1766 (class 2606 OID 16553)
-- Dependencies: 1479 1479
-- Name: pkEV; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY "EntidadVerificadora"
    ADD CONSTRAINT "pkEV" PRIMARY KEY ("ID");


--
-- TOC entry 1770 (class 2606 OID 16563)
-- Dependencies: 1481 1481
-- Name: pkIDInst; Type: CONSTRAINT; Schema: public; Owner: admin; Tablespace: 
--

ALTER TABLE ONLY "Insititucion"
    ADD CONSTRAINT "pkIDInst" PRIMARY KEY ("ID");


--
-- TOC entry 1774 (class 1259 OID 16606)
-- Dependencies: 1485
-- Name: fki_fkEV; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX "fki_fkEV" ON "Auditoria" USING btree ("IDEV");


--
-- TOC entry 1775 (class 1259 OID 16605)
-- Dependencies: 1485
-- Name: fki_fkInst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX "fki_fkInst" ON "Auditoria" USING btree ("IDInstitucion");


--
-- TOC entry 1780 (class 1259 OID 16632)
-- Dependencies: 1488
-- Name: idxAudRes; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX "idxAudRes" ON "AuditoriaDetalle" USING btree ("Resultado");


--
-- TOC entry 1776 (class 1259 OID 16604)
-- Dependencies: 1485
-- Name: idxAuditFecha; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX "idxAuditFecha" ON "Auditoria" USING btree ("fechaFin");


--
-- TOC entry 1846 (class 0 OID 0)
-- Dependencies: 1776
-- Name: INDEX "idxAuditFecha"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX "idxAuditFecha" IS 'Indice por fecha de auditoria';


--
-- TOC entry 1763 (class 1259 OID 16554)
-- Dependencies: 1479
-- Name: idxNomEV; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX "idxNomEV" ON "EntidadVerificadora" USING btree ("Nombre");


--
-- TOC entry 1847 (class 0 OID 0)
-- Dependencies: 1763
-- Name: INDEX "idxNomEV"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX "idxNomEV" IS 'Indice por nombre de entidad verificadora';


--
-- TOC entry 1767 (class 1259 OID 16564)
-- Dependencies: 1481
-- Name: idxNomInst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX "idxNomInst" ON "Insititucion" USING btree ("Nombre");


--
-- TOC entry 1848 (class 0 OID 0)
-- Dependencies: 1767
-- Name: INDEX "idxNomInst"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX "idxNomInst" IS 'Indice Nombre de la Institucion';


--
-- TOC entry 1773 (class 1259 OID 16581)
-- Dependencies: 1483
-- Name: idxNombreDisp; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX "idxNombreDisp" ON "Disposicion" USING btree (nombre);


--
-- TOC entry 1849 (class 0 OID 0)
-- Dependencies: 1773
-- Name: INDEX "idxNombreDisp"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX "idxNombreDisp" IS 'Indice del Nombre de la Disposicion';


--
-- TOC entry 1777 (class 1259 OID 16603)
-- Dependencies: 1485
-- Name: idxPortal; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE INDEX "idxPortal" ON "Auditoria" USING btree (portal);


--
-- TOC entry 1850 (class 0 OID 0)
-- Dependencies: 1777
-- Name: INDEX "idxPortal"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX "idxPortal" IS 'Indice por portal de la tabla auditoria';


--
-- TOC entry 1764 (class 1259 OID 16555)
-- Dependencies: 1479
-- Name: idxRIFEV; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX "idxRIFEV" ON "EntidadVerificadora" USING btree ("RIF");


--
-- TOC entry 1851 (class 0 OID 0)
-- Dependencies: 1764
-- Name: INDEX "idxRIFEV"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX "idxRIFEV" IS 'Indice por RIF de la Entidad Verificadora';


--
-- TOC entry 1768 (class 1259 OID 16565)
-- Dependencies: 1481
-- Name: idxRIFInst; Type: INDEX; Schema: public; Owner: admin; Tablespace: 
--

CREATE UNIQUE INDEX "idxRIFInst" ON "Insititucion" USING btree ("RIF");


--
-- TOC entry 1852 (class 0 OID 0)
-- Dependencies: 1768
-- Name: INDEX "idxRIFInst"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON INDEX "idxRIFInst" IS 'Indice RIF de la Institucion';


--
-- TOC entry 1785 (class 2606 OID 16622)
-- Dependencies: 1778 1485 1488
-- Name: fkAuditoria; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY "AuditoriaDetalle"
    ADD CONSTRAINT "fkAuditoria" FOREIGN KEY ("IDAuditoria") REFERENCES "Auditoria"("ID");


--
-- TOC entry 1786 (class 2606 OID 16627)
-- Dependencies: 1483 1771 1488
-- Name: fkDisp; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY "AuditoriaDetalle"
    ADD CONSTRAINT "fkDisp" FOREIGN KEY ("IDDisposicion") REFERENCES "Disposicion"("ID");


--
-- TOC entry 1783 (class 2606 OID 16593)
-- Dependencies: 1485 1765 1479
-- Name: fkEV; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY "Auditoria"
    ADD CONSTRAINT "fkEV" FOREIGN KEY ("IDEV") REFERENCES "EntidadVerificadora"("ID");


--
-- TOC entry 1853 (class 0 OID 0)
-- Dependencies: 1783
-- Name: CONSTRAINT "fkEV" ON "Auditoria"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT "fkEV" ON "Auditoria" IS 'Relaciona las auditorias con las entidades verificadoras';


--
-- TOC entry 1784 (class 2606 OID 16598)
-- Dependencies: 1485 1769 1481
-- Name: fkInst; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY "Auditoria"
    ADD CONSTRAINT "fkInst" FOREIGN KEY ("IDInstitucion") REFERENCES "Insititucion"("ID");


--
-- TOC entry 1854 (class 0 OID 0)
-- Dependencies: 1784
-- Name: CONSTRAINT "fkInst" ON "Auditoria"; Type: COMMENT; Schema: public; Owner: admin
--

COMMENT ON CONSTRAINT "fkInst" ON "Auditoria" IS 'Relaciona las auditorias con las instituciones';


--
-- TOC entry 1797 (class 0 OID 0)
-- Dependencies: 3
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2010-04-22 12:43:43 VET

--
-- PostgreSQL database dump complete
--

