;;; diminish --- Diminished modes are minor modes with no modeline display
;;; Commentary: https://github.com/emacsmirror/diminish
(use-package diminish
  :ensure t
  :init
  (progn
    (diminish 'auto-fill-function "")))
