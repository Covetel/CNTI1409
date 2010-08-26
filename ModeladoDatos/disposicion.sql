ALTER TABLE disposicion ADD COLUMN descripcion text;
ALTER TABLE disposicion ALTER COLUMN descripcion SET STORAGE EXTENDED;
ALTER TABLE disposicion ALTER COLUMN descripcion SET NOT NULL;
COMMENT ON COLUMN disposicion.descripcion IS 'Descripcion de la disposicion';

LTER TABLE disposicion ADD COLUMN descripcion_prueba text;
ALTER TABLE disposicion ALTER COLUMN descripcion_prueba SET STORAGE EXTENDED;
