ALTER TABLE ONLY public.urls DROP CONSTRAINT urls_job_id_fkey;
ALTER TABLE ONLY public.results DROP CONSTRAINT results_url_id_fkey;
ALTER TABLE ONLY public.events DROP CONSTRAINT events_result_id_fkey;
DROP INDEX public.urls_job_id_state;
ALTER TABLE ONLY public.urls DROP CONSTRAINT urls_pkey;
ALTER TABLE ONLY public.results DROP CONSTRAINT results_pkey;
ALTER TABLE ONLY public.jobs DROP CONSTRAINT jobs_pkey;
ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
DROP TABLE public.urls;
DROP TABLE public.results;
DROP TABLE public.jobs;
DROP TABLE public.events;

CREATE TABLE jobs (
    id          SERIAL PRIMARY KEY,
    site        TEXT,
    callback    TEXT,
    data        TEXT,
    state       VARCHAR(10), -- new, run, done 
    ctime       TIMESTAMP,
    mtime       TIMESTAMP
);

CREATE TABLE urls (
    id          SERIAL PRIMARY KEY,
    job_id      INTEGER REFERENCES jobs(id) ON DELETE CASCADE,
    path        TEXT,
    state       VARCHAR(10), -- new, run, done
    ctime       TIMESTAMP,
    mtime       TIMESTAMP
);

CREATE INDEX urls_job_id_state ON urls (job_id, state);

CREATE TABLE results (
    id          SERIAL PRIMARY KEY,
    url_id      INTEGER REFERENCES urls(id) ON DELETE CASCADE,
    pass        INTEGER,
    name        TEXT
);

CREATE TABLE events (
    id          SERIAL PRIMARY KEY,
    result_id   INTEGER REFERENCES results(id) ON DELETE CASCADE,
    class       TEXT,
    message     TEXT,
    data        TEXT
);
