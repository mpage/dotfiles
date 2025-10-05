(setq-default indent-tabs-mode nil
              fill-column 79)

(setq visible-bell nil
      color-theme-is-global t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun insert-todays-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))
