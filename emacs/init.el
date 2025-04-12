(setq user-email-address "ajf44@gmail.com")

;; (add-hook 'prog-mode-hook 'display-line-numbers-mode 'relative);
;; (add-hook 'prog-mode-hook
;;           (lambda ()
;;             (setq display-line-numbers 'relative)
;;             (display-line-numbers-mode)))

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)
(setq-default tab-width 4)

(global-text-scale-adjust 10) 

;; (add-to-list 'load-path "/home/ajpf/.config/emacs/plugins/evil")
;; (require 'evil)
;; (evil-mode 1)

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(global-set-key (kbd "C-<tab>") 'switch-to-previous-buffer)

;; change the backup files to a specific direcotry ~/.emacs.d/backups
(setq backup-directory-alist
      `(("." . "~/.emacs.d/backups"))) ;; or any folder you prefer
(setq backup-by-copying t) ;; don’t clobber symlinks

(tool-bar-mode -1)
(add-hook 'prog-mode-hook #'flymake-mode)
