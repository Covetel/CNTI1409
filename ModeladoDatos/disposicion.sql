ALTER TABLE disposicion ADD COLUMN descripcion text;
ALTER TABLE disposicion ALTER COLUMN descripcion SET STORAGE EXTENDED;
ALTER TABLE disposicion ALTER COLUMN descripcion SET NOT NULL;
COMMENT ON COLUMN disposicion.descripcion IS 'Descripcion de la disposicion';

ALTER TABLE disposicion ADD COLUMN descripcion_prueba text;
ALTER TABLE disposicion ALTER COLUMN descripcion_prueba SET STORAGE EXTENDED;

DELETE FROM disposicion;

INSERT INTO disposicion VALUES (1, 'Dominio', 'Todo Portal de Internet de los órganos y entes de la Administración Pública Nacional deberá ser accesible a través de un nombre de dominio compuesto por el dominio de segundo nivel que represente el nombre del órgano o ente encargado del Portal de Internet, dominio genérico de segundo nivel (.gob), seguido del dominio de primer nivel de país (.ve).', true, 'Domain', 'Verifica y valida si cumple o no con las especificaciones del nombre de Dominio dispuestas en la Norma.
');
INSERT INTO disposicion VALUES (17, 'Controles Añadibles', 'Solo podrán usarse en los Portales de Internet de los órganos y entes de la Administración Pública Nacional aquellos controladores añadibles que cumplan con la definición de Software Libre, en los términos establecidos en el marco legal vigente. Está prohibido el uso de controladores privativos en todo Portal de Internet de los órganos y entes de la Administración Pública Nacional.', true, 'Plugins', 'Verificar y validar la utilización de controladores añadibles
que no cumplan con la definición de Software Libre, por ejemplo
flash, ActiveX.');
INSERT INTO disposicion VALUES (9, 'Imagenes PNG', 'Los archivos de imágenes y gráficos a ser usados en los Portales de Internet, deberán utilizar como formato la especificación PNG, según se describe en la Norma ISO/IEC 15948:2003, dictada por la Organización Internacional para la Estandarización.', true, 'Img', 'Analizar la metadata de los gráficos e imágenes que se encuentren en el árbol HTML del documento, verificar que el formato no es diferente de PNG.');
INSERT INTO disposicion VALUES (3, 'Etiqueta Title', 'Todo Portal de Internet de los órganos y entes de la Administración Pública Nacional deberá poseer la meta etiqueta Title por cada una de sus páginas internas, y esta etiqueta debe contener el titulo de la página.
', true, 'Title', 'Cumple con las especificaciones de la etiqueta TITLE dispuestas en la norma');
INSERT INTO disposicion VALUES (11, 'Atributo alt', 'Se debe utilizar el atributo ALT, del elemento IMG descrito en la especificación HTML 4.01, para definir un texto alterno a las imágenes a ser usadas en los Portales de Internet, con el fin de mejorar el acceso y la usabilidad de los Portales de Internet para aquellos usuarios que tengan deshabilitados el despliegue de imágenes o que por cualquier razón no puedan apreciar esas imágenes.', true, 'Alt', 'Validar y verificar el uso del atributo ALT, en la etiqueta IMG el elemento IMG descrito en la especificación HTML 4.01 para definir un texto alterno a las imágenes usadas en el portal');
INSERT INTO disposicion VALUES (4, 'Juego de Caracteres', 'Todo Portal de Internet de los órganos y entes de la Administración Pública Nacional deberá utilizar la especificación Unicode 8 bit (UTF-8) para codificar el Juego de Caracteres de sus documentos de hipertexto.
', true, 'UTF8', 'Verificar y validar la codificación del juego de caracteres de sus Archivos de Hipertexto, utiliza las especificaciones Unicode 8 bit (UTF-8)
');
INSERT INTO disposicion VALUES (12, 'Uso de Javascript', 'El Lenguaje Script a ser usado en los Portales de Internet debe ser JavaScript en su versión 1.7 ECMA-262, como mínimo, debiendo colocar el código JavaScript de manera separada en un archivo de extensión ".js".', true, 'JS', 'Verificar y validar la utilización del lenguaje Javascript');
INSERT INTO disposicion VALUES (18, 'Tipografía', '', true, 'Fonts', '');
INSERT INTO disposicion VALUES (13, 'Archivos js', 'El código del Lenguaje Script JavaScript usado en los Portales de Internet debe ser colocado de manera separada en un archivo de extensión ".js".', true, 'JS_inc', 'Verificar y validar la inclusión de archivos ".js" del Lenguaje Script JavaScript. Validar que no se encuentran embebido en el árbol de la estructura HTML del Portal de Internet.');
INSERT INTO disposicion VALUES (15, 'HTML 4.01/XHTML 1.0', 'Los documentos de hipertexto a ser usados en los Portales de Internet deberán utilizar como formato las especificaciones HTML 4.01, según se expresa en las recomendaciones XHTML 4.01 del 24 de diciembre de 1999, o XHTML 1.0 de fecha 1 de agosto de 2002, de la W3C.

Los Documentos de hipertexto de los Portales de Internet sujetos a esta Resolución deben ser validados utilizando las herramientas que la W3C dispone en línea, procurándose la inclusión gráfica en los Portales de los sellos de conformidad dispuestos por la W3C.', true, 'HTML4', 'Verificar y validar el uso de HTML 4.01 o XHTML 1.0 para
la estructura organizativa de portales.
');
