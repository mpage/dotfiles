(defun rename-file-backing-buffer (new-file-name)
  "Rename the file backing the current buffer"
  (interactive
   (let ((prompt (format "Rename %s to: " (buffer-file-name))))
     (list (read-file-name prompt))))
  (rename-file (buffer-file-name) new-file-name t)
  (set-visited-file-name new-file-name t t))
