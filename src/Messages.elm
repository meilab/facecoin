module Messages exposing (..)

import Navigation exposing (Location)


type Msg
    = OnLocationChange Location
    | NewUrl String
    | TokenAmountChange String
    | BuyToken
    | NoOp
