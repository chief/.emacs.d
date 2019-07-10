;;; rust-mode --- Emacs configuration for Rust
;;; https://github.com/rust-lang/rust-mode
(use-package rust-mode
  :ensure
  :config
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode)))
