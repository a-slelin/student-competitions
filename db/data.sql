-- ============================================
-- Тестовые данные для системы учета участий в олимпиадах
-- ============================================

-- ============================================
-- СТУДЕНТЫ
-- ============================================

INSERT INTO student (id, name, surname, middle_name, card_number, faculty, university, department, study_group, created_at, updated_at, description) VALUES

-- Технические специальности
(gen_random_uuid(), 'Иван', 'Петров', 'Сергеевич', 2101001, 'ФИТ', 'Московский технический университет', 'Программная инженерия', 'ПИ-21-1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Активный участник олимпиад по программированию'),
(gen_random_uuid(), 'Мария', 'Сидорова', 'Александровна', 2101002, 'ФИТ', 'Московский технический университет', 'Информационная безопасность', 'ИБ-21-2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер хакатонов по кибербезопасности'),
(gen_random_uuid(), 'Алексей', 'Козлов', 'Дмитриевич', 2101003, 'ФИТ', 'Московский технический университет', 'Искусственный интеллект', 'ИА-21-1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Увлекается машинным обучением'),

-- Естественно-научные специальности
(gen_random_uuid(), 'Екатерина', 'Николаева', 'Владимировна', 2102001, 'ФЕН', 'Московский технический университет', 'Биотехнологии', 'БТ-21-3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник олимпиад по биохимии'),
(gen_random_uuid(), 'Дмитрий', 'Иванов', 'Олегович', 2102002, 'ФЕН', 'Московский технический университет', 'Химия', 'ХМ-21-2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель региональной олимпиады по химии'),

-- Гуманитарные специальности
(gen_random_uuid(), 'Анна', 'Смирнова', 'Павловна', 2103001, 'ФГН', 'Московский технический университет', 'Лингвистика', 'ЛГ-21-1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участвует в конкурсах перевода'),
(gen_random_uuid(), 'Сергей', 'Васильев', 'Игоревич', 2103002, 'ФГН', 'Московский технический университет', 'Международные отношения', 'МО-21-2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Активный участник дебатов'),

-- Экономические специальности
(gen_random_uuid(), 'Ольга', 'Михайлова', 'Сергеевна', 2104001, 'ФЭ', 'Московский технический университет', 'Финансы и кредит', 'ФК-21-1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер кейс-чемпионатов'),
(gen_random_uuid(), 'Артем', 'Федоров', 'Андреевич', 2104002, 'ФЭ', 'Московский технический университет', 'Менеджмент', 'МН-21-3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник бизнес-олимпиад'),

-- Разные университеты для разнообразия
(gen_random_uuid(), 'Наталья', 'Попова', 'Викторовна', 2201001, 'Мехмат', 'Санкт-Петербургский государственный университет', 'Прикладная математика', 'ПМ-21-1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель олимпиад по математике'),
(gen_random_uuid(), 'Павел', 'Семенов', 'Романович', 2201002, 'Физфак', 'Санкт-Петербургский государственный университет', 'Ядерная физика', 'ЯФ-21-2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник научных конференций'),

