;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name ""
      user-mail-address "")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-flatwhite)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq doom-font (font-spec :family "Source Code Pro" :size 10))

;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq compilation-scroll-output t)

;;;; Hacks

;; Hack from Henrik Lissner, creator of Doom Emacs.
;; Mitigates occasional Emacs flickering
;; https://github.com/hlissner/doom-emacs-private/blob/master/config.el
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;;;; Programming

;;; Web
(use-package! prettier
  :init
  (add-hook 'after-init-hook #'global-prettier-mode))

;;;; Navigation

;;; Evil

(after! evil
  (define-key evil-normal-state-map (kbd "<left>") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "<right>") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "<up>") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "<down>") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "<backspace>") 'evil-window-prev)
  (define-key evil-normal-state-map (kbd "S-<backspace>") 'evil-window-next))

;; Move to new window after splitting
;; (setq evil-split-window-below t
;;       evil-vsplit-window-right t)


(use-package! evil-escape
  :custom
  (evil-escape-key-sequence "kj"))
;; (use-package! key-chord
;;   :after evil
;;   :config
;;   (setq key-chord-two-keys-delay 0.5)
;;   (key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
;;   (key-chord-mode t))

(use-package! cider-mode
  :after evil
  :init
  ;; (add-hook 'before-save-hook 'cider-format-buffer t t)
  :custom
  (cider-save-on-load t)
  (cider-auto-select-error-buffer nil)
  (cider-auto-select-test-buffer nil))

(use-package! clojure-mode
  :after flycheck-clj-kondo)

;; TODO: Ivy
;; TODO: Deft
;; TODO: Treemacs

;; TODO: Hydra

;;;; TODO: Magit
;;;;

;;;; TODO: Eshell

;;;; TODO: Editing
;; TODO: Fill line

;;;; Org Mode

;;; Org Roam

;; (defun isaac-org-roam (&optional goto keys)
;;   (debug "hello")
;;   (setq my-org-capture-before-config (current-window-configuration))
;;   (org-roam-capture goto keys)
;;   (doom/window-maximize-buffer))

;; (defun isaac-org-roam-capture-hook ()
;;   (-when-let ((&alist 'name name) (frame-parameters))
;;     (when (equal name "Roam Capture - Doom Emacs")
;;       (delete-frame))))

;; (use-package! org-roam
;;   :hook
;;   (after-init . org-roam-mode)
;;   :custom
;;   (org-roam-v2-ack t)
;;   (org-roam-directory (file-truename org-directory))
;;   :bind (:map org-mode-map
;;          (("C-c n i" . org-roam-insert))
;;          (("C-c n I" . org-roam-insert-immediate)))
;;   :init
;;   (add-hook 'org-capture-after-finalize-hook #'isaac-org-roam-capture-hook)
;;   (map! :leader
;;         (:prefix ("r" . "roam")
;;          :desc "Catpure" "c" #'org-roam-capture
;;          :desc "Find file" "f" #'org-roam-find-file
;;          :desc "Graph" "g" #'org-roam-graph
;;          :desc "Org store link" "l" #'org-store-link
;;          :desc "Org insert link" "L" #'org-insert-link
;;          :desc "Toggle Roam Buffer" "r" #'org-roam)))

;;; Diagrams

;; Bash command
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Window-Frame-Parameters.html
;; emacsclient -c -F '((name . "org-protocol-capture"))' "$@"
;;

;; Set the fill column
(setq global-display-fill-column-indicator-mode t)
(setq fill-column 100)


(after! (:and evil-collection company)
  ;; Override the keybindings defined by evil-collection so
  ;; it's possible to use Evil completion while the autocomplete
  ;; dropdown is active.
  (define-key company-active-map (kbd "C-n") 'evil-complete-next)
  (define-key company-active-map (kbd "C-p") 'evil-complete-previous))

(use-package! evil-snipe
  :custom (evil-snipe-spillover-scope 'whole-visible))

(after! rustic
  (setq lsp-rust-server 'rust-analyzer)
  (setq rustic-lsp-server 'rust-analyzer)
  (setq lsp-rust-analyzer-server-display-inlay-hints t)
  (setq lsp-rust-analyzer-display-chaining-hints t)
  (setq lsp-rust-analyzer-display-parameter-hints t))

(use-package! company
  :config
  (dolist (key '("<return>" "RET"))
    (define-key company-active-map (kbd key)
      `(menu-item nil company-complete
                  :filter ,(lambda (cmd)
                             (when (company-explicit-action-p)
                               cmd)))))
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection)
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (define-key company-active-map (kbd "SPC") nil)
  :custom
  (company-selection-wrap-around t "Wrap suggestions when navigation with C-n C-p")
  (company-auto-complete-chars nil "Supposedly causes issues when defining custom company keybindings"))

(use-package! projectile
  :custom
  (projectile-sort-order 'recently-active))

(let ((last-text nil))
  (defun isaac/unhighlight-occurrences ()
    (interactive)
    (when last-text
      (unhighlight-regexp last-text))
    (setq last-text nil))

  (defun isaac/highlight-occurrences (text)
    (interactive "sHighlight occurences of: ")
    (let ((quoted-text (regexp-quote text))
          (old-case-fold-search case-fold-search))
     (isaac/unhighlight-occurrences)
      (setq case-fold-search nil)
      (highlight-regexp quoted-text 'lazy-highlight)
      (setq last-text quoted-text)
      (setq case-fold-search old-case-fold-search))))

(defun isaac/highlight-occurences-of-selection ()
  (interactive)
  (let ((selection (buffer-substring (mark) (1+ (point)))))
    (when (> (length selection) 1)
      (isaac/highlight-occurrences selection))))

(add-hook 'evil-visual-state-entry-hook
          (lambda ()
            (add-hook 'post-command-hook 'isaac/highlight-occurences-of-selection)))

(add-hook 'evil-visual-state-exit-hook
          (lambda ()
            (isaac/unhighlight-occurrences)
            (remove-hook 'post-command-hook 'isaac/highlight-occurences-of-selection)))

(use-package! display-line-numbers
  :custom
  ;; Line numbers on Mac Emacs grows and shrinks when a minibuffer
  ;; if opened with split windows. Preventing it from shrinking stops
  ;; it from shifting and being distracting
  (display-line-numbers-grow-only t))


(use-package! hl-todo
  :custom
  ;; Override keyword faces in order to add DEBT
  (hl-todo-keyword-faces
   `(("TODO" warning bold)
     ("FIXME" error bold)
     ("DEBT" error bold)
     ("HACK" font-lock-constant-face bold)
     ("REVIEW" font-lock-keyword-face bold)
     ("NOTE" success bold)
     ("DEPRECATED" font-lock-doc-face bold)
     ("BUG" error bold)
     ("XXX" font-lock-constant-face bold))))

(map! :leader
      ;; Swap the default keybindings
      :desc "Eval expression" ":" #'pp-eval-expression
      :desc "M-x"             ";" #'execute-extended-command)

(use-package! rustic
  :custom (buffer-save-without-query t))

;; TODO Evil inner pipe binding
;; It's defined how all other evil-inner-.* are defined, but it doesn't work
(evil-define-text-object evil-inner-pipe (count &optional beg end type)
  "Select inner pipes."
  :extend-selection nil
  (evil-select-paren ?\| ?\| beg end type count))

(define-key! evil-inner-text-objects-map "|" 'evil-inner-pipe)


