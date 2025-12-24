import React from "react";

export default function ConfirmModal({ message, onConfirm, onCancel }) {
  return (
    <div className="confirm-modal active">
      <div className="confirm-modal-content">
        <div className="confirm-modal-header">
          <h3><span className="confirm-modal-icon"></span> Подтверждение удаления</h3>
        </div>
        <div className="confirm-modal-body">{message}</div>
        <div className="confirm-modal-footer">
          <button className="btn btn-danger" onClick={onConfirm}>Удалить</button>
          <button className="btn btn-secondary" onClick={onCancel}>Отмена</button>
        </div>
      </div>
    </div>
  );
}