-- Дополнительные студенты для более полного тестирования
(gen_random_uuid(), 'Виктория', 'Лебедева', 'Максимовна', 2101004, 'ФИТ', 'Московский технический университет', 'Программная инженерия', 'ПИ-21-2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник международных хакатонов'),
(gen_random_uuid(), 'Максим', 'Орлов', 'Петрович', 2102003, 'ФЕН', 'Московский технический университет', 'Физика', 'ФЗ-21-1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер олимпиад по физике'),
(gen_random_uuid(), 'Елена', 'Кузнецова', 'Дмитриевна', 2103003, 'ФГН', 'Московский технический университет', 'История', 'ИС-21-1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник исторических конференций'),
(gen_random_uuid(), 'Андрей', 'Морозов', 'Владимирович', 2104003, 'ФЭ', 'Московский технический университет', 'Экономика', 'ЭК-21-2', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель экономических олимпиад'),
(gen_random_uuid(), 'Кирилл', 'Соколов', 'Алексеевич', 2101005, 'ФИТ', 'Московский технический университет', 'Информационные системы', 'ИС-21-3', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник соревнований по базам данных'),
(gen_random_uuid(), 'Татьяна', 'Волкова', 'Игоревна', 2102004, 'ФЕН', 'Московский технический университет', 'Биология', 'БЛ-21-1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер олимпиад по биологии'),
(gen_random_uuid(), 'Игорь', 'Новиков', 'Сергеевич', 2201003, 'Факультет информатики', 'Санкт-Петербургский государственный университет', 'Компьютерная безопасность', 'КБ-21-1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Специалист по этичному хакингу');

-- ============================================
-- УРОВНИ СОРЕВНОВАНИЙ
-- ============================================

INSERT INTO level (id, code, name, created_at, updated_at, description) VALUES
(1, 'UNI', 'Вузовский', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Внутривузовский уровень'),
(2, 'REG', 'Региональный', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Региональный уровень'),
(3, 'RUS', 'Всероссийский', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Всероссийский уровень'),
(4, 'INT', 'Международный', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Международный уровень');

-- ============================================
-- РЕЗУЛЬТАТЫ
-- ============================================

INSERT INTO result (id, code, name, created_at, updated_at, description) VALUES
(1, 'WIN', 'Победитель', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'I место'),
(2, 'PRIZE', 'Призер', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'II-III место'),
(3, 'PART', 'Участник', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участие без призового места'),
(4, 'DQ', 'Дисквалифицирован', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Дисквалификация за нарушение регламента'),
(5, 'DIP', 'Дипломант', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Специальный диплом или поощрительная награда');

-- ============================================
-- КОНКУРСЫ И ОЛИМПИАДЫ
-- ============================================

INSERT INTO competition (id, name, organizer, type, created_at, updated_at, description) VALUES
(gen_random_uuid(), 'Всероссийская олимпиада по программированию', 'Минобрнауки РФ', 'OLYMPIAD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Ежегодная олимпиада по алгоритмам и структурам данных'),
(gen_random_uuid(), 'Хакатон "Цифровой прорыв"', 'АНО "Цифровая экономика"', 'CONTEST', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, '48-часовой хакатон по разработке цифровых решений'),
(gen_random_uuid(), 'Чемпионат по кибербезопасности', 'ВУЗ-CERT', 'CHAMPIONSHIP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'CTF соревнования по информационной безопасности'),
(gen_random_uuid(), 'Олимпиада по математике им. Колмогорова', 'МГУ', 'OLYMPIAD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Традиционная математическая олимпиада для студентов'),
(gen_random_uuid(), 'Конкурс научных работ молодых ученых', 'РАН', 'COMPETITION', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Ежегодный конкурс научно-исследовательских работ'),
(gen_random_uuid(), 'Кейс-чемпионат по финансам', 'Сбер', 'CHAMPIONSHIP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Решение бизнес-кейсов по финансовым продуктам и услугам'),
(gen_random_uuid(), 'Олимпиада по химии "Ломоносов"', 'МГУ', 'OLYMPIAD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Многопрофильная олимпиада школьников по химии'),
(gen_random_uuid(), 'Международный конкурс по искусственному интеллекту', 'IEEE', 'COMPETITION', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Соревнование по машинному обучению и нейронным сетям'),
(gen_random_uuid(), 'Дебаты "Молодежь и мир"', 'МИД России', 'CONTEST', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Конкурс ораторского мастерства и дебатов'),
(gen_random_uuid(), 'Олимпиада по физике "Росатом"', 'Росатом', 'OLYMPIAD', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Олимпиада по ядерной физике и энергетике'),
(gen_random_uuid(), 'Чемпионат "Программирование на скорость"', 'Яндекс', 'CHAMPIONSHIP', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Соревнование по быстрому решению алгоритмических задач'),
(gen_random_uuid(), 'Конкурс стартапов "Технопрорыв"', 'Фонд Сколково', 'COMPETITION', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Конкурс инновационных проектов и стартапов');

-- ============================================
-- УЧАСТИЯ СТУДЕНТОВ
-- ============================================

INSERT INTO participation (id, student_id, competition_id, level_id, result_id, year, supervisor, is_blocked, created_at, updated_at, description) VALUES

-- Иван Петров (программист) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Петров' AND name = 'Иван' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по программированию' LIMIT 1),
 3, 2, 2024, 'Проф. Смирнов А.А.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер отборочного этапа, решил 6 из 8 задач'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Петров' AND name = 'Иван' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 3, 3, 2024, 'Проф. Смирнов А.А.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник трека Backend-разработка'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Петров' AND name = 'Иван' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по программированию' LIMIT 1),
 2, 1, 2023, 'Проф. Смирнов А.А.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель регионального этапа'),

-- Мария Сидорова (кибербезопасность) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Сидорова' AND name = 'Мария' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 3, 1, 2024, 'Доц. Петрова Е.В.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель в категории Web Security'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Сидорова' AND name = 'Мария' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 3, 1, 2023, 'Доц. Петрова Е.В.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победа в треке Кибербезопасность'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Сидорова' AND name = 'Мария' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 2, 2, 2022, 'Доц. Петрова Е.В.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер регионального CTF'),

-- Алексей Козлов (ИИ) - 2 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Козлов' AND name = 'Алексей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Международный конкурс по искусственному интеллекту' LIMIT 1),
 4, 2, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер в номинации Computer Vision'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Козлов' AND name = 'Алексей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 3, 3, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник трека AI/ML'),

-- Екатерина Николаева (биотех) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Николаева' AND name = 'Екатерина' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 3, 5, 2024, 'Проф. Иванова М.П.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Диплом за оригинальный подход в НИР по генной инженерии'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Николаева' AND name = 'Екатерина' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 2, 1, 2023, 'Проф. Иванова М.П.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель регионального этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Николаева' AND name = 'Екатерина' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 1, 5, 2022, 'Проф. Иванова М.П.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Диплом за перспективное исследование'),

-- Дмитрий Иванов (химия) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Иванов' AND name = 'Дмитрий' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по химии "Ломоносов"' LIMIT 1),
 3, 1, 2024, 'Доц. Петров К.К.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель заключительного этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Иванов' AND name = 'Дмитрий' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по химии "Ломоносов"' LIMIT 1),
 2, 2, 2022, 'Доц. Петров К.К.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер регионального этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Иванов' AND name = 'Дмитрий' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 1, 1, 2024, 'Доц. Петров К.К.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель внутривузовского этапа'),

-- Анна Смирнова (лингвистика) - 2 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Смирнова' AND name = 'Анна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 2, 2, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер регионального этапа дебатов'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Смирнова' AND name = 'Анна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 1, 1, 2023, NULL, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель внутривузовского отбора'),

-- Сергей Васильев (международные отношения) - 2 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Васильев' AND name = 'Сергей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 3, 1, 2024, 'Проф. Соколов В.В.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель всероссийского этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Васильев' AND name = 'Сергей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 1, 1, 2023, 'Проф. Соколов В.В.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель внутривузовского этапа'),

-- Ольга Михайлова (финансы) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Михайлова' AND name = 'Ольга' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 3, 2, 2024, 'Доц. Новикова Т.Т.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер в треке инвестиционного анализа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Михайлова' AND name = 'Ольга' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 2, 1, 2023, 'Доц. Новикова Т.Т.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель регионального этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Михайлова' AND name = 'Ольга' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс стартапов "Технопрорыв"' LIMIT 1),
 2, 2, 2024, 'Доц. Новикова Т.Т.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер с проектом в сфере финтех'),

-- Артем Федоров (менеджмент) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Федоров' AND name = 'Артем' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 1, 3, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник внутривузовского этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Федоров' AND name = 'Артем' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс стартапов "Технопрорыв"' LIMIT 1),
 1, 2, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер с проектом системы управления бизнес-процессами'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Федоров' AND name = 'Артем' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 2, 4, 2022, NULL, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Дисквалификация за использование готового кода из интернета'),

-- Наталья Попова (математика) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Попова' AND name = 'Наталья' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по математике им. Колмогорова' LIMIT 1),
 4, 1, 2024, 'Проф. Лебедев Н.Н.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель международного этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Попова' AND name = 'Наталья' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по математике им. Колмогорова' LIMIT 1),
 3, 1, 2023, 'Проф. Лебедев Н.Н.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель всероссийского этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Попова' AND name = 'Наталья' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по математике им. Колмогорова' LIMIT 1),
 2, 1, 2022, 'Проф. Лебедев Н.Н.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель регионального этапа'),

-- Павел Семенов (физика) - 2 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Семенов' AND name = 'Павел' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 3, 2, 2024, 'Проф. Волков Д.Д.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер за работу по квантовой физике'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Семенов' AND name = 'Павел' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по физике "Росатом"' LIMIT 1),
 3, 1, 2024, 'Проф. Волков Д.Д.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель в секции ядерной физики'),

-- Виктория Лебедева (программист) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Лебедева' AND name = 'Виктория' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 4, 2, 2024, 'Проф. Смирнов А.А.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер международного трека'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Лебедева' AND name = 'Виктория' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат "Программирование на скорость"' LIMIT 1),
 3, 3, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник всероссийского финала'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Лебедева' AND name = 'Виктория' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по программированию' LIMIT 1),
 3, 4, 2023, 'Проф. Смирнов А.А.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Дисквалификация за нарушение временного регламента'),

-- Максим Орлов (физик) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Орлов' AND name = 'Максим' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по физике "Росатом"' LIMIT 1),
 2, 2, 2024, 'Доц. Кузнецов П.П.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер регионального этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Орлов' AND name = 'Максим' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 2, 5, 2023, 'Доц. Кузнецов П.П.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Диплом за инновационный подход в работе по оптике'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Орлов' AND name = 'Максим' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Олимпиада по физике "Росатом"' LIMIT 1),
 1, 5, 2023, 'Доц. Кузнецов П.П.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Диплом за лучшее решение экспериментальной задачи'),

