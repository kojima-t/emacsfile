;;; haskell --- my haskell mode config and hooks
;;; Commentary:
;;; Code:
(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(use-package haskell-mode
  :mode (("\\.hs$" . haskell-mode)
         ("\\.lhs$" . literate-haskell-mode))
  :init (add-to-list 'company-backends '(company-ghc :with company-dabbrev-code))
  (setq haskell-program-name "ghci")
  :config (add-hook 'haskell-mode-hook 'my-haskell-mode-hook))
(defun my-haskell-mode-hook ()
  "My haskell mode hook."
  (haskell-indentation-mode)
  (turn-on-haskell-doc-mode)
  (font-lock-mode)
  (imenu-add-menubar-index)
  (inf-haskell-mode)
  (ghc-init)
  (define-key haskell-mode-map
    "\C-cl" (lambda ()
              (interactive)
              (inferior-haskell-load-file)
              (other-window 1))))

(provide 'my-haskell)
;;; my-haskell.el ends here
