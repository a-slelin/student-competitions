
-- ============================================================================
-- Схема БД для системы учёта участия студентов в олимпиадах и конкурсах
-- Версия 3.0 - Упрощеная c триггерами
-- ============================================================================

-- ----------------------------------------------------------------------------
-- СПРАВОЧНЫЕ ТАБЛИЦЫ
-- ----------------------------------------------------------------------------

-- Справочник уровней участия
CREATE TABLE level (
    code VARCHAR(20) PRIMARY KEY  -- Код уровня (UNI, REG, RUS, INT)
        CHECK (LENGTH(code) >= 3 AND LENGTH(code) <= 20)
        CHECK (code ~ '^[A-Z]+$'),

    name VARCHAR(50) NOT NULL UNIQUE -- Отображаемое название
        CHECK (LENGTH(TRIM(name)) >= 3 AND LENGTH(TRIM(name)) <= 50),

    sort_order INTEGER NOT NULL -- Порядок сортировки для UI
        CHECK (sort_order >= 0) 
);

-- Справочник результатов участия
CREATE TABLE result (
    code VARCHAR(20) PRIMARY KEY -- Код результата (WIN, PRIZE, PART, DIQ, DIP)
        CHECK (LENGTH(code) >= 3 AND LENGTH(code) <= 20)
        CHECK (code ~ '^[A-Z]+$'),

    name VARCHAR(50) NOT NULL UNIQUE -- Отображаемое название
        CHECK (LENGTH(TRIM(name)) >= 3 AND LENGTH(TRIM(name)) <= 50),

    sort_order INTEGER NOT NULL -- Порядок сортировки для UI
        CHECK (sort_order >= 0)
);


-- ----------------------------------------------------------------------------
-- ОСНОВНЫЕ ТАБЛИЦЫ
-- ----------------------------------------------------------------------------

