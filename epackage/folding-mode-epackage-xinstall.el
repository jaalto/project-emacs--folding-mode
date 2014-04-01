(autoload 'folding-mode "folding" "Folding mode" t)
(autoload 'turn-off-folding-mode "folding" "Folding mode" t)
(autoload 'turn-on-folding-mode  "folding" "Folding mode" t)
(autoload 'folding-install-hooks "folding")

;; This is one time setup. Activate only on-demand.
;;
;; After we find any fold, transfer control to folding-mode.
;; This way we keep it lean, until it's time to load "the package"

(defun folding-mode-epackage-find-file-hook ()
  "Activate folding mode for file as needed."
  (cond
   ((featurep 'folding)
    (remove-hook 'find-file-hook 'folding-mode-epackage-find-file-hook)
    (folding-install-hooks))
   (t
    ;; Poor man's fold detection
    (save-excursion
      (when (re-search-forward (format "^%s{{{" (or comment-start "")) nil t)
	(turn-on-folding-mode)
	(remove-hook 'find-file-hook 'folding-mode-epackage-find-file-hook)
	(folding-install-hooks))))))

(if (featurep 'folding)
    (folding-install-hooks)
  (add-hook 'find-file-hook 'folding-mode-epackage-find-file-hook))

(provide 'folding-mode-epackage-xinstall)
