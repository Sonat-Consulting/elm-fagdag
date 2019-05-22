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



---- UPDATE ----


type Msg
    = FirstNameInput String
    | LastNameInput String
    | EmailInput String
    | CreatePerson



{--Update this function to actually do something.
    Hint: {model | field = new status}. Remember to reset model.form with an empty person Person "" "" ""
--}


update : Msg -> Model -> Model
update msg model =
    case msg of
        CreatePerson ->
            { model | person = model.form }

        FirstNameInput firstName ->
            model

        LastNameInput lastName ->
            model

        EmailInput email ->
            model



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Person" ]
        , createPersonForm model
        , h3 [] [ text "Person in model" ]

        {--Try to render the person you created here. Uncomment `showmodel model` below to if the model
            is actually working as expected while experimenting with this.
            Hint: You can call on the model using model.person.firstName to get the firstname.            
        --}
        , showModel model
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
        [ text "Debug model:"
        , Debug.toString model
            |> text
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
