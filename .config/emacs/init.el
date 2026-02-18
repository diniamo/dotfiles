(defun smart-tab (arg)
  "Complete in minibuffer, indent if needed, otherwise expand with hippie-expand."
  (interactive "P")
  (cond
   ((minibufferp) (minibuffer-complete))
   ((use-region-p) (indent-region (region-beginning) (region-end)))
   ((looking-at "\\_>") (hippie-expand arg))
   (t (funcall indent-line-function))))

(defun set-jump (&rest _)
  "Set jump at point."
  (better-jumper-set-jump)
  nil)
(defun set-jump-a (fn &rest args)
  "Set jump at point, if the function moves it."
  (let ((origin (point-marker))
        (result (apply fn args))
        (dest (point-marker)))
    (unless (equal origin dest)
      (with-current-buffer (marker-buffer origin)
        (better-jumper-set-jump
         (if (markerp (car args))
             (car args)
           origin))))
    (set-marker origin nil)
    (set-marker dest nil)
    result)
  (better-jumper-set-jump)
  nil)

(defun project-ensure-root ()
  "Returns the root of the current project, prompting for a project, if the user isn't in one."

  (project-root (project-current t)))
(defun project-find-ripgrep ()
  "Prompt for, then search for the given regex pattern in the current project using `ripgrep-regexp'."
  (interactive)

  (let ((directory (project-ensure-root))
        (regexp (read-from-minibuffer "Regex: " (thing-at-point 'symbol))))
    (ripgrep-regexp regexp directory)))
(defun project-magit-status ()
  "Run `magit-status' in the current project."
  (interactive)

  (magit-status (project-ensure-root)))


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(require 'use-package)
(setq use-package-always-ensure t
      use-package-always-defer t)

(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox-dark-medium t)
  (set-face-background 'line-number nil)
  (set-face-background 'line-number-current-line nil))

(use-package doom-modeline
  :hook after-init)

(use-package better-jumper
  :hook after-init
  :init (keymap-set input-decode-map "C-i" [C-i])
  :config
  (advice-add 'xref-push-marker-stack :around #'set-jump-a)
  (advice-add 'avy-action-goto :before #'set-jump)
  (advice-add 'beginning-of-buffer :before #'set-jump)
  (advice-add 'end-of-buffer :before #'set-jump)
  (advice-add 'scroll-up-command :before #'set-jump)
  (advice-add 'scroll-down-command :before #'set-jump)
  (advice-add 'isearch-exit :before #'set-jump)
  :bind (([C-i] . better-jumper-jump-forward)
         ("C-o" . better-jumper-jump-backward)))

(use-package avy
  :init (setq avy-timeout-seconds 0.25
              avy-keys '(?a ?s ?d ?f ?j ?k ?l ?é))
  :bind (("C-é" . avy-goto-char-timer)
         ("M-g a" . avy-goto-line)
         ("M-g e" . avy-goto-end-of-line)
         ("M-g w" . avy-goto-word-0)))

(use-package dumb-jump
  :init
  (setq dumb-jump-default-project "~/dev"
        dumb-jump-force-searcher 'rg)
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

(use-package magit)
(use-package ripgrep)

(setq treesit-language-source-alist '((odin "https://github.com/tree-sitter-grammars/tree-sitter-odin")))
(use-package odin-ts-mode
  :vc (:url "https://github.com/Sampie159/odin-ts-mode.git")
  :mode "\\.odin\\'"
  :hook ((odin-ts-mode . indent-tabs-mode)))

(use-package gcmh
  :init (setq gcmh-idle-delay 'auto
	          gcmh-auto-idle-delay-factor 10
	          gcmh-high-cons-threshold (* 64 1024 1024))
  :hook emacs-startup)


(setq lock-file-name-transforms `((".*" ,temporary-file-directory t))
      make-backup-files nil
      auto-save-default nil
      custom-file "~/.config/emacs/custom.el"
      initial-scratch-message nil
      display-line-numbers-type 'relative
      shell-file-name "/bin/sh"
      hippie-expand-try-functions-list '(try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers))

(setq-default indent-tabs-mode nil
	          tab-width 4
	          truncate-lines t)

(set-face-attribute 'default nil :font "monospace 12")

(blink-cursor-mode -1)
(electric-pair-mode 1)
(which-key-mode 1)
(delete-selection-mode 1)
(editorconfig-mode 1)
(global-display-line-numbers-mode 1)
(repeat-mode 1)
(savehist-mode 1)

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(keymap-global-set "TAB" #'smart-tab)
(keymap-global-set "S-<return>" #'split-line)

(keymap-set project-prefix-map "m" #'project-magit-status)
(keymap-set project-prefix-map "g" #'project-find-ripgrep)
