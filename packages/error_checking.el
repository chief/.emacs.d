;; flycheck
;; --------
(use-package flycheck
  :ensure t
  :defer 5
  :bind (("M-g M-n" . flycheck-next-error)
         ("M-g M-p" . flycheck-previous-error)
         ("M-g M-=" . flycheck-list-errors))
  :init (global-flycheck-mode)
  :diminish flycheck-mode
  :config
  (progn
    (setq-default flycheck-disabled-checkers '(reek-ruby emacs-lisp-checkdoc))
    (use-package flycheck-pos-tip
      :ensure t
      :init (flycheck-pos-tip-mode))
    (use-package helm-flycheck
      :ensure t
      :init (define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))))

;; Spell check and flyspell settings
;; ---------------------------------

;; Standard location of personal dictionary
(setq ispell-personal-dictionary "~/.flydict")

;; Taken from dakrone who took it mostly from
;; http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
(when (executable-find "aspell")
  (setq ispell-program-name (executable-find "aspell"))
  (setq ispell-extra-args
        (list "--sug-mode=fast" ;; ultra/fast/normal/bad-spellers
              "--lang=en_GB" ;; TODO: can this be toggled for Greek?
              "--ignore=4")))

;; hunspell
(when (executable-find "hunspell")
  (setq ispell-program-name (executable-find "hunspell"))
  (setq ispell-extra-args '("-d en_GB")))

;; blindly copy-pasting here:
(add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))
(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

(defun my/enable-flyspell-prog-mode ()
  (interactive)
  (flyspell-prog-mode))

(use-package flyspell
  :defer t
  :diminish ""
  :init (add-hook 'prog-mode-hook #'my/enable-flyspell-prog-mode))

(use-package flycheck-tip
  :ensure t)

