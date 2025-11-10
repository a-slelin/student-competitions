--liquibase formatted sql

--changeset a.slelin:003-create-table-student

CREATE TABLE student (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name VARCHAR(50) NOT NULL
        CHECK (LENGTH(TRIM(name)) >= 3 AND LENGTH(name) <= 50),

    surname VARCHAR(50) NOT NULL
        CHECK (LENGTH(TRIM(name)) >= 3 AND LENGTH(name) <= 50),

    middle_name VARCHAR(50)
        CHECK (middle_name IS NULL OR (LENGTH(middle_name) >= 3 AND LENGTH(middle_name) <= 50)),

    card_number BIGINT UNIQUE NOT NULL
        CHECK (card_number >= 0),

    faculty VARCHAR(50) NOT NULL CHECK (faculty IN (
	'Факультет биологии и экологии', 'Факультет Информатики и вычислительной техники',
	'Исторический факультет', 'Математический факультет', 'Факультет психологии', 'Факультет социально-политических наук',
	'Факультет иностранных языков', 'Физико-технический факультет', 'Факультет филологии и коммуникации', 'Экономический факультет',
	'Юридический факультет')),

    department VARCHAR(20)
         CHECK (department IS NULL OR LENGTH(TRIM(department)) > 0),

    study_group VARCHAR(50)
        CHECK (study_group IS NULL OR LENGTH(TRIM(study_group)) > 0),

    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--rollback DROP TABLE IF EXISTS student