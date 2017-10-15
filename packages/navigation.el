;;; avy --- Jump to things in Emacs tree-style
;;; Commentary: https://github.com/abo-abo/avy
(use-package avy
  :disabled
  :ensure t
  :config
  (setq avy-background t)
  (setq avy-style 'at-full))

;;; windmove.el --- directional window-selection routines
;;; https://github.com/emacs-mirror/emacs/blob/master/lisp/windmove.el
(use-package windmove
  :init
  (setq windmove-wrap-around t)
  :config
  (windmove-default-keybindings))
