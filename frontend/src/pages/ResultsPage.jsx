import React, { useState, useEffect } from "react";
import ResultsTable from "../components/ResultsTable.jsx";
import SearchBar from "../components/SearchBar.jsx";
import Pagination from "../components/Pagination.jsx";
import ConfirmModal from "../components/ConfirmModal.jsx";
import ResultForm from "../components/ResultForm.jsx";

export default function ResultsPage() {
  const [results, setResults] = useState([]);
  const [currentPage, setCurrentPage] = useState(0);
  const [pageSize] = useState(10);
  const [totalPages, setTotalPages] = useState(1);
  const [search, setSearch] = useState("");
  const [sort, setSort] = useState({ column: null, direction: "asc" });
  const [confirmModal, setConfirmModal] = useState({ show: false, callback: null });
  const [formModal, setFormModal] = useState({ show: false, result: null });

  // Сбрасываем страницу при изменении поиска или сортировки
  useEffect(() => setCurrentPage(0), [search, sort]);

  const loadResults = async (page = currentPage) => {
    try {
      const isSearch = search.trim().length > 0;
      const baseUrl = isSearch ? "/api/results/search" : "/api/results";

      const params = new URLSearchParams({ page, size: pageSize });

      if (sort.column) {
        // Для поля "order" сервер ожидает "sortOrder"
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
      setResults(data.content || []);
      setCurrentPage(data.page?.number ?? 0);
      setTotalPages(data.page?.totalPages ?? 1);
    } catch (err) {
      alert(err.message);
      console.error(err);
    }
  };

  useEffect(() => {
    loadResults();
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

      if (formModal.result) {
        // редактирование
        const res = await fetch(`/api/results/${formModal.result.code}`, {
          method: "PUT",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
        if (!res.ok) throw new Error("Ошибка обновления результата");
      } else {
        // создание
        payload.code = form.code;
        const res = await fetch("/api/results", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });
        if (!res.ok) throw new Error("Ошибка создания результата");
      }

      setFormModal({ show: false, result: null });
      loadResults(0);
    } catch (err) {
      alert(err.message);
      console.error(err);
    }
  };

  const handleEdit = (result) => setFormModal({ show: true, result });

  const handleDelete = (code) => {
    setConfirmModal({
      show: true,
      callback: async () => {
        try {
          const res = await fetch(`/api/results/${code}`, { method: "DELETE" });
          if (!res.ok) throw new Error("Ошибка удаления результата");
          setConfirmModal({ show: false, callback: null });
          await loadResults(currentPage);
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
        <h2>Результаты</h2>
        <SearchBar
          search={search}
          setSearch={setSearch}
          placeholder="Поиск по названию результата"
          buttonLabel="Новый результат"
          onButtonClick={() => setFormModal({ show: true, result: null })}
        />
      </div>

      <ResultsTable
        results={results}
        sort={sort}
        onSort={handleSort}
        onEdit={handleEdit}
        onDelete={handleDelete}
      />

      <div className="students-info">{results.length} записей</div>

      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={setCurrentPage}
      />

      {confirmModal.show && (
        <ConfirmModal
          message="Вы точно хотите удалить этот результат?"
          onConfirm={confirmModal.callback}
          onCancel={() => setConfirmModal({ show: false, callback: null })}
        />
      )}

      {formModal.show && (
        <ResultForm
          result={formModal.result}
          onSave={handleSave}
          onCancel={() => setFormModal({ show: false, result: null })}
        />
      )}
    </div>
  );
}
