module ViewHelpers exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, href)
import Messages exposing (Msg(..))
import Routing exposing (Route, routingItem, urlFor)
import Html.Events exposing (onClick)
import Json.Decode as JD
import Models exposing (Model)
import Html.CssHelpers exposing (withNamespace)
import Styles.SharedStyles exposing (..)
import Date.Extra
import Date exposing (Date)


{ id, class, classList } =
    withNamespace "meilab"


navigationOnClick : Msg -> Attribute Msg
navigationOnClick msg =
    Html.Events.onWithOptions "click"
        { stopPropagation = False
        , preventDefault = True
        }
        (JD.succeed msg)


headerNav : Model -> Html Msg
headerNav model =
    div [ class [ HeaderNavWrapper ] ]
        [ navigation model (class [ HeaderNav ]) (class [ MenuList ]) ]


horizontalNav : Model -> Html Msg
horizontalNav model =
    navigation model (class [ MenuContainer ]) (class [ MenuList ])


verticalNav : Model -> Html Msg
verticalNav model =
    navigation model (class [ SideBarMenu ]) (class [ MenuListVertical ])


navigation : Model -> Attribute Msg -> Attribute Msg -> Html Msg
navigation model navClass menuClass =
    nav [ navClass ]
        [ ul [ menuClass ]
            (List.map (navItem model) (routingItem model.url.base_url))
        ]


navItem : Model -> ( String, String, Route, String ) -> Html Msg
navItem model ( title, iconClass, route, slug ) =
    let
        isCurrentLocation =
            model.route == route

        ( onClickCmd, selectedClass ) =
            case ( isCurrentLocation, route ) of
                ( False, route ) ->
                    ( route |> (urlFor model.url.base_url) |> NewUrl
                    , class []
                    )

                _ ->
                    ( NoOp
                    , class [ MenuSelected ]
                    )
    in
        linkItem selectedClass
            onClickCmd
            (class [])
            iconClass
            slug
            title


linkItem : Attribute Msg -> Msg -> Attribute Msg -> String -> String -> String -> Html Msg
linkItem liClass onClickCmd aClass iconClass slug textToShow =
    li
        [ class [ MenuItem ]
        , liClass
        ]
        [ a
            [ href slug
            , navigationOnClick (onClickCmd)
            , aClass
            ]
            [ i [ Html.Attributes.class iconClass ] []
            , text textToShow
            ]
        ]


normalLinkItem : String -> String -> String -> Html Msg
normalLinkItem base_url slug textToShow =
    linkItem (class [])
        (NewUrl (base_url ++ slug))
        (class [])
        ""
        slug
        textToShow


externalLink : String -> String -> Html Msg
externalLink url textToShow =
    a
        [ class [ MenuLink ]
        , href url
        ]
        [ text textToShow ]


footerLinkItem : ( String, String, String ) -> Html Msg
footerLinkItem ( _, iconClass, slug ) =
    li [ class [ MenuItem ] ]
        [ a
            [ href slug ]
            [ span [ Html.Attributes.class "fa-stack fa-lg" ]
                [ i [ Html.Attributes.class "fa fa-circle fa-stack-2x" ] []
                , i [ Html.Attributes.class iconClass ] []
                ]
            ]
        ]


formatDate : Date -> String
formatDate =
    Date.Extra.toFormattedString "MMMM ddd, y"
