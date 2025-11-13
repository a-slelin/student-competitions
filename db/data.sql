-- ============================================
-- Тестовые данные для системы учета участий в олимпиадах
-- ============================================

-- ============================================
-- СТУДЕНТЫ
-- ============================================

INSERT INTO student (id, name, surname, middle_name, card_number, faculty, department, study_group) VALUES

(gen_random_uuid(), 'Иван', 'Петров', 'Сергеевич', 2101001, 'Факультет информатики и вычислительной техники', 'П И', 'ПИ-21-1'),
(gen_random_uuid(), 'Мария', 'Сидорова', 'Александровна', 2101002, 'Факультет информатики и вычислительной техники', 'И Б', 'ИБ-21-2'),
(gen_random_uuid(), 'Алексей', 'Козлов', 'Дмитриевич', 2101003, 'Факультет информатики и вычислительной техники', 'И И', 'ИА-21-1'),

(gen_random_uuid(), 'Екатерина', 'Николаева', 'Владимировна', 2102001, 'Факультет биологии и экологии', 'Биотехнологии', 'БТ-21-3'),
(gen_random_uuid(), 'Дмитрий', 'Иванов', 'Олегович', 2102002, 'Факультет биологии и экологии', 'Химия', 'ХМ-21-2'),

(gen_random_uuid(), 'Анна', 'Смирнова', 'Павловна', 2103001, 'Факультет филологии и коммуникации', 'Лингвистика', 'ЛГ-21-1'),
(gen_random_uuid(), 'Сергей', 'Васильев', 'Игоревич', 2103002, 'Юридический факультет', 'М О', 'МО-21-2'),

(gen_random_uuid(), 'Ольга', 'Михайлова', 'Сергеевна', 2104001, 'Экономический факультет', 'Ф К', 'ФК-21-1'),
(gen_random_uuid(), 'Артем', 'Федоров', 'Андреевич', 2104002, 'Экономический факультет', 'Менеджмент', 'МН-21-3'),

(gen_random_uuid(), 'Наталья', 'Попова', 'Викторовна', 2201001, 'Математический факультет', 'П М', 'ПМ-21-1'),
(gen_random_uuid(), 'Павел', 'Семенов', 'Романович', 2201002, 'Физико-технический факультет', 'Ядерная физика', 'ЯФ-21-2'),

(gen_random_uuid(), 'Виктория', 'Лебедева', 'Максимовна', 2101004, 'Факультет информатики и вычислительной техники', 'П И', 'ПИ-21-2'),
(gen_random_uuid(), 'Максим', 'Орлов', 'Петрович', 2102003, 'Физико-технический факультет', 'Физика', 'ФЗ-21-1'),
(gen_random_uuid(), 'Елена', 'Кузнецова', 'Дмитриевна', 2103003, 'Исторический факультет', 'История', 'ИС-21-1'),
(gen_random_uuid(), 'Андрей', 'Морозов', 'Владимирович', 2104003, 'Экономический факультет', 'Экономика', 'ЭК-21-2'),
(gen_random_uuid(), 'Кирилл', 'Соколов', 'Алексеевич', 2101005, 'Факультет информатики и вычислительной техники', 'И С', 'ИС-21-3'),
(gen_random_uuid(), 'Татьяна', 'Волкова', 'Игоревна', 2102004, 'Факультет биологии и экологии', 'Биология', 'БЛ-21-1'),
(gen_random_uuid(), 'Игорь', 'Новиков', 'Сергеевич', 2201003, 'Факультет информатики и вычислительной техники', 'К Б', 'КБ-21-1');

-- ============================================
-- УРОВНИ СОРЕВНОВАНИЙ
-- ============================================

INSERT INTO level (code, name, sort_order) VALUES
('UNI', 'Внутривузовский уровень', 1),
('REG', 'Региональный уровень', 2),
('RUS', 'Всероссийский уровень', 3),
('INT', 'Международный уровень', 4);

-- ============================================
-- РЕЗУЛЬТАТЫ
-- ============================================

INSERT INTO result (code, name, sort_order) VALUES
('WIN', 'Победитель', 1),
('PRIZE', 'Призер', 2),
('PART', 'Участник', 3),
('DIQ', 'Дисквалифицирован', 4),
('DIP', 'Дипломант', 5);

-- ============================================
-- КОНКУРСЫ И ОЛИМПИАДЫ
-- ============================================

