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

## 01-skeleton
Person manager let's you add persons to your system, but we can do better.

### Task
1. Create two different lists, one for active and one for inactive persons
1. Populate a view of these lists, and create buttons to move persons between lists
1. Create a detail button for each person containing any extra detail (email?) it's okay to hide from the primary list
1. Move on to 02-hello-world (literally Elm interacting with the real world outside it's sandbox)

## 02-solution
This is a possible solution to the task above.

## 03-real-workd
Continue building and exploring using either your `01-skeleton` implementation or the `02-solution` implementation to add some more "real life" functionality.

### Task
1. Post to and read from a remote API - install [json-server](https://github.com/typicode/json-server)
1. Post and read from localStorage (hint: ports and js)
1. Style your project either using normal css or [elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest)
1. Write tests, but know that testing Elm is different compared to more more error prone languages