#!/usr/bin/env bash
# create a project layout for Meteor projects
# Script Version: 0.1
#
# VARIABLES
# main dirs
PROJECT_NAME="project_name"
ROOT_DIRECTORIES="client server lib collections public tests"
CLIENT_DIRECTORIES="lib stylesheets views"
# files
CLIENT_STYLESHEETS="stylesheets/style.css"
# TEMPLATES
# index.html template
INDEX="<template name=\"index\">
put the home page content here
</template>"

# main.html (iron router layout)
MAIN="<template name=\"main\">
{{> header}}

{{> yield}}

{{> footer}}
</template>"

HEADER="<template name=\"header\">
nav - header related content
</template>"

FOOTER="<template name=\"footer\">
footer content
</template>"

# additional .gitignore currently contains .idea directory
GIT_IGNORE=".idea"
# router.js basic contents
ROUTER="Router.configure({
  layoutTemplate: 'main',
});

Router.map(function () {

    this.route('index', {
        path: '/'
    });

});"

SUBSCRIPTIONS="//Meteor.subscribe('some_collection');"

METHODS="//Meteor.methods({
//
//});"

PUBLICATIONS="//Meteor.publish('some_collection', function(){
//    return 'some_collection'.find();
//});"

FIXTURES="//if (some_collection.find().count() === 0) {
//
//}"
#
# check if project name is given
if [ -z "$1" ]; then
    echo "Project name not given, will assign project_name"
else
    PROJECT_NAME=$1
fi

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

# client files
touch ${CLIENT_STYLESHEETS}
echo "${SUBSCRIPTIONS}" > "lib/subscriptions.js"
touch "views/main.js"

# create server files
cd ../server

echo "${METHODS}" > methods.js
echo "${PUBLICATIONS}" > publications.js
echo "${FIXTURES}" > fixtures.js
