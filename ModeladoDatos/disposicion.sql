ALTER TABLE disposicion ALTER COLUMN descripcion TYPE text;
ALTER TABLE disposicion ADD COLUMN descripcion_prueba text;
ALTER TABLE disposicion ALTER COLUMN descripcion_prueba SET STORAGE EXTENDED;
