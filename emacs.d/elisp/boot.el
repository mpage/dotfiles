;; This file contains code to provide a consistent platform for further initialization
;; that is independent of the underlying OS.

;; Jacked from http://stackoverflow.com/questions/8606954/path-and-exec-path-set-but-emacs-does-not-find-executable
(defun set-exec-path-from-shell ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "env NOCOWSAY=true bash -ilc 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; Mostly for OSX. Emacs.app isn't launched via the shell, so PATH/exec-path needs to be updated manually.
(if (not (getenv "TERM_PROGRAM"))
    (set-exec-path-from-shell))

;; Tweak for problem on OS X where Emacs.app doesn't run the right
;; init scripts when invoking a sub-shell
(cond
 ((eq window-system 'ns) ; macosx
  ;; Invoke login shells, so that .profile or .bash_profile is read
  (setq shell-command-switch "-lc")))
