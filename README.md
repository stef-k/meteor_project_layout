## A bash script to create directory structures for new Meteor projects

Tested on Ubuntu 14.04 64 bit with **bash** not **sh** version:
`GNU bash, version 4.3.11(1)-release (x86_64-pc-linux-gnu)`

### Usage - 'installation':

1. Place the script in your $PATH or source it so you can call it from terminal
2. Make it executable with `chmod +x meteor-project`

#### New project

```bash
$meteor-project project PROJECT_NAME
```

where `PROJECT_NAME` type the name of your project.

**note** the `project` keyword

**OR**

```bash
$meteor-project project PROJECT_NAME packages [PACKAGE_NAME] [PACKAGE_NAME] ...
```

additionally download and install all [PACKAGE_NAME]s given as arguments.

**note:** 
* the `package` keyword
* the script has some default packages hardcoded, these are:
  * "mizzao:bootstrap-3"
  * "iron:router"

To change the default packages look for the line bellow

```bash
PACKAGES=("iron:router" "mizzao:bootstrap-3")
```

#### New view

During view creation, the following are being created:
 * a new directory at `client/views/VIEW_NAME` (according to user's input)
 * a new template named as VIEW_NAME (according to user's input)
 * a new helper (according to user's input)
 * a route is register at `lib/router.js` (according to user's input)

```bash
$meteor-project new view VIEW_NAME
```

where `VIEW_NAME` the name of the view to be created

**note** the `new` and `view` keywords

#### New collection

Creates a new collection at `collections/` directory and a fixture in server's directory

```bash
$meteor-project new collection COLLECTION_NAME
```

where `COLLECTION_NAME`, the name of the collection to be created

**note** the `new` and `collection` keywords

#### Scaffold

Creates CRUD views and their respective collection's and fixtures

```bash
$meteor-project scaffold NAME
```

where `NAME` the name of the CRUD


#### Links

Generates a links menu in navbar containing all views currently located in client/views/

```bash
$meteor-project links
```

**note** the command can be invoked multiple times as it re-generates the links menu.


### INFO

The script creates a meteor project with layout as bellow and inserts skeleton code in some files (see the script):

```
new_meteor_project/
├── client
│   ├── lib // client side libraries - utilities - configurations
│   │   └── subscriptions.js
│   ├── stylesheets
│   │   ├── sticky_footer.css
│   │   └── style.css
│   └── views
│       ├── index.html
│       └── layout // layout templates combined all in the main.html template
│           ├── footer.html
│           ├── header.html
│           ├── head.html
│           ├── main.html
│           └── main.js
├── collections
├── lib // client and server side libraries - utilities - configurations
│   └── router.js
├── public
├── server
│   ├── fixtures.js
│   ├── methods.js
│   └── publications.js
└── tests

10 directories, 13 files

```
