module ElmUIC.Input exposing (Input, defaultInput, input)

import Css exposing (Color, backgroundColor, border3, borderBox, borderRadius, boxShadow6, boxSizing, color, focus, fontFamilies, fontSize, height, hex, inset, lineHeight, none, outline, padding2, pct, px, solid, transparent, width, zero)
import Css.Transitions exposing (linear, transition)
import ElmUIC.Theme exposing (ColorSetting(..), Size(..), Theme)
import Html.Styled as Styled exposing (Attribute, Html, styled)


type alias Input =
    {}


defaultInput : Input
defaultInput =
    {}


{-| A styled input
-}
input : Theme -> Input -> List (Attribute msg) -> List (Html msg) -> Html msg
input theme model =
    styled Styled.input
        [ transition
            [ Css.Transitions.boxShadow3 400 0 linear
            ]
        , focus
            [ transition
                [ Css.Transitions.boxShadow3 200 0 linear
                ]
            , boxShadow6 inset zero zero zero (px 2) (hex "#00C0FF")
            , outline none
            ]
        , boxShadow6 inset zero zero zero (px 2) transparent
        , boxSizing borderBox
        , border3 (px 1) solid (hex "#DDD")
        , backgroundColor (hex "#FDFDFD")
        , borderRadius (px 2)
        , color (hex "#707070")
        , padding2 (px 6) (px 9)
        , lineHeight (px 16)
        , fontSize (px 16)
        , width (pct 100)
        , height (px 36)
        , fontFamilies theme.font
        ]
