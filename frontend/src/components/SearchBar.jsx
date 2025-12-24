import React, { useState, useEffect } from "react";

export default function SearchBar({
  search,
  setSearch,
  placeholder = "Поиск",
  buttonLabel,
  onButtonClick,
}) {
  const [value, setValue] = useState(search);

  useEffect(() => {
    const handler = setTimeout(() => {
      setSearch(value.trim());
    }, 300);
    return () => clearTimeout(handler);
  }, [value, setSearch]);

  return (
    <div className="search-panel">
      <input
        type="text"
        className="search-input"
        placeholder={placeholder}
        value={value}
        onChange={(e) => setValue(e.target.value)}
      />

      {buttonLabel && (
        <button
          className="btn btn-primary"
          onClick={onButtonClick}
        >
          {buttonLabel}
        </button>
      )}
    </div>
  );
}
