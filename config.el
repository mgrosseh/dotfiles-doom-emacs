;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

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
;; the highlighted symbol at press 'K'.

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

(setq confirm-kill-emacs nil) ;; disable prompt when quitting

;; TODO: I want to implement C-' to pass remaining key sequence into the normal mode keymap of evil mode to execute a single evil mode keyinput
;; maybe look at: (evil-execute-in-emacs-state)
;;(keymap-global-set "C-' p" 'evil-paste-after)
;; this hack nearly gets me this behaviour
(setq evil-want-minibuffer t)
(add-hook 'minibuffer-setup-hook '(lambda () "Start minibuffer evil mode in emacs mode" (evil-emacs-state nil)))

(setq standard-indent 2)


;; ================================
;; => Package config
;; ================================

(define-globalized-minor-mode global-rainbow-delimiters-mode rainbow-delimiters-mode
  (lambda () (rainbow-delimiters-mode 1)))
(global-rainbow-delimiters-mode 1)

;; display evil marks in buffer
(with-eval-after-load 'evil-visual-mark-mode
  (set-face-foreground 'evil-visual-mark-face "#282a36")
  (set-face-background 'evil-visual-mark-face "#ffb86c"))

(with-eval-after-load 'evil-traces
  (evil-traces-use-diff-faces) ;; make it look better?
  (evil-traces-mode))

(with-eval-after-load 'undo-tree
  (setq undo-tree-auto-save-history nil)) ; don't save history to file
(global-undo-tree-mode 1)

(with-eval-after-load 'rainbow-mode ; disable certain highlights, no need to make "red" be red
  (setq rainbow-html-colors nil
        rainbow-x-colors nil
        rainbow-latex-colors nil
        rainbow-ansi-colors 'auto
        rainbow-r-colors nil))
(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(global-rainbow-mode 1)


;; kinda sad C-a / C-x don't work but can use g- / g= instead and C-x seems too important / much of a hassle to move
;;(doom/backward-to-bol-or-indent &optional POINT)
;; (with-eval-after-load 'evil-numbers
;;   (evil-define-key '(normal visual) 'global (kbd "C-a") 'evil-numbers/inc-at-pt)
;;   (evil-define-key '(normal visual) 'global (kbd "C-x") 'evil-numbers/dec-at-pt)
;;   (evil-define-key '(normal visual) 'global (kbd "C-c C-+") 'evil-numbers/inc-at-pt-incremental)
;;   (evil-define-key '(normal visual) 'global (kbd "C-c C--") 'evil-numbers/dec-at-pt-incremental))

(with-eval-after-load 'treemacs
  (treemacs-project-follow-mode)) ;; regularly check current buffer, if different project (or out of project file), change root to match project


(with-eval-after-load 'centaur-tabs
  (setq centaur-tabs-modified-marker "♡")

  (set-face-foreground 'centaur-tabs-selected-modified "#bd93f9")
  (set-face-foreground 'centaur-tabs-unselected-modified "#bd93f9")

  (set-face-foreground 'centaur-tabs-close-selected "#ff5555")
  (defun +tabs-buffer-list ()
    (seq-filter (lambda (b)
                  (if (cond ((string-match "[*]Treemacs.*" (buffer-name b)) ;; added filter to filter out certain buffers
                             (string-equal "*doom*" (buffer-name b))))
                      nil
                    (cond ((eq (current-buffer) b) b)
                          ((buffer-file-name b) b)
                          ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                          ((buffer-live-p b) b))))
                (buffer-list)))
  (setq centaur-tabs-buffer-list-function #'+tabs-buffer-list)
  (defun my/centaur-tabs-buffer-groups ()
      (list
       (cond
        ((member (buffer-name) '("*scratch*" "*Messages*" "*dashboard*" "*eww*")) "Others")
        ((string-match "[*].*[*]" (buffer-name)) "Others")
        ((string-equal "*" (substring (buffer-name) 0 1)) "Others")
        ((eq major-mode 'message-mode) "All")
        ((eq major-mode 'dired-mode) "dired")
        (t "All"))))
  (setq centaur-tabs-buffer-groups-function #'my/centaur-tabs-buffer-groups))

(with-eval-after-load 'demap
  (setq demap-minimap-window-width 16)
  (set-face-background 'demap-current-line-face "#bd93f9")
  (set-face-foreground 'demap-current-line-face "#282a36")
  (set-face-background 'demap-visible-region-face "#373844"))

(setq which-key-idle-delay 0) ;; show which-key helper without delay

(with-eval-after-load 'corfu
  (setq corfu-popupinfo-delay '(0.5 . 0.25)
        corfu-popupinfo-max-height 15))

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

(with-eval-after-load 'flyover
  (setq flyover-show-at-eol t)
  (setq flyover-display-mode 'show-only-on-same-line)
  (add-to-list 'flyover-border-chars '(spaces . ("  " . "  ")))
  (setq flyover-border-style 'spaces))

;; ================================
;; => Mode Hooks
;; ================================

(add-hook 'markdown-mode-hook
          '(lambda () "My markdown mode configuration"
             (display-fill-column-indicator)))



;; ================================
;; => Other
;; ================================

(defun display-virtual-caret ()
  "Display a virtual caret at designated position"
  (interactive)
  (let ((pos (- (point) 2)))
    (let ((char (char-after (- pos 1))))
      (compose-region (- pos 1) pos (concat "▏" (string char))))))
