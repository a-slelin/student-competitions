--liquibase formatted sql

--changeset a.slelin:006-create-trigger-block-edit

CREATE OR REPLACE FUNCTION prevent_blocked_update()
RETURNS TRIGGER AS '
BEGIN
    IF OLD.is_blocked = TRUE THEN
        RAISE EXCEPTION ''Редактирование записи заблокировано по регламенту'';
    END IF;
    RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_blocked_update
BEFORE UPDATE ON participation
FOR EACH ROW
EXECUTE FUNCTION prevent_blocked_update();

--rollback DROP TRIGGER IF EXISTS trg_prevent_blocked_update ON participation;
--rollback DROP FUNCTION IF EXISTS prevent_blocked_update;