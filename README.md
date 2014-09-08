## A bash script to create Meteor project layouts

### Usage:

1. Place the script in your $PATH 

2. Create a new project:

```bash
$meteor_project.bash PROJECT_NAME
```

where PROJECT_NAME type the name of your project

### INFO

The script creates a meteor project with layout as bellow and inserts skeleton code in some file.:

```
project_name/
├── client
│   ├── lib
│   │   └── subscriptions.js
│   ├── stylesheets
│   │   └── style.css
│   └── views
│       ├── footer.html
│       ├── header.html
│       ├── index.html
│       ├── main.html
│       └── main.js
├── collections
├── lib
│   └── router.js
├── public
├── server
│   ├── fixtures.js
│   ├── methods.js
│   └── publications.js
└── tests

9 directories, 11 files

```

Also the script installs the Iron Router and the Bootstrap 3 packages using:

```bash
meteor add iron:router
meteor add mizzao:bootstrap-3
```
