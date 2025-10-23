-- ============================================================================
-- Схема БД для системы учёта участия студентов в олимпиадах и конкурсах
-- ============================================================================

-- ----------------------------------------------------------------------------
-- СПРАВОЧНЫЕ ТАБЛИЦЫ (кодификаторы по ТЗ)
-- ----------------------------------------------------------------------------

-- Справочник уровней участия
CREATE TABLE level (
    code VARCHAR(20) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL,
    sort_order INTEGER NOT NULL,
    CONSTRAINT uq_level_name UNIQUE (name)
);

COMMENT ON TABLE level IS 'Справочник уровней мероприятий';
COMMENT ON COLUMN level.code IS 'Код уровня (для использования в API)';
COMMENT ON COLUMN level.name IS 'Отображаемое название уровня';
COMMENT ON COLUMN level.sort_order IS 'Порядок сортировки (для UI)';

-- Справочник результатов участия
CREATE TABLE result (
    code VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    sort_order INTEGER NOT NULL,
    CONSTRAINT uq_result_name UNIQUE (name)
);

COMMENT ON TABLE result IS 'Справочник результатов участия';
COMMENT ON COLUMN result.code IS 'Код результата';
COMMENT ON COLUMN result.name IS 'Отображаемое название результата';
COMMENT ON COLUMN result.sort_order IS 'Порядок сортировки (для UI)';

-- Справочник типов мероприятий
CREATE TABLE competition_type (
    code VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT uq_competition_type_name UNIQUE (name)
);

COMMENT ON TABLE competition_type IS 'Справочник типов мероприятий';

-- ----------------------------------------------------------------------------
-- ОСНОВНЫЕ ТАБЛИЦЫ
-- ----------------------------------------------------------------------------

-- Таблица студентов
CREATE TABLE student (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    surname VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    card_number BIGINT UNIQUE NOT NULL,
    faculty VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    study_group VARCHAR(50),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE student IS 'Студенты образовательной организации';
COMMENT ON COLUMN student.card_number IS 'Номер студенческого билета (уникальный)';
COMMENT ON COLUMN student.faculty IS 'Факультет/институт студента';
COMMENT ON COLUMN student.department IS 'Кафедра (опционально)';
COMMENT ON COLUMN student.study_group IS 'Учебная группа (опционально)';

-- Таблица конкурсов/олимпиад
CREATE TABLE competition (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    organizer VARCHAR(255),
    type_code VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_competition_type FOREIGN KEY (type_code) 
        REFERENCES competition_type(code) ON DELETE RESTRICT
);

COMMENT ON TABLE competition IS 'Конкурсы и олимпиады';
COMMENT ON COLUMN competition.name IS 'Название мероприятия';
COMMENT ON COLUMN competition.organizer IS 'Организатор (опционально)';
COMMENT ON COLUMN competition.type_code IS 'Тип мероприятия (ссылка на справочник)';

-- Таблица участий
CREATE TABLE participation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL,
    competition_id UUID NOT NULL,
    level_code VARCHAR(20) NOT NULL,
    result_code VARCHAR(20) NOT NULL,
    year INTEGER NOT NULL,
    supervisor VARCHAR(255),
    description TEXT,
    is_blocked BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign keys
    CONSTRAINT fk_participation_student FOREIGN KEY (student_id) 
        REFERENCES student(id) ON DELETE CASCADE,
    CONSTRAINT fk_participation_competition FOREIGN KEY (competition_id) 
        REFERENCES competition(id) ON DELETE CASCADE,
    CONSTRAINT fk_participation_level FOREIGN KEY (level_code) 
        REFERENCES level(code) ON DELETE RESTRICT,
    CONSTRAINT fk_participation_result FOREIGN KEY (result_code) 
        REFERENCES result(code) ON DELETE RESTRICT,
    
    -- Проверка года (от 2000 до следующего года)
    CONSTRAINT chk_year CHECK (
        year >= 2000 AND year <= EXTRACT(YEAR FROM CURRENT_DATE) + 1
    ),
    
    -- Защита от дубликатов (ТЗ: студент+конкурс+год должны быть уникальны)
    -- level_code включён, т.к. студент может участвовать на разных уровнях
    CONSTRAINT uq_participation UNIQUE (student_id, competition_id, year, level_code)
);

COMMENT ON TABLE participation IS 'Записи об участии студентов в мероприятиях';
COMMENT ON COLUMN participation.supervisor IS 'ФИО научного руководителя/куратора (опционально)';
COMMENT ON COLUMN participation.description IS 'Комментарий к участию';
COMMENT ON COLUMN participation.is_blocked IS 'Флаг блокировки редактирования по регламенту (ФТ-4.4)';

