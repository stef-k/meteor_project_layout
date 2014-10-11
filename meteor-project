#!/usr/bin/env bash
# Structured Meteor projects
# Version: 0.2
#
# the name of this script
readonly script="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
## Variables, Files - Directories
PROJECT_NAME=""
ROOT_DIRECTORIES="client server lib collections public tests"
CLIENT_DIRECTORIES="lib stylesheets views views/layout"
# files
CLIENT_STYLESHEETS="client/stylesheets/style.css client/stylesheets/sticky_footer.css"

# additional .gitignore currently contains .idea directory
GIT_IGNORE=".idea
*.sublime-project"

# Packages can be installed during project creation
# currenlty some defaults are bundled.
# Default packages can be edited, leave space for each package
PACKAGES=("iron:router" "mizzao:bootstrap-3")

## End of variables declarations ##
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
// e.g: an event from the nav which may be global
Template.events({

});

Template.main.helpers({

});"

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
#
## Function declarations ##

# colored echo
# usage: colored "text" [color]
# this function is taken from:
# http://stackoverflow.com/a/23006365/307826
function colored()
{
    local exp=$1;
    local color=$2;
    if ! [[ $color =~ ^[0-9]$ ]] ; then
       case $(echo "${color}" | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput setaf $color;
    echo "${exp}";
    tput sgr0;
}

# checks user input and invokes the respective generator(s)
function user_input
{
    # collect user input

    # Empty args
    if [[ -z "$1" ]]; then
        colored "Error: command is missing" red
        echo "Available commands:"
        colored "To create a new project:" magenta
        colored "  \$${script} project [project_name] or " cyan
        colored "  \$${script} project [project_name] packages [package_name] [package_name] ..." cyan
        colored "To generate various files: " magenta
        colored "  \$${script} new view [view_name]" cyan
        colored "       creates a new directory in views, a tempalte, a helper and a route" magenta
        colored "  \$${script} new collection [collection_name]" cyan
        colored "       creates a new collection in collections directory" magenta

    # project creation
    elif [[ "$1" = "project" ]]; then
        if [[ -z "$2" ]]; then
            colored "Error: project name is missing" red
            colored "Usage: \$${script} project [project_name] or" cyan
            colored "project \$${script} [project_name] packages [package_name] [package_name] ..." cyan
        else
            eval PROJECT_NAME="$2"

            create_project

            create_project_root_dirs

            create_project_root_files

            create_client_dirs

            create_client_files

            create_server_files
            # check for additional packages
            if [[ "${#}" -gt 3 ]]; then
                for package in "${@:4}"; do
                    PACKAGES=("${PACKAGES[@]}" " ${package}")
                done
            fi
            install_packages

            colored "cd into project ${PROJECT_NAME} to start working" yellow
        fi
    elif [[ "$1" = "new" ]]; then
                if [[ -z "$2" ]]; then
                    colored "Error: generator name is missing" red
                    colored "  \$${script} new view [view_name]" cyan
                    colored "       creates a new directory in views, a tempalte, a helper and a route" magenta
                    colored "  \$${script} new collection [collection_name]" cyan
                    colored "       creates a new collection in collections directory" magenta

                elif [[ "$2" = "view" ]]; then
                    create_view "$3"

                elif [[ "$2" = "collection" ]]; then
                    create_collection "$3"
                else
                    colored "Error unknown generator" red
                    colored "  \$${script} new view [view_name]" cyan
                    colored "       creates a new directory in views, a tempalte, a helper and a route" magenta
                    colored "  \$${script} new collection [collection_name]" cyan
                    colored "       creates a new collection in collections directory" magenta
                fi
    else
        colored "Error unknown command" red
        echo "Available commands:"
        colored "To create a new project:" magenta
        colored "  \$${script} project [project_name] or " cyan
        colored "  \$${script} project [project_name] packages [package_name] [package_name] ..." cyan
        colored "To generate various files: " magenta
        colored "  \$${script} new view [view_name]" cyan
        colored "       creates a new directory in views, a tempalte, a helper and a route" magenta
        colored "  \$${script} new collection [collection_name]" cyan
        colored "       creates a new collection in collections directory" magenta
    fi
}

# creates a Meteor project
function create_project
{
    echo "Creating project: ${PROJECT_NAME}"
    # create project
    meteor create "${PROJECT_NAME}" >/dev/null

    cd "${PROJECT_NAME}"
    # delete default generated files
    rm "${PROJECT_NAME}".*

    colored "Project ${PROJECT_NAME} has been created" green
}

# installs Meteor packages
function install_packages
{
    if [[ -n "${PACKAGES[*]}" ]]; then
        echo "Installing packages:"
        colored "${PACKAGES[*]}" yellow
        for package in ${PACKAGES[*]}; do
            meteor add "${package}"
        done
        colored "${#PACKAGES[@]} packages have been installed" green
    fi
}

# creates project's root directories
function create_project_root_dirs
{
    # project's root directories
    echo "Creating root directories"
    for directory in ${ROOT_DIRECTORIES}; do
        mkdir "${directory}"
    done
    colored "Project's root directories have been created" green
}


# creates project's root files
function create_project_root_files
{
    echo "Creating root various files"
    # additonal top level gitignore for editors - IDEs
    echo "${GIT_IGNORE}" > .gitignore

    echo "${ROUTER}" > "lib/router.js"

    colored "All root files have been created" green
}

# creates client's directory structure
function create_client_dirs
{
    echo "Creating client's directory structure"
    for directory in ${CLIENT_DIRECTORIES};do
        mkdir "client/${directory}"
    done
    colored "Client's directory structure have been created" green
}

# creates client's files
function create_client_files
{
    echo "Creating client files"
    echo "${INDEX}" > "client/views/index.html"
    echo "${MAIN}" > "client/views/layout/main.html"
    echo "${HEADER}" > "client/views/layout/header.html"
    echo "${FOOTER}" > "client/views/layout/footer.html"
    echo "${HEAD}" > "client/views/layout/head.html"

    for file in ${CLIENT_STYLESHEETS};do
        touch "${file}"
    done

    echo "${STICKY_FOOTBAR}" > "client/stylesheets/sticky_footer.css"
    echo "${SUBSCRIPTIONS}" > "client/lib/subscriptions.js"
    echo "${MAIN_HELPER}" > "client/views/layout/main.js"

    colored "All client's files have been created" green
}

# creates server's files
function create_server_files
{
    echo "Creating server files"
    echo "${METHODS}" > "server/methods.js"
    echo "${PUBLICATIONS}" > "server/publications.js"
    echo "${FIXTURES}" > "server/fixtures.js"
    colored "All server files have been created" green
}

# check if this script is invoked from a valid Meteor project root
# by checking if .meteor directory exists
# returns: true if in a valid project root, false otherwise
function in_project_dir
{
    if [[ -d ".meteor" ]]; then
        return 0
    else
        return 1
    fi
}

# checks if a file exists
# returns: true if file exists, false otherwise
function dir_exists
{
    if [[ -d "$1" ]]; then
        return 0
    else
        return 1
    fi
}

function file_exists
{
    if [[ -f "$1" ]]; then
        return 0
    else
        return 1
    fi
}

# Creates a new collection
# params: collection's name
function create_collection
{
    if in_project_dir; then
        if [[ -z "$1" ]]; then
            colored "Error: collection name is missing" red
            colored "Usage: \$${script} new model [model name]" cyan
        else
            if file_exists "collections/$1.js";then
                colored "The collection $1 allready exists!" yellow
            else
                tpl="$1 = new Meteor.Collection('$1');"

                echo "${tpl}" > "collections/$1.js"

                colored "The collection $1 has been created at collections/$1.js" green
            fi
        fi
    else
        colored "Error: not valid Meteor project directory" red
        colored "This command must be called from project's root directory" cyan
    fi
}

# Creates a new template
# params: template's name
function create_template
{
    if in_project_dir; then
        if [[ -z "$1" ]]; then
            colored "Error: template name is missing" red
            colored "Usage: \$${script} new template [template name]" cyan
        else
            if file_exists "client/views/$1/$1.html";then
                colored "The template $1 allready exists." yellow
            else
                tpl="<template name=\"$1\">

</template>"

                echo "${tpl}" > "client/views/$1/$1.html"

                colored "The template $1 has been created at 'client/views/$1/$1.html'" green
            fi
        fi
    else
        colored "Error: not valid Meteor project directory" red
        colored "This command must be called from project's root directory" cyan
    fi
}

# Creates a new helper
# params: helper's name
function create_helper
{
    if in_project_dir; then
        if [[ -z "$1" ]]; then
            colored "Error: helper name is missing" red
            colored "Usage: \$${script} new helper [helper name] <-- must match with a view name" cyan
        else
            if file_exists "client/views/$1/$1.js";then
                colored "The helper $1 allready exists" yellow
            else

                tpl="Template.$1.helpers({

    // controllers
    name: function(){
        return $1
    }

});

