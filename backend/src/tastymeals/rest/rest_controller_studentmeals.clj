(ns tastymeals.rest.rest-controller
  (:refer-clojure :exclude [distinct filter for group-by into partition-by set update])
  (:require [clojure.data.json :as json]
            [clojure.set :refer [rename-keys]]
            [compojure.core :refer :all]
            [honey.sql :as sql]
            [honey.sql.helpers :refer :all :as h]
            [next.jdbc :as jdbc]
            [ring.middleware.defaults :refer :all]))

(def db-config
  {:dbtype "postgresql"
   :dbname "studentmeals"
   :host "localhost"
   :port 54321
   :user "postgres"
   :password "studentmeals-secret"})

(def db (jdbc/get-datasource db-config))

(defn assoc-recipes-with-ingredients-and-steps [recipes]
  (-> recipes
      (->> (map #(assoc % "equipment" [])))
      (->> (map #(assoc % "ingredients" [])))
      (->> (map #(rename-keys % {:recipes/img_url :imgUrl})))
      (->> (map #(rename-keys % {:recipes/price_per_meal :pricePerMeal})))
      ))

(defn query-all-recipes []
  (-> {:select [:*] :from [:recipes] :order-by [[:id :desc]]}
      (sql/format)
      (->> (jdbc/execute! db))
      (->> (assoc-recipes-with-ingredients-and-steps))
      ))

(defn query-one-recipe [id]
  (-> {:select [:*] :from [:recipes] :where [:= :id id]}
      (sql/format)
      (->> (jdbc/execute! db))
      (->> (assoc-recipes-with-ingredients-and-steps))
      (->> first)
      ))

(defn get-all-recipes []
  {:status 200
   :headers {"Content-Type" "application/json"}
   :body    (json/write-str (query-all-recipes))})

(defn get-one-recipe [id]
  {:status 200
   :headers {"Content-Type" "application/json"}
   :body    (json/write-str (query-one-recipe id))})

(defroutes app-routes
  (GET "/api/v1/recipes" [] (get-all-recipes))
  (GET "/api/v1/recipes/:id" [id] (get-one-recipe (Integer/parseInt id)))
  )