-- ----------------------------------------------------------------------------
-- ИНДЕКСЫ для производительности
-- ----------------------------------------------------------------------------

-- Для поиска участий по студенту (ФТ-4.2)
CREATE INDEX idx_participation_student ON participation(student_id);

-- Для поиска участий по конкурсу (ФТ-4.2)
CREATE INDEX idx_participation_competition ON participation(competition_id);

-- Для фильтрации по году (ФТ-4.3)
CREATE INDEX idx_participation_year ON participation(year);

-- Для поиска студентов по фамилии (ФТ-4.3)
CREATE INDEX idx_student_surname ON student(surname);

-- Композитный индекс для фильтрации по году и уровню (ФТ-4.3)
CREATE INDEX idx_participation_year_level ON participation(year, level_code);

-- Для поиска конкурсов по названию (ФТ-4.3)
CREATE INDEX idx_competition_name ON competition(name);

-- ----------------------------------------------------------------------------
-- ТРИГГЕРЫ для автоматического обновления updated_at
-- ----------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_student_updated_at
    BEFORE UPDATE ON student
    FOR EACH ROW
    EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trg_competition_updated_at
    BEFORE UPDATE ON competition
    FOR EACH ROW
    EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trg_participation_updated_at
    BEFORE UPDATE ON participation
    FOR EACH ROW
    EXECUTE FUNCTION update_timestamp();

-- ----------------------------------------------------------------------------
-- НАПОЛНЕНИЕ СПРАВОЧНИКОВ (начальные данные)
-- ----------------------------------------------------------------------------

-- Уровни участия (по ТЗ)
INSERT INTO level (code, name, sort_order) VALUES
    ('university', 'Вузовский', 1),
    ('regional', 'Региональный', 2),
    ('national', 'Всероссийский', 3),
    ('international', 'Международный', 4);

-- Результаты участия (по ТЗ)
INSERT INTO result (code, name, sort_order) VALUES
    ('winner', 'Победитель', 1),
    ('prize', 'Призёр', 2),
    ('participant', 'Участник', 3),
    ('diploma', 'Дипломант', 4),
    ('disqualified', 'Дисквалифицирован', 5);

-- Типы мероприятий (по ТЗ)
INSERT INTO competition_type (code, name) VALUES
    ('olympiad', 'Олимпиада'),
    ('contest', 'Конкурс'),
    ('championship', 'Чемпионат'),
    ('competition', 'Соревнование');

-- ----------------------------------------------------------------------------
-- ПОЛЕЗНЫЕ ПРЕДСТАВЛЕНИЯ (Views)
-- ----------------------------------------------------------------------------

-- Представление для удобного просмотра участий с полными названиями
CREATE VIEW v_participation_full AS
SELECT 
    p.id,
    p.year,
    s.surname || ' ' || s.name || COALESCE(' ' || s.middle_name, '') AS student_fio,
    s.card_number,
    s.faculty,
    s.study_group,
    c.name AS competition_name,
    c.organizer,
    ct.name AS competition_type,
    l.name AS level_name,
    r.name AS result_name,
    p.supervisor,
    p.description,
    p.is_blocked,
    p.created_at,
    p.updated_at
FROM participation p
JOIN student s ON p.student_id = s.id
JOIN competition c ON p.competition_id = c.id
JOIN competition_type ct ON c.type_code = ct.code
JOIN level l ON p.level_code = l.code
JOIN result r ON p.result_code = r.code;

COMMENT ON VIEW v_participation_full IS 'Полное представление участий с расшифровкой всех справочников';

-- ----------------------------------------------------------------------------
-- ПРИМЕРЫ ЗАПРОСОВ для проверки
-- ----------------------------------------------------------------------------

-- Пример 1: Просмотр достижений по студенту (ФТ-4.2)
-- SELECT * FROM v_participation_full 
-- WHERE card_number = 123456789
-- ORDER BY year DESC, competition_name;

-- Пример 2: Просмотр участников конкурса с фильтрацией (ФТ-4.2)
-- SELECT * FROM v_participation_full 
-- WHERE competition_name ILIKE '%Программирование%'
--   AND year = 2025
--   AND level_name = 'Всероссийский'
-- ORDER BY result_name, student_fio;

-- Пример 3: Поиск и фильтрация (ФТ-4.3)
-- SELECT * FROM v_participation_full 
-- WHERE year BETWEEN 2023 AND 2025
--   AND level_name IN ('Региональный', 'Всероссийский')
--   AND faculty = 'Факультет информатики'
--   AND student_fio ILIKE '%Иванов%';

-- ----------------------------------------------------------------------------
-- КОНЕЦ СХЕМЫ
-- ----------------------------------------------------------------------------
