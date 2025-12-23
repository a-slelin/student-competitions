import React, { useState, useEffect } from "react"; 
import { useNavigate } from "react-router-dom";
import ParticipationsTable from "../components/ParticipationsTable.jsx";
import Pagination from "../components/Pagination.jsx";
import ConfirmModal from "../components/ConfirmModal.jsx";
import ParticipationForm from "../components/ParticipationForm.jsx";
import AdvancedSearchModal from "../components/AdvancedSearchModal.jsx";

export default function ParticipationsPage() {
  const [participations, setParticipations] = useState([]);
  const [currentPage, setCurrentPage] = useState(0);
  const [pageSize] = useState(10);
  const [totalPages, setTotalPages] = useState(1);
  const [sort, setSort] = useState({ column: null, direction: "asc" });
  const [advancedFilters, setAdvancedFilters] = useState([]);

  const [confirmModal, setConfirmModal] = useState({ show: false, id: null });
  const [formModal, setFormModal] = useState({ show: false, participation: null });
  const [searchModal, setSearchModal] = useState(false);
  const [loading, setLoading] = useState(false);

  const navigate = useNavigate();

  const normalizeUrl = (url) => {
    if (!url) return null;
    try {
      const u = new URL(url);
      return u.pathname + u.search;
    } catch {
      return url;
    }
  };

  const enrichParticipations = async (content) => {
    if (!content || content.length === 0) return [];

    const enriched = await Promise.all(
      content.map(async (item) => {
        try {
          const [studentData, compData, levelData, resultData] = await Promise.all([
            item.student ? fetch(normalizeUrl(item.student)).then((r) => r.json()).catch(() => null) : null,
            item.competition ? fetch(normalizeUrl(item.competition)).then((r) => r.json()).catch(() => null) : null,
            item.level ? fetch(normalizeUrl(item.level)).then((r) => r.json()).catch(() => null) : null,
            item.result ? fetch(normalizeUrl(item.result)).then((r) => r.json()).catch(() => null) : null,
          ]);

          return {
            ...item,
            studentName: studentData ? `${studentData.surname} ${studentData.name} ${studentData.middleName || ""}`.trim() : "Неизвестно",
            faculty: studentData?.faculty || "-",
            competitionName: compData?.name || "Неизвестно",
            levelName: levelData?.name || "-",
            resultName: resultData?.name || "-",
            studentId: studentData?.id,
            competitionId: compData?.id,
            IsBlocked: item.isBlocked ?? false,
          };
        } catch (error) {
          console.error("Ошибка при загрузке деталей для ID:", item.id, error);
          return item;
        }
      })
    );

    return enriched;
  };

  const loadParticipations = async () => {
    setLoading(true);
    try {
      const url = "/api/participations/search";
      const params = new URLSearchParams({ page: currentPage, size: pageSize });
      if (sort.column) params.append("sort", `${sort.column},${sort.direction.toUpperCase()}`);

      let filters = [];
      if (advancedFilters.length > 0) {
        filters = [...filters, ...advancedFilters];
      }

      const res = await fetch(`${url}?${params}`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ filters: filters }),
      });

      if (!res.ok) throw new Error("Ошибка загрузки");

      const data = await res.json();
      const enrichedContent = await enrichParticipations(data.content || []);
      setParticipations(enrichedContent);
      setTotalPages(data.page?.totalPages || 1);
    } catch (e) {
      console.error("Ошибка:", e);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    loadParticipations();
  }, [currentPage, sort, JSON.stringify(advancedFilters)]);

  const handleSave = async (payload) => {
    try {
      const isEdit = !!payload.id;
      const url = isEdit ? `/api/participations/${payload.id}` : "/api/participations";
      const method = isEdit ? "PATCH" : "POST";

      const res = await fetch(url, {
        method: method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });

      if (!res.ok) {
        const err = await res.text();
        throw new Error(err || "Ошибка сохранения");
      }

      setFormModal({ show: false, participation: null });
      loadParticipations();
    } catch (e) {
      alert(e.message);
    }
  };

  const handleDelete = async () => {
    try {
      const res = await fetch(`/api/participations/${confirmModal.id}`, { method: "DELETE" });
      if (!res.ok) throw new Error("Ошибка удаления");
      setConfirmModal({ show: false, id: null });
      loadParticipations();
    } catch (e) {
      alert(e.message);
    }
  };

  const handleAdvancedSearch = (filters) => {
    setAdvancedFilters(filters);
    setCurrentPage(0);
    setSearchModal(false);
  };

  const handleClearFilters = () => {
    setAdvancedFilters([]);
    setCurrentPage(0);
  };

  return (
    <div className="page active">
      <div className="content-header">
        <h2>Участия</h2>
        <div style={{ display: "flex", gap: "10px", alignItems: "center" }}>
          <button 
            className="btn btn-secondary" 
            onClick={() => setSearchModal(true)}
          >
            🔍 Расширенный поиск
          </button>

          {advancedFilters.length > 0 && (
            <button 
              className="btn btn-secondary" 
              onClick={handleClearFilters}
            >
              ✕ Очистить фильтры ({advancedFilters.length})
            </button>
          )}

          <button 
            className="btn btn-primary" 
            onClick={() => setFormModal({ show: true, participation: null })}
          >
            Новое участие
          </button>
        </div>
      </div>

      <ParticipationsTable
        participations={participations}
        sort={sort}
        setSort={setSort}
        onEdit={(p) => setFormModal({ show: true, participation: p })}
        onDelete={(id) => setConfirmModal({ show: true, id })}
        onStudentClick={(studentId) => navigate(`/students/${studentId}`)}
        onCompetitionClick={(competitionId) => navigate(`/competitions/${competitionId}`)}
        loading={loading}
      />

      {loading && <div style={{ marginTop: 10, color: '#888' }}>Загрузка данных...</div>}

      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={setCurrentPage}
      />

      {confirmModal.show && (
        <ConfirmModal
          message="Вы действительно хотите удалить запись об участии?"
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

      {searchModal && (
        <AdvancedSearchModal
          onSearch={handleAdvancedSearch}
          onCancel={() => setSearchModal(false)}
        />
      )}
    </div>
  );
}
