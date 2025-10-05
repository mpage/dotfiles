;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
; (package-initialize)

(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/src/go/src/github.com/dougm/goflymake")

(load "boot")

(load "backup")
(load "cosmetics")
(load "fslib")
(load "google-c-style")
(load "keybindings")
(load "misc")
(load "packages")
(load "web-mode")

(install-packages '(fill-column-indicator expand-region
                    zenburn-theme python ruby-mode smex go-mode
                    haskell-mode protobuf-mode auto-complete flycheck
                    tuareg utop merlin go-mode jsx-mode scss-mode eglot
                    markdown-mode rust-mode))


(setup-keybindings)

(require 'tramp)
(add-to-list 'tramp-methods
             '("et"
               (tramp-login-program "et")
               (tramp-login-args
                (("-p") ("8080") ("%h")))
               (tramp-remote-shell "/bin/sh")
               (tramp-remote-shell-login
                ("-l"))
               (tramp-remote-shell-args
                ("-c"))
               (tramp-default-port 8080)))

;; devvm28978.prn1.facebook.com
;; dev12169.prn1.facebook.com
(defun my-devservers (unused)
  "Let tramp auto-complete my dev server"
  (("devvm2116.prn3.facebook.com" 'nil)))

(tramp-set-completion-function "et"
 '((my-devservers "unused")))

(add-to-list 'tramp-default-method-alist '("dev" "" "et"))

;; HACK - https://github.com/joaotavora/eglot/issues/492
;; (defun project-root (project) (car (project-roots project)))

;; (require 'eglot)

;; (add-to-list 'eglot-server-programs
;;             `((c-mode c++-mode) . ("/home/mpage/fbsource/fbcode/third-party-buck/platform009/build/llvm-fb/12/bin/clangd")))

;; HACK - https://github.com/joaotavora/eglot/issues/662
(defun eglot--cmd (contact)
  (if (file-remote-p default-directory)
       (list "sh" "-c"
            (string-join
             (append (cons "stty raw > /dev/null;"
                           (mapcar #'shell-quote-argument contact))
                     '("2>" "/dev/null"))
             " "))
    contact))
;; (add-hook 'c-mode-hook 'eglot-ensure)
;; (add-hook 'c++-mode-hook 'eglot-ensure)
;; Paren mode
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match nil :weight 'bold)
(set-face-background 'show-paren-match (face-background 'default))

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
(setq-default c-basic-offset 2)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
(c-set-offset 'inextern-lang 0)

;; python
(add-hook 'python-mode-hook 'flycheck-mode)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; java
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2
                                      tab-width 2
                                      indent-tabs-mode t)))

;; markdown
(add-hook 'markdown-mode-hook 'outline-minor-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Golang
;; (require 'go-flymake)
;; (defun my-go-mode-hook ()
;;  (add-hook 'before-save-hook 'gofmt-before-save))
;; (add-hook 'go-mode-hook 'my-go-mode-hook)

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
   '("405c5240a912732cac2b373354729594c56d6edee0962d5a848429a4e4e3edef" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default))
 '(package-selected-packages
   '(rust-mode markdown-mode tramp jsonrpc eglot web-mode zenburn-theme utop tuareg smex scss-mode protobuf-mode merlin jsx-mode haskell-mode go-mode flycheck fill-column-indicator expand-region auto-complete))
 '(uniquify-buffer-name-style 'forward nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit default :extend nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Menlo")))))

;; TODO(mpage) - Ugh customize can't find this font for some reason
; (set-face-attribute 'default nil :font "fixed-6x13")

(show-paren-mode 1)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match nil :weight 'bold)
(set-face-background 'show-paren-match (face-background 'default))


;; Disable anti-aliasing
; (setq mac-allow-anti-aliasing nil)
