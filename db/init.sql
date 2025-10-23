-- Создание таблицы для студентов

CREATE TABLE student (
    id UUID PRIMARY KEY, -- Уникальный идентификатор студента
    name VARCHAR(50) NOT NULL, -- Имя студента
    surname VARCHAR(50) NOT NULL, -- Фамилия студента
    middle_name VARCHAR(50), -- Отчество студента
    card_number BIGINT UNIQUE NOT NULL, -- Номер студенческого билета
    faculty VARCHAR(50) NOT NULL, -- Факультет/институт студента
    university VARCHAR(100) NOT NULL, -- Университет студента
    department VARCHAR(100), -- Кафедра студента
    study_group VARCHAR(50), -- Учебная группа студента
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время создания записи
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время последнего обновления записи
);

-- Создание таблицы для конкурсов

CREATE TABLE competition (
    id UUID PRIMARY KEY, -- Уникальный идентификатор конкурса
    name VARCHAR(100) NOT NULL, -- Название конкурса/олимпиады
    organizer VARCHAR(256), -- Организатор конкурса
    type VARCHAR(50) NOT NULL CHECK (type IN ('OLYMPIAD', 'CONTEST', 'CHAMPIONSHIP', 'COMPETITION')), -- Тип мероприятия 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время создания записи
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время последнего обновления записи
    
);

-- Создание таблицы для участия

CREATE TABLE participation (
    id UUID PRIMARY KEY, -- Уникальный идентификатор участия
    student_id UUID NOT NULL REFERENCES student(id), -- Ссылка на студента 
    competition_id UUID NOT NULL REFERENCES competition(id), -- - Ссылка на конкурс
	points NUMERIC(6, 2) NOT NULL, -- Количество баллов
    level VARCHAR(20) NOT NULL CHECK (level IN  ('Вузовский', 'Региональный', 'Всероссийский', 'Международный')), -- Уровень участия
    result VARCHAR(20) NOT NULL CHECK( result IN ('Победитель', 'Призер', 'Участник', 'Дисквалифицирован', 'Дипломант')), -- Результат участия
    year INTEGER NOT NULL CHECK (year >= 2000 AND year <= EXTRACT(YEAR FROM CURRENT_DATE) + 1), -- Год участия
    supervisor VARCHAR(256), -- ФИО научного руководителя/куратора 
    is_blocked BOOLEAN NOT NULL, -- Флаг блокировки редактирования записи 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время создания записи (автоматически)
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время последнего обновления записи (автоматически)
    description TEXT, -- Комментарий к участию

    -- Уникальное ограничение для предотвращения дубликатов
    UNIQUE(student_id, competition_id, year)
);

-- Создание таблицы для пользователей

CREATE TABLE users (
	login VARCHAR(20) PRIMARY KEY, -- Логин
	password VARCHAR(20), -- Пароль
	name VARCHAR(20) NOT NULL, -- Имя
	surname VARCHAR(30) NOT NULL, -- Фамилия
	middle_name VARCHAR(20), -- Отчетво
	organization VARCHAR(100), -- Организатор
	level VARCHAR(20) CHECK(level IN ('Вузовский', 'Региональный', 'Всероссийский', 'Международный')), -- Уровень
	role VARCHAR(20) NOT NULL CHECK(role IN ('organizer', 'admin', 'su')), -- Роль
	CONSTRAINT chk_level_for_organizer CHECK (
		(role != 'organizer') OR (level IS NOT NULL)
	)
);
