(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
;(add-to-list 'package-archives
;            '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
;  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(setq-default indent-tabs-mode nil)
;(add-to-list 'load-path "~/.emacs.d/color-theme/")
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-deep-blue)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(coq-prog-name "/usr/local/bin/coqtop")
 '(custom-enabled-themes '(spacemacs-light))
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "e6df46d5085fde0ad56a46ef69ebb388193080cc9819e2d6024c9c6e27388ba9" "76c5b2592c62f6b48923c00f97f74bcb7ddb741618283bdb2be35f3c0e1030e3" "f3455b91943e9664af7998cc2c458cfc17e674b6443891f519266e5b3c51799d" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d431bff071bfc4c300767f2a0b29b23c7994573f7c6b5ef4c77ed680e6f44dd0" "afbb40954f67924d3153f27b6d3399df221b2050f2a72eb2cfa8d29ca783c5a8" default))
 '(fci-rule-color "#383838")
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(spacemacs-theme geiser-chez geiser-racket neotree all-the-icons racket-mode exec-path-from-shell company-coq proof-general zenburn-theme solarized-theme sml-mode rebecca-theme paredit))
 '(proof-three-window-enable t)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'default-frame-alist '(height . 48))
(add-to-list 'default-frame-alist '(width . 100))

;(require 'desktop)
;(desktop-save-mode 1)

;(load-theme #'zenburn t)

;; keys
(global-set-key (kbd "s-\\") "λ")

;; neotree
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


;;;;;;;;;;;;
;; Scheme 
;;;;;;;;;;;;
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code."
  t)

(require 'cmuscheme)
(setq scheme-program-name "/usr/local/bin/scheme")


;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))


(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window 1))
   ((not (cl-find "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))
               :test 'equal))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window -1))))


(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))


(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))

(add-hook 'racket-mode-hook
          (lambda () (paredit-mode 1)))


;; SML
;(setenv "PATH" (concat "/usr/local/smlnj/bin:" (getenv "PATH")))
;(setq exec-path (cons "/usr/local/smlnj/bin"  exec-path))

;; Proof General
;; Load company-coq when opening Coq files
(add-hook 'coq-mode-hook #'company-coq-mode)
(setq coq-compile-before-require t)

;; geiser
(setq geiser-default-implementation 'chez)
