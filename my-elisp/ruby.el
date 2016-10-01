;;; ruby.el --- my ruby-mode config
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
(defun my-ruby-mode-hook ()
  (ruby-block-mode t)
  (setq ruby-block-highlight-toggle t)
  (abbrev-mode 1)
  (electric-pair-mode t)
  (electric-indent-mode t)
  (electric-layout-mode t)
  (smart-newline-mode t)
  (inf-ruby)
  (robe-mode)
  (robe-start))

(add-to-list 'company-backends '(company-robe :with company-dabbrev-code))

(provide 'ruby)
;;; ruby.el ends here
