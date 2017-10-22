;;; References --- https://writequit.org/articles/working-with-logs-in-emacs.html
(use-package rails-log-mode
  :ensure t)

;; View large files
(use-package vlf
  :ensure t)

(use-package vlf-setup)

(use-package log4j-mode
  :ensure t)

;;; logview --- Emacs mode for viewing log files.
;;; https://github.com/doublep/logview
(use-package logview
  :ensure t)
