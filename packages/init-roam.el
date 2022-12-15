(use-package org-roam
  :ensure t
  :config
  (setq org-roam-directory (file-truename "~/Projects/personal/chief.github.io/notes"))
  (org-roam-db-autosync-mode))

(use-package websocket
  :ensure t
  :after org-roam)

(use-package org-roam-ui
  :ensure t
  ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; (use-package org-roam-timestamps
;;   :ensure t
;;   :config (org-roam-timestamps-mode))
