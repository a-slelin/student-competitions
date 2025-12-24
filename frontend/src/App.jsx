import React from "react";
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import Sidebar from "./components/Sidebar.jsx";
import StudentsPage from "./pages/StudentsPage.jsx";
import CompetitionsPage from "./pages/CompetitionsPage.jsx";
import ParticipationsPage from "./pages/ParticipationsPage.jsx";
import LevelsPage from "./pages/LevelsPage.jsx";
import ResultsPage from "./pages/ResultsPage.jsx";
import StudentProfile from "./pages/StudentProfile.jsx";
import CompetitionProfile from "./pages/CompetitionProfile.jsx";

export default function App() {
  return (
    <Router>
      <div className="app-container">
        <header className="header">
          <div>
            <h1>Студенческие соревнования</h1>
            <div className="header-subtitle">
              Учет участия студентов в олимпиадах и конкурсах
            </div>
          </div>
        </header>

        <div className="container">
          <Sidebar />

          <main className="content">
            <Routes>
              <Route path="/" element={<Navigate to="/students" />} />
              <Route path="/students" element={<StudentsPage />} />
              <Route path="/students/:id" element={<StudentProfile />} />
              <Route path="/competitions" element={<CompetitionsPage />} />
              <Route path="/competitions/:id" element={<CompetitionProfile />} />
              <Route path="/participations" element={<ParticipationsPage />} />
              <Route path="/levels" element={<LevelsPage />} />
              <Route path="/results" element={<ResultsPage />} />
              <Route path="*" element={<div>404 - Страница не найдена</div>} />
            </Routes>
          </main>
        </div>
        <footer className="footer" />
      </div>
    </Router>
  );
}
