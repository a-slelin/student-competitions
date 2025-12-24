import React from "react";

export default function ResultsTable({ results, sort, onSort, onEdit, onDelete }) {
  if (!results.length) return <div className="empty-state">Нет данных</div>;

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
          {results.map((r) => (
            <tr key={r.code}>
              <td>{r.code}</td>
              <td>{r.name}</td>
              <td>{r.order ?? "-"}</td>
              <td>
                <div className="action-btns">
                  <button className="btn btn-secondary" onClick={() => onEdit(r)}>
                    Редактировать
                  </button>
                  <button className="btn btn-danger" onClick={() => onDelete(r.code)}>
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
