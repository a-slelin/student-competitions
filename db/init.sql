
-- ============================================================================
-- Схема БД для системы учёта участия студентов в олимпиадах и конкурсах
-- Версия 2.0 - Строгая 3НФ
-- ============================================================================

-- ----------------------------------------------------------------------------
-- СПРАВОЧНЫЕ ТАБЛИЦЫ (кодификаторы по ТЗ)
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

-- Справочник типов мероприятий
CREATE TABLE competition_type (
    code VARCHAR(20) PRIMARY KEY, -- Код типа (OLYMPIAD, CONTEST, CHAMPIONSHIP, COMPETITION)
    name VARCHAR(50) NOT NULL, -- Отображаемое название
    CONSTRAINT uq_competition_type_name UNIQUE (name)
);

-- Справочник факультетов/институтов (для достижения 3НФ)
CREATE TABLE faculty (
    code VARCHAR(20) PRIMARY KEY, -- Код факультета (ФИТ, ФЕН, ФГН)
    name VARCHAR(150) NOT NULL, -- Полное название факультета
    CONSTRAINT uq_faculty_name UNIQUE (name)
);

-- Справочник кафедр (для достижения 3НФ)
CREATE TABLE department (
    code VARCHAR(20) PRIMARY KEY, -- Код кафедры
    name VARCHAR(150) NOT NULL, -- Название кафедры
    faculty_code VARCHAR(20) NOT NULL, -- Факультет, к которому относится
    CONSTRAINT fk_department_faculty FOREIGN KEY (faculty_code) 
        REFERENCES faculty(code) ON DELETE RESTRICT,
    CONSTRAINT uq_department_name UNIQUE (name)
);

-- Справочник научных руководителей (для достижения 3НФ)
CREATE TABLE supervisor (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Уникальный идентификатор
    surname VARCHAR(50) NOT NULL, -- Фамилия
    name VARCHAR(50) NOT NULL, -- Имя
    middle_name VARCHAR(50), -- Отчество
    position VARCHAR(100), -- Должность (проф., доц., ст. преп.)
    department_code VARCHAR(20), -- Кафедра (опционально)
    email VARCHAR(100), -- Email (опционально)
    phone VARCHAR(20), -- Телефон (опционально)
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата создания
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата обновления
    CONSTRAINT fk_supervisor_department FOREIGN KEY (department_code) 
        REFERENCES department(code) ON DELETE SET NULL
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
    faculty_code VARCHAR(20) NOT NULL, -- Факультет (ссылка на справочник)
    department_code VARCHAR(20), -- Кафедра (опционально, ссылка на справочник)
    study_group VARCHAR(50), -- Учебная группа (опционально)
    email VARCHAR(100), -- Email студента (опционально)
    phone VARCHAR(20), -- Телефон студента (опционально)
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата создания
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата обновления
    CONSTRAINT fk_student_faculty FOREIGN KEY (faculty_code) 
        REFERENCES faculty(code) ON DELETE RESTRICT,
    CONSTRAINT fk_student_department FOREIGN KEY (department_code) 
        REFERENCES department(code) ON DELETE SET NULL
);

-- Таблица конкурсов/олимпиад
CREATE TABLE competition (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Уникальный идентификатор
    name VARCHAR(255) NOT NULL, -- Название мероприятия
    organizer VARCHAR(255), -- Организатор (опционально)
    type_code VARCHAR(20) NOT NULL, -- Тип мероприятия (ссылка на справочник)
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата создания
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Дата обновления
    CONSTRAINT fk_competition_type FOREIGN KEY (type_code) 
        REFERENCES competition_type(code) ON DELETE RESTRICT
);

-- Таблица участий
CREATE TABLE participation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Уникальный идентификатор
    student_id UUID NOT NULL, -- Студент (ссылка на таблицу student)
    competition_id UUID NOT NULL, -- Конкурс (ссылка на таблицу competition)
    level_code VARCHAR(20) NOT NULL, -- Уровень (ссылка на справочник)
    result_code VARCHAR(20) NOT NULL, -- Результат (ссылка на справочник)
    year INTEGER NOT NULL, -- Год участия
    supervisor_id UUID, -- Научный руководитель (опционально, ссылка на supervisor)
    participation_date DATE, -- Конкретная дата участия (опционально)
    certificate_number VARCHAR(100), -- Номер диплома/сертификата (опционально)
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
    CONSTRAINT fk_participation_supervisor FOREIGN KEY (supervisor_id) 
        REFERENCES supervisor(id) ON DELETE SET NULL,
    
    -- Проверка года (от 2000 до следующего года)
    CONSTRAINT chk_year CHECK (
        year >= 2000 AND year <= EXTRACT(YEAR FROM CURRENT_DATE) + 1
    ),
    
    -- Защита от дубликатов (ТЗ: студент+конкурс+год должны быть уникальны)
    CONSTRAINT uq_participation UNIQUE (student_id, competition_id, year)
);
