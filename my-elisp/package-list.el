;;; package-list.el --- list of installed package
;;; Commentary: 
;;; define install function
(defun not-install-package-install (package-name)
  "If you have not installed arg-pkg, this function install it."
  (unless (package-installed-p package-name)
    (package-refresh-contents) (package-install package-name)))
;;; install packages:
(not-install-package-install 'async)
(not-install-package-install 'atom-one-dark-theme)
(not-install-package-install 'auto-install)
(not-install-package-install 'company)
(not-install-package-install 'company-ghc)
(not-install-package-install 'dash)
(not-install-package-install 'quickrun)
(not-install-package-install 'epl)
(not-install-package-install 'evil)
(not-install-package-install 'evil-leader)
(not-install-package-install 'evil-org)
(not-install-package-install 'exec-path-from-shell)
(not-install-package-install 'fish-mode)
(not-install-package-install 'flycheck)
(not-install-package-install 'flycheck-haskell)
(not-install-package-install 'ghc)
(not-install-package-install 'goto-chg)
(not-install-package-install 'haskell-mode)
(not-install-package-install 'haskell-snippets)
(not-install-package-install 'helm)
(not-install-package-install 'helm-ack)
(not-install-package-install 'helm-ag)
(not-install-package-install 'helm-core)
(not-install-package-install 'helm-ls-git)
(not-install-package-install 'helm-ls-hg)
(not-install-package-install 'htmlize)
(not-install-package-install 'let-alist)
(not-install-package-install 'macrostep)
(not-install-package-install 'magit)
(not-install-package-install 'markdown-mode)
(not-install-package-install 'neotree)
(not-install-package-install 'open-junk-file)
(not-install-package-install 'org)
(not-install-package-install 'org-pandoc)
(not-install-package-install 'org-wc)
(not-install-package-install 'org-preview-html)
(not-install-package-install 'org-plus-contrib)
(not-install-package-install 'pkg-info)
(not-install-package-install 'popup)
(not-install-package-install 'seq)
(not-install-package-install 'slime)
(not-install-package-install 'twittering-mode)
(not-install-package-install 'undo-tree)
(not-install-package-install 'use-package)
(not-install-package-install 'w3m)
(not-install-package-install 'yasnippet)
(not-install-package-install 'yatex)
(provide 'package-list)
;;; package-list.el ends here
