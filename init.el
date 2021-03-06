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
               '("gnu" . "http://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/"))
  (add-to-list 'package-archives
               (insert ) '("org" . "http://orgmode.org/elpa/"))
  (package-initialize))
(package-install 'use-package)
(require 'use-package)
;;; my-library-path
(add-to-list 'load-path "~/.emacs.d/my-elisp")
;;; package install:
(use-package package-list)
;;; basic config:
(set-locale-environment nil)
(set-language-environment "Japanese")
(use-package mozc)
(setq default-input-method "japanese-mozc")
(global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)
(global-set-key (kbd "C-\\") 'toggle-input-method)
(add-hook 'mozc-mode-hook
  (lambda()
    (define-key mozc-mode-map (kbd "<zenkaku-hankaku>") 'toggle-input-method)
    (define-key mozc-mode-map (kbd "C-\\") 'toggle-input-method)))
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(setq make-backup-files nil)
(setq auto-save-default nil)
(global-font-lock-mode t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq c-hungry-delete-key t)
(setq-default tab-width 4 indent-tabs-mode nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode 0)
(global-hl-line-mode t)
(show-paren-mode 1)
(global-set-key "\C-ct" 'toggle-truncate-lines)
(setq ring-bell-function 'ignore)
(if window-system (load-theme 'molokai t)
  (load-theme 'manoj-dark t))
(set-frame-font "Osaka－等幅 14")
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;;; kill all buffers
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(use-package whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         spaces         ; スペース
                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))

(global-whitespace-mode 1)

(defvar my/bg-color "#232323")
(set-face-attribute 'whitespace-trailing nil
                    :background my/bg-color
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :background my/bg-color
                    :foreground "LightSkyBlue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :background my/bg-color
                    :foreground "GreenYellow"
                    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
                    :background my/bg-color)

;;; Shell
(setq explicit-shell-file-name "/usr/bin/fish")
(setq shell-file-name "fish")
(setenv "SHELL" shell-file-name)
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(global-set-key [f1] 'shell)
;;; emacsclient:
(use-package server)
(unless (server-running-p)
  (server-start))
;;; exec-path-from-shell:
(exec-path-from-shell-initialize)
;;; yasnippet
(use-package yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
;;; flycheck:
(use-package flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
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
(use-package quickrun)
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
   (concat "chromium "
       (file-name-sans-extension buffer-file-name) ".html")))
(defun my-org-hooks ()
  (local-set-key "\C-co" 'org-html-open)
  (setq org-src-fontify-natively t))
(add-hook 'org-mode-hook 'my-org-hooks)
(when (require 'org-install nil t)
  (setq org-export-htmlize-output-type 'css))
(eval-after-load "org"
  '(require 'ox-gfm nil t))
;;; org-babel
(use-package ob-ruby)
(use-package ob-sh)
(use-package ob-lisp)
(use-package ob-haskell)
(use-package ob-python)
(use-package ob-ipython)
;;; junk:
(use-package open-junk-file)
(setq open-junk-file-format "~/org/junk/%Y-%m%d-%H%M%S")
(global-set-key "\C-xj" 'my-open-junk-file)
(defun my-open-junk-file ()
  (interactive)
  (setq open-junk-file-format "~/org/junk/%Y-%m%d-%H%M%S")
  (open-junk-file)
  (toggle-truncate-lines)
  (insert "#+TITLE:\n")
  (insert "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.pirilampo.org/styles/readtheorg/css/htmlize.css\"/>\n")
  (insert "#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.pirilampo.org/styles/readtheorg/css/readtheorg.css\"/>\n")
  (insert "#+HTML_HEAD: <script src=\"https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js\"></script>\n")
  (insert "#+HTML_HEAD: <script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js\"></script>\n")
  (insert "#+HTML_HEAD: <script type=\"text/javascript\" src=\"http://www.pirilampo.org/styles/lib/js/jquery.stickytableheaders.js\"></script>\n")
  (insert "#+HTML_HEAD: <script type=\"text/javascript\" src=\"http://www.pirilampo.org/styles/readtheorg/js/readtheorg.js\"></script>\n"))
(defun open-movie-file ()
  (interactive)
  (setq open-junk-file-format "~/blog/movie/")
  (open-junk-file)
  (insert "# TITLE\n\n")
  (insert "### *Introduction*\n\n")
  (insert "<!-- more -->\n\n")
  (insert "### *Staff \& Cast*\n\n")
  (insert "### *Summary*\n\n")
  (insert "### *Impressions*\n\n")
  (insert "### *Conclusion*"))

;;; haskel;
(use-package my-haskell)
;;; ruby
(use-package my-ruby)
;;; python
(use-package my-python)
;;; common lisp:
(setq inferior-lisp-program "clisp")
(use-package slime)
(slime-setup '(slime-repl slime-fancy slime-banner))
;;; markdown-mode:
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command
              (expand-file-name "~/source/peg-multimarkdown/multimarkdown")))
(use-package w3m)
(add-hook 'markdown-mode-hook 'my-markdown-mode-hook)
(defun my-markdown-mode-hook ()
  (define-key markdown-mode-map "\C-c\C-cv"
  (lambda ()
    (interactive)
    (setq html-file-name (concat (file-name-sans-extension (buffer-file-name)) ".html"))
    (markdown-export html-file-name)
    (if (one-window-p) (split-window-right))
    (other-window 1)
    (if (get-buffer "*w3m*")
        (prog2 (switch-to-buffer "*w3m*") (w3m-reload-this-page)) (w3m-find-file html-file-name))
    (other-window 1))))
;;; anything.el
(global-set-key "\C-x\C-r" 'anything-mini)
(global-set-key "\C-x\C-f" 'anything-find-files)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("54ece5659cc7acdcd529dddd78675c2972a5ac69260af4a6aec517dcea16208b" default)))
 '(package-selected-packages
   (quote
    (ox-gfm ob-ipython molokai-theme company-inf-ruby inf-ruby migemo recentf-ext yaml-mode smart-newline smart-new-line yatex w3m use-package slime org-preview-html org-wc org-pandoc open-junk-file neotree markdown-mode magit macrostep htmlize haskell-snippets flycheck-haskell flycheck fish-mode exec-path-from-shell epl quickrun dash company-ghc company auto-install atom-one-dark-theme async))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
;;; init.el ends here
