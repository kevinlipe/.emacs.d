;; Kevin's fancy dumb Emacs tricks

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

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(custom-enabled-themes (quote (anti-zenburn)))
 '(custom-safe-themes
   (quote
    ("76659fd7fc5ce57d14dfb22b30aac6cf0d4eb0a279f4131be3945d3cfff10bc6" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "d34d4f2e7464e8425ddd5964e78a598a6bda7aa6e541eace75a44cb1700e16ec" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(gnus-logo-colors (quote ("#0d7b72" "#adadad")) t)
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")) t)
 '(package-selected-packages
   (quote
    (wc-goal-mode magit-annex magit ox-pandoc zenburn-theme wc-mode pandoc-mode org olivetti markdown-mode exec-path-from-shell anti-zenburn-theme alect-themes)))
 '(tool-bar-mode nil))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

;; use exec-path-from-shell so the $PATH is right
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; use GNU ls from coreutils
(when (eq system-type 'darwin)
  (setq insert-directory-program (executable-find "gls")))

;; map meta to Command instead of Option
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

;; use visual line mode while in anything derived from Text mode or Org
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

;; org mode stuff, including C-c a for agenda
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; set up markdown-mode with the proper minor modes
(add-hook 'markdown-mode-hook 'pandoc-mode)
(add-hook 'markdown-mode-hook 'wc-goal-mode)

;; autoload these filetypes as markdown-mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

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

(if (eq system-type 'darwin) ;; use Source Code Pro on OS X, Hack on Linux
 ;; custom-set-faces for OS X (the "if")
     (custom-set-faces
      '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :foundry "nil" :family "Source Code Pro")))))
 ;; custom-set-faces for Linux (the "else")
   (custom-set-faces
    '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Hack"))))))

;; default options for all output formats
(setq org-pandoc-options '((standalone . t)))
;; cancel above settings only for 'docx' format
(setq org-pandoc-options-for-html '((standalone . nil)))

;; Set wc-goal-mode modeline display
(setq wc-goal-modeline-format "WC[%tw/%gw]")
