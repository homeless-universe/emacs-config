;; TODO: make a keymap for C-k so that we can kill a line/end/start of file... in a easy way

(global-set-key (kbd "C-z") 'goto-line)

;; scroll screen using up/down bottom
(global-set-key [next] 'scroll-n-lines-ahead)
(global-set-key [prior] 'scroll-n-lines-behind)

;; =================================================================================================
;; cool jumping in file
;; =================================================================================================
(ensure-package-installed 'ace-jump-mode)
;; this list specifies what the influence of the prefix is
(setq ace-jump-mode-submode-list
      '( ace-jump-line-mode
        ace-jump-char-mode
        ace-jump-word-mode))
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; (ensure-package-installed 'ace-jump-buffer)
;; (global-set-key (kbd "C-x b") 'ace-jump-buffer)

;; launch imenu or idomenu if available
(global-set-key (kbd "C-c i") (cond ((package-installed-p 'helm) 'helm-imenu)
                                    ((package-installed-p 'idomenu) 'idomenu)
                                    (t imenu)))

;; ==========================================================================================
;; better window navigation
;; ==========================================================================================
(ensure-package-installed 'win-switch)
(global-set-key (kbd "M-<left>")  'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>")    'windmove-up)
(global-set-key (kbd "M-<down>")  'windmove-down)

(global-set-key (kbd "C-x 6 v") 'split-window-vertically-ff)
(global-set-key (kbd "C-x 6 h") 'split-window-horizontally-ff)

;; (add-hook 'c-mode-common-hook (lambda() (local-set-key (kbd "C-j") 'control-j-newline-indent)))

(global-set-key (kbd "C-k") 'delete-line)
(global-set-key (kbd "M-d") 'delete-word)

(global-set-key (kbd "C-c C-w") (quote copy-word))
(global-set-key (kbd "C-c C-k") (quote copy-line))

(global-set-key (kbd "C-x C-v") 'revert-buffer-func)

(global-set-key (kbd "<down>") 'move-region-or-next-line)
(global-set-key (kbd "<up>") 'move-region-or-previous-line)

;; we define comment-region for all files because we can define the commenting string afterwards.
(global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line)
;; you can also use (C-c q) to break lines in comments
;; (add-hook 'prog-mode-hook 'turn-on-auto-fill)

(global-set-key (kbd "<f12>") 'create-or-kill-eshell)
(global-set-key (kbd "C-<f12>") 'erase-eshell-buffer)

;; killing region without kill ring
(global-set-key (kbd "C-M-q") 'delete-region)

;; to delete only the window : C-x 0
(global-set-key (kbd "C-x 4 t") 'toggle-window-split)
(global-set-key (kbd "C-x 4 k") 'kill-buffer-and-window)

;; spartparens
(sp-use-smartparens-bindings)
;; you can run backward commands with negative prefix (C-M--)
(define-key sp-keymap (kbd "C-M-k") 'sp-kill-sexp)
(define-key sp-keymap (kbd "M-<C-backspace>") 'sp-backward-kill-sexp)
(define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)
;; I use <M-backspace> to delete words
(define-key sp-keymap (kbd "<M-backspace>") nil)
(define-key sp-keymap (kbd "<C-backspace>") 'sp-backward-unwrap-sexp)

;; nice search: highlight-symbol

;; =================================================================================================
;; Give visual feed-back when searching for regexp
;; https://github.com/benma/visual-regexp-steroids.el/blob/master/README.md
;; =================================================================================================
(ensure-package-installed 'visual-regexp-steroids)
(require 'visual-regexp-steroids)
(global-set-key (kbd "C-c r") 'vr/my-search-replace-simultaneously) ; uses vr/replace!
(define-key global-map (kbd "C-c q") 'vr/query-replace)
;; if you use multiple-cursors, this is for you:
(define-key global-map (kbd "C-c m") 'vr/mc-mark)
;; I prefer to use the emacs commands here. Seem to work better
;; (define-key esc-map (kbd "C-r") 'vr/isearch-backward) ;; C-M-r
;; (define-key esc-map (kbd "C-s") 'vr/isearch-forward) ;; C-M-s

;; =================================================================================================
;; Nice rectangular visual feed-back mode. It is not that powerful as the emacs 24.4 version
;; especially for yanking/kill-ring-saving rectangle w/o the rectangle commands.
;; =================================================================================================
(ensure-package-installed 'rect-mark)
(when (or (and (= emacs-major-version 24) (<= emacs-minor-version 3))
          (< emacs-major-version 24))
  (define-key ctl-x-map (kbd "SPC") 'rm-set-mark)
  (define-key ctl-x-map "r\C-y" 'yank-rectangle)
  (define-key ctl-x-map "r\C-x" 'rm-exchange-point-and-mark)
  (define-key ctl-x-map "r\C-w" 'rm-kill-region)
  (define-key ctl-x-map "r\M-w" 'rm-kill-ring-save))

;; Help functions
(define-key global-map (kbd "C-h s") 'apropos)

(global-set-key (kbd "<f9> t") 'cycle-color-theme)

(define-key global-map (kbd "<f9> m") 'mu4e)

(define-key global-map (kbd "C-c b") 'backup-current-file)

(global-set-key (kbd "<f8>") (lambda () (interactive) (ansi-term "/bin/bash")))

(provide 'odabai-keybindings)
