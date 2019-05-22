# Elm Fagdag

## Before you start
Install these to get started.
1. Install [elm](https://elm-lang.org)
    1. `yarn global add elm`
    1. `npm install -g elm`
1. Install [elm-app](https://github.com/halfzebra/create-elm-app) 
    1. `yarn global add create-elm-app`
    1. `npm install create-elm-app -g`
1. Install [elm-format](https://github.com/avh4/elm-format)
    1. `yarn global add elm-format`
    1. `npm install -g elm-format`

VSCode users: [Install Elm Language Support](https://marketplace.visualstudio.com/items?itemName=sbrink.elm) 

## Tasks
01-03 are fairy simple tasks to complete, and the [Elm Guide](https://guide.elm-lang.org/) is recommended.
They are all accompanied with a `0_-_-example` if you get stuck.

## 01-model
Populate a model with a `Person`

## 02-list
Add new `Person`s to a List 

## 03-http
`POST` and `GET` data over HTTP
To complete this task, install [json-server](https://github.com/typicode/json-server). An example db.json can be found
under the `server` folder.

This task uses a non-core library for JSON [elm-decode-pipeline](https://package.elm-lang.org/packages/NoRedInk/elm-decode-pipeline/3.0.1/) because it feels nice to work with, and it is an instant recommendation. The example will use this, but feel free to use
which ever approach you want. 

## 00-bonus-task
1. Post and read from localStorage (hint: ports and js)
1. Write tests, but know that testing Elm is different compared to more more error prone languages
1. Style your project either using normal css or [elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest)