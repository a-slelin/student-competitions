-- =======================================================
-- Тестовые данные для системы учета участий в олимпиадах
-- =======================================================

-- =======================================================
-- УРОВНИ
-- =======================================================

INSERT INTO level (code, name, sort_order) VALUES
	('UNI', 'Внутривузовский уровень', 1),
	('REG', 'Региональный уровень', 2),
	('RUS', 'Всероссийский уровень', 3),
	('INT', 'Международный уровень', 4);


-- =======================================================
-- РЕЗУЛЬТАТЫ
-- =======================================================

INSERT INTO result (code, name, sort_order) VALUES
	('WIN', 'Победитель', 1),
	('PRIZE', 'Призер', 2),
	('PART', 'Участник', 3),
	('DIQ', 'Дисквалифицирован', 4),
	('DIP', 'Дипломант', 5);

-- =======================================================
-- КОНКУРСЫ И ОЛИМПИАДЫ
-- =======================================================

INSERT INTO student (name, surname, middle_name, card_number, faculty, department, study_group, email, phone) VALUES
	('Дарья', 'Алексеева', 'Сергеевна', 1032867, 'Математический факультет', 'Общая математика', 'ПМИ-41БО', 'darya.alekseeva@yandex.ru', '+7(485)235-12-34'),
	('Лора', 'Амирян', 'Геворкиевна', 1032890, 'Факультет психологии', 'Общая психология', 'ПС-41БО', 'lora.amiryan@gmail.com', '+7(910)456-78-90'),
	('Александра', 'Антошкина', 'Анатольевна', 1032912, 'Факультет информатики и вычислительной техники', 'Компьютерные сети', 'ИВТ-31БО', 'alex.antoshkina@yandex.ru', '+7(485)267-89-01'),
	('Фёдор', 'Батов', 'Ильич', 1032934, 'Физико-технический факультет', 'Радиофизика', 'РФ-41БО', 'fedor.batov@gmail.com', '+7(920)123-45-67'),
	('Полина', 'Белобокова', 'Владимировна', 1032956, 'Экономический факультет', 'Финансы и кредит', 'Э-41БО', 'polina.belobokova@inbox.ru', '+7(485)278-90-12'),
	('Наталья', 'Белова', 'Максимовна', 1032978, 'Юридический факультет', 'Гражданское право', 'ЮР-41БО', 'natalya.belova@gmail.com', '+7(915)345-67-89'),
	('Андрей', 'Богуцкий', 'Сергеевич', 1033000, 'Факультет биологии и экологии', 'Экология и зоология', 'ЭП-31БО', 'andrey.bogutsky@gmail.com', '+7(485)289-01-23'),
	('Дарья', 'Борисюк', 'Родионовна', 1033022, 'Исторический факультет', 'Всеобщая история', 'И-31БО', 'darya.borisyuk@gmail.com', '+7(925)456-78-90'),
	('Владислав', 'Братчиков', 'Алексеевич', 1033044, 'Факультет филологии и коммуникации', 'Прикладная филология', 'ФЛ-41БО', 'vlad.bratchikov@mail.ru', '+7(485)290-12-34'),
	('Вероника', 'Брыченкова', 'Дмитриевна', 1033066, 'Факультет иностранных языков', 'Иностранные языки', 'ЛН-31БО', 'veronika.brychenkova@gmail.com', '+7(916)567-89-01'),
	('Олег', 'Васьков', 'Николаевич', 1033088, 'Математический факультет', 'Общая математика', 'МКН-41БО', 'oleg.vaskov@gmail.com', '+7(485)301-23-45'),
	('Василиса', 'Васюкова', 'Евгеньевна', 1033110, 'Факультет психологии', 'Общая психология', 'ПС-21БО', 'vasilisa.vasyukova@yandex.ru', '+7(921)678-90-12'),
	('Виолетта', 'Викторова', 'Александровна', 1033132, 'Факультет информатики и вычислительной техники', 'Компьютерные сети', 'ИТ-21БО', 'violetta.viktorova@gmail.com', '+7(485)312-34-56'),
	('Дмитрий', 'Воропаев', 'Юрьевич', 1033154, 'Физико-технический факультет', 'Теоретическая физика', 'Ф-21БО', 'dmitry.voropaev@yandex.ru', '+7(917)789-01-23'),
	('Ариана', 'Галкина', 'Андреевна', 1033176, 'Экономический факультет', 'Мировая экономика', 'МН-31БО', 'ariana.galkina@gmail.com', '+7(485)323-45-67'),
	('Максим', 'Гладков', 'Сергеевич', 1033198, 'Юридический факультет', 'Уголовное право', 'ЮР-21БО', 'maxim.gladkov@yandex.ru', '+7(926)890-12-34'),
	('Виктория', 'Глебова', 'Андреевна', 1033220, 'Факультет биологии и экологии', 'Ботаника', 'Б-21БО', 'viktoriya.glebova@gmail.com', '+7(485)334-56-78'),
	('Кристина', 'Голикова', 'Алексеевна', 1033242, 'Исторический факультет', 'Регионоведение', 'Т-21БО', 'kristina.golikova@mail.ru', '+7(918)901-23-45'),
	('Владислав', 'Грачев', 'Владимирович', 1033264, 'Факультет филологии и коммуникации', 'Общая филология', 'МДК-11БО', 'vlad.grachev@mail.ru', '+7(485)345-67-89'),
	('Мария', 'Гусева', 'Алексеевна', 1033286, 'Факультет иностранных языков', 'Иностранные языки', 'ФЛ-22БО', 'maria.guseva@gmail.com', '+7(927)012-34-56'),
	('Артём', 'Дыбцын', 'Станиславович', 1033308, 'Математический факультет', 'Матанализ', 'ПМИ-11БО', 'artem.dybtsyn@mail.ru', '+7(485)356-78-90'),
	('Лидия', 'Жиоара', 'Андреевна', 1033330, 'Факультет психологии', 'Общая психология', 'ПС-11БО', 'lidiya.zhioara@yandex.ru', '+7(919)123-45-67'),
	('Ксения', 'Захарова', 'Алексеевна', 1033352, 'Факультет информатики и вычислительной техники', 'Дискретный анализ', 'ИВТ-11БО', 'ksenia.zakharova@rambler.ru', '+7(485)367-89-01'),
	('Владислав', 'Иванченко', 'Романович', 1033374, 'Физико-технический факультет', 'Радиофизика', 'РФ-11БО', 'vlad.ivanchenko@gmail.com', '+7(928)234-56-78'),
	('Ирина', 'Илатовская', 'Александровна', 1033396, 'Экономический факультет', 'Финансы и кредит', 'Э-11БО', 'irina.ilatovskaya@gmail.com', '+7(485)378-90-12'),
	('Эрик', 'Каграманян', 'Ашотович', 1033418, 'Юридический факультет', 'Гражданское право', 'ЮР-11БО', 'erik.kagramanyan@mail.ru', '+7(920)345-67-89'),
	('Валентина', 'Каскун', 'Максимовна', 1033440, 'Факультет биологии и экологии', 'Экология и зоология', 'ЭП-11БО', 'valentina.kaskun@yandex.ru', '+7(485)389-01-23'),
	('Илья', 'Квасков', 'Александрович', 1033462, 'Исторический факультет', 'Всеобщая история', 'И-11БО', 'ilya.kvaskov@gmail.com', '+7(929)456-78-90'),
	('Гордей', 'Киселев', 'Иванович', 1033484, 'Факультет филологии и коммуникации', 'Прикладная филология', 'ФЛ-11БО', 'gordey.kiselev@yandex.ru', '+7(485)390-12-34'),
	('Екатерина', 'Кобякова', 'Сергеевна', 1033506, 'Факультет иностранных языков', 'Иностранные языки', 'ЛН-11БО', 'ekaterina.kobyakova@gmail.com', '+7(921)567-89-01'),
	('Алена', 'Козулина', 'Юрьевна', 1033528, 'Математический факультет', 'Матмоделирования', 'МКН-11БО', 'alena.kozulina@list.ru', '+7(485)401-23-45'),
	('Александр', 'Комаров', 'Максимович', 1033550, 'Факультет психологии', 'Соцпсихология', 'ПС-31БО', 'alex.komarov@yandex.ru', '+7(930)678-90-12'),
	('Эллина', 'Комарова', 'Андреевна', 1033572, 'Факультет информатики и вычислительной техники', 'Компьютерные сети', 'ИТ-31БО', 'ellina.komarova@gmail.com', '+7(485)412-34-56'),
	('Катерина', 'Коныгина', 'Викторовна', 1033594, 'Физико-технический факультет', 'Теоретическая физика', 'Ф-31БО', 'katerina.konygina@list.ru', '+7(922)789-01-23'),
	('Илья', 'Коняшин', 'Романович', 1033616, 'Экономический факультет', 'Мировая экономика', 'МН-11БО', 'ilya.konyashin@yandex.ru', '+7(485)423-45-67'),
	('Анастасия', 'Кортушева', 'Владимировна', 1033638, 'Юридический факультет', 'Уголовное право', 'ЮР-31БО', 'anastasia.kortusheva@gmail.com', '+7(931)890-12-34'),
	('Степан', 'Крайнов', 'Михайлович', 1033660, 'Факультет биологии и экологии', 'Ботаника', 'Б-11БО', 'stepan.kraynov@gmail.com', '+7(485)434-56-78'),
	('Ярослав', 'Крылов', 'Русланович', 1033682, 'Исторический факультет', 'Регионоведение', 'Т-11БО', 'yaroslav.krylov@mail.ru', '+7(923)901-23-45'),
	('Вероника', 'Куделевская', 'Александровна', 1033704, 'Факультет филологии и коммуникации', 'Общая филология', 'ФЛ-21БО', 'veronika.kudelevskaya@icloud.com', '+7(485)445-67-89'),
	('Юрий', 'Кульбачинский', 'Владимирович', 1033726, 'Факультет иностранных языков', 'Иностранные языки', 'ФЛ-32БО', 'yury.kulbachinsky@mail.ru', '+7(932)012-34-56'),
	('Наталия', 'Макарова', 'Сергеевна', 1033748, 'Математический факультет', 'Матанализ', 'ПМИ-21БО', 'nataliya.makarova@yandex.ru', '+7(485)456-78-90'),
	('Екатерина', 'Медведева', 'Александровна', 1033770, 'Факультет психологии', 'Общая психология', 'ПС-21БО', 'ekaterina.medvedeva@gmail.com', '+7(924)123-45-67'),
	('Валерия', 'Некрасова', 'Сергеевна', 1033792, 'Факультет информатики и вычислительной техники', 'Дискретный анализ', 'ИВТ-21БО', 'valeriya.nekrasova@bk.ru', '+7(485)467-89-01'),
	('Петрос', 'Оганесян', 'Арутюнович', 1033814, 'Физико-технический факультет', 'Радиофизика', 'РФ-21БО', 'petros.oganesyan@gmail.com', '+7(933)234-56-78'),
	('Анастасия', 'Полякова', 'Сергеевна', 1033836, 'Экономический факультет', 'Финансы и кредит', 'Э-21БО', 'anastasia.polyakova@gmail.com', '+7(485)478-90-12'),
	('Арина', 'Попова', 'Андреевна', 1033858, 'Юридический факультет', 'Гражданское право', 'ЮР-21БО', 'arina.popova@mail.ru', '+7(925)345-67-89'),
	('Полина', 'Савинова', 'Ринатовна', 1033880, 'Факультет биологии и экологии', 'Экология и зоология', 'ЭП-21БО', 'polina.savinova@gmail.com', '+7(485)489-01-23'),
	('Алина', 'Семечкина', 'Ивановна', 1033902, 'Исторический факультет', 'Всеобщая история', 'И-21БО', 'alina.semechkina@gmail.com', '+7(934)456-78-90'),
	('Ева', 'Суворова', 'Викторовна', 1033924, 'Факультет филологии и коммуникации', 'Прикладная филология', 'ФЛ-31БО', 'eva.suvorova@yandex.ru', '+7(485)490-12-34'),
	('Мария', 'Сухова', 'Алексеевна', 1039421, 'Факультет иностранных языков', 'Иностранные языки', 'ЛН-21БО', 'maria.sukhova@gmail.com', '+7(926)567-89-01');

