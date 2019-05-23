module Main exposing (Model, Msg(..), Person, createPersonForm, formatName, getPersons, init, main, personDecoder, personEncoder, personsDecoder, postPerson, showModel, subscriptions, update, view)

import Browser
import Debug as Debug
import Html exposing (Html, button, div, form, h1, h3, img, input, label, p, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)
import Http as Http exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline
import Json.Encode as Encode



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



---- MODEL ----


type alias Model =
    { persons : List Person
    , form : Person
    , error : Maybe String
    }


type alias Person =
    { id : Int
    , firstName : String
    , lastName : String
    , email : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model [] (Person 0 "" "" "") Nothing, getPersons )



---- UPDATE ----


type Msg
    = NoOp
    | FirstNameInput String
    | LastNameInput String
    | EmailInput String
    | CreatePerson
    | GotPerson (Result Http.Error Person)
    | GotPersons (Result Http.Error (List Person))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GotPerson result ->
            Debug.todo "Implement to get a person."

        GotPersons result ->
            Debug.todo "Implement to get persons."

        CreatePerson ->
            ( model, postPerson model.form )

        FirstNameInput firstName ->
            let
                form =
                    model.form

                newForm =
                    { form | firstName = firstName }
            in
            ( { model | form = newForm }, Cmd.none )

        LastNameInput lastName ->
            let
                form =
                    model.form

                newForm =
                    { form | lastName = lastName }
            in
            ( { model | form = newForm }, Cmd.none )

        EmailInput email ->
            let
                form =
                    model.form

                newForm =
                    { form | email = email }
            in
            ( { model | form = newForm }, Cmd.none )



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

        -- map persons here
        , showError model

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


showError : Model -> Html Msg
showError model =
    case model.error of
        Nothing ->
            text ""

        Just error ->
            div []
                [ h3 [] [ text "Errors" ]
                , text <| Debug.toString error
                ]


showModel : Model -> Html Msg
showModel model =
    div []
        [ h3 [] [ text "Model" ]
        , text <| Debug.toString model
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



---- HTTP ----


getPersons : Cmd Msg
getPersons =
    Debug.todo "Implement request to get persons"


postPerson : Person -> Cmd Msg
postPerson person =
    Debug.todo "Implement reques to post a person"



---- DECODER / ENCODER ----


personsDecoder : Decode.Decoder (List Person)
personsDecoder =
    Debug.todo "Implement decoding of persons to a list."


personDecoder : Decode.Decoder Person
personDecoder =
    Debug.todo "Implement decoding of on person"


personEncoder : Person -> Encode.Value
personEncoder person =
    Debug.todo "unimplemented"
