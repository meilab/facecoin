module Styles.SharedStyles exposing (..)

import Html.CssHelpers exposing (withNamespace)


type CssClass
    = Layout
    | Container
    | ContentContainer
    | Body
    | Hero
    | SideBarWrapper
    | SideBarMenu
    | MenuContainer
    | MenuContainerVertical
    | MenuList
    | MenuListVertical
    | HeaderMenuList
    | MenuItem
    | MenuLink
    | MenuSelected
    | MenuActive
    | MenuInActive
    | MenuToggler
    | ImgResponsive
    | MarkdownWrapper
    | TrainingContainer
    | TrainingItem
    | AuthorContainer
    | AuthorItem
    | AuthorMeta
    | Spacing
    | TagContainer
    | TagItem
    | TagItemActive
    | TokenAmountInput
    | IconImg
      -- Header and Footer
    | Header
    | HeaderNavWrapper
    | HeaderNav
    | Footer
    | CopyRight
    | GithubIframe
    | Intro
    | TokenContent
    | TokenPurchase
    | TokenSaleCount
    | CurrentSale
    | SaleTitle
    | Digest
    | DigestContent
    | Value
    | Innovation
    | InnovationGroup
    | InnovationItem
    | Team
    | Roadmap
    | MainLogo
    | Message
    | CtaGroup
    | Cta
    | BuyTokenButton
    | PurchaseResult
    | Title
    | Content
    | Logo


meilabNamespace : Html.CssHelpers.Namespace String class id msg
meilabNamespace =
    withNamespace "meilab"
