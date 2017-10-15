;;; whitespace.el --- minor mode to visualize TAB, (HARD) SPACE, NEWLINE
;;; https://github.com/emacs-mirror/emacs/blob/master/lisp/whitespace.el
;;; http://emacsredux.com/blog/2013/05/31/highlight-lines-that-exceed-a-certain-length-limit/
(use-package whitespace-mode
  :init
  (setq whitespace-line-column 80
        whitespace-style '(tabs newline space-mark
                                tab-mark newline-mark
                                face lines-tail trailing))

  ;; display pretty things for newlines and tabs
  (setq whitespace-display-mappings
        ;; all numbers are Unicode codepoint in decimal. e.g. (insert-char 182 1)
        ;; 32 SPACE, 183 MIDDLE DOT
        '((space-mark nil)
          ;; 10 LINE FEED
          ;;(newline-mark 10 [172 10])
          (newline-mark nil)
          ;; 9 TAB, MIDDLE DOT
          (tab-mark 9 [183 9] [92 9])))
  (add-hook 'prog-mode-hook 'whitespace-mode))


(use-package git-gutter
  :ensure t
  :defer t
  :bind (("C-x =" . git-gutter:popup-hunk)
         ("C-x P" . git-gutter:previous-hunk)
         ("C-c N" . git-gutter:next-hunk)
         ("C-x p" . git-gutter:previous-hunk)
         ("C-x n" . git-gutter:next-hunk)
         ("C-c G" . git-gutter:popup-hunk))
  :diminish ""
  :init
  (add-hook 'prog-mode-hook 'git-gutter-mode)
  (add-hook 'org-mode-hook 'git-gutter-mode))

(use-package anzu
  :ensure t
  :defer t
  :bind ("M-%" . anzu-query-replace-regexp)
  :config
  (progn
    (use-package thingatpt)
    (setq anzu-mode-lighter "")
    (set-face-attribute 'anzu-mode-line nil :foreground "yellow")))

(add-hook 'prog-mode-hook #'anzu-mode)
(add-hook 'org-mode-hook #'anzu-mode)


(use-package projectile
  :ensure t
  :defer 5
  :commands projectile-global-mode
  :diminish projectile-mode
  :config
  (bind-key "C-c p b" #'projectile-switch-to-buffer #'projectile-command-map)
  (bind-key "C-c p K" #'projectile-kill-buffers #'projectile-command-map)

  ;; global ignores
  (add-to-list 'projectile-globally-ignored-files ".tern-port")
  (add-to-list 'projectile-globally-ignored-files "GTAGS")
  (add-to-list 'projectile-globally-ignored-files "GPATH")
  (add-to-list 'projectile-globally-ignored-files "GRTAGS")
  (add-to-list 'projectile-globally-ignored-files "GSYMS")
  (add-to-list 'projectile-globally-ignored-files ".DS_Store")
  ;; always ignore .class files
  (add-to-list 'projectile-globally-ignored-file-suffixes ".class")

  (use-package helm-projectile
    :init
    (use-package grep) ;; required for helm-ag to work properly
    (setq projectile-completion-system 'helm)
    ;; no fuzziness for projectile-helm
    (setq helm-projectile-fuzzy-match nil)
    (helm-projectile-on))
  (projectile-mode))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :init (add-hook 'magit-mode-hook 'hl-line-mode)
  :config
  (setenv "GIT_PAGER" "")
  (if (file-exists-p  "/usr/local/bin/emacsclient")
      (setq magit-emacsclient-executable "/usr/local/bin/emacsclient")
    (setq magit-emacsclient-executable (executable-find "emacsclient"))))

