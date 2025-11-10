--liquibase formatted sql

--changeset a.slelin:002-create-table-result

CREATE TABLE result (
    code VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    sort_order INTEGER NOT NULL,
    CONSTRAINT uq_result_name UNIQUE (name)
);

--rollback DROP TABLE IF EXISTS result