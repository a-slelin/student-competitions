import React from "react";
import { NavLink } from "react-router-dom";

export default function Sidebar() {
  const menuItems = [
    { path: "/students", label: "Студенты" },
    { path: "/competitions", label: "Соревнования" },
    { path: "/participations", label: "Участия" },
    { path: "/levels", label: "Уровни" },
    { path: "/results", label: "Результаты" },
  ];

  return (
    <aside className="sidebar">
      {menuItems.map((item) => (
        <NavLink
          key={item.path}
          to={item.path}
          className={({ isActive }) => `menu-item ${isActive ? "active" : ""}`}
        >
          {item.label}
        </NavLink>
      ))}
    </aside>
  );
}
