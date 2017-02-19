;;; my-python --- my python mode config and hooks
;;; Commentary:
;;; Code:
(defun my-python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi)
  (jedi:setup)
  (py-yapf-enable-on-save))

;;; using virtual environment
(use-package pyvenv
  :ensure t
  :init
  (setenv "WORKON_HOME" "/home/hikaru/.pyenv/versions/anaconda3-4.2.0/envs")
  (pyvenv-mode 1)
  (pyvenv-tracking-mode 1))

(add-hook 'python-mode-hook 'my-python-mode-hook)

(provide 'my-python)
;;; my-python.el ends here
