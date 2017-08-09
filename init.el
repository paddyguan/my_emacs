;; init.el --- Emacs configuration
;;
(menu-bar-mode -1)
;;
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq auto-save-default nil)
;; (set-clipboard-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (modify-coding-system-alist 'process "*" 'utf-8)
;;git-emacs
(add-to-list 'load-path "/home/gyp/.emacs.d/git-emacs/")
(require 'git-emacs)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
;;(package-install 'auto-complete)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    auto-complete
    material-theme))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

(push "~/env/bin" exec-path)
(setenv "PATH"
	(concat
	 "~/env/bin" ":"
	 (getenv "PATH")
	 ))

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
;;
;;(exec-path-from-shell-copy-env "PATH")
;;(setq python-python-command "/home/gyp/env/bin/python")
;;(require 'python-mode)

;;(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "/usr/share/emacs/site-lisp/ac-dict")
;;(ac-config-default)
;;(require "python2")
;;(setq python-command "ipython")
(elpy-enable)
(elpy-use-ipython)
(auto-complete-mode)

;;                                                ;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'elpy-mode-hook 'flycheck-mode))

;;(require 'virtualenvwrapper)
;;(venv-initialize-interactive-shells) ;; if you want interactive shell support
;;(venv-initialize-eshell) ;; if you want eshell support

;;;; enable autopep8 formatting on save
;;(require 'py-autopep8)
;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; pymacs
(load-file "/home/gyp/env/src/pymacs/pymacs.el")
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;ropemacs
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)
