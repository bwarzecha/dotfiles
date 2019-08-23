(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))

(use-package org-bullets
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/notes/inbox.org")

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/notes/inbox.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/notes/personal/journal.org")
	 "****  %<%H:%M> %?%a \n" :tree-type week)))
