#!/bin/bash

show_help() {
    cat << EOF
Usage:
    $0 mdfile htmlfile
EOF

}

# parse parameters
if [ "x$1" = "x" ]
then
    show_help
    exit
fi

if [ "x$2" = "x" ]
then
    show_help
    exit
fi

# get parameters
SRC_FILE="$1"
DEST_FILE="$2"

# file exists
if [ ! -f $SRC_FILE ]
then
    echo "File $SRC_FILE does not exists."
    exit
fi

######################################################################################################

do_convert() {
    curl --data-binary @$SRC_FILE -H "Content-Type:text/plain" -s https://api.github.com/markdown/raw >> $DEST_FILE
}

# output header
output_header() {
    cat << EOF > $DEST_FILE
<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<title>GitHub Markdown render</title>

<style>
body {
    background: #fff;
    color: #333;
    font: 14px/1.6 Helvetica,arial,freesans,clean,sans-serif;
    margin: 20px;
    padding: 0;
}

#frame {
    background: #eee;
    border-radius: 3px;
    margin: 0 auto;
    padding: 3px;
    width: 914px;
}

#markdown {
    background: #fff;
    border: 1px solid #cacaca;
    padding: 30px;
}

#markdown > :first-child {
    margin-top: 0;
}

#markdown > :last-child {
    margin-bottom: 0;
}

h1,h2,h3,h4,h5,h6 {
    font-weight: bold;
    margin: 20px 0 10px;
    padding: 0;
}

h1 {
    color: #000;
    font-size: 28px;
}

h2 {
    border-bottom: 1px solid #ccc;
    color: #000;
    font-size: 24px;
}

h3 {
    font-size: 18px;
}

h4 {
    font-size: 18px;
}

h5,h6 {
    font-size: 14px;
}

h6 {
    color: #777;
}

#markdown > h1:first-child,
#markdown > h2:first-child,
#markdown > h1:first-child + h2,
#markdown > h3:first-child,
#markdown > h4:first-child,
#markdown > h5:first-child,
#markdown > h6:first-child {
    margin-top: 0;
}

blockquote,dl,ol,p,pre,table,ul {
    border: 0;
    margin: 15px 0;
    padding: 0;
}

ul,ol {
    padding-left: 30px;
}

ol li > :first-child,
ol li ul:first-of-type,
ul li > :first-child,
ul li ul:first-of-type {
    margin-top: 0;
}

ol ol,ol ul,ul ol,ul ul {
    margin-bottom: 0;
}

h1 + p,h2 + p,h3 + p,h4 + p,h5 + p,h6 + p {
    margin-top: 0;
}

table {
    border-collapse: collapse;
    border-spacing: 0;
    font-size: 100%;
    font: inherit;
}

table tr {
    border-top: 1px solid #ccc;
    background: #fff;
}

table tr:nth-child(2n) {
    background: #f8f8f8;
}

table th,
table td {
    border: 1px solid #ccc;
    padding: 6px 13px;
}

table th {
    font-weight: bold;
}

code,pre,tt {
    font-family: Consolas,"Liberation Mono",Courier,monospace;
    font-size: 12px;
}

code,tt {
    background: #f8f8f8;
    border-radius: 3px;
    border: 1px solid #eaeaea;
    margin: 0 2px;
    padding: 0 5px;
}

code {
    white-space: nowrap;
}

pre {
    background: #f8f8f8;
    border-radius: 3px;
    border: 1px solid #ccc;
    font-size: 13px;
    line-height: 19px;
    overflow: auto;
    padding: 6px 10px;
}

pre > code,
pre > tt {
    background: transparent;
    border: 0;
    margin: 0;
    padding: 0;
}

pre > code {
    white-space: pre;
}

.highlight .bp { color: #999999; }
.highlight .c { color: #999988;font-style: italic; }
.highlight .c1 { color: #999988;font-style: italic; }
.highlight .cm { color: #999988;font-style: italic; }
.highlight .cp { color: #999999;font-weight: bold; }
.highlight .cs { color: #999999;font-weight: bold;font-style: italic; }
.highlight .err { color: #a61717;background: #e3d2d2; }
.highlight .gc { color: #999;background: #eaf2f5; }
.highlight .gd .x { color: #000000;background: #ffaaaa; }
.highlight .gd { color: #000000;background: #ffdddd; }
.highlight .ge { font-style: italic; }
.highlight .gh { color: #999999; }
.highlight .gi .x { color: #000000;background: #aaffaa; }
.highlight .gi { color: #000000;background: #ddffdd; }
.highlight .go { color: #888888; }
.highlight .gp { color: #555555; }
.highlight .gr { color: #aa0000; }
.highlight .gs { font-weight: bold; }
.highlight .gt { color: #aa0000; }
.highlight .gu { color: #800080;font-weight: bold; }
.highlight .il { color: #009999; }
.highlight .k { font-weight: bold; }
.highlight .kc { font-weight: bold; }
.highlight .kd { font-weight: bold; }
.highlight .kn { font-weight: bold; }
.highlight .kp { font-weight: bold; }
.highlight .kr { font-weight: bold; }
.highlight .kt { color: #445588;font-weight: bold; }
.highlight .m { color: #009999; }
.highlight .mf { color: #009999; }
.highlight .mh { color: #009999; }
.highlight .mi { color: #009999; }
.highlight .mo { color: #009999; }
.highlight .n { color: #333333; }
.highlight .na { color: #008080; }
.highlight .nb { color: #0086b3; }
.highlight .nc { color: #445588;font-weight: bold; }
.highlight .ne { color: #990000;font-weight: bold; }
.highlight .nf { color: #990000;font-weight: bold; }
.highlight .ni { color: #800080; }
.highlight .nn { color: #555555; }
.highlight .no { color: #008080; }
.highlight .nt { color: #000080; }
.highlight .nv { color: #008080; }
.highlight .o { font-weight: bold; }
.highlight .ow { font-weight: bold; }
.highlight .s { color: #d14; }
.highlight .s1 { color: #d14; }
.highlight .s2 { color: #d14; }
.highlight .sb { color: #d14; }
.highlight .sc { color: #d14; }
.highlight .sd { color: #d14; }
.highlight .se { color: #d14; }
.highlight .sh { color: #d14; }
.highlight .si { color: #d14; }
.highlight .sr { color: #009926; }
.highlight .ss { color: #990073; }
.highlight .sx { color: #d14; }
.highlight .vc { color: #008080; }
.highlight .vg { color: #008080; }
.highlight .vi { color: #008080; }
.highlight .w { color: #bbbbbb; }
.type-csharp .highlight .k { color: #0000ff; }
.type-csharp .highlight .kt { color: #0000ff; }
.type-csharp .highlight .nc { color: #2b91af; }
.type-csharp .highlight .nf { color: #000000;font-weight: normal; }
.type-csharp .highlight .nn { color: #000000; }
.type-csharp .highlight .s { color: #a31515; }
.type-csharp .highlight .sc { color: #a31515; }

a {
    color: #4183c4;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

#footer {
    color: #777;
    font-size: 11px;
    margin: 10px auto;
    text-align: right;
    white-space: nowrap;
    width: 914px;
}
</style>
</head>

<body>

<div id="frame"><div id="markdown">
EOF
}

# output footer
output_footer() {
    cat << EOF >> $DEST_FILE
    </div></div>
</body>
</html>
EOF
}


# convert and generate file
echo -n "Converting $SRC_FILE to $DEST_FILE... "
output_header
do_convert
output_footer
echo "DONE"