(ns hello-graal.server
  (:require [pohjavirta.server :as server])
  (:gen-class))


(defn handler [req]
  {:status  200
   :headers {"content-type" "text/plain"}
   :body    "Hello!\n"})


(defn -main [& args]
  (-> handler server/create server/start))
