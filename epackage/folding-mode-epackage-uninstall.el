(autoload 'folding-uninstall-hooks "folding")

(when (featurep 'folding)
  (folding-uninstall-hooks))

(provide 'folding-mode-epackage-uninstall)
