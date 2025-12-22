import React, { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";

export default function CompetitionProfile() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [competition, setCompetition] = useState(null);
  const [participants, setParticipants] = useState([]);
  const [loading, setLoading] = useState(false);

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

  useEffect(() => {
    async function loadCompetitionProfile() {
      setLoading(true);
      try {
        const compRes = await fetch(`/api/competitions/${id}`);
        if (!compRes.ok) throw new Error("Соревнование не найдено");
        const comp = await compRes.json();
        setCompetition(comp);

        const res = await fetch(`/api/participations?size=1000`);
        if (!res.ok) throw new Error("Ошибка загрузки участий");
        const data = await res.json();
        const all = data.content || [];
        const competitionUrl = `/api/competitions/${id}`;

        const filtered = all.filter(
          (p) => normalizeApiUrl(p.competition) === normalizeApiUrl(competitionUrl)
        );

        if (!filtered.length) {
          setParticipants([]);
          return;
        }

        const studentUrls = filtered.map((p) => p.student);
        const levelUrls = filtered.map((p) => p.level);
        const resultUrls = filtered.map((p) => p.result);

        const [students, levels, results] = await Promise.all([
          fetchEntities(studentUrls),
          fetchEntities(levelUrls),
          fetchEntities(resultUrls),
        ]);

        const enriched = filtered.map((p) => {
          const s = students[normalizeApiUrl(p.student)];
          const l = levels[normalizeApiUrl(p.level)];
          const r = results[normalizeApiUrl(p.result)];

          return {
            ...p,
            studentName: s
              ? `${s.surname} ${s.name} ${s.middleName || ""}`.trim()
              : "-",
            levelName: l?.name || "-",
            resultName: r?.name || "-",
            year: p.year ?? "-",
            points: p.points ?? "-",
            supervisor: p.supervisor || "-",
            description: p.description || "-",
          };
        });

        setParticipants(enriched);
      } catch (e) {
        console.error(e);
      } finally {
        setLoading(false);
      }
    }

    if (id) loadCompetitionProfile();
  }, [id]);

  if (loading) return <div className="loading">Загрузка данных...</div>;
  if (!competition) return <div>Соревнование не найдено</div>;

  return (
    <div id="competition-profile">
      <button className="back-btn" onClick={() => navigate(-1)}>
        ← Назад к списку
      </button>

      <div className="profile-header">
        <div className="profile-name">{competition.name}</div>

        <div className="profile-info">
          <div className="profile-info-item">
            <span className="profile-info-label">Тип</span>
            <div>{competition.type || "-"}</div>
          </div>

          <div className="profile-info-item">
            <span className="profile-info-label">Организатор</span>
            <div>{competition.organizer || "Не указан"}</div>
          </div>
        </div>
      </div>

      <div className="content-header">
        <h2>Список участников</h2>
      </div>

      <div className="table-container">
        <table>
          <thead>
            <tr>
              <th>Студент</th>
              <th>Уровень</th>
              <th>Результат</th>
              <th>Год</th>
              <th>Баллы</th>
              <th>Руководитель</th>
              <th>Описание</th>
            </tr>
          </thead>
          <tbody>
            {participants.length === 0 ? (
              <tr>
                <td colSpan="7" className="empty-state">
                  Участников пока нет
                </td>
              </tr>
            ) : (
              participants.map((p) => (
                <tr key={p.id}>
                  <td>{p.studentName}</td>
                  <td>{p.levelName}</td>
                  <td>{p.resultName}</td>
                  <td>{p.year}</td>
                  <td>{p.points}</td>
                  <td>{p.supervisor}</td>
                  <td>{p.description}</td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