-- ============================================
-- КОНКУРСЫ И ОЛИМПИАДЫ
-- ============================================

INSERT INTO competition (name, organizer, type) VALUES
	('Всероссийская олимпиада по математике', 'Министерство образования РФ', 'OLYMPIAD'),
	('Региональный хакатон по программированию', 'Ярославский государственный университет', 'CONTEST'),
	('Международный конкурс биотехнологий', 'UNESCO', 'COMPETITION'),
	('Внутривузовский чемпионат по физике', 'ЯрГУ', 'CHAMPIONSHIP'),
	('Всероссийский конкурс психологических исследований', 'Российская академия наук', 'CONTEST'),
	('Региональный турнир по истории', 'Ярославская область', 'COMPETITION'),
	('Международная олимпиада по информатике', 'IOI Committee', 'OLYMPIAD'),
	('Внутривузовский конкурс экономических проектов', 'ЯрГУ Экономический факультет', 'CONTEST'),
	('Всероссийский чемпионат по юриспруденции', 'Министерство юстиции РФ', 'CHAMPIONSHIP'),
	('Региональный конкурс иностранных языков', 'Ярославская лингвистическая ассоциация', 'COMPETITION'),
	('Международный хакатон по экологии', 'Greenpeace', 'CONTEST'),
	('Внутривузовский турнир по филологии', 'ЯрГУ Филологический факультет', 'COMPETITION'),
	('Всероссийская олимпиада по радиофизике', 'Росатом', 'OLYMPIAD'),
	('Региональный конкурс социальных наук', 'Ярославский социальный центр', 'CONTEST'),
	('Международный чемпионат по программированию', 'ICPC', 'CHAMPIONSHIP'),
	('Внутривузовский конкурс биологии', 'ЯрГУ Биологический факультет', 'CONTEST'),
	('Всероссийский турнир по психологии', 'Психологическая ассоциация РФ', 'COMPETITION'),
	('Региональная олимпиада по экономике', 'Ярославская экономическая палата', 'OLYMPIAD'),
	('Международный конкурс исторических исследований', 'International History Society', 'CONTEST'),
	('Внутривузовский хакатон по информатике', 'ЯрГУ ИВТ', 'CONTEST');

