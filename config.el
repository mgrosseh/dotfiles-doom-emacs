;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Miranda Große-Heilmann"
      user-mail-address "mgrosseh@posteo.net")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JuliaMono" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "JuliaMono" :size 16))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; CONSIDER:
;; evil-quickscope
;; evil-replace-with-register
;; evil-surround
;; undo-tree
;; evil-terminal-cursor-changer ;; for running emacs in a terminal


(general-define-key
  :states '(normal visual motion)
  :keymaps 'override
  "C-w o" #'delete-other-windows)

(map! :nv
  :desc "Comment or Uncomment (selected / current) line(s)"
  "C-/" #'evilnc-comment-or-uncomment-lines)

;; Swap 0 and ^
(define-key evil-motion-state-map (kbd "0") 'evil-first-non-blank)
(define-key evil-motion-state-map (kbd "^") 'evil-beginning-of-line)

(drag-stuff-global-mode 1)
(map! :nv :desc "Drag selection / line up" "M-k" #'drag-stuff-up)
(map! :nv :desc "Drag selection / line down" "M-j" #'drag-stuff-down)

;; =============================
;; => Leader keybinds
;; =============================
;; == [o]pen ==
(defun alacritty ()
  "Open alacritty with working directory of open buffer or if absent home."
  (interactive "@")
  (shell-command (concat "alacritty --working-directory "
                         (file-name-directory (or load-file-name buffer-file-name "\"$HOME\"/file"))
                         " > /dev/null 2>&1 & disown") nil nil))
(map! :n :desc "Open terminal" :leader "o t" #'alacritty)

;; == [t]oggle ==
(map! :n :desc "Toggle Centaur tabs" :leader "t T" #'centaur-tabs-mode)
(map! :n :desc "Toggle rainbow mode (hl colors)" :leader "t C" #'rainbow-mode)
(map! :n :desc "Toggle electric pair mode" :leader "t p" #'electric-pair-mode)
(map! :n :desc "Toggle evil-visual-mark-mode (display marks where they are set)" :leader "t `" #'evil-visual-mark-mode)
(map! :desc "Toggle treemacs" :leader "t t" #'treemacs)
(map! :desc "Toggle undo-tree-visualization" :leader "t u" #'undo-tree-visualize)

;; == []Global ==
;;(map! :nvg :leader "<ESC>" #'ignore)
(map! :n :desc "Kill current buffer" :leader "x" #'kill-current-buffer)
;;(map! :n :desc "Kill current buffer and window" :leader "X" #'kill-buffer-and-window)
(map! :n :desc "Toggle scratch buffer" :leader "#" #'doom/toggle-scratch-buffer)
(map! :n :desc "Text scale decrease" :leader "-" #'text-scale-decrease)
(map! :n :desc "Text scale increase" :leader "-" #'text-scale-increase)
(map! :n :desc "Previous TODO" :leader "{" #'hl-todo-previous)
(map! :n :desc "Next TODO"     :leader "}" #'hl-todo-next)
(map! :n :desc "Swap char with previous char" :leader "<" #'transpose-chars)
(map! :n :desc "Swap word with previous word" :leader ">" #'transpose-words)
(map! :n :desc "Switch buffers" :leader "B" #'consult-buffer)
(map! :n :desc "Describe char" :leader "D" #'describe-char)

;; == [i]nsert ==
(map! :n :desc "Insert character" :leader "i c" #'insert-char)
;;(map! :n :desc "")


(with-eval-after-load 'hl-todo
  (setq hl-todo-keyword-faces
    '(("TODO"     . "#50fa7b")    ;; dracula green
      ("TODOs"    . "#50fa7b")    ;; dracula green
      ("PASS"     . "#50fa7b")    ;; dracula green
      ("OKAY"     . "#8be9fd")    ;; dracula cyan
      ("REF"      . "#8be9fd")    ;; dracula cyan
      ("NOTE"     . "#ff79c6")    ;; dracual pink
      ("CONSIDER" . "#ff79c6")    ;; dracual pink
      ("HACK"     . "#bd93f9")    ;; dracula purple
      ("FIX"      . "#bd93f9")    ;; dracula purple
      ("IDEA"     . "#bd93f9")    ;; dracula purple
      ("HERE"     . "#bd93f9")    ;; dracula purple
      ("TEMP"     . "#ffb86c")    ;; dracula orange
      ("WARN"     . "#ffb86c")    ;; dracula orange
      ("REMOVE"   . "#ff5555")    ;; dracula red
      ("FAIL"     . "#ff5555")    ;; dracula red
      ("BUG"      . "#ff5555")    ;; dracula red
      ("BUGGY"    . "#ff5555")    ;; dracula red
      ("FIXME"    . "#ff5555")    ;; dracula red
      ("XXX+"     . "#ff5555")    ;; dracula red
      ("WARNING"  . "#ff5555")))) ;; dracula red

(define-globalized-minor-mode global-rainbow-delimiters-mode rainbow-delimiters-mode
  (lambda () (rainbow-delimiters-mode 1)))
(global-rainbow-delimiters-mode 1)

(setq confirm-kill-emacs nil) ;; disable prompt when quitting

(setq standard-indent 2)
;; (setq-default indent-tabs-mode nil) ;; I think this is set by default
(dolist (key (mapcar 'kbd '("M-k" "M-j"))) (global-unset-key key))

;; display evil marks in buffer
(with-eval-after-load 'evil-visual-mark-mode
  (set-face-foreground 'evil-visual-mark-face "#282a36")
  (set-face-background 'evil-visual-mark-face "#ffb86c"))

(with-eval-after-load 'evil-traces
  (evil-traces-use-diff-faces) ;; make it look better?
  (evil-traces-mode))

(with-eval-after-load 'undo-tree
  (setq undo-tree-auto-save-history nil) ; don't save history to file
  (global-undo-tree-mode 1))


;; kinda sad C-a / C-x don't work but can use g- / g= instead and C-x seems too important / much of a hassle to move
;;(doom/backward-to-bol-or-indent &optional POINT)
;; (with-eval-after-load 'evil-numbers
;;   (evil-define-key '(normal visual) 'global (kbd "C-a") 'evil-numbers/inc-at-pt)
;;   (evil-define-key '(normal visual) 'global (kbd "C-x") 'evil-numbers/dec-at-pt)
;;   (evil-define-key '(normal visual) 'global (kbd "C-c C-+") 'evil-numbers/inc-at-pt-incremental)
;;   (evil-define-key '(normal visual) 'global (kbd "C-c C--") 'evil-numbers/dec-at-pt-incremental))

;; fix centaur tabs TODO: WIP
(with-eval-after-load 'centaur-tabs
  (setq centaur-tabs-modified-marker "♡")
;;  (setq centaur-tabs-close-button "")

  (set-face-foreground 'centaur-tabs-selected-modified "#bd93f9")
  (set-face-foreground 'centaur-tabs-unselected-modified "#bd93f9")

  (set-face-foreground 'centaur-tabs-close-selected "#ff5555")
  (defun +tabs-buffer-list ()
    (seq-filter (lambda (b)
                  (cond ((eq (current-buffer) b) b)
                        ((buffer-file-name b) b)
                        ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                        ((buffer-live-p b) b)))
                (buffer-list)))
  (setq centaur-tabs-buffer-list-function #'+tabs-buffer-list)
  (defun my/centaur-tabs-buffer-groups ()
      (list
       (cond
        ((member (buffer-name) '("*scratch*" "*Messages*" "*dashboard*" "*eww*")) "Others")
        ((string-equal "newsrc-dribble" (buffer-name)) "Others")
        ((derived-mode-p 'gnus-mode) "All") ;; "Email")
        ((eq major-mode 'message-mode) "All")
        ((string-equal "*" (substring (buffer-name) 0 1)) "Others")
        ((string-match "org.*sidebar" (buffer-name)) "Others")
        ((string-match "<tree>" (buffer-name)) "Others")
        ((string-match "^TAGS.*" (buffer-name)) "Others")
        ((eq major-mode 'dired-mode) "dired")
        (t "All"))))
  (setq centaur-tabs-buffer-groups-function #'my/centaur-tabs-buffer-groups))

(with-eval-after-load 'minimap
  (setq minimap-minimum-width 25
        minimap-width-fraction 0.125
        minimap-window-location 'right
        minimap-update-delay 0.4)
  (set-face-background 'minimap-current-line-face "#bd93f9")
  (set-face-foreground 'minimap-current-line-face "#282a36")
  (set-face-background 'minimap-active-region-background "#373844"))

(setq which-key-idle-delay 0) ;; show which-key helper without delay

;; TODO: unsure if I need this with doom emacs:
;; (defun minibuffer-keyboard-quit ()
;;   "Make escape quit most things."
;;   (interactive)
;;   (if (and delete-selection-mode transient-mark-mode mark-active)
;;     (setq deactivate-mark  t)
;;     (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
;;     (abort-recursive-edit)))
;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
