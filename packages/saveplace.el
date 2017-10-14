;;; saveplace.el --- automatically save place in files
;;; https://github.com/emacs-mirror/emacs/blob/master/lisp/saveplace.el
(use-package saveplace
  :defer t
  :init
  (setq-default save-place t)
  (setq save-place-file (expand-file-name ".places" user-emacs-directory)))
