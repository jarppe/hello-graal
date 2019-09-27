(ns hello-graal.server
  (:require [org.httpkit.server :as server])
  (:gen-class))


(defn handler [req]
  {:status  200
   :headers {"content-type" "text/plain"}
   :body    "Hello!\n"})


(defn -main [& args]
  (server/run-server handler {:port 8080}))
