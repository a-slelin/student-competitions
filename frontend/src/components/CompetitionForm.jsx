import React, { useState, useEffect } from "react";

export default function CompetitionForm({ competition, onSave, onCancel }) {
  const [form, setForm] = useState({
    name: "",
    organizer: "",
    type: "Olympiad",
  });

  const [errors, setErrors] = useState({});

  useEffect(() => {
    if (competition) {
      setForm({
        name: competition.name || "",
        organizer: competition.organizer || "",
        type: competition.type || "Olympiad",
      });
    }
  }, [competition]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setForm((p) => ({ ...p, [name]: value }));
  };

  const validate = () => {
    const e = {};
    if (!form.name.trim()) e.name = "Обязательно";
    if (!form.organizer.trim()) e.organizer = "Обязательно";
    if (!form.type) e.type = "Обязательно";

    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!validate()) return;
    onSave(form);
  };

  return (
    <div className="modal-overlay">
      <div className="modal-window large">
        <div className="modal-header">
          <h3>
            {competition ? "Редактирование соревнования" : "Новое соревнование"}
          </h3>
          <button className="modal-close" onClick={onCancel}>×</button>
        </div>

        <form className="modal-body" onSubmit={handleSubmit}>
          <div className="form-row">
            <label>Название *</label>
            <input
              name="name"
              value={form.name}
              onChange={handleChange}
            />
            {errors.name && <span className="error">{errors.name}</span>}
          </div>

          <div className="form-row">
            <label>Организатор *</label>
            <input
              name="organizer"
              value={form.organizer}
              onChange={handleChange}
            />
            {errors.organizer && (
              <span className="error">{errors.organizer}</span>
            )}
          </div>

          <div className="form-row">
            <label>Тип *</label>
            <select
              name="type"
              value={form.type}
              onChange={handleChange}
            >
              <option value="Olympiad">Олимпиада</option>
              <option value="Contest">Состязание</option>
              <option value="Championship">Чемпионат</option>
              <option value="Competition">Соревнование</option>
            </select>
            {errors.type && <span className="error">{errors.type}</span>}
          </div>

          <div className="modal-footer" style={{ justifyContent: "space-between" }}>
            <button type="submit" className="btn btn-primary">
              Сохранить
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
