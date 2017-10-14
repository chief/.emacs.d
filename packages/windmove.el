;;; windmove.el --- directional window-selection routines
;;; https://github.com/emacs-mirror/emacs/blob/master/lisp/windmove.el
(use-package windmove
  :init
  (setq windmove-wrap-around t)
  :config
  (windmove-default-keybindings))
