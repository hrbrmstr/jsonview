
`jsonview` : View formatted and "pretty printed" JSON or `list`s in R

It is intended for interactive use. When working with gnarly lists or JSON data, it's often times advantageous to be able to see the document in a more formatted way.

You can pass in:

- plain character JSON
- an R `list` object

and view the formatted & pretty-printed result in the RStudio viewer or web browser.

The widget uses  [vkbeautify](http://www.eslinstructor.net/vkbeautify/) and [highlight.js](https://highlightjs.org)  to do all the work.

The following functions are implemented:

- `json_view`: view JSON

### News

- Version 0.1.0 released

### Installation


```r
devtools::install_github("hrbrmstr/jsonview")
```



### Usage


```r
library(xmlview)
library(jsonlite)

# available styles
highlight_styles()

# plain character
txt <- '{
"glossary": {
"title": "example glossary",
"GlossDiv": {
"title": "S",
"GlossList": {
"GlossEntry": {
"ID": "SGML",
"SortAs": "SGML",
"GlossTerm": "Standard Generalized Markup Language",
"Acronym": "SGML",
"Abbrev": "ISO 8879:1986",
"GlossDef": {
"para": "A meta-markup language, used to create markup languages such as DocBook.",
"GlossSeeAlso": ["GML", "XML"]
},
"GlossSee": "markup"
}
}
}
}
}'
  
json_view(txt)

doc <- fromJSON(txt)
json_view(doc, style="obsidian")

json_view(readLines("https://collector.torproject.org/index.json"))

json_view(fromJSON("https://collector.torproject.org/index.json",
                   simplifyVector=FALSE))
```
