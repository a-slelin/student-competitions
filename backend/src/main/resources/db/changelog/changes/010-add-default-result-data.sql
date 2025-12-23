--liquibase formatted sql

--changeset a.slelin:010-add-default-result-data

INSERT INTO result (code, name, sort_order) VALUES
	('WIN', 'Победитель', 1),
	('PRIZE', 'Призер', 2),
	('PART', 'Участник', 3),
	('DIP', 'Дипломант', 4),
	('DIQ', 'Дисквалифицирован', 5);

--rollback DELETE FROM result;
