module Models exposing (..)

import Routing exposing (Route)


type alias Url =
    { base_url : String }


type alias Ui =
    { sideMenuActive : Bool }


type alias Model =
    { route : Route
    , url : Url
    , amount : String
    }


initialModel : Route -> Url -> Model
initialModel route url =
    { route = route
    , url = url
    , amount = ""
    }
