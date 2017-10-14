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
              ("C-M-b" . paredit-backward)))

