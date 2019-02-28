(use-package org
  :ensure t
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb)))

;; org-bullets
(use-package org-bullets
  :ensure t
  :commands org-bullets-mode
  :init
  (add-hook 'org-mode-hook #'org-bullets-mode))
