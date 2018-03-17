module Styles.HeaderFooter exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Colors exposing (..)
import Css.Namespace exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Styles.SharedStyles exposing (..)
import Styles.Colors exposing (..)
import Styles.SharedVariables exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace meilabNamespace.name)
        [ each [ class Footer, class Header ]
            [ backgroundColor background
            , color snow
            ]
        , class Header
            [ backgroundColor snow
            , flex3 (int 0) (int 0) (px 64)
            , displayFlex
            , justifyContent spaceBetween
            , alignItems center
            , overflow hidden
            , padding2 (px 10) zero
            ]
        , class Footer
            [ backgroundColor (hex "#134374")
            , backgroundColor snow
            , color gray
            , padding2 (Css.em 3) (pct 10)
            , textAlign center
            , flex3 (int 0) (int 0) (px 120)
            , displayFlex
            , flexDirection column
            , justifyContent spaceAround
            , alignItems center
            ]
        , class CopyRight
            [ flex (int 1)
            , displayFlex
            , flexDirection column
            , justifyContent center
            , alignItems center
            , textAlign center
            ]
        , class GithubIframe
            [ border zero ]
        ]
