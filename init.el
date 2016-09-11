;;; MELPA --- config:
;;; package:
(when (require 'package nil t)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize))
;;; basic config:
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq make-backup-files nil)
(setq auto-save-default nil)
(global-font-lock-mode t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(setq c-hungry-delete-key t)
(defun yel-yank ()
  "yank to cycle kill ring"
  (interactive "*")
  (if (or (eq last-command 'yank-pop)
          (eq last-command 'yank))
      (yank-pop 1)
    (yank 1)))

(global-set-key "\C-y" 'yel-yank)
;;; visual
(if window-system (require 'atom-one-dark-theme)
  (load-theme 'manoj-dark t))
(set-frame-font "Osaka－等幅 12")
;; emacsclient
(require 'server)
(unless (server-running-p)
  (server-start))

;;; enable-evil
(require 'evil)
(evil-mode 1)
(evil-ex-define-cmd "q[uit]" 'kill-buffer)
;; exec-path-from-shell
(exec-path-from-shell-initialize)

;; company-mode
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

; org-mode
(global-set-key "\C-ct" 'toggle-truncate-lines)
(defun edit-my-diary ()
  (interactive)
  (find-file "~/org/diary.org"))
(global-set-key "\C-cd" 'edit-my-diary)
; myCmd
(defun org-html-open ()
  (interactive)
  (async-shell-command
   (concat "chromium "
       (file-name-sans-extension buffer-file-name) ".html")))
(defun my-org-hooks ()
  (interactive)
  (local-set-key "\C-co" 'org-html-open)
  (setq org-src-fontify-natively t))
(add-hook 'org-mode-hook 'my-org-hooks)

; junk
(require 'open-junk-file)
(setq open-junk-file-format "~/org/junk/%Y-%m%d-%H%M%S.org")
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


;; haskell
(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal$" . haskell-cabal-mode))

(add-to-list 'company-backends 'company-ghc)

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

(setq twittering-icon-mode t)

(require 'helm)
(require 'helm-config)
(helm-mode 1)
(global-set-key "\M-x" #'helm-M-x)
(global-set-key "\C-x\C-f" #'helm-find-files)
(require 'helm-ag)
(setq helm-ag-base-command "ag --nocolor --nogrou")
(global-set-key "\C-cs" 'helm-ag)

(provide 'init)
;;; init.el ends here