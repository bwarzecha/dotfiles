;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; {If} you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Projects
(setq projectile-project-search-path '("~/dev/" ))

;; Clojure
;;
(setq clojure-align-forms-automatically t)
(setq clojure-indent-style 'align-arguments)
(setq clojure-align-forms-automatically t)
(setq-default evil-escape-key-sequence "fd")
(setq  display-line-numbers-type nil)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)
(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)

;; clojure
(add-hook! clojure-mode
  (setq cljr-warn-on-eval nil
        cljr-eagerly-build-asts-on-startup nil
        cider-show-error-buffer 'only-in-repl)
  (require #'flycheck-clj-kondo))

(global-set-key (kbd "TAB") #'company-indent-or-complete-common)

;;; :lang org
;; Config mostly stolen from:        http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
(after! org
  (setq org-directory "~/org/"
        org-hide-emphasis-markers t
        org-superstar-leading-bullet '("⊚" "⊙" "◎" "◌" "●" ))
  (setq org-agenda-files '("~/org/areas.org"
                           "~/org/projects.org"
                           "~/org/resources.org"))

  (setq org-capture-templates
        '(("t" "Todo" entry (file "~/org/inbox.org")
	         "* TODO %?\n  %i")
          ("d" "Diary" entry (file+datetree "~/org/log.org")
	         "****  %<%H:%M> %? " :tree-type week)
          ))
  (setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (setq org-refile-allow-creating-parent-nodes t)
  (setq org-archive-location "archive/%s_archive::")
  (setq org-archive-save-context-info '(time file))
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "WAITING(w)" "INPROGRESS(i)" "UNCLEAR(u)" "|" "CANCELLED(c)" "DONE(d)")
                (sequence "SOMEDAY(s)" "|" "CANCELLED(c)"))))

  (setq
   ;; Coloured faces for agenda/todo items
   org-todo-keyword-faces
   '(
     ("DONE" . (:foreground "#588da8" :weight bold  :strike-through t))
     ("TODO" . (:foreground "#a8e6cf" :weight bold))
     ("WAITING" . (:foreground "#fde2e2" :weight bold))
     ("INPROGRESS" .  (:foreground "#ffd3b6" :weight bold))
     ("CANCELLED" . (:foreground "#a8d3da" :weight bold :strike-through t))
     ("SOMEDAY" . (:foreground "#ab82ff" :weight bold))
     )
   )
  (let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                               ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                               ((x-list-fonts "Verdana")         '(:font "Verdana"))
                               ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                               (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         (base-font-color     (face-foreground 'default nil 'default))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

    (custom-theme-set-faces 'user
                            `(org-level-8 ((t (,@headline ,@variable-tuple))))
                            `(org-level-7 ((t (,@headline ,@variable-tuple))))
                            `(org-level-6 ((t (,@headline ,@variable-tuple))))
                            `(org-level-5 ((t (,@headline ,@variable-tuple))))
                            `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
                            `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
                            `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
                            `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
                            `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))
  )

(setq org-journal-dir (concat "~/org/" "journal/"))
(setq org-journal-file-format "%Y%m%d.org")
(after! org-journal

  ;; org-journal
  (defun org-journal-save-entry-and-exit()
    "Simple convenience function.
  Saves the buffer of the current day's entry and kills the window
  Similar to org-capture like behavior"
    (interactive)
    (save-buffer)
    (kill-buffer-and-window))

  (define-key org-journal-mode-map (kbd "C-c C-c") 'org-journal-save-entry-and-exit)

  (defun get-journal-file-today ()
    "Gets filename for today's journal entry."
    (let ((daily-name (format-time-string "%Y%m%d")))
      (expand-file-name (concat org-journal-dir daily-name))))

  (defun journal-file-today ()
    "Creates and load a journal file based on today's date."
    (interactive)
    (find-file (get-journal-file-today)))

  (defun get-journal-file-yesterday ()
    "Gets filename for yesterday's journal entry."
    (let* ((yesterday (time-subtract (current-time) (days-to-time 1)))
           (daily-name (format-time-string "%Y%m%d" yesterday)))
      (expand-file-name (concat org-journal-dir daily-name))))

  (defun journal-file-yesterday ()
    "Creates and load a file based on yesterday's date."
    (interactive)
    (find-file (get-journal-file-yesterday))))

(map! :leader
      (:prefix ("j" . "journal") ;; org-journal bindings
        :desc "Create new journal entry" "j" #'org-journal-new-entry
        :desc "Open today" "t" #'journal-file-today
        :desc "Open yesterday" "y" #'journal-file-yesterday
        :desc "Search journal" "s" #'org-journal-search-forever))




;; :lang clojure
(map! :leader
      (:prefix-map ("k" . "lisp")
        :desc "sp-end-of-sexp"                  "$" #'sp-end-of-sexp
        :desc "sp-absorb-sexp"                  "a" #'sp-absorb-sexp
        :desc "sp-backward-barf-sexp"           "B" #'sp-backward-barf-sexp
        :desc "sp-forward-barf-sexp"            "b" #'sp-forward-barf-sexp
        :desc "sp-convolute-sexp"               "c" #'sp-convolute-sexp
        :desc "sp-splice-sexp-killing-backward" "E" #'sp-splice-sexp-killing-backward
        :desc "sp-splice-sexp-killing-forward"  "e" #'sp-splice-sexp-killing-forward
        :desc "sp-backward-sexp"                "H" #'sp-backward-sexp
        :desc "sp-backward-symbol"              "h" #'sp-backward-symbol
        :desc "sp-join-sexp"                    "J" #'sp-join-sexp
        :desc "sp-forward-sexp"                 "L" #'sp-forward-sexp
        :desc "sp-raise-sexp"                   "r" #'sp-raise-sexp
        :desc "sp-forward-slurp-sexp"           "s" #'sp-forward-slurp-sexp
        :desc "sp-backard-slurp-sexp"           "S" #'sp-backward-slurp-sexp
        :desc "sp-transpose-sexp"               "t" #'sp-transpose-sexp
        :desc "sp-backward-up-sexp"             "U" #'sp-backward-up-sexp
        :desc "sp-unwrap-sexp"                  "W" #'sp-unwrap-sexp
        :desc "sp-copy-sexp"                    "y" #'sp-copy-sexp))

;; company
