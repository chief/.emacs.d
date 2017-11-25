;;; server.el --- Lisp code for GNU Emacs running as server process
;;; https://github.com/emacs-mirror/emacs/blob/master/lisp/server.el
(use-package server
  :if window-system
  :init
  (add-hook 'after-init-hook 'server-start t))
