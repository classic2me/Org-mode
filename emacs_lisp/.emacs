(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "Korean")
 '(default-input-method "korean-hangul")
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "blue4" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "raster" :family "Courier")))))

;; Added by Soochang Choe to enable Verilog Mode
(defun prepend-path ( my-path )
(setq load-path (cons (expand-file-name my-path) load-path)))
(defun append-path ( my-path )
(setq load-path (append load-path (list (expand-file-name my-path)))))
;; Look first in the directory ~/elisp for elisp files
;(prepend-path "C:/Documents and Settings/a0789116/My Documents/PROG/ELISP")
;; Load verilog mode only when needed
;(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;; Any files that end in .v should be in verilog mode
;(setq auto-mode-alist (cons '("\\.v\\'" . verilog-mode) auto-mode-alist))
;; Any files in verilog mode should have their keywords colorized
;(add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1)))

;; Add paths for color theme
(append-path "C:/Program Files (x86)/Emacs/ELISP/color-theme-6.6.0")
(append-path "C:/Program Files (x86)/Emacs/ELISP/color-theme-6.6.0/themes")

(setq-default transient-mark-mode t)   ; make mark appear
(setq case-fold-search t)              ; make searches case insensitive
;(setq case-fold-search nil)           ; make searches case sensitive
(setq-default indent-tabs-mode nil)    ; force emacs use spaces in stead of tabs
;(setq default-tab-width 4)	       ; set tab width
(setq default-tab-width 8)	       ; set tab width
;(add-hook 'python-mode-hook            ; set tab width to 4 when in python-mode
;    (function (lambda () (setq default-tab-width 4))))

(put 'narrow-to-region 'disabled nil)  ; narrow-to-region is on
(global-font-lock-mode t)              ; text highlight
(setq make-backup-files nil)
(setq auto-save-mode    nil)
;(setq-default truncate-lines t)

;;; Text mode and Auto Fill mode
; The next three lines put Emacs into Text mode
; and Auto Fill mode, and are for writers who
; want to start writing prose rather than code.
;(setq default-major-mode 'text-mode)
;(add-hook 'text-mode-hook 'text-mode-hook-identify)
;(add-hook 'text-mode-hook 'turn-on-auto-fill)
;(setq colon-double-space t)

; auto-indent
(define-key global-map (kbd "RET") 'newline-and-indent)

; line-by-line scroll
(setq scroll-step 1)

; The following executed on scratch will give you the exact font name
;(prin1-to-string (w32-select-font))
;(set-default-font "-outline-Courier New-normal-r-normal-normal-12-90-96-96-c-*-iso8859-1")

; Kill trailing white space on save
(autoload 'delete-trailing-whitespace "whitespace" nil t)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)
;(setq-default show-trailing-whitespace t)

;; Installing color-theme
; M-x color-theme-select
(require 'color-theme)
(autoload 'color-theme-word-perfect "color-theme-library" nil t)
(color-theme-word-perfect)
;(set-face-font 'menu "7x14")
(set-face-foreground 'menu "black")

;;;
;;; ediff configuration
;;;

;; Whitespace and case insensitivity
(setq ediff-diff-options "-w")
;; usage: emacs -diff file1 file2
(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))
(add-to-list 'command-switch-alist '("-diff" . command-line-diff))
;; This is what you probably want if you are using a titing window
;; manager under X, such as ratpoison.
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function (lambda (&optional arg)
                                    (if (> (frame-width) 150)
                                      (split-window-horizontally arg)
                                      (split-window-vertically arg))))
;; Some custom configuration to ediff
(defvar my-ediff-bwin-config nil "Window configuration before ediff.")
(defcustom my-ediff-bwin-reg ?b
           "*Register to be set up to hold `my-ediff-bwin-config'
configuration.")

(defvar my-ediff-bwin-config nil "Window configuration after ediff.")
(defcustom my-ediff-bwin-reg ?e
           "*Register to be used up to hold `my-ediff-bwin-config'
configuration.")

(defun my-ediff-bsh ()
  "Function to be called before any buffers or window setup for ediff."
  (setq my-ediff-bwin-config (current-window-configuration))
  (when (characterp my-ediff-bwin-reg)
    (set-register my-ediff-bwin-reg
                  (list my-ediff-bwin-config (point-marker)))))

(defun my-ediff-ash ()
  "Function to be called after buffers and window setup for ediff."
  (setq my-ediff-awin-config (current-window-configuration))
  (when (characterp my-ediff-awin-reg)
    (set-register my-ediff-awin-reg
                  (list my-ediff-awin-config (point-marker)))))

(defun my-ediff_qh ()
  "Function to be called when ediff quits."
  (when my-ediff-bwin-config
    (set-window-configuration my-ediff-bwin-config)))

(add-hook 'ediff-before-setup-hook 'my-ediff-bsh)
(add-hook 'ediff-after-setup-hook 'my-ediff-ash 'append)
(add-hook 'ediff-quit-hook 'my-ediff-qh)

(put 'upcase-region 'disabled nil)

;; kill-whole-line
(defun kill-whole-line nil
  "kills the entire line on which the cursor is located, and places the
cursor as close to its previous position as possible."
  (interactive)
  (progn
    (let ((y (current-column))
          (a (progn (beginning-of-line) (point)))
          (b (progn (forward-line 1) (point))))
       (kill-region a b)
       (move-to-column y))))
(global-set-key (kbd "<C-S-backspace>") 'kill-whole-line)
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

(global-set-key "\C-l" 'goto-line)
; Goto line like in XEmacs:
(define-key global-map (kbd "M-g") 'ffap)
; show absolute file name with full path
(defun show-file-name ()
    "Show the full path file name in the minibuffer."
    (interactive)
    (message (buffer-file-name))
    (kill-new (file-truename buffer-file-name))
)
(global-set-key [C-f1] 'show-file-name)
