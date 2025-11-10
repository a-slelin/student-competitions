--liquibase formatted sql

--changeset a.slelin:001-create-table-level

CREATE TABLE level (
    code VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    sort_order INTEGER NOT NULL,
    CONSTRAINT uq_level_name UNIQUE (name)
);

--rollback DROP TABLE IF EXISTS level