(ns hello-graal.server
  (:require [aleph.http :as http])
  (:gen-class))


(defn handler [req]
  {:status  200
   :headers {"content-type" "text/plain"}
   :body    "Hello!\n"})


(defn -main [& args]
  (http/start-server handler {:port 8080}))
