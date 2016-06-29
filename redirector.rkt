#lang racket
 
(require web-server/servlet)
(provide/contract (start (request? . -> . response?)))

(define (start request)
  (redirect-to "http://blog.mxm.blue" permanently))

(require web-server/servlet-env)

(serve/servlet start
               #:launch-browser? #f
               #:quit? #f
               #:listen-ip #f
               #:port 80
               #:extra-files-paths
               (list)
               #:servlet-path
               "/")