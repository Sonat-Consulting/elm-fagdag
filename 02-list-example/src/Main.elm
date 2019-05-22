module Main exposing (Model, Msg(..), formatName, init, main, update, view)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, button, div, form, h1, h3, img, input, label, p, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



---- MODEL ----


type alias Model =
    { persons : List Person
    , form : Person
    }


type alias Person =
    { firstName : String
    , lastName : String
    , email : String
    }


init : Model
init =
    Model initWithUsers (Person "" "" "")


initWithUsers : List Person
initWithUsers =
    [ Person "Some" "Somelastname" "some@example.org"
    , Person "Emos" "Emosnamelast" "emos@example.org"
    , Person "Soem" "Soemlast" "soem@example.org"
    ]



---- UPDATE ----


type Msg
    = NoOp
    | FirstNameInput String
    | LastNameInput String
    | EmailInput String
    | CreatePerson


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        CreatePerson ->
            let
                newPersons =
                    model.form :: model.persons
            in
            { model | persons = newPersons, form = Person "" "" "" }

        FirstNameInput firstName ->
            let
                form =
                    model.form

                newForm =
                    { form | firstName = firstName }
            in
            { model | form = newForm }

        LastNameInput lastName ->
            let
                form =
                    model.form

                newForm =
                    { form | lastName = lastName }
            in
            { model | form = newForm }

        EmailInput email ->
            let
                form =
                    model.form

                newForm =
                    { form | email = email }
            in
            { model | form = newForm }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Person" ]
        , createPersonForm model
        , h3 [] [ text "Persons" ]
        , model.persons
            |> List.map
                (\person ->
                    div [] [ text <| person.firstName ++ " " ++ person.lastName ++ " " ++ person.email ]
                )
            |> div []
        ]


createPersonForm : Model -> Html Msg
createPersonForm model =
    div []
        [ input [ placeholder "First name", value model.form.firstName, onInput FirstNameInput ] []
        , input [ placeholder "Last name", value model.form.lastName, onInput LastNameInput ] []
        , input [ placeholder "Email", value model.form.email, onInput EmailInput ] []
        , button [ onClick CreatePerson ] [ text "Create" ]
        ]



---- UTILS ----


formatName : String -> String
formatName name =
    let
        start =
            String.toUpper <| String.left 1 name

        end =
            String.toLower <| String.dropLeft 1 name
    in
    start ++ end
