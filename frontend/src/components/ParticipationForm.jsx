import React, { useState, useEffect } from "react";

export default function ParticipationForm({ participation, onSave, onCancel }) {
  const [form, setForm] = useState({
    student: "",
    competition: "",
    level: "",
    result: "",
    year: "",
    points: "",
    supervisor: "",
    description: "",
  });
  const [errors, setErrors] = useState({});
  const isBlocked = participation?.IsBlocked ?? false;

  useEffect(() => {
    if (participation) {
      setForm({
        student: participation.studentName || "",
        competition: participation.competitionName || "",
        level: participation.levelName || "",
        result: participation.resultName || "",
        year: participation.year || "",
        points: participation.points || "",
        supervisor: participation.supervisor || "",
        description: participation.description || "",
      });
    } else {
      setForm({
        student: "",
        competition: "",
        level: "",
        result: "",
        year: "",
        points: "",
        supervisor: "",
        description: "",
      });
    }
  }, [participation]);

  const handleChange = (e) => {
    if (isBlocked) return; // блокируем изменения
    const { name, value } = e.target;
    setForm((prev) => ({ ...prev, [name]: value }));
  };

  const validate = () => {
    const e = {};
    if (!form.student.trim()) e.student = "Обязательно";
    if (!form.competition.trim()) e.competition = "Обязательно";
    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (isBlocked) return;
    if (!validate()) return;
    onSave(form);
  };

  return (
    <div className="modal-overlay">
      <div className="modal-window large">
        <div className="modal-header">
          <h3>
            {participation
              ? isBlocked
                ? "Просмотр участия"
                : "Редактирование участия"
              : "Новое участие"}
          </h3>
          <button className="modal-close" onClick={onCancel}>×</button>
        </div>

        <form className="modal-body" onSubmit={handleSubmit}>
          <div className="form-row">
            <label>Студент *</label>
            <input name="student" value={form.student} onChange={handleChange} readOnly />
            {errors.student && <span className="error">{errors.student}</span>}
          </div>

          <div className="form-row">
            <label>Соревнование *</label>
            <input name="competition" value={form.competition} onChange={handleChange} readOnly />
            {errors.competition && <span className="error">{errors.competition}</span>}
          </div>

          <div className="form-row">
            <label>Уровень</label>
            <input name="level" value={form.level} onChange={handleChange} readOnly />
          </div>

          <div className="form-row">
            <label>Результат</label>
            <input name="result" value={form.result} onChange={handleChange} readOnly />
          </div>

          <div className="form-row">
            <label>Год</label>
            <input name="year" value={form.year} onChange={handleChange} readOnly={isBlocked} />
          </div>

          <div className="form-row">
            <label>Баллы</label>
            <input name="points" value={form.points} onChange={handleChange} readOnly={isBlocked} />
          </div>

          <div className="form-row">
            <label>Руководитель</label>
            <input name="supervisor" value={form.supervisor} onChange={handleChange} readOnly={isBlocked} />
          </div>

          <div className="form-row">
            <label>Описание</label>
            <textarea name="description" value={form.description} onChange={handleChange} readOnly={isBlocked} />
          </div>

          <div className="modal-footer" style={{ justifyContent: "space-between" }}>
            <button
              type="submit"
              className={`btn btn-primary ${isBlocked ? "btn-disabled" : ""}`}
              disabled={isBlocked}
            >
              {isBlocked ? "Недоступно" : "Сохранить"}
            </button>
            <button type="button" className="btn btn-secondary" onClick={onCancel}>
              Отмена
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
