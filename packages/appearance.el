
;;; smart-mode-line --- A powerful and beautiful mode-line for Emacs.
;;; https://github.com/Malabarba/smart-mode-line
(use-package smart-mode-line
  :ensure t
  :init
  (progn
    (setq sml/theme 'respectful)
    (sml/setup))
  :config
  (setq sml/shorten-directory t
        sml/shorten-modes t))
