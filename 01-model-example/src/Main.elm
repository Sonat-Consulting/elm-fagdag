module Main exposing (Model, Msg(..), formatName, init, main, update, view)

import Browser
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
    { person : Person
    , form : Person
    }


type alias Person =
    { firstName : String
    , lastName : String
    , email : String
    }


init : Model
init =
    Model (Person "" "" "") (Person "" "" "")


emptyPerson : Person
emptyPerson =
    Person "" "" ""



---- UPDATE ----


type Msg
    = FirstNameInput String
    | LastNameInput String
    | EmailInput String
    | CreatePerson


update : Msg -> Model -> Model
update msg model =
    case msg of
        CreatePerson ->
            { model | person = model.form, form = emptyPerson }

        FirstNameInput firstName ->
            let
                form =
                    model.form

                newForm =
                    { form | firstName = formatName firstName }
            in
            { model | form = newForm }

        LastNameInput lastName ->
            let
                form =
                    model.form

                newForm =
                    { form | lastName = formatName lastName }
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



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Person" ]
        , createPersonForm model
        , h3 [] [ text "Person in model" ]
        , model.person
            |> (\x -> p [] [ text <| x.firstName ++ " " ++ x.lastName ++ " " ++ x.email ])
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
