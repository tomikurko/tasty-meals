(defproject tastymeals "0.1.0-SNAPSHOT"
  :description "The backend of Tasty Meals, a cross-platform recipe application"
  :dependencies [[org.clojure/clojure "1.11.1"]
                 ; Compojure - A basic routing library
                 [compojure "1.7.0"]
                 ; Our Http library for client/server
                 [http-kit "2.7.0"]
                 ; Ring middleware for CORS
                 [ring-cors "0.1.13"]
                 ; Ring defaults - for query params etc
                 [ring/ring-defaults "0.4.0"]
                 ; Clojure data.JSON library
                 [org.clojure/data.json "2.5.0"]
                 [com.github.seancorfield/next.jdbc "1.3.909"]
                 [org.postgresql/postgresql "42.7.1"]
                 [com.github.seancorfield/honeysql "2.5.1103"]
                 ]
  :main ^:skip-aot tastymeals.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all
                       :jvm-opts ["-Dclojure.compiler.direct-linking=true"]}})
