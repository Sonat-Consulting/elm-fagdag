module Tests exposing (formatName)

import Expect
import Main as M exposing (formatName)
import Test exposing (..)



-- Check out http://package.elm-lang.org/packages/elm-community/elm-test/latest to learn more about testing in Elm!


expectedName : String
expectedName =
    "Evan"


formatName : Test
formatName =
    describe "name"
        [ test "Upper case the first letter of a lower case String" <|
            \_ ->
                Expect.equal expectedName (M.formatName "evan")
        , test "Upper case the first letter of a upper case String" <|
            \_ ->
                Expect.equal expectedName (M.formatName "EVAN")
        , test "Upper case the first letter of a randomly cased String" <|
            \_ ->
                Expect.equal expectedName (M.formatName "eVaN")
        ]
