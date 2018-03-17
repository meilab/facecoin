module Main exposing (..)

import Views exposing (view)
import Messages exposing (Msg(..))
import Update exposing (..)
import Models exposing (..)
import Navigation
import Routing exposing (parseLocation)


-- port for listening for suggestions from JavaScript
-- port balance : (List String -> msg) -> Sub msg


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


ghProjectName : String
ghProjectName =
    "facecoin"


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        base_url =
            case
                location.pathname
                    |> String.split "/"
                    |> List.member ghProjectName
            of
                True ->
                    "/" ++ ghProjectName

                False ->
                    ""

        currentRoute =
            parseLocation location base_url

        url =
            { base_url = base_url }

        initModel =
            initialModel currentRoute url

        initCommand =
            changeUrlCommand initModel currentRoute
    in
        ( initModel, initCommand )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
