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

;; use exec-path-from-shell so the $PATH is right
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; use GNU ls from coreutils
(setq insert-directory-program (executable-find "gls"))

;; map meta to Command instead of Option
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

;; set up markdown-mode with the proper minor modes
(add-hook 'markdown-mode-hook 'visual-line-mode)
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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (alect-dark-alt)))
 '(custom-safe-themes
   (quote
    ("04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" default)))
 '(package-selected-packages
   (quote
    (olivetti wc-mode alect-themes org exec-path-from-shell pandoc-mode markdown-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#d5d2be" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Source Code Pro")))))
