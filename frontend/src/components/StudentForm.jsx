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
  const [isSubmitting, setIsSubmitting] = useState(false);

  useEffect(() => {
    if (student) {
      setForm({
        surname: student.surname ?? "",
        name: student.name ?? "",
        middleName: student.middleName ?? "",
        cardNumber: student.cardNumber ?? "",
        faculty: student.faculty ?? "",
        department: student.department ?? "",
        studyGroup: student.studyGroup ?? "",
        email: student.email ?? "",
        phone: student.phone ?? "",
      });
    }
  }, [student]);

  function handleChange(e) {
    const { name, value } = e.target;

    const textOnlyFields = ["surname", "name", "middleName", "department"];
    
    if (textOnlyFields.includes(name)) {
      if (/\d/.test(value)) {
        return;
      }
    }

    setForm((prev) => ({
      ...prev,
      [name]: value,
    }));

    if (errors[name]) {
      setErrors((prev) => ({ ...prev, [name]: null }));
    }
  }

  function validate() {
  const e = {};

  if (!form.surname.trim()) {
    e.surname = "Обязательно";
  } else if (form.surname.trim().length < 2) {
    e.surname = "Минимум 2 символа";
  } else if (form.surname.trim().length > 50) {
    e.surname = "Максимум 50 символов";
  } else if (/\d/.test(form.surname)) {
    e.surname = "Фамилия не должна содержать цифры";
  }

  if (!form.name.trim()) {
    e.name = "Обязательно";
  } else if (form.name.trim().length < 2) {
    e.name = "Минимум 2 символа";
  } else if (form.name.trim().length > 50) {
    e.name = "Максимум 50 символов";
  } else if (/\d/.test(form.name)) {
    e.name = "Имя не должно содержать цифры";
  }

  if (form.middleName) {
    if (form.middleName.trim().length < 2) {
      e.middleName = "Минимум 2 символа";
    } else if (form.middleName.trim().length > 50) {
      e.middleName = "Максимум 50 символов";
    } else if (/\d/.test(form.middleName)) {
      e.middleName = "Отчество не должно содержать цифры";
    }
  }

  if (form.department && /\d/.test(form.department)) {
    e.department = "Кафедра не должна содержать цифры";
  }

  if (!form.faculty) {
    e.faculty = "Выберите факультет";
  }

  if (!student && !form.cardNumber.toString().trim()) {
    e.cardNumber = "Обязательно";
  }

  setErrors(e);
  return Object.keys(e).length === 0;
}


  async function handleSubmit(e) {
    e.preventDefault();
    if (!validate()) return;

    const payload = {
      ...(student?.id ? { id: student.id } : {}),

      surname: form.surname.trim(),
      name: form.name.trim(),
      faculty: form.faculty,

      middleName: form.middleName.trim() || null,
      department: form.department.trim() || null,
      studyGroup: form.studyGroup.trim() || null,
      email: form.email.trim() || null,
      phone: form.phone.trim() || null,
    };

    if (!student) {
      payload.cardNumber = Number(form.cardNumber);
    }

    setIsSubmitting(true);

    try {
      const isEdit = Boolean(student?.id);
      const url = isEdit ? `/api/students/${student.id}` : "/api/students";
      const method = isEdit ? "PATCH" : "POST";

      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });

      if (!res.ok) {
        const errorData = await res.json().catch(() => null);
        
        if (errorData) {
          if (errorData.exception === "NotUniqueFieldException" && errorData.details) {
            const field = errorData.details.field;
            const fieldNameMap = {
              cardNumber: "cardNumber",
              surname: "surname",
              name: "name",
              email: "email",
              phone: "phone"
            };

            const mappedField = fieldNameMap[field] || field;
            
            let errorMessage = "Это значение уже используется";
            if (field === "cardNumber") {
              errorMessage = `Студент с номером билета ${errorData.details.value} уже существует`;
            } else if (field === "email") {
              errorMessage = `Email ${errorData.details.value} уже используется`;
            } else if (field === "phone") {
              errorMessage = `Телефон ${errorData.details.value} уже используется`;
            }

            setErrors({ [mappedField]: errorMessage });
          } else {
            setErrors({ general: errorData.message || "Ошибка при сохранении данных" });
          }
        } else {
          setErrors({ general: "Ошибка при сохранении данных" });
        }
        
        setIsSubmitting(false);
        return;
      }

      onSave(payload);
    } catch (err) {
      console.error("Ошибка при сохранении:", err);
      setErrors({ general: "Произошла ошибка при сохранении данных" });
      setIsSubmitting(false);
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
          {errors.general && (
            <div style={{ 
              padding: "10px", 
              marginBottom: "15px", 
              backgroundColor: "#fee", 
              border: "1px solid #fcc",
              borderRadius: "4px",
              color: "#c33",
              fontSize: "0.9rem"
            }}>
              {errors.general}
            </div>
          )}

          <div className="form-row two-cols">
            <div>
              <label>Фамилия *</label>
              <input
                name="surname"
                value={form.surname}
                onChange={handleChange}
                style={errors.surname ? { borderColor: "#dc3545" } : {}}
                
              />
              {errors.surname && (
                <span style={{ 
                  color: "#dc3545", 
                  fontSize: "0.85rem", 
                  marginTop: "4px",
                  display: "block"
                }}>
                  {errors.surname}
                </span>
              )}
            </div>

            <div>
              <label>Имя *</label>
              <input
                name="name"
                value={form.name}
                onChange={handleChange}
                style={errors.name ? { borderColor: "#dc3545" } : {}}               
              />
              {errors.name && (
                <span style={{ 
                  color: "#dc3545", 
                  fontSize: "0.85rem", 
                  marginTop: "4px",
                  display: "block"
                }}>
                  {errors.name}
                </span>
              )}
            </div>
          </div>

          <div className="form-row">
            <label>Отчество</label>
            <input
              name="middleName"
              value={form.middleName}
              onChange={handleChange}
              style={errors.middleName ? { borderColor: "#dc3545" } : {}}
             
            />
            {errors.middleName && (
              <span style={{ 
                color: "#dc3545", 
                fontSize: "0.85rem", 
                marginTop: "4px",
                display: "block"
              }}>
                {errors.middleName}
              </span>
            )}
          </div>

          {!student && (
            <div className="form-row">
              <label>Номер студенческого билета *</label>
              <input
                name="cardNumber"
                type="number"
                value={form.cardNumber}
                onChange={handleChange}
                style={errors.cardNumber ? { borderColor: "#dc3545" } : {}}
              />
              {errors.cardNumber && (
                <span style={{ 
                  color: "#dc3545", 
                  fontSize: "0.85rem", 
                  marginTop: "4px",
                  display: "block"
                }}>
                  {errors.cardNumber}
                </span>
              )}
            </div>
          )}

          <div className="form-row">
            <label>Факультет *</label>
            <select
              name="faculty"
              value={form.faculty}
              onChange={handleChange}
              style={errors.faculty ? { borderColor: "#dc3545" } : {}}
            >
              <option value="">Выберите факультет</option>
              {FACULTIES.map((f) => (
                <option key={f} value={f}>
                  {f}
                </option>
              ))}
            </select>
            {errors.faculty && (
              <span style={{ 
                color: "#dc3545", 
                fontSize: "0.85rem", 
                marginTop: "4px",
                display: "block"
              }}>
                {errors.faculty}
              </span>
            )}
          </div>

          <div className="form-row two-cols">
            <div>
              <label>Кафедра</label>
              <input
                name="department"
                value={form.department}
                onChange={handleChange}
                style={errors.department ? { borderColor: "#dc3545" } : {}}
              
              />
              {errors.department && (
                <span style={{ 
                  color: "#dc3545", 
                  fontSize: "0.85rem", 
                  marginTop: "4px",
                  display: "block"
                }}>
                  {errors.department}
                </span>
              )}
            </div>

            <div>
              <label>Учебная группа</label>
              <input
                name="studyGroup"
                value={form.studyGroup}
                onChange={handleChange}
              />
            </div>
          </div>

          <div className="form-row two-cols">
            <div>
              <label>Email</label>
              <input
                name="email"
                type="email"
                value={form.email}
                onChange={handleChange}
                style={errors.email ? { borderColor: "#dc3545" } : {}}
              />
              {errors.email && (
                <span style={{ 
                  color: "#dc3545", 
                  fontSize: "0.85rem", 
                  marginTop: "4px",
                  display: "block"
                }}>
                  {errors.email}
                </span>
              )}
            </div>

            <div>
              <label>Телефон</label>
              <input
                name="phone"
                value={form.phone}
                onChange={handleChange}
                style={errors.phone ? { borderColor: "#dc3545" } : {}}
              />
              {errors.phone && (
                <span style={{ 
                  color: "#dc3545", 
                  fontSize: "0.85rem", 
                  marginTop: "4px",
                  display: "block"
                }}>
                  {errors.phone}
                </span>
              )}
            </div>
          </div>

          <div className="modal-footer">
            <button 
              type="submit" 
              className="btn btn-primary"
              disabled={isSubmitting}
            >
              {isSubmitting ? "Сохранение..." : "Сохранить"}
            </button>
            <button 
              type="button" 
              className="btn btn-secondary" 
              onClick={onCancel}
              disabled={isSubmitting}
            >
              Отмена
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}