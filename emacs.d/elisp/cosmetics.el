(require 'uniquify)

(when window-system
  (tooltip-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))

(setq visible-bell t
      inhibit-startup-message t
      ring-bell-function 'ignore)

;; Mode-line
(line-number-mode t)
(column-number-mode t)

;(set-face-attribute 'default nil :font  "fixed-6x13")
;(set-frame-font "fixed-6x13")
