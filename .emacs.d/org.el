(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))

(use-package org-bullets
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-agenda-files '("~/productivity/inbox.org"
                         "~/productivity/gtd.org"))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/productivity/inbox.org" "Tasks")
         "* TODO %?\n  %i\n  %U %a")
        ("j" "Journal" entry (file+datetree "~/productivity/journal.org")
	 "****  %<%H:%M> %? \n\t %U %a" :tree-type week)))
