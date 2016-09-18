;;; init.el --- my init.el
;;; Commentary:
;; Copyright (C) 2016 by Takahiro Kojima

;; Author: Takahiro Kojima <12kojima.takahiro@gmail.com>
;; URL: https://github.com/m16Takahiro/emacsfiles
;; Version: 0.01
;;; Package-Requires: (package-list)

;; MIT License

;; Copyright (c) 2016 Takahiro Kojima
;; 
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;; 
;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.
;; 
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Code:
(when (require 'package nil t)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/"))
  (add-to-list 'package-archives
	       '("org" . "http://orgmode.org/elpa/"))
  (package-initialize))
;;; my-library-path
(add-to-list 'load-path "~/.emacs.d/my-elisp")
;;; package install:
(require 'package-list)
;;; basic config:
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq make-backup-files nil)
(setq auto-save-default nil)
(global-font-lock-mode t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq c-hungry-delete-key t)
(global-linum-mode t)
(defun yel-yank ()
  "Yank to cycle kill ring."
  (interactive "*")
  (if (or (eq last-command 'yank-pop)
          (eq last-command 'yank))
      (yank-pop 1)
    (yank 1)))

(global-set-key "\C-y" 'yel-yank)
(global-set-key "\C-ct" 'toggle-truncate-lines)
(if window-system (require 'atom-one-dark-theme)
  (load-theme 'manoj-dark t))
(set-frame-font "Osaka－等幅 12")
;;; Shell
(setq explicit-shell-file-name "/usr/bin/fish")
(setq shell-file-name "fish")
(setenv "SHELL" shell-file-name)
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(global-set-key [f1] 'shell)
;;; emacsclient:
(require 'server)
(unless (server-running-p)
  (server-start))
;;; evil:
(defun after-all-loads ()
  (require 'evil)
  (evil-mode 1)
  (evil-ex-define-cmd "q[uit]" 'kill-buffer))
(add-hook 'after-init-hook 'after-all-loads)
;;; exec-path-from-shell:
(exec-path-from-shell-initialize)
;;; yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
;;; company-mode:
(global-company-mode 1)
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(set-face-attribute 'company-tooltip nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common nil
                    :foreground "black" :background "lightgrey")
(set-face-attribute 'company-tooltip-common-selection nil
                    :foreground "white" :background "steelblue")
(set-face-attribute 'company-tooltip-selection nil
                    :foreground "black" :background "steelblue")
(set-face-attribute 'company-preview-common nil
                    :background nil :foreground "lightgrey" :underline t)
(set-face-attribute 'company-scrollbar-fg nil
                    :background "orange")
(set-face-attribute 'company-scrollbar-bg nil
                    :background "gray40")
;;; quickrun:
(require 'quickrun)
(global-set-key [f5] 'quickrun)
(setq quickrun-focus-p nil)
(quickrun-add-command "haskell"
		      '((:command . "stack runghc")
			(:exec . ("%c %s")))
			:override t)
;;; org-mode:
(defun edit-my-diary ()
  (interactive)
  (find-file "~/org/diary.org"))
(global-set-key "\C-cd" 'edit-my-diary)
(defun org-html-open ()
  (interactive)
  (async-shell-command
   (concat "chromium-browser "
       (file-name-sans-extension buffer-file-name) ".html")))
(defun my-org-hooks ()
  (interactive)
  (local-set-key "\C-co" 'org-html-open)
  (setq org-src-fontify-natively t))
(add-hook 'org-mode-hook 'my-org-hooks)
(when (require 'org-install nil t)
  (setq org-export-htmlize-output-type 'css))
;;; org-babel
(require 'ob-ruby)
(require 'ob-sh)
(require 'ob-lisp)
(require 'ob-haskell)
;;; junk:
(require 'open-junk-file)
(setq open-junk-file-format "~/org/junk/%Y-%m%d-%H%M%S")
(global-set-key "\C-xj" 'my-open-junk-file)
(defun my-open-junk-file ()
  (interactive)
  (open-junk-file)
  (toggle-truncate-lines)
  (insert "#+TITLE:\n")
  (insert "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.pirilampo.org/styles/readtheorg/css/htmlize.css\"/>\n")
  (insert "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.pirilampo.org/styles/readtheorg/css/readtheorg.css\"/>\n")
  (insert "#+HTML_HEAD: <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js\"></script>\n")
  (insert "#+HTML_HEAD: <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js\"></script>\n")
  (insert "#+HTML_HEAD: <script type=\"text/javascript\" src=\"http://www.pirilampo.org/styles/lib/js/jquery.stickytableheaders.js\"></script>\n")
  (insert "#+HTML_HEAD: <script type=\"text/javascript\" src=\"http://www.pirilampo.org/styles/readtheorg/js/readtheorg.js\"></script>\n"))

;;; haskell:
(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'company-backends '(company-ghc :with company-dabbrev-code))

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
(defun my-haskell-mode-hook ()
  (interactive)
  (turn-on-haskell-indentation)
  (turn-on-haskell-doc-mode)
  (font-lock-mode)
  (imenu-add-menubar-index)
  (setq haskell-program-name "/usr/bin/stack ghci")
  (inf-haskell-mode)
  (ghc-init)
  (flymake-mode))
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)
;;; common lisp:
(setq inferior-lisp-program "clisp")
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner))
;;; markdown-mode:
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "/home/hikaru515/source/peg-multimarkdown/multimarkdown"))
(require 'w3m)
(add-hook 'markdown-mode-hook 'my-markdown-mode-hook)
(defun my-markdown-mode-hook ()
  (interactive)
  (define-key markdown-mode-map "\C-c\C-cv"
  (lambda ()
    (interactive)
    (setq html-file-name (concat (file-name-sans-extension (buffer-file-name)) ".html"))
    (markdown-export html-file-name)
    (if (one-window-p) (split-window))
    (other-window 1)
    (w3m-find-file html-file-name))))
;;; Twitter:
(setq twittering-icon-mode t)

;;; helm:
(require 'helm)
(require 'helm-config)
(helm-mode 1)
(global-set-key "\M-x" #'helm-M-x)
(global-set-key "\C-x\C-f" #'helm-find-files)
(require 'helm-ag)
(setq helm-ag-base-command "ag --nocolor --nogrou")
(global-set-key "\C-cs" 'helm-ag)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("54ece5659cc7acdcd529dddd78675c2972a5ac69260af4a6aec517dcea16208b" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
;;; init.el ends here