-- =======================================================
-- УЧАСТИЯ
-- =======================================================

INSERT INTO participation (student_id, competition_id, level_code, result_code, year, supervisor, points, description) VALUES
	((SELECT id FROM student WHERE card_number = 1032867), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'RUS', 'WIN', 2024, 'Проф. Иванов И.И.', 95, 'Выдающееся решение задач'),
	((SELECT id FROM student WHERE card_number = 1032867), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'REG', 'PRIZE', 2023, 'Доц. Петров П.П.', 85, 'Инновационный проект'),
	((SELECT id FROM student WHERE card_number = 1032867), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'INT', 'PART', 2025, NULL, NULL, NULL),
	 
	((SELECT id FROM student WHERE card_number = 1032890), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'RUS', 'DIP', 2024, 'Проф. Сидорова А.А.', 80, 'Интересное исследование'),
	((SELECT id FROM student WHERE card_number = 1032890), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'WIN', 2023, NULL, 90, NULL),
	 
	((SELECT id FROM student WHERE card_number = 1032912), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'INT', 'PRIZE', 2025, 'Доц. Козлов В.В.', 92, 'Отличный алгоритм'),
	((SELECT id FROM student WHERE card_number = 1032912), (SELECT id FROM competition WHERE name = 'Региональный турнир по истории'), 'REG', 'PART', 2024, NULL, NULL, 'Активное участие'),
	((SELECT id FROM student WHERE card_number = 1032912), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'UNI', 'DIQ', 2023, NULL, NULL, 'Нарушение правил'),
	 
	((SELECT id FROM student WHERE card_number = 1032934), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по радиофизике'), 'RUS', 'WIN', 2024, 'Проф. Федоров Ф.Ф.', 88, NULL),
	((SELECT id FROM student WHERE card_number = 1032934), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'INT', 'DIP', 2025, NULL, 75, 'Экологический проект'),
	((SELECT id FROM student WHERE card_number = 1032934), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'PART', 2023, NULL, NULL, NULL),
	((SELECT id FROM student WHERE card_number = 1032934), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'UNI', 'PRIZE', 2022, 'Доц. Громова Е.Е.', 82, NULL),
	 
	((SELECT id FROM student WHERE card_number = 1032956), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'UNI', 'WIN', 2023, NULL, 95, NULL),
	((SELECT id FROM student WHERE card_number = 1032956), (SELECT id FROM competition WHERE name = 'Всероссийский чемпионат по юриспруденции'), 'RUS', 'PRIZE', 2024, 'Проф. Юрьев Ю.Ю.', 85, 'Юридический анализ'),
	 
	((SELECT id FROM student WHERE card_number = 1032978), (SELECT id FROM competition WHERE name = 'Всероссийский чемпионат по юриспруденции'), 'RUS', 'PART', 2024, NULL, NULL, NULL),
	((SELECT id FROM student WHERE card_number = 1032978), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'REG', 'DIP', 2023, 'Доц. Социалов С.С.', 78, NULL),
	((SELECT id FROM student WHERE card_number = 1032978), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'INT', 'DIQ', 2025, NULL, NULL, 'Техническая ошибка'),
	 
	((SELECT id FROM student WHERE card_number = 1033000), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'INT', 'WIN', 2025, 'Проф. Биологов Б.Б.', 96, 'Биотехнологии'),
	((SELECT id FROM student WHERE card_number = 1033000), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'UNI', 'PRIZE', 2024, NULL, 87, NULL),
	 
	((SELECT id FROM student WHERE card_number = 1033022), (SELECT id FROM competition WHERE name = 'Региональный турнир по истории'), 'REG', 'PART', 2023, NULL, NULL, NULL),
	((SELECT id FROM student WHERE card_number = 1033022), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'RUS', 'DIP', 2024, 'Доц. Психологова П.П.', 80, NULL),
	((SELECT id FROM student WHERE card_number = 1033022), (SELECT id FROM competition WHERE name = 'Международный чемпионат по программированию'), 'INT', 'WIN', 2025, NULL, 93, 'Командная работа'),
	 
	((SELECT id FROM student WHERE card_number = 1033044), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'UNI', 'DIQ', 2023, NULL, NULL, 'Плагиат'),
	((SELECT id FROM student WHERE card_number = 1033044), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'PRIZE', 2024, 'Проф. Лингвистов Л.Л.', 84, NULL),
	 
	((SELECT id FROM student WHERE card_number = 1033066), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'WIN', 2024, NULL, 90, NULL),
	((SELECT id FROM student WHERE card_number = 1033066), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'RUS', 'PART', 2023, 'Доц. Математиков М.М.', NULL, NULL),
	((SELECT id FROM student WHERE card_number = 1033066), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'INT', 'DIP', 2025, NULL, 76, NULL),
	 
	((SELECT id FROM student WHERE card_number = 1033088), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'REG', 'DIQ', 2024, 'Доц. Математиков М.М.', NULL, 'Биотехнологии'),
	((SELECT id FROM student WHERE card_number = 1033088), (SELECT id FROM competition WHERE name = 'Всероссийский чемпионат по юриспруденции'), 'REG', 'DIQ', 2023, 'Доц. Громова Е.Е.', 80, 'Интересное исследование'), 
	((SELECT id FROM student WHERE card_number = 1033088), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'REG', 'DIP', 2022, 'Доц. Социалов С.С.', 80, 'Экологический проект'),
	 
	((SELECT id FROM student WHERE card_number = 1033110), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'UNI', 'DIP', 2023, 'Проф. Сидорова А.А.', NULL, 'Нарушение времени'),
	 
	((SELECT id FROM student WHERE card_number = 1033110), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'REG', 'WIN', 2024, 'Доц. Козлов В.В.', 77, 'Глобальный проект'),
	 
	((SELECT id FROM student WHERE card_number = 1033132), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'RUS', 'PART', 2023, 'Доц. Козлов В.В.', 92, 'Нарушение времени'),
	 
	((SELECT id FROM student WHERE card_number = 1033132), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'RUS', 'DIQ', 2024, 'Проф. Экономистов Э.Э.', 72, 'Отличный алгоритм'),
	 
	((SELECT id FROM student WHERE card_number = 1033154), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'UNI', 'WIN', 2022, 'Доц. Математиков М.М.', NULL, 'Интересное исследование'), 
	((SELECT id FROM student WHERE card_number = 1033154), (SELECT id FROM competition WHERE name = 'Всероссийский чемпионат по юриспруденции'), 'UNI', 'DIQ', 2025, 'Доц. Петров П.П.', NULL, 'Техническая ошибка'),
	((SELECT id FROM student WHERE card_number = 1033154), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'INT', 'PRIZE', 2022, 'Проф. Юрьев Ю.Ю.', 79, 'Экономическая модель'),
	 
	((SELECT id FROM student WHERE card_number = 1033176), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'UNI', 'DIP', 2022, 'Проф. Юрьев Ю.Ю.', NULL, 'Выдающееся решение задач'),
	((SELECT id FROM student WHERE card_number = 1033176), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'PRIZE', 2022, 'Доц. Козлов В.В.', 94, 'Техническая ошибка'),
	 
	((SELECT id FROM student WHERE card_number = 1033198), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'REG', 'DIQ', 2025, NULL, 90, NULL),
	((SELECT id FROM student WHERE card_number = 1033198), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'UNI', 'WIN', 2024, 'Проф. Лингвистов Л.Л.', NULL, 'Активное участие'),
	 
	((SELECT id FROM student WHERE card_number = 1033220), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'PART', 2025, NULL, 74, 'Экологический проект'),
	((SELECT id FROM student WHERE card_number = 1033220), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'REG', 'PART', 2024, 'Доц. Психологова П.П.', NULL, 'Нарушение времени'),
	((SELECT id FROM student WHERE card_number = 1033220), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'INT', 'PART', 2025, 'Доц. Громова Е.Е.', NULL, 'Отличный алгоритм'),
	 
	((SELECT id FROM student WHERE card_number = 1033242), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'UNI', 'DIQ', 2025, 'Проф. Иванов И.И.', NULL, 'Нарушение времени'),
	 
	((SELECT id FROM student WHERE card_number = 1033264), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'RUS', 'PART', 2025, 'Проф. Юрьев Ю.Ю.', NULL, 'Инновационный проект'),
	((SELECT id FROM student WHERE card_number = 1033264), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'INT', 'WIN', 2024, 'Доц. Исследователь И.И.', NULL, 'Экологический проект'),
	 
	((SELECT id FROM student WHERE card_number = 1033286), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'REG', 'PART', 2024, 'Доц. Математиков М.М.', 100, 'Глобальный проект'),
	((SELECT id FROM student WHERE card_number = 1033286), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'INT', 'WIN', 2022, 'Доц. Психологова П.П.', NULL, 'Нарушение времени'),
	 
	((SELECT id FROM student WHERE card_number = 1033308), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'RUS', 'WIN', 2025, 'Доц. Математиков М.М.', NULL, 'Выдающееся решение задач'),
	((SELECT id FROM student WHERE card_number = 1033308), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'UNI', 'DIP', 2023, 'Доц. Социалов С.С.', 90, 'Плагиат'),
	 
	((SELECT id FROM student WHERE card_number = 1033330), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'REG', 'WIN', 2022, 'Проф. Иванов И.И.', 98, 'Командная работа'),
	((SELECT id FROM student WHERE card_number = 1033330), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'INT', 'PRIZE', 2023, NULL, 74, 'Интересное исследование'),
	((SELECT id FROM student WHERE card_number = 1033330), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'UNI', 'WIN', 2025, 'Доц. Козлов В.В.', NULL, 'Экономическая модель'),
	 
	((SELECT id FROM student WHERE card_number = 1033352), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'RUS', 'PRIZE', 2024, 'Доц. Социалов С.С.', 82, 'Интересное исследование'),
	((SELECT id FROM student WHERE card_number = 1033352), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'PART', 2025, 'Проф. Биологов Б.Б.', 95, 'Интересное исследование'),
	 
	((SELECT id FROM student WHERE card_number = 1033374), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'INT', 'WIN', 2023, 'Проф. Иванов И.И.', 75, 'Техническая ошибка'),
	((SELECT id FROM student WHERE card_number = 1033374), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'REG', 'DIP', 2022, 'Проф. Биологов Б.Б.', NULL, 'Экологический проект'),
	 
	((SELECT id FROM student WHERE card_number = 1033396), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'RUS', 'PRIZE', 2022, 'Доц. Петров П.П.', 97, NULL),
	((SELECT id FROM student WHERE card_number = 1033396), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'UNI', 'PRIZE', 2023, 'Проф. Экономистов Э.Э.', NULL, 'Нарушение правил'),
	 
	((SELECT id FROM student WHERE card_number = 1033418), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'DIP', 2025, 'Проф. Экономистов Э.Э.', NULL, 'Нарушение правил'),
	((SELECT id FROM student WHERE card_number = 1033418), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'RUS', 'PART', 2022, 'Доц. Исследователь И.И.', 70, 'Командная работа'),
	((SELECT id FROM student WHERE card_number = 1033418), (SELECT id FROM competition WHERE name = 'Международный чемпионат по программированию'), 'INT', 'PRIZE', 2024, 'Доц. Громова Е.Е.', NULL, 'Техническая ошибка'),
	 
	((SELECT id FROM student WHERE card_number = 1033440), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'RUS', 'WIN', 2025, 'Проф. Сидорова А.А.', NULL, 'Юридический анализ'),
	((SELECT id FROM student WHERE card_number = 1033440), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'UNI', 'WIN', 2023, 'Доц. Социалов С.С.', 95, 'Интересное исследование'),
	 
	((SELECT id FROM student WHERE card_number = 1033462), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'DIQ', 2024, 'Доц. Психологова П.П.', 80, 'Командная работа'),
	((SELECT id FROM student WHERE card_number = 1033462), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по радиофизике'), 'UNI', 'PRIZE', 2025, 'Проф. Экономистов Э.Э.', 97, 'Интересное исследование'),
	 
	((SELECT id FROM student WHERE card_number = 1033484), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'RUS', 'PART', 2025, NULL, NULL, 'Нарушение времени'),
	((SELECT id FROM student WHERE card_number = 1033484), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'RUS', 'WIN', 2022, NULL, 71, 'Активное участие'),
	((SELECT id FROM student WHERE card_number = 1033484), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'UNI', 'PRIZE', 2023, 'Доц. Громова Е.Е.', 89, 'Техническая ошибка'),
	 
	((SELECT id FROM student WHERE card_number = 1033506), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'INT', 'PRIZE', 2024, 'Проф. Юрьев Ю.Ю.', NULL, 'Экономическая модель'),
	((SELECT id FROM student WHERE card_number = 1033506), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'RUS', 'PRIZE', 2022, 'Проф. Иванов И.И.', 99, 'Плагиат'),
	 
	((SELECT id FROM student WHERE card_number = 1033528), (SELECT id FROM competition WHERE name = 'Региональный турнир по истории'), 'UNI', 'WIN', 2022, 'Проф. Иванов И.И.', NULL, 'Плагиат'),
	 
	((SELECT id FROM student WHERE card_number = 1033550), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'RUS', 'WIN', 2022, 'Проф. Экономистов Э.Э.', 92, 'Выдающееся решение задач'),
	((SELECT id FROM student WHERE card_number = 1033550), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'UNI', 'DIQ', 2023, 'Доц. Социалов С.С.', NULL, 'Экономическая модель'),
	((SELECT id FROM student WHERE card_number = 1033550), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'RUS', 'WIN', 2025, 'Доц. Психологова П.П.', 77, 'Выдающееся решение задач'),
	 
	((SELECT id FROM student WHERE card_number = 1033572), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'UNI', 'DIQ', 2024, 'Проф. Юрьев Ю.Ю.', 87, 'Отличный алгоритм'),
	 
	((SELECT id FROM student WHERE card_number = 1033594), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'UNI', 'DIQ', 2025, 'Проф. Сидорова А.А.', 96, 'Биотехнологии'),
	((SELECT id FROM student WHERE card_number = 1033594), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'REG', 'PART', 2025, 'Проф. Биологов Б.Б.', NULL, 'Экологический проект'),
	((SELECT id FROM student WHERE card_number = 1033594), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'INT', 'PART', 2023, 'Проф. Федоров Ф.Ф.', NULL, 'Нарушение правил'),
	 
	((SELECT id FROM student WHERE card_number = 1033616), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'INT', 'DIP', 2022, 'Доц. Петров П.П.', 90, 'Отличный алгоритм'),
	((SELECT id FROM student WHERE card_number = 1033616), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'DIP', 2025, 'Доц. Исследователь И.И.', NULL, NULL),
	((SELECT id FROM student WHERE card_number = 1033616), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'REG', 'DIP', 2025, 'Проф. Федоров Ф.Ф.', NULL, 'Плагиат'),
	 
	((SELECT id FROM student WHERE card_number = 1033638), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'UNI', 'DIQ', 2022, 'Доц. Психологова П.П.', 99, 'Экологический проект'),
	((SELECT id FROM student WHERE card_number = 1033638), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'UNI', 'DIP', 2022, 'Проф. Иванов И.И.', NULL, 'Нарушение правил'),
	 
	((SELECT id FROM student WHERE card_number = 1033660), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'INT', 'WIN', 2024, 'Доц. Громова Е.Е.', 74, NULL),
	((SELECT id FROM student WHERE card_number = 1033660), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'DIQ', 2025, 'Доц. Исследователь И.И.', NULL, 'Юридический анализ'),
	 
	((SELECT id FROM student WHERE card_number = 1033682), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'RUS', 'PRIZE', 2024, 'Доц. Психологова П.П.', 95, 'Интересное исследование'),
	((SELECT id FROM student WHERE card_number = 1033682), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'REG', 'DIP', 2022, 'Доц. Исследователь И.И.', NULL, 'Активное участие'),
	 
	((SELECT id FROM student WHERE card_number = 1033704), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'INT', 'WIN', 2024, 'Проф. Экономистов Э.Э.', NULL, 'Биотехнологии'),
	((SELECT id FROM student WHERE card_number = 1033704), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'PART', 2023, 'Проф. Федоров Ф.Ф.', 100, 'Активное участие'),
	((SELECT id FROM student WHERE card_number = 1033704), (SELECT id FROM competition WHERE name = 'Международный чемпионат по программированию'), 'UNI', 'DIP', 2022, 'Проф. Сидорова А.А.', 77, 'Инновационный проект'),
	 
	((SELECT id FROM student WHERE card_number = 1033726), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'RUS', 'DIP', 2024, 'Доц. Петров П.П.', NULL, 'Нарушение правил'),
	 
	((SELECT id FROM student WHERE card_number = 1033748), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'INT', 'DIP', 2025, 'Проф. Лингвистов Л.Л.', 85, 'Юридический анализ'),
	((SELECT id FROM student WHERE card_number = 1033748), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'UNI', 'WIN', 2023, 'Проф. Федоров Ф.Ф.', 88, 'Техническая ошибка'),
	((SELECT id FROM student WHERE card_number = 1033748), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'RUS', 'WIN', 2024, 'Доц. Математиков М.М.', 79, 'Активное участие'),
	 
	((SELECT id FROM student WHERE card_number = 1033770), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'INT', 'PRIZE', 2022, 'Доц. Петров П.П.', NULL, 'Плагиат'),
	((SELECT id FROM student WHERE card_number = 1033770), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'UNI', 'PART', 2024, 'Доц. Петров П.П.', NULL, 'Плагиат'),
	((SELECT id FROM student WHERE card_number = 1033770), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'UNI', 'DIQ', 2022, 'Проф. Федоров Ф.Ф.', 72, 'Выдающееся решение задач'),
	 
	((SELECT id FROM student WHERE card_number = 1033792), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'WIN', 2022, 'Доц. Петров П.П.', 96, 'Юридический анализ'),
	((SELECT id FROM student WHERE card_number = 1033792), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'UNI', 'DIQ', 2024, 'Доц. Социалов С.С.', NULL, 'Интересное исследование'),
	((SELECT id FROM student WHERE card_number = 1033792), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'REG', 'PART', 2024, 'Доц. Козлов В.В.', 71, 'Экологический проект'),
	 
	((SELECT id FROM student WHERE card_number = 1033814), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'INT', 'PRIZE', 2025, 'Доц. Громова Е.Е.', 78, 'Активное участие'),
	((SELECT id FROM student WHERE card_number = 1033814), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'REG', 'DIQ', 2024, NULL, 89, 'Нарушение времени'),
	 
	((SELECT id FROM student WHERE card_number = 1033836), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'UNI', 'WIN', 2022, 'Проф. Юрьев Ю.Ю.', NULL, 'Биотехнологии'),
	((SELECT id FROM student WHERE card_number = 1033836), (SELECT id FROM competition WHERE name = 'Региональный турнир по истории'), 'REG', 'DIP', 2022, 'Доц. Математиков М.М.', NULL, 'Экономическая модель'),
	((SELECT id FROM student WHERE card_number = 1033836), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'REG', 'WIN', 2025, 'Проф. Экономистов Э.Э.', 99, 'Нарушение времени'),
	 
	((SELECT id FROM student WHERE card_number = 1033858), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'INT', 'PRIZE', 2024, 'Проф. Экономистов Э.Э.', NULL, 'Плагиат'),
	((SELECT id FROM student WHERE card_number = 1033858), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'INT', 'PRIZE', 2025, 'Доц. Громова Е.Е.', 73, 'Отличный алгоритм'),
	
	((SELECT id FROM student WHERE card_number = 1033880), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'REG', 'DIP', 2024, 'Проф. Иванов И.И.', NULL, NULL),
	((SELECT id FROM student WHERE card_number = 1033880), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'REG', 'WIN', 2022, 'Доц. Исследователь И.И.', NULL, 'Юридический анализ'),
	((SELECT id FROM student WHERE card_number = 1033880), (SELECT id FROM competition WHERE name = 'Международный чемпионат по программированию'), 'RUS', 'DIQ', 2025, 'Доц. Исследователь И.И.', NULL, 'Нарушение правил'),
	
	((SELECT id FROM student WHERE card_number = 1033902), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'WIN', 2023, 'Проф. Биологов Б.Б.', 70, 'Нарушение времени'),
	((SELECT id FROM student WHERE card_number = 1033902), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'UNI', 'DIP', 2023, 'Проф. Сидорова А.А.', 84, 'Экономическая модель'),
	((SELECT id FROM student WHERE card_number = 1033902), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'UNI', 'WIN', 2024, 'Проф. Биологов Б.Б.', NULL, 'Командная работа'),
	
	((SELECT id FROM student WHERE card_number = 1033924), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'UNI', 'WIN', 2024, NULL, 92, NULL),
	((SELECT id FROM student WHERE card_number = 1033924), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'REG', 'PRIZE', 2023, 'Проф. Экономистов Э.Э.', 83, 'Экономическая модель'),
	((SELECT id FROM student WHERE card_number = 1033924), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'INT', 'PART', 2025, NULL, NULL, NULL),
	
	((SELECT id FROM student WHERE card_number = 1039421), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'DIQ', 2024, NULL, NULL, 'Нарушение времени'),
	((SELECT id FROM student WHERE card_number = 1039421), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'RUS', 'DIP', 2023, 'Доц. Исследователь И.И.', 79, NULL),
	((SELECT id FROM student WHERE card_number = 1039421), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'INT', 'WIN', 2025, NULL, 94, 'Глобальный проект');
	

-- -- Проверка
-- SELECT 
--     -- Информация о студенте
--     s.card_number AS "Номер студбилета",
--     s.surname AS "Фамилия",
--     s.name AS "Имя",
--     s.middle_name AS "Отчество",
--     s.faculty AS "Факультет",
--     s.department AS "Кафедра",
--     s.study_group AS "Группа",
--     s.email AS "Email",
--     s.phone AS "Телефон",
    
--     -- Информация о мероприятии
--     c.name AS "Название мероприятия",
--     c.organizer AS "Организатор",
--     c.type AS "Тип мероприятия",
    
--     -- Информация об участии
--     p.year AS "Год участия",
--     l.name AS "Уровень",
--     r.name AS "Результат",
--     p.supervisor AS "Научный руководитель",
--     p.points AS "Баллы",
--     p.description AS "Описание",
--     p.is_blocked AS "Заблокировано",
--     p.created_at AS "Дата создания",
--     p.updated_at AS "Дата обновления"
    
-- FROM participation p
-- JOIN student s ON p.student_id = s.id
-- JOIN competition c ON p.competition_id = c.id
-- JOIN level l ON p.level_code = l.code
-- JOIN result r ON p.result_code = r.code
-- ORDER BY p.year DESC, s.surname, s.name;

-- -- Удаление данных
-- DELETE FROM participation;
-- DELETE FROM competition;
-- DELETE FROM student;
-- DELETE FROM level;
-- DELETE FROM result;
