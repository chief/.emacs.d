(defun my-custom-settings-fn ()
  (setq css-indent-offset 2))

(add-hook 'scss-mode-hook 'my-custom-settings-fn)
