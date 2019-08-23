;; ITERM2 MOUSE SUPPORT
    (unless window-system
      (require 'mouse)
      (xterm-mouse-mode t)
      (defun track-mouse (e)) 
      (setq mouse-sel-mode t)
   )