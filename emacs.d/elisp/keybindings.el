(defun setup-keybindings ()
  "Installs custom keybindings"

  (when (eq system-type 'darwin)
    (setq mac-option-modifier 'alt)
    (setq mac-command-modifier 'meta))

  (windmove-default-keybindings)
  (global-set-key (kbd "C-;") 'windmove-left)
  (global-set-key (kbd "C-'") 'windmove-right)

  (global-set-key (kbd "M-b") 'ido-switch-buffer)

  (global-set-key (kbd "M-u") 'browse-url-at-point)

  (global-set-key (kbd "M-=") 'er/expand-region)

  (global-set-key (kbd "C-+") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease)

  (global-set-key (kbd "M-p") 'fill-paragraph))