INSERT INTO competition (id, name, organizer, type) VALUES
(gen_random_uuid(), 'Всероссийская олимпиада по программированию', 'Минобрнауки РФ', 'OLYMPIAD'),
(gen_random_uuid(), 'Хакатон "Цифровой прорыв"', 'АНО "Цифровая экономика"', 'CONTEST'),
(gen_random_uuid(), 'Чемпионат по кибербезопасности', 'ВУЗ-CERT', 'CHAMPIONSHIP'),
(gen_random_uuid(), 'Олимпиада по математике им. Колмогорова', 'МГУ', 'OLYMPIAD'),
(gen_random_uuid(), 'Конкурс научных работ молодых ученых', 'РАН', 'COMPETITION'),
(gen_random_uuid(), 'Кейс-чемпионат по финансам', 'Сбер', 'CHAMPIONSHIP'),
(gen_random_uuid(), 'Олимпиада по химии "Ломоносов"', 'МГУ', 'OLYMPIAD'),
(gen_random_uuid(), 'Международный конкурс по искусственному интеллекту', 'IEEE', 'COMPETITION'),
(gen_random_uuid(), 'Дебаты "Молодежь и мир"', 'МИД России', 'CONTEST'),
(gen_random_uuid(), 'Олимпиада по физике "Росатом"', 'Росатом', 'OLYMPIAD'),
(gen_random_uuid(), 'Чемпионат "Программирование на скорость"', 'Яндекс', 'CHAMPIONSHIP'),
(gen_random_uuid(), 'Конкурс стартапов "Технопрорыв"', 'Фонд Сколково', 'COMPETITION');

-- ============================================
-- УЧАСТИЯ СТУДЕНТОВ
-- ============================================

INSERT INTO participation (id, student_id, competition_id, level_code, result_code, year, supervisor, is_blocked, description) VALUES

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Петров' AND name = 'Иван' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по программированию' LIMIT 1),
 'RUS', 'PRIZE', 2024, 'Проф. Смирнов А.А.', FALSE, 'Призер отборочного этапа, решил 6 из 8 задач'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Петров' AND name = 'Иван' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 'RUS', 'PART', 2024, 'Проф. Смирнов А.А.', FALSE, 'Участник трека Backend-разработка'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Петров' AND name = 'Иван' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по программированию' LIMIT 1),
 'REG', 'WIN', 2023, 'Проф. Смирнов А.А.', TRUE, 'Победитель регионального этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Сидорова' AND name = 'Мария' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 'RUS', 'WIN', 2024, 'Доц. Петрова Е.В.', FALSE, 'Победитель в категории Web Security'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Сидорова' AND name = 'Мария' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 'RUS', 'WIN', 2023, 'Доц. Петрова Е.В.', TRUE, 'Победа в треке Кибербезопасность'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Сидорова' AND name = 'Мария' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 'REG', 'PRIZE', 2022, 'Доц. Петрова Е.В.', TRUE, 'Призер регионального CTF'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Козлов' AND name = 'Алексей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Международный конкурс по искусственному интеллекту' LIMIT 1),
 'INT', 'PRIZE', 2024, NULL, FALSE, 'Призер в номинации Computer Vision'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Козлов' AND name = 'Алексей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 'RUS', 'PART', 2024, NULL, FALSE, 'Участник трека AI/ML'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Николаева' AND name = 'Екатерина' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
