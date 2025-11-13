--liquibase formatted sql

--changeset a.slelin:012-add-default-competition-data

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

--rollback DELETE FROM competition;