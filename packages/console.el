;;; exec-path-from-shell --- Make Emacs use the $PATH set up by the user's shell
;;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :ensure t
  :defer t
  :init
  (progn
    (setq exec-path-from-shell-variables '("JAVA_HOME"
                                           "PATH"
                                           "WORKON_HOME"
                                           "MANPATH"
                                           "LANG"))
    (exec-path-from-shell-initialize)))
