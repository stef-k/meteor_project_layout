## A bash script to create directory structures for new Meteor projects

### Usage - 'installation':

1. Place the script in your $PATH
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

as above additionally download and install all [PACKAGE_NAME] given as arguments.

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

During view creation a new directory is created at `client/views/`, a new template and a new helper, finally a route is register at `lib/router.js`

```bash
$meteor-project new view VIEW_NAME
```

where `VIEW_NAME` the name of the view to be created

**note** the `new` and `view` keywords

#### New collection

Creates a new collection at `collections/` directory

```bash
$meteor-project new collection COLLECTION_NAME
```

where `COLLECTION_NAME`, the name of the collection to be created

**note** the `new` and `collection` keywords


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

Also the script installs the Iron Router and the Bootstrap 3 packages using:

```bash
meteor add iron:router
meteor add mizzao:bootstrap-3
```
