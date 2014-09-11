#!/usr/bin/env bash
# Structured Meteor projects
# Version: 0.2
#
## File templates ##
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

MAIN_HELPER="// This is the main template helper
// here you can handle some top level events,
// e.g: a event from the nav which may be global
Template.events({

});

Template.main.helper = function (){

};"

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

STICKY_FOOTBAR="
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

## End of template declarations ##

## Variables Files - Directories
ROOT_DIRECTORIES="client server lib collections public tests"
CLIENT_DIRECTORIES="lib stylesheets views views/layout"
# files
CLIENT_STYLESHEETS="client/stylesheets/style.css client/stylesheets/sticky_footer.css"

# Default project name
PROJECT_NAME="new_meteor_project"

# additional .gitignore currently contains .idea directory
GIT_IGNORE=".idea"

# Packages to install, do not edit by hand
# If you need to customize the packages, see
# bellow the install_packages function
PACKAGES=()

## End of variables declarations ##
#
## Function declarations ##

# checks user input such as project name
# todo: basic package installation during
# project's creation
function user_input
{
    # check if project name is given
    if [ -z "$1" ]; then
        echo "Project name not given, will assign project_name"
    else
        PROJECT_NAME=$1
    fi

    # unused for now but may be used in
    # future to install some packages during
    # project's creation
    for arg in "${@:3}";do
        PACKAGES+=" ${arg}"
    done
}

# creates a Meteor project
function create_project
{
    # create project
    meteor create "${PROJECT_NAME}"

    cd "${PROJECT_NAME}"
    # delete default generated files
    rm "${PROJECT_NAME}".*
}

# installs Meteor packages
function install_packages
{
    # Hard coded packages to install
    # change it according to your needs
    meteor add iron:router
    meteor add mizzao:bootstrap-3
}

# creates project's root directories
function create_project_root_dirs
{
    # project's root directories
    for directory in ${ROOT_DIRECTORIES}; do
        mkdir "${directory}"
    done
}


# creates project's root files
function create_project_root_files
{
    # additonal top level gitignore for editors - IDEs
    echo ${GIT_IGNORE} > .gitignore

    echo "${ROUTER}" > "lib/router.js"
}

# creates client's directory structure
function create_client_dirs
{
    for directory in ${CLIENT_DIRECTORIES};do
        mkdir "client/${directory}"
    done
}

# creats client's files
function create_client_files
{
    echo "${INDEX}" > "client/views/index.html"
    echo "${MAIN}" > "client/views/layout/main.html"
    echo "${HEADER}" > "client/views/layout/header.html"
    echo "${FOOTER}" > "client/views/layout/footer.html"
    echo "${HEAD}" > "client/views/layout/head.html"

    for file in ${CLIENT_STYLESHEETS};do
        touch "${file}"
    done

    echo "${STICKY_FOOTBAR}" > "client/stylesheets/sticky_footer.css"
    echo "${SUBSCRIPTIONS}" > "lib/subscriptions.js"
    echo "${MAIN_HELPER}" > "client/views/layout/main.js"
}

# creates server's files
function create_server_files
{
    echo "${METHODS}" > "server/methods.js"
    echo "${PUBLICATIONS}" > "server/publications.js"
    echo "${FIXTURES}" > "server/fixtures.js"
}

function main
{
    user_input "$@"

    create_project

    create_project_root_dirs

    create_project_root_files

    create_client_dirs

    create_client_files

    create_server_files

    install_packages
}

## End of functions declarations ##

# invoke the main function
main "$@"
