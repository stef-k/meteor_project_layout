#!/usr/bin/env bash
# create a project layout for Meteor projects
# Script Version: 0.1
#
# VARIABLES
# main dirs
PROJECT_NAME="project_name"
#
# check if project name is given
if [ -z "$1" ]; then
    echo "Project name not given, will assign project_name"
else
    PROJECT_NAME=$1
fi
ROOT_DIRECTORIES="client server lib collections public tests"
CLIENT_DIRECTORIES="lib stylesheets views"
# files
CLIENT_STYLESHEETS="stylesheets/style.css stylesheets/sticky_footer.css"
# TEMPLATES
# index.html template
INDEX="<template name=\"index\">
        <!--bootstrap container class delete otherwise-->
        <div class=\"container\">
            main content
        </div>
</template>"

# main.html (iron router layout)
MAIN="<template name=\"main\">
    <body>
    {{> header}}

    {{> yield}}

    {{> footer}}
    </body>
</template>"

# head
HEAD="<head>
    <title>${PROJECT_NAME}</title>
</head>"

# header.html
HEADER="<template name=\"header\">
    <!--bootstrap related classes delete otherwise-->
    <div class=\"navbar navbar-default navbar-fixed-top\" role=\"navigation\">
        <div class=\"container\">
            <div class=\"navbar-header\">
                <button type=\"button\" class=\"navbar-toggle collapsed\" data-toggle=\"collapse\" data-target=\".navbar-collapse\">
                    <span class=\"sr-only\">Toggle navigation</span>
                    <span class=\"icon-bar\"></span>
                    <span class=\"icon-bar\"></span>
                    <span class=\"icon-bar\"></span>
                </button>
                <a class=\"navbar-brand\" >${PROJECT_NAME}</a>
            </div>
            <div class=\"collapse navbar-collapse\">
                <ul class=\"nav navbar-nav\">
                    <li class=\"active\"><a href=\"{{pathFor 'index'}}\">Home</a></li>
                    <li><a href=\"#about\">About</a></li>
                    <!--{{> loginButtons}} if accounts-password meteor package is used-->
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>
</template>"

FOOTER="<template name=\"footer\">
    <!--bootstrap footer classes delete otherwise-->
    <div class=\"footer\">
        <div class=\"container\">
            <p class=\"text-muted\">Place sticky footer content here.</p>
        </div>
    </div>
</template>"

STICKY="
/* Sticky footer styles
this file is used with Bootstrap 3 for the known sticky footer.
You can delete the file if Bootstrap 3 is not used or you do not want
a sticky footer.
-------------------------------------------------- */
html {
    position: relative;
    min-height: 100%;
}
body {
    /* Margin bottom by footer height */
    margin-bottom: 60px;
}
.footer {
    position: absolute;
    bottom: 0;
    width: 100%;
    /* Set the fixed height of the footer here */
    height: 60px;
    background-color: #f5f5f5;
}


/* Custom page CSS
-------------------------------------------------- */
/* Not required for template or sticky footer method. */

body > .container {
    padding: 60px 15px 0;
}
.container .text-muted {
    margin: 20px 0;
}

.footer > .container {
    padding-right: 15px;
    padding-left: 15px;
}

code {
    font-size: 80%;
}"

# additional .gitignore currently contains .idea directory
GIT_IGNORE=".idea"
# router.js basic contents
ROUTER="Router.configure({
  layoutTemplate: 'main'
});

Router.map(function () {

    this.route('index', {
        path: '/'
    });

});"

SUBSCRIPTIONS="//Meteor.subscribe('a_collection');"

METHODS="//Meteor.methods({
//
//});"

PUBLICATIONS="//Meteor.publish('a_collection', function(){
//    return 'a_collection'.find();
//});"

FIXTURES="//if (a_collection.find().count() === 0) {
//
//}"

# create project
meteor create "${PROJECT_NAME}"

cd "${PROJECT_NAME}"

rm "${PROJECT_NAME}".*

# PACKAGES
meteor add iron:router
meteor add mizzao:bootstrap-3

# root directories
for directory in ${ROOT_DIRECTORIES}; do
    mkdir "${directory}"
done

# add gitignore
echo ${GIT_IGNORE} > .gitignore

# router file
echo "${ROUTER}" > "lib/router.js"
#
# client dirs
cd client

for directory in ${CLIENT_DIRECTORIES};do
    mkdir "${directory}"
done

echo "${INDEX}" > "views/index.html"
echo "${MAIN}" > "views/main.html"
echo "${HEADER}" > "views/header.html"
echo "${FOOTER}" > "views/footer.html"
echo "${HEAD}" > "views/head.html"

# client files
touch ${CLIENT_STYLESHEETS}
echo "${STICKY}" > "stylesheets/sticky_footer.css"
echo "${SUBSCRIPTIONS}" > "lib/subscriptions.js"
touch "views/main.js"

# create server files
cd ../server

echo "${METHODS}" > methods.js
echo "${PUBLICATIONS}" > publications.js
echo "${FIXTURES}" > fixtures.js
