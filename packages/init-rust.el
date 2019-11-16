;;; rust-mode --- Emacs configuration for Rust
;;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))

(use-package toml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-mode)))
