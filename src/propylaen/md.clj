(ns propylaen.md
  (:require
   [clojure.java.io :as io])
  (:import
   (com.vladsch.flexmark.html HtmlRenderer)
   (com.vladsch.flexmark.parser Parser)))

(def parser
  (.. (Parser/builder) (build)))

(def renderer
  (.. (HtmlRenderer/builder) (build)))

(defn render-str
  [s]
  (.render renderer (.parse parser s)))

(defn render
  [k]
  (render-str (slurp (io/resource (str "propylaen/" k ".md")))))

(comment
  (render-str "# Test"))

