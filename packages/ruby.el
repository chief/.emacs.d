;;; ruby-mode--- Major mode for editing Ruby files
;;; https://svn.ruby-lang.org/cgi-bin/viewvc.cgi/trunk/misc/ruby-mode.el?view=markup
(use-package ruby-mode
  :ensure t
  :mode ("\\.rake\\'"
         "Rakefile\\'"
         "\\.gemspec\\'"
         "\\.ru\\'"
         "Gemfile\\'"
         "Guardfile\\'"
         "Capfile\\'"
         "\\.cap\\'")
  :config
  (progn
    ;; (inf-ruby-minor-mode t)
    (setq ruby-insert-encoding-magic-comment nil)))

;;; ruby-tools --- Collection of handy functions for Emacs ruby-mode
;;; https://github.com/rejeep/ruby-tools.el
(use-package ruby-tools
  :ensure t
  :diminish ""
  :init
  (add-hook 'ruby-mode-hook 'ruby-tools-mode))

;;; rbenv --- use rbenv to manage your Ruby versions within Emacs
;;; https://github.com/senny/rbenv.el
(use-package rbenv
  :ensure t
  :defer 25
  :init
  (setq rbenv-show-active-ruby-in-modeline nil)
  :config
  (global-rbenv-mode t))

(defadvice inf-ruby-console-auto (before activate-rbenv-for-robe activate)
  (rbenv-use-corresponding))

;;; rspec-mode --- An RSpec minor mode for Emacs
;;; https://github.com/pezra/rspec-mode
(use-package rspec-mode
  :ensure t
  :defer 20
  :diminish rspec-mode
  :commands rspec-mode)

;;; inf-ruby --- provides a REPL buffer connected to a Ruby subprocess.
;;; https://github.com/nonsequitur/inf-ruby
(use-package inf-ruby
  :ensure t
  :init
  (add-hook 'after-init-hook 'inf-ruby-switch-setup)
  :config
  (inf-ruby-minor-mode t))

;;; robe --- Code navigation, documentation lookup and completion for Ruby
;;; https://github.com/dgutov/robe
(use-package robe
  :ensure t
  :init
  (add-hook 'ruby-mode-hook 'robe-mode)
  :diminish ""
  :config
  (eval-after-load 'company
    '(push 'company-robe company-backends)))

