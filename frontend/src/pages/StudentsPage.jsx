import React, { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import StudentsTable from "../components/StudentsTable.jsx";
import SearchBar from "../components/SearchBar.jsx";
import Pagination from "../components/Pagination.jsx";
import ConfirmModal from "../components/ConfirmModal.jsx";
import StudentForm from "../components/StudentForm.jsx";

export default function StudentsPage() {
  const [students, setStudents] = useState([]);
  const [currentPage, setCurrentPage] = useState(0);
  const [pageSize] = useState(10);
  const [totalPages, setTotalPages] = useState(1);
  const [search, setSearch] = useState("");
  const [sort, setSort] = useState({ column: null, direction: "asc" });

  const [confirmModal, setConfirmModal] = useState({ show: false, id: null });
  const [formModal, setFormModal] = useState({ show: false, student: null });

  const navigate = useNavigate();

  async function loadStudents() {
    const isSearch = search.trim().length > 0;
    const url = isSearch ? "/api/students/search" : "/api/students";

    const params = new URLSearchParams({
      page: currentPage,
      size: pageSize,
    });

    if (sort.column) {
      params.append("sort", `${sort.column},${sort.direction.toUpperCase()}`);
    }

    const options = isSearch
      ? {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            filters: [{ field: "surname", operation: "like", value: search }],
          }),
        }
      : { method: "GET" };

    const res = await fetch(`${url}?${params.toString()}`, options);
    const data = await res.json();

    setStudents(data.content || []);
    setTotalPages(data.page?.totalPages ?? 1);
  }

  useEffect(() => {
    loadStudents();
  }, [currentPage, search, sort]);

  const handleSaveStudent = async (form) => {
    try {
      const res = formModal.student
        ? await fetch(`/api/students/${formModal.student.id}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(form),
          })
        : await fetch("/api/students", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(form),
          });

      if (!res.ok) {
        const text = await res.text();
        throw new Error(text || "Ошибка сохранения");
      }

      setFormModal({ show: false, student: null });
      setCurrentPage(0);
      loadStudents();
    } catch (e) {
      alert(e.message);
    }
  };

  return (
    <div className="page active">
      <div className="content-header">
        <h2>Студенты</h2>
        <SearchBar
          search={search}
          setSearch={setSearch}
          placeholder="Поиск по фамилии"
          buttonLabel="Новый студент"
          onButtonClick={() => setFormModal({ show: true, student: null })}
        />
      </div>

      <StudentsTable
        students={students}
        sort={sort}
        setSort={setSort}
        onRowClick={(id) => navigate(`/students/${id}`)}
        onEdit={(s) => setFormModal({ show: true, student: s })}
        onDelete={(id) => setConfirmModal({ show: true, id })}
      />

      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={setCurrentPage}
      />

      {confirmModal.show && (
        <ConfirmModal
          message="Удалить студента?"
          onConfirm={async () => {
            await fetch(`/api/students/${confirmModal.id}`, { method: "DELETE" });
            setConfirmModal({ show: false, id: null });
            loadStudents();
          }}
          onCancel={() => setConfirmModal({ show: false, id: null })}
        />
      )}

      {formModal.show && (
        <StudentForm
          student={formModal.student}
          onSave={handleSaveStudent}
          onCancel={() => setFormModal({ show: false, student: null })}
        />
      )}
    </div>
  );
}