'RUS', 'DIP', 2024, 'Проф. Иванова М.П.', FALSE, 'Диплом за оригинальный подход в НИР по генной инженерии'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Николаева' AND name = 'Екатерина' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 'REG', 'WIN', 2023, 'Проф. Иванова М.П.', TRUE, 'Победитель регионального этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Николаева' AND name = 'Екатерина' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 'UNI', 'DIP', 2022, 'Проф. Иванова М.П.', TRUE, 'Диплом за перспективное исследование'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Иванов' AND name = 'Дмитрий' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по химии "Ломоносов"' LIMIT 1),
 'RUS', 'WIN', 2024, 'Доц. Петров К.К.', FALSE, 'Победитель заключительного этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Иванов' AND name = 'Дмитрий' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по химии "Ломоносов"' LIMIT 1),
 'REG', 'PRIZE', 2022, 'Доц. Петров К.К.', TRUE, 'Призер регионального этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Иванов' AND name = 'Дмитрий' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 'UNI', 'WIN', 2024, 'Доц. Петров К.К.', FALSE, 'Победитель внутривузовского этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Смирнова' AND name = 'Анна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 'REG', 'PRIZE', 2024, NULL, FALSE, 'Призер регионального этапа дебатов'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Смирнова' AND name = 'Анна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 'UNI', 'WIN', 2023, NULL, TRUE, 'Победитель внутривузовского отбора'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Васильев' AND name = 'Сергей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 'RUS', 'WIN', 2024, 'Проф. Соколов В.В.', FALSE, 'Победитель всероссийского этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Васильев' AND name = 'Сергей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 'UNI', 'WIN', 2023, 'Проф. Соколов В.В.', TRUE, 'Победитель внутривузовского этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Михайлова' AND name = 'Ольга' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 'RUS', 'PRIZE', 2024, 'Доц. Новикова Т.Т.', FALSE, 'Призер в треке инвестиционного анализа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Михайлова' AND name = 'Ольга' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 'REG', 'WIN', 2023, 'Доц. Новикова Т.Т.', TRUE, 'Победитель регионального этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Михайлова' AND name = 'Ольга' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс стартапов "Технопрорыв"' LIMIT 1),
 'REG', 'PRIZE', 2024, 'Доц. Новикова Т.Т.', FALSE, 'Призер с проектом в сфере финтех'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Федоров' AND name = 'Артем' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 'UNI', 'PART', 2024, NULL, FALSE, 'Участник внутривузовского этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Федоров' AND name = 'Артем' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс стартапов "Технопрорыв"' LIMIT 1),
 'UNI', 'PRIZE', 2024, NULL, FALSE, 'Призер с проектом системы управления бизнес-процессами'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Федоров' AND name = 'Артем' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 'REG', 'DIQ', 2022, NULL, TRUE, 'Дисквалификация за использование готового кода из интернета'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Попова' AND name = 'Наталья' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по математике им. Колмогорова' LIMIT 1),
 'REG', 'WIN', 2024, 'Проф. Лебедев Н.Н.', FALSE, 'Победитель международного этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Попова' AND name = 'Наталья' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по математике им. Колмогорова' LIMIT 1),
 'RUS', 'WIN', 2023, 'Проф. Лебедев Н.Н.', TRUE, 'Победитель всероссийского этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Попова' AND name = 'Наталья' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по математике им. Колмогорова' LIMIT 1),
 'REG', 'WIN', 2022, 'Проф. Лебедев Н.Н.', TRUE, 'Победитель регионального этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Семенов' AND name = 'Павел' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 'RUS', 'PRIZE', 2024, 'Проф. Волков Д.Д.', FALSE, 'Призер за работу по квантовой физике'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Семенов' AND name = 'Павел' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по физике "Росатом"' LIMIT 1),
 'RUS', 'WIN', 2024, 'Проф. Волков Д.Д.', FALSE, 'Победитель в секции ядерной физики'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Лебедева' AND name = 'Виктория' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 'INT', 'PRIZE', 2024, 'Проф. Смирнов А.А.', FALSE, 'Призер международного трека'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Лебедева' AND name = 'Виктория' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат "Программирование на скорость"' LIMIT 1),
 'RUS', 'PART', 2024, NULL, FALSE, 'Участник всероссийского финала'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Лебедева' AND name = 'Виктория' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по программированию' LIMIT 1),
 'RUS', 'DIQ', 2023, 'Проф. Смирнов А.А.', TRUE, 'Дисквалификация за нарушение временного регламента'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Орлов' AND name = 'Максим' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по физике "Росатом"' LIMIT 1),
 'REG', 'PRIZE', 2024, 'Доц. Кузнецов П.П.', FALSE, 'Призер регионального этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Орлов' AND name = 'Максим' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 'REG', 'DIP', 2023, 'Доц. Кузнецов П.П.', TRUE, 'Диплом за инновационный подход в работе по оптике'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Орлов' AND name = 'Максим' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по физике "Росатом"' LIMIT 1),
 'UNI', 'DIP', 2023, 'Доц. Кузнецов П.П.', TRUE, 'Диплом за лучшее решение экспериментальной задачи'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Кузнецова' AND name = 'Елена' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 'UNI', 'PART', 2024, NULL, FALSE, 'Участник с работой по истории России XX века'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Кузнецова' AND name = 'Елена' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 'REG', 'DIQ', 2023, NULL, TRUE, 'Дисквалификация за плагиат в выступлении'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Морозов' AND name = 'Андрей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 'REG', 'WIN', 2024, 'Проф. Соколова Л.Л.', FALSE, 'Победитель регионального этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Морозов' AND name = 'Андрей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс стартапов "Технопрорыв"' LIMIT 1),
 'RUS', 'PRIZE', 2024, 'Проф. Соколова Л.Л.', FALSE, 'Призер с проектом маркетплейса'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Морозов' AND name = 'Андрей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 'RUS', 'DIP', 2023, 'Проф. Соколова Л.Л.', TRUE, 'Диплом за креативность решения'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Соколов' AND name = 'Кирилл' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 'REG', 'PART', 2024, NULL, FALSE, 'Участник регионального этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Соколов' AND name = 'Кирилл' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат "Программирование на скорость"' LIMIT 1),
 'RUS', 'DIQ', 2023, NULL, TRUE, 'Дисквалификация за попытку использования запрещенных библиотек'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Соколов' AND name = 'Кирилл' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по программированию' LIMIT 1),
 'UNI', 'PRIZE', 2024, NULL, FALSE, 'Призер внутривузовского этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Волкова' AND name = 'Татьяна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 'REG', 'PRIZE', 2024, 'Проф. Иванова М.П.', FALSE, 'Призер с работой по экологии'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Волкова' AND name = 'Татьяна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 'UNI', 'WIN', 2023, 'Проф. Иванова М.П.', TRUE, 'Победитель внутривузовского этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Волкова' AND name = 'Татьяна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 'RUS', 'DIQ', 2022, 'Проф. Иванова М.П.', TRUE, 'Дисквалификация за обнаружение фальсификации экспериментальных данных'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Новиков' AND name = 'Игорь' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 'INT', 'WIN', 2024, 'Доц. Петрова Е.В.', FALSE, 'Победитель международного этапа CTF'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Новиков' AND name = 'Игорь' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 'RUS', 'WIN', 2023, 'Доц. Петрова Е.В.', TRUE, 'Победитель всероссийского этапа'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Новиков' AND name = 'Игорь' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 'RUS', 'PRIZE', 2024, NULL, FALSE, 'Призер в треке кибербезопасности'),

