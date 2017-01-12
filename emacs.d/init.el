(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/src/go/src/github.com/dougm/goflymake")

(load "boot")

(load "backup")
(load "brkt")
(load "cosmetics")
(load "fslib")
(load "google-c-style")
(load "keybindings")
(load "misc")
(load "packages")

(install-packages '(fill-column-indicator expand-region
                    zenburn-theme python ruby-mode smex go-mode scala-mode2
                    haskell-mode protobuf-mode auto-complete flycheck
                    tuareg utop merlin go-mode jsx-mode scss-mode))

(setup-keybindings)

;; Paren mode
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face (face-background 'default))
(set-face-attribute 'show-paren-match-face nil :weight 'bold)

;; Ido-like completion for M-x
(smex-initialize)
(setq smex-save-file "~/.emacs.d/.smex-items")
(global-set-key (kbd "M-x") 'smex)

(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)

;; c
(setq-default c-basic-offset 4)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; python
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; ocaml
;; Add opam emacs directory to the load-path
(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(setq opam-bin (substring (shell-command-to-string "opam config var bin 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))
;; Use ocp-indent for indentation
(require 'ocp-indent)
(setq ocp-indent-path (concat opam-bin "/ocp-indent"))

;; Utop
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)

;; Load merlin-mode
(require 'merlin)
;; Start merlin on ocaml files
(add-hook 'tuareg-mode-hook 'merlin-mode t)
(add-hook 'caml-mode-hook 'merlin-mode t)
;; Enable auto-complete
(setq merlin-use-auto-complete-mode t)
;; Use opam switch to lookup ocamlmerlin binary
(setq merlin-command 'opam)

;; Golang
(require 'go-flymake)
(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; SCSS/SASS
;; NB - The sass binary needs to be in emacs's PATH
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(load-theme 'zenburn t)
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("405c5240a912732cac2b373354729594c56d6edee0962d5a848429a4e4e3edef" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Fixed")))))
