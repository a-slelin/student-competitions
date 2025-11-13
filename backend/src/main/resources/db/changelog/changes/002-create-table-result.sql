--liquibase formatted sql

--changeset a.slelin:002-create-table-result

CREATE TABLE result (
    code VARCHAR(20) PRIMARY KEY
        CHECK (LENGTH(code) >= 3 AND LENGTH(code) <= 20)
        CHECK (code ~ '^[A-Z]+$'),

    name VARCHAR(50) NOT NULL UNIQUE
        CHECK (LENGTH(TRIM(name)) >= 3 AND LENGTH(TRIM(name)) <= 50),

    sort_order INTEGER NOT NULL
        CHECK (sort_order >= 0)
);

--rollback DROP TABLE IF EXISTS result