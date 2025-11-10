--liquibase formatted sql

--changeset a.slelin:003-create-table-student

CREATE TABLE student (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    card_number BIGINT UNIQUE NOT NULL,
    faculty VARCHAR(50) NOT NULL CHECK (faculty IN (
	'Факультет биологии и экологии', 'Факультет Информатики и вычислительной техники',
	'Исторический факультет', 'Математический Факультет', 'Факультет психологии', 'Факультет социально-политических наук',
	'Факультет иностранных языков', 'Физико-технический факультет', 'Факультет филологии и коммуникации', 'Экономический факультет',
	'Юридический факультет')),
    department VARCHAR(20),
    study_group VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--rollback DROP TABLE IF EXISTS student