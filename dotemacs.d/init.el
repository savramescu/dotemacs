
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(clojure-slime-config)
(global-set-key (kbd "C-m") 'newline-and-indent)

(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding
point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (dabbrev-expand arg)
    (indent-according-to-mode)))
 
(defun my-tab-fix ()
  (local-set-key [tab] 'indent-or-expand))

(add-hook 'clojure-mode-hook 'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)

(add-hook 'c-mode-common-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'xml-mode-hook '(lambda ()
       (local-set-key (kbd "RET") 'newline-and-indent)))

(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
;(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1)))

(add-to-list 'load-path "~/emacs/")


(require 'find-file-in-project)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(autoload 'markdown-mode "markdown-mode" "Markdown editing mode." t)
(add-to-list 'auto-mode-alist '("\.markdown$" . markdown-mode))
(add-to-list 'interpreter-mode-alist '("markdown" . markdown-mode))

(autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

(setq swank-clojure-classpath (append (directory-files "~/emacs/clojure" t "$")
				      (directory-files "~/src/geoladder/src" t "$")))
(setq swank-clojure-extra-vm-args (list "-server" "-Xmx1g"))

(defun clojure-add-classpath (path)
  "Add a classpath to Clojure and refresh slime-lisp-implementations"
  (interactive "GPath: ")
  (push path swank-clojure-extra-classpaths)
  (setq slime-lisp-implementations
	(cons `(clojure ,(swank-clojure-cmd) :init swank-clojure-init)
	      (remove-if #'(lambda (x) (eq (car x) 'clojure)) slime-lisp-implementations))))

(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(load "ryancolor")
(color-theme-ryan-dark)

(setq ido-everywhere t)

(setq-default c-basic-offset 4)
(setq tab-width 2)
(setq-default indent-tabs-mode nil)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(require 'linum)
(global-linum-mode 1)
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)