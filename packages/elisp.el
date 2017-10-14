;;; elisp-slime-nav --- Slime-style navigation of Emacs Lisp source with M-. & M-,P
;;; https://github.com/purcell/elisp-slime-nav
(use-package elisp-slime-nav
  :ensure t
  :diminish elisp-slime-nav-mode
  :config
  (add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
  (add-hook 'ielm-mode-hook 'elisp-slime-nav-mode)
  )

;;; eldoc.el --- Show function arglist or variable docstring in echo area
;;; https://github.com/emacs-mirror/emacs/blob/master/lisp/emacs-lisp/eldoc.el
(use-package eldoc
  :ensure t
  :diminish eldoc-mode
  :init
  (setq eldoc-idle-deplay 0.3)
  :config
  (set-face-attribute 'eldoc-highlight-function-argument nil
                      :underline t :foreground "green"
                      :weight 'bold)
  (add-hook 'emacs-lisp-mode-hook 'eldoc-mode)
  (add-hook 'ielm-mode-hook 'eldoc-mode)
  )

