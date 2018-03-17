module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = HomeRoute
    | CrowdfundingRoute
    | NotFoundRoute


parseBaseUrl : String -> Parser a a -> Parser a a
parseBaseUrl base_url item =
    case base_url of
        "" ->
            item

        _ ->
            base_url
                |> String.dropLeft 1
                |> String.split "/"
                |> List.map (s)
                |> List.reverse
                |> List.foldl (</>) (item)


matchers : String -> Parser (Route -> a) a
matchers base_url =
    oneOf
        [ map HomeRoute (parseBaseUrl base_url top)
        , map CrowdfundingRoute (parseBaseUrl base_url (s "crowdfunding"))
        ]


parseLocation : Location -> String -> Route
parseLocation location base_url =
    case (parsePath (matchers base_url) location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


urlFor : String -> Route -> String
urlFor base_url route =
    case route of
        HomeRoute ->
            base_url ++ "/"

        CrowdfundingRoute ->
            base_url ++ "/crowdfunding"

        NotFoundRoute ->
            base_url


routingItem : String -> List ( String, String, Route, String )
routingItem base_url =
    [ ( "Home", "", HomeRoute, base_url ++ "/" )
    , ( "Get FaceCoin", "", CrowdfundingRoute, base_url ++ "/crowdfunding" )
    ]


footerRoutingItem : List ( String, String, String )
footerRoutingItem =
    [ ( "Github", "fa fa-github fa-stack-1x fa-inverse", "https://github.com/meilab" )
    , ( "Weibo", "fa fa-weibo fa-stack-1x fa-inverse", "http://weibo.com/meilab" )
    , ( "Linkedin", "fa fa-linkedin fa-stack-1x fa-inverse", "https://linkedin.com/in/meilab" )
    ]
