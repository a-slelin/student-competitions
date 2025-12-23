import React, { useState, useEffect } from "react";

export default function ParticipationForm({ participation, onSave, onCancel }) {
  const [form, setForm] = useState({
    studentId: "",
    competitionId: "",
    levelCode: "",
    resultCode: "",
    year: new Date().getFullYear(),
    points: "",
    supervisor: "",
    description: "",
  });

  const [students, setStudents] = useState([]);
  const [competitions, setCompetitions] = useState([]);
  const [levels, setLevels] = useState([]);
  const [results, setResults] = useState([]);
  const [errors, setErrors] = useState({});

  const isBlocked = participation?.isBlocked || false;

  const extractId = (val) => {
    if (!val) return "";
    if (typeof val === "string") return val.includes("/") ? val.split("/").pop() : val;
    if (typeof val === "object" && val.id) return val.id;
    return "";
  };

  useEffect(() => {
    const fetchData = async (url) => {
      try {
        const res = await fetch(url);
        if (!res.ok) throw new Error(`Ошибка ${res.status}`);
        const data = await res.json();
        return data?.content || (Array.isArray(data) ? data : []);
      } catch (e) {
        console.error(`Не удалось загрузить данные из ${url}:`, e);
        return [];
      }
    };

    async function loadAllDicts() {
      const [s, c, l, r] = await Promise.all([
        fetchData("/api/students?size=1000"),
        fetchData("/api/competitions?size=1000"),
        fetchData("/api/levels"),
        fetchData("/api/results")
      ]);
      setStudents(s);
      setCompetitions(c);
      setLevels(l);
      setResults(r);
    }

    loadAllDicts();
  }, []);

  useEffect(() => {
    if (participation) {
      setForm({
        studentId: extractId(participation.student),
        competitionId: extractId(participation.competition),
        levelCode: extractId(participation.level),
        resultCode: extractId(participation.result),
        year: participation.year || "",
        points: participation.points ?? "",
        supervisor: participation.supervisor || "",
        description: participation.description || "",
      });
    }
  }, [participation]);

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!form.studentId || !form.competitionId) {
      setErrors({ general: "Выберите студента и соревнование" });
      return;
    }

    const payload = {
      student: form.studentId,
      competition: form.competitionId,
      level: form.levelCode || null,
      result: form.resultCode || null,
      year: parseInt(form.year),
      points: form.points !== "" ? parseFloat(form.points) : null,
      supervisor: form.supervisor || null,
      description: form.description || null,
    };

    if (participation?.id) payload.id = participation.id;

    onSave(payload);
  };

  return (
    <div className="modal-overlay">
      <div className="modal-window large">
        <div className="modal-header">
          <h3>{participation ? "Редактирование участия" : "Новое участие"}</h3>
          <button className="modal-close" onClick={onCancel}>×</button>
        </div>

        <form className="modal-body" onSubmit={handleSubmit}>
          {errors.general && <p style={{ color: "red", fontSize: "0.9rem" }}>{errors.general}</p>}

          <div className="form-row">
            <label>Студент*</label>
            <select
              value={form.studentId}
              onChange={(e) => setForm({ ...form, studentId: e.target.value })}
              disabled={isBlocked}
              required
            >
              <option value="">-- Выберите студента --</option>
              {students.map((s) => (
                <option key={s.id} value={s.id}>
                  {s.surname} {s.name} {s.middleName || ""}
                </option>
              ))}
            </select>
          </div>

          <div className="form-row">
            <label>Соревнование*</label>
            <select
              value={form.competitionId}
              onChange={(e) => setForm({ ...form, competitionId: e.target.value })}
              disabled={isBlocked}
              required
            >
              <option value="">-- Выберите соревнование --</option>
              {competitions.map((c) => (
                <option key={c.id} value={c.id}>{c.name}</option>
              ))}
            </select>
          </div>

          <div className="form-row two-cols">
            <div>
              <label>Уровень</label>
              <select
                value={form.levelCode}
                onChange={(e) => setForm({ ...form, levelCode: e.target.value })}
                disabled={isBlocked}
              >
                <option value="">-- Не указан --</option>
                {levels.map((l) => (
                  <option key={l.code || l.id} value={l.code || l.id}>{l.name}</option>
                ))}
              </select>
            </div>

            <div>
              <label>Результат</label>
              <select
                value={form.resultCode}
                onChange={(e) => setForm({ ...form, resultCode: e.target.value })}
                disabled={isBlocked}
              >
                <option value="">-- Не указан --</option>
                {results.map((r) => (
                  <option key={r.code || r.id} value={r.code || r.id}>{r.name}</option>
                ))}
              </select>
            </div>
          </div>

          <div className="form-row three-cols">
            <div>
              <label>Год</label>
              <input
                type="number"
                value={form.year}
                onChange={(e) => setForm({ ...form, year: e.target.value })}
                disabled={isBlocked}
              />
            </div>
            <div>
              <label>Баллы</label>
              <input
                type="number"
                step="0.1"
                value={form.points}
                onChange={(e) => setForm({ ...form, points: e.target.value })}
                disabled={isBlocked}
              />
            </div>
            <div>
              <label>Руководитель</label>
              <input
                value={form.supervisor}
                onChange={(e) => setForm({ ...form, supervisor: e.target.value })}
                disabled={isBlocked}
              />
            </div>
          </div>

          <div className="form-row">
            <label>Описание</label>
            <textarea
              value={form.description}
              onChange={(e) => setForm({ ...form, description: e.target.value })}
              disabled={isBlocked}
            />
          </div>

          <div className="modal-footer">
            <button type="button" className="btn btn-secondary" onClick={onCancel}>
              Отмена
            </button>
            {!isBlocked && <button type="submit" className="btn btn-primary">Сохранить</button>}
          </div>
        </form>
      </div>
    </div>
  );
}
