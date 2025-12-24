import React, { useState, useEffect } from "react";
import LevelsTable from "../components/LevelsTable.jsx";
import SearchBar from "../components/SearchBar.jsx";
import Pagination from "../components/Pagination.jsx";
import ConfirmModal from "../components/ConfirmModal.jsx";
import LevelForm from "../components/LevelForm.jsx";

export default function LevelsPage() {
  const [levels, setLevels] = useState([]);
  const [currentPage, setCurrentPage] = useState(0);
  const [pageSize] = useState(10);
  const [totalPages, setTotalPages] = useState(1);
  const [search, setSearch] = useState("");
  const [sort, setSort] = useState({ column: null, direction: "asc" });
  const [confirmModal, setConfirmModal] = useState({ show: false, callback: null });
  const [formModal, setFormModal] = useState({ show: false, level: null });

  useEffect(() => setCurrentPage(0), [search, sort]);

  const loadLevels = async () => {
    try {
      const isSearch = search.trim().length > 0;
      const baseUrl = isSearch ? "/api/levels/search" : "/api/levels";

      const params = new URLSearchParams({ page: currentPage, size: pageSize });

      if (sort.column) {
        const columnName = sort.column === "order" ? "sortOrder" : sort.column;
        params.append("sort", `${columnName},${sort.direction.toUpperCase()}`);
      }

      const options = isSearch
        ? {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              filters: [{ field: "name", operation: "like", value: search }],
            }),
          }
        : {};

      const res = await fetch(`${baseUrl}?${params.toString()}`, options);
      if (!res.ok) throw new Error(`Ошибка сервера ${res.status}`);

      const data = await res.json();
      setLevels(data.content || []);
      setTotalPages(data.page?.totalPages ?? 1);
    } catch (err) {
      alert(err.message);
      console.error(err);
    }
  };

  useEffect(() => {
    loadLevels();
  }, [currentPage, search, sort]);

  const handleSort = (column) => {
    setCurrentPage(0);
    setSort((prev) => {
      if (prev.column === column) {
        return { column, direction: prev.direction === "asc" ? "desc" : "asc" };
      }
      return { column, direction: "asc" };
    });
  };

  const handleSave = async (form) => {
    try {
      const payload = { name: form.name, order: form.order ? Number(form.order) : null };

      const res = formModal.level
        ? await fetch(`/api/levels/${formModal.level.code}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload),
          })
        : await fetch("/api/levels", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ code: form.code, ...payload }),
          });

      if (!res.ok) throw new Error("Ошибка сохранения");

      setFormModal({ show: false, level: null });
      loadLevels();
    } catch (err) {
      alert(err.message);
      console.error(err);
    }
  };

  const handleDelete = (code) => {
    setConfirmModal({
      show: true,
      callback: async () => {
        try {
          const res = await fetch(`/api/levels/${code}`, { method: "DELETE" });
          if (!res.ok) throw new Error("Ошибка удаления уровня");
          setConfirmModal({ show: false, callback: null });
          await loadLevels();
        } catch (err) {
          alert(err.message);
          console.error(err);
        }
      },
    });
  };

  return (
    <div className="page active">
      <div className="content-header">
        <h2>Уровни</h2>
        <SearchBar
          search={search}
          setSearch={setSearch}
          placeholder="Поиск по названию уровня"
          buttonLabel="Новый уровень"
          onButtonClick={() => setFormModal({ show: true, level: null })}
        />
      </div>

      <LevelsTable
        levels={levels}
        sort={sort}
        onSort={handleSort}
        onEdit={(l) => setFormModal({ show: true, level: l })}
        onDelete={handleDelete}
      />

      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={setCurrentPage}
      />

      {confirmModal.show && (
        <ConfirmModal
          message="Удалить уровень?"
          onConfirm={confirmModal.callback}
          onCancel={() => setConfirmModal({ show: false, callback: null })}
        />
      )}

      {formModal.show && (
        <LevelForm
          level={formModal.level}
          onSave={handleSave}
          onCancel={() => setFormModal({ show: false, level: null })}
        />
      )}
    </div>
  );
}