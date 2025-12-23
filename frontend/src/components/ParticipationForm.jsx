import React, { useState, useEffect, useRef } from "react";

export default function ParticipationForm({ participation, onSave, onCancel }) {
  const [form, setForm] = useState({
    studentId: "",
    studentText: "",
    competitionId: "",
    competitionText: "",
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
  const [suggestions, setSuggestions] = useState({ student: [], competition: [] });
  const [activeSuggestion, setActiveSuggestion] = useState(null);

  const studentRef = useRef(null);
  const competitionRef = useRef(null);

  const isBlocked = participation?.isBlocked || false;

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
        fetchData("/api/results"),
      ]);
      setStudents(s);
      setCompetitions(c);
      setLevels(l);
      setResults(r);
    }

    loadAllDicts();
  }, []);

  // Заполняем форму при редактировании
  useEffect(() => {
    if (participation) {
      setForm({
        studentId: participation.studentId || participation.student?.id || "",
        studentText: participation.studentName || (participation.student ? `${participation.student.surname} ${participation.student.name}` : ""),
        competitionId: participation.competitionId || participation.competition?.id || "",
        competitionText: participation.competitionName || (participation.competition ? participation.competition.name : ""),
        levelCode: participation.levelCode || participation.level?.code || "",
        resultCode: participation.resultCode || participation.result?.code || "",
        year: participation.year || new Date().getFullYear(),
        points: participation.points ?? "",
        supervisor: participation.supervisor || "",
        description: participation.description || "",
      });
    }
  }, [participation]);

  useEffect(() => {
    const handleClickOutside = (e) => {
      if (
        studentRef.current && !studentRef.current.contains(e.target) &&
        competitionRef.current && !competitionRef.current.contains(e.target)
      ) {
        setActiveSuggestion(null);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const handleInput = (field, value, list, keyId, keyName) => {
    setForm({ ...form, [`${field}Text`]: value, [`${field}Id`]: "" });
    if (value.length > 0) {
      const filtered = list.filter(item =>
        `${item[keyName]}`.toLowerCase().includes(value.toLowerCase())
      );
      setSuggestions({ ...suggestions, [field]: filtered });
      setActiveSuggestion(field);
    } else {
      setSuggestions({ ...suggestions, [field]: [] });
      setActiveSuggestion(null);
    }
  };

  const selectItem = (field, item, keyId, keyName) => {
    setForm({
      ...form,
      [`${field}Id`]: item[keyId],
      [`${field}Text`]: `${item.surname || ""} ${item.name || item.name || ""}`.trim() || item[keyName],
    });
    setSuggestions({ ...suggestions, [field]: [] });
    setActiveSuggestion(null);
  };

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

  const inputStyle = {
    width: "100%",
    padding: "8px 10px",
    border: "1px solid #ccc",
    borderRadius: "4px",
    fontSize: "0.95rem",
    boxSizing: "border-box",
  };

  const suggestionBoxStyle = {
    position: "absolute",
    top: "100%",
    left: 0,
    right: 0,
    maxHeight: "200px",
    overflowY: "auto",
    backgroundColor: "#fff",
    border: "1px solid #ccc",
    borderTop: "none",
    zIndex: 1000,
  };

  const suggestionItemStyle = {
    padding: "8px 10px",
    cursor: "pointer",
  };

  return (
    <div className="modal-overlay">
      <div className="modal-window large">
        <div className="modal-header">
          <h3>{participation ? "Редактирование участия" : "Новое участие"}</h3>
          <button className="modal-close" onClick={onCancel}>×</button>
        </div>

        <form className="modal-body" onSubmit={handleSubmit}>
          {errors.general && <p style={{ color: "red" }}>{errors.general}</p>}

          {/* Студент */}
          <div className="form-row" ref={studentRef} style={{ position: "relative" }}>
            <label>Студент*</label>
            <input
              type="text"
              value={form.studentText}
              onChange={(e) => handleInput("student", e.target.value, students, "id", "surname")}
              disabled={isBlocked}
              required
              style={inputStyle}
            />
            {activeSuggestion === "student" && suggestions.student.length > 0 && (
              <div style={suggestionBoxStyle}>
                {suggestions.student.map((s) => (
                  <div
                    key={s.id}
                    style={suggestionItemStyle}
                    onClick={() => selectItem("student", s, "id", "surname")}
                  >
                    {s.surname} {s.name} {s.middleName || ""}
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* Соревнование */}
          <div className="form-row" ref={competitionRef} style={{ position: "relative" }}>
            <label>Соревнование*</label>
            <input
              type="text"
              value={form.competitionText}
              onChange={(e) => handleInput("competition", e.target.value, competitions, "id", "name")}
              disabled={isBlocked}
              required
              style={inputStyle}
            />
            {activeSuggestion === "competition" && suggestions.competition.length > 0 && (
              <div style={suggestionBoxStyle}>
                {suggestions.competition.map((c) => (
                  <div
                    key={c.id}
                    style={suggestionItemStyle}
                    onClick={() => selectItem("competition", c, "id", "name")}
                  >
                    {c.name}
                  </div>
                ))}
              </div>
            )}
          </div>

          {/* Уровень и Результат */}
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

          {/* Год, Баллы, Руководитель */}
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

          {/* Описание */}
          <div className="form-row">
            <label>Описание</label>
            <textarea
              value={form.description}
              onChange={(e) => setForm({ ...form, description: e.target.value })}
              disabled={isBlocked}
            />
          </div>

          <div className="modal-footer">
            <button type="button" className="btn btn-secondary" onClick={onCancel}>Отмена</button>
            {!isBlocked && <button type="submit" className="btn btn-primary">Сохранить</button>}
          </div>
        </form>
      </div>
    </div>
  );
}
