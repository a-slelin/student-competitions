--liquibase formatted sql

--changeset a.slelin:013-add-default-participation-data

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

--rollback DELETE FROM participation;