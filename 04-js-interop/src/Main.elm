port module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (Html, button, div, form, h1, h3, img, input, label, p, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onClick, onInput)



---- PORT ----


port cache : String -> Cmd msg


port clearCache : String -> Cmd msg


port dataEvent : (String -> msg) -> Sub msg



---- PROGRAM ----


main : Program Model Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



---- MODEL ----


type alias Model =
    { message : String
    , cache : Maybe String
    , cacheState : Maybe String
    }


init : Model -> ( Model, Cmd Msg )
init model =
    ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ dataEvent CacheEvent ]



---- UPDATE ----


type Msg
    = NoOp
    | UpdateCache
    | ClearCache
    | CacheEvent String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateCache ->
            ( { model | cache = Just "Updated" }, cache "Updated" )

        ClearCache ->
            ( { model | cache = Nothing }, clearCache "Deleted cache" )

        CacheEvent state ->
            ( { model | cacheState = Just state }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Interop" ]
        , div [] [ text <| "Message from JavaScript: " ++ model.message ]
        , viewCache model
        , showModel model
        ]


viewCache : Model -> Html Msg
viewCache model =
    case model.cache of
        Just c ->
            div []
                [ text c
                , button [ onClick ClearCache ] [ text "Clear cache" ]
                ]

        Nothing ->
            div []
                [ text "No cache yet"
                , button [ onClick UpdateCache ] [ text "Update cache" ]
                ]


viewCacheEvent : Model -> Html Msg
viewCacheEvent model =
    case model.cacheState of
        Just cacheStatus ->
            div []
                [ text <| "Got event => " ++ cacheStatus
                ]

        Nothing ->
            div []
                [ text "Waiting for event..."
                ]


showModel : Model -> Html Msg
showModel model =
    div []
        [ h3 [] [ text "Model" ]
        , text <| Debug.toString model
        ]
