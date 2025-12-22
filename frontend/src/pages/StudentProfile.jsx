import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";

const StudentProfile = () => {
  const { id } = useParams();
  const navigate = useNavigate();

  const [student, setStudent] = useState(null);
  const [participations, setParticipations] = useState([]);
  const [loading, setLoading] = useState(true);

  // --- utils ---
  const normalizeApiUrl = (url) => {
    if (!url) return null;
    try {
      const u = new URL(url);
      return u.pathname + u.search;
    } catch {
      return url;
    }
  };

  const fetchEntities = async (urls) => {
    const unique = [...new Set(urls.map(normalizeApiUrl).filter(Boolean))];
    const results = await Promise.all(
      unique.map(async (url) => {
        try {
          const r = await fetch(url);
          return r.ok ? await r.json() : null;
        } catch {
          return null;
        }
      })
    );
    const map = {};
    unique.forEach((u, i) => (map[u] = results[i]));
    return map;
  };

  // --- загрузка данных ---
  useEffect(() => {
    async function loadProfile() {
      setLoading(true);
      try {
        // 1. Студент
        const sRes = await fetch(`/api/students/${id}`);
        if (!sRes.ok) throw new Error("Студент не найден");
        const studentData = await sRes.json();
        setStudent(studentData);

        // 2. Участия
        const pRes = await fetch(`/api/participations?page=0&size=1000`);
        const pData = await pRes.json();

        const filtered = (pData.content || []).filter((p) => {
          const studentUrl =
            typeof p.student === "string" ? p.student : p._links?.student?.href;
          return studentUrl?.endsWith(id);
        });

        if (!filtered.length) {
          setParticipations([]);
          return;
        }

        // 3. Подгрузка связанных сущностей
        const [competitions, levels, results] = await Promise.all([
          fetchEntities(filtered.map((p) => p.competition)),
          fetchEntities(filtered.map((p) => p.level)),
          fetchEntities(filtered.map((p) => p.result)),
        ]);

        const enriched = filtered.map((p) => ({
          ...p,
          competitionName: competitions[normalizeApiUrl(p.competition)]?.name || "—",
          levelName: levels[normalizeApiUrl(p.level)]?.name || "—",
          resultName: results[normalizeApiUrl(p.result)]?.name || "—",
          supervisor: p.supervisor || "—",
          description: p.description || "—",
        }));

        setParticipations(enriched);
      } catch (err) {
        console.error("Ошибка загрузки профиля:", err);
      } finally {
        setLoading(false);
      }
    }

    if (id) loadProfile();
  }, [id]);

  // --- UI ---
  if (loading) return <div className="loading">Загрузка профиля...</div>;
  if (!student) return <div>Студент не найден</div>;

  return (
    <div id="student-profile">
      <button className="back-btn" onClick={() => navigate(-1)}>
        ← Назад
      </button>

      <div className="profile-header">
        <div className="profile-name">
          {student.surname} {student.name} {student.middleName || ""}
        </div>

        <div className="profile-info">
          <div><b>Студ. билет:</b> {student.cardNumber || "—"}</div>
          <div><b>Факультет:</b> {student.faculty || "—"}</div>
          <div><b>Группа:</b> {student.studyGroup || "—"}</div>
          <div><b>Email:</b> {student.email || "—"}</div>
          <div><b>Телефон:</b> {student.phone || "—"}</div>
        </div>
      </div>

      <h2>История участий</h2>

      <div className="table-container">
        <table>
          <thead>
            <tr>
              <th>Соревнование</th>
              <th>Уровень</th>
              <th>Результат</th>
              <th>Год</th>
              <th>Баллы</th>
              <th>Преподаватель</th>
              <th>Описание</th>
            </tr>
          </thead>
          <tbody>
            {participations.length === 0 ? (
              <tr>
                <td colSpan="7" className="empty-state">
                  Участий не найдено
                </td>
              </tr>
            ) : (
              participations.map((p) => (
                <tr key={p.id}>
                  <td>{p.competitionName}</td>
                  <td>{p.levelName}</td>
                  <td>{p.resultName}</td>
                  <td>{p.year}</td>
                  <td>{p.points ?? "—"}</td>
                  <td>{p.supervisor}</td>
                  <td className="description-cell">{p.description}</td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default StudentProfile;
