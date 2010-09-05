
CREATE TABLE spider_job (
    id      INTEGER PRIMARY KEY,
    num     INTEGER,
    dir     INTEGER,
    depth   INTEGER,
    base    VARCHAR(256),
    state   INTEGER
);

CREATE TABLE spider_url (
    job     INTEGER REFERENCES spider_job(id),
    url     TEXT,
    title   TEXT,
    state   INTEGER,
    sum     VARCHAR(32),
    UNIQUE (job, sum),
    PRIMARY KEY (job, url)
);

