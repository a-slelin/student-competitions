import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import CompetitionsTable from "../components/CompetitionsTable.jsx";
import SearchBar from "../components/SearchBar.jsx";
import Pagination from "../components/Pagination.jsx";
import ConfirmModal from "../components/ConfirmModal.jsx";
import CompetitionForm from "../components/CompetitionForm.jsx";

export default function CompetitionsPage() {
  const [competitions, setCompetitions] = useState([]);
  const [currentPage, setCurrentPage] = useState(0);
  const [pageSize] = useState(10);
  const [totalPages, setTotalPages] = useState(1);
  const [search, setSearch] = useState("");
  const [sort, setSort] = useState(null);
  const [confirmModal, setConfirmModal] = useState({ show: false, callback: null });
  const [formModal, setFormModal] = useState({ show: false, competition: null });

  const navigate = useNavigate();

  async function loadCompetitions() {
    try {
      const params = new URLSearchParams({ page: currentPage, size: pageSize });
      if (sort) params.append("sort", `${sort.column},${sort.direction}`);

      const isSearch = search.trim().length > 0;
      const url = isSearch ? "/api/competitions/search" : "/api/competitions";
      const options = isSearch
        ? {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              filters: [{ field: "name", operation: "like", value: search }]
            })
          }
        : {};

      const res = await fetch(`${url}?${params.toString()}`, options);
      const data = await res.json();
      setCompetitions(data.content || []);
      setTotalPages(data.page?.totalPages ?? 1);
    } catch (e) {
      alert(e.message);
    }
  }

  useEffect(() => {
    loadCompetitions();
  }, [currentPage, search, sort]);

  const handleSave = async (form) => {
    try {
      const res = formModal.competition
        ? await fetch(`/api/competitions/${formModal.competition.id}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(form),
          })
        : await fetch("/api/competitions", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(form),
          });

      if (!res.ok) throw new Error("Ошибка сохранения");

      setFormModal({ show: false, competition: null });
      loadCompetitions();
    } catch (e) {
      alert(e.message);
    }
  };

  const handleDelete = (id) => {
    setConfirmModal({
      show: true,
      callback: async () => {
        await fetch(`/api/competitions/${id}`, { method: "DELETE" });
        setConfirmModal({ show: false, callback: null });
        loadCompetitions();
      },
    });
  };

  return (
    <div className="page active">
      <div className="content-header">
        <h2>Соревнования</h2>
        <SearchBar
          search={search}
          setSearch={setSearch}
          placeholder="Поиск по названию"
          buttonLabel="Новое соревнование"
          onButtonClick={() => setFormModal({ show: true, competition: null })}
        />
      </div>

      <CompetitionsTable
        competitions={competitions}
        sort={sort}
        setSort={setSort}
        onEdit={(c) => setFormModal({ show: true, competition: c })}
        onDelete={handleDelete}
        onCompetitionSelect={(id) => navigate(`/competitions/${id}`)}
      />

      <Pagination currentPage={currentPage} totalPages={totalPages} onPageChange={setCurrentPage} />

      {confirmModal.show && (
        <ConfirmModal
          message="Удалить соревнование?"
          onConfirm={confirmModal.callback}
          onCancel={() => setConfirmModal({ show: false, callback: null })}
        />
      )}

      {formModal.show && (
        <CompetitionForm
          competition={formModal.competition}
          onSave={handleSave}
          onCancel={() => setFormModal({ show: false, competition: null })}
        />
      )}
    </div>
  );
}
