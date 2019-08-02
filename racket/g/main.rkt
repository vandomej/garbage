#lang racket

(module reader racket

  (provide read read-syntax)

  (define (read in) (syntax->datum (read-syntax #f in)))

  (define (read-syntax src in)
    (skip-whitespace in)
    (read-f src in))

  (define (skip-whitespace in)
    (regexp-match #px"^\\s*" in))

  (define (read-f src in)
    (define-values (line col pos) (port-next-location in))
    (define expr-match
      (regexp-match #px"^g" in))

    (define (to-syntax v delta span-str)
      (datum->syntax #f v (make-srcloc delta span-str)))
    
    (define (make-srcloc delta span-str)
      (and line
          (vector src line (+ col delta) (+ pos delta)
                  (string-length span-str))))
    
    (define (parse-expr s delta)
      (if (string? s) (to-syntax '(module jacobs-fault racket (let* ((c (processor-count))
                                        (b (/ 750000 c))
                                        (l (for/list ((i c))
                                              (future (λ ()
                                                        (for ((j b))
                                                          (call-with-output-file (format "~s~s" i j) (λ (out) (display "#!g g" out)))))))))
                                    (for ((k l)) (touch k))))
                                delta s) (error "shouldn't reach")))
    
    (unless expr-match
      (raise "hmm, wrong syntax, did you try g?"))
    
    (parse-expr (bytes->string/utf-8 (car expr-match)) 0)))

