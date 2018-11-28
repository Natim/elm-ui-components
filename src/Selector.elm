module Selector exposing (Option, Selector, defaultSelector, dropdownItem, selector)

import Css exposing (Color, backgroundColor, border3, borderBox, borderRadius, boxShadow5, boxShadow6, boxSizing, color, cursor, displayFlex, ellipsis, flex, fontFamilies, fontSize, height, hex, hidden, hover, inherit, inset, int, lineHeight, maxHeight, noWrap, opacity, overflow, overflowY, padding, padding2, padding4, paddingRight, pct, pointer, position, px, relative, rgba, scroll, solid, textOverflow, top, transparent, visibility, visible, whiteSpace, width, zIndex, zero)
import Css.Transitions exposing (linear, transition)
import Html.Styled as Styled exposing (Attribute, Html, styled, text)
import Html.Styled.Attributes as Attributes exposing (css, placeholder, readonly, value)
import Html.Styled.Events exposing (onClick)
import Theme exposing (ColorSetting(..), Size(..), Theme)


type Msg
    = NoOp


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


dropdownItem : Option -> Option -> List (Attribute msg) -> Html msg
dropdownItem option selected attrs =
    let
        item =
            styled Styled.div
                [ textOverflow ellipsis
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
        ]


{-| A styled select element
-}
selector : Theme -> Selector -> (Option -> msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
selector theme model selectMsg attr inner =
    let
        panelVisibility =
            if model.open then
                [ visibility visible
                , opacity (int 1)
                ]

            else
                [ visibility hidden
                , opacity zero
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
                        dropdownItem option
                            model.selected
                            [ onClick (selectMsg option) ]
                    )
                    model.options
                )
            ]
        ]
