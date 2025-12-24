import React from "react";

export default function LevelsTable({
  levels,
  sort,
  onSort,
  onEdit,
  onDelete,
}) {
  if (!levels.length) {
    return <div className="empty-state">Нет данных</div>;
  }

  const renderTh = (label, column) => (
    <th
      className={`sortable ${
        sort.column === column
          ? sort.direction === "asc"
            ? "sort-asc"
            : "sort-desc"
          : ""
      }`}
      onClick={() => onSort(column)}
    >
      {label}
    </th>
  );

  return (
    <div className="table-container">
      <table>
        <thead>
          <tr>
            {renderTh("Код", "code")}
            {renderTh("Название", "name")}
            {renderTh("Порядок", "order")}
            <th>Действия</th>
          </tr>
        </thead>

        <tbody>
          {levels.map((l) => (
            <tr key={l.code}>
              <td>{l.code}</td>
              <td>{l.name}</td>
              <td>{l.order ?? "-"}</td>
              <td>
                <div className="action-btns">
                  <button
                    className="btn btn-secondary"
                    onClick={() => onEdit(l)}
                  >
                    Редактировать
                  </button>
                  <button
                    className="btn btn-danger"
                    onClick={() => onDelete(l.code)}
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
