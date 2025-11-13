--liquibase formatted sql

--changeset a.slelin:007-create-trigger-update_at

CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS '
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER trg_level_updated_at
BEFORE UPDATE ON level
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trg_result_updated_at
BEFORE UPDATE ON result
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trg_student_updated_at
BEFORE UPDATE ON student
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trg_competition_updated_at
BEFORE UPDATE ON competition
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER trg_participation_updated_at
BEFORE UPDATE ON participation
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

--rollback DROP TRIGGER IF EXISTS trg_level_updated_at ON level;
--rollback DROP TRIGGER IF EXISTS trg_result_updated_at ON result;
--rollback DROP TRIGGER IF EXISTS trg_student_updated_at ON student;
--rollback DROP TRIGGER IF EXISTS trg_competition_updated_at ON competition;
--rollback DROP TRIGGER IF EXISTS trg_participation_updated_at ON participation;
--rollback DROP FUNCTION IF EXISTS update_timestamp;
