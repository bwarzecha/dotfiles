  (require 'use-package-ensure)
  (setq use-package-always-ensure t)

  (use-package auto-compile
    :config (auto-compile-on-load-mode))

  (setq load-prefer-newer t)

  (setq user-full-name "Bartosz Warzecha"
	user-mail-address "bartosz@warzecha.co.uk"
	calendar-latitude 55.86
	calendar-longitude -4.25
	calendar-location-name "Glasgow, UK")

  (use-package spacemacs-theme
	:defer t
	:init
	(load-theme 'spacemacs-dark t))

;; When you visit a file, point goes to the last place where it
;; was when you previously visited the same file.
;; http://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)
(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

;; Emacs can automatically create backup files. This tells Emacs to
;; put all backups in ~/.emacs.d/backups. More info:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default nil)

;; Set CMD key to meta in UI
(if window-system
    (setq mac-command-modifier 'meta))
