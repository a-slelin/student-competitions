import React from "react";

export default function Pagination({ currentPage, totalPages, onPageChange }) {
  return (
    <div className="pagination">
      <button
        className="page-btn"
        disabled={currentPage <= 0}
        onClick={() => onPageChange(currentPage - 1)}
      >
        &lt;
      </button>
      <span id="page-info">Страница {currentPage + 1} из {totalPages}</span>
      <button
        className="page-btn"
        disabled={currentPage >= totalPages - 1}
        onClick={() => onPageChange(currentPage + 1)}
      >
        &gt;
      </button>
    </div>
  );
}
