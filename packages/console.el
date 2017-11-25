;;; exec-path-from-shell --- Make Emacs use the $PATH set up by the user's shell
;;; https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :ensure t
  :defer t
  :config
  (progn
    (setq exec-path-from-shell-variables '("JAVA_HOME"
                                           "PATH"
                                           "WORKON_HOME"
                                           "MANPATH"
                                           "LANG"))
    (exec-path-from-shell-initialize)))

;;; eshell-prompt-extras --- Display extra information and color for your eshell prompt.
;;; https://github.com/kaihaosw/eshell-prompt-extras
(use-package eshell-prompt-extras
  :ensure t
  :defer t
  :config
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda)
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  )
