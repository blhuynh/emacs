;; Initialize Packages
(setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")))
(let ((default-directory "~/.emacs.d/elpa/"))
    (normal-top-level-add-subdirs-to-load-path))

;; Initialize Workspace
(require 'multiple-cursors)
(package-initialize)
(defalias 'malt 'mc/mark-all-like-this)
(setq-default show-trailing-whitespace t)
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;; (ac-config-default)
(require 'auto-complete)
(global-auto-complete-mode t)
(global-linum-mode 1)
(defun auto-complete-mode-maybe ()
  "No maybe for you. Only AC!"
  (unless (minibufferp (current-buffer))
    (auto-complete-mode 1)))
(define-key ac-complete-mode-map "\t" 'ac-complete)
(setq ac-auto-start 3)
(defalias 'om 'org-mode)

;; Save backup files in another directory
(setq backup-directory-alist '(("." ., "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 6    ; how many of the newest versions to keep
      kept-old-versions 2    ; and how many of the old
      )

;; Commenting
(defun comment-eclipse()
  (interactive)
  (let ((start (line-beginning-position))
        (end (line-end-position)))
    (when (or (not transient-mark-mode) (region-active-p))
      (setq start (save-excursion
                    (goto-char (region-beginning))
                    (beginning-of-line)
                    (point))
            end (save-excursion
                  (goto-char (region-end))
                  (end-of-line)
                  (point))))
    (comment-or-uncomment-region start end)))
(global-set-key (kbd "C-c C-;") 'comment-eclipse)

;; Untabify
(setq-default indent-tabs-mode nil) ;; no tabs by default
(add-hook 'before-save-hook (lambda() (untabify (point-min) (point-max)))) ;; untabify all on save

;; Whitespace
(defun delete-leading-whitespace (start end)
  "Delete whitespace at the beginning of each line in region."
  (interactive "*r")
  (save-excursion
    (if (not (bolp)) (forward-line 1))
        (delete-whitespace-rectangle (point) end nil)))

;; End of Line Settings
(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-unix t))
(add-hook 'file-file-hook 'find-file-check-line-endings)
(defun dos-file-endings-p () ;; automatically convert line endings to unix
  (string-match "dos" (symbol-name buffer-file-coding-system)))
(defun find-file-check-line-endings ()
  (when (dos-file-endings-p)
    (set-buffer-file-coding-system 'undecided-unix)
    (set-buffer-modified-p nil)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (manoj-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
