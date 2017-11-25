
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

;;; diminish --- Diminished modes are minor modes with no modeline display
;;; Commentary: https://github.com/emacsmirror/diminish
(use-package diminish
  :ensure t
  :init
  (progn
    (diminish 'auto-fill-function "")))

