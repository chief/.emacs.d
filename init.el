;; Keep track of loading time
(defconst emacs-start-time (current-time))

;; Turn on debugging
(setq debug-on-error t)
(setq debug-on-quit t)

;; Initialize all ELPA packages
(require 'package)
(package-initialize)

(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(require 'cl-lib)

;; Highlight the current line
(global-hl-line-mode t)

;; Save desktop
(desktop-save-mode t)

;; Clean up obsolete buffers automatically
(require 'midnight)

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Load use-package, used for loading packages everywhere else
(require 'use-package)

;; Debug package loading
(setq use-package-verbose t)

;;; better-defaults --- A small number of better defaults for Emacs
;;; https://github.com/technomancy/better-defaults
(use-package better-defaults :ensure t)

(setq user-full-name "Giorgos Tsiftsis"
      user-mail-address "giorgos.tsiftsis@gmail.com")

;; Prefer UTF-8 everywhere: language, terminal, keyboard, buffers
(set-language-environment "UTF-8")

(set-default-coding-systems 'utf-8)

(prefer-coding-system 'utf-8)

;; Turn on syntax highlighting for all buffers
(global-font-lock-mode t)

;; Raise maximum number of logs in *Messages*
(setq message-log-max 16384)

;;
;; Low level settings
;;

;; Seed random number generator
(random t)

;; Configure the GC
(setq gc-cons-threshold (* 100 1024 1024)) ;; 100 mb

;; Set font-lock speed (https://www.emacswiki.org/emacs/FontLockSpeed)
(setq font-lock-support-mode 'jit-lock-mode
      jit-lock-stealth-time 16
      jit-lock-defer-contextually t
      jit-lock-defer-time 0.05
      jit-lock-stealth-nice 0.5)
(setq-default font-lock-multiline t)

;; Make gnutls a bit safer
(setq gnutls-min-prime-bits 4096)

;; Set large file warning to 26MB
(setq large-file-warning-threshold (* 25 1024 1024))


;;
;; Editing settings
;;

;; Delete selected region on typing
(delete-selection-mode t)

(setq-default indicate-empty-lines nil)

(setq line-move-visual t)

;; Hide mouse while typing
(setq make-pointer-invisible t)

;; Single space ends a sentence
(setq sentence-end-double-space nil)

(setq-default tab-width 2)

(setq auto-save-default t)

;;
;; Editor settings
;;

;; Turn off all kinds of modes
(when (functionp 'mouse-wheel-mode)
  (mouse-wheel-mode -1))
(when (functionp 'tooltip-mode)
  (tooltip-mode -1))
(when (functionp 'blink-cursor-mode)
  (blink-cursor-mode -1))

;; Don't blink
(when (functionp 'blink-cursor-mode)
  (blink-cursor-mode -1))

;; Don't beep
(setq ring-bell-function (lambda ()))

;; Don't show startup message
(setq inhibit-startup-screen t
      initial-major-mode 'fundamental-mode)

;; Show line and column numbers in mode line
(line-number-mode t)

(column-number-mode t)

;; Ignore case in file name completion
(setq read-file-name-completion-ignore-case t)

;; y or n should suffice
(defalias 'yes-or-no-p 'y-or-n-p)

;; Confirm when killing only on graphical session
(when (window-system)
  (setq confirm-kill-emacs 'yes-or-no-p))

;; Fix some weird color escape sequences
(setq system-uses-terminfo nil)

;; Resolve symlinks
(setq-default find-file-visit-truename t)

;; Split windows
(setq split-height-threshold nil)
(setq split-width-threshold 180)

;; Rescan for imenu changes
(set-default 'imenu-auto-rescan t)

;; Switch to unified diffs
(setq diff-switches "-u")

;; Turn on auto-fill mode in text buffers
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Never kill the *scratch* buffer
(with-current-buffer "*scratch*"
  (emacs-lock-mode 'kill))

;; Automatically revert file if changed on disk
(global-auto-revert-mode t)

;; Be quiet about reverting files
(setq auto-revert-verbose nil)

;; GUI-specific
(when (window-system)
  (setenv "EMACS_GUI" "t"))

(setq tls-program
      ;; Defaults:
      ;; '("gnutls-cli --insecure -p %p %h"
      ;;   "gnutls-cli --insecure -p %p %h --protocols ssl3"
      ;;   "openssl s_client -connect %h:%p -no_ssl2 -ign_eof")
      '("gnutls-cli -p %p %h"
        "openssl s_client -connect %h:%p -no_ssl2 -no_ssl3 -ign_eof"))

;;
;; OS-specific settings
;; --------------------

(when (eq system-type 'darwin)
  (setq ns-use-native-fullscreen nil)
  ;; brew install coreutils
  (if (executable-find "gls")
      (progn
        (setq insert-directory-program "gls")
        (setq dired-listing-switches "-lFaGh1v --group-directories-first"))
    (setq dired-listing-switches "-ahlF"))

  (defun copy-from-osx ()
    "Handle copy/paste intelligently on osx."
    (let ((pbpaste (purecopy "/usr/bin/pbpaste")))
      (if (and (eq system-type 'darwin)
               (file-exists-p pbpaste))
          (let ((tramp-mode nil)
                (default-directory "~"))
            (shell-command-to-string pbpaste)))))

  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "/usr/bin/pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

  (setq interprogram-cut-function 'paste-to-osx
        interprogram-paste-function 'copy-from-osx)

  (defun move-file-to-trash (file)
    "Use `trash' to move FILE to the system trash.
When using Homebrew, install it using \"brew install trash\"."
    (call-process (executable-find "trash")
                  nil 0 nil
                  file))

  ;; Trackpad scrolling
  (global-set-key [wheel-up] 'previous-line)
  (global-set-key [wheel-down] 'next-line)
  (global-set-key [wheel-left] 'left-char)
  (global-set-key [wheel-right] 'right-char))

;; Settings for temporary files
(setq savehist-additional-variables
      ;; also save my search entries
      '(search-ring regexp-search-ring)
      savehist-file "~/.emacs.d/savehist")
(savehist-mode t)
(setq-default save-place t)

;; Delete old backups silently
(setq delete-old-versions t)

;; use cat for shell pager
(setenv "PAGER" "cat")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comint-completion-addsuffix t)
 '(comint-get-old-input (lambda nil "") t)
 '(comint-input-ignoredups t)
 '(comint-move-point-for-output nil)
 '(comint-prompt-read-only nil)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(custom-safe-themes
   (quote
    ("8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(package-selected-packages
   (quote
    (diminish htmlize god-mode yard-mode cider indium paradox rjsx-mode gitignore-mode wisi helm-dash company-tern js2-refactor xref-js2 skewer-mode discover-my-major all-the-icons hlinum monokai-theme zenburn-theme which-key crux dockerfile-mode eshell-prompt-extras git-timemachine git-gutter magit helm-flycheck helm-flx helm-swoop helm-ag helm-projectile helm web-mode yaml-mode markdown-mode+ markdown-mode es-mode geiser paredit elisp-slime-nav ruby-tools rubocop rspec-mode robe rbenv inf-ruby js2-mode json-mode coffee-mode ac-cider paren-face clojure-mode-extra-font-locking clojure-mode flycheck-pos-tip flycheck-tip flycheck dired+ org-bullets idle-highlight-mode restclient projectile imenu-anywhere vlf ido-vertical-mode smartscan iedit undo-tree shrink-whitespace smart-tab anzu fill-column-indicator golden-ratio flx-ido smooth-scrolling smartparens ido-completing-read+ ag smex popup company symon exec-path-from-shell rainbow-delimiters beacon smart-mode-line rainbow-mode better-defaults use-package)))
 '(paradox-github-token t))

(defun my/shell-kill-buffer-sentinel (process event)
  (when (memq (process-status process) '(exit signal))
    (kill-buffer)))

(defun my/kill-process-buffer-on-exit ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                        #'my/shell-kill-buffer-sentinel))

(dolist (hook '(ielm-mode-hook term-exec-hook comint-exec-hook))
  (add-hook hook 'my/kill-process-buffer-on-exit))

(defun set-scroll-conservatively ()
  "Add to shell-mode-hook to prevent jump-scrolling on newlines in shell buffers."
  (set (make-local-variable 'scroll-conservatively) 10))

(global-set-key (kbd "<mouse-4>") 'previous-line)
(global-set-key (kbd "<mouse-5>") 'next-line)

(defadvice comint-previous-matching-input
    (around suppress-history-item-messages activate)
  "Suppress the annoying 'History item : NNN' messages from shell history isearch.
If this isn't enough, try the same thing with
comint-replace-by-expanded-history-before-point."
  (let ((old-message (symbol-function 'message)))
    (unwind-protect
        (progn (fset 'message 'ignore) ad-do-it)
      (fset 'message old-message))))

(add-hook 'shell-mode-hook 'set-scroll-conservatively)
;; truncate buffers continuously
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)
;; interpret and use ansi color codes in shell output windows
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; kill lines backward
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)
                                        (indent-according-to-mode)))

(global-set-key (kbd "C-w") 'my-kill-region-or-line)

(defun my-kill-region-or-line (&optional arg)
  "Kill active region or current line."
  (interactive "p")
  (if (use-region-p)
      (sp-kill-region (region-beginning) (region-end)) ;; strict-mode version of kill-region
    (sp-kill-whole-line))) ;; strict-mode version of kill-whole-line

(use-package discover-my-major :ensure t)

;; A quick major mode help with discover-my-major
(define-key 'help-command (kbd "C-m") 'discover-my-major)

;; add shortcuts for help command
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-i") 'info-display-manual)

(global-set-key [(control shift up)]  'move-text-up)
(global-set-key [(control shift down)]  'move-text-down)

;; Remove some backends form vc-mode
(setq vc-handled-backends '())

;; Highlight lines
(add-hook 'prog-mode-hook #'hl-line-mode)

;; Rest Client
;; -----------
(use-package restclient
  :mode ("\\.rest\\'" . restclient-mode))

(setq ns-use-srgb-colorspace t)

;; Open urls in Google Chrome
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; Fonts
;; -----
(defun my/setup-osx-fonts ()
  (interactive)
  (when (eq system-type 'darwin)
    (set-fontset-font "fontset-default" 'symbol "Monaco")
    (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)
    ;; (set-default-font "Bitstream Vera Sans Mono")
    ;; (set-default-font "Fantasque Sans Mono")
    ;; (set-default-font "Fira Mono")
    ;; (set-default-font "Source Code Pro")
    (set-face-attribute 'default nil :height 120 :weight 'normal)
    (set-face-attribute 'fixed-pitch nil :height 120 :weight 'normal)

    ;; Anti-aliasing
    (setq mac-allow-anti-aliasing t)))

(when (eq system-type 'darwin)
  (add-hook 'after-init-hook #'my/setup-osx-fonts))

(defun my/set-fringe-background ()
  "Set the fringe background to the same color as the regular background."
  (interactive)
  (setq my/fringe-background-color
        (face-background 'default))
  (custom-set-faces
   `(fringe ((t (:background ,my/fringe-background-color))))))

(add-hook 'after-init-hook #'my/set-fringe-background)

;; Indicate where a buffer starts and stops
(setq-default indicate-buffer-boundaries 'right)

;; ediff
;; -----
(use-package ediff
  :config
  (progn
    (setq
     ;; Always split nicely for wide screens
     ediff-split-window-function 'split-window-horizontally)))

;; Load packages
(add-to-list 'load-path "~/.emacs.d/packages/")

(load "init-theme")

(load "console")

(load "init-which-key")

(load "appearance")

(load "init-js")

(load "init-crux")

(load "init-tramp")

(load "error_checking")

(load "lisp")

(load "navigation")

(load "packaging")

(load "programming")

(load "init-server")

(load "visual")

(load "init-recentf")

(load "init-ruby")

(load "interface")

(load "init-org")

(when (eq system-type 'darwin)
  (add-hook 'after-init-hook #'my/setup-osx-fonts))

;; electric modes
;; --------------

;; Automatically instert pairs of characters
(electric-pair-mode 1)
(setq electric-pair-preserve-balance t
      electric-pair-delete-adjacent-pairs t
      electric-pair-open-newline-between-pairs nil)

;; Auto-indentation
(electric-indent-mode 1)

;; Ignore electric indentation for python and yaml
(defun electric-indent-ignore-mode (char)
  "Ignore electric indentation for python-mode"
  (if (or (equal major-mode 'python-mode)
          (equal major-mode 'yaml-mode))
      'no-indent
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-mode)

;; Automatic layout
(electric-layout-mode 1)

;; smart-tab
;; ---------
(use-package smart-tab
  :ensure t
  :defer t
  :diminish ""
  :init (global-smart-tab-mode 1)
  :config
  (progn
    (add-to-list 'smart-tab-disabled-major-modes 'mu4e-compose-mode)
    (add-to-list 'smart-tab-disabled-major-modes 'erc-mode)
    (add-to-list 'smart-tab-disabled-major-modes 'shell-mode)))

;; shrink-whitespace
;; -----------------
(use-package shrink-whitespace
  :bind (("M-SPC" . shrink-whitespace)
         ("M-S-SPC" . shrink-whitespace)))

;; undo-tree
;; ---------
(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode t)
  :defer t
  :diminish ""
  :config
  (progn
    (define-key undo-tree-map (kbd "C-x u") 'undo-tree-visualize)
    (define-key undo-tree-map (kbd "C-/") 'undo-tree-undo)))

;; Use it to edit every instance of a word in the buffer.
(use-package iedit
  :bind ("C-;" . iedit-mode))

;; View large files
;; (use-package vlf-setup)

;; *******************
;; Extra Functionality
;; *******************
(defadvice server-visit-files (before parse-numbers-in-lines (files proc &optional nowait) activate)
  "Open file with emacsclient with cursors positioned on requested line.
Most of console-based utilities prints filename in format
'filename:linenumber'.  So you may wish to open filename in that format.
Just call:

  emacsclient filename:linenumber

and file 'filename' will be opened and cursor set on line 'linenumber'"
  (ad-set-arg 0
              (mapcar (lambda (fn)
                        (let ((name (car fn)))
                          (if (string-match "^\\(.*?\\):\\([0-9]+\\)\\(?::\\([0-9]+\\)\\)?$" name)
                              (cons
                               (match-string 1 name)
                               (cons (string-to-number (match-string 2 name))
                                     (string-to-number (or (match-string 3 name) ""))))
                            fn))) files)))

;; Better C-a
;; See http://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/
;; Code borrowed from Prelude

(defun smart-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line]
                'smart-move-beginning-of-line)

;; Cleaning a buffer
(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defvar bad-cleanup-modes '(python-mode yaml-mode)
  "List of modes where `cleanup-buffer' should not be used")

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer. If the
buffer is one of the `bad-cleanup-modes' then only whitespace is stripped."
  (interactive)
  (unless (member major-mode bad-cleanup-modes)
    (progn
      (indent-buffer)
      (untabify-buffer)))
  (whitespace-cleanup))

;; Perform general cleanup.
(global-set-key (kbd "C-c n") #'cleanup-buffer)

;; Clean whitespace after saving
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Join on killing lines
(defun kill-and-join-forward (&optional arg)
  "If at end of line, join with following; otherwise kill line.
Deletes whitespace at join."
  (interactive "P")
  (if (and (eolp) (not (bolp)))
      (delete-indentation t)
    (kill-line arg)))

(global-set-key (kbd "C-k") 'kill-and-join-forward)

;; Join line to next line
(global-set-key (kbd "M-j")
                (lambda ()
                  (interactive)
                  (join-line -1)))

;; Font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(define-key global-map [(control shift down)] 'move-line-down)
(define-key global-map [(control shift up)] 'move-line-up)

;; **************
;; Finalize Setup
;; **************
(setq debug-on-error nil)
(setq debug-on-quit nil)

(put 'narrow-to-region 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "#272822")))))

;; Message how long it took to load everything
(let ((elapsed (float-time (time-subtract (current-time)
                                          emacs-start-time))))
  (message "Loading emacs...done (%.3fs)" elapsed))
