;;; Monokai for Emacs is a port of the popular TextMate theme Monokai by Wimer Hazenberg.
;;; https://github.com/oneKelvinSmith/monokai-emacs
(use-package monokai-theme
  :ensure t
  :init
  (load-theme 'monokai 't 't)
  (enable-theme 'monokai))

(use-package all-the-icons
  :ensure t)

;;; doom-themes --- An opinionated pack of modern color-themes
;;; https://github.com/hlissner/emacs-doom-themes
(use-package doom-themes
  :disabled
  :ensure t
  :init
  (setq doom-themes-enabled-bold t
        doom-themes-enabled-italic t)
  :config
  (load-theme 'doom-molokai t)
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme
  (doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))
