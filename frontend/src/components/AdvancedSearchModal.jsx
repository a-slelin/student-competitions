import React, { useState, useEffect, useRef } from "react";

export default function AdvancedSearchModal({ onSearch, onCancel }) {
  const [form, setForm] = useState({
    studentId: "",
    studentText: "",
    competitionId: "",
    competitionText: "",
    levelId: "",
    levelText: "",
    resultId: "",
    resultText: "",
    yearType: "exact",
    yearExact: "",
    yearFrom: "",
    yearTo: "",
    pointsType: "exact",
    pointsExact: "",
    pointsFrom: "",
    pointsTo: "",
    supervisor: "",
  });

  const [students, setStudents] = useState([]);
  const [competitions, setCompetitions] = useState([]);
  const [levels, setLevels] = useState([]);
  const [results, setResults] = useState([]);
  const [suggestions, setSuggestions] = useState({ student: [], competition: [], level: [], result: [] });
  const [activeSuggestion, setActiveSuggestion] = useState(null);

  const studentRef = useRef(null);
  const competitionRef = useRef(null);
  const levelRef = useRef(null);
  const resultRef = useRef(null);

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
      [`${field}Id`]: item[keyId] || item.code,
      [`${field}Text`]: item[keyName] || item.name
    });
    setSuggestions({ ...suggestions, [field]: [] });
    setActiveSuggestion(null);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const filters = [];

    if (form.studentId) filters.push({ field: "student.id", operation: "equals", value: form.studentId });
    if (form.competitionId) filters.push({ field: "competition.id", operation: "equals", value: form.competitionId });
    if (form.levelId) filters.push({ field: "level.code", operation: "equals", value: form.levelId });
    if (form.resultId) filters.push({ field: "result.code", operation: "equals", value: form.resultId });

    // Год
    if (form.yearType === "exact" && form.yearExact) {
      filters.push({ field: "year", operation: "equals", value: parseInt(form.yearExact) });
    } else if (form.yearType === "range") {
      if (form.yearFrom && form.yearTo) filters.push({ field: "year", operation: "between", value: parseInt(form.yearFrom), value2: parseInt(form.yearTo) });
      else if (form.yearFrom) filters.push({ field: "year", operation: "greater or equals", value: parseInt(form.yearFrom) });
      else if (form.yearTo) filters.push({ field: "year", operation: "less or equals", value: parseInt(form.yearTo) });
    }

    // Баллы
    if (form.pointsType === "exact" && form.pointsExact) filters.push({ field: "points", operation: "equals", value: parseFloat(form.pointsExact) });
    else if (form.pointsType === "range") {
      if (form.pointsFrom && form.pointsTo) filters.push({ field: "points", operation: "between", value: parseFloat(form.pointsFrom), value2: parseFloat(form.pointsTo) });
      else if (form.pointsFrom) filters.push({ field: "points", operation: "greater or equals", value: parseFloat(form.pointsFrom) });
      else if (form.pointsTo) filters.push({ field: "points", operation: "less or equals", value: parseFloat(form.pointsTo) });
    }

    if (form.supervisor) filters.push({ field: "supervisor", operation: "like", value: form.supervisor });

    onSearch(filters);
  };

  const handleReset = () => {
    setForm({
      studentId: "", studentText: "",
      competitionId: "", competitionText: "",
      levelId: "", levelText: "",
      resultId: "", resultText: "",
      yearType: "exact", yearExact: "", yearFrom: "", yearTo: "",
      pointsType: "exact", pointsExact: "", pointsFrom: "", pointsTo: "",
      supervisor: "",
    });
    setSuggestions({ student: [], competition: [], level: [], result: [] });
    setActiveSuggestion(null);
  };

  const inputStyle = {
    width: "100%",
    padding: "10px 12px",
    border: "1px solid #d0d0d0",
    borderRadius: "4px",
    fontSize: "0.95rem",
    backgroundColor: "#fff",
    boxSizing: "border-box"
  };

  const suggestionBoxStyle = {
    position: "absolute",
    top: "100%",
    left: 0,
    right: 0,
    maxHeight: "200px",
    overflowY: "auto",
    backgroundColor: "#fff",
    border: "1px solid #d0d0d0",
    borderTop: "none",
    borderRadius: "0 0 4px 4px",
    zIndex: 1000,
    boxShadow: "0 4px 12px rgba(0,0,0,0.15)"
  };

  const suggestionItemStyle = {
    padding: "10px 12px",
    cursor: "pointer",
    borderBottom: "1px solid #f0f0f0",
    fontSize: "0.95rem"
  };

  return (
    <div className="modal-overlay" onClick={onCancel} style={{ backgroundColor: "rgba(0,0,0,0.5)", position: "fixed", inset: 0, display: "flex", justifyContent: "center", alignItems: "center", zIndex: 2000 }}>
      <div 
        className="modal-content" 
        onClick={(e) => e.stopPropagation()}
        style={{ 
          maxWidth: "800px", 
          width: "95%",
          maxHeight: "90vh",
          overflowY: "auto",
          backgroundColor: "#fff",
          borderRadius: "10px",
          padding: "25px",
          boxShadow: "0 12px 25px rgba(0,0,0,0.25)",
        }}
      >
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: "25px" }}>
          <h2 style={{ margin: 0, fontSize: "1.6rem", fontWeight: 600 }}>Расширенный поиск</h2>
          <button onClick={onCancel} style={{ background: "none", border: "none", fontSize: "1.6rem", cursor: "pointer", color: "#666" }}>✕</button>
        </div>

        <form onSubmit={handleSubmit} style={{ display: "grid", gap: "20px" }}>
          {/* Студент и соревнование */}
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: "20px" }}>
            <div ref={studentRef} style={{ position: "relative" }}>
              <label style={{ marginBottom: "6px", fontWeight: 500 }}>Студент</label>
              <input type="text" placeholder="Введите фамилию или имя" value={form.studentText} onChange={(e) => handleInput("student", e.target.value, students, "id", "surname")} onFocus={() => form.studentText && setActiveSuggestion("student")} style={inputStyle} />
              {activeSuggestion === "student" && suggestions.student.length > 0 && (
                <div style={suggestionBoxStyle}>
                  {suggestions.student.map((s) => (
                    <div key={s.id} style={suggestionItemStyle} onClick={() => selectItem("student", s, "id", "surname")} onMouseEnter={(e)=> e.target.style.backgroundColor="#f5f5f5"} onMouseLeave={(e)=> e.target.style.backgroundColor="#fff"}>{s.surname} {s.name}</div>
                  ))}
                </div>
              )}
            </div>

            <div ref={competitionRef} style={{ position: "relative" }}>
              <label style={{ marginBottom: "6px", fontWeight: 500 }}>Соревнование</label>
              <input type="text" placeholder="Введите название соревнования" value={form.competitionText} onChange={(e) => handleInput("competition", e.target.value, competitions, "id", "name")} onFocus={() => form.competitionText && setActiveSuggestion("competition")} style={inputStyle} />
              {activeSuggestion === "competition" && suggestions.competition.length > 0 && (
                <div style={suggestionBoxStyle}>
                  {suggestions.competition.map((c) => (
                    <div key={c.id} style={suggestionItemStyle} onClick={() => selectItem("competition", c, "id", "name")} onMouseEnter={(e)=> e.target.style.backgroundColor="#f5f5f5"} onMouseLeave={(e)=> e.target.style.backgroundColor="#fff"}>{c.name}</div>
                  ))}
                </div>
              )}
            </div>
          </div>

          {/* Уровень и результат */}
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: "20px" }}>
            <div ref={levelRef} style={{ position: "relative" }}>
              <label style={{ marginBottom: "6px", fontWeight: 500 }}>Уровень</label>
              <input type="text" placeholder="Введите уровень" value={form.levelText} onChange={(e) => handleInput("level", e.target.value, levels, "code", "name")} onFocus={() => form.levelText && setActiveSuggestion("level")} style={inputStyle} />
              {activeSuggestion === "level" && suggestions.level.length > 0 && (
                <div style={suggestionBoxStyle}>
                  {suggestions.level.map((l) => (
                    <div key={l.code || l.id} style={suggestionItemStyle} onClick={() => selectItem("level", l, "code", "name")} onMouseEnter={(e)=> e.target.style.backgroundColor="#f5f5f5"} onMouseLeave={(e)=> e.target.style.backgroundColor="#fff"}>{l.name}</div>
                  ))}
                </div>
              )}
            </div>

            <div ref={resultRef} style={{ position: "relative" }}>
              <label style={{ marginBottom: "6px", fontWeight: 500 }}>Результат</label>
              <input type="text" placeholder="Введите результат" value={form.resultText} onChange={(e) => handleInput("result", e.target.value, results, "code", "name")} onFocus={() => form.resultText && setActiveSuggestion("result")} style={inputStyle} />
              {activeSuggestion === "result" && suggestions.result.length > 0 && (
                <div style={suggestionBoxStyle}>
                  {suggestions.result.map((r) => (
                    <div key={r.code || r.id} style={suggestionItemStyle} onClick={() => selectItem("result", r, "code", "name")} onMouseEnter={(e)=> e.target.style.backgroundColor="#f5f5f5"} onMouseLeave={(e)=> e.target.style.backgroundColor="#fff"}>{r.name}</div>
                  ))}
                </div>
              )}
            </div>
          </div>

          {/* Год */}
          <div>
            <label style={{ marginBottom: "6px", fontWeight: 500 }}>Год</label>
            <div style={{ display: "flex", gap: "20px", marginBottom: "10px" }}>
              <label style={{ display: "flex", alignItems: "center", gap: "6px", cursor: "pointer" }}>
                <input type="radio" name="yearType" value="exact" checked={form.yearType==="exact"} onChange={(e)=>setForm({...form, yearType:e.target.value})}/> Точный
              </label>
              <label style={{ display: "flex", alignItems: "center", gap: "6px", cursor: "pointer" }}>
                <input type="radio" name="yearType" value="range" checked={form.yearType==="range"} onChange={(e)=>setForm({...form, yearType:e.target.value})}/> Диапазон
              </label>
            </div>
            {form.yearType==="exact" ? (
              <input type="number" placeholder="Введите год" value={form.yearExact} onChange={(e)=>setForm({...form, yearExact:e.target.value})} style={inputStyle}/>
            ):(
              <div style={{ display:"grid", gridTemplateColumns:"1fr auto 1fr", gap:"10px", alignItems:"center"}}>
                <input type="number" placeholder="От" value={form.yearFrom} onChange={(e)=>setForm({...form, yearFrom:e.target.value})} style={inputStyle}/>
                <span style={{color:"#666"}}>—</span>
                <input type="number" placeholder="До" value={form.yearTo} onChange={(e)=>setForm({...form, yearTo:e.target.value})} style={inputStyle}/>
              </div>
            )}
          </div>

          {/* Баллы */}
          <div>
            <label style={{ marginBottom:"6px", fontWeight:500 }}>Баллы</label>
            <div style={{ display:"flex", gap:"20px", marginBottom:"10px"}}>
              <label><input type="radio" name="pointsType" value="exact" checked={form.pointsType==="exact"} onChange={(e)=>setForm({...form, pointsType:e.target.value})}/> Точные</label>
              <label><input type="radio" name="pointsType" value="range" checked={form.pointsType==="range"} onChange={(e)=>setForm({...form, pointsType:e.target.value})}/> Диапазон</label>
            </div>
            {form.pointsType==="exact" ? (
              <input type="number" step="0.1" placeholder="Введите баллы" value={form.pointsExact} onChange={(e)=>setForm({...form, pointsExact:e.target.value})} style={inputStyle}/>
            ):(
              <div style={{ display:"grid", gridTemplateColumns:"1fr auto 1fr", gap:"10px" }}>
                <input type="number" step="0.1" placeholder="От" value={form.pointsFrom} onChange={(e)=>setForm({...form, pointsFrom:e.target.value})} style={inputStyle}/>
                <span>—</span>
                <input type="number" step="0.1" placeholder="До" value={form.pointsTo} onChange={(e)=>setForm({...form, pointsTo:e.target.value})} style={inputStyle}/>
              </div>
            )}
          </div>

          {/* Руководитель */}
          <div>
            <label style={{ marginBottom:"6px", fontWeight:500 }}>Руководитель</label>
            <input type="text" placeholder="Введите имя руководителя" value={form.supervisor} onChange={(e)=>setForm({...form, supervisor:e.target.value})} style={inputStyle}/>
          </div>

          {/* Кнопки */}
          <div style={{ display:"flex", justifyContent:"flex-end", gap:"10px", marginTop:"20px" }}>
            <button type="button" onClick={handleReset} className="btn btn-secondary" style={{ padding:"10px 20px", fontWeight:500 }}>Сбросить</button>
            <button type="submit" className="btn btn-primary" style={{ padding:"10px 20px", fontWeight:500 }}>Поиск</button>
            <button type="button" onClick={onCancel} className="btn btn-secondary" style={{ padding:"10px 20px", fontWeight:500 }}>Отмена</button>
          </div>

        </form>
      </div>
    </div>
  );
}
