--liquibase formatted sql

--changeset a.slelin:013-add-default-participation-data
INSERT INTO participation (student_id, competition_id, level_code, result_code, year, supervisor, points, description, is_blocked) VALUES
	((SELECT id FROM student WHERE card_number = 1032867), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'RUS', 'WIN', 2024, 'Проф. Иванов И.И.', 95, 'Выдающееся решение задач', TRUE),
	((SELECT id FROM student WHERE card_number = 1032867), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'REG', 'PRIZE', 2023, 'Доц. Петров П.П.', 85, 'Инновационный проект', TRUE),
	((SELECT id FROM student WHERE card_number = 1032867), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'INT', 'PART', 2025, NULL, NULL, NULL, FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1032890), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'RUS', 'DIP', 2024, 'Проф. Сидорова А.А.', 80, 'Интересное исследование', TRUE),
	((SELECT id FROM student WHERE card_number = 1032890), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'WIN', 2023, NULL, 90, NULL, TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1032912), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'INT', 'PRIZE', 2025, 'Доц. Козлов В.В.', 92, 'Отличный алгоритм', FALSE),
	((SELECT id FROM student WHERE card_number = 1032912), (SELECT id FROM competition WHERE name = 'Региональный турнир по истории'), 'REG', 'PART', 2024, NULL, NULL, 'Активное участие', TRUE),
	((SELECT id FROM student WHERE card_number = 1032912), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'UNI', 'DIQ', 2023, NULL, NULL, 'Нарушение правил', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1032934), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по радиофизике'), 'RUS', 'WIN', 2024, 'Проф. Федоров Ф.Ф.', 88, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1032934), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'INT', 'DIP', 2025, NULL, 75, 'Экологический проект', FALSE),
	((SELECT id FROM student WHERE card_number = 1032934), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'PART', 2023, NULL, NULL, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1032934), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'UNI', 'PRIZE', 2022, 'Доц. Громова Е.Е.', 82, NULL, TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1032956), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'UNI', 'WIN', 2023, NULL, 95, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1032956), (SELECT id FROM competition WHERE name = 'Всероссийский чемпионат по юриспруденции'), 'RUS', 'PRIZE', 2024, 'Проф. Юрьев Ю.Ю.', 85, 'Юридический анализ', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1032978), (SELECT id FROM competition WHERE name = 'Всероссийский чемпионат по юриспруденции'), 'RUS', 'PART', 2024, NULL, NULL, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1032978), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'REG', 'DIP', 2023, 'Доц. Социалов С.С.', 78, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1032978), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'INT', 'DIQ', 2025, NULL, NULL, 'Техническая ошибка', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033000), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'INT', 'WIN', 2025, 'Проф. Биологов Б.Б.', 96, 'Биотехнологии', FALSE),
	((SELECT id FROM student WHERE card_number = 1033000), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'UNI', 'PRIZE', 2024, NULL, 87, NULL, TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033022), (SELECT id FROM competition WHERE name = 'Региональный турнир по истории'), 'REG', 'PART', 2023, NULL, NULL, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1033022), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'RUS', 'DIP', 2024, 'Доц. Психологова П.П.', 80, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1033022), (SELECT id FROM competition WHERE name = 'Международный чемпионат по программированию'), 'INT', 'WIN', 2025, NULL, 93, 'Командная работа', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033044), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'UNI', 'DIQ', 2023, NULL, NULL, 'Плагиат', TRUE),
	((SELECT id FROM student WHERE card_number = 1033044), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'PRIZE', 2024, 'Проф. Лингвистов Л.Л.', 84, NULL, TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033066), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'WIN', 2024, NULL, 90, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1033066), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'RUS', 'PART', 2023, 'Доц. Математиков М.М.', NULL, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1033066), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'INT', 'DIP', 2025, NULL, 76, NULL, FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033088), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'REG', 'DIQ', 2024, 'Доц. Математиков М.М.', NULL, 'Биотехнологии', TRUE),
	((SELECT id FROM student WHERE card_number = 1033088), (SELECT id FROM competition WHERE name = 'Всероссийский чемпионат по юриспруденции'), 'REG', 'DIQ', 2023, 'Доц. Громова Е.Е.', 80, 'Интересное исследование', TRUE), 
	((SELECT id FROM student WHERE card_number = 1033088), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'REG', 'DIP', 2022, 'Доц. Социалов С.С.', 80, 'Экологический проект', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033110), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'UNI', 'DIP', 2023, 'Проф. Сидорова А.А.', NULL, 'Нарушение времени', TRUE),
	((SELECT id FROM student WHERE card_number = 1033110), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'REG', 'WIN', 2024, 'Доц. Козлов В.В.', 77, 'Глобальный проект', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033132), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'RUS', 'PART', 2023, 'Доц. Козлов В.В.', 92, 'Нарушение времени', TRUE),
	((SELECT id FROM student WHERE card_number = 1033132), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'RUS', 'DIQ', 2024, 'Проф. Экономистов Э.Э.', 72, 'Отличный алгоритм', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033154), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'UNI', 'WIN', 2022, 'Доц. Математиков М.М.', NULL, 'Интересное исследование', TRUE), 
	((SELECT id FROM student WHERE card_number = 1033154), (SELECT id FROM competition WHERE name = 'Всероссийский чемпионат по юриспруденции'), 'UNI', 'DIQ', 2025, 'Доц. Петров П.П.', NULL, 'Техническая ошибка', FALSE),
	((SELECT id FROM student WHERE card_number = 1033154), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'INT', 'PRIZE', 2022, 'Проф. Юрьев Ю.Ю.', 79, 'Экономическая модель', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033176), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'UNI', 'DIP', 2022, 'Проф. Юрьев Ю.Ю.', NULL, 'Выдающееся решение задач', TRUE),
	((SELECT id FROM student WHERE card_number = 1033176), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'PRIZE', 2022, 'Доц. Козлов В.В.', 94, 'Техническая ошибка', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033198), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'REG', 'DIQ', 2025, NULL, 90, NULL, FALSE),
	((SELECT id FROM student WHERE card_number = 1033198), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'UNI', 'WIN', 2024, 'Проф. Лингвистов Л.Л.', NULL, 'Активное участие', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033220), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'PART', 2025, NULL, 74, 'Экологический проект', FALSE),
	((SELECT id FROM student WHERE card_number = 1033220), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'REG', 'PART', 2024, 'Доц. Психологова П.П.', NULL, 'Нарушение времени', TRUE),
	((SELECT id FROM student WHERE card_number = 1033220), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'INT', 'PART', 2025, 'Доц. Громова Е.Е.', NULL, 'Отличный алгоритм', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033242), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'UNI', 'DIQ', 2025, 'Проф. Иванов И.И.', NULL, 'Нарушение времени', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033264), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'RUS', 'PART', 2025, 'Проф. Юрьев Ю.Ю.', NULL, 'Инновационный проект', FALSE),
	((SELECT id FROM student WHERE card_number = 1033264), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'INT', 'WIN', 2024, 'Доц. Исследователь И.И.', NULL, 'Экологический проект', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033286), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'REG', 'PART', 2024, 'Доц. Математиков М.М.', 100, 'Глобальный проект', TRUE),
	((SELECT id FROM student WHERE card_number = 1033286), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'INT', 'WIN', 2022, 'Доц. Психологова П.П.', NULL, 'Нарушение времени', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033308), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'RUS', 'WIN', 2025, 'Доц. Математиков М.М.', NULL, 'Выдающееся решение задач', FALSE),
	((SELECT id FROM student WHERE card_number = 1033308), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'UNI', 'DIP', 2023, 'Доц. Социалов С.С.', 90, 'Плагиат', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033330), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'REG', 'WIN', 2022, 'Проф. Иванов И.И.', 98, 'Командная работа', TRUE),
	((SELECT id FROM student WHERE card_number = 1033330), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'INT', 'PRIZE', 2023, NULL, 74, 'Интересное исследование', TRUE),
	((SELECT id FROM student WHERE card_number = 1033330), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'UNI', 'WIN', 2025, 'Доц. Козлов В.В.', NULL, 'Экономическая модель', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033352), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'RUS', 'PRIZE', 2024, 'Доц. Социалов С.С.', 82, 'Интересное исследование', TRUE),
	((SELECT id FROM student WHERE card_number = 1033352), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'PART', 2025, 'Проф. Биологов Б.Б.', 95, 'Интересное исследование', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033374), (SELECT id FROM competition WHERE name = 'Международный конкурс биотехнологий'), 'INT', 'WIN', 2023, 'Проф. Иванов И.И.', 75, 'Техническая ошибка', TRUE),
	((SELECT id FROM student WHERE card_number = 1033374), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'REG', 'DIP', 2022, 'Проф. Биологов Б.Б.', NULL, 'Экологический проект', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033396), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'RUS', 'PRIZE', 2022, 'Доц. Петров П.П.', 97, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1033396), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'UNI', 'PRIZE', 2023, 'Проф. Экономистов Э.Э.', NULL, 'Нарушение правил', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033418), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'DIP', 2025, 'Проф. Экономистов Э.Э.', NULL, 'Нарушение правил', FALSE),
	((SELECT id FROM student WHERE card_number = 1033418), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'RUS', 'PART', 2022, 'Доц. Исследователь И.И.', 70, 'Командная работа', TRUE),
	((SELECT id FROM student WHERE card_number = 1033418), (SELECT id FROM competition WHERE name = 'Международный чемпионат по программированию'), 'INT', 'PRIZE', 2024, 'Доц. Громова Е.Е.', NULL, 'Техническая ошибка', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033440), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'RUS', 'WIN', 2025, 'Проф. Сидорова А.А.', NULL, 'Юридический анализ', FALSE),
	((SELECT id FROM student WHERE card_number = 1033440), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'UNI', 'WIN', 2023, 'Доц. Социалов С.С.', 95, 'Интересное исследование', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033462), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'DIQ', 2024, 'Доц. Психологова П.П.', 80, 'Командная работа', TRUE),
	((SELECT id FROM student WHERE card_number = 1033462), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по радиофизике'), 'UNI', 'PRIZE', 2025, 'Проф. Экономистов Э.Э.', 97, 'Интересное исследование', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033484), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'RUS', 'PART', 2025, NULL, NULL, 'Нарушение времени', FALSE),
	((SELECT id FROM student WHERE card_number = 1033484), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'RUS', 'WIN', 2022, NULL, 71, 'Активное участие', TRUE),
	((SELECT id FROM student WHERE card_number = 1033484), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'UNI', 'PRIZE', 2023, 'Доц. Громова Е.Е.', 89, 'Техническая ошибка', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033506), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'INT', 'PRIZE', 2024, 'Проф. Юрьев Ю.Ю.', NULL, 'Экономическая модель', TRUE),
	((SELECT id FROM student WHERE card_number = 1033506), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'RUS', 'PRIZE', 2022, 'Проф. Иванов И.И.', 99, 'Плагиат', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033528), (SELECT id FROM competition WHERE name = 'Региональный турнир по истории'), 'UNI', 'WIN', 2022, 'Проф. Иванов И.И.', NULL, 'Плагиат', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033550), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'RUS', 'WIN', 2022, 'Проф. Экономистов Э.Э.', 92, 'Выдающееся решение задач', TRUE),
	((SELECT id FROM student WHERE card_number = 1033550), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'UNI', 'DIQ', 2023, 'Доц. Социалов С.С.', NULL, 'Экономическая модель', TRUE),
	((SELECT id FROM student WHERE card_number = 1033550), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'RUS', 'WIN', 2025, 'Доц. Психологова П.П.', 77, 'Выдающееся решение задач', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033572), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'UNI', 'DIQ', 2024, 'Проф. Юрьев Ю.Ю.', 87, 'Отличный алгоритм', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033594), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'UNI', 'DIQ', 2025, 'Проф. Сидорова А.А.', 96, 'Биотехнологии', FALSE),
	((SELECT id FROM student WHERE card_number = 1033594), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'REG', 'PART', 2025, 'Проф. Биологов Б.Б.', NULL, 'Экологический проект', FALSE),
	((SELECT id FROM student WHERE card_number = 1033594), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'INT', 'PART', 2023, 'Проф. Федоров Ф.Ф.', NULL, 'Нарушение правил', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033616), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'INT', 'DIP', 2022, 'Доц. Петров П.П.', 90, 'Отличный алгоритм', TRUE),
	((SELECT id FROM student WHERE card_number = 1033616), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'DIP', 2025, 'Доц. Исследователь И.И.', NULL, NULL, FALSE),
	((SELECT id FROM student WHERE card_number = 1033616), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'REG', 'DIP', 2025, 'Проф. Федоров Ф.Ф.', NULL, 'Плагиат', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033638), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'UNI', 'DIQ', 2022, 'Доц. Психологова П.П.', 99, 'Экологический проект', TRUE),
	((SELECT id FROM student WHERE card_number = 1033638), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'UNI', 'DIP', 2022, 'Проф. Иванов И.И.', NULL, 'Нарушение правил', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033660), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'INT', 'WIN', 2024, 'Доц. Громова Е.Е.', 74, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1033660), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'DIQ', 2025, 'Доц. Исследователь И.И.', NULL, 'Юридический анализ', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033682), (SELECT id FROM competition WHERE name = 'Региональный конкурс социальных наук'), 'RUS', 'PRIZE', 2024, 'Доц. Психологова П.П.', 95, 'Интересное исследование', TRUE),
	((SELECT id FROM student WHERE card_number = 1033682), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'REG', 'DIP', 2022, 'Доц. Исследователь И.И.', NULL, 'Активное участие', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033704), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'INT', 'WIN', 2024, 'Проф. Экономистов Э.Э.', NULL, 'Биотехнологии', TRUE),
	((SELECT id FROM student WHERE card_number = 1033704), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'UNI', 'PART', 2023, 'Проф. Федоров Ф.Ф.', 100, 'Активное участие', TRUE),
	((SELECT id FROM student WHERE card_number = 1033704), (SELECT id FROM competition WHERE name = 'Международный чемпионат по программированию'), 'UNI', 'DIP', 2022, 'Проф. Сидорова А.А.', 77, 'Инновационный проект', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033726), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'RUS', 'DIP', 2024, 'Доц. Петров П.П.', NULL, 'Нарушение правил', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033748), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс биологии'), 'INT', 'DIP', 2025, 'Проф. Лингвистов Л.Л.', 85, 'Юридический анализ', FALSE),
	((SELECT id FROM student WHERE card_number = 1033748), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'UNI', 'WIN', 2023, 'Проф. Федоров Ф.Ф.', 88, 'Техническая ошибка', TRUE),
	((SELECT id FROM student WHERE card_number = 1033748), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'RUS', 'WIN', 2024, 'Доц. Математиков М.М.', 79, 'Активное участие', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033770), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'INT', 'PRIZE', 2022, 'Доц. Петров П.П.', NULL, 'Плагиат', TRUE),
	((SELECT id FROM student WHERE card_number = 1033770), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'UNI', 'PART', 2024, 'Доц. Петров П.П.', NULL, 'Плагиат', TRUE),
	((SELECT id FROM student WHERE card_number = 1033770), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'UNI', 'DIQ', 2022, 'Проф. Федоров Ф.Ф.', 72, 'Выдающееся решение задач', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033792), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'WIN', 2022, 'Доц. Петров П.П.', 96, 'Юридический анализ', TRUE),
	((SELECT id FROM student WHERE card_number = 1033792), (SELECT id FROM competition WHERE name = 'Региональный хакатон по программированию'), 'UNI', 'DIQ', 2024, 'Доц. Социалов С.С.', NULL, 'Интересное исследование', TRUE),
	((SELECT id FROM student WHERE card_number = 1033792), (SELECT id FROM competition WHERE name = 'Внутривузовский чемпионат по физике'), 'REG', 'PART', 2024, 'Доц. Козлов В.В.', 71, 'Экологический проект', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033814), (SELECT id FROM competition WHERE name = 'Внутривузовский конкурс экономических проектов'), 'INT', 'PRIZE', 2025, 'Доц. Громова Е.Е.', 78, 'Активное участие', FALSE),
	((SELECT id FROM student WHERE card_number = 1033814), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'REG', 'DIQ', 2024, NULL, 89, 'Нарушение времени', TRUE),
	 
	((SELECT id FROM student WHERE card_number = 1033836), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'UNI', 'WIN', 2022, 'Проф. Юрьев Ю.Ю.', NULL, 'Биотехнологии', TRUE),
	((SELECT id FROM student WHERE card_number = 1033836), (SELECT id FROM competition WHERE name = 'Региональный турнир по истории'), 'REG', 'DIP', 2022, 'Доц. Математиков М.М.', NULL, 'Экономическая модель', TRUE),
	((SELECT id FROM student WHERE card_number = 1033836), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'REG', 'WIN', 2025, 'Проф. Экономистов Э.Э.', 99, 'Нарушение времени', FALSE),
	 
	((SELECT id FROM student WHERE card_number = 1033858), (SELECT id FROM competition WHERE name = 'Всероссийский турнир по психологии'), 'INT', 'PRIZE', 2024, 'Проф. Экономистов Э.Э.', NULL, 'Плагиат', TRUE),
	((SELECT id FROM student WHERE card_number = 1033858), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'INT', 'PRIZE', 2025, 'Доц. Громова Е.Е.', 73, 'Отличный алгоритм', FALSE),
	
	((SELECT id FROM student WHERE card_number = 1033880), (SELECT id FROM competition WHERE name = 'Всероссийская олимпиада по математике'), 'REG', 'DIP', 2024, 'Проф. Иванов И.И.', NULL, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1033880), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'REG', 'WIN', 2022, 'Доц. Исследователь И.И.', NULL, 'Юридический анализ', TRUE),
	((SELECT id FROM student WHERE card_number = 1033880), (SELECT id FROM competition WHERE name = 'Международный чемпионат по программированию'), 'RUS', 'DIQ', 2025, 'Доц. Исследователь И.И.', NULL, 'Нарушение правил', FALSE),
	
	((SELECT id FROM student WHERE card_number = 1033902), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'RUS', 'WIN', 2023, 'Проф. Биологов Б.Б.', 70, 'Нарушение времени', TRUE),
	((SELECT id FROM student WHERE card_number = 1033902), (SELECT id FROM competition WHERE name = 'Внутривузовский турнир по филологии'), 'UNI', 'DIP', 2023, 'Проф. Сидорова А.А.', 84, 'Экономическая модель', TRUE),
	((SELECT id FROM student WHERE card_number = 1033902), (SELECT id FROM competition WHERE name = 'Международная олимпиада по информатике'), 'UNI', 'WIN', 2024, 'Проф. Биологов Б.Б.', NULL, 'Командная работа', TRUE),
	
	((SELECT id FROM student WHERE card_number = 1033924), (SELECT id FROM competition WHERE name = 'Внутривузовский хакатон по информатике'), 'UNI', 'WIN', 2024, NULL, 92, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1033924), (SELECT id FROM competition WHERE name = 'Региональная олимпиада по экономике'), 'REG', 'PRIZE', 2023, 'Проф. Экономистов Э.Э.', 83, 'Экономическая модель', TRUE),
	((SELECT id FROM student WHERE card_number = 1033924), (SELECT id FROM competition WHERE name = 'Международный конкурс исторических исследований'), 'INT', 'PART', 2025, NULL, NULL, NULL, FALSE),
	
	((SELECT id FROM student WHERE card_number = 1039421), (SELECT id FROM competition WHERE name = 'Региональный конкурс иностранных языков'), 'REG', 'DIQ', 2024, NULL, NULL, 'Нарушение времени', TRUE),
	((SELECT id FROM student WHERE card_number = 1039421), (SELECT id FROM competition WHERE name = 'Всероссийский конкурс психологических исследований'), 'RUS', 'DIP', 2023, 'Доц. Исследователь И.И.', 79, NULL, TRUE),
	((SELECT id FROM student WHERE card_number = 1039421), (SELECT id FROM competition WHERE name = 'Международный хакатон по экологии'), 'INT', 'WIN', 2025, NULL, 94, 'Глобальный проект', FALSE);

--rollback DELETE FROM participation;
