(defvar my-packages '(paredit
		      projectile
                      clojure-mode
                      cider
		      rainbow-delimiters))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))
