import React from "react";

export default function CompetitionsTable({
  competitions,
  sort,
  setSort,
  onEdit,
  onDelete,
  onCompetitionSelect, // новая пропса
}) {
  function handleSort(column) {
    if (!sort || sort.column !== column) {
      setSort({ column, direction: "asc" });
    } else {
      setSort({
        column,
        direction: sort.direction === "asc" ? "desc" : "asc",
      });
    }
  }

  if (!competitions.length) {
    return <div className="empty-state">Нет данных</div>;
  }

  const renderTh = (col, label) => (
    <th
      onClick={() => handleSort(col)}
      className={`sortable ${
        sort?.column === col
          ? sort.direction === "asc"
            ? "sort-asc"
            : "sort-desc"
          : ""
      }`}
    >
      {label}
    </th>
  );

  return (
    <div className="table-container">
      <table>
        <thead>
          <tr>
            {renderTh("name", "Название")}
            {renderTh("organizer", "Организатор")}
            {renderTh("type", "Тип")}
            <th>Действия</th>
          </tr>
        </thead>
        <tbody>
          {competitions.map((c) => (
            <tr key={c.id}>
              {/* Переход на профиль по клику на название */}
              <td
                className="clickable"
                onClick={() => onCompetitionSelect(c.id)}
              >
                {c.name}
              </td>
              <td>{c.organizer || "-"}</td>
              <td>{c.type || "-"}</td> {/* тип как приходит из API */}
              <td>
                <div className="action-btns">
                  <button
                    className="btn btn-secondary"
                    onClick={() => onEdit(c)}
                  >
                    Редактировать
                  </button>
                  <button
                    className="btn btn-danger"
                    onClick={() => onDelete(c.id)}
                  >
                    Удалить
                  </button>
                </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
