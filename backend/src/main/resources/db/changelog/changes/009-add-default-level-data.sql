--liquibase formatted sql

--changeset a.slelin:009-add-default-level-data

INSERT INTO level (code, name, sort_order) VALUES
	('UNI', 'Внутривузовский уровень', 1),
	('REG', 'Региональный уровень', 2),
	('RUS', 'Всероссийский уровень', 3),
	('INT', 'Международный уровень', 4);

--rollback DELETE FROM level;