-- Елена Кузнецова (история) - 2 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Кузнецова' AND name = 'Елена' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 1, 3, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник с работой по истории России XX века'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Кузнецова' AND name = 'Елена' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Дебаты "Молодежь и мир"' LIMIT 1),
 2, 4, 2023, NULL, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Дисквалификация за плагиат в выступлении'),

-- Андрей Морозов (экономика) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Морозов' AND name = 'Андрей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 2, 1, 2024, 'Проф. Соколова Л.Л.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель регионального этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Морозов' AND name = 'Андрей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс стартапов "Технопрорыв"' LIMIT 1),
 3, 2, 2024, 'Проф. Соколова Л.Л.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер с проектом маркетплейса'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Морозов' AND name = 'Андрей' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Кейс-чемпионат по финансам' LIMIT 1),
 3, 5, 2023, 'Проф. Соколова Л.Л.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Диплом за креативность решения'),

-- Кирилл Соколов (информационные системы) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Соколов' AND name = 'Кирилл' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 2, 3, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Участник регионального этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Соколов' AND name = 'Кирилл' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат "Программирование на скорость"' LIMIT 1),
 3, 4, 2023, NULL, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Дисквалификация за попытку использования запрещенных библиотек'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Соколов' AND name = 'Кирилл' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по программированию' LIMIT 1),
 1, 2, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер внутривузовского этапа'),

