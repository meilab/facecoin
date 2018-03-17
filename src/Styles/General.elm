module Styles.General exposing (..)

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
        [ html
            [ boxSizing borderBox ]
        , body
            [ fontSize (px 16)
            , fontFamily sansSerif
            , padding zero
            , margin zero
            , backgroundColor background
            ]
        , p
            [ lineHeight (Css.em 1.6) ]
        , each [ h1, h2 ]
            [ padding zero
            , margin zero
            ]
        , h3
            [ margin2 (px 15) zero
            ]
        , img
            [ maxWidth (pct 100)
            , height auto
            ]
        , nav
            [ descendants
                [ ul
                    [ listStyleType none
                    , margin zero
                    , padding zero
                    , displayFlex
                    , justifyContent spaceBetween
                    , alignItems center
                    , textAlign center
                    ]
                ]
            ]
        , class Layout
            [ displayFlex
            , flexDirection column
            , alignItems center
            ]
        , class Container
            [ displayFlex
            ]
        , class ContentContainer
            [ flex (int 1)
            , width (pct 100)
            , displayFlex
            , flexDirection column
            , alignItems center
            , padding (Css.em 1.5)
            ]
        , class Title
            [ color snow
            , fontSize (px 18)
            , margin (px 15)
            ]
        , class Content
            [ color (hex "ccc")
            , fontSize (px 16)
            ]
        , each
            [ class Hero
            , class Intro
            , class TokenContent
            , class Digest
            , class Value
            , class Innovation
            , class Team
            , class Roadmap
            , class InnovationItem
            ]
            [ color (rgba 0 0 0 0.9)
            , width (pct 100)

            --, backgroundColor (hex "#222")
            , backgroundRepeat noRepeat
            , backgroundSize cover
            , displayFlex
            , flexDirection column
            , justifyContent center
            , alignItems center
            , textAlign center
            , padding (px 30)
            ]
        , class InnovationGroup
            [ displayFlex
            , justifyContent spaceAround
            , width (pct 90)
            , alignItems flexStart
            ]
        , class InnovationItem
            [ margin (px 15)
            , descendants
                [ img
                    [ width (pct 80)
                    , marginBottom (px 15)
                    ]
                ]
            ]
        , class Hero
            [ backgroundAttachment fixed
            , height (vh 100)
            , color snow
            ]
        , class TokenContent
            [ backgroundColor black
            , color snow
            , displayFlex
            , flexDirection row
            ]
        , each [ class TokenPurchase, class TokenSaleCount ]
            [ displayFlex
            , flexDirection column
            , justifyContent spaceAround
            , alignItems center
            ]
        , class TokenPurchase
            [ flex (int 1) ]
        , class TokenSaleCount
            [ flex (int 2)
            , height (pct 90)
            , displayFlex
            , flexDirection column
            , justifyContent spaceAround
            , alignItems center
            ]
        , class CurrentSale
            []
        , class Digest
            [ backgroundImage (url "../images/digest-bg.png")
            , flexDirection row
            , flexWrap wrap
            , justifyContent spaceAround
            ]
        , class DigestContent
            [ flex (pct 40)
            , height (px 200)
            , maxWidth (px 300)
            , margin (px 20)
            , padding (px 15)
            , borderRadius (px 2)
            , backgroundColor (rgba 255 255 255 0.6)
            , displayFlex
            , flexDirection column
            , justifyContent spaceAround
            , alignItems center
            , cursor pointer
            ]
        , class Innovation
            [ backgroundImage (url "../images/tech-bg.png") ]
        , class Roadmap
            [ backgroundImage (url "../images/road-bg.png") ]
        , each [ class MenuContainer, class MenuContainerVertical ]
            [ displayFlex
            , justifyContent spaceBetween
            , alignItems center
            ]
        , class MenuContainerVertical
            [ flexDirection column ]
        , class SideBarWrapper
            [ flex3 (int 0) (int 0) menuWidth
            , withClass MenuInActive
                [ display none ]
            ]
        , class SideBarMenu
            [ position fixed
            , width menuWidth
            , height (vh 100)
            , displayFlex
            , flexDirection column
            , justifyContent flexStart
            , backgroundColor ember
            ]
        , each [ class MenuList, class MenuListVertical, class HeaderMenuList ]
            [ width (pct 100)
            , displayFlex
            , justifyContent spaceAround
            , listStyle none
            , padding zero
            , margin zero
            , descendants
                [ a
                    [ textDecoration none
                    , textAlign center
                    , display block
                    , padding (px 10)
                    , color black
                    ]
                ]
            ]
        , class MenuListVertical
            [ flexDirection column ]
        , class HeaderMenuList
            [ display block
            ]
        , class MenuItem
            [ paddingLeft (Css.rem 0.2)

            -- , border3 (px 1) solid silver
            ]
        , class HeaderNavWrapper
            [ position absolute
            , width (pct 100)
            , padding2 zero (px 10)
            , top (px 10)
            ]
        , class HeaderNav
            [ displayFlex
            , justifyContent center
            , color white
            , textTransform uppercase
            , descendants
                [ a
                    [ color snow
                    , hover
                        [ color yellow
                        ]
                    , active
                        [ color yellow ]
                    ]
                ]
            ]
        , class TokenAmountInput
            [ fontSize (Css.em 1)
            , color snow
            , backgroundColor Css.transparent
            , borderBottom3 (px 1) solid (hex "#00dcdc")
            , borderTopColor Css.transparent
            , borderLeftColor Css.transparent
            , borderRightColor Css.transparent
            , outline none
            ]
        , class IconImg
            [ width (Css.rem 3)
            , height auto
            ]
        , class Spacing
            [ padding2 (px 50) zero ]
        , class CtaGroup
            [ displayFlex
            , justifyContent center
            , alignItems center
            , marginTop (px 30)
            , padding (px 20)
            ]
        , each [ class Cta, class BuyTokenButton ]
            [ border3 (px 1) solid silver
            , borderRadius (px 24)
            , height (px 48)
            , lineHeight (px 47)
            , width (px 200)
            , color snow
            , textTransform uppercase
            , textAlign center
            , fontSize (px 16)
            , fontWeight (int 600)
            , cursor pointer
            , margin (px 15)
            , textDecoration none
            , hover
                [ backgroundColor (hex "#F88A2F") ]
            ]
        , class BuyTokenButton
            [ flex (int 1) ]
        , class PurchaseResult
            [ flex (int 1)
            , displayFlex
            , justifyContent center
            , alignItems center
            ]
        , class Logo
            [ maxWidth (px 200)
            , height auto
            , textAlign middle
            ]
        , mediaQuery "screen and (min-width : 48em)"
            [ class Hero
                [ height (vh 60)
                , minHeight (px 240)
                , padding2 (pct 15) zero
                ]
            , class HeaderNav
                [ justifyContent flexStart ]
            , class MenuList
                [ justifyContent flexStart ]
            , class ContentContainer
                [ padding2 zero (pct 12) ]
            ]
        ]
