import React, { useState, useEffect, useRef } from "react";

export default function ParticipationForm({ participation, onSave, onCancel }) {
  const [form, setForm] = useState({
    studentId: "",
    studentText: "",
    competitionId: "",
    competitionText: "",
    levelCode: "",
    levelText: "",
    resultCode: "",
    resultText: "",
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
  const [suggestions, setSuggestions] = useState({ student: [], competition: [], level: [], result: [] });
  const [activeSuggestion, setActiveSuggestion] = useState(null);

  const studentRef = useRef(null);
  const competitionRef = useRef(null);
  const levelRef = useRef(null);
  const resultRef = useRef(null);

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

  useEffect(() => {
    if (!participation) return;
    if (students.length === 0 || competitions.length === 0 || levels.length === 0 || results.length === 0) return;

    const studentObj = students.find(s => s.id === participation.student?.id);
    const competitionObj = competitions.find(c => c.id === participation.competition?.id);
    const levelObj = levels.find(l => l.code === participation.level?.code);
    const resultObj = results.find(r => r.code === participation.result?.code);

    setForm({
      studentId: studentObj?.id || "",
      studentText: studentObj ? `${studentObj.surname} ${studentObj.name} ${studentObj.middleName || ""} (${studentObj.cardNumber})` : "",
      competitionId: competitionObj?.id || "",
      competitionText: competitionObj?.name || "",
      levelCode: levelObj?.code || "",
      levelText: levelObj?.name || "",
      resultCode: resultObj?.code || "",
      resultText: resultObj?.name || "",
      year: participation.year || new Date().getFullYear(),
      points: participation.points ?? "",
      supervisor: participation.supervisor || "",
      description: participation.description || "",
    });
  }, [participation, students, competitions, levels, results]);

  useEffect(() => {
    const handleClickOutside = (e) => {
      if (
        studentRef.current && !studentRef.current.contains(e.target) &&
        competitionRef.current && !competitionRef.current.contains(e.target) &&
        levelRef.current && !levelRef.current.contains(e.target) &&
        resultRef.current && !resultRef.current.contains(e.target)
      ) {
        setActiveSuggestion(null);
      }
    };
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const handleInput = (field, value, list) => {
    setForm({ ...form, [`${field}Text`]: value, [`${field}Code`]: "", [`${field}Id`]: "" });

    if (value.length > 0) {
      const filtered = list.filter(item => {
        if (field === "student") {
          const text = `${item.surname} ${item.name} ${item.middleName || ""} (${item.cardNumber})`;
          return text.toLowerCase().includes(value.toLowerCase());
        } else {
          return item.name.toLowerCase().includes(value.toLowerCase());
        }
      });
      setSuggestions({ ...suggestions, [field]: filtered });
      setActiveSuggestion(field);
    } else {
      setSuggestions({ ...suggestions, [field]: [] });
      setActiveSuggestion(null);
    }
  };

  const selectItem = (field, item) => {
    if (field === "student") {
      setForm({
        ...form,
        studentId: item.id,
        studentText: `${item.surname} ${item.name} ${item.middleName || ""} (${item.cardNumber})`,
      });
    } else if (field === "competition") {
      setForm({ ...form, competitionId: item.id, competitionText: item.name });
    } else if (field === "level") {
      setForm({ ...form, levelCode: item.code, levelText: item.name });
    } else if (field === "result") {
      setForm({ ...form, resultCode: item.code, resultText: item.name });
    }
    setSuggestions({ ...suggestions, [field]: [] });
    setActiveSuggestion(null);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const newErrors = {};
    if (!form.studentId) newErrors.student = "Выберите студента";
    if (!form.competitionId) newErrors.competition = "Выберите соревнование";
    if (!form.levelCode) newErrors.level = "Выберите уровень";
    if (!form.resultCode) newErrors.result = "Выберите результат";

    if (Object.keys(newErrors).length > 0) {
      setErrors(newErrors);
      return;
    }

    const payload = {
      student: form.studentId,
      competition: form.competitionId,
      level: form.levelCode,
      result: form.resultCode,
      year: parseInt(form.year),
      points: form.points !== "" ? parseFloat(form.points) : null,
      supervisor: form.supervisor || null,
      description: form.description || null,
    };

    if (participation?.id) payload.id = participation.id;

    onSave(payload);
  };

  const inputStyle = { width: "100%", padding: "8px 10px", border: "1px solid #ccc", borderRadius: "4px", fontSize: "0.95rem", boxSizing: "border-box" };
  const suggestionBoxStyle = { position: "absolute", top: "100%", left: 0, right: 0, maxHeight: "200px", overflowY: "auto", backgroundColor: "#fff", border: "1px solid #ccc", borderTop: "none", zIndex: 1000 };
  const suggestionItemStyle = { padding: "8px 10px", cursor: "pointer" };

  return (
    <div className="modal-overlay">
      <div className="modal-window large">
        <div className="modal-header">
          <h3>{participation ? "Редактирование участия" : "Новое участие"}</h3>
          <button className="modal-close" onClick={onCancel}>×</button>
        </div>
        <form className="modal-body" onSubmit={handleSubmit}>
          {/* Студент */}
          <div className="form-row" ref={studentRef} style={{ position: "relative" }}>
            <label>Студент*</label>
            <input type="text" value={form.studentText} onChange={(e) => handleInput("student", e.target.value, students)} disabled={isBlocked} style={inputStyle} />
            {errors.student && <p style={{ color: "red" }}>{errors.student}</p>}
            {activeSuggestion === "student" && suggestions.student.length > 0 && (
              <div style={suggestionBoxStyle}>
                {suggestions.student.map(s => (
                  <div key={s.id} style={suggestionItemStyle} onClick={() => selectItem("student", s)}>
                    {s.surname} {s.name} {s.middleName || ""} ({s.cardNumber})
                  </div>
                ))}
              </div>
            )}
          </div>

          <div className="form-row" ref={competitionRef} style={{ position: "relative" }}>
            <label>Соревнование*</label>
            <input type="text" value={form.competitionText} onChange={(e) => handleInput("competition", e.target.value, competitions)} disabled={isBlocked} style={inputStyle} />
            {errors.competition && <p style={{ color: "red" }}>{errors.competition}</p>}
            {activeSuggestion === "competition" && suggestions.competition.length > 0 && (
              <div style={suggestionBoxStyle}>
                {suggestions.competition.map(c => (
                  <div key={c.id} style={suggestionItemStyle} onClick={() => selectItem("competition", c)}>
                    {c.name}
                  </div>
                ))}
              </div>
            )}
          </div>

          <div className="form-row two-cols">
            <div ref={levelRef} style={{ position: "relative" }}>
              <label>Уровень*</label>
              <input type="text" value={form.levelText} onChange={(e) => handleInput("level", e.target.value, levels)} disabled={isBlocked} style={inputStyle} />
              {errors.level && <p style={{ color: "red" }}>{errors.level}</p>}
              {activeSuggestion === "level" && suggestions.level.length > 0 && (
                <div style={suggestionBoxStyle}>
                  {suggestions.level.map(l => (
                    <div key={l.code} style={suggestionItemStyle} onClick={() => selectItem("level", l)}>
                      {l.name}
                    </div>
                  ))}
                </div>
              )}
            </div>
            <div ref={resultRef} style={{ position: "relative" }}>
              <label>Результат*</label>
              <input type="text" value={form.resultText} onChange={(e) => handleInput("result", e.target.value, results)} disabled={isBlocked} style={inputStyle} />
              {errors.result && <p style={{ color: "red" }}>{errors.result}</p>}
              {activeSuggestion === "result" && suggestions.result.length > 0 && (
                <div style={suggestionBoxStyle}>
                  {suggestions.result.map(r => (
                    <div key={r.code} style={suggestionItemStyle} onClick={() => selectItem("result", r)}>
                      {r.name}
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>

          <div className="form-row three-cols">
            <div>
              <label>Год</label>
              <input type="number" value={form.year} onChange={(e) => setForm({ ...form, year: e.target.value })} disabled={isBlocked} />
            </div>
            <div>
              <label>Баллы</label>
              <input type="number" step="0.1" value={form.points} onChange={(e) => setForm({ ...form, points: e.target.value })} disabled={isBlocked} />
            </div>
            <div>
              <label>Руководитель</label>
              <input value={form.supervisor} onChange={(e) => setForm({ ...form, supervisor: e.target.value })} disabled={isBlocked} />
            </div>
          </div>

          <div className="form-row">
            <label>Описание</label>
            <textarea value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} disabled={isBlocked} />
          </div>

          <div className="modal-footer" style={{ display: "flex", justifyContent: "flex-end", gap: "10px" }}>
            <button type="submit" className="btn btn-primary">Сохранить</button>
            <button type="button" className="btn btn-secondary" onClick={onCancel}>Отмена</button>
          </div>
        </form>
      </div>
    </div>
  );
}
