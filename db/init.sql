
-- ============================================================================
-- Схема БД для системы учёта участия студентов в олимпиадах и конкурсах
-- Версия 3.0 - Упрощеная c триггерами
-- ============================================================================

-- ----------------------------------------------------------------------------
-- СПРАВОЧНЫЕ ТАБЛИЦЫ
-- ----------------------------------------------------------------------------

-- Справочник уровней участия
CREATE TABLE level (
    code VARCHAR(20) PRIMARY KEY, -- Код уровня (UNI, REG, RUS, INT)
    name VARCHAR(50) NOT NULL, -- Отображаемое название
    sort_order INTEGER NOT NULL, -- Порядок сортировки для UI
    CONSTRAINT uq_level_name UNIQUE (name)
);

-- Справочник результатов участия
CREATE TABLE result (
    code VARCHAR(20) PRIMARY KEY, -- Код результата (WIN, PRIZE, PART, DQ, DIP)
    name VARCHAR(50) NOT NULL, -- Отображаемое название
    sort_order INTEGER NOT NULL, -- Порядок сортировки для UI
    CONSTRAINT uq_result_name UNIQUE (name)
);


-- ----------------------------------------------------------------------------
-- ОСНОВНЫЕ ТАБЛИЦЫ
-- ----------------------------------------------------------------------------

-- Таблица студентов
CREATE TABLE student (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Уникальный идентификатор
    surname VARCHAR(50) NOT NULL, -- Фамилия
    name VARCHAR(50) NOT NULL, -- Имя
    middle_name VARCHAR(50), -- Отчество (опционально)
    card_number BIGINT UNIQUE NOT NULL, -- Номер студенческого билета (уникальный)
    faculty VARCHAR(50) NOT NULL CHECK (faculty IN (
	'Факультет биологии и экологии', 'Факультет Информатики и вычислительной техники',
	'Исторический факультет', 'Математический Факультет', 'Факультет психологии', 'Факультет социально-политических наук',
	'Факультет иностранных языков', 'Физико-технический факультет', 'Факультет филологии и коммуникации', 'Экономический факультет', 
	'Юридический факультет')), -- Факультет 
    department VARCHAR(20), -- Кафедра
    study_group VARCHAR(50), -- Учебная группа (опционально)
    email VARCHAR(100), -- Email студента (опционально)
    phone VARCHAR(20), -- Телефон студента (опционально)
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата создания
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP -- Дата обновления
    
);


-- Таблица конкурсов/олимпиад
CREATE TABLE competition (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Уникальный идентификатор
    name VARCHAR(255) NOT NULL, -- Название мероприятия
    organizer VARCHAR(255), -- Организатор (опционально)
	type VARCHAR(50) NOT NULL CHECK (type IN ('OLYMPIAD', 'CONTEST', 'CHAMPIONSHIP', 'COMPETITION')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата создания
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP -- Дата обновления
    -- CONSTRAINT fk_competition_type FOREIGN KEY (type_code) 
    --     REFERENCES competition_type(code) ON DELETE RESTRICT
);


-- Таблица участий
CREATE TABLE participation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Уникальный идентификатор
    student_id UUID NOT NULL, -- Студент (ссылка на таблицу student)
    competition_id UUID NOT NULL, -- Конкурс (ссылка на таблицу competition)
    level_code VARCHAR(20) NOT NULL,
    result_code VARCHAR(20) NOT NULL, -- Результат (ссылка на справочник)
    year INTEGER NOT NULL, -- Год участия
    supervisor VARCHAR(100), -- Научный руководитель 
    points INTEGER, -- Количество баллов (если применимо)
    description TEXT, -- Комментарий к участию (причина дисквалификации, особые заслуги и т.д.)
    is_blocked BOOLEAN NOT NULL DEFAULT FALSE, -- Флаг блокировки редактирования по регламенту
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата создания
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата обновления
    
    -- Foreign keys
    CONSTRAINT fk_participation_student FOREIGN KEY (student_id) 
        REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_participation_competition FOREIGN KEY (competition_id) 
        REFERENCES competition(id) ON DELETE CASCADE,
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
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.is_blocked = TRUE THEN
        RAISE EXCEPTION 'Редактирование записи заблокировано по регламенту';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_blocked_update
BEFORE UPDATE ON participation
FOR EACH ROW
EXECUTE FUNCTION prevent_blocked_update();

-- ----------------------------------------------------------------------------
-- ТРИГГЕРЫ ДЛЯ ОБНОВЛЕНИЯ ВРЕМЕНИ РЕДАКТИРОВАНИЯ ТАБЛИЦ
-- ----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--Уровни
CREATE TRIGGER trg_level_updated_at
BEFORE UPDATE ON level
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();


-- Результаты
CREATE TRIGGER trg_result_updated_at
BEFORE UPDATE ON result
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();


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