-- Татьяна Волкова (биология) - 3 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Волкова' AND name = 'Татьяна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 2, 2, 2024, 'Проф. Иванова М.П.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер с работой по экологии'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Волкова' AND name = 'Татьяна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 1, 1, 2023, 'Проф. Иванова М.П.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель внутривузовского этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Волкова' AND name = 'Татьяна' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Конкурс научных работ молодых ученых' LIMIT 1),
 3, 4, 2022, 'Проф. Иванова М.П.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Дисквалификация за обнаружение фальсификации экспериментальных данных'),

-- Игорь Новиков (компьютерная безопасность) - 4 участия
(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Новиков' AND name = 'Игорь' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 4, 1, 2024, 'Доц. Петрова Е.В.', FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель международного этапа CTF'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Новиков' AND name = 'Игорь' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 3, 1, 2023, 'Доц. Петрова Е.В.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Победитель всероссийского этапа'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Новиков' AND name = 'Игорь' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Хакатон "Цифровой прорыв"' LIMIT 1),
 3, 2, 2024, NULL, FALSE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Призер в треке кибербезопасности'),

(gen_random_uuid(), 
 (SELECT id FROM student WHERE surname = 'Новиков' AND name = 'Игорь' LIMIT 1),
 (SELECT id FROM competition WHERE name = 'Чемпионат по кибербезопасности' LIMIT 1),
 2, 4, 2022, 'Доц. Петрова Е.В.', TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Дисквалификация за выход за границы тестовой среды');

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
