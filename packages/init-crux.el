;;; crux --- A Collection of Ridiculously Useful eXtensions for Emacs
;;; Commentary: https://github.com/bbatsov/crux
(use-package crux
  :ensure t
  :bind
  ([remap kill-whole-line] . crux-kill-whole-line)
  ([(shift return)] . crux-smart-open-line)
  ([(control shift return)] . crux-smart-open-line-above)
  ("C-c f" . crux-recentf-ido-find-file)
  ("C-c d" . crux-duplicate-current-line-or-region)
  ("C-c k" . crux-kill-other-buffers))
