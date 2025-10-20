-- Создание таблицы для студентов

CREATE TABLE student (
    id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    card_number BIGINT UNIQUE NOT NULL,
    faculty VARCHAR(50) NOT NULL,
    university VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    study_group VARCHAR(50),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    description VARCHAR(256)
);

-- Создание таблицы для конкурсов

CREATE TABLE competition (
    id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    organizer VARCHAR(256),
    type VARCHAR(50) NOT NULL CHECK (type IN ('OLYMPIAD', 'CONTEST', 'CHAMPIONSHIP', 'COMPETITION')),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    description VARCHAR(256)
);

-- Создание таблицы для уровня

CREATE TABLE level (
    id BIGINT PRIMARY KEY,
    code VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    description VARCHAR(256)
);

-- Создание таблицы для результатов

CREATE TABLE result (
    id BIGINT PRIMARY KEY,
    code VARCHAR(256) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    description VARCHAR(256)
);

-- Создание таблицы для участия

CREATE TABLE participation (
    id UUID PRIMARY KEY,
    student_id UUID NOT NULL REFERENCES student(id),
    competition_id UUID NOT NULL REFERENCES competition(id),
    level_id BIGINT NOT NULL REFERENCES level(id),
    result_id BIGINT NOT NULL REFERENCES result(id),
    year INTEGER NOT NULL CHECK (year >= 2000 AND year <= EXTRACT(YEAR FROM CURRENT_DATE) + 1),
    supervisor VARCHAR(256),
    is_blocked BOOLEAN NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    description VARCHAR(256),

    -- Уникальное ограничение для предотвращения дубликатов
    UNIQUE(student_id, competition_id, year)
);