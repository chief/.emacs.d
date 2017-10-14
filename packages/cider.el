(use-package cider
  :ensure t
  :defer 30
  :init
  (add-hook 'cider-mode-hook 'company-mode)
  (add-hook 'cider-repl-mode-hook 'company-mode)
  :config
  (setq cider-repl-display-help-banner nil))
