(ns tastymeals.rest.rest-controller
  (:refer-clojure :exclude [distinct filter for group-by into partition-by set update])
  (:require [clojure.data.json :as json]
            [clojure.string :as str]
            [compojure.core :refer :all]
            [honey.sql :as sql]
            [honey.sql.helpers :refer :all :as h]
            [next.jdbc :as jdbc]
            [ring.middleware.defaults :refer :all]))

(def db-config
  {:dbtype "postgresql"
   :dbname "tastymeals"
   :host "localhost"
   :port 54322
   :user "postgres"
   :password "tastymeals-secret"})

(def db (jdbc/get-datasource db-config))


(defn query-recipe-ingredients [recipe-id]
  (-> {:select [:*] :from [:ingredients] :where [:= :recipe_id recipe-id]}
      (sql/format)
      (->> (jdbc/execute! db))
      (->> (map #(dissoc % :ingredients/recipe_id)))
      ))

(defn query-recipe-steps [recipe-id]
  (-> {:select [:*] :from [:steps] :where [:= :recipe_id recipe-id]}
      (sql/format)
      (->> (jdbc/execute! db))
      (->> (map #(dissoc % :steps/recipe_id)))
      ))

(defn assoc-recipes-with-ingredients-and-steps [recipes]
  (-> recipes
      (->> (map #(assoc % "ingredients" (query-recipe-ingredients (% :recipes/id)))))
      (->> (map #(assoc % "steps" (query-recipe-steps (% :recipes/id)))))
      ))


(defn query-all-categories []
  (-> {:select [:*] :from [:categories] :order-by [[:name :asc]]}
      (sql/format)
      (->> (jdbc/execute! db))
      ))

(defn query-top-categories []
  ;(-> ["SELECT id, name, recipe_count
  ;      FROM (
  ;        SELECT category_id, COUNT(*) AS recipe_count
  ;        FROM category_recipes
  ;        GROUP BY category_id
  ;        ORDER BY recipe_count DESC
  ;        LIMIT 3)
  ;      JOIN categories ON category_id = categories.id;"]

  (-> {:select [:id :name :recipe_count]
       :from
         {:select [:category_id [:%count.* :recipe_count]]
          :from [:category_recipes]
          :group-by :category_id
          :order-by [[:recipe_count :desc]]
          :limit 3}
       :join [:categories [:= :category_id :categories.id]]}
      (sql/format)
      (->> (jdbc/execute! db))
      ))

(defn query-one-category [id]
  (-> {:select [:*] :from [:categories] :where [:= :id id]}
      (sql/format)
      (->> (jdbc/execute! db))
      (->> first)
      ))

(defn query-recipes [category-id, name-contains]
  (-> {:select [:*] :from [:recipes]
       :join [:category_recipes [:= :recipes.id :category_recipes.recipe_id]]
       :where [:and
         (if (nil? category-id) nil [:= :category_recipes.category_id category-id])
         (if (nil? name-contains) nil [:ilike :name (str "%" (str/escape name-contains {\% "\\%" \_ "\\_"}) "%")])
       ]
       :order-by [[:id :desc]]}
      (sql/format)
      (->> (jdbc/execute! db))
      (->> (assoc-recipes-with-ingredients-and-steps))
      ))

(defn query-latest-recipe []
  (-> {:select [:*] :from [:recipes] :order-by [[:id :desc]] :limit 1}
      (sql/format)
      (->> (jdbc/execute! db))
      (->> (assoc-recipes-with-ingredients-and-steps))
      (->> first)
      ))

(defn query-random-recipe []
  (-> ["SELECT * FROM recipes ORDER BY RANDOM() LIMIT 1"]
      (->> (jdbc/execute! db))
      (->> (assoc-recipes-with-ingredients-and-steps))
      (->> first)
      ))

(defn query-one-recipe [id]
  (-> {:select [:*] :from [:recipes] :where [:= :id id]}
      (sql/format)
      (->> (jdbc/execute! db))
      (->> (assoc-recipes-with-ingredients-and-steps))
      (->> first)
      ))


(defn get-all-categories []
  {:status 200
   :headers {"Content-Type" "application/json"}
   :body    (json/write-str (query-all-categories))})

(defn get-top-categories []
  {:status 200
   :headers {"Content-Type" "application/json"}
   :body    (json/write-str (query-top-categories))})

(defn get-one-category [id]
  (let [category (if (nil? id) nil (query-one-category id))]
    {:status (if (nil? category) 404 200)
     :headers {"Content-Type" "application/json"}
     :body    (json/write-str category)}))

(defn get-recipes [category-id, name-contains]
  {:status 200
   :headers {"Content-Type" "application/json"}
   :body    (json/write-str (query-recipes category-id name-contains))})

(defn get-latest-recipe []
  (let [recipe (query-latest-recipe)]
    {:status (if (nil? recipe) 404 200)
     :headers {"Content-Type" "application/json"}
     :body    (json/write-str recipe)}))

(defn get-random-recipe []
  (let [recipe (query-random-recipe)]
    {:status (if (nil? recipe) 404 200)
     :headers {"Content-Type" "application/json"}
     :body    (json/write-str recipe)}))

(defn get-one-recipe [id]
  (let [recipe (if (nil? id) nil (query-one-recipe id))]
    {:status (if (nil? recipe) 404 200)
     :headers {"Content-Type" "application/json"}
     :body    (json/write-str recipe)}))


(defroutes app-routes
  (GET "/api/v1/categories" [] (get-all-categories))
  (GET "/api/v1/top-categories" [] (get-top-categories))
  (GET "/api/v1/category/:id" [id]
    (get-one-category (try (Integer/parseInt id) (catch NumberFormatException e nil))))
  (GET "/api/v1/recipes" {params :params}
    (get-recipes
      (try (Integer/parseInt (get params :category)) (catch NumberFormatException e nil))
      (get params :nameContains)))
  (GET "/api/v1/latest-recipe" [] (get-latest-recipe))
  (GET "/api/v1/random-recipe" [] (get-random-recipe))
  (GET "/api/v1/recipe/:id" [id]
    (get-one-recipe (try (Integer/parseInt id) (catch NumberFormatException e nil))))
  )
