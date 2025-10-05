(defun todo-del-line ()
  "Delete the current line and return it, sans trailing newlines"
  (let (start end line term endp)
    (progn
      (setq start (line-beginning-position))
      (setq end (line-end-position))
      (setq line (delete-and-extract-region start end))
      (setq endp (+ (point) 1))
      (if (> endp (point-max)) (setq endp (point)))
      (setq term (buffer-substring-no-properties (point) endp))
      (if (equal term "\n") (delete-char 1))
      line)))

(defun todo-insert-into-done (task)
  "Insert task into the done section"
  (save-excursion
    (let (done-start date)
      (setq done-start (re-search-forward "^# Done\n+" nil t))
      (setq date (format-time-string "%Y-%m-%d"))
      (if done-start
        (insert (format "- %s - %s\n" date task))
        (message "Couldn't find done section")
        )
      )
    )
  )

(defun todo-mark-done ()
  "Move the current line to the done section"
  (interactive)
  (let (line task)
    (setq line (todo-del-line))
    (string-match "^[\- \*]*\\(.*\\)" line)
    (setq task (match-string 1 line))
    (todo-insert-into-done task)
    ))
