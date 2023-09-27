(setq make-backup-files nil)
(standard-display-ascii ?\t "^I")
(setq-default indent-tabs-mode nil)

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
