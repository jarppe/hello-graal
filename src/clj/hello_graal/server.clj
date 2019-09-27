(ns hello-graal.server
  (:gen-class)
  (:import (com.sun.net.httpserver HttpServer HttpHandler HttpExchange)
           (java.net InetSocketAddress)
           (java.nio.charset StandardCharsets)))


(defn handler ^HttpHandler []
  (proxy [HttpHandler] []
    (handle [^HttpExchange exchange]
      (let [response (.getBytes "Hello!\n" StandardCharsets/UTF_8)]
        (.sendResponseHeaders exchange 200 (count response))
        (doto (.getResponseBody exchange)
          (.write response)
          (.close))))))


(defn run-server! []
  (let [server (HttpServer/create (InetSocketAddress. 8080) 0)]
    (-> server
        (.createContext "/")
        (.setHandler (handler)))
    (-> server
        (.start))))


(defn -main [& args]
  (run-server!))
