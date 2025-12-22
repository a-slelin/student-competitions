import React from "react";

export default function ParticipationsTable({
  participations,
  sort,
  setSort,
  onEdit,
  onDelete,
  onStudentClick,
  onCompetitionClick,
  loading, // добавили флаг загрузки
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

  const thClass = (col) =>
    `sortable ${
      sort.column === col
        ? sort.direction === "asc"
          ? "sort-asc"
          : "sort-desc"
        : ""
    }`;

  // --- сначала проверяем загрузку ---
  if (loading) {
    return <div className="loading">Загрузка...</div>;
  }

  // --- если данных нет ---
  if (!participations.length) {
    return <div className="empty-state">Нет записей</div>;
  }

  return (
    <div className="table-container">
      <table>
        <thead>
          <tr>
            <th className={thClass("student")} onClick={() => handleSort("student")}>
              Студент
            </th>
            <th
              className={thClass("competition")}
              onClick={() => handleSort("competition")}
            >
              Соревнование
            </th>
            <th className={thClass("level")} onClick={() => handleSort("level")}>
              Уровень
            </th>
            <th className={thClass("result")} onClick={() => handleSort("result")}>
              Результат
            </th>
            <th className={thClass("year")} onClick={() => handleSort("year")}>
              Год
            </th>
            <th className={thClass("points")} onClick={() => handleSort("points")}>
              Баллы
            </th>
            <th className={thClass("supervisor")} onClick={() => handleSort("supervisor")}>
              Руководитель
            </th>
            <th>Действия</th>
          </tr>
        </thead>

        <tbody>
          {participations.map((p) => {
            const isBlocked = p.IsBlocked;

            return (
              <tr key={p.id}>
                <td
                  className="clickable"
                  onClick={() => onStudentClick(p.studentId)}
                >
                  {p.studentName || "-"}
                </td>
                <td
                  className="clickable"
                  onClick={() => onCompetitionClick(p.competitionId)}
                >
                  {p.competitionName || "-"}
                </td>
                <td>{p.levelName || "-"}</td>
                <td>{p.resultName || "-"}</td>
                <td>{p.year || "-"}</td>
                <td>{p.points ?? "-"}</td>
                <td>{p.supervisor || "-"}</td>
                <td>
                  <div className="action-btns">
                    <button
                      className={`btn btn-secondary${isBlocked ? " blocked" : ""}`}
                      disabled={isBlocked}
                      onClick={() => !isBlocked && onEdit(p)}
                    >
                      Редактировать
                    </button>
                    <button
                      className="btn btn-danger"
                      onClick={() => onDelete(p.id)}
                    >
                      Удалить
                    </button>
                  </div>
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}
