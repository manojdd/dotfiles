;; Bootstrap code for straight.el package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install themes
(straight-use-package 'oceanic-theme)
(straight-use-package 'nord-theme)
(straight-use-package 'dracula-theme)
(straight-use-package 'solarized-theme)
(straight-use-package 'gruvbox-theme)
(straight-use-package 'spacemacs-theme)

;; Load a theme by default(2nd argument indicates no-confirm)
(load-theme 'dracula t)

;; Evil mode to use vim key-bindings
(straight-use-package 'evil)
(evil-mode 1)

;; Helm
(straight-use-package 'helm)
(require 'helm-config)
(helm-mode 1)

;; Export package: Twitter bootstrap html
(straight-use-package 'ox-twbs)

;; Org mode bullets/superstar
(straight-use-package 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq inhibit-compacting-font-caches t)
(setq org-hide-leading-stars t)
(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "~/org/"
         :publishing-directory "~/public_html/"
         :publishing-function org-twbs-publish-to-html
         :with-sub-superscript nil
         )))
(defun my-org-publish-buffer ()
  (interactive)
  (save-buffer)
  (save-excursion (org-publish-current-file))
  (let* ((proj (org-publish-get-project-from-filename buffer-file-name))
         (proj-plist (cdr proj))
         (rel (file-relative-name buffer-file-name
                                  (plist-get proj-plist :base-directory)))
         (dest (plist-get proj-plist :publishing-directory)))
    (browse-url (concat "file://"
                        (file-name-as-directory (expand-file-name dest))
                        (file-name-sans-extension rel)
                        ".html"))))

;; Org babel load languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t)))
