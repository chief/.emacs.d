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
         "\\.cap\\'"
         "\\.thor\\'"
         "\\.rabl\\'"
         "Thorfile\\'"
         "Vagrantfile\\'"
         "\\.jbuilder\\'")
  :config
  (progn
    (eldoc-mode t)

    (setq ruby-insert-encoding-magic-comment nil)

    ;; hook to delete whitespaces
    (add-hook 'before-save-hook 'delete-trailing-whitespace)))

;;; ruby-tools --- Collection of handy functions for Emacs ruby-mode
;;; https://github.com/rejeep/ruby-tools.el
(use-package ruby-tools
  :ensure t
  :defer t
  :diminish ""
  :init
  (add-hook 'ruby-mode-hook 'ruby-tools-mode)
  :config
  (ruby-tools-mode t))

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
  :commands rspec-mode
  :init
  (setq rspec-autosave-buffer t)
  :config
  (add-hook 'rspec-verify-method 'rspec--autosave-buffer-maybe)
  :bind (("C-c v" . rspec-verify-single)))

;;; inf-ruby --- provides a REPL buffer connected to a Ruby subprocess.x
;;; https://github.com/nonsequitur/inf-ruby
(use-package inf-ruby
  :ensure t
  :defer t
  :init
  (add-hook 'after-init-hook 'inf-ruby-switch-setup)
  :config
  (inf-ruby-minor-mode t))

;;; robe --- Code navigation, documentation lookup and completion for Ruby
;;; https://github.com/dgutov/robe
(use-package robe
  :ensure t
  :defer t
  :init
  (add-hook 'ruby-mode-hook 'robe-mode)
  :diminish ""
  :config
  (eval-after-load 'company
    '(push 'company-robe company-backends)))

;;; rubocop --- An Emacs interface for RuboCop
;;; https://github.com/bbatsov/rubocop-emacs
(use-package rubocop
  :ensure t
  :defer t)

;;; yard-mode --- Emacs minor mode for editing YARD tags
;;; https://github.com/pd/yard-mode.el
(use-package yard-mode
  :ensure t
  :defer t
  :init
  (add-hook 'ruby-mode-hook 'yard-mode))

;;; yaml-mode --- The emacs major mode for editing files in the YAML data serialization format.
;;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode
  :ensure t
  :defer t
  :config
   (add-hook 'yaml-mode-hook
      '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent))))

;;; projectile-rails --- Emacs Rails mode based on projectile
;;; https://github.com/asok/projectile-rails
(use-package projectile-rails
  :ensure t
  :config
  ;;; (projectile-rails-global-mode)
  )