(gen_random_uuid(),
 (SELECT id FROM student WHERE surname = 'Новиков' AND name = 'Игорь' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 'REG', 'DIQ', 2022, 'Доц. Петрова Е.В.', TRUE, 'Дисквалификация за выход за границы тестовой среды');

-- ============================================
-- ПРОВЕРОЧНЫЕ ЗАПРОСЫ
-- Раскомментируйте для проверки данных
-- ============================================

-- Количество записей
-- SELECT 'Студентов' as entity, COUNT(*) as count FROM student
-- UNION ALL
-- SELECT 'Конкурсов', COUNT(*) FROM competition
-- UNION ALL
-- SELECT 'Участий', COUNT(*) FROM participation;

-- Детальный просмотр участий
-- SELECT 
--     s.surname || ' ' || s.name as student,
--     c.name as competition,
--     l.name as level,
--     r.name as result,
--     p.year,
--     p.is_blocked,
--     p.supervisor
-- FROM participation p
-- JOIN student s ON p.student_id = s.id
-- JOIN competition c ON p.competition_id = c.id
-- JOIN level l ON p.level_id = l.id
-- JOIN result r ON p.result_id = r.id
-- ORDER BY p.year DESC, s.surname;

-- Статистика по годам
-- SELECT 
--     year,
--     COUNT(*) as total,
--     SUM(CASE WHEN is_blocked THEN 1 ELSE 0 END) as blocked
-- FROM participation
-- GROUP BY year
-- ORDER BY year DESC;

-- SELECT 'Студентов' as "Таблица", COUNT(*) as "Записей" FROM student
-- UNION ALL
-- SELECT 'Уровней', COUNT(*) FROM level
-- UNION ALL
-- SELECT 'Результатов', COUNT(*) FROM result
-- UNION ALL
-- SELECT 'Конкурсов', COUNT(*) FROM competition
-- UNION ALL
-- SELECT 'Участий', COUNT(*) FROM participation;
-- Select * from particioation 
-- where  
