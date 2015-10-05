;; Add MELPA to package archives ----------------------------
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; start the server so the Terminal can find you
(server-start)

;; make buffer switch command auto suggestions, also for find-file command
(ido-mode 1)

;; use exec-path-from-shell so the $PATH is right
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; use GNU ls from coreutils
(setq insert-directory-program (executable-find "gls"))

;; map meta to Command instead of Option
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

;; use visual line mode while in anything derived from Text mode or Org
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

;; set up markdown-mode with the proper minor modes
(add-hook 'markdown-mode-hook 'pandoc-mode)

;; C-c m opens the current file in Marked (only on a Mac)
(defun markdown-preview-file ()
   "run Marked on the current file and revert the buffer"
   (interactive)
   (shell-command
    (format "open -a /Applications/Marked\\ 2.app %s"
            (shell-quote-argument (buffer-file-name))))
   )
 
(global-set-key "\C-cm" 'markdown-preview-file)

;; Hide the splash screen, eeew
(setq inhibit-startup-message t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (alect-light)))
 '(custom-safe-themes
   (quote
    ("7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" "d34d4f2e7464e8425ddd5964e78a598a6bda7aa6e541eace75a44cb1700e16ec" default)))
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(package-selected-packages
   (quote
    (zenburn-theme wc-mode pandoc-mode org olivetti markdown-mode exec-path-from-shell anti-zenburn-theme alect-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#ded6c5" :foreground "#262626" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :foundry "nil" :family "Source Code Pro")))))