-- Таблица студентов
CREATE TABLE student (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Уникальный идентификатор

    name VARCHAR(50) NOT NULL -- Имя
        CHECK (LENGTH(TRIM(name)) >= 3 AND LENGTH(name) <= 50),

    surname VARCHAR(50) NOT NULL -- Фамилия
        CHECK (LENGTH(TRIM(name)) >= 3 AND LENGTH(name) <= 50),

    middle_name VARCHAR(50) -- Отчество (опционально)
        CHECK (middle_name IS NULL OR (LENGTH(middle_name) >= 3 AND LENGTH(middle_name) <= 50)),

    card_number BIGINT UNIQUE NOT NULL -- Номер студенческого билета (уникальный)
        CHECK (card_number >= 0),

    faculty VARCHAR(50) NOT NULL CHECK (faculty IN (
	'Факультет биологии и экологии', 'Факультет информатики и вычислительной техники',
	'Исторический факультет', 'Математический факультет', 'Факультет психологии', 'Факультет социально-политических наук',
	'Факультет иностранных языков', 'Физико-технический факультет', 'Факультет филологии и коммуникации', 'Экономический факультет',
	'Юридический факультет')), -- Факультет

    department VARCHAR(20) -- Кафедра
         CHECK (department IS NULL OR LENGTH(TRIM(department)) > 0),

    study_group VARCHAR(50) -- Учебная группа (опционально)
        CHECK (study_group IS NULL OR LENGTH(TRIM(study_group)) > 0),

    email VARCHAR(100), -- Email студента (опционально)
    phone VARCHAR(20), -- Телефон студента (опционально)
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Таблица конкурсов/олимпиад
CREATE TABLE competition (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Уникальный идентификатор

    name VARCHAR(255) NOT NULL -- Название мероприятия
        CHECK (LENGTH(TRIM(name)) > 0),

    organizer VARCHAR(255) -- Организатор (опционально)
         CHECK (organizer IS NULL OR LENGTH(TRIM(organizer)) > 0),

	type VARCHAR(50) NOT NULL CHECK (type IN ('OLYMPIAD', 'CONTEST', 'CHAMPIONSHIP', 'COMPETITION')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Таблица участий
CREATE TABLE participation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Уникальный идентификатор
    student_id UUID NOT NULL, -- Студент (ссылка на таблицу student)
    competition_id UUID NOT NULL, -- Конкурс (ссылка на таблицу competition)
    level_code VARCHAR(20) NOT NULL,
    result_code VARCHAR(20) NOT NULL, -- Результат (ссылка на справочник)
    year INTEGER NOT NULL -- Год участия
        CHECK(year >= 0),
    supervisor VARCHAR(100), -- Научный руководитель 
    points INTEGER -- Количество баллов (если применимо)
        CHECK (points IS NULL OR points >= 0),
    description TEXT -- Комментарий к участию (причина дисквалификации, особые заслуги и т.д.)
        CHECK (description IS NULL OR LENGTH(TRIM(description)) > 0),
    is_blocked BOOLEAN NOT NULL DEFAULT FALSE, -- Флаг блокировки редактирования по регламенту
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_participation_student FOREIGN KEY (student_id)
        REFERENCES student(id) ON DELETE RESTRICT,
    CONSTRAINT fk_participation_competition FOREIGN KEY (competition_id)
        REFERENCES competition(id) ON DELETE RESTRICT,
    CONSTRAINT fk_participation_level FOREIGN KEY (level_code)
        REFERENCES level(code) ON DELETE RESTRICT,
    CONSTRAINT fk_participation_result FOREIGN KEY (result_code)
        REFERENCES result(code) ON DELETE RESTRICT,

    -- Защита от дубликатов (ТЗ: студент+конкурс+год должны быть уникальны)
    CONSTRAINT uq_participation UNIQUE (student_id, competition_id, year)
);


-- ----------------------------------------------------------------------------
-- ТРИГГЕР ДЛЯ БЛОКИРОВКИ РЕДАКТИРОВАНИЯ (ФТ-4.4)
-- ----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION prevent_blocked_update()
RETURNS TRIGGER AS '
BEGIN
    IF OLD.is_blocked = TRUE THEN
        RAISE EXCEPTION ''Редактирование записи заблокировано по регламенту'';
    END IF;
    RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_blocked_update
BEFORE UPDATE ON participation
FOR EACH ROW
EXECUTE FUNCTION prevent_blocked_update();

-- ----------------------------------------------------------------------------
-- ТРИГГЕРЫ ДЛЯ ОБНОВЛЕНИЯ ВРЕМЕНИ РЕДАКТИРОВАНИЯ ТАБЛИЦ
-- ----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS '
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
' LANGUAGE plpgsql;


-- Студенты
CREATE TRIGGER trg_student_updated_at
BEFORE UPDATE ON student
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();


-- Конкурсы/олимпиады
CREATE TRIGGER trg_competition_updated_at
BEFORE UPDATE ON competition
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- Участия
CREATE TRIGGER trg_participation_updated_at
BEFORE UPDATE ON participation
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

-- ----------------------------------------------------------------------------
-- ТРИГГЕРЫ ДЛЯ БЛОКИРОВКИ РЕДАКТИРОВАНИЯ ВРЕМЕНИ СОЗДАНИЯ
-- ----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION check_created_at()
RETURNS TRIGGER AS '
BEGIN
    IF TG_OP = ''UPDATE'' THEN
        IF OLD.created_at IS DISTINCT FROM NEW.created_at THEN
            RAISE EXCEPTION ''Cannot modify created_at field in % table.'', TG_TABLE_NAME;
        END IF;
    END IF;

    RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER created_at_student_trigger
    BEFORE UPDATE ON student
    FOR EACH ROW
    EXECUTE FUNCTION check_created_at();

CREATE TRIGGER created_at_competition_trigger
    BEFORE UPDATE ON competition
    FOR EACH ROW
    EXECUTE FUNCTION check_created_at();

CREATE TRIGGER created_at_participation_trigger
    BEFORE UPDATE ON participation
    FOR EACH ROW
    EXECUTE FUNCTION check_created_at();
