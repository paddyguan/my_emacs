(defface codepilot-folding-overlay 
   '((default (:inherit region :box (:line-width 1 :color "DarkSeaGreen1" :style released-button))) 
     (((class color)) (:background "DarkSeaGreen2" :foreground "black"))) 
   "*Font used by folding overlay." 
   :group 'codepilot) 
   
(defun cptree-ov-delete () 
   (interactive) 
   (dolist (o (overlays-at (point))) 
     (cptree-delete-overlay o 'cptree))) 
   
(defvar cptree--overlay-keymap nil "keymap for folding overlay") 
   
(unless cptree--overlay-keymap 
   (let ((map (make-sparse-keymap))) 
     (define-key map [mouse-1] 'cptree-ov-delete) 
     (define-key map "\r" 'cptree-ov-delete) 
     (setq cptree--overlay-keymap map))) 
   
(defun cptree-delete-overlay(o prop) 
   (when (eq (overlay-get o 'cptree-tag) prop) 
     (delete-overlay o) 
     t)) 
   
(defun cptree-hide-region (from to prop) 
   "Hides a region by making an invisible overlay over it and save the overlay on the hide-region-overlays \"ring\""
   (interactive) 
   (let ((new-overlay (make-overlay from to))) 
     ;;(overlay-put new-overlay 'invisible nil) 
     (overlay-put new-overlay 'cptree-tag prop) 
     (overlay-put new-overlay 'face 'codepilot-folding-overlay) 
     (overlay-put new-overlay 'display 
                  (propertize 
                   (format "...<%d lines>..." 
                           (1- (count-lines (overlay-start new-overlay) 
                                            (overlay-end new-overlay)))))) 
     (overlay-put new-overlay 'priority (- 0 from)) 
     (overlay-put new-overlay 'keymap cptree--overlay-keymap) 
     (overlay-put new-overlay 'pointer 'hand))) 
   
(require 'python) 
   
(defun mypython-fold/unfold-block () 
   "fold the block"
   (interactive) 
   (let (ret b e) 
     (dolist (o (overlays-at (if (python-open-block-statement-p) 
                                 (save-excursion 
                                   (python-end-of-statement) 
                                   (point) 
                                   ) 
                                 (point)))) 
       (when (cptree-delete-overlay o 'cptree) 
         (setq ret t))) 
     (unless ret 
       (save-excursion 
         (unless (python-open-block-statement-p) 
           (python-beginning-of-block)) 
         (python-end-of-statement) 
         (setq b (point)) 
         (python-end-of-block) 
         (setq e (1- (point))) 
         (cptree-hide-region b e 'cptree))))) 