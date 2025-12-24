import React, { useState, useEffect } from "react";

export default function ResultForm({ result, onSave, onCancel }) {
  const [form, setForm] = useState({
    name: "",
    code: "",
    order: ""
  });

  const [errors, setErrors] = useState({});

  useEffect(() => {
    if (result) {
      setForm({
        name: result.name || "",
        code: result.code || "",
        order: result.order ?? ""
      });
    } else {
      setForm({ name: "", code: "", order: "" });
    }
  }, [result]);

  const handleChange = (e) => {
    const { name, value } = e.target;

    if (name === "order" && !/^\d*$/.test(value)) return;

    setForm(prev => ({ ...prev, [name]: value }));
  };

  const validate = () => {
    const e = {};

    if (!form.name.trim()) e.name = "Обязательно";
    if (!form.code.trim() && !result) e.code = "Обязательно";
    if (form.order === "" || form.order === null)
      e.order = "Обязательно";

    setErrors(e);
    return Object.keys(e).length === 0;
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!validate()) return;

    onSave({
      ...form,
      order: Number(form.order),
    });
  };

  return (
    <div className="modal-overlay">
      <div className="modal-window large">
        <div className="modal-header">
          <h3>{result ? "Редактирование результата" : "Новый результат"}</h3>
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
            <label>Код *</label>
            <input
              name="code"
              value={form.code}
              onChange={handleChange}
              readOnly={!!result}
            />
            {errors.code && <span className="error">{errors.code}</span>}
          </div>

          <div className="form-row">
            <label>Порядок *</label>
            <input
              name="order"
              value={form.order}
              onChange={handleChange}
              placeholder="Число"
            />
            {errors.order && <span className="error">{errors.order}</span>}
          </div>

          <div className="modal-footer" style={{ justifyContent: "space-between" }}>
            <button type="submit" className="btn btn-primary">
              Сохранить
            </button>
            <button
              type="button"
              className="btn btn-secondary"
              onClick={onCancel}
            >
              Отмена
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
