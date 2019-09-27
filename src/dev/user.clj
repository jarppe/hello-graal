(ns user
  (:require [clojure.tools.namespace.repl :as repl]
            [lucid.core.inject :as inject]))


;;
;; Programming utils:
;;


(inject/inject '[.
                 [aprint.core aprint]
                 [clojure.repl doc source dir]
                 [lucid.core.debug dbg-> dbg->> ->prn ->doto ->>doto]])


;;
;; Integrant repl setup:
;;


(def reset (fn [] (repl/refresh)))

(comment
  (require 'hello-graal.server)
  (hello-graal.server/-main [])
  )