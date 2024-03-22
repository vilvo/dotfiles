(setq make-backup-files nil)
(standard-display-ascii ?\t "^I")
(setq-default indent-tabs-mode nil)

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;; modes nix-packaged and symlinked via configuration.nix
(add-to-list 'load-path "/home/vilvo/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-to-list 'load-path "/home/vilvo/go-mode/")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

(setq column-number-mode t)

(setq-default auto-fill-function 'do-auto-fill)
(set-fill-column 80)
