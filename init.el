;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------
;; 关闭菜单栏
(menu-bar-mode -1)
;;关闭自动保存
(setq auto-save-default -1)
;; 设置自动注释的快捷键
(global-set-key (kbd "C-x /") 'comment-or-uncomment-region)


(load-file "~/.emacs.d/my_macro.el")
(global-set-key (kbd "C-x n RET") 'next-lines)
(global-set-key (kbd "C-x p RET") 'previous-lines)
;;设置编码
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(modify-coding-system-alist 'process "*" 'utf-8)

;;自动填充右括号
(electric-pair-mode 1)
(add-hook 'python-mode-hook
    (lambda ()
        (define-key python-mode-map "\"" 'electric-pair)
        (define-key python-mode-map "\'" 'electric-pair)
        (define-key python-mode-map "{" 'electric-pair)
        (define-key python-mode-map "[" 'electric-pair)
        (define-key python-mode-map "(" 'electric-pair)))

;; 添加路径
(push "~/env/bin" exec-path)
(setenv "PATH"
	(concat
	 "~/env/bin" ":"
	 (getenv "PATH")
	 ))


;; 开启package
(require 'package)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))


(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

;;(setq inhibit-startup-message t) ;; hide the startup message
;;(load-theme 'material t) ;; load material theme
(load-theme 'monokai t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;;(exec-path-from-shell-copy-env "PATH")
;;(setq python-python-command "/Library/Frameworks/Python.framework/Versions/2.7/bin/python")
;;(setq python-python-command "~/env/bin/python")
;;(require 'python-mode)

;; PYTHON CONFIGURATION
;; --------------------------------------

;(require "python2")
;(setq python-command "ipython")
(elpy-enable)
;;(elpy-use-ipython)
;;(require 'evil)
;;(evil-mode 1)
;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;;(require 'virtualenvwrapper)
;;(venv-initialize-interactive-shells) ;; if you want interactive shell support
;;(venv-initialize-eshell) ;; if you want eshell support
;; note that setting `venv-location` is not necessary if you
;; use the default location (`~/.virtualenvs`), or if the
;; the environment variable `WORKON_HOME` points to the right place
;;(setq venv-location "/Users/mac/.pyenv")
;; enable autopep8 formatting on save
;;(require 'py-autopep8)
;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; autocomple
;;(load-file "~/.emacs.d/auto-complete/auto-complete.el")
(add-to-list 'load-path "~/.emacs.d/lisp/auto-complete")
(require 'auto-complete-config)
(ac-config-default)


;; pymacs
(load-file "~/env/src/pymacs/pymacs.el")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")

;; pycomplete & python-mode
(load-file "~/.emacs.d/python-mode.el")
(load-file "~/.emacs.d/pycomplete.el")
(require 'pycomplete)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq interpreter-mode-alist(cons '("python" . python-mode)
				  interpreter-mode-alist))
;; path to the python interpreter, e.g.: ~rw/python27/bin/python2.7
;;(setq py-python-command "python") ;; 上面已经设置了
(autoload 'python-mode "python-mode" "Python editing mode." t)

;;fold-python
(load-file "~/.emacs.d/fold-python.el")

;;find-file-in-project
(load-file "~/.emacs.d/find-file-in-project/find-file-in-project.el")


;;window-numbering
(require 'window-numbering)
(window-numbering-mode 1)

;;org-mode
(add-to-list 'load-path "~/.emacs.d/org-9.0.9/lisp")
(add-to-list 'load-path "~/.emacs.d/org-9.0.9/contrib/lisp" t)

;;yasnippet 创建模版文件用的插件
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(column-number-mode t)
;; '(current-language-environment "UTF-8")
;; '(display-time-mode t)
;; '(package-selected-packages
;;   (quote
;;    (py-autopep8 flycheck elpy ein material-theme better-defaults)))
;; '(size-indication-mode t))
;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

