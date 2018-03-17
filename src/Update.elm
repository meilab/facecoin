port module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Routing exposing (Route(..), parseLocation)
import Navigation exposing (Location)


-- port for sending strings out to JavaScript


port buyToken : Int -> Cmd msg


changeUrlCommand : Model -> Route -> Cmd Msg
changeUrlCommand model route =
    case route of
        _ ->
            Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location model.url.base_url
            in
                ( { model | route = newRoute }
                , changeUrlCommand
                    model
                    newRoute
                )

        NewUrl url ->
            model
                ! [ Navigation.newUrl url
                  ]

        TokenAmountChange amount ->
            ( { model | amount = amount }, Cmd.none )

        BuyToken ->
            case String.toInt model.amount of
                Ok amount ->
                    ( model, buyToken amount )

                Err error ->
                    ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )
