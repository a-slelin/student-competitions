--liquibase formatted sql

--changeset a.slelin:005-create-table-participation

CREATE TABLE participation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    student_id UUID NOT NULL,
    competition_id UUID NOT NULL,
    level_code VARCHAR(20) NOT NULL,
    result_code VARCHAR(20) NOT NULL,
    year INTEGER NOT NULL
        CHECK(year >= 0),
    supervisor VARCHAR(100),
    points INTEGER
        CHECK (points IS NULL OR points >= 0),
    description TEXT
        CHECK (description IS NULL OR LENGTH(TRIM(description)) > 0),
    is_blocked BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_participation_student FOREIGN KEY (student_id)
        REFERENCES student(id) ON DELETE RESTRICT,
    CONSTRAINT fk_participation_competition FOREIGN KEY (competition_id)
        REFERENCES competition(id) ON DELETE RESTRICT,
    CONSTRAINT fk_participation_level FOREIGN KEY (level_code)
        REFERENCES level(code) ON DELETE RESTRICT,
    CONSTRAINT fk_participation_result FOREIGN KEY (result_code)
        REFERENCES result(code) ON DELETE RESTRICT,

    CONSTRAINT uq_participation UNIQUE (student_id, competition_id, year)
);

--rollback DROP TABLE IF EXISTS participation