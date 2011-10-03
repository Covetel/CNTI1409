--
-- PostgreSQL database dump
--

-- Dumped from database version 8.3.9
-- Dumped by pg_dump version 9.0.3
-- Started on 2011-10-02 22:55:05 VET

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- TOC entry 1802 (class 0 OID 0)
-- Dependencies: 1508
-- Name: disposicion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('disposicion_id_seq', 29, true);


--
-- TOC entry 1799 (class 0 OID 33121)
-- Dependencies: 1507
-- Data for Name: disposicion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY disposicion (id, nombre, descripcion, habilitado, modulo, descripcion_prueba) FROM stdin;
1	Dominio	Todo Portal de Internet de los órganos y entes de la Administración Pública Nacional deberá ser accesible a través de un nombre de dominio compuesto por el dominio de segundo nivel que represente el nombre del órgano o ente encargado del Portal de Internet, dominio genérico de segundo nivel (.gob), seguido del dominio de primer nivel de país (.ve).	t	Domain	Verifica y valida si cumple o no con las especificaciones del nombre de Dominio dispuestas en la Norma
3	Etiqueta Title	Todo Portal de Internet de los órganos y entes de la Administración Pública Nacional deberá poseer la meta etiqueta Title por cada una de sus páginas internas, y esta etiqueta debe contener el titulo de la página. \n	t	Title	Cumple con las especificaciones de la etiqueta TITLE dispuestas en la norma
4	UTF8	Todo Portal de Internet de los órganos y entes de la Administración Pública Nacional deberá utilizar la especificación Unicode 8 bit (UTF-8) para codificar el Juego de Caracteres de sus documentos de hipertexto.\n	t	UTF8	Verificar y validar la codificación del juego de caracteres de sus Archivos de Hipertexto, utiliza las especificaciones Unicode 8 bit (UTF-8)
9	Imagenes PNG	Los archivos de imágenes y gráficos a ser usados en los Portales de Internet, deberán utilizar como formato la especificación PNG, según se describe en la Norma ISO/IEC 15948:2003, dictada por la Organización Internacional para la Estandarización.	t	Img	Analizar la metadata de los gráficos e imágenes que se encuentren en el árbol HTML del documento, verificar que el formato no es diferente de PNG.
11	Atributo alt	Se debe utilizar el atributo ALT, del elemento IMG descrito en la especificación HTML 4.01, para definir un texto alterno a las imágenes a ser usadas en los Portales de Internet, con el fin de mejorar el acceso y la usabilidad de los Portales de Internet para aquellos usuarios que tengan deshabilitados el despliegue de imágenes o que por cualquier razón no puedan apreciar esas imágenes.	t	Alt	Validar y verificar el uso del atributo ALT, en la etiqueta IMG el elemento IMG descrito en la especificación HTML 4.01 para definir un texto alterno a las imágenes usadas en el portal
12	Uso de Javascript	El Lenguaje Script a ser usado en los Portales de Internet debe ser JavaScript en su versión 1.7 ECMA-262, como mínimo, debiendo colocar el código JavaScript de manera separada en un archivo de extensión ".js".	t	JS	Verificar y validar la utilización del lenguaje Javascript
13	Archivos js	El código del Lenguaje Script JavaScript usado en los Portales de Internet debe ser colocado de manera separada en un archivo de extensión ".js".	t	JS_inc	Verificar y validar la inclusión de archivos ".js" del Lenguaje Script JavaScript. Validar que no se encuentran embebido en el árbol de la estructura HTML del Portal de Internet.
15	HTML 4.01/XHTML 1.0	Los documentos de hipertexto a ser usados en los Portales de Internet deberán utilizar como formato las especificaciones HTML 4.01, según se expresa en las recomendaciones XHTML 4.01 del 24 de diciembre de 1999, o XHTML 1.0 de fecha 1 de agosto de 2002, de la W3C. Los Documentos de hipertexto de los Portales de Internet sujetos a esta Resolución deben ser validados utilizando las herramientas que la W3C dispone en línea, procurándose la inclusión gráfica en los Portales de los sellos de conformidad dispuestos por la W3C.	t	HTML4	Verificar y validar el uso de HTML 4.01 o XHTML 1.0 para la estructura organizativa de portales.
18	Controles Añadibles	A los efectos de esta Resolución y de la diagramación gráfica de los Portales de Internet en los órganos y entes, se debe utilizar tipografía abierta que no requiera de pago de regalias.	t	Plugins	Verificar y validar el uso de tipografía abierta, es decir, queno requiere de pago de regalías
22	Fuentes Libres	Verificar el uso de Fuentes Libres	t	Fonts	Verificar el uso de fuentes libres
27	Uso de SSL	Verificar el uso de SSL para el envío de indatos sensibles	t	SSL	Verificar el uso de SSL para el envío de indatos sensibles
28	Validar CSS contra W3C	Hacer uso del validador oficial de la W3C para la validación de CSS	t	W3C_CSS	Hacer uso del validador oficial de la W3C para la validación de CSS
29	Validar HTML contra W3C	Hacer uso del validador oficial de la W3C para la validación del HTML	t	W3C_HTML	Hacer uso del validador oficial de la W3C para la validación del HTML
24	Uso de meta etiquetas	Verificar el uso de meta etiquetas en el portal	t	Meta	Verificar el uso de meta etiquetas en el portal
25	Uso de formatos libres	Verificar que no existan formatos no libres disponibles para la descarga	t	Formatos	Verificar que no existan formatos no libres disponibles para la descarga
26	Maquetado del sitio	Verificar que el maquetado del portal no sea por medio de tablas	t	Layout	Verificar que el maquetado del portal no sea por medio de tablas
\.


-- Completed on 2011-10-02 22:55:05 VET

--
-- PostgreSQL database dump complete
--

