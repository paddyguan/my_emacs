;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------
;; 关闭菜单栏
(menu-bar-mode -1)
;;关闭自动保存
(setq auto-save-default -1)
;; 设置自动注释的快捷键
(global-set-key (kbd "C-x /") 'comment-or-uncomment-region)
(global-set-key (kbd "C-x r") 'set-mark-command)

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


(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


(setq inhibit-startup-message t) ;; hide the startup message
;;(load-theme 'material t) ;; load material theme
(load-theme 'monokai t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally


;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(require 'evil)
(evil-mode 1)
;; 默认是emacs模式
(setq evil-default-state 'emacs)
;; 按C-o之后按命令是使用vim模式
(define-key evil-emacs-state-map (kbd "C-o") 'evil-execute-in-normal-state) 

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(require 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)


;; python-mode
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))


;;fold-python
(load-file "~/.emacs.d/fold-python.el")

;;find-file-in-project
(load-file "~/.emacs.d/find-file-in-project/find-file-in-project.el")


;;window-numbering
(require 'window-numbering)
(window-numbering-mode 1)



;;yasnippet 创建模版文件用的插件
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (window-numbering smex shell-command python-switch-quotes python-mode python-info python-environment python-docstring python-django pyimport pyim-basedict py-autopep8 pos-tip multi-term monokai-theme material-theme magit-popup flycheck evil elpy ein company-anaconda better-defaults autopair ansi))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
