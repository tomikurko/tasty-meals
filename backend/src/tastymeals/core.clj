(ns tastymeals.core
  (:require [org.httpkit.server :as server]
            [compojure.handler :as handler]
            [ring.middleware.cors :refer [wrap-cors]]
            [tastymeals.rest.rest-controller :as rest-controller])
  (:gen-class))

(def app
  (-> rest-controller/app-routes
      (wrap-cors
       :access-control-allow-origin [#"http://localhost:3000"]
       :access-control-allow-methods [:get :post :delete])
      (->> compojure.handler/api)))

(defn -main
  [& args]
  (let [port (Integer/parseInt (or (System/getenv "PORT") "8080"))]
    (server/run-server #'app {:port port})
    (println (str "Running the server at http://localhost:" port "/"))))
