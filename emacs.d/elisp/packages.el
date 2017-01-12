(require 'package)

(add-to-list 'package-archives
    '("melpa" .
      "http://melpa.org/packages/") t)

(package-initialize)

(defun install-packages (package-list)
  "Ensures all packages in package-list are installed"

  ;; Ensure package listings are up to date
  (when (not package-archive-contents)
    (package-refresh-contents))

  (dolist (p package-list)
    (when (not (package-installed-p p))
      (package-install p))))
