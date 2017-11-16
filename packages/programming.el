;;; whitespace.el --- minor mode to visualize TAB, (HARD) SPACE, NEWLINE
;;; https://github.com/emacs-mirror/emacs/blob/master/lisp/whitespace.el
;;; http://emacsredux.com/blog/2013/05/31/highlight-lines-that-exceed-a-certain-length-limit/
(use-package whitespace-mode
  :init
  (setq whitespace-line-column 80
        whitespace-style '(tabs newline space-mark
                                tab-mark newline-mark
                                face lines-tail trailing))
  (setq-default show-trailing-whitespace t)

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


;;; git-gutter --- Emacs port of GitGutter which is Sublime Text Plugin
;;; https://github.com/syohex/emacs-git-gutter
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

;;; anzu --- Emacs Port of anzu.vim
;;; https://github.com/syohex/emacs-anzu
(use-package anzu
  :ensure t
  :defer t
  :bind ("M-%" . anzu-query-replace-regexp)
  :init
  (add-hook 'prog-mode-hook 'anzu-mode)
  (add-hook 'org-mode-hook 'anzu-mode))

;;; projectile --- Project Interaction Library for Emacs
;;; https://github.com/bbatsov/projectile
(use-package projectile
  :ensure t
  :defer 5
  :commands projectile-mode
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

  ;;; helm-projectile --- Helm UI for Projectile
  ;;; https://github.com/bbatsov/helm-projectile
  (use-package helm-projectile
    :ensure t
    :init
    (use-package grep
      :ensure t) ;; required for helm-ag to work properly
    (setq projectile-completion-system 'helm)
    ;; no fuzziness for projectile-helm
    (setq helm-projectile-fuzzy-match nil)
    (helm-projectile-on))
  (projectile-mode))

;;; magit --- It's Magit! A Git porcelain inside Emacs
;;; https://github.com/magit/magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :init (add-hook 'magit-mode-hook 'hl-line-mode)
  :config
  (setenv "GIT_PAGER" "")
  (if (file-exists-p  "/usr/local/bin/emacsclient")
      (setq magit-emacsclient-executable "/usr/local/bin/emacsclient")
    (setq magit-emacsclient-executable (executable-find "emacsclient"))))


;; highlight FIXME and TODO
(defun my/add-watchwords ()
  "Highlight FIXME, TODO and REFACTOR in code TODO"
  (font-lock-add-keywords
   nil '(("\\<\\(FIXME:?\\|TODO:?\\|REFACTOR:?\\)\\>"
          1 '((:foreground "#d7a3ad") (:weight bold)) t))))

(add-hook 'prog-mode-hook #'my/add-watchwords)

;;; smartparens --- Minor mode for Emacs that deals with parens pairs and tries to be smart about it.
;;; https://github.com/Fuco1/smartparens
(use-package smartparens
  :ensure t
  :defer 5
  :diminish smartparens-mode
  :init
  (sp-use-paredit-bindings)
  (show-smartparens-global-mode t)
  :config
  (use-package smartparens-config)
  (setq sp-base-key-bindings 'paredit)
  (setq sp-autoskip-closing-pair 'always)
  (setq sp-hybrid-kill-entire-symbol nil)
  (add-hook 'prog-mode-hook 'smartparens-mode))

;;; rainbow-delimiters --- Emacs rainbow delimiters mode
;;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;;; company-mode --- Modular in-buffer completion framework for Emacs
;;; http://company-mode.github.io
(use-package company
  :ensure t
  :defer nil
  :diminish company-mode
  :bind ("C-." . company-complete)
  :init (add-hook #'prog-mode-hook #'company-mode)
  :config
  (progn
    (add-to-list 'company-backends 'company-tern)
    (setq company-idle-delay 0.4
          ;; min prefix of 3 chars
          company-minimum-prefix-length 3
          company-selection-wrap-around t
          company-show-numbers t
          company-dabbrev-downcase nil
          company-transformers '(company-sort-by-occurrence))
    (bind-keys :map company-active-map
               ("C-n" . company-select-next)
               ("C-p" . company-select-previous)
               ("C-d" . company-show-doc-buffer)
               ("<tab>" . company-complete))))

;;; git-timemachine --- Step through historic versions of git controlled file using everyone's favourite editor
;;; https://github.com/pidu/git-timemachine
(use-package git-timemachine
  :ensure t)

;;; with-editor --- Use the Emacsclient as the $EDITOR of child processes
;;; https://github.com/magit/with-editor
(use-package with-editor
  :ensure t
  :init
  (progn
    (add-hook 'shell-mode-hook 'with-editor-export-editor)
    (add-hook 'eshell-mode-hook 'with-editor-export-editor)
    (add-hook 'term-mode-hook 'with-editor-export-editor)))

;;; dockerfile-mode --- An emacs mode for handling Dockerfiles
;;; https://github.com/spotify/dockerfile-mode
(use-package dockerfile-mode
  :ensure t
  :mode (("Dockerfile\\'" . dockerfile-mode)))

;;; subword --- Handling capitalized subwords in a nomenclature
;;; https://github.com/emacs-mirror/emacs/blob/master/lisp/progmodes/subword.el
(use-package subword
  :ensure t
  :diminish subword)

;;; markdown-mode --- Emacs Markdown Mode
;;; https://github.com/jrblevin/markdown-mode
(use-package markdown-mode
  :ensure t
  :init
  (add-hook 'markdown-mode-hook 'whitespace-mode)
  :commands (markdown-mode gfm-mode)
  :mode (("\\README\\.md\\'" . gfm-mode)
         ("github\\.com.*\\.txt\\'" . gfm-mode)
         ("\\.md\\'"          . markdown-mode)
         ("\\.markdown\\'"    . markdown-mode)))


;;; helm-dash --- Browse Dash docsets inside emacs
;;; https://github.com/areina/helm-dash
(use-package helm-dash
  :ensure t)

;;; git-modes --- Emacs major modes for various Git configuration files
;;; https://github.com/magit/git-modes
(use-package gitignore-mode
  :ensure t)


;;; paredit --- Minor mode for editing parentheses
;;; Commentary: https://github.com/emacsmirror/paredit
(use-package paredit
  :ensure t
  :commands paredit-mode
  :diminish "()"
  :bind (:map paredit-mode-map
              ("M-)" . paredit-forward-slurp-sexp)
              ("C-(" . paredit-forward-barf-sexp)
              ("C-)" . paredit-forward-slurp-sexp)
              (")" .  paredit-close-parenthesis)
              ("C-M-f" . paredit-forward)
              ("C-M-b" . paredit-backward))
  :init
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  (add-hook 'ruby-mode-hook 'paredit-mode))
