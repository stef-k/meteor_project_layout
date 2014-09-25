## A bash script to create directory structures for new Meteor projects

### Usage:

1. Place the script in your $PATH
2. Make it executable with `chmod +x meteor_project.bash`
3. Create a new project:

```bash
$meteor-project.bash PROJECT_NAME
```

where PROJECT_NAME type the name of your project.



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
