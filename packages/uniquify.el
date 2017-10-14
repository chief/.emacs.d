;;; uniquify ---  Unique buffer names dependent on file name
;;; Commentary: https://github.com/emacs-mirror/emacs/blob/master/lisp/uniquify.el
(use-package uniquify
  :init
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))
