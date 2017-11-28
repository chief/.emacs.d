;;; helm-flx --- Flx-based fuzzy sorting for helm
;;; https://github.com/PythonNut/helm-flx
(use-package helm-flx
  :ensure t
  :defer t
  :init (helm-flx-mode +1))

;;; helm-swoop --- Efficiently hopping squeezed lines powered by Emacs helm interface
;;; https://github.com/ShingoFukuyama/helm-swoop
(use-package helm-swoop
  :ensure t
  :bind (("M-i" . helm-swoop)
         ("M-I" . helm-swoop-back-to-last-point)
         ("C-c M-i" . helm-multi-swoop))
  :config
  ;; When doing isearch, hand the word over to helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  ;; From helm-swoop to helm-multi-swoop-all
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t
        ;; If this value is t, split window inside the current window
        helm-swoop-split-with-multiple-windows t
        ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
        helm-swoop-split-direction 'split-window-vertically
        ;; If nil, you can slightly boost invoke speed in exchange for text color
        helm-swoop-speed-or-color nil))


;;; ag --- An Emacs frontend to The Silver Searcher
;;; https://github.com/Wilfred/ag.el
(use-package ag
  :ensure t
  :defer t)

(use-package helm-ag
  :ensure t
  :defer t)

;;; helm -- Emacs incremental completion and selection narrowing framework
;;; https://github.com/emacs-helm/helm
(use-package helm
  :ensure t)

(use-package helm-config
  :diminish helm-mode
  :demand t
  :bind
  (("C-x C-f" . helm-find-files)
   ("M-y" . helm-show-kill-ring)
   ("C-x C-i" . helm-semantic-or-imenu)
   ("M-x" . helm-M-x)
   ("C-x b" . helm-mini)
   ("C-x C-b" . helm-buffers-list)
   ("C-h f" . helm-apropos)
   ("C-c f" . helm-recentf)
   )
  :config
  (use-package helm-files
    :defer t
    :config (setq helm-ff-file-compressed-list '("gz" "bz2" "zip" "tgz" "xz" "txz")))
  (use-package helm-buffers)
  (use-package helm-mode
    :defer t
    :diminish helm-mode
    :init (helm-mode 1))
  (use-package helm-misc)
  (use-package helm-imenu)
  (use-package helm-semantic)
  (use-package helm-ring)


  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))

  (setq
   ;; truncate long lines in helm completion
   helm-truncate-lines t
   ;; do not display invisible candidates
   helm-quick-update t
   ;; open helm buffer inside current window, don't occupy whole other window
   helm-split-window-in-side-p t
   ;; move to end or beginning of source when reaching top or bottom
   ;; of source
   helm-move-to-line-cycle-in-source t
   ;; fuzzy matching
   helm-recentf-fuzzy-match t
   helm-locate-fuzzy-match nil ;; locate fuzzy is worthless
   helm-M-x-fuzzy-match t
   helm-buffers-fuzzy-matching t
   helm-semantic-fuzzy-match t
   helm-imenu-fuzzy-match t
   helm-completion-in-region-fuzzy-match t)

  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))

  ;; ggrep is gnu grep on OSX
  (when (executable-find "ggrep")
    (setq helm-grep-default-command
          "ggrep -a -d skip %e -n%cH -e %p %f"
          helm-grep-default-recurse-command
          "ggrep -a -d recurse %e -n%cH -e %p %f")))

;;; god-mode --- Global minor mode for entering Emacs commands without modifier keys
;;; https://github.com/chrisdone/god-mode
(use-package god-mode
  :ensure t
  :bind
  ("s-g" . god-local-mode))

;;; smooth-scrolling --- Emacs smooth scrolling package
;;; https://github.com/aspiers/smooth-scrolling
(use-package smooth-scrolling
  :ensure t
  :defer t
  :init
  (add-hook 'ruby-mode-hook 'smooth-scrolling-mode)
  :config
  (setq smooth-scroll-margin 10
        scroll-margin 3
        scroll-conservatively 101
        scroll-preserve-screen-position t
        auto-window-vscroll nil))
