module ElmUIC.Selector exposing (Option, Selector, defaultSelector, dropdownItem, selector)

import Css exposing (Color, absolute, backgroundColor, block, border3, borderBox, borderRadius, boxShadow5, boxShadow6, boxSizing, color, cursor, display, displayFlex, ellipsis, flex, fontFamilies, fontSize, height, hex, hidden, hover, inherit, inset, int, lineHeight, maxHeight, noWrap, none, opacity, overflow, overflowY, padding, padding2, padding4, paddingRight, pct, pointer, position, px, relative, rgba, scroll, solid, textOverflow, top, transparent, visibility, visible, whiteSpace, width, zIndex, zero)
import Css.Transitions exposing (linear, transition)
import ElmUIC.Theme exposing (ColorSetting(..), Size(..), Theme)
import Html.Styled as Styled exposing (Attribute, Html, styled, text)
import Html.Styled.Attributes as Attributes exposing (css, placeholder, readonly, value)
import Html.Styled.Events exposing (onClick)


type alias Selector =
    { kind : ColorSetting
    , size : Size
    , placeholder : String
    , open : Bool
    , options : List Option
    , selected : Option
    }


type alias Option =
    { key : String
    , value : String
    }


defaultSelector : Selector
defaultSelector =
    { kind = Primary
    , size = Medium
    , placeholder = ""
    , open = False
    , options = []
    , selected =
        { key = ""
        , value = ""
        }
    }


panelWrapper : List (Attribute msg) -> List (Html msg) -> Html msg
panelWrapper =
    styled Styled.div
        [ paddingRight (px 8)
        , maxHeight inherit
        , overflowY scroll
        , height inherit
        , flex (int 1)
        ]


getColor : Theme -> Selector -> Css.Color
getColor theme model =
    case model.kind of
        Primary ->
            theme.primary

        Secondary ->
            theme.secondary

        Warning ->
            theme.warning

        Success ->
            theme.success

        Danger ->
            theme.danger


dropdownItem : Theme -> Selector -> Option -> List (Attribute msg) -> Html msg
dropdownItem theme model option attrs =
    let
        selectedStyles =
            if option.key == model.selected.key then
                [ backgroundColor (getColor theme model), color (hex "#FFF") ]

            else
                []

        item =
            styled Styled.div
                ([ textOverflow ellipsis
                 , whiteSpace noWrap
                 , overflow hidden
                 , borderRadius (px 2)
                 , padding4 (px 8) (px 30) (px 8) (px 10)
                 , whiteSpace noWrap
                 , overflow hidden
                 , position relative
                 , cursor pointer
                 , hover
                    [ backgroundColor (hex "#f0f0f0")
                    ]
                 ]
                    ++ selectedStyles
                )
    in
    item attrs [ text option.value ]


dropdownPanel : Theme -> List (Attribute msg) -> List (Html msg) -> Html msg
dropdownPanel theme =
    styled Styled.div
        [ position relative
        , maxHeight (px 250)
        , displayFlex
        , fontFamilies theme.font
        , border3 (px 1) solid (hex "#DDD")
        , backgroundColor (hex "#FDFDFD")
        , borderRadius (px 2)
        , color (hex "#707070")
        , zIndex (int 1000)
        , boxShadow5 zero (px 5) (px 20) zero (rgba 0 0 0 0.1)
        , width inherit
        , top (px 8)
        ]


input : Theme -> Selector -> List (Attribute msg) -> List (Html msg) -> Html msg
input theme model =
    let
        textColor =
            getColor theme model

        ( fs, h ) =
            case model.size of
                Small ->
                    ( px 12, px 26 )

                Medium ->
                    ( px 16, px 36 )

                Large ->
                    ( px 22, px 50 )
    in
    styled Styled.input
        [ color textColor
        , borderRadius (px 2)
        , padding2 (px 6) (px 9)
        , height h
        , fontSize fs
        , fontFamilies theme.font
        , zIndex (int 2)
        , transition
            [ Css.Transitions.boxShadow3 400 0 linear ]
        , boxShadow6 inset zero zero zero (px 1) transparent
        , boxSizing borderBox
        , border3 (px 1) solid (hex "#DDD")
        , lineHeight (px 16)
        , width inherit
        , cursor pointer
        ]


{-| A styled select element
-}
selector : Theme -> Selector -> (Option -> msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
selector theme model selectMsg attr inner =
    let
        panelVisibility =
            if model.open then
                [ display block
                , position absolute
                ]

            else
                [ display none
                ]
    in
    Styled.div
        attr
        [ input theme
            model
            [ placeholder model.placeholder, value model.selected.value, readonly True, onClick (selectMsg model.selected) ]
            []
        , dropdownPanel theme
            [ css panelVisibility ]
            [ panelWrapper []
                (List.map
                    (\option ->
                        dropdownItem theme
                            model
                            option
                            [ onClick (selectMsg option) ]
                    )
                    model.options
                )
            ]
        ]
