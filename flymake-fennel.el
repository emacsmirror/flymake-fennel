;;; flymake-fennel.el --- Flymake backend for Fennel  -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Graham Marlow

;; Author:  Graham Marlow <info@mgmarlow.com>
;; Keywords: tools
;; Version: 1.0.0
;; Package-Requires: ((emacs "26.1"))
;; Homepage: https://git.sr.ht/~mgmarlow/flymake-fennel

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A Flymake backend for the Fennel programming language.
;;
;; (add-hook 'fennel-mode-hook #'flymake-fennel-setup)

;;; Code:

(require 'cl-lib)

(defvar-local flymake-fennel--flymake-proc nil)

(defun flymake-fennel--make-diagnostics (source)
  "Build diagnostics for SOURCE from `current-buffer'."
  (cl-loop
   while (search-forward-regexp
          "\\(.*\\):\\([[:digit:]]*\\):\\([[:digit:]]*\\) \\(.*\\)"
          nil t)
   for msg = (match-string 4)
   for (beg . end) = (flymake-diag-region
                      source
                      (string-to-number (match-string 2))
                      (string-to-number (match-string 3)))
   when (and beg end)
   collect (flymake-make-diagnostic source beg end :error msg)))

(defun flymake-fennel-flymake-backend (report-fn &rest _args)
  "Flymake backend function.

Calls into REPORT-FN with diagnostics from the fennel compiler."
  (unless (executable-find "fennel")
    (error "Cannot find fennel binary"))

  (when (process-live-p flymake-fennel--flymake-proc)
    (kill-process flymake-fennel--flymake-proc))

  (let ((source (current-buffer)))
    (save-restriction
      (widen)
      (setq flymake-fennel--flymake-proc
            (make-process
             :name "fennel-flymake"
             :noquery t
             :connection-type 'pipe
             :buffer (generate-new-buffer " *flymake-fennel*")
             :command (list "fennel" "--compile" (buffer-file-name (current-buffer)))
             :sentinel
             (lambda (proc _event)
               (when (memq (process-status proc) '(exit signal))
                 (unwind-protect
                     (if (with-current-buffer source (eq proc flymake-fennel--flymake-proc))
                         (with-current-buffer (process-buffer proc)
                           (goto-char (point-min))
                           (funcall report-fn (flymake-fennel--make-diagnostics source)))
                       (flymake-log :warning "Canceling obsolete check %s" proc))
                   (kill-buffer (process-buffer proc)))))))
      (process-send-region flymake-fennel--flymake-proc (point-min) (point-max))
      (process-send-eof flymake-fennel--flymake-proc))))

;;;###autoload
(defun flymake-fennel-setup ()
  "Set up Fennel and Flymake."
  (interactive)
  (add-hook 'flymake-diagnostic-functions #'flymake-fennel-flymake-backend nil t)
  (flymake-mode))

(provide 'flymake-fennel)
;;; flymake-fennel.el ends here

