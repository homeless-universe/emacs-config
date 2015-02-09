(when (display-graphic-p)
  ;; ======================================================================================================
  ;; Completion in M-x and find-file
  ;; ======================================================================================================
  (if (not (locate-library "helm"))
      (ensure-package-installed 'helm))
  (require 'helm-config)

  (setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t)
  (global-set-key (kbd "C-x C-f") #'helm-find-files)
  (add-hook 'eshell-mode-hook
            #'(lambda ()
                (define-key eshell-mode-map (kbd "<tab>")     #'helm-esh-pcomplete)
                (define-key eshell-mode-map (kbd "C-c C-l") #'helm-eshell-history)))

  (helm-mode 1)
  ;; (setq helm-ff-ido-style-backspace 'always)
  (setq helm-ff-skip-boring-files t)
  (define-key helm-find-files-map (kbd "<backspace>") 'helm-find-files-up-one-level)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  (dolist (ext '("\\.\\.$" "\\.bash_history"))
    (add-to-list 'helm-boring-file-regexp-list ext))

  ;; I don't like to see recent files in buffer list
  (defcustom helm-mini-default-sources '(helm-source-buffers-list
                                         ;helm-source-recentf
                                         helm-source-buffer-not-found)
    "Default sources list used in `helm-mini'."
    :group 'helm-misc
    :type '(repeat (choice symbol)))

  ;; let <return> open directory or file
  ;; http://emacs.stackexchange.com/questions/3798/how-do-i-make-pressing-ret-in-helm-find-files-open-the-directory
  (defun odabai/helm-find-files-navigate-forward (orig-fun &rest args)
    (if (file-directory-p (helm-get-selection))
        (apply orig-fun args)
      (helm-maybe-exit-minibuffer)))
  (advice-add 'helm-execute-persistent-action :around #'odabai/helm-find-files-navigate-forward)
  (define-key helm-find-files-map (kbd "<return>") 'helm-execute-persistent-action)

  ;; do not delete file path so strongly when I hit backspace
  ;; http://emacs.stackexchange.com/questions/3798/how-do-i-make-pressing-ret-in-helm-find-files-open-the-directory
  (defun odabai/helm-find-files-navigate-back (orig-fun &rest args)
   (if (= (length helm-pattern) (length (helm-find-files-initial-input)))
        (helm-find-files-up-one-level 1)
      (apply orig-fun args)))
  (advice-add 'helm-ff-delete-char-backward :around #'odabai/helm-find-files-navigate-back)

  (define-key helm-find-files-map (kbd "<backspace>") 'helm-ff-delete-char-backward)
  (lookup-key helm-find-files-map
              (read-kbd-macro "<backspace>"))

  ;; (setq helm-idle-delay 0.1)
  ;; (setq helm-input-idle-delay 0.1)
)

(provide 'odabai-helm)
