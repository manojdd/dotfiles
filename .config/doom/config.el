;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Load personal config (gitignored, machine-specific) — must come first
(let ((personal (expand-file-name "personal.el" doom-private-dir)))
  (when (file-exists-p personal)
    (load personal)))



;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face

(setq doom-font (font-spec :family "Aporetic Sans Mono" :size 26)
      doom-variable-pitch-font (font-spec :family "Aporetic Sans")
      doom-serif-font (font-spec :family "Aporetic Serif")
      doom-unicode-font (font-spec :family "Aporetic Sans Mono"))

;; Make org src block table output fixed-pitch
(after! org
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code  nil :inherit 'fixed-pitch))
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'catppuccin)
;; (load-theme 'catppuccin)
;; (setq catppuccin-flavor 'latte) ;; or 'latte, 'macchiato, or 'mocha
;; (catppuccin-reload)
;; (load-theme 'ef-day t)
(load-theme 'doom-feather-light t)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
;; (global-display-line-numbers-mode)

;; ────────────────────────────────────────────────────────────────────────
;; Org Mode — Basic
;; ────────────────────────────────────────────────────────────────────────

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq delete-by-moving-to-trash t)
(setq org-startup-folded 'content)

(setq org-ellipsis " ▼")

(add-hook 'org-mode-hook (lambda ()
                           "Beautify Org Checkbox Symbol"
                           (push '("[ ]" .  "🔲") prettify-symbols-alist)
                           (push '("[X]" . "✅" ) prettify-symbols-alist)
                           (push '("[-]" . "⊝" ) prettify-symbols-alist)
                           (prettify-symbols-mode)(variable-pitch-mode)(olivetti-mode)))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use 'C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ────────────────────────────────────────────────────────────────────────
;; Org Mode — TODO States
;; ────────────────────────────────────────────────────────────────────────

(setq org-todo-keywords
      '((sequence "TODO(t!)" "NEXT(n!)" "|" "DONE(d@)")
        (sequence "TOREAD" "|" "READ")
        (sequence "WAIT(w!)" "HOLD(h)" "IDEA(i)" "SOMEDAY(s)" "|" "CANCELLED(c@/!)")
        (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
        (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")
        (sequence "REMIND(r)" "REFLECT(f)" "REVIEW(v)" "|" "REVISED(R)" "DROPPED(D)")))

(setq org-log-done 'note)
(setq org-log-into-drawer t)
;; Archive setup: uses default location

;; ────────────────────────────────────────────────────────────────────────
;; Org Mode — Roam
;; ────────────────────────────────────────────────────────────────────────

(setq org-roam-directory (file-truename "~/org/roam"))
(setq org-journal-dir (concat (expand-file-name org-roam-directory) "/journals/"))
(setq org-journal-file-format "%Y_%m_%d.org")
(setq org-roam-dailies-directory (file-truename "~/org/roam/journals/"))
(setq org-roam-capture-templates
      '(("d" "default" plain
         "%?" :target
         (file+head "pages/${slug}.org" "#+title: ${title}\n")
         :unnarrowed t)))

(org-roam-db-autosync-mode)
;;(setq org-roam-v2-ack t)
(setq org-roam-completion-everywhere t)
;; Fix for org roam search by tags
(setq org-roam-node-display-template
      (concat "${title:*} "
              (propertize "${tags:10}" 'face 'org-tag)))

(defun capitalize-first-char (string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string 0 1))
          (rest-str (substring string 1)))
      (concat (capitalize first-char) rest-str))))

(defun my/org-roam-dailies-capture-with-direct-text (text)
  (org-roam-dailies-capture-today)
  (goto-char (point-max))
  (backward-char 2)
  (delete-char 1)
  (insert " " text)
  (save-buffer)
  (kill-buffer)
  (delete-frame)
  )

;; ────────────────────────────────────────────────────────────────────────
;; Org Mode — Agenda
;; ────────────────────────────────────────────────────────────────────────

(setq org-agenda-files (list "~/org/roam/mobile/Tasks.org"))
(setq org-icalendar-include-todo 'all)
(setq org-agenda-start-with-log-mode t)
(setq org-agenda-span 3)
(setq org-agenda-start-day "-1d")
(setq org-agenda-format-date
      (lambda (date)
        (concat "\n\n" (org-agenda-format-date-aligned date))))
(setq org-agenda-prefix-format '((agenda . " %i %-12:c%?-12t% s") (todo . " %i %-12:c") (tags . " %i %-12:c")
                                 (search . " %i %-12:c")))

(defun my/org-agenda-skip-if-inherited-tag (tags)
  "Skip an agenda entry if it or any of its parents have a tag in the list TAGS.
TAGS should be a list of strings, e.g., '(\"read\" \"watch\")."
  (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
    (if (catch 'found
          (dolist (tag tags)
            (when (member tag (org-get-tags-at))
              (throw 'found t)))
          nil)
        next-headline
      nil)))

(setq org-agenda-custom-commands
      '(("c" "Tasks (excluding read/watch)"
         ((agenda ""
                  ((org-agenda-skip-function
                    '(my/org-agenda-skip-if-inherited-tag '("read" "watch" "study")))))))

        ("r" "Read/Watch List"
         ((tags-todo "read|watch"
                     ((org-agenda-overriding-header "Items to Read or Watch:")))))

        ("s" "Study List"
         ((tags-todo "study"
                     ((org-agenda-overriding-header "Items to Study:")))))
        ))

(defun my/org-agenda-tab-to-show ()
  "Rebind TAB to `org-agenda-show` in Evil motion state."
  (evil-define-key 'motion evil-org-agenda-mode-map
    (kbd "<tab>") #'org-agenda-show
    (kbd "TAB") #'org-agenda-show))

(add-hook 'org-agenda-mode-hook #'my/org-agenda-tab-to-show)

(defun my/org-agenda-terminal ()
  (interactive)
  ;; (org-agenda-list)
  (org-agenda nil "c")
  ;; (doom/set-frame-opacity 70)
  (local-set-key "q" (lambda ()
                       (interactive)
                       (if (one-window-p)
                           (delete-frame (selected-frame))
                         (quit-window)))))

;; ────────────────────────────────────────────────────────────────────────
;; Org Mode — CalDAV
;; ────────────────────────────────────────────────────────────────────────

;; CalDAV URL is set in personal.el

(setq org-caldav-debug-level 2)

;; calendar ID on server
(setq org-caldav-calendar-id "c46d3e4d-1d0f-5c02-7b68-f0b171a6a568")

;; Org filename where new entries from calendar stored
(setq org-caldav-inbox "~/org/roam/mobile/caldav.org")

;; Additional Org files to check for calendar events
(setq org-caldav-files nil)

;; Usually a good idea to set the timezone manually
(setq org-icalendar-timezone "Asia/Kolkata")
(setq org-caldav-sync-todo t)
(setq org-caldav-todo-priority '((0 nil) (1 "1") (2 "1") (3 "1") (4 "1") (5 "2")))

;; ────────────────────────────────────────────────────────────────────────
;; Org Mode — LaTeX / PDF
;; ────────────────────────────────────────────────────────────────────────

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("memoir"
                 "\\documentclass{memoir}
                  [NO-DEFAULT-PACKAGES]
                  [PACKAGES]
                  [EXTRA]"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
(setq org-latex-compiler "xelatex")
(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode -output-directory %o %f"
        "xelatex -interaction nonstopmode -output-directory %o %f"))
(require 'ox-tailwind)

(setq TeX-engine 'xetex
      TeX-command-default "XeLaTeX"
      TeX-save-query nil
      TeX-show-compilation t)
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq TeX-engine 'xetex
                  +latex-viewers '(pdf-tools)
                  TeX-source-correlate-mode t
                  TeX-source-correlate-start-server t
                  TeX-auto-save t
                  TeX-parse-self t
                  TeX-save-query nil
                  TeX-PDF-mode t
                  )))
(setq TeX-PDF-mode t)       ; Always compile to PDF
(after! tex
  ;; Use pdf-tools to open PDF files inside Emacs
  (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-source-correlate-start-server t
        TeX-source-correlate-mode t))
;; Ensure pdf-tools is used by default for viewing PDFs
(after! pdf-tools
  (pdf-tools-install))

;; ────────────────────────────────────────────────────────────────────────
;; Org Mode — Capture
;; ────────────────────────────────────────────────────────────────────────

(setq org-capture-templates `(
                              ("p" "Protocol" entry (file+headline ,(concat org-directory "links.org") "Inbox")
                               "* %^{Title}\nSource: [[%:link][%:description]] \n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
                              ("L" "Protocol Link" entry (file+headline ,(concat org-directory "links.org") "Inbox")
                               "* %? [[%:link][%:description]] \nCaptured On: %U")
                              ("X" "Protocol" entry (file+headline ,(concat org-directory "links.org") "Inbox")
                               "* %? [[%:link][%:description]] \n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n \nCaptured On: %U" :immediate-finish t :empty-lines 1)
                              ))

;; ────────────────────────────────────────────────────────────────────────
;; Org Mode — Download & Screenshots
;; ────────────────────────────────────────────────────────────────────────

(setq org-id-extra-files (directory-files-recursively org-roam-directory "\.org$"))
(setq org-startup-with-inline-images t)

(after! org-download
  (setq org-download-method 'directory)
  (setq org-download-image-dir (concat org-roam-directory "/assets/"))
  (setq org-download-link-format-function
        (lambda (filename)
          (format "[[file:%s]]" filename)))
  (setq org-download-annotate-function (lambda (_link) ""))
  (setq org-download-file-format-function
        (lambda (filename)
          (let* ((base-name (file-name-sans-extension filename))
                 (ext (file-name-extension filename))
                 (timestamp (format-time-string "%Y%m%d-%H%M%S")))
            (if (and ext (member (downcase ext) '("jpg" "jpeg" "png" "gif" "webp")))
                (format "%s-%s.%s" base-name timestamp ext)
              (format "%s-%s.jpeg" base-name timestamp)))))
  (defun my/org-download--dir-2 ()
    (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))
  (defun my/org-download--dir ()
    "Return the directory path for image storage."
    (if (org-download-org-mode-p)
        (let* ((part1 org-download-image-dir)
               (part2 (my/org-download--dir-2))
               (dir (expand-file-name part2 part1)))
          (unless (file-exists-p dir)
            (make-directory dir t))
          dir)
      default-directory)))

(defun insert-screenshot-to-org-roam-daily ()
  (shell-command "gnome-screenshot -af /tmp/tmp_screenshot.png && oxipng -o max /tmp/tmp_screenshot.png && wl-copy -ot image/png < /tmp/tmp_screenshot.png")
  (org-roam-dailies-goto-today)
  (goto-char (point-max))
  (insert "* ")
  (org-download-clipboard)
  (save-buffer)
  (kill-buffer)
  (delete-frame)
  )

;; ────────────────────────────────────────────────────────────────────────
;; Utility functions
;; ────────────────────────────────────────────────────────────────────────

(defun consult-list-all-project-files () 
  "Show all project files immediately with live preview" 
  (interactive) 
  (require 'consult)
  (consult--read (project-files (project-current t)) 
                 :prompt "Project file: " 
                 :category 'file 
                 :state (consult--file-state) 
                 :require-match t))

;; ────────────────────────────────────────────────────────────────────────
;; Key Bindings
;; ────────────────────────────────────────────────────────────────────────

;; Leader key bindings
(map! :leader
      (:prefix ("k" . "roam")
       :desc "Roam find" "f" #'org-roam-node-find
       :desc "Roam tag" "t" #'org-roam-tag-add
       :desc "Roam toggle" "b" #'org-roam-buffer-toggle
       :desc "Roam insert" "i" #'org-roam-node-insert
       :desc "Roam random" "k" #'org-roam-node-random
       ;; :desc "Roam search" "s" #'(lambda () (interactive) (consult-ripgrep org-roam-directory))
       :desc "Roam search" "s" #'(lambda () (interactive) (consult-ripgrep "~/org/roam"))

       )
      ;; :desc "Roam random" "SPC" #'org-roam-node-random
      ;; :desc "Open Today's Agenda" "SPC" #'org-agenda-list
      :desc "Olivetti Mode Toggle" "SPC" #'olivetti-mode
      :desc "Daily previous" "<up>" #'org-roam-dailies-goto-previous-note
      :desc "Daily next" "<down>" #'org-roam-dailies-goto-next-note

      :desc "Search lines in current buffer" "s l" #'consult-line
      :desc "Search with rg in dir" "s g" #'consult-ripgrep
      :desc "Consult Org Agenda" "o o" #'consult-org-agenda
      :desc "Toggle repeat" "r" #'repeat-mode
      ;; :desc "Search lines across all buffers" "s L" #'consult-line-multi

      ;; LLMs
      ;; :desc "GPTel" "l l" #'gptel

      :desc "Project fd" "s f" #'consult-list-all-project-files
      )

;; Use page up and down keys to goto previous or next daily note
(evil-global-set-key 'motion (kbd "<prior>") 'org-roam-dailies-goto-previous-note)
(evil-global-set-key 'motion (kbd "<next>") 'org-roam-dailies-goto-next-note)
(evil-global-set-key 'motion (kbd "<home>") 'org-roam-node-random)
(evil-global-set-key 'motion (kbd "<end>") 'org-roam-dailies-goto-today)
;; ;; Use up and down arrow keys to goto previous or next daily note
;; (evil-global-set-key 'motion (kbd "<up>") 'org-roam-dailies-goto-previous-note)
;; (evil-global-set-key 'motion (kbd "<down>") 'org-roam-dailies-goto-next-note)

(map! "C-`" #'+vterm/toggle)

;; ────────────────────────────────────────────────────────────────────────
;; Hugo Export
;; ────────────────────────────────────────────────────────────────────────

(defun ox-hugo/export-all (&optional org-files-root-dir dont-recurse)
  "Export all Org files under ORG-FILES-ROOT-DIR using ox-hugo.
If DONT-RECURSE is non-nil, do not recurse into subdirectories."
  (interactive)
  (setq org-files-root-dir "~/org/roam")
  (setq org-hugo-base-dir my/org-hugo-base-dir)
  (let* ((org-files-root-dir (or org-files-root-dir "~/org/roam/"))
         (search-path (file-name-as-directory (expand-file-name org-files-root-dir)))
         (org-files (if dont-recurse
                        (directory-files search-path t "\\.org$")
                      (directory-files-recursively search-path "\\.org$"))))
    (if (null org-files)
        (message "No Org files found in %s" search-path)
      (progn
        (message "[ox-hugo/export-all] XExporting %d files from %s ..."
                 (length org-files) search-path)
        (dolist (org-file org-files)
          (unless (or (file-directory-p org-file)
                      (string-match-p (regexp-quote "highlights") org-file))
            (with-current-buffer (find-file-noselect org-file)
              (setq-local org-hugo-base-dir my/org-hugo-base-dir) ;; Ensure it's set for this buffer
              (setq-local org-hugo-section "posts/nonsense") ;; Ensure it's set for this buffer
              ;; Adjust links to account for flattened directory structure
              (org-element-map (org-element-parse-buffer 'link) 'link
                (lambda (link)
                  (let ((path (org-element-property :path link)))
                    (when (and (string= (org-element-property :type link) "file")
                               (string-match "\\.org$" path))
                      (let ((filename (file-name-nondirectory path)))
                        (org-element-put-property link :path filename))))))
              (org-hugo-export-wim-to-md :all-subtrees))))
        (message "CHANGED Export finished!")))))


(defun ox-hugo/export-all-with-sections (&optional org-files-root-dir)
  "Export all Org files under ORG-FILES-ROOT-DIR, handling subdirectories.
Org files in the root of ORG-FILES-ROOT-DIR are exported to \"content/posts\".
For each subdirectory, set `org-hugo-section` to \"content/posts/<subdir>\" so that
exported Markdown files land in the corresponding subdirectory within your Hugo base.
If ORG-FILES-ROOT-DIR is nil, it defaults to \"~/org/roam\"."
  (interactive)
  (let* ((org-files-root-dir (or org-files-root-dir "~/org/roam"))
         ;; Get all files in the root directory (non-recursively)
         (root-org-files (seq-filter (lambda (f)
                                       (and (file-regular-p f)
                                            (string-match-p "\\.org$" f)
                                            (not (string-match-p (regexp-quote "highlights") f))))
                                     (directory-files org-files-root-dir t "^[^.].*")))
         ;; Get all immediate subdirectories (ignoring hidden ones)
         (subdirs (seq-filter (lambda (d)
                                (and (file-directory-p d)
                                     (not (string-match-p "^\\." (file-name-nondirectory d)))))
                              (directory-files org-files-root-dir t "^[^.].*"))))

    ;; Export Org files in the root directory
    (dolist (org-file root-org-files)
      (with-current-buffer (find-file-noselect org-file)
        (setq-local org-hugo-base-dir my/org-hugo-base-dir)
        (setq-local org-hugo-section "posts")
        (org-hugo-export-wim-to-md :all-subtrees)))

    ;; Now process each subdirectory
    (dolist (subdir subdirs)
      (let ((subdir-name (file-name-nondirectory (directory-file-name subdir))))
        (message "Exporting subdirectory: %s" subdir-name)
        (let ((subdir-org-files (directory-files-recursively subdir "\\.org$")))
          (dolist (org-file subdir-org-files)
            (when (and (file-regular-p org-file)
                       (not (string-match-p (regexp-quote "highlights") org-file)))
              (with-current-buffer (find-file-noselect org-file)
                (setq-local org-hugo-base-dir my/org-hugo-base-dir)
                (setq-local org-hugo-section (concat "posts/" subdir-name))
                (org-hugo-export-wim-to-md :all-subtrees)))))))
    (message "Export finished!")))

;; ────────────────────────────────────────────────────────────────────────
;; Language Servers
;; ────────────────────────────────────────────────────────────────────────

(add-hook 'go-mode-hook #'lsp-deferred)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(setq lsp-ui-doc-show-with-cursor nil)

(defun org-babel-edit-prep:java (babel-info)
  (setq-local buffer-file-name (->> babel-info caddr (alist-get :tangle)))
  (lsp))

;; Turn off LSP formatting exclusively in C mode
(setq-hook! 'c-mode-hook +format-with-lsp nil)

;; ────────────────────────────────────────────────────────────────────────
;; Debugger — Dape
;; ────────────────────────────────────────────────────────────────────────

(require 'dap-dlv-go)

(defun safe-project-root ()
  (or (and (project-current) (project-root (project-current)))
      default-directory))

(after! transient
  (transient-define-prefix dape-transient ()
    "Transient for dape."
    [["Stepping"
      ("n" "Next" dape-next :transient t)
      ("i" "Step in" dape-step-in :transient t)
      ("o" "Step out" dape-step-out :transient t)
      ("c" "Continue" dape-continue :transient t)
      ("r" "restart" dape-restart :transient t)]
     ["Breakpoints"
      ("bb" "Next" dape-breakpoint-toggle :transient t)
      ("bd" "Step in" dape-breakpoint-remove-at-point :transient t)
      ("bD" "Continue" dape-breakpoint-remove-all :transient t)
      ("bl" "restart" dape-breakpoint-log :transient t)]
     ["Info"
      ("si" "Info" dape-breakpoint-toggle :transient t)
      ("sm" "Memory" dape-breakpoint-remove-at-point :transient t)
      ("ss" "Select Stack" dape-breakpoint-remove-all :transient t)
      ("R" "Repl" dape-breakpoint-log :transient t)]
     ["Quit"
      ("qq" "Quit" dape-quit :transient nil)
      ("qk" "Kill" dape-kill :transient nil)]])
  )

(after! dape
  (push
   `(debug-node
     modes (js-mode js-ts-mode typescript-mode typescript-ts-mode)
     host "localhost"
     port 8123
     command "node"
     command-cwd ,(expand-file-name "~/.emacs.d/debug-adapters/js-debug")
     command-args ("src/dapDebugServer.js" "8123")
     :type "pwa-node"
     :request "launch"
     :cwd dape-cwd-fn
     :program (lambda () (buffer-file-name))
     :outputCapture "console"
     :sourceMapRenames t
     :pauseForSourceMap nil
     :enableContentValidation t
     :autoAttachChildProcesses t
     :console "internalConsole"
     :killBehavior "forceful")
   dape-configs)

  (push
   `(debug-chrome
     modes (js-mode js-ts-mode typescript-mode typescript-ts-mode)
     command "node"
     command-cwd ,(expand-file-name "~/.emacs.d/debug-adapters/js-debug")
     command-args ("src/dapDebugServer.js" "8123")
     :runtimeExecutable "/usr/bin/google-chrome-stable"
     :runtimeArgs ["--remote-debugging-port=9222" "--no-first-run" "--no-default-browser-check" "--ozone-platform=x11"]

     port 8123
     :type "pwa-chrome"
     :name "Debug react"
     :trace t
     :url ,(lambda ()
             (read-string "Url: "
                          "http://localhost:5173"))
     :webRoot dape-cwd-fn
     :outputCapture "console"
     ) dape-configs)
  (push
   `(debug-firefox
     :type "pwa-firefox"
     :request "launch"
     :name "Vite React (Firefox)"
     :url "http://localhost:5173"

     ;; Must point to your Firefox binary
     :runtimeExecutable "firefox-developer-edition"

     ;; Firefox remote debugging port (default: 6000)
     :runtimeArgs ["--start-debugger-server" "6000"]
     ;; REQUIRED for firefox attach
     :browserAttachHost "localhost"
     :browserAttachPort 6000
     ;; Required mappings
     :webRoot (lambda () (safe-project-root))
     :cwd (lambda () (safe-project-root))

     ;; Required for Firefox → without this you get nil-path errors
     :pathMappings
     [( :url "/" :path (lambda () (safe-project-root)) )]

     ;; Stabilizes session so dape doesn't open nil-sized buffers
     :reAttach t

     :sourceMaps t
     :sourceMapRenames t
     )

   dape-configs)
  )

(require 'dap-chrome)
(add-hook 'dape-display-source-hook #'pulse-momentary-highlight-one-line)

;; ────────────────────────────────────────────────────────────────────────
;; LLM — GPTel
;; ────────────────────────────────────────────────────────────────────────

(setq gptel-org-branching-context t)

;; Llama.cpp offers an OpenAI compatible API
(gptel-make-openai "llama-cpp"          ;Any name
  :stream t                             ;Stream responses
  :protocol "http"
  :host "localhost:8000"                ;Llama.cpp server location
  :models '(test))                    ;Any names, doesn't matter for Llama

;; :key can be a function that returns the API key.
;; gptel-api-key is a placeholder. Actual API key comes from the authinfo.gpg file
(gptel-make-gemini "Gemini" :key gptel-api-key :stream t)

;; OPTIONAL configuration
(setq
 gptel-default-mode 'org-mode
 gptel-server-url "http://localhost:8000"
 gptel-default-model "unsloth/qwen3.5-27b"
 gptel-model   'unsloth/qwen3.5-27b
 gptel-backend (gptel-make-openai "llama-cpp"
                 :stream t
                 :protocol "http"
                 :host "localhost:8000"
                 :models '(unsloth/qwen3.5-27b)))

(setf (alist-get 'org-mode gptel-prompt-prefix-alist) "@user\n")
(setf (alist-get 'org-mode gptel-response-prefix-alist) "@assistant\n")

(setq gptel-directives '((default
                          . "You are a large language model living in Emacs and a helpful assistant.")
                         (programming
                          . "You are a large language model and a careful programmer. Provide code and only code as output without any additional text, prompt or note.")
                         (writing
                          . "You are a large language model and a writing assistant. Respond concisely.")
                         (chat
                          . "You are a large language model and a conversation partner. Respond concisely.")))

;; ────────────────────────────────────────────────────────────────────────
;; Vterm
;; ────────────────────────────────────────────────────────────────────────

(with-eval-after-load 'vterm
  (define-key vterm-mode-map (kbd "C-SPC")
              (lambda () (interactive) (vterm-send-key " " nil nil t))))

(setq vterm-zsh-args '("-c" "bindkey -e; zsh"))
(map! :after vterm
      :map vterm-mode-map
      ;; Binds Ctrl+Enter in Insert Mode (from previous config)
      :i "<C-return>" (cmd! (vterm-send-key "<right>")
                            (vterm-send-return))

      ;; Bind Ctrl+Space to send "Right Arrow" (accepts autosuggestion) (new config)
      :i "C-SPC" (cmd! (vterm-send-key "<right>")))
(set-popup-rule! "^\\*vterm" :size 1.0 :side 'bottom :vslot -4 :select t :quit nil :ttl 0)

;; ────────────────────────────────────────────────────────────────────────
;; Evil — Windmove
;; ────────────────────────────────────────────────────────────────────────

(after! evil
  (map! :g
        "M-<left>"  #'windmove-left
        "M-<down>"  #'windmove-down
        "M-<up>"    #'windmove-up
        "M-<right>" #'windmove-right))

;; ────────────────────────────────────────────────────────────────────────
;; Misc
;; ────────────────────────────────────────────────────────────────────────

;; Android-only: uses 'am' command to open URLs.
;; Not intended for desktop Linux.
(defun open-url-am (url &rest ignore)
  (interactive "sURL: ")
  (shell-command (concat "am start -a android.intent.action.VIEW -d '" url "'")
                 (setq truncate-lines t)))

(setq browse-url-firefox-program "firefox-developer-edition")
(setq browse-url-browser-function 'browse-url-firefox)
(setq browse-url-browser-function 'browse-url-xdg-open)

;; Completion & Vertico
(completion-preview-mode 1)
(setf completion-styles '(basic flex)
      completion-auto-select t ;; Show completion on first call
      completion-auto-help 'visible ;; Display *Completions* upon first request
      completions-format 'one-column ;; Use only one column
      completions-sort 'historical ;; Order based on minibuffer history
      completions-max-height 20 ;; Limit completions to 15 (completions start at line 5)
      completion-ignore-case t)

(setq vertico-count 17)
(setq alternate-vertico-count 40)
(defun my/toggle-vertico-count ()
  (interactive)
  (let ((x vertico-count))
    (setq vertico-count alternate-vertico-count)
    (setq alternate-vertico-count x)))
(map! (:when (modulep! :completion vertico)
        :map global-map "C-S-a" #'my/toggle-vertico-count
        ))

;; Increase minibuffer font size

;; Org Babel: Redis
;; https://extgit.isec.tugraz.at/smore/org-mode/-/blob/a03e57cdaf26a0cfa9537b8c62edcbbe15bd9633/contrib/lisp/ob-redis.el
(defgroup ob-redis nil
  "org-mode blocks for Redis."
  :group 'org)

(defcustom ob-redis:default-db "127.0.0.1:6379"
  "Default Redis database."
  :group 'ob-redis
  :type 'string)

;;;###autoload
(defun org-babel-execute:redis (body params)
  "org-babel redis hook."
  (let* ((db (or (cdr (assoc :db params))
                 ob-redis:default-db))
         (cmd (mapconcat 'identity (list "redis-cli") " ")))
    (org-babel-eval cmd body)
    ))

;;;###autoload
(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("redis" . redis)))

(use-package! anki-editor)
(setq org-babel-sh-command "bash")

;; Orgyank
(setq org-yank-dnd-default-attach-method "cp")
(setq org-yank-dnd-method 'attach)
(setq org-yank-image-save-method 'attach)

;; Default indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq olivetti-body-width 100)
;; Delete this if titlebar doesn't go away
(add-to-list 'default-frame-alist '(undecorated . t))

;; Calendar
(setq calendar-latitude 18.6011547)
(setq calendar-longitude 73.7746049)
(setq calendar-location-name "Pune")

;; PlantUML
;; https://github.com/plantuml/plantuml/releases/download/v1.2025.10/plantuml-1.2025.10.jar
(setq org-plantuml-jar-path (concat (expand-file-name org-roam-directory) "/assets/plantuml-1.2025.10.jar"))

(use-package! verb
  :after org
  :config
  (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

;; Auth
(setq auth-sources '("~/org/roam/mobile/authinfo.gpg" "~/.authinfo.gpg" "secrets:Login"))

(setq url-user-agent "Mozilla/5.0 (X11; Linux x86_64; rv/147.0) Gecko/20100101 Firefox/147.0")
