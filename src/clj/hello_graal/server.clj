(ns hello-graal.server
  (:require [org.httpkit.server :as server])
  (:import (java.time LocalDateTime)
           (java.time.format DateTimeFormatter))
  (:gen-class))


(defn handler [req]
  {:status  200
   :headers {"content-type" "text/plain"}
   :body    "Hello!\n"})


(defn log [message]
  (->> (str (.format DateTimeFormatter/ISO_LOCAL_DATE_TIME (LocalDateTime/now)) " : " message)
       (.println System/err)))


(defn -main [& args]
  (log "server starting...")
  (server/run-server handler {:port 8080})
  (log "server ready"))


(comment
  (-main []))
