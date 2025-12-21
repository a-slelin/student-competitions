--liquibase formatted sql

--changeset a.slelin:004-create-table-competition

CREATE TABLE competition (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name VARCHAR(255) NOT NULL
        CHECK (LENGTH(TRIM(name)) > 0),

    organizer VARCHAR(255)
         CHECK (organizer IS NULL OR LENGTH(TRIM(organizer)) > 0),

	type VARCHAR(50) NOT NULL CHECK (type IN ('OLYMPIAD', 'CONTEST', 'CHAMPIONSHIP', 'COMPETITION')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--rollback DROP TABLE IF EXISTS competition