;; Package config
(require 'package)
(add-to-list
	'package-archives
	'("melpa" . "http://melpa.org/packages/")
	t)
(package-initialize)

(setq tags-table-list
      '("~/.emacs.d/tags"))

(load-theme 'misterioso t)
(defun gentags (&rest dirs)
  (dolist (dir dirs)
    (shell-command (format "find %s -iname '*.[chp]' | xargs etags --append --output=%s"
                           (expand-file-name dir)
                           tags-table-list))))

;; Requirements
(require 'use-package)

(use-package evil
  :ensure t)
(use-package indent-guide
  :init (indent-guide-global-mode)
  :ensure t)
(use-package ivy
  :demand
  :inti
  (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "))

(use-package ivy-rich
  :demand
  :init
  (ivy-rich-mode t))

(use-package counsel
  :ensure t)

(use-package highlight-parentheses
  :init
  (highlight-parentheses-mode 1))

(use-package smartparens
  :ensure t)

(use-package smart-tab
  :ensure t
  :init
  (smart-tab-mode 1))

(use-package multiple-cursors
  :bind ("C-c n" . mc/mark-next-like-this)
        ("C-c p" . mc/mark-previous-like-this)
        ("C-c a" . mc/mark-all-like-this)
  :init
  (multiple-cursors-mode 1)
  :ensure t)
  
(electric-pair-mode 1)

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

;; Hooks
(with-eval-after-load 'company
  (company-ctags-auto-setup))

(setq company-ctags-extra-tags-files '("$HOME/.emacs.d/tags"))

;; Indentation config
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
    (quote
     (ivy-posframe highlight-parentheses smart-tab smartparens indent-guide use-package rainbow-delimiters multiple-cursors helm-mode-manager))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
  
(defun eval-clang-format ()
  (if (file-exists-p (expand-file-name (read-file-name "Location of .clang-format: ")))
      ((shell-command (format "clang-format -style=file %s" (buffer-file-name)))
       (revert-buffer))
    (message "Could not find clang format file.")))