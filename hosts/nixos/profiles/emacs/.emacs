(setq make-backup-files nil)
(standard-display-ascii ?\t "^I")

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
