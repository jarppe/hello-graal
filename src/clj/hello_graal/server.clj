(ns hello-graal.server
  (:require [org.httpkit.server :as server])
  (:gen-class))


(defn handler [request]
  {:status  200
   :headers {"content-type" "text/plain"}
   :body    "hello!"})


(defn -main [& args]
  (println "Server staring...")
  (server/run-server handler {:port 8080})
  (println "Server ready!"))
