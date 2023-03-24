(ns propylaen.tei-schema
  {:clj-kondo/config '{:linters {:unresolved-symbol {:level :off}}}}
  (:require
   [clojure.java.io :as io]
   [lambdaisland.hiccup :as h]
   [lambdaisland.ornament :as o :refer [defstyled]]
   [propylaen.md :as md]))

(def output-dir
  (io/file "public"))

(defn ensure-dir!
  [f]
  (.. (io/file f) (getParentFile) (mkdirs))
  f)

(defn write!
  [f s]
  (spit (ensure-dir! (io/file f)) s))

(o/set-tokens! {:tw-version 3
                :fonts      {:sans  "Inter,Arial,sans-serif"
                             :serif "BlackerProDis-Rg,Times New Roman,serif"}
                :colors     {:bug "47bd6d"
                             :gb  "ef6d5e"
                             :gt  "54a9fb"
                             :ra  "f5b448"
                             :wa  "14b8a6"}})

(defstyled header :header
  :relative
  [:nav
   :flex :justify-between :items-center :px-4 :sm:px-6 :py-6
   :justify-start :space-x-10
   [:#logo
    [:a :flex
     [:span :sr-only]
     [:img :h-16 :sm:h-20 :w-auto]]]
   [:#menu :flex-1 :flex :items-center :justify-between
    [:nav :flex :space-x-10]
    [:a :text-gray :hover:text-gray-900
     [:.title :text-lg :font-black]]]]
  ([ctx-path]
   [:nav
    [:div#logo
     [:a {:href (str ctx-path "index.html")}
      [:span "PROPYLÄEN. Goethes Biographica"]
      [:img {:src (str ctx-path "logos/propy.png")}]]]
    [:div#menu
     [:a {:href (str ctx-path "index.html") :title "TEI-P5 Schema"}
      [:span.title "TEI-P5 Schema"]]]]))

(def logos
  [["https://www.klassik-stiftung.de/"
    "Klassik Stiftung Weimar"
    "ksw.svg"]
   ["https://www.akademienunion.de/"
    "Union der deutschen Akademien der Wissenschaften"
    "akademienunion.svg"]
   ["https://www.goethehaus-frankfurt.de/"
    "Frankfurter Goethehaus"
    "goethehaus.svg"]
   ["https://www.saw-leipzig.de/"
    "Sächsische Akademie der Wissenschaften zu Leipzig"
    "saw.svg"]
   ["https://www.adwmainz.de/"
    "Akademie der Wissenschaften und der Literatur | Mainz"
    "adw.svg"]
   ["https://www.unesco.de/kultur-und-natur/weltdokumentenerbe/weltdokumentenerbe-deutschland/goethes-literarischer-nachlass"
    "UNESCO Weltdokumentenerbe Goethes literarischer Nachlass"
    "unesco.svg"]])

(defstyled footer :footer
  [:.logos :bg-gray-100 :px-4 :sm:px-6 :lg:px-8 :py-8 
   [:ul :max-w-7xl :mx-auto :grid :grid-cols-2 :md:grid-cols-6 :lg:grid-cols-6 :gap-8
    [:li :cols-span-1 :flex :justify-center :md:col-span-2 :lg:col-span-1
     [:img :h-12]]]]
  [:p :py-8 :text-center :text-base :text-gray-400]
  ([ctx-path]
   [:<>
    [:div.logos
     [:ul
      (for [[href title img] logos]
        [:li
         [:a {:href href :title title}
          [:img {:src (str ctx-path "logos/" img) :alt title}]]])]]]))

(defstyled h1 :h1
  :text-3xl :sm:text-4xl :text-gray-900 :font-extrabold)

(defstyled h2 :h2
  :mt-8 :border-b :text-2xl :sm:text-3xl :text-gray-900)

(defstyled md :div
  :mt-8
  [:p :mt-2 :text-lg :text-neutral-600 :text-justify]
  [:a :text-sky-600]
  ([k]
   [::h/unsafe-html (md/render k)]))

(defstyled page :html
  :h-full :bg-white :font-sans
  [:body :h-full :font-sans
   [:main :max-w-5xl :mx-auto :py-12 :sm:py-16 :px-4 :sm:px-6 :lg:px-8]]
  ([ctx-path title & contents]
   [:<> {:lang "de"}
    [:head
     [:meta {:charset "UTF-8"}]
     [:meta {:name "viewport", :content "width=device-width, initial-scale=1.0"}]
     [:link {:rel "stylesheet" :href (str ctx-path "fonts.css")}]
     [:link {:rel "stylesheet" :href (str ctx-path "styles.css")}]
     [:title (str "PROPYLÄEN: TEI-P5 Schema – " title)]]
    [:body
     [header ctx-path]
     [:main contents]
     [footer ctx-path]]]))

(defstyled schema-files :ul
  :mt-8
  [:li :text-lg]
  [:a :text-sky-600]
  ([files]
   [:<>
    (for [[path desc] files]
      [:li [:a {:href path :title desc} desc]])]))

(defn write-index!
  []
  (->>
   [page "" "Resources"
    [h1 "Resources"]
    [schema-files
     [["propy.rnc" "RELAX-NG schema (Compact Syntax)"]
      ["propy.rng" "RELAX-NG schema (XML Syntax)"]
      ["propy.sch.xsl" "Schematron Validation XSL Stylesheet"]]]]
   (h/render)
   (write! (io/file output-dir "index.html"))))

(defn write-css!
  []
  (write! (io/file output-dir "styles.css")
          (o/defined-styles {:preflight? true})))

(defn -main
  [& _]
  (write-css!)
  (write-index!))

(comment
  (-main))
