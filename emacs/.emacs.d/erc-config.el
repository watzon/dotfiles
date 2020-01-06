;;; erc-config.el --- my erc config
;;  Author: Chris Watson
;;; Commentary:
;;  ERC config
;;; Code:
(add-hook 'erc-after-connect
        '(lambda (SERVER NICK)
           (cond
            ((string-match "freenode\\.net" SERVER)
             (erc-message "PRIVMSG" (format "NickServ identify %s"
                                            (getenv "IRC_PASSWORD")))))))

(require 'erc-join)
(erc-autojoin-mode 1)
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#crystal-lang" "#zig")))

(require 'erc-match)
(setq erc-keywords '("watzon"))
(erc-match-mode)

(require 'erc-track)
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))

(add-hook 'erc-mode-hook
          '(lambda ()
             (require 'erc-pcomplete)
             (pcomplete-erc-setup)
             (erc-completion-mode 1)))

(require 'erc-fill)
(erc-fill-mode t)

(require 'erc-ring)
(erc-ring-mode t)

(require 'erc-netsplit)
(erc-netsplit-mode t)

(erc-timestamp-mode t)
(setq erc-timestamp-format "[%R-%m/%d]")

(require 'erc-button)
(erc-button-mode t)

(setq erc-user-full-name "Chris Watson")
(setq erc-email-userid "cawatson1993@gmail.com")

;; logging:
(setq erc-log-insert-log-on-open nil)
(setq erc-log-channels t)
(setq erc-log-channels-directory "~/.irclogs/")
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps nil)

(defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
  (save-some-buffers t (lambda () (when (and (eq major-mode 'erc-mode)
                                             (not (null buffer-file-name)))))))

(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)
(add-hook 'erc-mode-hook '(lambda () (when (not (featurep 'xemacs))
                                       (set (make-variable-buffer-local
                                             'coding-system-for-write)
                                            'emacs-mule))))
;; end logging

;; Truncate buffers so they don't hog core.
(setq erc-max-buffer-size 20000)
(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
(setq erc-truncate-buffer-on-save t)


;; Clears out annoying erc-track-mode stuff for when we don't care.
;; Useful for when ChanServ restarts :P
(defun reset-erc-track-mode ()
  (interactive)
  (setq erc-modified-channels-alist nil)
  (erc-modified-channels-update))
(global-set-key (kbd "C-c r") 'reset-erc-track-mode)

;;; Finally, connect to the networks.
(defun irc-maybe ()
  "Connect to IRC."
  (interactive)
  (when (y-or-n-p "IRC? ")
    (erc :server "irc.freenode.net" :port 6667
                :nick "watzon" :full-name "Chris Watson")))

;;; Filter bots/users - requires lexical binding.
(defun squiddo-erc-filter-bot (channel bots)
  "Filter messages to/from bots.
CHANNEL is the name of the channel to watch.
BOTS are a list of bots (nicks) to filter."
  (message "Filtering %s channel for %s bots" channel bots)
  (let ((bot-list `()))
    (dolist (bot bots)
      (push (format "%s:" bot) bot-list)
      (push (format "<%s>" bot) bot-list))
    (message "Bot list %s" bot-list)
    (add-hook 'erc-insert-pre-hook (function (lambda (msg)
                                               (when (string-match (buffer-name) channel)
                                                 (dolist (bot-indicator bot-list)
                                                   (when (string-match bot-indicator msg)
                                                     ;(message "Filtering bot: %s" msg)
                                                     (setq erc-insert-this nil)))))))))

;;; erc-config.el ends here
