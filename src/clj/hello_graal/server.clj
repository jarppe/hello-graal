(ns hello-graal.server
  (:require [org.httpkit.server :as server])
  (:import (java.time LocalDateTime))
  (:gen-class))


(defn log [message]
  (->> (str (LocalDateTime/now) " : " message)
       (.println System/err)))


(defn handler [req]
  {:status  200
   :headers {"content-type" "text/plain"}
   :body    "Hello!\n"})


(defn -main [& _]
  (log "server starting...")
  (server/run-server handler {:port 8080})
  (log "server ready"))
