;;; haskell --- my haskell mode config and hooks
;;; Commentary:
;;; Code:
(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(defun my-haskell-mode-hook ()
  (interactive)
  (turn-on-haskell-indentation)
  (turn-on-haskell-doc-mode)
  (font-lock-mode)
  (imenu-add-menubar-index)
  (add-to-list 'company-backends '(company-ghc :with company-dabbrev-code))
  (setq haskell-program-name "/usr/bin/stack ghci")
  (inf-haskell-mode)
  (ghc-init)
  ;;;(flycheck-mode)
  (smart-newline-mode t))
(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(provide 'haskell)
;;; haskell.el ends here
