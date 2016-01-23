#!/bin/bash
# -*- sh -*-

url="http://fss16.unbox.org"

file=$QUERY_STRING

[ -z "$file" ] && file="$1"
file=$(echo $file  | sed 's/[^\&\/=A-Za-z0-9._-]/_/g')
file="$file.md"

if   which markdown_py
then
     root="./"
     md=markdown_py
else
     echo "Content-type: text/html"
     echo
     root=/home/stuff/fss16.unbox.org
     md=/home/stuff/env1/bin/markdown_py
fi

title=$(awk 'gsub(/^#[ \t]*/,"") { print $0; exit }' "$file")


(cat $root/_etc/header.html
 cat $file | $md                    \
  -x tables -x footnotes                     \
  -x def_list  -x toc -x smart_strong         \
  -x attr_list -x sane_lists  -x  fenced_code  \
  -x "codehilite(linenums=True)"
 cat $root/_etc/footer.html
)                          |
python $root/_etc/xpand.py |
sed -e "s/\$FiLe/$file/g"     \
    -e "s/\$TiTlE/$title/g"    \
    -e "s?\$IcOnS?/img/icons?g" \
    -e "s?\$ImG?/img?g"          \
    -e "s?\$RoOt?$root?g"         \
    -e "s?\$UrL?$url?g"   

