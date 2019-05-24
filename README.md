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
1. Install [json-server](https://github.com/typicode/json-server)
    1. `yarn global add json-server`
    1. `npm install -g json-server`

VSCode users: [Install Elm Language Support](https://marketplace.visualstudio.com/items?itemName=sbrink.elm) 

## Tasks
01-03 are fairy simple tasks to complete, and the [Elm Guide](https://guide.elm-lang.org/) is recommended. They are all accompanied with a `0_-_-example` if you get stuck, but these are very
simple and basic and can be solved better.

## 01-model
Populate a model with a `Person`   
`update : Msg -> Model -> Model` - update the records in this function for each `Msg`

## 02-list
Add new `Person`s to a List.   
Update model with a Person record (supplied, but feel free to type alias the different fields).

To update the list, `Msg CreatePerson` is perhaps the best place you want to be.   
Remember `(::) : a -> List a -> List a`.

## 03-http
`POST` and `GET` data over HTTP   
To complete this task, install [json-server](https://github.com/typicode/json-server).   
An example db.json can be found under the `server` folder.

The app will crash untill all functions are implemented.

This task uses a non-core library for JSON [elm-decode-pipeline](https://package.elm-lang.org/packages/NoRedInk/elm-decode-pipeline/3.0.1/) because it feels nice to work with, and it is an instant recommendation. The example will use this, but feel free to use which ever approach you want. 

## 04-js-interop
Try to look at this, and see if it can be used elsewhere?

## 00-bonus-task
1. Post and read from localStorage (hint: ports and js)
1. Write tests, but know that testing Elm is different compared to more more error prone languages
1. Style your project either using normal css or [elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest)