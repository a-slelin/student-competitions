import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import ParticipationsTable from "../components/ParticipationsTable.jsx";
import SearchBar from "../components/SearchBar.jsx";
import Pagination from "../components/Pagination.jsx";
import ConfirmModal from "../components/ConfirmModal.jsx";
import ParticipationForm from "../components/ParticipationForm.jsx";

export default function ParticipationsPage() {
  const [participations, setParticipations] = useState([]);
  const [currentPage, setCurrentPage] = useState(0);
  const [pageSize] = useState(10);
  const [totalPages, setTotalPages] = useState(1);
  const [search, setSearch] = useState("");
  const [sort, setSort] = useState({ column: null, direction: "asc" });

  const [confirmModal, setConfirmModal] = useState({ show: false, id: null });
  const [formModal, setFormModal] = useState({ show: false, participation: null });

  const navigate = useNavigate();

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
    async function loadParticipations() {
      try {
        const params = new URLSearchParams({ page: currentPage, size: pageSize });
        if (sort.column) params.append("sort", `${sort.column},${sort.direction}`);

        const filters = [];
        const term = search.trim();
        const yearMatch = term.match(/^(\d{4})(-(\d{4}))?$/);

        if (yearMatch) {
          const fromYear = Number(yearMatch[1]);
          const toYear = yearMatch[3] ? Number(yearMatch[3]) : fromYear;
          filters.push({ field: "year", operation: "between", value: fromYear, value2: toYear });
        } else if (term.length > 0) {
          filters.push(
            { field: "student.surname", operation: "like", value: term },
            { field: "student.name", operation: "like", value: term },
            { field: "student.middleName", operation: "like", value: term },
            { field: "student.faculty", operation: "like", value: term },
            { field: "level.name", operation: "like", value: term },
            { field: "competition.name", operation: "like", value: term }
          );
        }

        const body = filters.length > 0 ? { filters } : null;

        const res = await fetch(
          filters.length > 0 ? `/api/participations/search?${params}` : `/api/participations?${params}`,
          body ? { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(body) } : {}
        );

        if (!res.ok) throw new Error("Ошибка загрузки");

        const data = await res.json();

        const studentUrls = data.content.map((p) => p.student);
        const competitionUrls = data.content.map((p) => p.competition);
        const levelUrls = data.content.map((p) => p.level);
        const resultUrls = data.content.map((p) => p.result);

        const [students, competitions, levels, results] = await Promise.all([
          fetchEntities(studentUrls),
          fetchEntities(competitionUrls),
          fetchEntities(levelUrls),
          fetchEntities(resultUrls),
        ]);

        const enriched = data.content.map((p) => {
          const get = (url, map) => map[normalizeApiUrl(url)];

          const s = get(p.student, students);
          const c = get(p.competition, competitions);
          const l = get(p.level, levels);
          const r = get(p.result, results);

          return {
            ...p,
            studentName: s ? `${s.surname} ${s.name} ${s.middleName || ""}`.trim() : "-",
            faculty: s?.faculty || "-",
            competitionName: c?.name || "-",
            levelName: l?.name || "-",
            resultName: r?.name || "-",
            year: p.year ?? "-",
            points: p.points ?? "-",
            supervisor: p.supervisor || "-",
            IsBlocked: p.isBlocked ?? false,
            studentId: s?.id,
            competitionId: c?.id,
          };
        });

        setParticipations(enriched);
        setTotalPages(data.page?.totalPages ?? 1);
      } catch (e) {
        alert(e.message);
      }
    }

    loadParticipations();
  }, [currentPage, pageSize, search, sort]);

  const handleSave = async (form) => {
    const payload = {
      student: form.student,
      competition: form.competition,
      level: form.level,
      result: form.result,
      year: Number(form.year),
      supervisor: form.supervisor || null,
      points: form.points ? Number(form.points) : null,
      description: form.description || null,
    };

    try {
      const res = formModal.participation
        ? await fetch(`/api/participations/${formModal.participation.id}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload),
          })
        : await fetch("/api/participations", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload),
          });

      if (!res.ok) throw new Error("Ошибка сохранения");

      setFormModal({ show: false, participation: null });
      setCurrentPage(0);
    } catch (e) {
      alert(e.message);
    }
  };

  const handleDelete = async () => {
    try {
      await fetch(`/api/participations/${confirmModal.id}`, { method: "DELETE" });
      setConfirmModal({ show: false, id: null });
      setCurrentPage(0);
    } catch (e) {
      alert(e.message);
    }
  };

  return (
    <div className="page active">
      <div className="content-header">
        <h2>Участия</h2>
        <SearchBar
          search={search}
          setSearch={setSearch}
          placeholder="Поиск по ФИО, факультету, уровню, соревнованию или году (например, 2022-2024)"
          buttonLabel="Новое участие"
          onButtonClick={() => setFormModal({ show: true, participation: null })}
        />
      </div>

      <ParticipationsTable
        participations={participations}
        sort={sort}
        setSort={setSort}
        onEdit={(p) => !p.IsBlocked && setFormModal({ show: true, participation: p })}
        onDelete={(id) => setConfirmModal({ show: true, id })}
        onStudentClick={(studentId) => navigate(`/students/${studentId}`)}
        onCompetitionClick={(competitionId) => navigate(`/competitions/${competitionId}`)}
      />

      <Pagination currentPage={currentPage} totalPages={totalPages} onPageChange={setCurrentPage} />

      {confirmModal.show && (
        <ConfirmModal
          message="Удалить запись?"
          onConfirm={handleDelete}
          onCancel={() => setConfirmModal({ show: false, id: null })}
        />
      )}

      {formModal.show && (
        <ParticipationForm
          participation={formModal.participation}
          onSave={handleSave}
          onCancel={() => setFormModal({ show: false, participation: null })}
        />
      )}
    </div>
  );
}
