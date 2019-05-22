module Main exposing (Model, Msg(..), Person, createPersonForm, formatName, init, main, showModel, subscriptions, update, view)

import Browser
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
            case result of
                Ok newPerson ->
                    let
                        persons =
                            model.persons

                        newPerons =
                            List.sortBy .id <| newPerson :: persons
                    in
                    ( { model | persons = newPerons }, Cmd.none )

                Err err ->
                    ( { model | error = Just <| Debug.toString err }, Cmd.none )

        GotPersons result ->
            case result of
                Ok newPersons ->
                    ( { model | persons = newPersons }, Cmd.none )

                Err err ->
                    ( { model | error = Just <| Debug.toString err }, Cmd.none )

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
        , createPersonForm model -- Adds the form function
        , div [] [] -- Tip: Define a function to draw a view of people who are active.
        , div [] [] -- Tip: Define a function to draw a view of people who are inactive.
        , h3 [] [ text "Persons" ]
        , model.persons
            |> List.map (\person -> p [] [ text <| "(" ++ String.fromInt person.id ++ ")" ++ person.firstName ++ " " ++ person.lastName ++ " " ++ person.email ])
            |> div []
        , h3 [] [ text "Errors" ]

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
    Http.get
        { url = "http://localhost:8080/peoples"
        , expect = Http.expectJson GotPersons personsDecoder
        }


postPerson : Person -> Cmd Msg
postPerson person =
    Http.post
        { url = "http://localhost:8080/peoples"
        , body = Http.jsonBody <| personEncoder person
        , expect = Http.expectJson GotPerson personDecoder
        }



---- DECODER / ENCODER ----


personsDecoder : Decode.Decoder (List Person)
personsDecoder =
    Decode.list personDecoder


personDecoder : Decode.Decoder Person
personDecoder =
    Decode.succeed Person
        |> Pipeline.required "id" Decode.int
        |> Pipeline.required "firstName" Decode.string
        |> Pipeline.required "lastName" Decode.string
        |> Pipeline.required "email" Decode.string


personEncoder : Person -> Encode.Value
personEncoder person =
    Encode.object
        [ ( "firstName", Encode.string <| person.firstName )
        , ( "lastName", Encode.string <| person.lastName )
        , ( "email", Encode.string <| person.email )
        ]