Template.$1.events({

    // event handlers
    'click #id': function(){
        //
    }

});
"
                echo "${tpl}" > "client/views/$1/$1.js"
                colored "The template $1 has been created at client/views/$1/$1.js" green
            fi
        fi
    else
        colored "Error: not valid Meteor project directory" red
        colored "This command must be called from project's root directory" cyan
    fi
}

# Adds a new route into router.js
# params: view's name
function add_route
{
    if [[ -z $1 ]]; then
        # do nothing for now
        :
    else
        tpl="\\    this.route('$1', { \\
        path: '/$1' \\
    });"

        # use sed to append after the pattern
        pattern="Router.map"

        sed -i "/$pattern/a $tpl\ " "lib/router.js"
        sed -i "/$pattern/a \ " "lib/router.js"
    fi
}

# Creates a combination of a template and a helper
# params: view's name
function create_view
{
    if in_project_dir; then
        if [[ -z $1 ]]; then
            colored "Error: view name is missing" red
            colored "Usage: \$${script} new [view name]" cyan
        else
            if dir_exists "client/views/$1";then
                colored "The view $1 allready exists" yellow
            else
                mkdir "client/views/$1"
                create_template "$1"
                create_helper "$1"
                add_route "$1"

                colored "The view $1 has been created at client/views/$1" green
                colored "and registered as route /$1" green
            fi
        fi
    else
        colored "Error: not valid Meteor project directory" red
        colored "This command must be called from project's root directory" cyan
    fi
}

function main
{
    user_input "$@"
}

## End of functions declarations ##

# invoke the main function
main "$@"
