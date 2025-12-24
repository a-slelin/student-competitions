import React from "react";

export default function StudentsTable({
  students,
  sort,
  setSort,
  onRowClick,
  onEdit,
  onDelete,
}) {
  function handleSort(column) {
    if (sort.column === column) {
      setSort({
        column,
        direction: sort.direction === "asc" ? "desc" : "asc",
      });
    } else {
      setSort({ column, direction: "asc" });
    }
  }

  return (
    <div className="table-container">
      <table id="students-table">
        <thead>
          <tr>
            {[
              "surname",
              "name",
              "middleName",
              "cardNumber",
              "faculty",
              "studyGroup",
            ].map((col) => (
              <th
                key={col}
                className={`sortable ${
                  sort.column === col
                    ? sort.direction === "asc"
                      ? "sort-asc"
                      : "sort-desc"
                    : ""
                }`}
                onClick={() => handleSort(col)}
              >
                {col === "surname"
                  ? "Фамилия"
                  : col === "name"
                  ? "Имя"
                  : col === "middleName"
                  ? "Отчество"
                  : col === "cardNumber"
                  ? "№ билета"
                  : col === "faculty"
                  ? "Факультет"
                  : col === "studyGroup"
                  ? "Группа"
                  : col}
              </th>
            ))}
            <th>Действия</th>
          </tr>
        </thead>

        <tbody>
          {students.length === 0 ? (
            <tr>
              <td colSpan="7">
                <div className="empty-state">
                  <div className="empty-state-title">Нет записей</div>
                </div>
              </td>
            </tr>
          ) : (
            students.map((st) => (
              <tr key={st.id} onClick={() => onRowClick(st.id)}>
                <td>{st.surname || ""}</td>
                <td>{st.name || ""}</td>
                <td>{st.middleName || ""}</td>
                <td>{st.cardNumber || "-"}</td>
                <td>{st.faculty || "-"}</td>
                <td>{st.studyGroup || "-"}</td>
                <td>
                  <div className="action-btns">
                    <button
                      className="btn btn-secondary"
                      onClick={(e) => {
                        e.stopPropagation();
                        onEdit(st);
                      }}
                    >
                      Редактировать
                    </button>

                    <button
                      className="btn btn-danger"
                      onClick={(e) => {
                        e.stopPropagation();
                        onDelete(st.id);
                      }}
                    >
                      Удалить
                    </button>
                  </div>
                </td>
              </tr>
            ))
          )}
        </tbody>
      </table>
    </div>
  );
}
