;;
;; Major mode for openlcad.
;;
;; Sources:
;;  hy-mode.el from the Hy language project.
;;  http://ergoemacs.org/emacs/elisp_comment_handling.html
;;  http://stackoverflow.com/questions/3623101/how-to-extend-emacs-lisp-mode-with-indentation-changes-and-color-changes
;;

(defconst lcad-keywords
      `((,(concat "(\\("
		  (regexp-opt '("aref" "block" "cond" "def" "for" "if" "import" "list" 
				"mirror" "part" "print" "rotate" "set" "translate" "while"))
		  "\\)\\>"
		  "[ \r\n\t]+")
	 (1 font-lock-function-name-face))
	(,(concat "\\<\\("
		  (regexp-opt '("e" "nil" "pi" "t"))
		  "\\)\\>")
	 (1 font-lock-constant-face))))

;; command to comment/uncomment text
(defun lcad-comment-dwim (arg)
  "Comment or uncomment current line or region in a smart way. For detail, see `comment-dwim'."
  (interactive "*P")
  (require 'newcomment)
  (let ((comment-start ";") (comment-end ""))
    (comment-dwim arg)))

;; syntax table
(defvar lcad-syntax-table nil "Syntax table for `lcad-mode'.")
(setq lcad-syntax-table
      (let ((synTable (make-syntax-table)))
        (modify-syntax-entry ?\; "< b" synTable)
        (modify-syntax-entry ?\n "> b" synTable)
        synTable))

(progn
  (add-to-list 'auto-mode-alist '("\\.lcad\\'" . lcad-mode)))

;; lcad specific offsets here
(put 'aref 'lcad-indent-function 1)
(put 'block 'lcad-indent-function 1)
(put 'cond 'lcad-indent-function 1)
(put 'def 'lcad-indent-function 1)
(put 'for 'lcad-indent-function 1)
(put 'if 'lcad-indent-function 1)
(put 'import 'lcad-indent-function 1)
(put 'list 'lcad-indent-function 1)
(put 'mirror 'lcad-indent-function 1)
(put 'part 'lcad-indent-function 1)
(put 'print 'lcad-indent-function 1)
(put 'rotate 'lcad-indent-function 1)
(put 'set 'lcad-indent-function 1)
(put 'translate 'lcad-indent-function 1)
(put 'while 'lcad-indent-function 1)

(defun lcad-indent-function (indent-point state)
  (let ((normal-indent (current-column)))
    (goto-char (1+ (elt state 1)))
    (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
    (if (and (elt state 2)
             (not (looking-at "\\sw\\|\\s_")))
        (progn
          (if (not (> (save-excursion (forward-line 1) (point))
                      calculate-lisp-indent-last-sexp))
              (progn (goto-char calculate-lisp-indent-last-sexp)
                     (beginning-of-line)
                     (parse-partial-sexp (point)
                                         calculate-lisp-indent-last-sexp 0 t)))
          (backward-prefix-chars)
          (current-column))
      (let ((function (buffer-substring (point)
                                        (progn (forward-sexp 1) (point))))
            method)
        (setq method (or (get (intern-soft function) 'lcad-indent-function)
                         (get (intern-soft function) 'lisp-indent-hook)))
        (cond ((or (eq method 'defun)
                   (and (null method)
                        (> (length function) 3)
                        (string-match "\\`def" function)))
               (lisp-indent-defform state indent-point))
              ((integerp method)
               (lisp-indent-specform method state
                                     indent-point normal-indent))
              (method
               (funcall method indent-point state)))))))

(define-derived-mode lcad-mode lisp-mode 
  "lcad-mode is a major mode for editing the lcad language."
  :syntax-table lcad-syntax-table
  (setq font-lock-defaults '(lcad-keywords))
  (setq mode-name "lcad")
  (setq lisp-indent-function 'lcad-indent-function)

  (define-key lcad-mode-map [remap comment-dwim] 'lcad-comment-dwim))

(provide 'lcad-mode)

;
; The MIT License
;
; Copyright (c) 2014 Hazen Babcock
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in
; all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
; THE SOFTWARE.
;