(setq make-backup-files nil)
(standard-display-ascii ?\t "^I")
(setq-default indent-tabs-mode nil)

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; rust-mode cloned from https://github.com/rust-lang/rust-mode
(add-to-list 'load-path "/home/vilvo/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(setq column-number-mode t)
