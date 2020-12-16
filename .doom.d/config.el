;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Idle delay set to very low
(setq which-key-idle-delay 0.1)

(setq-default evil-escape-key-sequence "fd")

;; Clojure
;; -----------------------------------------------------
(setq clojure-align-forms-automatically t)

(global-set-key (kbd "TAB") #'company-indent-or-complete-common)

(add-hook 'clojure-mode-hook #'aggressive-indent-mode)
(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'evil-cleverparens-mode)
;; SPC m e f - evaluate function at point
(map! :map clojure-mode-map
        :localleader
        "ef" 'cider-eval-defun-at-point)
;; Enable checking when idle or new line
(setq flycheck-check-syntax-automatically '(save mode-enable))


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


;; -------------------------------------------------------
;; Flycheck
(after! flycheck
  (setq flycheck-check-syntax-automatically '(mode-enabled save idle-change)))

(map! :after flycheck
      :n "SPC e n" #'flycheck-next-error
      :n "SPC e n" #'flycheck-next-error
      :n "SPC e p" #'flycheck-previous-error
      :n "SPC e v" #'flycheck-verify-setup)

;; transpose-frame key binding F4
(map! :after transpose-frame
      :nv "<f4>" #'transpose-frame)
