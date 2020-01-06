;;; keyboard-shortcuts.el --- keyboard shortcuts
;;  Author: Chris Watson
;;; Commentary:
;;  Keyboard shortcuts for my Emacs configuration
;;; Code:
(global-set-key (kbd "C-M-<right>") 'windmove-right)
(global-set-key (kbd "C-M-<left>") 'windmove-left)
(global-set-key (kbd "C-M-<up>") 'windmove-up)
(global-set-key (kbd "C-M-<down>") 'windmove-down)

(global-set-key (kbd "C-S-d") 'duplicate-line-or-region)

(global-set-key (kbd "S-<tab>") 'shift-right)
(global-set-key (kbd "S-<tab>") 'shift-left)

(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)

(provide 'keyboard-shortcuts)
;;; keyboard-shortcuts.el ends here
