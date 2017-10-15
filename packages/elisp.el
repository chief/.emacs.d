;;; elisp-slime-nav --- Slime-style navigation of Emacs Lisp source with M-. & M-,P
;;; https://github.com/purcell/elisp-slime-nav
(use-package elisp-slime-nav
  :ensure t
  :diminish elisp-slime-nav-mode
  :config
  (add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
  (add-hook 'ielm-mode-hook 'elisp-slime-nav-mode))

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
  (add-hook 'ielm-mode-hook 'eldoc-mode))

;;; lisp-mode.el --- Lisp mode, and its idiosyncratic commands
;;; https://github.com/emacs-mirror/emacs/blob/master/lisp/emacs-lisp/lisp-mode.el
(use-package emacs-lisp-mode
  :mode
  ("\\.el\'"
   "\\.elc\'")
  :config
  ;; change the faces for elisp regex grouping
  (set-face-foreground 'font-lock-regexp-grouping-backslash "#ff1493")
  (set-face-foreground 'font-lock-regexp-grouping-construct "#ff8c00")
  :bind
  (("M-:" . pp-eval-expression)
   :map emacs-lisp-mode-map
   ("C-c C-z" . ielm-other-window)
   ("C-x C-e" . sanityinc/eval-last-sexp-or-region)
   :map lisp-interaction-mode-map
   ("C-c C-z" . ielm-other-window)))

(defun ielm-other-window ()
  "Run ielm on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*ielm*"))
  (call-interactively 'ielm))

(defun sanityinc/eval-last-sexp-or-region (prefix)
  "Eval region from BEG to END if active, otherwise the last sexp."
  (interactive "P")
  (if (and (mark) (use-region-p))
      (eval-region (min (point) (mark)) (max (point) (mark)))
    (pp-eval-last-sexp prefix)))

;;; paren-face --- A face dedicated to lisp parentheses
;;; https://github.com/tarsius/paren-face
(use-package paren-face
  :ensure t
  :init (global-paren-face-mode))
