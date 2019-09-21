(defvar my-packages '(paredit
		      projectile
                      clojure-mode
                      cider
		      rainbow-delimiters))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

;; Make sure clojure executable is available in path
(add-to-list 'exec-path "/usr/local/bin/")
