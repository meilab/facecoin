module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, href, seamless, width, height, placeholder)
import Html.Events exposing (onInput, onClick)
import Css exposing (backgroundImage, url)
import Messages exposing (Msg(..))
import Models exposing (..)
import ViewHelpers exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Styles.SharedStyles exposing (..)
import Routing exposing (footerRoutingItem, Route(..))


styles =
    Css.asPairs >> Html.Attributes.style


{ id, class, classList } =
    withNamespace "meilab"


view : Model -> Html Msg
view model =
    let
        contentView =
            case model.route of
                HomeRoute ->
                    homeView model

                CrowdfundingRoute ->
                    crowdfundingView model

                NotFoundRoute ->
                    notFoundView
    in
        div [ class [ Layout ] ]
            [ --headerNav model
              contentView
            , renderFooter
            ]


homeView : Model -> Html Msg
homeView model =
    div [ class [ ContentContainer ] ]
        [ homeHero
            --"images/home.jpg"
            "images/crowdfunding.jpg"
            (class [ Hero ])
        , intro
        , tokenContent
        , digest
        , value
        , innovation
        , team
        , roadmap
        ]


homeHero : String -> Attribute Msg -> Html Msg
homeHero srcUrl heroClass =
    div
        [ heroClass
        , styles
            [ backgroundImage (url srcUrl)
            ]
        ]
        [ img
            [ src "images/logo12.png"
            , class [ IconImg ]
            ]
            []
        , h1 [ class [ MainLogo ] ] [ text "Frashleek" ]
        , h2 [ class [ Message ] ] [ text "Future is coming" ]
        , div [ class [ CtaGroup ] ]
            [ a
                [ href "content/whitepaper.md"
                , class [ Cta ]
                ]
                [ text "White Paper" ]
            , a
                [ href "content/whitepaper.md"
                , class [ Cta ]
                ]
                [ text "GITHUB" ]
            ]
        ]


intro : Html Msg
intro =
    div [ class [ Intro ] ]
        [ h2 [] [ text "简介" ]
        , p []
            [ text "Freshleek是一个人脸建模系统" ]
        ]


tokenContent : Html Msg
tokenContent =
    div [ class [ TokenContent ] ]
        [ div [ class [ TokenPurchase ] ]
            [ img
                [ src "images/spinning_logo.gif"
                , class [ Logo ]
                ]
                []
            , div []
                [ label [] [ text "Claim your share: " ]
                , input
                    [ placeholder "Input amount"
                    , class [ TokenAmountInput ]
                    , onInput TokenAmountChange
                    ]
                    []
                ]
            , div [ class [ Container ] ]
                [ h1
                    [ onClick BuyToken
                    , class [ BuyTokenButton ]
                    ]
                    [ text "Get Token" ]
                , div [ class [ PurchaseResult ] ]
                    [ span [] [ text "You got: " ]
                    , span [] [ text "0" ]
                    , span [] [ text " FC" ]
                    ]
                ]
            ]
        , div [ class [ TokenSaleCount ] ]
            [ div [] [ text "Facecoin Distribution" ]
            , div []
                [ div [] [ text "Current Distribution" ]
                , div [] [ text "Ditribution Ends in" ]
                ]
            ]
        ]


digest : Html Msg
digest =
    div [ class [ Digest ] ]
        [ div [ class [ DigestContent ] ]
            [ h2 [] [ text "-解决的问题-" ]
            , img [ src "images/icon-que.png" ] []
            ]
        , div [ class [ DigestContent ] ]
            [ h2 [] [ text "-现状与未来-" ]
            , img [ src "images/icon-time.png" ] []
            ]
        , div [ class [ DigestContent ] ]
            [ h2 [] [ text "-意义-" ]
            , img [ src "images/icon-mean.png" ] []
            ]
        , div [ class [ DigestContent ] ]
            [ h2 [] [ text "-优势-" ]
            , img [ src "images/icon-light.png" ] []
            ]
        ]


value : Html Msg
value =
    div [ class [ Value ] ]
        []


innovation : Html Msg
innovation =
    div [ class [ Innovation ] ]
        [ div [] [ text "技术创新" ]
        , div
            [ class [ InnovationGroup ] ]
            [ div [ class [ InnovationItem ] ]
                [ img [ src "images/tech-1.png" ] []
                , div [ class [ Title ] ] [ text "人脸建模" ]
                , div [ class [ Content ] ] [ text "自主研发的业界领先人脸建模算法，高效准确的为各大洲人种构建人脸模型" ]
                ]
            , div [ class [ InnovationItem ] ]
                [ img [ src "images/tech-2.png" ] []
                , div [ class [ Title ] ] [ text "Ethereum公链" ]
                , div [ class [ Content ] ] [ text "无缝对接现有区块链生态体系，接入全球百万开发者" ]
                ]
            , div [ class [ InnovationItem ] ]
                [ img [ src "images/tech-3.png" ] []
                , div [ class [ Title ] ] [ text "POF机制" ]
                , div [ class [ Content ] ] [ text "自主研发的证明机制，名为轮廓量证明机制，解决了评定用户输入的脸模质量高低的问题，使得社区内所有用户都可以受益" ]
                ]
            , div [ class [ InnovationItem ] ]
                [ img [ src "images/tech-4.png" ] []
                , div [ class [ Title ] ] [ text "归属权记录" ]
                , div [ class [ Content ] ] [ text "结合密码学算法，确保人脸建模数据生产者的唯一性和真实性" ]
                ]
            ]
        ]


team : Html Msg
team =
    div [ class [ Team ] ]
        [ h2 [ class [ Title ] ] [ text "团队成员" ]
        , h1 [] [ text "待公布" ]
        ]


roadmap : Html Msg
roadmap =
    div [ class [ Roadmap ] ]
        [ h2 [ class [ Title ] ] [ text "发展路线" ]
        , h1 [] [ text "即将上线，敬请期待" ]
        ]


crowdfundingView : Model -> Html Msg
crowdfundingView model =
    div [ class [ ContentContainer ] ]
        [ crowdfundingHero
            "images/crowdfunding.jpg"
            (class [ Hero ])
        , h1 [] [ text "Buy now" ]
        ]


crowdfundingHero : String -> Attribute Msg -> Html Msg
crowdfundingHero srcUrl heroClass =
    div
        [ heroClass
        , styles
            [ backgroundImage (url srcUrl)
            ]
        ]
        [ img
            [ src "images/elm.png"
            , class [ IconImg ]
            ]
            []
        , input
            [ placeholder "Input amount"
            , class [ TokenAmountInput ]
            , onInput TokenAmountChange
            ]
            []
        , h1 [ onClick BuyToken ] [ text "Buy Token" ]
        ]


renderFooter : Html Msg
renderFooter =
    footer [ class [ Footer ] ]
        [ ul [ class [ MenuList ] ]
            (footerRoutingItem
                |> List.map footerLinkItem
            )
        , p [ class [ CopyRight ] ]
            [ text "All code for this site is open source and written in Elm. "
            , text "! — © 2017 Meilab"
            , iframe
                [ class [ GithubIframe ]
                , width 100
                , height 20
                , src "https://ghbtns.com/github-btn.html?user=meilab&repo=facecoin&type=star&count=true"
                ]
                []
            ]
        ]


notFoundView : Html Msg
notFoundView =
    div []
        [ text "No Page Found" ]
