;; Highlights matching parenthesis
(show-paren-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;; comments
(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-;") 'toggle-comment-on-line)

;; JSON mode

;; Adding rotate window to make layout esier
;; see https://github.com/joshwnj/json-mode
(when (not (package-installed-p 'json-mode))
  (package-refresh-contents)
  (package-install 'json-mode))
;; Hierachical JSON viewer
;;  see https://github.com/DamienCassou/json-navigator
(when (not (package-installed-p 'json-navigator))
  (package-refresh-contents)
  (package-install 'json-navigator))

;; Navigation key bindings
;; New Frame
(global-set-key (kbd "M-n") 'make-frame)

;; Move to next window
(global-set-key (kbd "M-o") 'other-window)

