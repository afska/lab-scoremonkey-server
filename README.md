# scoremonkey
Automatic music to MIDI converter

Trello: https://trello.com/b/4ZpCOXng/losborbotones-proyectofinal

Slack: https://losborbotones.slack.com 

## server

[![Build Status](https://semaphoreci.com/api/v1/projects/7f2c0aa5-872c-4170-8077-9f64bb5dfd5c/408337/badge.svg)](https://semaphoreci.com/rodri042/scoremonkey) 

#### install:
```bash
# install nodejs
# install npm (node's package manager)

npm install -g grunt-cli
npm install
```

##### installing aubio dependency:
Aubio is the main dependency of the project and is the library that provides the frequency analysis of a  wave. Place the script `aubio_install.sh` in your home directory and execute it.

#### run server:
```bash
grunt server
# or simply:
grunt
# (as "server" is the default task)
```

#### run tests:
```bash
grunt test
```

#### REPL shell:
```shell
node
.load globals.js
#your debugging code:
Monkey = include("domains/monkey")
# ...
```

#### deploy:
https://toolbelt.heroku.com/

##### remote shell:
```heroku run /bin/bash --app scoremonkey```

##### add git remote and deploy
```bash
heroku git:remote --app scoremonkey
git push heroku master
```
