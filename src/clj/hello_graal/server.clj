(ns hello-graal.server
  (:require [immutant.web :as web])
  (:gen-class))


(defn handler [req]
  {:status  200
   :headers {"content-type" "text/plain"}
   :body    "Hello!\n"})


(defn -main [& args]
  (web/run handler {:port 8080}))

(comment (-main []))