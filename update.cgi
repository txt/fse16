#!/bin/bash
echo "Content-Type: text/html"
echo ""

echo "<p>"
date
echo "</p><pre>"
git pull origin master
echo "</pre>"
cat<<EOF
<p><a href="http://fss16.unbox.org/update.cgi">Update,  again</a>.</p>
EOF
