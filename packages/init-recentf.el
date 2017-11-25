;;; recentf --- setup a menu of recently opened files
;;; Commentary: https://github.com/emacs-mirror/emacs/blob/master/lisp/recentf.el
(use-package recentf
  :init
  (setq recentf-max-menu-items 100)
  :bind
  ("C-x C-r" . recentf-open-files)
  :commands recentf-mode)
