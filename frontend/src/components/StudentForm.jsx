import React, { useState, useEffect } from "react";

const FACULTIES = [
  "Факультет биологии и экологии",
  "Факультет информатики и вычислительной техники",
  "Исторический факультет",
  "Математический факультет",
  "Факультет психологии",
  "Факультет социально-политических наук",
  "Факультет иностранных языков",
  "Физико-технический факультет",
  "Факультет филологии и коммуникации",
  "Экономический факультет",
  "Юридический факультет",
];

export default function StudentForm({ student, onSave, onCancel }) {
  const [form, setForm] = useState({
    surname: "",
    name: "",
    middleName: "",
    cardNumber: "",
    faculty: "",
    department: "",
    studyGroup: "",
    email: "",
    phone: "",
  });

  const [errors, setErrors] = useState({});

  useEffect(() => {
    if (student) {
      setForm({
        surname: student.surname || "",
        name: student.name || "",
        middleName: student.middleName || "",
        cardNumber: student.cardNumber || "",
        faculty: student.faculty || "",
        department: student.department || "",
        studyGroup: student.studyGroup || "",
        email: student.email || "",
        phone: student.phone || "",
      });
    }
  }, [student]);

  function handleChange(e) {
    const { name, value } = e.target;
    if (name === "cardNumber" && !/^\d*$/.test(value)) return;
    setForm((prev) => ({ ...prev, [name]: value }));
  }

  function validate() {
    const e = {};
    if (!form.surname.trim()) e.surname = "Обязательно";
    if (!form.name.trim()) e.name = "Обязательно";
    if (!form.cardNumber.trim()) e.cardNumber = "Обязательно";
    if (!form.faculty) e.faculty = "Выберите факультет";
    if (form.email && !/^\S+@\S+\.\S+$/.test(form.email)) e.email = "Некорректный email";
    setErrors(e);
    return Object.keys(e).length === 0;
  }

  async function handleSubmit(e) {
    e.preventDefault();
    if (!validate()) return;

    try {
      const url = student ? `/api/students/${student.id}` : "/api/students";
      const method = student ? "PUT" : "POST";

      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });

      if (!res.ok) {
        const data = await res.json();
        if (data.errors) {
          // Подставляем серверные ошибки в форму
          const serverErrors = {};
          Object.entries(data.errors).forEach(([field, msg]) => {
            // Преобразуем путь из backend в поля формы
            const key = field.split(".").pop(); 
            serverErrors[key] = msg;
          });
          setErrors(serverErrors);
          return;
        }
        throw new Error(data.message || "Ошибка сохранения");
      }

      // Если всё ок
      onSave();
    } catch (e) {
      alert(e.message);
    }
  }

  return (
    <div className="modal-overlay">
      <div className="modal-window large">
        <div className="modal-header">
          <h3>{student ? "Редактирование студента" : "Новый студент"}</h3>
          <button className="modal-close" onClick={onCancel}>×</button>
        </div>

        <form className="modal-body" onSubmit={handleSubmit}>
          <div className="form-row two-cols">
            <div>
              <label>Фамилия *</label>
              <input name="surname" value={form.surname} onChange={handleChange} />
              {errors.surname && <span className="error">{errors.surname}</span>}
            </div>
            <div>
              <label>Имя *</label>
              <input name="name" value={form.name} onChange={handleChange} />
              {errors.name && <span className="error">{errors.name}</span>}
            </div>
          </div>

          <div className="form-row">
            <label>Отчество</label>
            <input name="middleName" value={form.middleName} onChange={handleChange} placeholder="Необязательное поле" />
          </div>

          <div className="form-row">
            <label>Номер студенческого билета *</label>
            <input name="cardNumber" value={form.cardNumber} onChange={handleChange} placeholder="Только цифры" />
            {errors.cardNumber && <span className="error">{errors.cardNumber}</span>}
          </div>

          <div className="form-row">
            <label>Факультет *</label>
            <select name="faculty" value={form.faculty} onChange={handleChange}>
              <option value="">Выберите факультет</option>
              {FACULTIES.map((f) => <option key={f} value={f}>{f}</option>)}
            </select>
            {errors.faculty && <span className="error">{errors.faculty}</span>}
          </div>

          <div className="form-row two-cols">
            <div>
              <label>Кафедра</label>
              <input name="department" value={form.department} onChange={handleChange} />
            </div>
            <div>
              <label>Учебная группа</label>
              <input name="studyGroup" value={form.studyGroup} onChange={handleChange} />
            </div>
          </div>

          <div className="form-row two-cols">
            <div>
              <label>Email</label>
              <input name="email" value={form.email} onChange={handleChange} />
              {errors.email && <span className="error">{errors.email}</span>}
            </div>
            <div>
              <label>Телефон</label>
              <input name="phone" value={form.phone} onChange={handleChange} placeholder="+7xxxxxxxxxx" />
              {errors.phone && <span className="error">{errors.phone}</span>}
            </div>
          </div>

          <div className="modal-footer" style={{ justifyContent: "space-between" }}>
            <button type="submit" className="btn btn-primary">Сохранить</button>
            <button type="button" className="btn btn-secondary" onClick={onCancel}>Отмена</button>
          </div>
        </form>
      </div>
    </div>
  );
}
