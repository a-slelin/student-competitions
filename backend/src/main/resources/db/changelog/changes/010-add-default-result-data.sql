--liquibase formatted sql

--changeset a.slelin:010-add-default-result-data

INSERT INTO result (code, name, sort_order) VALUES
('WIN', 'Победитель', 1),
('PRIZE', 'Призер', 2),
('PART', 'Участник', 3),
('DIQ', 'Дисквалифицирован', 4),
('DIP', 'Дипломант', 5);

--rollback DELETE FROM result;