;; Turn off the menu bar at the top of each frame because it's distracting
(menu-bar-mode -1)

;; Show line numbers
(global-linum-mode)

;; You can uncomment this to remove the graphical toolbar at the top. After
;; awhile, you won't need the toolbar.
;; (when (fboundp 'tool-bar-mode)
;;   (tool-bar-mode -1))

;; Don't show native OS scroll bars for buffers because they're redundant
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; increase font size for better readability
(set-face-attribute 'default nil :height 140)

;; No cursor blinking, it's distracting
(blink-cursor-mode 0)

;; full path in title bar
(setq-default frame-title-format "%b (%f)")

;; no bell
(setq ring-bell-function 'ignore)


;; Adding rotate window to make layout esier
(when (not (package-installed-p 'rotate))
  (package-refresh-contents)
  (package-install 'rotate))


;; Line wrap
(setq-default truncate-lines 0)

;; Adding IDO mode to make file switch easier
(when (not (package-installed-p 'ido))
  (package-refresh-contents)
  (package-install 'ido))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
