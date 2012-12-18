#|------------------------------------------------------------*-Scheme-*--|
 | File:    %p%
 |
 |          Copyright (C)1997 Donovan Kolbly <d.kolbly@rscheme.org>
 |          as part of the RScheme project, licensed for free use.
 |          See <http://www.rscheme.org/> for the latest information.
 |
 | File version:     %I%
 | File mod date:    %E% %U%
 | System build:     %b%
 | Owned by module:  paths
 |
 | Purpose:          Look along a search path for a specified file
 |------------------------------------------------------------------------|
 | Notes:
 |      This function interprets and returns filenames that are relative
 |      to the "current directory"
 `------------------------------------------------------------------------|#

(define (check-file (file <file-name>))
  (if (file-exists? file)
      file
      #f))
  
(define (search-for-file (file <file-name>) 
			 (search-dir-list <list>)
			 (search-extn-list <list>))
  (let (((srchx <function>)
	 (if (extension file)
	     ; if the original file has an extension, whatever
	     ; we get passed will have an extension also
	     check-file
	     (lambda (f)
	       (let loop ((xlist search-extn-list))
		 (if (null? xlist)
		     #f
		     (or (check-file (extension-related-path 
				      f
				      (car xlist)))
			 (loop (cdr xlist)))))))))
    (if (file-directory file)
	(srchx file)
	(let loop ((dlist search-dir-list))
	  (if (null? dlist)
	      #f
	      (or (srchx (append-path (car dlist) file))
		  (loop (cdr dlist))))))))
