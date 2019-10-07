asciidoctor -b docbook $1
pandoc -f docbook -t gfm ${1/.adoc/}.xml -o en.md