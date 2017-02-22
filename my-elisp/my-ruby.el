;;; my-ruby.el --- my ruby-mode config
;;; Commentary:
;;; Code:
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(use-package ruby-end)
(use-package ruby-block)
(use-package inf-ruby)
(use-package robe)
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-eval-binding "Pry.toplevel_binding")
(add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)

(add-to-list 'electric-layout-rules '(?{ . after))

(defun my-ruby-mode-hook ()
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t)
  (abbrev-mode 1)
  (electric-pair-mode t)
  (electric-indent-mode t)
  (electric-layout-mode t)
  (smart-newline-mode t)
  (robe-mode)
  (inf-ruby)
  (robe-start))

(add-hook 'ruby-mode-hook 'my-ruby-mode-hook)

(add-to-list 'company-backends '(company-robe :with company-dabbrev-code))

(use-package rbenv)
(global-rbenv-mode)
(setq rbenv-installation-dir "~/.rbenv")

(provide 'my-ruby)
;;; my-ruby.el ends here
