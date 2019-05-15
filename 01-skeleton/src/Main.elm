module Main exposing (Model, Msg(..), formatName, init, main, update, view)

import Browser
import Html exposing (Html, button, div, form, h1, h3, img, input, label, p, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)



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
    Model [] (Person "" "" "")



---- UPDATE ----


type Msg
    = FirstNameInput String
    | LastNameInput String
    | EmailInput String
    | CreatePerson



-- | SetPersonActive Person
-- | SetPersonInactive Person
-- | ClearAll


update : Msg -> Model -> Model
update msg model =
    case msg of
        CreatePerson ->
            let
                oldActive =
                    model.persons

                newActive =
                    model.form :: oldActive
            in
            { model | persons = newActive, form = Person "" "" "" }

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



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Person Manager" ]
        , createPersonForm model -- Adds the form function
        , div [] [] -- Tip: Define a function to draw a view of people who are active.
        , div [] [] -- Tip: Define a function to draw a view of people who are inactive.
        , h3 [] [ text "Active users" ]

        {--
         Simple example of how we ca use simple anonymous functions to map values to views
         Also not the |> (backwards) and <| (forwards) operator. 
         These are useful for function applications and for avoidin parentheses.
         The below code could also possibly have been split into its own function (aad should)
         in the event that the complexity increases.
        --}
        , model.persons
            |> List.map (\x -> p [] [ text <| x.firstName ++ " " ++ x.lastName ++ " " ++ x.email ])
            |> div []

        -- Uncomment to check out the entire model state
        -- , showModel model
        ]


createPersonForm : Model -> Html Msg
createPersonForm model =
    div []
        [ input [ placeholder "First name", value model.form.firstName, onInput FirstNameInput ] []
        , input [ placeholder "Last name", value model.form.lastName, onInput LastNameInput ] []
        , input [ placeholder "Email", value model.form.email, onInput EmailInput ] []
        , button [ onClick CreatePerson ] [ text "Create" ]
        ]


showModel : Model -> Html Msg
showModel model =
    div []
        [ h3 [] [ text "Model" ]
        , text <| Debug.toString model
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



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
